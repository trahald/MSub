

    function Sub_monomial(mon1::Monomial{C},mon2::Monomial{C},mon3::Union{PolyVar{C},Monomial{C},Number}) where {C}
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




    function Sub_monomial(mon1::Monomial{C},mon2::PolyVar{C},mon3::Union{PolyVar{C},Monomial{C},Number}) where {C}
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
