import Base: promote_rule

promo_error = "Cannot promote types with different moduli"

promote_rule(::Type{MiniMod{M}}, ::Type{MiniMod{N}}) where {M,N} =
    error(promo_error)

promote_rule(::Type{MiniMod{N}}, ::Type{MiniMod{N}}) where {N} = MiniMod{N}
promote_rule(::Type{MiniMod{N}}, ::Type{T}) where {N, T<:Integer} = MiniMod{N}
promote_rule(::Type{MiniMod{N}}, ::Type{Rational{T}}) where {N, T<:Integer} = MiniMod{N}

