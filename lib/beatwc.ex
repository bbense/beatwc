defmodule Beatwc do
	@moduledoc ~S"""
  Play around with various methods of counting number of lines in a file
  and see if native elixir can match wc -l.
  """

  # Best guess so far.
  @too_big 300000
  @pchunk_size 131072
  @chunk_size 32768

  def wc_l(path) do
    {result, 0} = System.cmd("wc",["-l", path])
    result
    |> String.split
    |> List.first
    |> String.to_integer
  end

  def naive(path) do
    path |> File.stream! |> Enum.count
  end

  # The :binary functions split and replace are not nifs.
  def slurp(path) do
    bin = File.read!(path)
    search = :binary.compile_pattern(<<"\n">>)
    new_bin = :binary.replace(bin,search,<<"">>,[:global])
    :erlang.byte_size(bin) - :erlang.byte_size(new_bin)
  end

  # using the count function slows it down by 3 mu secs.
  def allnifs(path) do
    binary = File.read!(path)
    search = :binary.compile_pattern(<<"\n">>)
    :erlang.length(:binary.matches(binary, search))
  end

  def chunkynifs(path, chunksize \\ @chunk_size) do
    File.stream!(path, [], chunksize)
    |> Enum.reduce(0, fn(chunk, total) -> total + count(chunk) end)
  end

  def parallel(path, chunksize \\ @pchunk_size) do
    File.stream!(path,[], chunksize)
    |> EnumP.scatter(fn(chunk) -> count(chunk) end) |> EnumP.gather(0, fn(acc, result) -> result + acc end)
  end

  defp count(binary) do
    search = :binary.compile_pattern(<<"\n">>)
    :erlang.length(:binary.matches(binary, search))
  end

end
