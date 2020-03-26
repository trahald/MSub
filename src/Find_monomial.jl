function find_monomial(mon1::Monomial{C}, mon2::PolyVar{C}) where {C}
    return findall( x -> x == mon2, variables(mon1))
end

function _subvectors(v::AbstractVector, l::Int)
    @assert length(v) >= l && l > 0
    return [v[i:i+l-1] for i = 1:length(v)-l+1]
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
