using Test
using MiniMods, Mods

@testset "Basics" begin
    a = MiniMod{11}(-1)
    @test a == 10

    aa = Mod(a)
    @test a == aa

    b = one(MiniMod{11})
    @test b == 1
    @test isone(b)
    bb = Mod(b)
    @test bb == b

    c = zero(MiniMod{11})
    @test c == 0
    @test iszero(c)


end

@testset "Arithmetic" begin
    a = MiniMod{11}(5)
    @test a + a == 2a
    @test one(a) == a / a
    @test zero(a) == a - a
    @test a + 1 == MiniMod{11}(6)
    @test a^10 == 1
    @test inv(a) * a == 1
    @test a / a == 1
    @test a / 5 == 1
    @test 5 // a == 1
end

@testset "Iteration" begin
    v = [x for x in MiniMod{11} if x != 0]
    @test prod(v) == -1 # Wilson's theorem
end

@testset "Overflow" begin
    a = MiniMod{127}(99)
    @test a * a == 99^2
    @test 20 * a == 20 * 99
    @test -5a == -5 * 99
end

@testset "Matrices" begin
    M = zeros(MiniMod{11}, 5, 7)
    @test iszero(sum(M))

    M = ones(MiniMod{11}, 5, 5)
    @test sum(M) == 25
end
