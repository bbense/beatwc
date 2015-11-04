defmodule BenchBeatwc do
  use Benchfella

  @data_files ["100","1000","10000","100000","1000000"]
  
  for chunk <- @data_files do 
   	@chunk chunk 
    bench "wc_l file with #{@chunk} lines" do
      Beatwc.wc_l("./bench/data/#{@chunk}") 
    end
  end 

  for chunk <- @data_files do 
    @chunk chunk 
    bench "naive file with #{@chunk} lines" do
      Beatwc.naive("./bench/data/#{@chunk}") 
    end
  end 

  for chunk <- @data_files do 
    @chunk chunk 
    bench "slurp file with #{@chunk} lines" do
      Beatwc.slurp("./bench/data/#{@chunk}") 
    end
  end 

 for chunk <- @data_files do 
    @chunk chunk 
    bench "allnifs file with #{@chunk} lines" do
      Beatwc.allnifs("./bench/data/#{@chunk}") 
    end
  end 

end