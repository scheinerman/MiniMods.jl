import Base: show

function show(io::IO, x::MiniMod)
    v = value(x)
    m = modulus(x)
    print(io, "MiniMod{$m}($v)")
end