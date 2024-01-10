# MiniMods
Extension of the [Mods](https://github.com/scheinerman/Mods.jl)  package for very small moduli.  

>  **NOTICE**: This module is under active development with various design changes 
being considered. We're looking for both space and speed efficiency. It is also possible
that we will fold the lessons learned here into `Mods` and abandon this project. 

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

## `MiniMod` numbers are smaller *and* faster than `Mod` numbers

```
julia> using MiniMods, Mods, LinearAlgebra, BenchmarkTools

julia> m = 17;

julia> n = 100;

julia> A = rand(Mod{m}, n, n);

julia> B = MiniMod.(A);

julia> @btime det(A)
  34.608 ms (1970121 allocations: 37.65 MiB)
Mod{17}(4)

julia> @btime det(B)
  1.869 ms (3 allocations: 10.83 KiB)
MiniMod{17}(4)

julia> @btime inv(A);
  263.101 ms (7970125 allocations: 152.25 MiB)

julia> @btime inv(B);
  16.046 ms (5 allocations: 31.56 KiB)
```


## Larger moduli

We envision that users of this module will be primarily using very small 
moduli, so the upper bound of 127 won't (we hope) be a problem. However,
users may elect to modify the code to work with larger integers (but smaller
than `Int`). 

In the source file `MiniMods.jl` find the line
```julia
const SmallInt = Int8
```
and change `Int8` to another integer type. For example, use `Int16` to expand
the range of moduli to 32767.

> **WARNING**: Unsigned integers do not work. Do not try to set `SmallInt` to `UInt8` or other unsigned types. This will result in an error message after
`using MiniMods` and the module will not compile.

