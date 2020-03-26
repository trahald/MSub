module MSub

using MultivariatePolynomials;
using DynamicPolynomials;

function unzero_termlike(ter::Term{C, T}) where {C, T}
    return Term{C,T}(coefficient(ter), unzero_term(monomial(ter)));
end
function unzero_termlike(mon::Monomial{C}) where {C}
    f = findall(x->x!=0, exponents(mon));
    if isempty(f)
        return 1;
    end
    z       = Int[];
    var     = PolyVar{C}[];
    i       = 0;
    for p in f
        push!(z,exponents(mon)[p]);
        push!(var, variables(mon)[p]);
    end

    return Monomial{C}(var, z);
end




include("Find_monomial.jl");
include("Sub_monomial.jl");

function Sub2(
              poly1::Polynomial{C,T},
              mon2::Union{PolyVar{C}, Monomial{C}},
              mon3::Union{PolyVar{C}, Monomial{C}}) where {C,T}
    poly = 0;
    for (c, m) in zip(coefficients(poly1), monomials(poly1))
        poly    += c*Sub_monomial(Monomial{C}(variables(poly1), exponents(m)), mon2, mon3);
    end

    return poly;
end

export Sub2, Sub_monomial;
end
