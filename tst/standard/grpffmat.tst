#############################################################################
##
#W  standard/grpffmat.tst
#Y  Copyright (C) 2015                                  James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##
gap> START_TEST("Semigroups package: standard/grpffmat.tst");
gap> LoadPackage("semigroups", false);;

#
gap> SEMIGROUPS.StartTest();

# Load a function for isomorphism checking
gap> BruteForceIsoCheck := function(iso)
>   local x, y;
>   if not IsInjective(iso) or not IsSurjective(iso) then
>     return false;
>   fi;
>   #homomorphism
>   for x in Generators(Source(iso)) do
>     for y in Generators(Source(iso)) do
>       if x ^ iso * y ^ iso <> (x * y) ^ iso then
>         return false;
>       fi;
>     od;
>   od;
>   return true;
> end;;
gap> BruteForceInverseCheck := function(map)
> local inv;
>   inv := InverseGeneralMapping(map);
>   return ForAll(Source(map), x -> x = (x ^ map) ^ inv)
>     and ForAll(Range(map), x -> x = (x ^ inv) ^ map);
> end;;

# IsomorphismPermGroup
gap> S := Semigroup(
> [ Matrix(GF(2), [[0*Z(2), Z(2)^0, 0*Z(2)], [0*Z(2), 0*Z(2), Z(2)^0],
>   [Z(2)^0, 0*Z(2), 0*Z(2)]]) ]);;
gap> map := IsomorphismPermGroup(S);
MappingByFunction( <group of size 3, 3x3 matrices over GF(2) with 1 generator>
, <group of size 3, with 1 generator>
, function( x ) ... end, function( x ) ... end )
gap> BruteForceInverseCheck(map);
true
gap> BruteForceIsoCheck(map);
true
gap> G := GroupOfUnits(GLM(2,2));;
gap> IsMatrixOverFiniteFieldGroup(G);
false
gap> G := Group(GeneratorsOfSemigroup(G));
<group of 2x2 matrices over GF(2) with 3 generators>
gap> IsMatrixOverFiniteFieldGroup(G);
true
gap> map := IsomorphismPermGroup(G);
MappingByFunction( <group of 2x2 matrices over GF(2) with 
3 generators>, Group([ (), (2,3), (1,
2) ]), function( x ) ... end, function( x ) ... end )
gap> BruteForceInverseCheck(map);
true
gap> BruteForceIsoCheck(map);
true

# IsomorphismMatrixGroup
gap> S := Semigroup(Matrix(GF(3), []));;
gap> IsomorphismMatrixGroup(S);
MappingByFunction( <trivial group of 0x0 matrices over GF(3) with 1 generator>
, <pc group of size 1 with 
0 generators>, function( x ) ... end, function( x ) ... end )
gap> S := Semigroup(Matrix(GF(3), [[Z(3)]]));;
gap> G := Group(One(S));
<group of 1x1 matrices over GF(3) with 1 generator>
gap> IsomorphismMatrixGroup(G);
MappingByFunction( <group of 1x1 matrices over GF(3) with 1 generator>, Group(
[ [ [ Z(3)^0 ] ] ]), <Attribute "AsList">, function( g ) ... end )

# ClosureGroup
gap> G := GroupOfUnits(GLM(3,3));
<group of 3x3 matrices over GF(3) with 2 generators>
gap> IsMatrixOverFiniteFieldGroup(G);
false
gap> G := Group(GeneratorsOfSemigroup(G));
<group of 3x3 matrices over GF(3) with 3 generators>
gap> IsMatrixOverFiniteFieldGroup(G);
true
gap> x := Matrix(GF(3), [[Z(3)^0, 0*Z(3), Z(3)^0, 0*Z(3)],
>  [0*Z(3), Z(3), Z(3)^0, Z(3)], [0*Z(3), Z(3), 0*Z(3), Z(3)^0],
>  [Z(3), Z(3)^0, 0*Z(3), Z(3)^0]]);;
gap> ClosureGroup(G, x);
Error, Semigroups: ClosureGroup (for matrix over finite field group and matrix\
 over finite field): usage,
 the args must have the same base domain, degree, and
 the second arg must be invertible,
gap> ClosureGroup(G, [x]);
Error, Semigroups: ClosureGroup (for matrix over finite field group and matrix\
 over finite field): usage,
 the args must have the same base domain, degree, and
 every matrix in the second arg must be invertible,
gap> G ^ x;
Error, Semigroups: ^ (for matrix over finite field group and matrix over finit\
e field): usage,
 the args must have the same base domain, degree, and
 the second arg must be invertible,
gap> S := Group(Matrix(GF(3), []));;
gap> ClosureGroup(S, S);
<group of 0x0 matrices over GF(3) with 1 generator>

# IsomorphismSemigroup
gap> G := GroupOfUnits(GLM(3,3));;
gap> G := Group(List(GeneratorsOfSemigroup(G), AsList));
<matrix group with 3 generators>
gap> IsomorphismSemigroup(IsMatrixOverFiniteFieldSemigroup, G);
MappingByFunction( <matrix group with 3 generators>, <group of 3x
3 matrices over GF(3) with 
3 generators>, function( g ) ... end, <Attribute "AsList"> )

# Size
gap> G := GroupOfUnits(GLM(3,3));;
gap> G := Group(GeneratorsOfSemigroup(G));;
gap> Size(G);
11232
gap> S := Semigroup(Matrix(GF(3), []));;
gap> IsMatrixOverFiniteFieldGroup(S);
false
gap> Size(S);
1

# \in 
gap> G := GroupOfUnits(GLM(3,3));;
gap> G := Group(GeneratorsOfSemigroup(G));;
gap> Matrix(GF(2^2), [[Z(2^2)^2, Z(2^2)], [0*Z(2), 0*Z(2)]]) in G;
false
gap> S := Semigroup(Matrix(GF(3), []));;
gap> Matrix(GF(3), []) in S;
true

# \^ for matrix group and matrix
gap> G := GroupOfUnits(GLM(3,3));;
gap> G := Group(GeneratorsOfSemigroup(G));;
gap> G ^ One(G);
<group of 3x3 matrices over GF(3) with 3 generators>
gap> G ^ Matrix(GF(3), [[Z(3), 0 * Z(3), Z(3)], [Z(3) ^ 0, Z(3) ^ 0, Z(3) ^ 0], [
> Z(3), Z(3), Z(3) ^ 0]]);
<group of 3x3 matrices over GF(3) with 3 generators>
gap> G := Group(Matrix(GF(3), []));;
gap> G ^ Matrix(GF(3), []);
<group of 0x0 matrices over GF(3) with 1 generator>

#
gap> STOP_TEST("Semigroups package: standard/grpffmat.tst");
