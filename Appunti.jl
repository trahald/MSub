using DynamicPolynomials;

@ncpolyvar x y z

poly1 = x*y*z;
poly2 = x*y*z-y*z*x-z*x*y;
poly3 = x*y*z+x*z*y+y*x*z+y*z*x+z*x*y+z*y*x;
poly4 = z*x*y+y*x*z+x*y*z+z*y*x+y*z*x+x*z*y;



@show typeof(x)
@show fieldnames(typeof(x))
@show x.id
@show x.name

@show typeof(poly1)
@show fieldnames(typeof(poly1))
@show poly1.vars
@show poly1.z

@show typeof(poly2)
@show fieldnames(typeof(poly2))
@show poly2.a
@show poly2.x
@show typeof(poly2.x[1])
@show fieldnames(typeof(poly2.x[1]))
println(poly2.x[1].vars)
println(poly2.x[2].vars)
println(poly2.x[3].vars)
println(poly2.x[1].z)
println(poly2.x[2].z)
println(poly2.x[3].z)

println(poly3.x[1].vars)
println(poly3.x[2].vars)
println(poly3.x[3].vars)
println(poly3.x[1].z)
println(poly3.x[2].z)
println(poly3.x[3].z)


println(poly4.x[1].vars)
println(poly4.x[2].vars)
println(poly4.x[3].vars)
println(poly4.x[1].z)
println(poly4.x[2].z)
println(poly4.x[3].z)



A = (findall(x -> x==1, [1,3,4,5,1,4,2]))

import DynamicPolynomials.mergevars
vars1, maps1 = mergevars([[x,y,z],[z,x,y],[y,x,z]])




@ncpolyvar x y # assigns x (resp. y) to a variable of name x (resp. y)
p = 2x + 3.0x*y^2 + y
subs(p, y=>x^2) # replace any occurence of y by x^2
differentiate(p, x) # compute the derivative of p with respect to x
differentiate.(p, (x, y)) # compute the gradient of p
p((x, y)=>(y, x)) # replace any x by y and y by x
subs(p, y=>x^2) # replace any occurence of y by x^2
p(x=>1, y=>2) # evaluate p at [1, 2]
