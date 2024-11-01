concat([],L,L).
concat([H|T],L,[H|M]) :- concat(T,L,M).

% Quicksort-ul, cu pivotul ales ca fiind capul listei la fiecare pas:

taie(_,[],[],[]).
taie(P,[H|T],[H|L],M) :- H=<P, taie(P,T,L,M).
taie(P,[H|T],L,[H|M]) :- H>P, taie(P,T,L,M).

qsort([],[]).
qsort([P|T],S) :- taie(P,T,M,N),qsort(M,Q),qsort(N,R),concat(Q,[P|R],S).

timpqsort(L,S) :- I is cputime, qsort(L,S), F is cputime, D is F-I, nl, write(D), write(' secunde').

% Quicksort-ul cu liste cu diferenta (nu foloseste niciun predicat pentru concatenare):

quicksort(L,S) :- qs(L,S-[]).

qs([],L-L).
qs([H|T],L-M) :- taie(H,T,S,D), qs(S,L-[H|C]), qs(D,C-M).

% A se vedea fisierul detaliiquicksortlistdif.png pentru modul de functionare a acestei implementari pentru quicksort.

detaliiquicksort(L,S) :- detaliiqs(L,S-[]).

detaliiqs([],L-L) :- write(L), write(' vida'), nl.
detaliiqs([H|T],L-M) :- taie(H,T,S,D), write('H:'), write(H), tab(1), write('T:'), write(T), tab(1), write('S:'), write(S), tab(1), write('D:'), write(D), nl,
                        detaliiqs(S,L-[H|C]), write('S:'), write(S), tab(1), write('L:'), write(L), tab(1), write('H:'), write(H), tab(1), write('C:'), write(C), nl,
                        detaliiqs(D,C-M), write('D:'), write(D), tab(1), write('C:'), write(C), tab(1), write('M:'), write(M), nl.

timpquicksort(L,S) :- I is cputime, quicksort(L,S), F is cputime, D is F-I, nl, write(D), write(' secunde').

% Sa generam o lista lunga:

puteri(_,0,[1]).
puteri(N,K,[H,G|T]) :- P is K-1, puteri(N,P,[G|T]), H is G*N.

inversa([],[]).
inversa([H|T],L) :- inversa(T,M), concat(M,[H],L).

genlist(N,X,M,Y,L) :- puteri(N,X,L1), puteri(M,Y,L2), inversa(L2,L3), multip(L1,L3,L).

multip([],_,[]).
multip([H|T],L,M) :- inmult(H,L,P), multip(T,L,Q), concat(P,Q,M).

inmult(_,[],[]).
inmult(X,[H|T],[K|U]) :- K is X*H, inmult(X,T,U).

/* Sa interogam:
?- genlist(3,10,5,70,L), timpqsort(L,S).
?- genlist(3,10,5,70,L), timpquicksort(L,S).
?- genlist(3,90,5,170,L), timpqsort(L,S).
?- genlist(3,90,5,170,L), timpquicksort(L,S).
si sa comparam timpii de executie.
*/

/* Amintesc concatenarea cu liste cu diferenta, executata in timp constant (in timp ce "concat"
de mai sus ruleaza in timp liniar), si iata inversarea de liste cu diferenta: */

concatdif(L-M,M-P,L-P).

inv(L-M,A-A) :- L==M.
inv([H|T]-M,A-B) :- inv(T-M,A-[H|B]).

/* Sa interogam:
?- genlist(3,10,5,70,L), I is cputime, inversa(L,M), F is cputime, D is F-I, nl, write(D), write(' secunde').
?- genlist(3,10,5,70,L), I is cputime, inv(L-[],M), F is cputime, D is F-I, nl, write(D), write(' secunde').
?- genlist(3,90,5,170,L), I is cputime, inversa(L,M), F is cputime, D is F-I, nl, write(D), write(' secunde').
?- genlist(3,90,5,170,L), I is cputime, inv(L-[],M), F is cputime, D is F-I, nl, write(D), write(' secunde').
si sa comparam timpii de executie.
*/
