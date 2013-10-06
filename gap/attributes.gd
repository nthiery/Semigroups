#############################################################################
##
#W  attributes.gd
#Y  Copyright (C) 2013                                   James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

DeclareOperation("IsMaximalSubsemigroup", [IsSemigroup, IsSemigroup]);
DeclareOperation("IrredundantGeneratingSubset",
[IsAssociativeElementCollection]);
DeclareOperation("InversesOfSemigroupElementNC", [IsActingSemigroup and
HasGeneratorsOfSemigroup, IsAssociativeElement]);

DeclareAttribute("GroupOfUnits", IsSemigroup);
DeclareAttribute("IdempotentGeneratedSubsemigroup", IsSemigroup);
DeclareAttribute("InjectionPrincipalFactor", IsGreensDClass);
DeclareAttribute("IsomorphismReesMatrixSemigroup", IsGreensDClass);
DeclareAttribute("IsomorphismPermGroup", IsSemigroup and HasGeneratorsOfSemigroup);
DeclareAttribute("MinimalIdeal", IsSemigroup);
DeclareAttribute("PosetOfIdempotents", IsSemigroup);
DeclareAttribute("PrimitiveIdempotents", IsInverseSemigroup);
DeclareAttribute("PrincipalFactor", IsGreensDClass);
DeclareAttribute("MultiplicativeZero", IsActingSemigroup);
DeclareAttribute("SmallGeneratingSet", IsActingSemigroup);
DeclareAttribute("StructureDescription", IsBrandtSemigroup);
DeclareAttribute("StructureDescription", IsGroupAsSemigroup);
DeclareAttribute("StructureDescriptionSchutzenbergerGroups", IsActingSemigroup);
DeclareAttribute("StructureDescriptionMaximalSubgroups", IsActingSemigroup);
DeclareAttribute("MaximalDClasses", IsSemigroup);
DeclareAttribute("MaximalSubsemigroups", IsSemigroup);
DeclareAttribute("MinimalDClass", IsSemigroup);
DeclareAttribute("IsGreensDLeq", IsActingSemigroup);

DeclareOperation("SubsemigroupByIndicesNC", 
[IsReesMatrixSubsemigroup, IsDenseList, IsDenseList]);
DeclareOperation("SubsemigroupByIndicesNC",
[IsReesZeroMatrixSubsemigroup, IsDenseList, IsDenseList]);
DeclareOperation("GeneratorsOfReesMatrixSubsemigroupNC",
[IsReesMatrixSemigroup, IsGroup]);
DeclareOperation("GeneratorsOfReesMatrixSubsemigroupNC",
[IsReesZeroMatrixSemigroup, IsGroup]);
