defmodule Beatwc do
	@moduledoc ~S"""
  Play around with various methods of counting number of lines in a file
  and see if native elixir can match wc -l. 
  """

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

  def slurp(path) do
    bin = File.read!(path)
    search = :binary.compile_pattern(<<"\n">>)
    new_bin = :binary.replace(bin,search,<<"">>,[:global])
    :erlang.byte_size(bin) - :erlang.byte_size(new_bin)
  end 
  
end
