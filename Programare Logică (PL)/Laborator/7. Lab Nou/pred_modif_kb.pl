/* Predicatele urmatoare adauga clauze (fapte sau reguli) la baza de cunostinte: "asserta" adauga o clauza la inceputul
bazei de cunostinte, iar "assertz" si "assert" o adauga la sfarsitul bazei de cunostinte.
Predicatul "retract" sterge prima aparitie a unei clauze din baza de cunostinte.
Ca exemplu, iata un predicat fib(N,F) care calculeaza al N-lea termen din sirul lui Fibonacci si ii depune valoarea in F
(al doilea argument al sau), evitand recalcularile prin folosirea lui asserta - desigur, nu assertz, pentru ca vrem ca
predicatele din dreapta regulii urmatoare sa fie satisfacute prin faptele care vor fi adaugate, nu prin recalculari.
Pentru a permite folosirea lui asserta, predicatul fib trebuie declarat ca dinamic (2 reprezinta aritatea lui fib):
*/

:- dynamic fib/2.

fib(1,0).
fib(2,1).
fib(N,F) :- N>2, PN is N-1, PPN is PN-1, fib(PPN,PPF), fib(PN,PF), F is PPF+PF, asserta(fib(N,F)).

/* Pentru urmatoarele predicate, dati interogarile urmatoare, cerand cate o singura solutie (i.e. fara a apasa ";"/"Next"):
?- testassertretract(10,3).
?- retract(predtest(7)).
?- findall(predtest(X),predtest(X),L), write(L).
?- asserta(predtest(5)).
?- findall(predtest(X),predtest(X),L), write(L).
?- assertz(predtest(5)).
?- findall(predtest(X),predtest(X),L), write(L).
?- assert(predtest(5)).
?- findall(predtest(X),predtest(X),L), write(L).
?- retract(predtest(5)).
?- findall(predtest(X),predtest(X),L), write(L).
?- retract(predtest(5)),retract(predtest(5)).
?- findall(predtest(X),predtest(X),L), write(L).
?- retract(predtest(5)).
*/

:- dynamic predtest/1.

testassert(0).
testassert(N) :- N>0, asserta(predtest(N)), PN is N-1, testassert(PN).

testretract(0).
testretract(K) :- K>0, retract(predtest(K)), PK is K-1, testretract(PK).

testassertretract(N,K) :- testassert(N), testretract(K), findall(predtest(X),predtest(X),L), write(L).
