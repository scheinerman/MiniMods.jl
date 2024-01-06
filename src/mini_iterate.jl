function Base.iterate(::Type{MiniMod{m}}) where {m}
    return MiniMod{m}(0), 0
end

function Base.iterate(::Type{MiniMod{m}}, s) where {m}
    if s == m - 1
        return nothing
    end
    s += 1
    return MiniMod{m}(s), s
end

Base.IteratorSize(::Type{MiniMod{m}}) where {m} = Base.HasLength()

Base.length(::Type{MiniMod{m}}) where {m} = m




