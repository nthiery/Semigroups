#############################################################################
##
#W  read.g
#Y  Copyright (C) 2013-15                                James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

BindGlobal("IsGrapeLoaded", IsPackageMarkedForLoading("grape", "4.5"));
BindGlobal("IsGrapeCompiled",
           ExternalFilename(DirectoriesPackagePrograms("grape"), "dreadnautB")
           <> fail);

if not IsGrapeLoaded then
  Add(SemigroupsOmitFromTestManualExamples, "SmallestMultiplicationTable");
  BindGlobal("GrapeIsNotLoadedString",
             Concatenation("the GRAPE package is not loaded and",
                           " so this function does not work"));
fi;

if not IsGrapeCompiled then
  Add(SemigroupsOmitFromTestManualExamples, "MaximalSubsemigroups");
  Add(SemigroupsOmitFromTestManualExamples, "MunnSemigroup");
  Add(SemigroupsOmitFromTestManualExamples, "IsIsomorphicSemigroup");
  Add(SemigroupsOmitFromTestManualExamples, "IsomorphismSemigroups");
  Add(SemigroupsOmitFromTestManualExamples, "RZMSInducedFunction");
  Add(SemigroupsOmitFromTestManualExamples, "RZMStoRZMSInducedFunction");
  BindGlobal("GrapeIsNotCompiledString",
             Concatenation("the nauty/dreadnaut binaries for the GRAPE ",
                           "package are not loaded\n#I  and so this function ",
                           "does not work"));
fi;

if TestPackageAvailability("genss") = fail then
  Add(SemigroupsOmitFromTestManualExamples, "Normalizer");
fi;

# Issue 5 for Orb:

if not IsBound(MappingPermListList_C) then
  BindGlobal("MappingPermListList_C",
  function(src, dst)
    local src_tab, dst_tab, d, out, next, i;

    if not IsList(src) or not IsList(dst) or Length(src) <> Length(dst)  then
       Error("Semigroups: MappingPermListList_C: usage,\n",
             "the arguments must be lists of equal length,");
       return;
    fi;

    if IsEmpty(src)  then
      return ();
    fi;
    src_tab := [];
    dst_tab := [];
    d := Maximum(Maximum(src), Maximum(dst));
    for i in [1 .. Length(src)] do
      src_tab[src[i]] := i;
    od;
    for i in [1 .. Length(dst)] do
      dst_tab[dst[i]] := i;
    od;
    out := EmptyPlist(d);
    next := 1;
    for i in [1 .. d] do
      if IsBound(src_tab[i]) then
        out[i] := dst[src_tab[i]];
      else
        while IsBound(dst_tab[next]) do
          next := next + 1;
        od;
        out[i] := next;
        next := next + 1;
      fi;
    od;

    return PermList(out);
  end);
fi;

ReadPackage("semigroups/gap/Elements/star.gi");
ReadPackage("semigroups/gap/Elements/pbr.gi");
ReadPackage("semigroups/gap/Elements/bipartition.gi");
ReadPackage("semigroups/gap/Elements/blocks.gi");
ReadPackage("semigroups/gap/Elements/matrix-semiring.gi");
ReadPackage("semigroups/gap/Elements/matrix-max-plus.gi");
ReadPackage("semigroups/gap/Elements/matrix-boolean.gi");
ReadPackage("semigroups/gap/Elements/matrix-prime-field.gi");

ReadPackage("semigroups/gap/Semigroups/semigroups.gi");
ReadPackage("semigroups/gap/Semigroups/froidure-pin.gi");
ReadPackage("semigroups/gap/Semigroups/grpperm.gi");
ReadPackage("semigroups/gap/Semigroups/reesmat.gi");
ReadPackage("semigroups/gap/Semigroups/semibipart.gi");
ReadPackage("semigroups/gap/Semigroups/semipperm.gi");
ReadPackage("semigroups/gap/Semigroups/semitrans.gi");
ReadPackage("semigroups/gap/Semigroups/semipbr.gi");
ReadPackage("semigroups/gap/Semigroups/semimaxplus.gi");
ReadPackage("semigroups/gap/Semigroups/semiringmat.gi");
ReadPackage("semigroups/gap/Semigroups/semiboolmat.gi");
ReadPackage("semigroups/gap/Semigroups/semipfmat.gi");
ReadPackage("semigroups/gap/Semigroups/examples.gi");

ReadPackage("semigroups/gap/Acting/setup.gi");
ReadPackage("semigroups/gap/Acting/acting.gi");
ReadPackage("semigroups/gap/Acting/lambda-rho.gi");
ReadPackage("semigroups/gap/Acting/graded.gi");
ReadPackage("semigroups/gap/Acting/orbits.gi");
ReadPackage("semigroups/gap/Acting/semigroups-acting.gi");

ReadPackage("semigroups/gap/Ideals/ideals.gi");
ReadPackage("semigroups/gap/Ideals/ideals-acting.gi");
ReadPackage("semigroups/gap/Ideals/ideals-lambda-rho.gi");
ReadPackage("semigroups/gap/Ideals/ideals-generic.gi");

ReadPackage("semigroups/gap/Tools/display.gi");
ReadPackage("semigroups/gap/Tools/enums.gi");
ReadPackage("semigroups/gap/Tools/io.gi");
ReadPackage("semigroups/gap/Tools/iterators.gi");
ReadPackage("semigroups/gap/Tools/utils.gi");

ReadPackage("semigroups/gap/Greens/greens-generic.gi");
ReadPackage("semigroups/gap/Greens/greens-acting.gi");
ReadPackage("semigroups/gap/Greens/greens-regular.gi");
ReadPackage("semigroups/gap/Greens/greens-inverse.gi");

ReadPackage("semigroups/gap/Attributes/attributes.gi");
ReadPackage("semigroups/gap/Attributes/attributes-acting.gi");
ReadPackage("semigroups/gap/Attributes/attributes-inverse.gi");
ReadPackage("semigroups/gap/Attributes/factor.gi");
ReadPackage("semigroups/gap/Attributes/isomorph.gi");
ReadPackage("semigroups/gap/Attributes/maximal.gi");
ReadPackage("semigroups/gap/Attributes/normalizer.gi");
ReadPackage("semigroups/gap/Attributes/properties.gi");
ReadPackage("semigroups/gap/Attributes/reesmat-iso.gi");

ReadPackage("semigroups/gap/Congruences/pairs-cong.gi");
ReadPackage("semigroups/gap/Congruences/reesmat-cong.gi");
ReadPackage("semigroups/gap/Congruences/univ-cong.gi");
ReadPackage("semigroups/gap/Congruences/inverse-cong.gi");
ReadPackage("semigroups/gap/Congruences/simple-cong.gi");
ReadPackage("semigroups/gap/Congruences/rees-cong.gi");
ReadPackage("semigroups/gap/Congruences/quotients.gi");

ReadPackage("semigroups/gap/Fp/fpsemi.gi");
ReadPackage("semigroups/gap/Fp/freeinverse.gi");
ReadPackage("semigroups/gap/Fp/freeband.gi");
