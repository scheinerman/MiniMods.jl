(+)(a::MiniMod{N}, b::MiniMod{N}) where {N} = MiniMod{N}(widen(value(a) + widen(value(b))))
(-)(a::MiniMod{N}) where {N} = MiniMod{N}(-value(a))
(*)(a::MiniMod{N}, b::MiniMod{N}) where {N} = MiniMod{N}(widen(value(a)) * widen(value(b)))

function is_invertible(a::MiniMod{N})::Bool where {N}
    gcd(value(a), N) == 1
end

function _invmod_mini(x::S, m::T) where {S<:Integer,T<:Integer}
    (g, v, _) = gcdx(x, m)
    if g != 1
        error("MiniMod{$m}($x) is not invertible")
    end
    return v
end

inv(a::MiniMod{N}) where {N} = MiniMod{N}(_invmod_mini(value(a), N))

