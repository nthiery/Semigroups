#%T##########################################################################
##
#W  standard/attributes/attributes-inverse.tst
#Y  Copyright (C) 2015                                   Wilfred A. Wilson
##
##  Licensing information can be found in the README file of this package.
#
#############################################################################
##
## TODO improve code coverage in JoinIrreducibleDClasses 
gap> START_TEST("Semigroups package: standard/attributes/attributes-inverse.tst");
gap> LoadPackage("semigroups", false);;

# 
gap> SemigroupsStartTest();

#T# attributes-inverse: VagnerPrestonRepresentation, symmetric inv monoid 4 1/1
gap> S := InverseSemigroup([
>   PartialPerm([2, 3, 4, 1]),
>   PartialPerm([2, 1, 3, 4]),
>   PartialPerm([1, 2, 3, 0])
> ]);;
gap> Size(S);
209
gap> Size(S) = Size(SymmetricInverseMonoid(4));
true
gap> iso := VagnerPrestonRepresentation(S);;
gap> DegreeOfPartialPermSemigroup(Range(iso));
209

#T# attributes-inverse: SameMinorantsSubgroup, symmetric inv monoid 5 1/2
gap> S := SymmetricInverseSemigroup(5);;
gap> h := HClass(S, One(S));
<Green's H-class: <identity partial perm on [ 1, 2, 3, 4, 5 ]>>
gap> SameMinorantsSubgroup(h);
[ <identity partial perm on [ 1, 2, 3, 4, 5 ]> ]
gap> h := HClass(S, PartialPerm([1, 2, 0, 0, 0]));
<Green's H-class: <identity partial perm on [ 1, 2 ]>>
gap> SameMinorantsSubgroup(h);
[ <identity partial perm on [ 1, 2 ]> ]
gap> h := HClass(S, MultiplicativeZero(S));
<Green's H-class: <empty partial perm>>
gap> SameMinorantsSubgroup(h);
[ <empty partial perm> ]

#T# attributes-inverse: SameMinorantsSubgroup, error 2/2
gap> S := FullTransformationMonoid(5);;
gap> h := HClass(S, One(S));
<Green's H-class: IdentityTransformation>
gap> SameMinorantsSubgroup(h);
Error, Semigroups: SameMinorantsSubgroup: usage,
the parent semigroup of the group H-class <H> must be inverse,

#T# attributes-inverse: Minorants, error
gap> S := SymmetricInverseMonoid(3);;
gap> f := PartialPerm([1, 2, 3, 4]);;
gap> Minorants(S, f);
Error, Semigroups: Minorants: usage,
the second argument is not an element of the first,
gap> f := PartialPerm([1, 2, 3]);;
gap> Set(Minorants(S, f));
[ <empty partial perm>, <identity partial perm on [ 1 ]>, 
  <identity partial perm on [ 2 ]>, <identity partial perm on [ 1, 2 ]>, 
  <identity partial perm on [ 3 ]>, <identity partial perm on [ 2, 3 ]>, 
  <identity partial perm on [ 1, 3 ]> ]
gap> NaturalPartialOrder(S);;
gap> Minorants(S, f);
[ <empty partial perm>, <identity partial perm on [ 1 ]>, 
  <identity partial perm on [ 2 ]>, <identity partial perm on [ 1, 2 ]>, 
  <identity partial perm on [ 3 ]>, <identity partial perm on [ 2, 3 ]>, 
  <identity partial perm on [ 1, 3 ]> ]
gap> f := PartialPerm([1, 3, 2]);;

#T# attributes-inverse: character tables of inverse acting semigroups
# Some random examples to test consistency of old code with new
gap> gens:=[
> [ PartialPerm( [ 1, 2, 3, 4, 6, 8, 9 ], [ 1, 5, 3, 8, 9, 4, 10 ] ) ],
> [ PartialPerm( [ 1, 2, 3, 4, 5, 6 ], [ 3, 8, 4, 6, 5, 7 ] ), 
>   PartialPerm( [ 1, 2, 3, 4, 5, 7 ], [ 1, 4, 3, 2, 7, 6 ] ), 
>   PartialPerm( [ 1, 2, 3, 5, 6, 8 ], [ 5, 7, 1, 4, 2, 6 ] ) ],
> [ PartialPerm( [ 1, 2, 3, 5 ], [ 2, 1, 7, 3 ] ), 
>   PartialPerm( [ 1, 2, 4, 5, 6 ], [ 7, 3, 1, 4, 2 ] ), 
>   PartialPerm( [ 1, 2, 3, 4, 6 ], [ 7, 6, 5, 1, 2 ] ), 
>   PartialPerm( [ 1, 3, 6, 7 ], [ 6, 3, 1, 4 ] ) ],
> [ PartialPerm( [ 1, 2, 3, 5 ], [ 1, 6, 4, 7 ] ), 
>   PartialPerm( [ 1, 2, 3, 6 ], [ 1, 6, 5, 2 ] ), 
>   PartialPerm( [ 1, 2, 3, 5, 6, 7 ], [ 4, 3, 5, 7, 1, 6 ] ), 
>   PartialPerm( [ 1, 2, 3, 4, 7 ], [ 6, 4, 2, 3, 1 ] ) ],
> [ PartialPerm( [ 1, 2, 3, 5, 6 ], [ 5, 3, 7, 4, 1 ] ), 
>   PartialPerm( [ 1, 2, 3, 4, 5, 7 ], [ 3, 1, 5, 7, 6, 2 ] ) ],
> [ PartialPerm( [ 1, 2, 3, 4, 5, 6, 9 ], [ 1, 5, 9, 2, 6, 10, 7 ] ), 
>   PartialPerm( [ 1, 3, 4, 7, 8, 9 ], [ 9, 4, 1, 6, 2, 8 ] ), 
>   PartialPerm( [ 1, 2, 3, 4, 5, 9 ], [ 9, 3, 8, 2, 10, 7 ] ) ],
> [ PartialPerm( [ 1, 2, 3, 4, 5 ], [ 6, 4, 1, 2, 7 ] ), 
>   PartialPerm( [ 1, 2, 3, 6 ], [ 3, 5, 7, 4 ] ), 
>   PartialPerm( [ 1, 2, 3, 4, 5, 6, 7 ], [ 1, 7, 9, 5, 2, 8, 4 ] ) ],
> [ PartialPerm( [ 1, 2, 4 ], [ 3, 6, 2 ] ), 
>   PartialPerm( [ 1, 2, 3, 4 ], [ 6, 3, 2, 1 ] ), 
>   PartialPerm( [ 1, 2, 3, 6 ], [ 4, 6, 3, 1 ] ), 
>   PartialPerm( [ 1, 2, 3, 5, 6 ], [ 5, 6, 3, 2, 4 ] ) ],
> [ PartialPerm( [ 1, 2, 3, 4 ], [ 3, 5, 1, 2 ] ), 
>   PartialPerm( [ 1, 2, 3, 4 ], [ 5, 4, 2, 1 ] ), 
>   PartialPerm( [ 1, 2, 4, 5 ], [ 3, 5, 1, 2 ] ) ],
> [ PartialPerm( [ 1, 2, 3, 5 ], [ 4, 1, 2, 3 ] ) ]];;
gap> S:=List(gens, x -> InverseSemigroup(x, rec(generic := false)));
[ <inverse partial perm semigroup of rank 9 with 1 generator>, 
<inverse partial perm semigroup of rank 8 with 3 generators>, 
<inverse partial perm semigroup of rank 7 with 4 generators>, 
<inverse partial perm semigroup of rank 7 with 4 generators>, 
<inverse partial perm semigroup of rank 7 with 2 generators>, 
<inverse partial perm semigroup of rank 10 with 3 generators>, 
<inverse partial perm semigroup of rank 9 with 3 generators>, 
<inverse partial perm semigroup of rank 6 with 4 generators>, 
<inverse partial perm semigroup of rank 5 with 3 generators>, 
<inverse partial perm semigroup of rank 5 with 1 generator> ]
gap> CharacterTableOfInverseSemigroup(S[1]);
[ [ [ 1, 0, 0, 0 ], [ 2, 1, 0, 0 ], [ 1, 1, 1, -1 ], [ 1, 1, 1, 1 ] ], 
  [ <identity partial perm on [ 1, 3, 4, 5, 8, 9, 10 ]>, 
      <identity partial perm on [ 1, 3, 4, 8, 10 ]>, 
      <identity partial perm on [ 1, 3, 4, 8 ]>, (1)(3)(4,8) ] ]
gap> CharacterTableOfInverseSemigroup(S[2]);
[ [ [ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 1, 1, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 2, 2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 2, 4, 4, 2, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 3, 3, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 4, 3, 3, 2, 2, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 4, 3, 3, 2, 2, 1, 0, 0, 1, E(3)^2, E(3), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 
         ], [ 4, 3, 3, 2, 2, 1, 0, 0, 1, E(3), E(3)^2, 0, 0, 0, 0, 0, 0, 0, 
          0, 0, 0 ], 
      [ 1, 1, 3, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, -1, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 19, 19, 20, 10, 10, 9, 4, 4, 4, 1, 1, 4, 3, -1, 1, -1, 1, 0, 0, 0, 0 ]
        , [ 38, 38, 40, 20, 20, 18, 8, 8, 8, -1, -1, 8, 6, 0, 2, 0, -1, 0, 0, 
          0, 0 ], 
      [ 19, 19, 20, 10, 10, 9, 4, 4, 4, 1, 1, 4, 3, 1, 1, 1, 1, 0, 0, 0, 0 ], 
      [ 15, 15, 15, 10, 10, 10, 6, 6, 6, 0, 0, 6, 6, 0, 3, -1, 0, 1, -1, 0, 0 
         ], [ 15, 15, 15, 10, 10, 10, 6, 6, 6, 0, 0, 6, 6, 2, 3, 1, 0, 1, 1, 
          0, 0 ], 
      [ 6, 6, 6, 5, 5, 5, 4, 4, 4, 1, 1, 4, 4, 2, 3, 1, 0, 2, 0, 1, 0 ], 
      [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ] ], 
  [ <identity partial perm on [ 3, 4, 5, 6, 7, 8 ]>, 
      <identity partial perm on [ 1, 2, 3, 4, 6, 7 ]>, 
      <identity partial perm on [ 1, 2, 4, 5, 6, 7 ]>, 
      <identity partial perm on [ 2, 3, 5, 6, 8 ]>, 
      <identity partial perm on [ 3, 5, 6, 7, 8 ]>, 
      <identity partial perm on [ 3, 4, 6, 7, 8 ]>, 
      <identity partial perm on [ 1, 2, 5, 7 ]>, 
      <identity partial perm on [ 4, 5, 6, 7 ]>, 
      <identity partial perm on [ 2, 3, 6, 7 ]>, (2)(3,6,7), (2)(3,7,6), 
      <identity partial perm on [ 2, 4, 5, 7 ]>, 
      <identity partial perm on [ 1, 2, 3, 4 ]>, (1)(2,4)(3), 
      <identity partial perm on [ 5, 6, 7 ]>, (5)(6,7), (5,6,7), 
      <identity partial perm on [ 2, 4 ]>, (2,4), 
      <identity partial perm on [ 7 ]>, <empty partial perm> ] ]
gap> CharacterTableOfInverseSemigroup(S[3]);
[ [ [ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 6, 6, 4, 2, 2, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 0, 1, 0, 1, 0, 0, 0, 0, 1, -1, 0, 0, 0, 0, 0 ], 
      [ 0, 1, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0 ], 
      [ 2, 2, 0, 0, 1, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0 ], 
      [ 10, 10, 6, 6, 6, 6, 3, 3, 3, -1, 3, 1, -1, 0, 0 ], 
      [ 10, 10, 6, 6, 6, 6, 3, 3, 3, 1, 3, 1, 1, 0, 0 ], 
      [ 5, 5, 4, 4, 4, 4, 3, 3, 3, 1, 3, 2, 0, 1, 0 ], 
      [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ] ], 
  [ <identity partial perm on [ 1, 2, 3, 4, 7 ]>, 
      <identity partial perm on [ 1, 2, 5, 6, 7 ]>, 
      <identity partial perm on [ 1, 2, 3, 7 ]>, 
      <identity partial perm on [ 1, 3, 4, 6 ]>, 
      <identity partial perm on [ 1, 5, 6, 7 ]>, 
      <identity partial perm on [ 2, 3, 4, 7 ]>, 
      <identity partial perm on [ 1, 2, 7 ]>, 
      <identity partial perm on [ 3, 6, 7 ]>, 
      <identity partial perm on [ 1, 3, 6 ]>, (1,6)(3), 
      <identity partial perm on [ 2, 4, 7 ]>, 
      <identity partial perm on [ 3, 7 ]>, (3,7), 
      <identity partial perm on [ 6 ]>, <empty partial perm> ] ]
gap> CharacterTableOfInverseSemigroup(S[4]);
[ [ [ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 4, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 2, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 2, 1, 0, 0, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 0, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 20, 9, 10, 4, 4, 0, 4, 3, 4, 1, -1, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 20, 9, 10, 4, 4, 0, 4, 3, 4, 1, 1, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0 ], 
      [ 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, E(3)^2, E(3), 0, 0, 0, 0 ], 
      [ 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, E(3), E(3)^2, 0, 0, 0, 0 ], 
      [ 15, 10, 10, 6, 6, -2, 6, 6, 6, 3, -1, 3, 0, 0, 1, -1, 0, 0 ], 
      [ 15, 10, 10, 6, 6, 2, 6, 6, 6, 3, 1, 3, 0, 0, 1, 1, 0, 0 ], 
      [ 6, 5, 5, 4, 4, 0, 4, 4, 4, 3, 1, 3, 0, 0, 2, 0, 1, 0 ], 
      [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ] ], 
  [ <identity partial perm on [ 1, 3, 4, 5, 6, 7 ]>, 
      <identity partial perm on [ 1, 2, 3, 4, 6 ]>, 
      <identity partial perm on [ 1, 4, 5, 6, 7 ]>, 
      <identity partial perm on [ 1, 4, 6, 7 ]>, 
      <identity partial perm on [ 1, 2, 5, 6 ]>, (1,5)(2,6), 
      <identity partial perm on [ 1, 2, 4, 7 ]>, 
      <identity partial perm on [ 2, 3, 4, 6 ]>, 
      <identity partial perm on [ 1, 2, 4, 6 ]>, 
      <identity partial perm on [ 1, 4, 6 ]>, (1,6)(4), 
      <identity partial perm on [ 2, 3, 4 ]>, (2,3,4), (2,4,3), 
      <identity partial perm on [ 1, 2 ]>, (1,2), 
      <identity partial perm on [ 1 ]>, <empty partial perm> ] ]
gap> CharacterTableOfInverseSemigroup(S[5]);
[ [ [ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 7, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 5, 2, 0, 1, 0, 0, 0, 0, 0, 0, 0 ]
        , [ 19, 10, 4, 4, 1, 1, 1, 0, 0, 0, 0 ], 
      [ 19, 10, 4, 4, 1, E(3)^2, E(3), 0, 0, 0, 0 ], 
      [ 19, 10, 4, 4, 1, E(3), E(3)^2, 0, 0, 0, 0 ], 
      [ 15, 10, 6, 6, 3, 0, 0, 1, -1, 0, 0 ], 
      [ 15, 10, 6, 6, 3, 0, 0, 1, 1, 0, 0 ], 
      [ 6, 5, 4, 4, 3, 0, 0, 2, 0, 1, 0 ], 
      [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ] ], 
  [ <identity partial perm on [ 1, 2, 3, 5, 6, 7 ]>, 
      <identity partial perm on [ 1, 3, 4, 5, 7 ]>, 
      <identity partial perm on [ 1, 2, 3, 4 ]>, 
      <identity partial perm on [ 1, 3, 5, 6 ]>, 
      <identity partial perm on [ 4, 5, 7 ]>, (4,5,7), (4,7,5), 
      <identity partial perm on [ 3, 4 ]>, (3,4), 
      <identity partial perm on [ 4 ]>, <empty partial perm> ] ]
gap> CharacterTableOfInverseSemigroup(S[6]);
[ [ [ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
      [ 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
      [ 2, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
      [ 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
      [ 2, 0, 2, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
      [ 2, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
      [ 2, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
      [ 1, 2, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
      [ 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
      [ 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
      [ 1, 4, 1, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
      [ 4, 6, 4, 1, 2, 1, 1, 1, 3, 2, 1, 0, 1, -1, 1, 0, 0, 0, 0, 0, 0, 0, 0 ]
        , [ 8, 12, 8, 2, 4, 2, 2, 2, 6, 4, 2, 0, 2, 0, -1, 0, 0, 0, 0, 0, 0, 
          0, 0 ], 
      [ 4, 6, 4, 1, 2, 1, 1, 1, 3, 2, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0 ],
      [ 5, 2, 3, 2, 2, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 ],
      [ 3, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 ],
      [ 3, 1, 2, 1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 ],
      [ 2, 1, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0 ],
      [ 21, 15, 15, 10, 10, 6, 6, 6, 6, 6, 6, 3, 3, -1, 0, 3, 3, 3, 3, 1, -1, 
          0, 0 ], 
      [ 21, 15, 15, 10, 10, 6, 6, 6, 6, 6, 6, 3, 3, 1, 0, 3, 3, 3, 3, 1, 1, 
          0, 0 ], 
      [ 7, 6, 6, 5, 5, 4, 4, 4, 4, 4, 4, 3, 3, 1, 0, 3, 3, 3, 3, 2, 0, 1, 0 ],
      [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ] 
     ], 
  [ <identity partial perm on [ 1, 2, 5, 6, 7, 9, 10 ]>, 
      <identity partial perm on [ 1, 2, 4, 6, 8, 9 ]>, 
      <identity partial perm on [ 2, 3, 7, 8, 9, 10 ]>, 
      <identity partial perm on [ 1, 5, 6, 7, 10 ]>, 
      <identity partial perm on [ 1, 2, 5, 7, 10 ]>, 
      <identity partial perm on [ 3, 7, 9, 10 ]>, 
      <identity partial perm on [ 1, 4, 7, 8 ]>, 
      <identity partial perm on [ 1, 4, 5, 9 ]>, 
      <identity partial perm on [ 1, 2, 8, 9 ]>, 
      <identity partial perm on [ 2, 3, 7, 9 ]>, 
      <identity partial perm on [ 2, 4, 6, 8 ]>, 
      <identity partial perm on [ 6, 8, 9 ]>, 
      <identity partial perm on [ 1, 3, 4 ]>, (1)(3,4), (1,3,4), 
      <identity partial perm on [ 5, 7, 9 ]>, 
      <identity partial perm on [ 1, 5, 10 ]>, 
      <identity partial perm on [ 3, 6, 9 ]>, 
      <identity partial perm on [ 4, 5, 9 ]>, 
      <identity partial perm on [ 6, 9 ]>, (6,9), 
      <identity partial perm on [ 7 ]>, <empty partial perm> ] ]
gap> CharacterTableOfInverseSemigroup(S[7]);
[ [ [ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 1, 0, 1, 1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 1, 0, 1, -1, -E(4), E(4), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 1, 0, 1, -1, E(4), -E(4), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 6, 2, 4, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 4, 2, 2, -2, 0, 0, 0, 1, 1, -1, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 4, 2, 2, 2, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 10, 5, 4, 0, 0, 0, 1, 2, 0, 0, 1, 0, 0, 0, 0, 0, 0 ], 
      [ 5, 1, 4, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0 ], 
      [ 3, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0 ], 
      [ 20, 10, 10, -2, 0, 0, 6, 6, 3, -1, 3, 3, 3, 1, -1, 0, 0 ], 
      [ 20, 10, 10, 2, 0, 0, 6, 6, 3, 1, 3, 3, 3, 1, 1, 0, 0 ], 
      [ 7, 5, 5, 1, 1, 1, 4, 4, 3, 1, 3, 3, 3, 2, 0, 1, 0 ], 
      [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ] ], 
  [ <identity partial perm on [ 1, 2, 4, 5, 7, 8, 9 ]>, 
      <identity partial perm on [ 1, 2, 4, 6, 7 ]>, 
      <identity partial perm on [ 1, 2, 4, 5, 7 ]>, (1)(2,4)(5,7), 
      (1)(2,5,4,7), (1)(2,7,4,5), <identity partial perm on [ 3, 4, 5, 7 ]>, 
      <identity partial perm on [ 1, 2, 5, 7 ]>, 
      <identity partial perm on [ 2, 4, 6 ]>, (2,4)(6), 
      <identity partial perm on [ 3, 4, 5 ]>, 
      <identity partial perm on [ 2, 4, 7 ]>, 
      <identity partial perm on [ 3, 5, 7 ]>, 
      <identity partial perm on [ 3, 6 ]>, (3,6), 
      <identity partial perm on [ 7 ]>, <empty partial perm> ] ]
gap> CharacterTableOfInverseSemigroup(S[8]);
[ [ [ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 1, 1, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 2, 0, 1, 0, 0, 0, 0, 0, 0, 0 ], [ 7, 4, 3, 1, -1, 1, 0, 0, 0, 0 ], 
      [ 14, 8, 6, 2, 0, -1, 0, 0, 0, 0 ], [ 7, 4, 3, 1, 1, 1, 0, 0, 0, 0 ], 
      [ 10, 6, 6, 3, -1, 0, 1, -1, 0, 0 ], [ 10, 6, 6, 3, 1, 0, 1, 1, 0, 0 ], 
      [ 5, 4, 4, 3, 1, 0, 2, 0, 1, 0 ], [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ] ], 
  [ <identity partial perm on [ 2, 3, 4, 5, 6 ]>, 
      <identity partial perm on [ 1, 2, 3, 6 ]>, 
      <identity partial perm on [ 2, 3, 4, 6 ]>, 
      <identity partial perm on [ 2, 3, 6 ]>, (2)(3,6), (2,3,6), 
      <identity partial perm on [ 2, 3 ]>, (2,3), 
      <identity partial perm on [ 6 ]>, <empty partial perm> ] ]
gap> CharacterTableOfInverseSemigroup(S[9]);
[ [ [ 1, 1, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 1, -1, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 4, 0, 1, -1, 0, 0, 0, 0, 0, 0 ], [ 4, 0, 1, 1, 0, 0, 0, 0, 0, 0 ], 
      [ 4, -2, 2, 0, 1, -1, 0, 0, 0, 0 ], [ 4, 2, 2, 0, 1, 1, 0, 0, 0, 0 ], 
      [ 2, 0, 1, -1, 0, 0, 1, -1, 0, 0 ], [ 2, 0, 1, 1, 0, 0, 1, 1, 0, 0 ], 
      [ 4, 0, 3, 1, 2, 0, 2, 0, 1, 0 ], [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ] ], 
  [ <identity partial perm on [ 1, 2, 3, 5 ]>, (1,5)(2,3), 
      <identity partial perm on [ 1, 3, 5 ]>, (1)(3,5), 
      <identity partial perm on [ 1, 3 ]>, (1,3), 
      <identity partial perm on [ 3, 5 ]>, (3,5), 
      <identity partial perm on [ 3 ]>, <empty partial perm> ] ]
gap> CharacterTableOfInverseSemigroup(S[10]);
[ [ [ 1, 0, 0, 0, 0 ], [ 2, 1, 0, 0, 0 ], [ 3, 2, 1, 0, 0 ], 
      [ 4, 3, 2, 1, 0 ], [ 1, 1, 1, 1, 1 ] ], 
  [ <identity partial perm on [ 1, 2, 3, 4 ]>, 
      <identity partial perm on [ 1, 2, 4 ]>, 
      <identity partial perm on [ 1, 4 ]>, <identity partial perm on [ 4 ]>, 
      <empty partial perm> ] ]
gap> CharacterTableOfInverseSemigroup(S[1]);
[ [ [ 1, 0, 0, 0 ], [ 2, 1, 0, 0 ], [ 1, 1, 1, -1 ], [ 1, 1, 1, 1 ] ], 
  [ <identity partial perm on [ 1, 3, 4, 5, 8, 9, 10 ]>, 
      <identity partial perm on [ 1, 3, 4, 8, 10 ]>, 
      <identity partial perm on [ 1, 3, 4, 8 ]>, (1)(3)(4,8) ] ]
gap> CharacterTableOfInverseSemigroup(S[2]);
[ [ [ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 1, 1, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 2, 2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 2, 4, 4, 2, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 3, 3, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 4, 3, 3, 2, 2, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 4, 3, 3, 2, 2, 1, 0, 0, 1, E(3)^2, E(3), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 
         ], [ 4, 3, 3, 2, 2, 1, 0, 0, 1, E(3), E(3)^2, 0, 0, 0, 0, 0, 0, 0, 
          0, 0, 0 ], 
      [ 1, 1, 3, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, -1, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 19, 19, 20, 10, 10, 9, 4, 4, 4, 1, 1, 4, 3, -1, 1, -1, 1, 0, 0, 0, 0 ]
        , [ 38, 38, 40, 20, 20, 18, 8, 8, 8, -1, -1, 8, 6, 0, 2, 0, -1, 0, 0, 
          0, 0 ], 
      [ 19, 19, 20, 10, 10, 9, 4, 4, 4, 1, 1, 4, 3, 1, 1, 1, 1, 0, 0, 0, 0 ], 
      [ 15, 15, 15, 10, 10, 10, 6, 6, 6, 0, 0, 6, 6, 0, 3, -1, 0, 1, -1, 0, 0 
         ], [ 15, 15, 15, 10, 10, 10, 6, 6, 6, 0, 0, 6, 6, 2, 3, 1, 0, 1, 1, 
          0, 0 ], 
      [ 6, 6, 6, 5, 5, 5, 4, 4, 4, 1, 1, 4, 4, 2, 3, 1, 0, 2, 0, 1, 0 ], 
      [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ] ], 
  [ <identity partial perm on [ 3, 4, 5, 6, 7, 8 ]>, 
      <identity partial perm on [ 1, 2, 3, 4, 6, 7 ]>, 
      <identity partial perm on [ 1, 2, 4, 5, 6, 7 ]>, 
      <identity partial perm on [ 2, 3, 5, 6, 8 ]>, 
      <identity partial perm on [ 3, 5, 6, 7, 8 ]>, 
      <identity partial perm on [ 3, 4, 6, 7, 8 ]>, 
      <identity partial perm on [ 1, 2, 5, 7 ]>, 
      <identity partial perm on [ 4, 5, 6, 7 ]>, 
      <identity partial perm on [ 2, 3, 6, 7 ]>, (2)(3,6,7), (2)(3,7,6), 
      <identity partial perm on [ 2, 4, 5, 7 ]>, 
      <identity partial perm on [ 1, 2, 3, 4 ]>, (1)(2,4)(3), 
      <identity partial perm on [ 5, 6, 7 ]>, (5)(6,7), (5,6,7), 
      <identity partial perm on [ 2, 4 ]>, (2,4), 
      <identity partial perm on [ 7 ]>, <empty partial perm> ] ]
gap> CharacterTableOfInverseSemigroup(S[3]);
[ [ [ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 6, 6, 4, 2, 2, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 0, 1, 0, 1, 0, 0, 0, 0, 1, -1, 0, 0, 0, 0, 0 ], 
      [ 0, 1, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0 ], 
      [ 2, 2, 0, 0, 1, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0 ], 
      [ 10, 10, 6, 6, 6, 6, 3, 3, 3, -1, 3, 1, -1, 0, 0 ], 
      [ 10, 10, 6, 6, 6, 6, 3, 3, 3, 1, 3, 1, 1, 0, 0 ], 
      [ 5, 5, 4, 4, 4, 4, 3, 3, 3, 1, 3, 2, 0, 1, 0 ], 
      [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ] ], 
  [ <identity partial perm on [ 1, 2, 3, 4, 7 ]>, 
      <identity partial perm on [ 1, 2, 5, 6, 7 ]>, 
      <identity partial perm on [ 1, 2, 3, 7 ]>, 
      <identity partial perm on [ 1, 3, 4, 6 ]>, 
      <identity partial perm on [ 1, 5, 6, 7 ]>, 
      <identity partial perm on [ 2, 3, 4, 7 ]>, 
      <identity partial perm on [ 1, 2, 7 ]>, 
      <identity partial perm on [ 3, 6, 7 ]>, 
      <identity partial perm on [ 1, 3, 6 ]>, (1,6)(3), 
      <identity partial perm on [ 2, 4, 7 ]>, 
      <identity partial perm on [ 3, 7 ]>, (3,7), 
      <identity partial perm on [ 6 ]>, <empty partial perm> ] ]
gap> CharacterTableOfInverseSemigroup(S[4]);
[ [ [ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 4, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 2, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 2, 1, 0, 0, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 0, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 20, 9, 10, 4, 4, 0, 4, 3, 4, 1, -1, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 20, 9, 10, 4, 4, 0, 4, 3, 4, 1, 1, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0 ], 
      [ 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, E(3)^2, E(3), 0, 0, 0, 0 ], 
      [ 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, E(3), E(3)^2, 0, 0, 0, 0 ], 
      [ 15, 10, 10, 6, 6, -2, 6, 6, 6, 3, -1, 3, 0, 0, 1, -1, 0, 0 ], 
      [ 15, 10, 10, 6, 6, 2, 6, 6, 6, 3, 1, 3, 0, 0, 1, 1, 0, 0 ], 
      [ 6, 5, 5, 4, 4, 0, 4, 4, 4, 3, 1, 3, 0, 0, 2, 0, 1, 0 ], 
      [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ] ], 
  [ <identity partial perm on [ 1, 3, 4, 5, 6, 7 ]>, 
      <identity partial perm on [ 1, 2, 3, 4, 6 ]>, 
      <identity partial perm on [ 1, 4, 5, 6, 7 ]>, 
      <identity partial perm on [ 1, 4, 6, 7 ]>, 
      <identity partial perm on [ 1, 2, 5, 6 ]>, (1,5)(2,6), 
      <identity partial perm on [ 1, 2, 4, 7 ]>, 
      <identity partial perm on [ 2, 3, 4, 6 ]>, 
      <identity partial perm on [ 1, 2, 4, 6 ]>, 
      <identity partial perm on [ 1, 4, 6 ]>, (1,6)(4), 
      <identity partial perm on [ 2, 3, 4 ]>, (2,3,4), (2,4,3), 
      <identity partial perm on [ 1, 2 ]>, (1,2), 
      <identity partial perm on [ 1 ]>, <empty partial perm> ] ]
gap> CharacterTableOfInverseSemigroup(S[5]);
[ [ [ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 7, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 5, 2, 0, 1, 0, 0, 0, 0, 0, 0, 0 ]
        , [ 19, 10, 4, 4, 1, 1, 1, 0, 0, 0, 0 ], 
      [ 19, 10, 4, 4, 1, E(3)^2, E(3), 0, 0, 0, 0 ], 
      [ 19, 10, 4, 4, 1, E(3), E(3)^2, 0, 0, 0, 0 ], 
      [ 15, 10, 6, 6, 3, 0, 0, 1, -1, 0, 0 ], 
      [ 15, 10, 6, 6, 3, 0, 0, 1, 1, 0, 0 ], 
      [ 6, 5, 4, 4, 3, 0, 0, 2, 0, 1, 0 ], 
      [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ] ], 
  [ <identity partial perm on [ 1, 2, 3, 5, 6, 7 ]>, 
      <identity partial perm on [ 1, 3, 4, 5, 7 ]>, 
      <identity partial perm on [ 1, 2, 3, 4 ]>, 
      <identity partial perm on [ 1, 3, 5, 6 ]>, 
      <identity partial perm on [ 4, 5, 7 ]>, (4,5,7), (4,7,5), 
      <identity partial perm on [ 3, 4 ]>, (3,4), 
      <identity partial perm on [ 4 ]>, <empty partial perm> ] ]
gap> CharacterTableOfInverseSemigroup(S[6]);
[ [ [ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
      [ 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
      [ 2, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
      [ 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
      [ 2, 0, 2, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
      [ 2, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
      [ 2, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
      [ 1, 2, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
      [ 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
      [ 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
      [ 1, 4, 1, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
      [ 4, 6, 4, 1, 2, 1, 1, 1, 3, 2, 1, 0, 1, -1, 1, 0, 0, 0, 0, 0, 0, 0, 0 ]
        , [ 8, 12, 8, 2, 4, 2, 2, 2, 6, 4, 2, 0, 2, 0, -1, 0, 0, 0, 0, 0, 0, 
          0, 0 ], 
      [ 4, 6, 4, 1, 2, 1, 1, 1, 3, 2, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0 ],
      [ 5, 2, 3, 2, 2, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 ],
      [ 3, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 ],
      [ 3, 1, 2, 1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 ],
      [ 2, 1, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0 ],
      [ 21, 15, 15, 10, 10, 6, 6, 6, 6, 6, 6, 3, 3, -1, 0, 3, 3, 3, 3, 1, -1, 
          0, 0 ], 
      [ 21, 15, 15, 10, 10, 6, 6, 6, 6, 6, 6, 3, 3, 1, 0, 3, 3, 3, 3, 1, 1, 
          0, 0 ], 
      [ 7, 6, 6, 5, 5, 4, 4, 4, 4, 4, 4, 3, 3, 1, 0, 3, 3, 3, 3, 2, 0, 1, 0 ],
      [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ] 
     ], 
  [ <identity partial perm on [ 1, 2, 5, 6, 7, 9, 10 ]>, 
      <identity partial perm on [ 1, 2, 4, 6, 8, 9 ]>, 
      <identity partial perm on [ 2, 3, 7, 8, 9, 10 ]>, 
      <identity partial perm on [ 1, 5, 6, 7, 10 ]>, 
      <identity partial perm on [ 1, 2, 5, 7, 10 ]>, 
      <identity partial perm on [ 3, 7, 9, 10 ]>, 
      <identity partial perm on [ 1, 4, 7, 8 ]>, 
      <identity partial perm on [ 1, 4, 5, 9 ]>, 
      <identity partial perm on [ 1, 2, 8, 9 ]>, 
      <identity partial perm on [ 2, 3, 7, 9 ]>, 
      <identity partial perm on [ 2, 4, 6, 8 ]>, 
      <identity partial perm on [ 6, 8, 9 ]>, 
      <identity partial perm on [ 1, 3, 4 ]>, (1)(3,4), (1,3,4), 
      <identity partial perm on [ 5, 7, 9 ]>, 
      <identity partial perm on [ 1, 5, 10 ]>, 
      <identity partial perm on [ 3, 6, 9 ]>, 
      <identity partial perm on [ 4, 5, 9 ]>, 
      <identity partial perm on [ 6, 9 ]>, (6,9), 
      <identity partial perm on [ 7 ]>, <empty partial perm> ] ]
gap> CharacterTableOfInverseSemigroup(S[7]);
[ [ [ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 1, 0, 1, 1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 1, 0, 1, -1, -E(4), E(4), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 1, 0, 1, -1, E(4), -E(4), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 6, 2, 4, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 4, 2, 2, -2, 0, 0, 0, 1, 1, -1, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 4, 2, 2, 2, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 10, 5, 4, 0, 0, 0, 1, 2, 0, 0, 1, 0, 0, 0, 0, 0, 0 ], 
      [ 5, 1, 4, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0 ], 
      [ 3, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0 ], 
      [ 20, 10, 10, -2, 0, 0, 6, 6, 3, -1, 3, 3, 3, 1, -1, 0, 0 ], 
      [ 20, 10, 10, 2, 0, 0, 6, 6, 3, 1, 3, 3, 3, 1, 1, 0, 0 ], 
      [ 7, 5, 5, 1, 1, 1, 4, 4, 3, 1, 3, 3, 3, 2, 0, 1, 0 ], 
      [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ] ], 
  [ <identity partial perm on [ 1, 2, 4, 5, 7, 8, 9 ]>, 
      <identity partial perm on [ 1, 2, 4, 6, 7 ]>, 
      <identity partial perm on [ 1, 2, 4, 5, 7 ]>, (1)(2,4)(5,7), 
      (1)(2,5,4,7), (1)(2,7,4,5), <identity partial perm on [ 3, 4, 5, 7 ]>, 
      <identity partial perm on [ 1, 2, 5, 7 ]>, 
      <identity partial perm on [ 2, 4, 6 ]>, (2,4)(6), 
      <identity partial perm on [ 3, 4, 5 ]>, 
      <identity partial perm on [ 2, 4, 7 ]>, 
      <identity partial perm on [ 3, 5, 7 ]>, 
      <identity partial perm on [ 3, 6 ]>, (3,6), 
      <identity partial perm on [ 7 ]>, <empty partial perm> ] ]
gap> CharacterTableOfInverseSemigroup(S[8]);
[ [ [ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 1, 1, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 2, 0, 1, 0, 0, 0, 0, 0, 0, 0 ], [ 7, 4, 3, 1, -1, 1, 0, 0, 0, 0 ], 
      [ 14, 8, 6, 2, 0, -1, 0, 0, 0, 0 ], [ 7, 4, 3, 1, 1, 1, 0, 0, 0, 0 ], 
      [ 10, 6, 6, 3, -1, 0, 1, -1, 0, 0 ], [ 10, 6, 6, 3, 1, 0, 1, 1, 0, 0 ], 
      [ 5, 4, 4, 3, 1, 0, 2, 0, 1, 0 ], [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ] ], 
  [ <identity partial perm on [ 2, 3, 4, 5, 6 ]>, 
      <identity partial perm on [ 1, 2, 3, 6 ]>, 
      <identity partial perm on [ 2, 3, 4, 6 ]>, 
      <identity partial perm on [ 2, 3, 6 ]>, (2)(3,6), (2,3,6), 
      <identity partial perm on [ 2, 3 ]>, (2,3), 
      <identity partial perm on [ 6 ]>, <empty partial perm> ] ]
gap> CharacterTableOfInverseSemigroup(S[9]);
[ [ [ 1, 1, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 1, -1, 0, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 4, 0, 1, -1, 0, 0, 0, 0, 0, 0 ], [ 4, 0, 1, 1, 0, 0, 0, 0, 0, 0 ], 
      [ 4, -2, 2, 0, 1, -1, 0, 0, 0, 0 ], [ 4, 2, 2, 0, 1, 1, 0, 0, 0, 0 ], 
      [ 2, 0, 1, -1, 0, 0, 1, -1, 0, 0 ], [ 2, 0, 1, 1, 0, 0, 1, 1, 0, 0 ], 
      [ 4, 0, 3, 1, 2, 0, 2, 0, 1, 0 ], [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ] ], 
  [ <identity partial perm on [ 1, 2, 3, 5 ]>, (1,5)(2,3), 
      <identity partial perm on [ 1, 3, 5 ]>, (1)(3,5), 
      <identity partial perm on [ 1, 3 ]>, (1,3), 
      <identity partial perm on [ 3, 5 ]>, (3,5), 
      <identity partial perm on [ 3 ]>, <empty partial perm> ] ]
gap> CharacterTableOfInverseSemigroup(S[10]);
[ [ [ 1, 0, 0, 0, 0 ], [ 2, 1, 0, 0, 0 ], [ 3, 2, 1, 0, 0 ], 
      [ 4, 3, 2, 1, 0 ], [ 1, 1, 1, 1, 1 ] ], 
  [ <identity partial perm on [ 1, 2, 3, 4 ]>, 
      <identity partial perm on [ 1, 2, 4 ]>, 
      <identity partial perm on [ 1, 4 ]>, <identity partial perm on [ 4 ]>, 
      <empty partial perm> ] ]

#T# attributes-inverse: NaturalPartialOrder (for a semigroup), works, 1/1
gap> S := InverseSemigroup( [ Bipartition( [ [ 1, -3 ], [ 2, -1 ], [ 3, 4, -2, -4 ] ] ),
>  Bipartition( [ [ 1, -1 ], [ 2, -3 ], [ 3, -2 ], [ 4, -4 ] ] ) ] );
<inverse bipartition semigroup of degree 4 with 2 generators>
gap> NaturalPartialOrder(AsTransformationSemigroup(S));
[ [  ], [ 1 ], [ 1 ], [ 1 ], [ 1 ], [ 1, 4, 5 ], [ 1 ], [ 1, 4, 7 ], [ 1 ], 
  [ 1, 2, 9 ], [ 1, 3, 9 ], [ 1 ], [ 1, 4, 12 ], [ 1, 4, 7, 8, 12, 13 ], 
  [ 1 ], [ 1, 4, 15 ], [ 1, 4, 5, 6, 15, 16 ], [ 1 ], [ 1, 2, 18 ], 
  [ 1, 3, 18 ] ]

#T# attributes-inverse: NaturalPartialOrder (for a semigroup), error, 1/2
gap> S := Semigroup(
> [ TropicalMinPlusMatrixNC([[infinity, 0, infinity, 1, 1, infinity, 3, 2, 3],
>      [3, 1, 1, infinity, 1, 1, 1, 1, 1], [0, 3, 0, 1, 1, 3, 0, infinity, 1],
>      [0, 0, 1, infinity, infinity, 3, 3, 2, 1], [1, 1, 0, 3, 0, 3, 0, 0, 3],
>      [0, 2, 3, 1, 0, 0, infinity, 3, infinity],
>      [1, 2, 3, 3, 1, 2, infinity, infinity, 3],
>      [1, 1, infinity, 3, 3, 1, 1, 1, 1], [1, 2, 0, infinity, 0, 0, 1, 1, 2]
>       ], 3) ] );
<commutative semigroup of 9x9 tropical min-plus matrices with 1 generator>
gap> NaturalPartialOrder(S);
Error, Semigroups: NaturalPartialOrder: usage,
the argument is not an inverse semigroup,

#T# attributes-inverse: NaturalPartialOrder (for a semigroup), error, 2/2
gap> NaturalPartialOrder(FreeInverseSemigroup(2));
Error, Semigroups: NaturalPartialOrder: usage,
the argument is not a finite semigroup,

#T# attributes-inverse: NaturalLeqInverseSemigroup (for a semigroup), error, 1/2
gap> S := Semigroup( [ PBR(
>      [ [ -4, -3, -2, -1, 1, 4, 5, 6 ], [ -6, -5, -4, -3, -2, 2, 6 ], [ -6, -4, 
> -3, -1, 1, 2, 4, 5, 6 ], [ -6, 2, 3, 4 ], [ -4, -2, 3, 6 ], [ -6, -3, 1, 3, 4,
> 6 ] ], [ [ -5, -2, -1, 3, 4 ], [ -5, -2, 1, 3, 5 ], [ -6, -4, -2, 2, 3, 4, 6 
> ], [ -5, -3, -1, 2, 4, 6 ], [ -6, -3, 1, 2, 3, 4, 6 ], [ -6, -3, 2, 6 ] ]),
>  PBR([ [ -6, -5, -3, -2, -1, 3, 6 ], [ -6, -2, 1, 2, 5 ], [ -6, -5, -4, -1, 1
> , 6 ], [ -6, -5, -4, -2, -1, 2, 5 ], [ -6, -2, -1, 1, 2, 4, 5 ], [ -6, -5, 3, 
> 4, 6 ] ],
>        [ [ -2, 1, 2, 3, 5, 6 ], [ -6, -5, -4, -3, -2, 1, 3, 5 ], [ -6, -4, -3
> , -1, 2, 5, 6 ], [ -5, -2, 3, 4, 5 ], [ -6, -5, -4, -3, -2, 1, 2, 3, 5, 6 ], [
> -4, 2, 3, 4, 5, 6 ] ]) ] );
<pbr semigroup of degree 6 with 2 generators>
gap> NaturalLeqInverseSemigroup(S);
Error, Semigroups: NaturalLeqInverseSemigroup: usage,
the argument is not an inverse semigroup,

#T# attributes-inverse: NaturalLeqInverseSemigroup (for a semigroup), error, 2/2
gap> NaturalLeqInverseSemigroup(FreeInverseSemigroup(2));
Error, Semigroups: NaturalLeqInverseSemigroup: usage,
the argument is not a finite semigroup,

#T# attributes-inverse: IsGreensDLeq (for an inverse op acting semigroup), 1/1
gap> S := InverseSemigroup(
> [ Bipartition( [ [ 1, -3 ], [ 2, -1 ], [ 3, 4, 5, -2, -4, -5 ] ] ),
>   Bipartition( [ [ 1, -1 ], [ 2, -3 ], [ 3, -4 ], [ 4, 5, -2, -5 ] ] ) ] );
<inverse bipartition semigroup of degree 5 with 2 generators>
gap> Size(S);
39
gap> foo := IsGreensDLeq(S);;
gap> foo(S.1, S.2);
false
gap> foo(S.2, S.1);
true

#T# attributes-inverse: PrimitiveIdempotents, inverse, 1/2
gap> S := InverseSemigroup( [ PartialPerm( [ 1, 2 ], [ 3, 1 ] ),
>  PartialPerm( [ 1, 2, 3 ], [ 1, 3, 4 ] ) ] );;
gap> Set(PrimitiveIdempotents(S));
[ <identity partial perm on [ 1 ]>, <identity partial perm on [ 2 ]>, 
  <identity partial perm on [ 3 ]>, <identity partial perm on [ 4 ]> ]

#T# attributes-inverse: PrimitiveIdempotents, inverse, 2/2
gap> S := InverseSemigroup(
> [ PartialPerm( [ 1, 2, 3, 5, 6, 11, 12 ], [ 4, 3, 7, 5, 1, 11, 12 ] ),
>   PartialPerm( [ 1, 3, 4, 5, 6, 7, 11, 12 ], [ 6, 7, 5, 3, 1, 4, 11, 12 ] ),
>   PartialPerm( [ 11, 12 ], [ 12, 11 ] ) ] );;
gap> PrimitiveIdempotents(S);
[ <identity partial perm on [ 11, 12 ]> ]

#T# attributes-inverse: PrimitiveIdempotents, semigroup, error, 1/2
gap> PrimitiveIdempotents(FreeSemigroup(2));
Error, Semigroups: PrimitiveIdempotents: usage,
the argument is not a finite semigroup,

#T# attributes-inverse: PrimitiveIdempotents, semigroup, error, 2/2
gap> PrimitiveIdempotents(FreeBand(2));
Error, Semigroups: PrimitiveIdempotents: usage,
the argument is not an inverse semigroup,

#T# attributes-inverse: IsJoinIrreducible, 1/4
gap> S := InverseSemigroup([
>  PartialPerm( [ 1, 2, 3, 4 ], [ 4, 1, 2, 6 ] ),
>  PartialPerm( [ 1, 2, 3, 4 ], [ 5, 7, 1, 6 ] ),
>  PartialPerm( [ 1, 2, 3, 5 ], [ 5, 2, 7, 3 ] ),
>  PartialPerm( [ 1, 2, 3, 6, 7 ], [ 1, 3, 4, 7, 5 ] ),
>  PartialPerm( [ 1, 2, 3, 4, 5, 7 ], [ 3, 2, 4, 6, 1, 5 ] ) ]);;
gap> I := SemigroupIdeal(S,
> PartialPerm( [ 1, 3, 4, 5, 7 ],[ 1, 3, 4, 5, 7 ] ));;
gap> x := PartialPerm( [ 1, 2, 4, 6 ], [ 2, 3, 1, 4 ] );;
gap> x in S;
true
gap> IsJoinIrreducible(S, x);
false
gap> x in I;
true
gap> IsJoinIrreducible(S, RandomBipartition(1));
Error, Semigroups: IsJoinIrreducible: usage,
the second argument <x> is not an element of the first,
gap> IsJoinIrreducible(S, MultiplicativeZero(S));
false

#T# attributes-inverse: IsJoinIrreducible, 2/4
gap> S := InverseSemigroup(
> [ PartialPerm( [ 1, 2, 3, 5, 6, 11, 12 ], [ 4, 3, 7, 5, 1, 11, 12 ] ),
>   PartialPerm( [ 1, 3, 4, 5, 6, 7, 11, 12 ], [ 6, 7, 5, 3, 1, 4, 11, 12 ] ),
>   PartialPerm( [ 11, 12 ], [ 12, 11 ] ) ] );;
gap> IsJoinIrreducible(S, PrimitiveIdempotents(S)[1]);
true

#T# attributes-inverse: IsJoinIrreducible, 3/4
gap> S := DualSymmetricInverseMonoid(3);
<inverse bipartition monoid of degree 3 with 3 generators>
gap> x := Bipartition([[ 1, 2, -1, -2 ], [ 3, -3 ]]);;
gap> IsJoinIrreducible(S, x);
true

#T# attributes-inverse: IsJoinIrreducible, 4/4
gap> S := InverseSemigroup([
>  PartialPerm( [ 1, 2, 4, 6], [2, 1, 4, 6]), 
>  PartialPerm( [ 1, 2, 3, 4 ], [ 4, 1, 2, 6 ] ),
>  PartialPerm( [ 1, 2, 3, 4 ], [ 5, 7, 1, 6 ] ),
>  PartialPerm( [ 1, 2, 3, 5 ], [ 5, 2, 7, 3 ] ),
>  PartialPerm( [ 1, 2, 3, 6, 7 ], [ 1, 3, 4, 7, 5 ] ),
>  PartialPerm( [ 1, 2, 3, 4, 5, 7 ], [ 3, 2, 4, 6, 1, 5 ] ) ]);;
gap> x := PartialPerm( [ 1, 2, 4, 6 ], [ 2, 3, 1, 4 ] );;
gap> IsJoinIrreducible(S, x);
false

#T# attributes-inverse: IsMajorantlyClosed, 1/1
gap> S := DualSymmetricInverseMonoid(3);
<inverse bipartition monoid of degree 3 with 3 generators>
gap> Size(S);
25
gap> T := InverseMonoid( [ Bipartition( [ [ 1, -1 ], [ 2, 3, -2, -3 ] ] ),
>  Bipartition( [ [ 1, -2 ], [ 2, 3, -1, -3 ] ] ) ] );
<inverse bipartition monoid of degree 3 with 2 generators>
gap> IsMajorantlyClosed(S, T);
false
gap> IsMajorantlyClosed(S, S);
true
gap> IsMajorantlyClosed(T, S);
Error, Semigroups: IsMajorantlyClosed: usage,
the second argument is not a subsemigroup of the first,
gap> IsMajorantlyClosed(S, Elements(T));
false
gap> IsMajorantlyClosed(S, Elements(S));
true
gap> IsMajorantlyClosed(T, Elements(S));
Error, Semigroups: IsMajorantlyClosed: usage,
the second argument should be a subset of the first,
gap> IsMajorantlyClosed(S, [One(S)]);
true

#T# attributes-inverse: JoinIrreducibleDClasses, partial perms, 1/2
gap> S := InverseSemigroup( [ PartialPerm( [ 1, 2, 3, 4 ], [ 2, 4, 1, 5 ] ),
>  PartialPerm( [ 1, 3, 5 ], [ 5, 1, 3 ] ) ] );;
gap> JoinIrreducibleDClasses(S)[1] = DClass(S, PartialPerm([3], [3]));
true

#T# attributes-inverse: JoinIrreducibleDClasses, partial perms, 1/2
gap> S := InverseSemigroup( [ PartialPerm( [ 1, 2, 3, 4 ], [ 2, 4, 1, 5 ] ),
>  PartialPerm( [ 1, 3, 5 ], [ 5, 1, 3 ] ) ] );;
gap> JoinIrreducibleDClasses(S)[1] = DClass(S, PartialPerm([3], [3]));
true

#T# attributes-inverse: JoinIrreducibleDClasses, inverse op, 1/?
gap> S := InverseMonoid( [ Bipartition( [ [ 1, 2, 5, -2, -3, -5 ], [ 3, 4, -1, -4 ] ] ),
>  Bipartition( [ [ 1, 4, -5 ], [ 2, 5, -1, -2, -3 ], [ 3, -4 ] ] ) ] );;
gap> jid := 
> [DClass(S, Bipartition([[ 1, 4, -1, -4 ], [ 2, 3, 5, -2, -3, -5 ]])),
>  DClass(S, Bipartition([[ 1, 2, 3, -1, -2, -3 ], [ 4, -4 ], [ 5, -5 ]]))];;
gap> JoinIrreducibleDClasses(S) = jid or JoinIrreducibleDClasses(S) = Set(jid);
true

#T# attributes-inverse: MajorantClosure, 1/1
gap> S := DualSymmetricInverseMonoid(3);
<inverse bipartition monoid of degree 3 with 3 generators>
gap> Size(S);
25
gap> T := InverseMonoid( [ Bipartition( [ [ 1, -1 ], [ 2, 3, -2, -3 ] ] ),
>  Bipartition( [ [ 1, -2 ], [ 2, 3, -1, -3 ] ] ) ] );
<inverse bipartition monoid of degree 3 with 2 generators>
gap> MajorantClosure(S, T);
[ <block bijection: [ 1, 2, 3, -1, -2, -3 ]>, 
  <block bijection: [ 1, 3, -1, -3 ], [ 2, -2 ]>, 
  <block bijection: [ 1, 3, -2, -3 ], [ 2, -1 ]>, 
  <block bijection: [ 1, -1 ], [ 2, 3, -2, -3 ]>, 
  <block bijection: [ 1, -2 ], [ 2, 3, -1, -3 ]>, 
  <block bijection: [ 1, -1 ], [ 2, -2 ], [ 3, -3 ]>, 
  <block bijection: [ 1, 2, -1, -2 ], [ 3, -3 ]>, 
  <block bijection: [ 1, 2, -1, -3 ], [ 3, -2 ]>, 
  <block bijection: [ 1, 2, -1 ], [ 3, -2, -3 ]>, 
  <block bijection: [ 1, 2, -2, -3 ], [ 3, -1 ]>, 
  <block bijection: [ 1, 2, -2 ], [ 3, -1, -3 ]>, 
  <block bijection: [ 1, 2, -3 ], [ 3, -1, -2 ]>, 
  <block bijection: [ 1, 3, -1, -2 ], [ 2, -3 ]>, 
  <block bijection: [ 1, 3, -1 ], [ 2, -2, -3 ]>, 
  <block bijection: [ 1, 3, -2 ], [ 2, -1, -3 ]>, 
  <block bijection: [ 1, 3, -3 ], [ 2, -1, -2 ]>, 
  <block bijection: [ 1, -1, -2 ], [ 2, 3, -3 ]>, 
  <block bijection: [ 1, -1, -3 ], [ 2, 3, -2 ]>, 
  <block bijection: [ 1, -2, -3 ], [ 2, 3, -1 ]>, 
  <block bijection: [ 1, -3 ], [ 2, 3, -1, -2 ]>, 
  <block bijection: [ 1, -1 ], [ 2, -3 ], [ 3, -2 ]>, 
  <block bijection: [ 1, -2 ], [ 2, -1 ], [ 3, -3 ]>, 
  <block bijection: [ 1, -3 ], [ 2, -1 ], [ 3, -2 ]>, 
  <block bijection: [ 1, -2 ], [ 2, -3 ], [ 3, -1 ]>, 
  <block bijection: [ 1, -3 ], [ 2, -2 ], [ 3, -1 ]> ]
gap> MajorantClosure(T, S);
Error, Semigroups: MajorantClosure: usage,
the second argument is not a subset of the first,
gap> MajorantClosure(S, Elements(T));
[ <block bijection: [ 1, 2, 3, -1, -2, -3 ]>, 
  <block bijection: [ 1, 3, -1, -3 ], [ 2, -2 ]>, 
  <block bijection: [ 1, 3, -2, -3 ], [ 2, -1 ]>, 
  <block bijection: [ 1, -1 ], [ 2, 3, -2, -3 ]>, 
  <block bijection: [ 1, -2 ], [ 2, 3, -1, -3 ]>, 
  <block bijection: [ 1, -1 ], [ 2, -2 ], [ 3, -3 ]>, 
  <block bijection: [ 1, 2, -1, -2 ], [ 3, -3 ]>, 
  <block bijection: [ 1, 2, -1, -3 ], [ 3, -2 ]>, 
  <block bijection: [ 1, 2, -1 ], [ 3, -2, -3 ]>, 
  <block bijection: [ 1, 2, -2, -3 ], [ 3, -1 ]>, 
  <block bijection: [ 1, 2, -2 ], [ 3, -1, -3 ]>, 
  <block bijection: [ 1, 2, -3 ], [ 3, -1, -2 ]>, 
  <block bijection: [ 1, 3, -1, -2 ], [ 2, -3 ]>, 
  <block bijection: [ 1, 3, -1 ], [ 2, -2, -3 ]>, 
  <block bijection: [ 1, 3, -2 ], [ 2, -1, -3 ]>, 
  <block bijection: [ 1, 3, -3 ], [ 2, -1, -2 ]>, 
  <block bijection: [ 1, -1, -2 ], [ 2, 3, -3 ]>, 
  <block bijection: [ 1, -1, -3 ], [ 2, 3, -2 ]>, 
  <block bijection: [ 1, -2, -3 ], [ 2, 3, -1 ]>, 
  <block bijection: [ 1, -3 ], [ 2, 3, -1, -2 ]>, 
  <block bijection: [ 1, -1 ], [ 2, -3 ], [ 3, -2 ]>, 
  <block bijection: [ 1, -2 ], [ 2, -1 ], [ 3, -3 ]>, 
  <block bijection: [ 1, -3 ], [ 2, -1 ], [ 3, -2 ]>, 
  <block bijection: [ 1, -2 ], [ 2, -3 ], [ 3, -1 ]>, 
  <block bijection: [ 1, -3 ], [ 2, -2 ], [ 3, -1 ]> ]
gap> MajorantClosure(S, Elements(S)) = Elements(S); 
true
gap> MajorantClosure(T, Elements(S));
Error, Semigroups: MajorantClosure: usage,
the second argument is not a subset of the first,
gap> MajorantClosure(S, [One(S)]);
[ <block bijection: [ 1, -1 ], [ 2, -2 ], [ 3, -3 ]> ]

#T# attributes-inverse: RightCosetsOfInverseSemigroup, 1/2
gap> S := InverseMonoid( [ PartialPerm( [ 1, 2, 3, 4 ], [ 2, 4, 1, 5 ] ),
>  PartialPerm( [ 1, 3, 5 ], [ 5, 1, 3 ] ) ] );;
gap> T := InverseSemigroup(
> [ PartialPerm( [ 3 ], [ 4 ] ), PartialPerm( [ 1, 3, 5 ], [ 3, 5, 1 ] ) ] );;
gap> RightCosetsOfInverseSemigroup(S, T);
Error, Semigroups: RightCosetsOfInverseSemigroup: usage,
the second argument must be majorantly closed,
gap> RightCosetsOfInverseSemigroup(S, InverseSemigroup(MajorantClosure(S, T), rec(small := true)));
[ [ <empty partial perm>, <identity partial perm on [ 1 ]>, [1,2], [1,3], 
      [1,4], [1,5], [2,1], <identity partial perm on [ 2 ]>, [2,3], [2,4], 
      [2,5], <identity partial perm on [ 1, 2 ]>, [2,5](1), [1,2,4], [2,1,3], 
      [1,3][2,4], [1,4][2,5], [1,5][2,3], [3,1], [3,2], 
      <identity partial perm on [ 3 ]>, [3,4], [3,5], 
      <identity partial perm on [ 1, 3 ]>, 
      <identity partial perm on [ 1, 2, 3 ]>, [3,1,2], [3,1,2,4], [1,3,5], 
      [1,4][3,2], [1,4](3), [1,4][3,2,5], [3,1,5], [1,5][3,4], [4,1], [4,2], 
      [4,3], <identity partial perm on [ 4 ]>, [4,5], [3,1][4,2], [3,1][4,5], 
      [3,2](4), [4,1](3), <identity partial perm on [ 3, 4 ]>, [3,4,5], 
      [4,3,5], [4,2,1], [2,1][4,5], <identity partial perm on [ 2, 4 ]>, 
      [2,3][4,1], [2,3](4), [2,4,5], [2,5][4,3], 
      <identity partial perm on [ 1, 2, 4 ]>, 
      <identity partial perm on [ 1, 2, 3, 4 ]>, [1,2,4,5], [3,1,2,4,5], 
      [4,2,1,3], [5,1], [5,2], [5,3], [5,4], <identity partial perm on [ 5 ]>,
      [4,1][5,2], [4,1](5), [5,4,2], [4,3][5,1], [5,4,3], 
      <identity partial perm on [ 4, 5 ]>, [4,5,3], [5,3,1], [3,2][5,1], 
      <identity partial perm on [ 3, 5 ]>, [3,4][5,2], [5,3,4], [3,5,1], 
      [3,5,4], [5,4,2,1], <identity partial perm on [ 2, 4, 5 ]>, 
      [4,1][5,2,3], [5,2](1), <identity partial perm on [ 1, 5 ]>, 
      <identity partial perm on [ 1, 3, 5 ]>, 
      <identity partial perm on [ 1, 2, 4, 5 ]>, 
      <identity partial perm on [ 1, 2, 3, 4, 5 ]>, [1,2][5,4], [5,1,3], 
      [1,3][5,4], (1,3,5), [5,4,2,1,3], [1,4](5), [1,5,3], (1,5,3) ] ]
gap> T := InverseSemigroup( [ PartialPerm( [ 1, 2, 4, 6, 8 ], [ 2, 10, 3, 5, 7 ] ),
>  PartialPerm( [ 1, 3, 4, 5, 6, 7, 8 ], [ 4, 7, 6, 9, 10, 1, 3 ] ) ] );;
gap> RightCosetsOfInverseSemigroup(S, T);
Error, Semigroups: RightCosetsOfInverseSemigroup: usage,
the second argument should be a subsemigroup of the first,

#T# attributes-inverse: RightCosetsOfInverseSemigroup, 2/2
gap> S := InverseSemigroup([
>  PartialPerm( [ 1, 2, 3, 4 ], [ 4, 1, 2, 6 ] ),
>  PartialPerm( [ 1, 2, 3, 4 ], [ 5, 7, 1, 6 ] ),
>  PartialPerm( [ 1, 2, 3, 5 ], [ 5, 2, 7, 3 ] ),
>  PartialPerm( [ 1, 2, 3, 6, 7 ], [ 1, 3, 4, 7, 5 ] ),
>  PartialPerm( [ 1, 2, 3, 4, 5, 7 ], [ 3, 2, 4, 6, 1, 5 ] ) ]);;
gap> W := InverseSemigroup(MajorantClosure(S,
> [PartialPerm( [ 1, 2, 3, 4 ], [ 1, 2, 3, 4 ] )]));
<inverse partial perm semigroup of rank 7 with 5 generators>
gap> Set(RightCosetsOfInverseSemigroup(S, W));
[ [ <identity partial perm on [ 1, 2, 3, 4 ]>, 
      <identity partial perm on [ 1, 2, 3, 4, 5 ]>, 
      <identity partial perm on [ 1, 2, 3, 4, 6 ]>, 
      <identity partial perm on [ 1, 2, 3, 4, 5, 6 ]>, 
      <identity partial perm on [ 1, 2, 3, 4, 5, 7 ]> ], [ [2,5](1)(3)(4) ], 
  [ [4,3,2,7](1) ], [ [2,1,3,4,6] ], 
  [ [1,3,4,6](2), [5,1,3,4,6](2), [7,5,1,3,4,6](2) ], [ [1,3,5][4,7](2) ], 
  [ [1,3,2,5](4) ], [ [3,2,1,4,6] ], [ [3,1,4,5](2) ], 
  [ [4,3,1,5](2), [4,3,1,5,7](2), [6,4,3,1,5](2), [6,4,3,1,5,7](2) ], 
  [ [1,5][2,4,3,6] ], [ [2,7][4,3,1,5] ], [ [2,7][3,1,5][4,6] ], 
  [ [4,1,6](2)(3) ], [ [3,5][4,1,7](2), [4,1,7][6,3,5](2) ], [ [2,3,4,1,7] ], 
  [ [3,1,7][4,2,6] ] ]

#T# attributes-inverse: SupremumIdempotents, 1/1
gap> SupremumIdempotentsNC([], PartialPerm([]));
<empty partial perm>
gap> SupremumIdempotentsNC([], Bipartition([[1], [-1]]));
<bipartition: [ 1 ], [ -1 ]>
gap> SupremumIdempotentsNC([], RandomBipartition(1));
<block bijection: [ 1, -1 ]>
gap> SupremumIdempotentsNC(Idempotents(DualSymmetricInverseMonoid(3)),
> RandomBlockBijection(3));
<block bijection: [ 1, -1 ], [ 2, -2 ], [ 3, -3 ]>
gap> SupremumIdempotentsNC(Transformation([1,1]), 1);
Error, Semigroups: SupremumIdempotentsNC: usage,
the argument is not a collection of partial perms, block bijections,
or partial perm bipartitions,

#T# SEMIGROUPS_UnbindVariables
gap> Unbind(S);
gap> Unbind(iso);
gap> Unbind(h);
gap> Unbind(f);

#E#
gap> STOP_TEST("Semigroups package: standard/attributes/attributes-inverse.tst");