function Find_monomial(mon1::Monomial{C},mon2::Monomial{C}) where {C}
    #Is it impossible for mon2 to intersecate? i.e. position=1,2 and l2=2.
    l1 = length(mon1.z);
    l2 = length(mon2.z);
    positions = [];
    if l2>l1
        return positions;
    end
    for i=1:(1+l1-l2)
        if (mon1.vars[i:(l2+i-1)]==mon2.vars && mon1.z[i:(l2+i-1)]==mon2.z)
            push!(positions,i);
        end
    end

    return positions;
end

function Find_monomial(mon1::Monomial{C},mon2::PolyVar{C}) where {C}
    #Is it impossible for mon2 to intersecate? i.e. position=1,2 and l2=2.
    l1 = length(mon1.z);
    positions = [];
    for i=1:(l1)
        if (mon1.vars[i]==mon2)
            push!(positions,i);
        end
    end

    return positions;
end
