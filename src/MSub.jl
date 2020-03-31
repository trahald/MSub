module MSub

using MultivariatePolynomials;
using DynamicPolynomials;

const MTermLike{C,T} = Union{Number,DynamicPolynomials.DMonomialLike{C},DynamicPolynomials.Term{C,T}};
const MTermPoly{C,T} = Union{MTermLike{C,T}, Polynomial{C,T}};

include("Find_monomial.jl");
include("Sub_monomial.jl");

function sub_monomial(
              poly1::Polynomial{C,T},
              mon2::Union{PolyVar{C}, Monomial{C}},
              mon3::MTermPoly{C,T}) where {C,T}
    poly = 0;
    for (c, m) in zip(coefficients(poly1), monomials(poly1))
        poly    += c*sub_monomial(Monomial{C}(variables(poly1), exponents(m)), mon2, mon3);
    end

    return poly;
end

export sub_monomial;
end
