#############################################################################
##
#W  semipperm.gi
#Y  Copyright (C) 2013-14                                James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

InstallGlobalFunction(SEMIGROUPS_SubsetNumber,
function(m, k, n, set, min, nr, coeff)
  local i;

  nr := nr + 1;

  if k = 1 then
    set[nr] := m + min;
    return set;
  fi;

  i := 1;
  while m > coeff do
    m := m - coeff;
    coeff := coeff * (n - k - i + 1) / (n - i);
    # coeff = Binomial( n - i, k - 1 )
    i := i + 1;
  od;

  min := min + i;
  set[nr] := min;

  return SEMIGROUPS_SubsetNumber(m, k - 1, n - i, set, min, nr,
   coeff * (k - 1) / (n - i) );
   # coeff = Binomial( n - i - 1, k - 2 )
end);

# the first occurrence in the ordered list of <m>-subsets of [ 1 .. <n> ] of
# set with first element equal to <k>.

InstallGlobalFunction(SEMIGROUPS_NumberSubset,
function(n, k, m)
  return Sum( List( [ 1 .. k - 1 ], i -> Binomial( n - i, m - 1 ) ) );
end);

# the <m>th subset of <[1..n]> with <k> elements

InstallMethod(SubsetNumber, "for pos int, pos int, pos int",
[IsPosInt, IsPosInt, IsPosInt],
function(m, k, n)
  return SEMIGROUPS_SubsetNumber(m, k, n, EmptyPlist(k), 0, 0, Binomial( n - 1, k - 1 ));
end);

InstallMethod(SubsetNumber, "for pos int, pos int, pos int, pos int, pos int",
[IsPosInt, IsPosInt, IsPosInt, IsPosInt],
function(m, k, n, coeff)
  return SEMIGROUPS_SubsetNumber(m, k, n, EmptyPlist(k), 0, 0, coeff);
end);

# the position of <set> in the set of subsets of [ 1 .. <n> ]

InstallMethod(NumberSubset, "for a set and a pos int",
[IsList, IsPosInt],
function(set, n)
  local m, nr, pos, k, prev, i;

  nr := Sum( List( [ 0 .. Length(set) - 1 ], i -> Binomial( n, i ) ) );

  k := n;
  prev := 0;
  m := Length(set);

  for i in [ 1 .. Length(set) ] do
    pos := Position( [ prev + 1 .. n ], set[i]);
    nr := nr + SEMIGROUPS_NumberSubset( k, pos, m );
    k := k - set[i];
    prev := set[i];
    m := m - 1;
  od;

  return nr;
end);

InstallMethod(PartialPermNumber, "for pos int and pos int",
[IsPosInt, IsPosInt],
function(m, n)
  local i, base, coeff, j;

  if m = 1 then
    return PartialPermNC([]);
  fi;

  m := m - 1;
  i := 1;
  base := [ 1 .. n ];
  coeff := n ^ 2; # Binomial( n, 1 ) * NrArrangements([1..n], 1)

  while m > coeff do
    m := m - coeff;
    i := i + 1;
    coeff := Binomial( n, i ) * NrArrangements(base, i);
  od;

  j := 1;
  coeff := NrArrangements(base, i);
  while m > coeff do
    j := j + 1;
    m := m - coeff;
  od;
  return PartialPermNC(SubsetNumber(j, i, n), ArrangementNumber(m, i, n));
end);

InstallMethod(NumberPartialPerm, "for a partial perm and a pos int",
[IsPartialPerm, IsPosInt],
function(x, n)
  local dom, i;

  dom := DomainOfPartialPerm(x);
  i := Length(dom);

  if i = 0 then
    return 1;
  fi;

  return Sum(List([1 .. i], Binomial(n, i)))
   + ((NumberSubset(dom, n) - 1) * NrArrangements([1 .. 10], i))
   + NumberArrangement(ImageSetOfPartialPerm(x), n);
end);

InstallMethod(AsPartialPermSemigroup, "for a semigroup", [IsSemigroup],
function(S)
  return Range(IsomorphismPartialPermSemigroup(S));
end);

# the following method is required to beat the method for
# IsPartialPermCollection in the library.

InstallMethod(One, "for a partial perm semigroup ideal",
[IsPartialPermSemigroup and IsSemigroupIdeal],
function(I)
  local pts, x;

  if HasGeneratorsOfSemigroup(I) then
    return One(GeneratorsOfSemigroup(I));
  fi;

  pts := Union(ComponentsOfPartialPermSemigroup(I));
  x := PartialPermNC(pts, pts);

  if x in I then
    return x;
  fi;
  return fail;
end);

#

InstallMethod(CodegreeOfPartialPermSemigroup,
"for a partial perm semigroup ideal",
[IsPartialPermSemigroup and IsSemigroupIdeal],
function(I)
  return CodegreeOfPartialPermCollection(SupersemigroupOfIdeal(I));
end);

#

InstallMethod(DegreeOfPartialPermSemigroup,
"for a partial perm semigroup ideal",
[IsPartialPermSemigroup and IsSemigroupIdeal],
function(I)
  return DegreeOfPartialPermCollection(SupersemigroupOfIdeal(I));
end);

#

InstallMethod(RankOfPartialPermSemigroup,
"for a partial perm semigroup ideal",
[IsPartialPermSemigroup and IsSemigroupIdeal],
function(I)
  return RankOfPartialPermCollection(SupersemigroupOfIdeal(I));
end);

#

InstallMethod(DisplayString, "for a partial perm semigroup with generators",
[IsPartialPermSemigroup and IsSemigroupIdeal and HasGeneratorsOfSemigroupIdeal],
ViewString);

#

InstallMethod(ViewString, "for a partial perm semigroup with generators",
[IsPartialPermSemigroup and IsSemigroupIdeal and HasGeneratorsOfSemigroupIdeal],
function(I)
  local str, nrgens;

  str := "<";

  if HasIsTrivial(I) and IsTrivial(I) then
    Append(str, "trivial ");
  else
    if HasIsCommutative(I) and IsCommutative(I) then
      Append(str, "commutative ");
    fi;
  fi;

  if HasIsTrivial(I) and IsTrivial(I) then
  elif HasIsZeroSimpleSemigroup(I) and IsZeroSimpleSemigroup(I) then
    Append(str, "0-simple ");
  elif HasIsSimpleSemigroup(I) and IsSimpleSemigroup(I) then
    Append(str, "simple ");
  fi;

  if HasIsInverseSemigroup(I) and IsInverseSemigroup(I) then
    Append(str, "inverse ");
  elif HasIsRegularSemigroup(I)
   and not (HasIsSimpleSemigroup(I) and IsSimpleSemigroup(I)) then
    if IsRegularSemigroup(I) then
      Append(str, "\>regular\< ");
    else
      Append(str, "\>non-regular\< ");
    fi;
  fi;

  Append(str, "partial perm semigroup ideal ");
  Append(str, "\<\>on ");
  Append(str, String(RankOfPartialPermSemigroup(I)));
  Append(str, " pts\<\> with ");

  nrgens := Length(GeneratorsOfSemigroupIdeal(I));
  Append(str, String(nrgens));
  Append(str, " generator");

  if nrgens > 1 or nrgens = 0 then
    Append(str, "s");
  fi;
  Append(str, ">");

  return str;
end);

#

InstallMethod(CyclesOfPartialPerm, "for a partial perm", [IsPartialPerm],
function(f)
  local n, seen, out, i, j, cycle;

  n := Maximum(DegreeOfPartialPerm(f), CoDegreeOfPartialPerm(f));
  seen := BlistList([1 .. n], ImageSetOfPartialPerm(f));
  out := [];

  #find chains
  for i in DomainOfPartialPerm(f) do
    if not seen[i] then
      i := i ^ f;
      while i <> 0 do
        seen[i] := false;
        i := i ^ f;
      od;
    fi;
  od;

  #find cycles
  for i in DomainOfPartialPerm(f) do
    if seen[i] then
      j := i ^ f;
      cycle := [j];
      while j <> i do
        seen[j] := false;
        j := j ^ f;
        Add(cycle, j);
      od;
      Add(out, cycle);
    fi;
  od;
  return out;
end);

#

InstallMethod(ComponentRepsOfPartialPermSemigroup,
"for a partial perm semigroup", [IsPartialPermSemigroup],
function(S)
  local pts, reps, next, opts, gens, o, out, i;

  pts := [1 .. DegreeOfPartialPermSemigroup(S)];
  reps := BlistList(pts, []);
  # true=its a rep, false=not seen it, fail=its not a rep
  next := 1;
  opts := rec(lookingfor := function(o, x)
    if not IsEmpty(x) then
      return reps[x[1]] = true or reps[x[1]] = fail;
    else
      return false;
    fi;
  end);

  if IsSemigroupIdeal(S) then
    gens := GeneratorsOfSemigroup(SupersemigroupOfIdeal(S));
  else
    gens := GeneratorsOfSemigroup(S);
  fi;

  repeat
    o := Orb(gens, [next], OnSets, opts);
    Enumerate(o);
    if PositionOfFound(o) <> false and reps[o[PositionOfFound(o)][1]] = true then
      if not IsEmpty(o[PositionOfFound(o)]) then
        reps[o[PositionOfFound(o)][1]] := fail;
      fi;
    fi;
    reps[next] := true;
    for i in [2 .. Length(o)] do
      if not IsEmpty(o[i]) then
        reps[o[i][1]] := fail;
      fi;
    od;
    next := Position(reps, false, next);
  until next = fail;

  out := [];
  for i in pts do
    if reps[i] = true then
      Add(out, i);
    fi;
  od;

  return out;
end);

#

InstallMethod(ComponentsOfPartialPermSemigroup,
"for a partial perm semigroup", [IsPartialPermSemigroup],
function(S)
  local pts, comp, next, nr, opts, gens, o, out, i;

  pts := [1 .. DegreeOfPartialPermSemigroup(S)];
  comp := BlistList(pts, []);
  # integer=its component index, false=not seen it
  next := 1;  nr := 0;
  opts := rec(lookingfor := function(o, x)
    if not IsEmpty(x) then
      return IsPosInt(comp[x[1]]);
    else
      return false;
    fi;
  end);

  if IsSemigroupIdeal(S) then
    gens := GeneratorsOfSemigroup(SupersemigroupOfIdeal(S));
  else
    gens := GeneratorsOfSemigroup(S);
  fi;

  repeat
    o := Orb(gens, [next], OnSets, opts);
    Enumerate(o);
    if PositionOfFound(o) <> false then
      for i in o do
        if not IsEmpty(i) then
          comp[i[1]] := comp[o[PositionOfFound(o)][1]];
        fi;
      od;
    else
      nr := nr + 1;
      for i in o do
        if not IsEmpty(i) then
          comp[i[1]] := nr;
        fi;
      od;
    fi;
    next := Position(comp, false, next);
  until next = fail;

  out := [];
  for i in pts do
    if not IsBound(out[comp[i]]) then
      out[comp[i]] := [];
    fi;
    Add(out[comp[i]], i);
  od;

  return out;
end);

#

InstallMethod(CyclesOfPartialPermSemigroup,
"for a partial perm semigroup", [IsPartialPermSemigroup],
function(S)
  local pts, comp, next, nr, cycles, opts, gens, o, scc, i;

  pts := [1 .. DegreeOfPartialPermSemigroup(S)];
  comp := BlistList(pts, []);
  # integer=its component index, false=not seen it
  next := 1;  nr := 0; cycles := [];
  opts := rec(lookingfor := function(o, x)
    if not IsEmpty(x) then
      return IsPosInt(comp[x[1]]);
    else
      return false;
    fi;
  end);

  if IsSemigroupIdeal(S) then
    gens := GeneratorsOfSemigroup(SupersemigroupOfIdeal(S));
  else
    gens := GeneratorsOfSemigroup(S);
  fi;

  repeat
    #JDM the next line doesn't work if OnPoints is used...
    o := Orb(gens, [next], OnSets, opts);
    Enumerate(o);
    if PositionOfFound(o) <> false then
      for i in o do
        if not IsEmpty(i) then
          comp[i[1]] := comp[o[PositionOfFound(o)][1]];
        fi;
      od;
    else
      nr := nr + 1;
      for i in o do
        if not IsEmpty(i) then
          comp[i[1]] := nr;
        fi;
      od;
      scc := First(OrbSCC(o), x -> Length(x) > 1);
      if scc <> fail then
        Add(cycles, List(o{scc}, x -> x[1]));
      fi;
    fi;
    next := Position(comp, false, next);
  until next = fail;

  return cycles;
end);

#

InstallMethod(NaturalLeqInverseSemigroup, "for two partial perms",
[IsPartialPerm, IsPartialPerm], NaturalLeqPartialPerm);

#EOF