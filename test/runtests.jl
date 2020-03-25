using DynamicPolynomials
using Test
using MSub

@ncpolyvar x y z a b

@testset "Sub_monomial" begin
    @testset "Same as subs" begin
        @test Sub_monomial(x*y*z*x*z*y*z*x,x,a)==a*y*z*a*z*y*z*a
        @test Sub_monomial(x*y*z*x*z*y*z*x,z,a)==x*y*a*x*a*y*a*x
    end
    @testset "variable to monomial" begin
        @test Sub_monomial(x*y*z*x*z*y*z*x,z*x,a)==x*y*a*z*y*a
        @test Sub_monomial(x*y*z*x*z*y*z*x,z*x,y)==x*y^2*z*y^2
        @test Sub_monomial(x*y*z*x^2*z*y*z*x,z*x^2,a)==x*y*a*z*y*z*x
        @test Sub_monomial(x*y*z*x^2*z*y*z*x,z*x^3,a)==x*y*z*x^2*z*y*z*x
    end
    @testset "monomial to variable" begin
        @test Sub_monomial(x*y*z*x*z*y*z*x,x,a*b)==a*b*y*z*a*b*z*y*z*a*b
        @test Sub_monomial(x*y*z*x^2*z*y*z*x,x,y)==y^2*z*y^2*z*y*z*y
        #Problem: I could have to substitite x in x^2
        #or even worse xy^2 in x^3y^6? This case NO for NCVAR
        #Solved?
    end
    @testset "monomial to monomial" begin
        @test Sub_monomial(x*y*z*x*z*y*z*x,x*y,a*b)==a*b*z*x*z*y*z*x
        @test Sub_monomial(x*y*z*x^2*z*y*z*x,z*x,y)==x*y*a*b*x*z*y*a*b #Questo manca
    end
end

@testset "Sub2" begin
    @test Sub2(x*y*z+2*z*x*y,z*x,a)==x*y*z+2*a*y
end
