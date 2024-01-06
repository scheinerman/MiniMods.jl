module MiniMods

import Mods: AbstractMod, modulus, value, is_invertible, Mod

import Base: (==), (+), (-), (*), (inv), (/), (//), (^)
import Base: hash, iszero, isone, mod, abs, conj, rand



export MiniMod, modulus, value, is_invertible

struct MiniMod{N} <: AbstractMod
    val::Int8
    function MiniMod{N}(x::T) where {N,T<:Integer}
        @assert N isa Integer && N > 1 "Modulus must be an integer greater than 1"
        @assert N <= typemax(Int8) "modulus is too large"
        new{Int(N)}(mod(x, N))
    end
end

MiniMod{N}(q::Rational{T}) where {N,T} = MiniMod{N}(numerator(q))/MiniMod{N}(denominator(q))


modulus(::MiniMod{N}) where {N} = N
conj(x::MiniMod{N}) where {N} = x

rand(::Type{MiniMod{N}}, dims::Integer...) where {N} = MiniMod{N}.(rand(Int, dims...))

include("mini_promotion.jl")
include("mini_iterate.jl")
include("mini_arithmetic.jl")

end # module MiniMods
