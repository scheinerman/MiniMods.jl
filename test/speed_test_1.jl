using MiniMods, Mods, LinearAlgebra, BenchmarkTools, LinearAlgebraX

m = 13;
n = 500;

A = rand(Mod{m}, n, n);
B = MiniMod.(A);

@info "Determinant tests"
@btime detx(A)
@btime detx(B)

@show detx(A) == det(A)
@show det(A) == det(B)

@info "Inverse tests"
@btime invx(A);
@btime invx(B);

@show inv(A) == inv(B)
@show inv(B) == invx(B)

nothing

## RESULTS with widen()  &   UInt8
# [ Info: Determinant tests
#   1.105 s (4 allocations: 1.91 MiB)
#   99.186 ms (128636 allocations: 89.81 MiB)
# detx(A) == det(A) = true
# det(A) == det(B) = true
# [ Info: Inverse tests
#   5.729 s (8 allocations: 5.73 MiB)
#   523.424 ms (254549 allocations: 262.71 MiB)
# inv(A) == inv(B) = true
# inv(B) == invx(B) = true


## RESULTS with no widen() and UInt8
# [ Info: Determinant tests
#   1.196 s (4 allocations: 1.91 MiB)
#   113.337 ms (128647 allocations: 89.81 MiB)
# detx(A) == det(A) = true
# det(A) == det(B) = true
# [ Info: Inverse tests
#   6.277 s (8 allocations: 5.73 MiB)
#   635.274 ms (254560 allocations: 262.72 MiB)
# inv(A) == inv(B) = true
# inv(B) == invx(B) = true

## RESULTS with no widen() and UInt16
# [ Info: Determinant tests
#   1.165 s (4 allocations: 1.91 MiB)
#   131.794 ms (128679 allocations: 171.47 MiB)
# detx(A) == det(A) = true
# det(A) == det(B) = true
# [ Info: Inverse tests
#   6.055 s (8 allocations: 5.73 MiB)
#   824.339 ms (254555 allocations: 507.96 MiB)
# inv(A) == inv(B) = true
# inv(B) == invx(B) = true