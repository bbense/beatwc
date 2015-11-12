defmodule BenchChunk do
  use Benchfella

  @chunksize [8192, 16384, 32768, 65536, 131072, 262144, 524288, 1048576]


  for chunk <- @chunksize do
    @chunk chunk
    bench "chunkynifs 10**5 file with #{Integer.to_string(@chunk)} chunk size" do
      Beatwc.chunkynifs("./bench/data/100000", @chunk)
    end
  end

 for chunk <- @chunksize do
    @chunk chunk
    bench "chunkynifs 10**6 file with #{Integer.to_string(@chunk)} chunk size" do
      Beatwc.chunkynifs("./bench/data/1000000", @chunk)
    end
  end

end