# Beatwc

**Playing around to see if we can ever beat System.cmd("wc",["-l", path]) with native Elixir**

Results so far: 


## BenchBeatwc
    allnifs file with 100 lines           50000   39.77 µs/op
    slurp file with 100 lines             50000   51.29 µs/op
    naive file with 100 lines             10000   174.93 µs/op
    allnifs file with 1000 lines          10000   203.96 µs/op
    slurp file with 1000 lines             5000   357.59 µs/op
    naive file with 1000 lines             1000   1304.55 µs/op
    allnifs file with 10000 lines          1000   2440.31 µs/op
    wc_l file with 100 lines                500   3093.44 µs/op
    wc_l file with 1000 lines               500   3134.72 µs/op
    wc_l file with 10000 lines              500   3514.85 µs/op
    slurp file with 10000 lines             500   3886.35 µs/op
    wc_l file with 100000 lines             500   6572.22 µs/op
    naive file with 10000 lines             100   11798.97 µs/op
    wc_l file with 1000000 lines             50   31000.94 µs/op
    allnifs file with 100000 lines           20   91750.95 µs/op
    slurp file with 100000 lines             10   104412.90 µs/op
    naive file with 100000 lines             10   119594.70 µs/op
    naive file with 1000000 lines             1   1194935.00 µs/op
    slurp file with 1000000 lines             1   13613259.00 µs/op
    allnifs file with 1000000 lines           1   13842518.00 µs/op
