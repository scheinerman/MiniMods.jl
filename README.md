# MiniMods
Extension for the `Mods` package for very small moduli.

## Everything is the same, just smaller

The `MiniMods` module defines the `MiniMod` type that behaves
exactly the same as `Mod` (from the `Mods` module) except that 
moduli are restricted to lie between 2 and 127. In this way, a
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
julia> a = MiniMod{10}(6);

julia> b = Mod{10}(5);

julia> a+b
MiniMod{10}(1)

julia> sizeof(a)
1

julia> sizeof(b)
8
```



