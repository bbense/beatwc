# Beatwc

**Playing around to see if we can ever beat System.cmd("wc",["-l", path]) with native Elixir**

Results so far: 


## BenchBeatwc

    allnifs file with 100 lines               50_000  39.12 µs/op
    slurp file with 100 lines                 50_000  50.82 µs/op
    chunkynifs file with 100 lines            50_000  62.27 µs/op
    naive file with 100 lines                 10_000  160.34 µs/op
    allnifs file with 1000 lines              10_000  205.44 µs/op
    chunkynifs file with 1000 lines           10_000  208.23 µs/op
    slurp file with 1000 lines                  5000   355.05 µs/op
    naive file with 1000 lines                  1000   1274.48 µs/op
    allnifs file with 10_000 lines              1000   2457.76 µs/op
    chunkynifs file with 10_000 lines           1000   2475.58 µs/op
    wc_l file with 100 lines                     500   3089.16 µs/op
    wc_l file with 1000 lines                    500   3141.68 µs/op
    wc_l file with 10_000 lines                  500   3593.99 µs/op
    slurp file with 10_000 lines                 500   4241.60 µs/op
    wc_l file with 100_000 lines                 500   6618.42 µs/op
    naive file with 10_000 lines                 100   11794.05 µs/op
    chunkynifs file with 100_000 lines           100   28883.04 µs/op
    wc_l file with 1_000_000 lines                50   31361.00 µs/op
    allnifs file with 100_000 lines               20   91678.35 µs/op
    slurp file with 100_000 lines                 10   103677.20 µs/op
    naive file with 100_000lines                  10   118839.30 µs/op
    chunkynifs file with 1_000_000 lines           5   286391.60 µs/op
    naive file with 1_000_000 lines                1   1189603.00 µs/op
    allnifs file with 1_000_000 lines              1   13899786.00 µs/op
    slurp file with 1_000_000 lines                1   13922358.00 µs/op
