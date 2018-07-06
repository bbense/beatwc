defmodule Beatwc do
	@moduledoc ~S"""
  Play around with various methods of counting number of lines in a file
  and see if native elixir can match wc -l.
  """

  # Best guess so far.
  @too_big 300000
  @pchunk_size 131072
  @chunk_size 32768

  def init do
    {:ok, :binary.compile_pattern(<<"\n">>)}
  end


  def wc_l(path, _context \\ nil) do
    {result, 0} = System.cmd("wc",["-l", path])

    result
    |> String.split()
    |> List.first()
    |> String.to_integer()
  end

  def naive(path, _context \\ nil) do
    File.stream!(path)
    |> Enum.count()
  end

  def naive_stringio(path, _context \\ nil) do
    {:ok, stringio_pid} = StringIO.open(File.read!(path))

    IO.binstream(stringio_pid, :line)
    |> Enum.count
  end

  def naive_flow(path, _context \\ nil) do
    File.stream!(path)
    |> Flow.from_enumerable()
    |> Flow.map(fn _ln -> 1 end)
    |> Flow.partition()
    |> Flow.reduce(fn -> [0] end, fn num, [acc] -> [num + acc] end)
    |> Enum.sum()
  end

  def minimized_naive_flow(path, _context \\ nil) do
    File.stream!(path)
    |> Flow.from_enumerable()
    |> Flow.map(fn _ln -> 1 end)
    |> Flow.reduce(fn -> [0] end, fn num, [acc] -> [num + acc] end)
    |> Enum.sum()
  end

  def chunky_flow(path, search_pat, chunksize \\ @pchunk_size) do
    File.stream!(path, [], chunksize)
    |> Flow.from_enumerable()
    |> Flow.map(&count(&1, search_pat))
    |> Flow.partition()
    |> Flow.reduce(fn -> [0] end, fn num, [acc] -> [num + acc] end)
    |> Enum.sum()
  end

  def minimized_chunky_flow(path, search_pat, chunksize \\ @pchunk_size) do
    File.stream!(path, [], chunksize)
    |> Flow.from_enumerable()
    |> Flow.map(&count(&1, search_pat))
    |> Flow.reduce(fn -> [0] end, fn num, [acc] -> [num + acc] end)
    |> Enum.sum()
  end

  # The :binary functions split and replace are not nifs.
  def slurp(path, search_pat) do
    bin = File.read!(path)
    new_bin = :binary.replace(bin, search_pat, <<"">>, [:global])
    :erlang.byte_size(bin) - :erlang.byte_size(new_bin)
  end

  # using the count function slows it down by 3 mu secs.
  def allnifs(path, search_pat) do
    binary = File.read!(path)
    :erlang.length(:binary.matches(binary, search_pat))
  end

  def chunkynifs(path, search_pat, chunksize \\ @chunk_size) do
    File.stream!(path, [], chunksize)
    |> Enum.reduce(0, fn(chunk, total) -> total + count(chunk, search_pat) end)
  end

  def chunkynifs_on_stringio(path, search_pat, chunksize \\ @pchunk_size) do
    {:ok, stringio_pid} = StringIO.open(File.read!(path))

    IO.binstream(stringio_pid, chunksize)
    |> Enum.reduce(0, fn(chunk, total) -> total + count(chunk, search_pat) end)
  end

  def scatter_gather(path, search_pat, chunksize \\ @pchunk_size) do
    File.stream!(path,[], chunksize)
    |> EnumP.scatter(fn(chunk) -> count(chunk, search_pat) end)
    |> EnumP.gather(0, fn(acc, result) -> result + acc end)
  end

  def async_await(path, search_pat, chunksize \\ @pchunk_size) do
    File.stream!(path, [], chunksize)
    |> Enum.map(fn chunk ->
      Task.async(fn -> count(chunk, search_pat) end)
    end)
    |> Enum.reduce(0, fn task, acc ->
      acc + Task.await(task)
    end)
  end

  def async_stream(path, search_pat, chunksize \\ @pchunk_size) do
    File.stream!(path, [], chunksize)
    |> Task.async_stream(&count(&1, search_pat))
    |> Enum.reduce(0, fn {:ok, num}, acc -> num + acc end)
  end

  defp count(binary, search_pat) do
    :erlang.length(:binary.matches(binary, search_pat))
  end

  @compile {:inline, [count: 2]}
end
