/*
= testeaza egalitatea ca expresii
\= testeaza nonegalitatea ca expresii
=:= testeaza egalitatea ca valori de expresii aritmetice calculate
=\= testeaza nonegalitatea ca valori de expresii aritmetice calculate
== testeaza literal identitatea
\== testeaza literal nonidentitatea
\+ sau not reprezinta negatia
=< este mai mic sau egal
>= este mai mare sau egal
*/

/*
Dati interogarile:
?- test1.
...
?- test4.
sau, direct:
?- 1+5=3+3.
...
?- 1+5=\=3+3.
Se pot da si interogari de forma: predicat(Var1,ct1,Var2,_,ct2,_,Var3,...).
Atunci, pentru fiecare satisfacere a lui predicat, se afiseaza doar
valorile lui Var1, Var2, Var3,... care satisfac predicatul.
*/

test1 :- 1+5=3+3.
test2 :- 1+5\=3+3.
test3 :- 1+5=:=3+3.
test4 :- 1+5=\=3+3.

/*
= face si unificarea, in unele versiuni de Prolog cu testarea ocurentelor
variabilelor in termeni, in alte versiuni fara acest test
unify_with_occurs_check face unificarea cu testarea ocurentelor variabilelor in termeni
*/

test5 :- f(X,g(X))=f(a,Y).
test6 :- f(X,g(X))=f(X,Y).
test7 :- f(X,g(X))=f(X,a).
test8 :- f(X,g(X))=f(g(X),Y).
test9 :- unify_with_occurs_check(f(X,g(X)),f(g(X),Y)).

/*
Daca dam interogarile:
?- test5.
...
?- test9.
interogari in care nu apar variabile, atunci raspunsurile Prologului vor fi true sau false.
Daca dam, ca interogari, doar: 
?- f(X,g(X))=f(a,Y).
?- f(X,g(X))=f(X,Y).
?- f(X,g(X))=f(X,a).
?- f(X,g(X))=f(g(X),Y).
?- unify_with_occurs_check(f(X,g(X)),f(g(X),Y)).
atunci afiseaza si unificatorul, daca acesta exista.
*/

/*
Dati interogarile:
?- X==c.
?- X==Y.
?- X==X.
?- X\==c.
?- X\==c.
?- X\==Y.
?- X\==X.
Observati ca nu se unifica variabila X cu constanta c sau cu variabila Y, ci se testeaza
daca membrii egalitatii sunt literal identici.
*/

/*
Afisarea urmatoarelor instante ale variabilelor care satisfac predicatul: ;
sau, in SWISH SWI-Prolog-ul online: NEXT, sau numarul de urmatoare instante de afisat.
*/

/*
Test pentru predicatele setof, bagof, findall (a se vedea definitia lor in liste.pl):
pentru h definit ca mai jos, interogati:
?- setof(X,h(X),L),write(L).
?- bagof(X,h(X),L),write(L).
?- findall(X,h(X),L),write(L).
*/

h(a).
h(b).
h(c) :- h(a),h(b).
h(d) :- h(a);h(c).
h(e) :- h(c),not(h(d)).
h(f) :- h(c),h(d).
h(g) :- fail.
h(i) :- h(g);h(d);h(a).
