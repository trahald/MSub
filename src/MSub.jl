module MSub

import DynamicPolynomials;

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


function Sub_monomial(mon1::Monomial{C},mon2::Monomial{C},mon3::Union{PolyVar{C},Monomial{C}}) where {C}
    mon1 = Unzero_monomial(mon1);
    mon2 = Unzero_monomial(mon2);
    p  = Find_monomial(mon1,mon2);
    lp = length(p);
    l2 = length(mon2.z);
    if isempty(p)
        return mon1;
    end
    if p[1]!=1
        mon     = Monomial(mon1.vars[1:(p[1]-1)], mon1.z[1:(p[1]-1)]);
    else
        mon=1;
    end
    mon     = *(mon,mon3);
    for i=2:lp;
        tmon    = Monomial(mon1.vars[(p[i-1]+l2):(p[i]-1)], mon1.z[(p[i-1]+l2):(p[i]-1)]);
        mon     = *(mon,tmon);
        mon     = *(mon,mon3)
    end
    tmon    = Monomial(mon1.vars[(p[end]+l2):end], mon1.z[(p[end]+l2):end]);
    mon     = *(mon,tmon);

    return mon;
end




function Sub_monomial(mon1::Monomial{C},mon2::PolyVar{C},mon3::Union{PolyVar{C},Monomial{C}}) where {C}
    mon1 = Unzero_monomial(mon1);
    p  = Find_monomial(mon1,mon2);
    lp = length(p);
    l2 = 1;
    if isempty(p)
        return mon1;
    end
    if p[1]!=1
        mon     = Monomial(mon1.vars[1:(p[1]-1)], mon1.z[1:(p[1]-1)]);
    else
        mon=1;
    end
    for i=1:mon1.z[p[1]]
        mon     = *(mon,mon3);
    end
    for i=2:lp;
        tmon    = Monomial(mon1.vars[(p[i-1]+l2):(p[i]-1)], mon1.z[(p[i-1]+l2):(p[i]-1)]);
        mon     = *(mon,tmon);
    for i=1:mon1.z[p[i]]
        mon     = *(mon,mon3)
    end
    end
    tmon    = Monomial(mon1.vars[(p[end]+l2):end], mon1.z[(p[end]+l2):end]);
    mon     = *(mon,tmon);

    return mon;
end


function Sub2(poly1::Polynomial{C,T}, mon2::Union{PolyVar{C},Monomial{C}}, mon3::Union{PolyVar{C},Monomial{C}}) where {C,T}
    poly = 0;
    i = 0;
    for c in poly1.a
        i       += 1;
        poly    += c*Sub_monomial(Monomial{C}(poly1.x.vars, poly1.x.Z[i]), mon2, mon3);
    end

    return poly;
end
