using MiniMods, Mods, LinearAlgebra, BenchmarkTools

m = 17;
n = 100;

A = rand(Mod{m}, n, n);
B = MiniMod.(A);

@btime det(A)
@btime det(B)

@btime inv(A);
@btime inv(B);
