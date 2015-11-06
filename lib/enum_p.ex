defmodule EnumP do
	@moduledoc """
	Apply the vector machine notices of Scatter/Gather to running
	a function on each value of an enumerable. 
	"""

	@doc """
	Start a process that calls function(item) for each value in an Enumerable. 

	"""
	def scatter(enum, function) do
		enum
		|> Enum.map(fn(item)->Task.async(fn ->function.(item) end) end)
	end

  @doc """
  Gather all the results of a scatter into a single value using the initial_value
  and accumilator function. 

  """
  def gather([],initial_value, _acc_function) do
    initial_value
  end

	def gather(pid_list, initial_value, acc_function) do
		{results, still_running } = Enum.reduce(pid_list, {[],[]}, fn(pid, acc) -> parse_yield(pid, acc) end )
    new_value = Enum.reduce(results, initial_value, fn(result, acc) -> acc_function.(result, acc) end)
    gather(still_running,new_value, acc_function)
  end

	defp parse_yield(pid,{results, still_running}) do
		case Task.yield(pid) do
			{:ok, result} -> {results ++ [result], still_running }
			nil -> {results, still_running ++ [pid]}
    end 
	end
end