using MiniMods, Mods, LinearAlgebra, BenchmarkTools

m = 13;
n = 1000;

A = rand(Mod{m}, n, n);
B = MiniMod.(A);
C = value.(A);

@info "Testing matrix multiplication (Mod, MiniMod, Integer)"
@btime A * A;
@btime B * B;
@btime (C * C) .% m;

@show A*A == B*B 
@show A*A == (C*C) .% m

nothing

## RESULTS with widen() & UInt8
# [ Info: Testing matrix multiplication (Mod, MiniMod, Integer)
#   21.916 s (6 allocations: 7.66 MiB)
#   5.451 s (6 allocations: 1008.19 KiB)
#   336.184 ms (9 allocations: 15.29 MiB)
# A * A == B * B = true
# A * A == (C * C) .% m = true

## RESULTS without widen() and UInt8
# [ Info: Testing matrix multiplication (Mod, MiniMod, Integer)
#   21.850 s (6 allocations: 7.66 MiB)
#   5.194 s (6 allocations: 1008.19 KiB)
#   336.209 ms (9 allocations: 15.29 MiB)
# A * A == B * B = true
# A * A == (C * C) .% m = true

## RESULTS with widen() and UInt16
# [ Info: Testing matrix multiplication (Mod, MiniMod, Integer)
#   23.041 s (6 allocations: 7.66 MiB)
#   5.977 s (6 allocations: 1.94 MiB)
#   350.945 ms (9 allocations: 15.29 MiB)
# A * A == B * B = true
# A * A == (C * C) .% m = true