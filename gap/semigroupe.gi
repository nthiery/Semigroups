
# TODO: generalise the code to not only use hash tables but dictionaries, or
# sets of elements

#  for details see:
#
#  V. Froidure, and J.-E. Pin, Algorithms for computing finite semigroups.
#  Foundations of computational mathematics (Rio de Janeiro, 1997), 112-126,
#  Springer, Berlin,  1997.

InstallMethod(PinData, "for a finite semigroup with generators",
[IsFinite and IsSemigroup and HasGeneratorsOfSemigroup], 
function(S)
  local gens, ht, nrgens, genstoapply, stopper, nr, one, nrrules, elts, words, first, final, left, prefix, suffix, right, rules, genslookup, reduced, wordsoflen, nrwordsoflen, maxwordlen, val, i;

  if IsMonoid(S) then 
    gens:=ShallowCopy(GeneratorsOfMonoid(S));
    ht:=HTCreate(One(S), rec(treehashsize:=SemigroupsOptionsRec.hashlen.L));
  else
    gens:=ShallowCopy(GeneratorsOfSemigroup(S));
    ht:=HTCreate(gens[1], rec(treehashsize:=SemigroupsOptionsRec.hashlen.L));
  fi;

  nrgens:=Length(gens);
  genstoapply:=[1..nrgens];
  
  stopper:=false;   nr:=0;            one:=false;  
  nrrules:=0;
  
  elts:=[];         words:=[];         
  first:=[];        final:=[];        left:=[];
  prefix:=[];       suffix:=[];       right:=[];  
  rules:=[];        genslookup:=[];   reduced:=[[]];
  wordsoflen:=[]; 
  nrwordsoflen:=[];
  maxwordlen:=0;
  
  if nrgens<>0 then 
    maxwordlen:=1;
    wordsoflen[1]:=[];
    nrwordsoflen[1]:=0;
  fi;
  
  if IsMonoid(S) then 
    nr:=1; 
    HTAdd(ht, One(S), 1); 
    elts[1]:=One(S);
    words[1]:=[];   
    first[1]:=0;    final[1]:=0;
    prefix[1]:=0;   suffix[1]:=0;
    reduced[1]:=BlistList(genstoapply, genstoapply);
    one:=1;
  fi;
   
  for i in genstoapply do 
    val:=HTValue(ht, gens[i]);
    if val=fail then 
      nr:=nr+1; 
      HTAdd(ht, gens[i], nr); 
      elts[nr]:=gens[i];
      words[nr]:=[i];  
      first[nr]:=i;    final[nr]:=i;
      prefix[nr]:=0;   suffix[nr]:=0;
      left[nr]:=[];    right[nr]:=[];
      genslookup[i]:=nr;
      reduced[nr]:=BlistList(genstoapply, []);
      nrwordsoflen[1]:=nrwordsoflen[1]+1;
      wordsoflen[1][nrwordsoflen[1]]:=nr;
      
      if one=false and ForAll(gens, y-> gens[i]*y=y and y*gens[i]=y) then 
        one:=nr;
      fi;
    else 
      genslookup[i]:=val;
      nrrules:=nrrules+1;
      rules[nrrules]:=[[i], [val]];
    fi;
  od;

  if IsMonoid(S) then 
    left[1]:=List(genstoapply, i-> genslookup[i]);    
    right[1]:=List(genstoapply, i-> genslookup[i]);
  fi;

  return Objectify(NewType(FamilyObj(S), IsPinData and IsMutable), 
      rec( ht:=ht, stopper:=stopper,   words:=words, genslookup:=genslookup,
           nr:=nr, elts:=elts,   one:=one, 
           first:=first, final:=final, prefix:=prefix, suffix:=suffix,
           left:=left,   right:=right, reduced:=reduced, genstoapply:=genstoapply, 
           gens:=gens, found:=false, rules:=rules, nrrules:=nrrules, pos:=1,
           len:=1, wordsoflen:=wordsoflen, nrwordsoflen:=nrwordsoflen, 
           maxwordlen:=maxwordlen, ind:=1));
end);

# the main algorithm

InstallMethod(Enumerate, "for Pin data", [IsPinData], 
function(data)
  return Enumerate(data, infinity, ReturnFalse);
end);

#

InstallMethod(Enumerate, "for Pin data and cyclotomic", [IsPinData, IsCyclotomic], 
function(data, limit)
  return Enumerate(data, limit, ReturnFalse);
end);

# <lookfunc> has arguments <data=S!.semigroupe> and an index <j> in
# <[1..Length(data!.elts)]>.

InstallMethod(Enumerate, "for Pin data, cyclotomic, function",
[IsPinData, IsCyclotomic, IsFunction], 
function(data, limit, lookfunc)
  local looking, found, len, maxwordlen, nr, elts, gens, genstoapply, genslookup, one, right, left, first, final, prefix, suffix, reduced, words, stopper, ht, rules, nrrules, wordsoflen, nrwordsoflen, pos, i, htadd, htvalue, lentoapply, b, s, r, new, newword, val, p, ind, j, k;
  
  if lookfunc<>ReturnFalse then 
    looking:=true;              # only applied to new elements, not old ones!!!
    data!.found:=false;         # in case we previously looked for something and found it
  else
    looking:=false;
  fi;
  
  found:=false; 
  
  len:=data!.len;                   # current word length
  maxwordlen:=data!.maxwordlen;     # the maximum length of a word so far
 
  if len>maxwordlen then
    SetFilterObj(data, IsClosedPinData);
    if looking then 
      data!.found:=false;
    fi;
    return data;
  fi;
  
  nr:=data!.nr;                     # nr=Length(elts);
  elts:=data!.elts;                 # the so far enumerated elements
  gens:=data!.gens;                 # the generators
  genstoapply:=data!.genstoapply;   # list of indices of generators to apply in inner loop
  genslookup:=data!.genslookup;     # genslookup[i]=Position(elts, gens[i])
                                    # this is not always <i+1>!
  one:=data!.one;                   # <elts[one]> is the mult. neutral element
  right:=data!.right;               # elts[right[i][j]]=elts[i]*gens[j], right Cayley graph
  left:=data!.left;                 # elts[left[i][j]]=gens[j]*elts[i], left Cayley graph
  first:=data!.first;               # elts[i]=gens[first[i]]*elts[suffix[i]], first letter 
  final:=data!.final;               # elts[i]=elts[prefix[i]]*gens[final[i]]
  prefix:=data!.prefix;             # see final, 0 if prefix is empty i.e. elts[i] is a gen
  suffix:=data!.suffix;             # see first, 0 if suffix is empty i.e. elts[i] is a gen
  reduced:=data!.reduced;           # words[right[i][j]] is reduced if reduced[i][j]=true
  words:=data!.words;               # words[i] is a word in the gens equal to elts[i]
  nr:=data!.nr;                     # nr=Length(elts);
  stopper:=data!.stopper;           # stop when we have applied generators to elts[stopper] 
  ht:=data!.ht;                     # HTValue(ht, x)=Position(elts, x)
  rules:=data!.rules;               # the relations
  nrrules:=data!.nrrules;           # Length(rules)
  wordsoflen:=data!.wordsoflen;     # wordsoflen[len]=list of positions in <words>
                                    # of length <len>
  nrwordsoflen:=data!.nrwordsoflen; # nrwordsoflen[len]=Length(wordsoflen[len]);

  ind:=data!.ind;                   # index in wordsoflen[len]
  i:=data!.pos;                     # wordsoflen[len][pos], the actual position
                                    # in the orbit we are about to apply generators to 
  
  if IsBoundGlobal("ORBC") then 
    htadd:=HTAdd_TreeHash_C;
    htvalue:=HTValue_TreeHash_C;
  else
    htadd:=HTAdd;
    htvalue:=HTValue;
  fi;
  
  while nr<=limit and len<=maxwordlen do 
    lentoapply:=[1..len];
    for i in [ind..nrwordsoflen[len]] do 
      i:=wordsoflen[len][i];
      b:=first[i];  s:=suffix[i];  # elts[i]=gens[b]*elts[s]

      for j in genstoapply do # consider <elts[i]*gens[j]>
        
        if s<>0 and not reduced[s][j] then     # <elts[s]*gens[j]> is not reduced
          r:=right[s][j];                      # elts[r]=elts[s]*gens[j]
          if prefix[r]<>0 then 
            right[i][j]:=right[left[prefix[r]][b]][final[r]];
            # elts[i]*gens[j]=gens[b]*elts[prefix[r]]*elts[final[r]];
            # reduced[i][j]=([words[i],j]=words[right[i][j]])
            reduced[i][j]:=false;
            if len+1=Length(words[right[i][j]]) and j=words[right[i][j]][len+1] then 
              reduced[i][j]:=true;
              for k in lentoapply do 
                if words[i][k]<>words[right[i][j]][k] then 
                  reduced[i][j]:=false;
                  break;
                fi;
              od;
            fi;
          elif r=one then               # <elts[r]> is the identity
            right[i][j]:=genslookup[b]; 
            reduced[i][j]:=true;        # <elts[i]*gens[j]=b> and it is reduced
          else # prefix[r]=0, i.e. elts[r] is one of the generators
            right[i][j]:=left[final[r]][b];
            # elts[i]*gens[j]=gens[b]*elts[final[r]];
            # reduced[i][j]=([words[i],j]=words[right[i][j]])
            reduced[i][j]:=false;
            if len+1=Length(words[right[i][j]]) and j=words[right[i][j]][len+1] then 
              reduced[i][j]:=true;
              for k in lentoapply do 
                if words[i][k]<>words[right[i][j]][k] then 
                  reduced[i][j]:=false;
                  break;
                fi;
              od;
            fi;
             
          fi;
        else # <elts[s]*gens[j]> is reduced
          new:=elts[i]*gens[j];
          # <newword>=<elts[i]*gens[j]>
          newword:=words[i]{lentoapply}; # better than ShallowCopy
          newword[len+1]:=j;             # using Concatenate here is very bad!
          val:=htvalue(ht, new);
          
          if val<>fail then 
            nrrules:=nrrules+1;
            rules[nrrules]:=[newword, words[val]];
            right[i][j]:=val;
            # <newword> and <words[val]> represent the same element (but are not
            # equal) and so <newword> is not reduced

          else #<new> is a new element!
            nr:=nr+1;
           
            if one=false and ForAll(gens, y-> new*y=y and y*new=y) then
              one:=nr;
            fi;
            if s<>0 then 
              suffix[nr]:=right[s][j];
            else 
              suffix[nr]:=genslookup[j];
            fi;
            
            elts[nr]:=new;        htadd(ht, new, nr);
            words[nr]:=newword;   
            first[nr]:=b;         final[nr]:=j;
            prefix[nr]:=i;        right[nr]:=[];        
            left[nr]:=[];         right[i][j]:=nr;      
            reduced[i][j]:=true;  reduced[nr]:=BlistList(genstoapply, []);
            
            if not IsBound(wordsoflen[len+1]) then 
              maxwordlen:=len+1;
              wordsoflen[len+1]:=[];
              nrwordsoflen[len+1]:=0;
            fi;
            nrwordsoflen[len+1]:=nrwordsoflen[len+1]+1;
            wordsoflen[len+1][nrwordsoflen[len+1]]:=nr;
            
            if looking and not found then
              if lookfunc(data, nr) then
                found:=true;
                data!.found := nr;
              fi;
            fi;
          fi;
        fi;
      od; # finished applying gens to <elts[i]>
      if i=stopper or (looking and found) then 
        break;
      fi;
    od; # finished words of length <len> or <looking and found>
    if i=stopper or (looking and found) then 
      break;
    fi;
    # process words of length <len> into <left>
    if len>1 then 
      for j in wordsoflen[len] do # loop over all words of length <len-1>
        p:=prefix[j]; b:=final[j];
        for k in genstoapply do 
          left[j][k]:=right[left[p][k]][b];
          # gens[k]*elts[j]=(gens[k]*elts[p])*gens[b]
        od;
      od;
    elif len=1 then 
      for j in wordsoflen[len] do  # loop over all words of length <1>
        b:=final[j];
        for k in genstoapply do 
          left[j][k]:=right[genslookup[k]][b];
          # gens[k]*elts[j]=gens[k]*gens[b]
        od;
      od;
    fi;
    len:=len+1;
    ind:=1;
  od;
  
  data!.nr:=nr;    
  data!.nrrules:=nrrules;
  data!.one:=one;  
  data!.pos:=i;
  data!.ind:=ind;
  data!.maxwordlen:=maxwordlen;

  if len>maxwordlen then
    data!.len:=maxwordlen;
    SetFilterObj(data, IsClosedPinData);
  else 
    data!.len:=len;
  fi;

  return data;
end);

#

InstallMethod(ClosureSemigroup, 
"for a finite semigroup and associative element collection",
[IsSemigroup and IsFinite, IsAssociativeElementCollection],
function(S, coll)
 
  if IsEmpty(coll) then 
    return S;
  fi;

  if not ElementsFamily(FamilyObj(S))=FamilyObj(Representative(coll)) then 
    Error("the semigroup and collection of elements are not of the same type,");
    return;
  fi;
  
  if IsSemigroup(coll) then 
    coll:=Generators(coll);
  fi;

  return ClosureNonActingSemigroupNC(S, Filtered(coll, x-> not x in S));
end);


# <coll> should consist of elements not in <S>

InstallGlobalFunction(ClosureNonActingSemigroupNC, 
function(S, coll)
  local T, data, oldnrgens, nr, elts, gens, genslookup, one, right, left, first, final, prefix, suffix, reduced, words, stopper, ht, rules, nrrules, wordsoflen, nrwordsoflen, oldpos, val, htadd, htvalue, newgenstoapply, allgenstoapply, i, len, lentoapply, genstoapply, b, s, r, new, newword, maxwordlen, p, j, k;
  
  if IsEmpty(coll) then 
    Info(InfoSemigroups, 2, "every element in the collection belong to the ",
    " semigroup,");
    return S;
  fi;

  if IsBound(S!.opts) then 
    if IsMonoid(S) and One(coll)=One(S) then 
      # it can be that these One's differ, and hence we shouldn't call Monoid here
      T:=Monoid(S, coll, S!.opts);    #JDM: safe?
    else
      T:=Semigroup(S, coll, S!.opts); #JDM: safe?
    fi;
  else
    if IsMonoid(S) and One(coll)=One(S) then 
      # it can be that these One's differ, and hence we shouldn't call Monoid here
      T:=Monoid(S, coll); 
    else
      T:=Semigroup(S, coll); 
    fi;
  fi;

  if not HasPinData(S) or (PinData(S)!.pos=1 and not IsClosedPinData(S)) then 
    #nothing is known about <S>
    return T;
  fi;

  data:=StructuralCopy(PinData(S));
  oldnrgens:=Length(data!.gens);

  nr:=data!.nr;                     # nr=Length(elts);
  elts:=data!.elts;                 # the so far enumerated elements
  gens:=data!.gens;                 # the generators
  genslookup:=data!.genslookup;     # genslookup[i]=Position(elts, gens[i])
                                    # this is not always <i+1>!
  one:=data!.one;                   # <elts[one]> is the mult. neutral element
  right:=data!.right;               # elts[right[i][j]]=elts[i]*gens[j], right Cayley graph
  left:=data!.left;                 # elts[left[i][j]]=gens[j]*elts[i], left Cayley graph
  first:=data!.first;               # elts[i]=gens[first[i]]*elts[suffix[i]], first letter 
  final:=data!.final;               # elts[i]=elts[prefix[i]]*gens[final[i]]
  prefix:=data!.prefix;             # see final, 0 if prefix is empty i.e. elts[i] is a gen
  suffix:=data!.suffix;             # see first, 0 if suffix is empty i.e. elts[i] is a gen
  reduced:=data!.reduced;           # words[right[i][j]] is reduced if reduced[i][j]=true
  words:=data!.words;               # words[i] is a word in the gens equal to elts[i]
  nr:=data!.nr;                     # nr=Length(elts);
  ht:=data!.ht;                     # HTValue(ht, x)=Position(elts, x)
  rules:=data!.rules;               # the relations
  nrrules:=data!.nrrules;           # Length(rules)
  wordsoflen:=data!.wordsoflen;     # wordsoflen[len]=list of positions in <words>
                                    # of length <len>
  nrwordsoflen:=data!.nrwordsoflen; # nrwordsoflen[len]=Length(wordsoflen[len]);

  oldpos:=data!.pos;                # so we discriminate old points from new ones
 

  Append(gens, coll);
  Append(data!.genstoapply, [oldnrgens+1..Length(gens)]);
  
  ResetFilterObj(data, IsClosedPinData);
  
  # in case <S> was trivial
  if not IsBound(wordsoflen[1]) then 
    # we are definitely adding some generators, so ok to increase <maxwordlen>
    data!.maxwordlen:=1;
    data!.wordsoflen[1]:=[];
    data!.nrwordsoflen[1]:=0;
  fi;
  
  # append the elements of <coll> to <data>
  for i in [1..Length(coll)] do 
    val:=HTValue(ht, coll[i]);
    if val=fail then #still have to check in case there are duplicates in coll
      nr:=nr+1; 
      HTAdd(ht, coll[i], nr); 
      elts[nr]:=coll[i];
      words[nr]:=[oldnrgens+i];  
      first[nr]:=oldnrgens+i;    
      final[nr]:=oldnrgens+i;
      prefix[nr]:=0;   
      suffix[nr]:=0;
      left[nr]:=[];    
      right[nr]:=[];
      genslookup[oldnrgens+i]:=nr;
      reduced[nr]:=BlistList([1..Length(gens)], []);
      nrwordsoflen[1]:=nrwordsoflen[1]+1;
      wordsoflen[1][nrwordsoflen[1]]:=nr;
      if one=false and ForAll(gens, y-> coll[i]*y=y and y*coll[i]=y) then 
        one:=nr;
      fi;
    else 
      genslookup[oldnrgens+i]:=val;
      nrrules:=nrrules+1;
      rules[nrrules]:=[[oldnrgens+i], [val]];
    fi;
  od;
  
  if IsBoundGlobal("ORBC") then 
    htadd:=HTAdd_TreeHash_C;
    htvalue:=HTValue_TreeHash_C;
  else
    htadd:=HTAdd;
    htvalue:=HTValue;
  fi;
  
  # apply new generators to old points, and all generators to new points...
  
  newgenstoapply := [oldnrgens+1..Length(gens)];
  allgenstoapply := data!.genstoapply;
  i:=1;
  len:=1;

  while i<>oldpos do 
    lentoapply:=[1..len];
    for i in wordsoflen[len] do 
      if i<=oldpos then 
        genstoapply:=newgenstoapply;
        Append(reduced[i], BlistList(genstoapply, []));
      else
        genstoapply:=allgenstoapply;
      fi;

      b:=first[i];  s:=suffix[i];  # elts[i]=gens[b]*elts[s]

      for j in genstoapply do # consider <elts[i]*gens[j]>
         
        if s<>0 and not reduced[s][j] then     # <elts[s]*gens[j]> is not reduced
          r:=right[s][j];                      # elts[r]=elts[s]*gens[j]
          if prefix[r]<>0 then 
            right[i][j]:=right[left[prefix[r]][b]][final[r]];
            # elts[i]*gens[j]=gens[b]*elts[prefix[r]]*elts[final[r]];
            # reduced[i][j]=([words[i],j]=words[right[i][j]])
            if len+1=Length(words[right[i][j]]) and j=words[right[i][j]][len+1] then 
              reduced[i][j]:=true;
              for k in lentoapply do 
                if words[i][k]<>words[right[i][j]][k] then 
                  reduced[i][j]:=false;
                  break;
                fi;
              od;
            else
              reduced[i][j]:=false;
            fi;
          elif r=one then               # <elts[r]> is the identity
            right[i][j]:=genslookup[b]; 
            reduced[i][j]:=true;        # <elts[i]*gens[j]=b> and it is reduced
          else # prefix[r]=0, i.e. elts[r] is one of the generators
            right[i][j]:=left[final[r]][b];
            # elts[i]*gens[j]=gens[b]*elts[final[r]];
            # reduced[i][j]=([words[i],j]=words[right[i][j]])
            if len+1=Length(words[right[i][j]]) and j=words[right[i][j]][len+1] then 
              reduced[i][j]:=true;
              for k in lentoapply do 
                if words[i][k]<>words[right[i][j]][k] then 
                  reduced[i][j]:=false;
                  break;
                fi;
              od;
            else
              reduced[i][j]:=false;
            fi;
             
          fi;
        else # <elts[s]*gens[j]> is reduced
          new:=elts[i]*gens[j];
          # <newword>=<elts[i]*gens[j]>
          newword:=words[i]{lentoapply}; # better than ShallowCopy
          newword[len+1]:=j;             # using Concatenate here is very bad!
          val:=htvalue(ht, new);
          
          if val<>fail then 
            nrrules:=nrrules+1;
            rules[nrrules]:=[newword, words[val]];
            right[i][j]:=val;
            # <newword> and <words[val]> represent the same element (but are not
            # equal) and so <newword> is not reduced

          else #<new> is a new element!
            nr:=nr+1;
           
            if one=false and ForAll(gens, y-> new*y=y and y*new=y) then
              one:=nr;
            fi;
            if s<>0 then 
              suffix[nr]:=right[s][j];
            else 
              suffix[nr]:=genslookup[j];
            fi;
            
            elts[nr]:=new;        htadd(ht, new, nr);
            words[nr]:=newword;   
            first[nr]:=b;         final[nr]:=j;
            prefix[nr]:=i;        right[nr]:=[];        
            left[nr]:=[];         right[i][j]:=nr;      
            reduced[i][j]:=true;  reduced[nr]:=BlistList(allgenstoapply, []);
            
            if not IsBound(wordsoflen[len+1]) then 
              maxwordlen:=len+1;
              wordsoflen[len+1]:=[];
              nrwordsoflen[len+1]:=0;
            fi;
            nrwordsoflen[len+1]:=nrwordsoflen[len+1]+1;
            wordsoflen[len+1][nrwordsoflen[len+1]]:=nr;
            
          fi;
        fi;
      od; # finished applying gens to <elts[i]>
      if i=oldpos then 
        break;
      fi;
    od; # finished words of length <len> or reach previous end point
    if i=oldpos then 
      break;
    fi;
    # process words of length <len> into <left>
    if len>1 then 
      for j in wordsoflen[len] do # loop over all words of length <len-1>
        p:=prefix[j]; b:=final[j];
        for k in genstoapply do 
          left[j][k]:=right[left[p][k]][b];
          # gens[k]*elts[j]=(gens[k]*elts[p])*gens[b]
        od;
      od;
    elif len=1 then 
      for j in wordsoflen[len] do  # loop over all words of length <1>
        b:=final[j];
        for k in genstoapply do 
          left[j][k]:=right[genslookup[k]][b];
          # gens[k]*elts[j]=gens[k]*gens[b]
        od;
      od;
    fi;
    len:=len+1;
  od;
  
  # put the numbers back in <data>
  data!.nr:=nr;    
  data!.nrrules:=nrrules;
  data!.one:=one;  
  data!.maxwordlen:=maxwordlen;       # this can increase!

  # remove the parts of the data that shouldn't be there!
  # Note that <data> can be closed at this point if the old data was closed.
  if len<=maxwordlen then 
    Unbind(data!.rightscc);
    Unbind(data!.leftscc);
    Unbind(data!.idempotents); 
    #JDM <idempotents> could be kept...
  else 
    SetFilterObj(data, IsClosedPinData);
  fi;
  
  SetPinData(T, data);
  return T;
end);

#

InstallMethod(Position, "for Pin data, an associative element, zero cyc",
[IsPinData, IsAssociativeElement, IsZeroCyc], 
function(data, x, n)
  local pos, lookfunc;

  pos:=HTValue(data!.ht, x);
  
  if pos<>fail then 
    return pos;
  else
    lookfunc:=function(data, i)
      return data!.elts[i]=x;
    end;
    
    pos:=Enumerate(data, infinity, lookfunc)!.found;
    if pos<>false then 
      return pos;
    fi;
  fi;

  return fail;
end);

#

InstallMethod(Length, "for Pin data", [IsPinData], 
function(data)
  return Length(data!.elts);
end);

#

InstallMethod(ViewObj, [IsPinData], 
function(data)
  Print("<");

  if IsClosedPinData(data) then 
    Print("closed ");
  else 
    Print("open ");
  fi;

  Print("semigroup data with ", Length(data!.elts), " elements, ");
  Print(Length(data!.rules), " relations, ");
  Print("max word length ", data!.maxwordlen, ">");
  return;
end);

#

InstallMethod(PrintObj, [IsPinData], 
function(data)
  local recnames, com, i, nam;
  
  recnames:=[ "elts", "final", "first", "found", "gens", "genslookup", "genstoapply", 
  "ht", "left", "len", "wordsoflen", "maxwordlen", "nr", "nrrules", "one", "pos", 
  "prefix", "reduced", "right", "rules", "stopper", "suffix", "words", "nrwordsoflen"];
  
  Print("\>\>rec(\n\>\>");
  com := false;
  i := 1;
  for nam in Set(recnames) do
      if com then
          Print("\<\<,\n\>\>");
      else
          com := true;
      fi;
      SET_PRINT_OBJ_INDEX(i);
      i := i+1;
      Print(nam, "\< := \>");
      if nam="ht" then 
        ViewObj(data!.(nam));
      else 
        PrintObj(data!.(nam));
      fi;
  od;
  Print(" \<\<\<\<)"); 
  
  return;
end);
