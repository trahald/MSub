function sub_monomial(
                        mon1::MTermLike{C,T},
                        mon2::PolyVar{C},
                        mon3::MTermPoly{C,T}) where {C,T}
    return sub_monomial(mon1, Monomial{C}([mon2],[1]), mon3);
end
function sub_monomial(
                        mon1::Term{C,T},
                        mon2::Monomial{C},
                        mon3::MTermPoly{C,T}) where {C,T}
    return coefficient(mon1)*sub_monomial(monomial(mon1),mon2, mon3);
end

function sub_monomial(
                        mon1::Monomial{C},
                        mon2::Monomial{C},
                        mon3::MTermPoly{C,T}) where {C,T}
    mon1 = unzero_termlike(mon1);
    mon2 = unzero_termlike(mon2);
    p  = find_monomial(mon1,mon2);
    lp = length(p);
    l2 = length(mon2.z);

    if isempty(p)
        return mon1;
    end

    if l2==1
        # subs(mon1, variables(mon2)[1] => mon3); #Do not work with (x * y * z * x * z * y * z * x ^ 3, x, a * b) and others
        if p[1]!=1
            mon     = Monomial{C}(variables(mon1)[1:(p[1]-1)], exponents(mon1)[1:(p[1]-1)]);
        else
            mon=1;
        end
        for i=1:exponents(mon1)[p[1]]
            mon     = *(mon,mon3);
        end
        for i=2:lp;
            tmon    = Monomial{C}(variables(mon1)[(p[i-1]+l2):(p[i]-1)], exponents(mon1)[(p[i-1]+l2):(p[i]-1)]);
            mon     = *(mon,tmon);
            for i=1:exponents(mon1)[p[i]]
                mon     = *(mon,mon3)
            end
        end
        tmon    = Monomial{C}(variables(mon1)[(p[end]+l2):end], exponents(mon1)[(p[end]+l2):end]);
        mon     = *(mon,tmon);
    else
        if p[1]!=1
            mon     = Monomial{C}(variables(mon1)[1:(p[1]-1)], exponents(mon1)[1:(p[1]-1)]);
        else
            mon     = Monomial{C}([variables(mon1)[1]], [exponents(mon1)[1]-mon2.z[1]]);
            mon     = unzero_termlike(mon);
        end
        mon     = *(mon,mon3);
        rmon    = Monomial{C}([variables(mon1)[p[1]+l2-1]], [exponents(mon1)[p[1]+l2-1]-mon2.z[l2]]);
        rmon    = unzero_termlike(rmon);
        mon     = *(mon,rmon);
        for i=2:lp
            tmon    = Monomial{C}(variables(mon1)[(p[i-1]+2):(p[i]-1)], exponents(mon1)[(p[i-1]+2):(p[i]-1)]);
            mon     = *(mon,tmon);
            lmon    = Monomial{C}([variables(mon1)[p[i]]], [exponents(mon1)[p[i]]-mon2.z[1]]);
            lmon    = unzero_termlike(lmon);
            mon     = *(mon,lmon);
            mon     = *(mon,mon3);
            rmon    = Monomial{C}([variables(mon1)[p[i]+l2-1]], [exponents(mon1)[p[i]+l2-1]-mon2.z[l2]]);
            rmon    = unzero_termlike(rmon);
            mon     = *(mon,rmon);
        end
        tmon    = Monomial{C}(variables(mon1)[(p[end]+2):end], exponents(mon1)[(p[end]+2):end]);
        mon     = *(mon,tmon);
    end

    return mon; #Unzero mon?
end

function sub_monomial(
             mon1::Number,
             mon2::Monomial{C},
             mon3::MTermPoly{C,T}) where {C,T}
    return mon1;
end
