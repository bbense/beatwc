defmodule BenchBeatwc do
  use Benchfella

  @data_files ["100","1000","10000","100000","1000000"]

  setup_all do
    Beatwc.init()
  end

  for chunk <- @data_files do
   	@chunk chunk
    bench "#{@chunk} lines, whole file, `wc -l`" do
      Beatwc.wc_l("./bench/data/#{@chunk}", bench_context)
    end

    bench "#{@chunk} lines, line-delimited IO, serial" do
      Beatwc.naive("./bench/data/#{@chunk}", bench_context)
    end

    bench "#{@chunk} lines, line-delimited IO, Flow, partitioned" do
       Beatwc.naive_flow("./bench/data/#{@chunk}", bench_context)
    end

    bench "#{@chunk} lines, line-delimited IO, Flow, single-stage" do
       Beatwc.minimized_naive_flow("./bench/data/#{@chunk}", bench_context)
    end

    bench "#{@chunk} lines, whole file, :binary.replace/4" do
      Beatwc.slurp("./bench/data/#{@chunk}", bench_context)
    end

    bench "#{@chunk} lines, whole file, :binary.matches/2" do
      Beatwc.allnifs("./bench/data/#{@chunk}", bench_context)
    end

    bench "#{@chunk} lines, whole file, line-delimited StringIO, serial" do
      Beatwc.naive_stringio("./bench/data/#{@chunk}", bench_context)
    end

    bench "#{@chunk} lines, chunked IO, serial, :binary.matches/2" do
      Beatwc.chunkynifs("./bench/data/#{@chunk}", bench_context)
    end

    bench "#{@chunk} lines, whole file, chunked StringIO, :binary.matches/2" do
      Beatwc.chunkynifs_on_stringio("./bench/data/#{@chunk}", bench_context)
    end

    bench "#{@chunk} lines, chunked IO, async-await, :binary.matches/2" do
       Beatwc.async_await("./bench/data/#{@chunk}", bench_context)
    end

    bench "#{@chunk} lines, chunked IO, scatter+gather, :binary.matches/2" do
       Beatwc.scatter_gather("./bench/data/#{@chunk}", bench_context)
    end

    bench "#{@chunk} lines, chunked IO, Task.async_stream, :binary.matches/2" do
       Beatwc.async_stream("./bench/data/#{@chunk}", bench_context)
    end

    bench "#{@chunk} lines, chunked IO, Flow, partitioned, :binary.matches/2" do
       Beatwc.chunky_flow("./bench/data/#{@chunk}", bench_context)
    end

    bench "#{@chunk} lines, chunked IO, Flow, single-stage, :binary.matches/2" do
       Beatwc.minimized_chunky_flow("./bench/data/#{@chunk}", bench_context)
    end
  end
end
