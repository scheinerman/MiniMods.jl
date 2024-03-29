# MiniMods
Extension of the [Mods](https://github.com/scheinerman/Mods.jl)  package for very small moduli.  


## Everything is the same, just smaller

The `MiniMods` module defines the `MiniMod` type that behaves
exactly the same as `Mod` (from the `Mods` module) except that 
moduli are restricted to lie between 2 and 255. In this way, a
`MiniMod` only takes up one byte of memory, whereas a `Mod` uses 
eight. 

```
julia> using MiniMods

julia> a = MiniMod{17}(-2)
MiniMod{17}(15)

julia> inv(a)
MiniMod{17}(8)

julia> 2a-5
MiniMod{17}(8)

julia> b = MiniMod{1000}(-1)
ERROR: AssertionError: modulus is too large
```

## Full interoperability with `Mods`

While it is not clear why one would like to mix expressions with both `Mod` and 
`MiniMod` types, this is permitted so long as the moduli of the numbers are the same. The result of such a mixed expression is `MiniMod` because this is the more 
space efficient type. 

```
julia> using Mods 

julia> a = MiniMod{10}(6);

julia> b = Mod{10}(5);

julia> a+b
MiniMod{10}(1)

julia> sizeof(a)
1

julia> sizeof(b)
8
```

## Other packages

We have tested using `MiniMods` with `LinearAlgebra`, `LinearAlgebraX`, and `SimplePolynomials`. It appears to work well in those settings.

```
julia> using LinearAlgebra, LinearAlgebraX

julia> A = rand(MiniMod{11},5,5)
5×5 Matrix{MiniMod{11}}:
 MiniMod{11}(4)  MiniMod{11}(2)  MiniMod{11}(0)  MiniMod{11}(6)  MiniMod{11}(1)
 MiniMod{11}(4)  MiniMod{11}(5)  MiniMod{11}(1)  MiniMod{11}(3)  MiniMod{11}(6)
 MiniMod{11}(9)  MiniMod{11}(7)  MiniMod{11}(2)  MiniMod{11}(9)  MiniMod{11}(9)
 MiniMod{11}(1)  MiniMod{11}(9)  MiniMod{11}(7)  MiniMod{11}(0)  MiniMod{11}(5)
 MiniMod{11}(5)  MiniMod{11}(7)  MiniMod{11}(5)  MiniMod{11}(2)  MiniMod{11}(8)

julia> det(A)
MiniMod{11}(7)

julia> detx(A)
MiniMod{11}(7)

julia> rankx(A)
5

julia> sizeof(A)   # 5x5 matrix of MiniMods using 25 bytes
25

julia> sizeof(Mod.(A)) # but same matrix of Mods using 8 times as much
200

julia> using SimplePolynomials

julia> x = getx()
x

julia> p = one(MiniMod{2}) + x
MiniMod{2}(1) + MiniMod{2}(1)*x

julia> p^8
MiniMod{2}(1) + MiniMod{2}(1)*x^8
```

## `MiniMod` numbers are smaller but not faster than `Mod` numbers

```
julia> using MiniMods, Mods, LinearAlgebra, BenchmarkTools

julia> m = 251; d = 500;

julia> A = rand(Mod{m}, d, d);

julia> B = MiniMod.(A);

julia> @btime A*A;
  601.262 ms (6 allocations: 1.94 MiB)

julia> @btime B*B;
  682.364 ms (6 allocations: 275.75 KiB)

julia> @btime det(A)
  150.941 ms (4 allocations: 1.91 MiB)
Mod{251}(217)

julia> @btime det(B)
  176.047 ms (4 allocations: 248.31 KiB)
MiniMod{251}(217)
```


## Larger moduli

We envision that users of this module will be primarily using very small 
moduli, so the upper bound of 255 won't (we hope) be a problem. However,
users may elect to modify the code to work with larger integers (but smaller
than `Int`). 

In the source file `MiniMods.jl` find the line
```julia
const SmallInt = UInt8
```
and change `UInt8` to another integer type. For example, use `UInt16` to expand
the range of moduli to 65535.


