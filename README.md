# Beatwc

**Playing around to see if we can ever beat System.cmd("wc",["-l", path]) with native Elixir**

Results so far: 


## BenchBeatwc

    allnifs file with 100 lines              50_000   42.55 µs/op
    slurp file with 100 lines                50_000   51.41 µs/op
    chunkynifs file with 100 lines           50_000   68.27 µs/op
    parallel file with 100 lines             50_000   69.11 µs/op
    naive file with 100 lines                10_000   176.79 µs/op
    allnifs file with 1000 lines             10_000   203.88 µs/op
    chunkynifs file with 1000 lines          10_000   216.20 µs/op
    parallel file with 1000 lines            10_000   221.56 µs/op
    slurp file with 1000 lines                 5000   354.49 µs/op
    naive file with 1000 lines                 1000   1207.86 µs/op
    allnifs file with 10_000 lines             1000   2381.74 µs/op
    chunkynifs file with 10_000 lines          1000   2418.45 µs/op
    parallel file with 10_000 lines            1000   2424.78 µs/op
    wc_l file with 100 lines                   1000   2749.69 µs/op
    wc_l file with 1000 lines                  1000   2768.28 µs/op
    wc_l file with 10_000 lines                 500   3186.56 µs/op
    slurp file with 10_000 lines                500   4138.48 µs/op
    wc_l file with 100_000 lines                500   6202.25 µs/op
    parallel file with 100_000 lines            500   6315.90 µs/op
    naive file with 10_000 lines                100   11135.70 µs/op
    chunkynifs file with 100_000 lines           50   30265.96 µs/op
    wc_l file with 1_000_000 lines               50   30754.48 µs/op
    parallel file with 1_000_000 lines           50   48843.44 µs/op
    allnifs file with 100_000 lines              20   87785.40 µs/op
    slurp file with 100_000 lines                10   101524.20 µs/op
    naive file with 100_000 lines                10   112340.10 µs/op
    chunkynifs file with 1_000_000 lines          5   300909.60 µs/op
    naive file with 1_000_000 lines               1   1100759.00 µs/op
    allnifs file with 1_000_000 lines             1   13774384.00 µs/op
    slurp file with 1_000_000 lines               1   13818511.00 µs/op

