module MiniMods

import Mods: AbstractMod, modulus, value, is_invertible, Mod

import Base: (==), (+), (-), (*), (inv), (/), (//), (^)
import Base: hash, iszero, isone, mod, abs, conj, rand

export MiniMod, modulus, value, is_invertible

# Users may define SmallInt to be a larger type of integer 
# if using a moduli greater than 127. If the modulus is 
# greater than 2_147_483_647 there is no point in using MiniMods; 
# use Mods instead.

const SmallInt = Int8

# Check that SmallInt is set to something legit
function __init__()
    if supertype(SmallInt) != Signed
        error("This module may not have SmallInt set to $SmallInt")
    end
end

struct MiniMod{N} <: AbstractMod
    val::SmallInt
    function MiniMod{N}(x::T) where {N,T<:Integer}
        @assert N isa Integer && N > 1 "Modulus must be an integer greater than 1"
        @assert N <= typemax(SmallInt) "modulus is too large"
        new{Int(N)}(mod(x, N))
    end
end

MiniMod{N}(q::Rational{T}) where {N,T} =
    MiniMod{N}(numerator(q)) / MiniMod{N}(denominator(q))

modulus(::MiniMod{N}) where {N} = N
conj(x::MiniMod{N}) where {N} = x

# conversions
Mod(a::MiniMod{N}) where {N} = Mod{N}(value(a))
Mod{N}(a::MiniMod{N}) where {N} = Mod{N}(value(a))

MiniMod(a::Mod{N}) where {N} = MiniMod{N}(value(a))
MiniMod{N}(a::Mod{N}) where {N} = MiniMod{N}(value(a))

# random MiniMod
rand(::Type{MiniMod{N}}, dims::Integer...) where {N} = MiniMod{N}.(rand(Int, dims...))

include("mini_promotion.jl")
include("mini_iterate.jl")
include("mini_arithmetic.jl")

end # module MiniMods
