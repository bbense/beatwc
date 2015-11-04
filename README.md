# Beatwc

**Playing around to see if we can ever beat System.cmd("wc",["-l", path]) with native Elixir**

Results so far: 

## BenchBeatwc
    slurp file with 100 lines           50000   51.35 Âµs/op
    naive file with 100 lines           10000   171.39 Âµs/op
    slurp file with 1000 lines           5000   354.25 Âµs/op
    naive file with 1000 lines           1000   1323.87 Âµs/op
    wc_l file with 100 lines             1000   2946.67 Âµs/op
    wc_l file with 1000 lines            1000   2987.48 Âµs/op
    wc_l file with 10000 lines            500   3427.45 Âµs/op
    slurp file with 10000 lines           500   4027.39 Âµs/op
    wc_l file with 100000 lines           500   6446.91 Âµs/op
    naive file with 10000 lines           100   12116.92 Âµs/op
    wc_l file with 1000000 lines           50   32450.54 Âµs/op
    slurp file with 100000 lines           10   103931.00 Âµs/op
    naive file with 100000 lines           10   118706.30 Âµs/op
    naive file with 1000000 lines           1   1186067.00 Âµs/op
    slurp file with 1000000 lines           1   13983707.00 Âµs/op


