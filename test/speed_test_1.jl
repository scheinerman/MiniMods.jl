using MiniMods, Mods, LinearAlgebra, BenchmarkTools, LinearAlgebraX

m = 17;
n = 500;

A = rand(Mod{m}, n, n);
B = MiniMod.(A);
C = value.(A);

@info "Determinant tests"
@btime detx(A)
@btime detx(B)
@btime detx(C).%m

@info "Inverse tests"
@btime invx(A);
@btime invx(B);
@btime invx(C);

nothing