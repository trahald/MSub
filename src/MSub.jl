module MSub

    using DynamicPolynomials;

    function Unzero_monomial(mon::Monomial{C}) where {C}
        f = findall(x->x!=0, mon.z);
        z       = zeros(Int, length(f));
        var     = PolyVar{C}[];
        i       = 0;
        for p in f
            i += 1;
            z[i]    = mon.z[p];
            push!(var, mon.vars[p]);
        end

        return Monomial(var, z);
    end

    include("Find_monomial.jl");
    include("Sub_monomial.jl");

    function Sub2(poly1::Polynomial{C,T}, mon2::Union{PolyVar{C},Monomial{C}}, mon3::Union{PolyVar{C},Monomial{C}}) where {C,T}
        poly = 0;
        i = 0;
        for c in poly1.a
            i       += 1;
            poly    += c*Sub_monomial(Monomial{C}(poly1.x.vars, poly1.x.Z[i]), mon2, mon3);
        end

        return poly;
    end

    export Sub2, Sub_monomial;
end
