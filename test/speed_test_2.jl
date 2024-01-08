using MiniMods, Mods, LinearAlgebra, BenchmarkTools

m = 17;
n = 1000;

A = rand(Mod{m}, n, n);
B = MiniMod.(A);
C = value.(A);

@info "Testing matrix multiplication (Mod, MiniMod, Integer)"
@btime A * A;
@btime B * B;
@btime (C * C) .% m;

nothing
