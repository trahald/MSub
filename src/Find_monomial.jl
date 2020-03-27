function find_monomial(mon1::Monomial{C}, mon2::PolyVar{C}) where {C}
    return findall( x -> x == mon2, variables(mon1))
end

function _subvectors(v::AbstractVector, l::Int)
    @assert length(v) >= l && l > 0
    return [v[i:i+l-1] for i = 1:length(v)-l+1]
end

"""
    unzero_termlike(term::MTermLike)

Returns a Term or a Monomial where all the variables()[i] with exponents()[i]==0 are eliminated
thus a Term or a Monomial without zeros in the exponents field.
"""
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
"""
    find_monomial(mon1, mon2)

Returns positions where mon2 can be found in the representation of mon1.
"""
function find_monomial(mon1, mon2)
    positions = Int[]
    exp1 = exponents(mon1)
    exp2 = exponents(mon2)
    l1 = length(exp1)
    l2 = length(exp2)
    if l1 >= l2
        candidates = findall(x -> x == variables(mon2), _subvectors(variables(mon1), l2))
        if !(candidates isa Nothing)
            idx = findall(c -> all(exp1[c:c+l2-1] .>= exp2), candidates)
            positions = candidates[idx]
        end
    end

    return positions
end
