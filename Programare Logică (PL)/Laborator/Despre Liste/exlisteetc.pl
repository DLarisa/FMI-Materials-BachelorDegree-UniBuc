/* Predicate pentru a determina daca lungimea unei liste este para, respectiv impara,
fara a calcula lungimea listei: */

lpara([]).
lpara([_,_|T]) :- lpara(T).

limpara([_|T]) :- lpara(T).

% Concatenarea, apoi inversarea de liste:

concat([],L,L).
concat([H|T],L,[H|M]) :- concat(T,L,M).

inversa([],[]).
inversa([H|T],L) :- inversa(T,M), concat(M,[H],L).

:- dynamic a/0.

b :- not(a).

/* Predicatul zeroar (adica fara argumente, fara operanzi) "a" nu e satisfacut (nu e definit prin nicio fapta sau regula,
deci nu avem cazuri de satisfacere a lui a, iar, fara a-l declara ca dinamic, adica putand sa fie nedefinit, am primi eroare),
deci predicatul zeroar b e satisfacut, adica raspunsul la urmatoarea interogare este true:
?- b.
*/

% Putem da astfel de fapte sau reguli:

c(ct,_).

d(X,c(a,X)).
d(X,c(V,Y)) :- d(X,c(V,X)) ; c(V,Y).  %% "," inseamna conjunctie logica ("si"), ";" semnifica disjunctie logica ("sau")

% Dar, de exemplu, in urmatorul fapt, "-" este privit ca un operator binar care construieste termeni:

e(_-_).

/* La fiecare dintre interogarile:
?- e(5-2).
?- e(a-f(X)).
?- e((a-b)-c).
Prologul raspunde true, dar la interogarea:
?- e(3).
Prologul raspunde false, pentru ca termenul X-Y, de operator dominant "-", si constanta 3 nu unifica. */

f(0) :- write(yap).
f(_-1) :- write(nope).
f(X) :- X>0, f(X-1).

/* Dati interogarea:
?- f(1).
*/

% Predicat infixat pentru calculul factorialului.

:- op(500,xfx,!).

0 ! 1.
N ! F :- N>0, M is N-1, M ! G, F is G*N.

/* fibo(N,L) obtine in argumentul L sirul lui Fibonacci pana la al N-lea termen, de la coada la cap,
astfel ca fib(N,F) e satisfacut pentru F = al N-lea termen din sirul lui Fibonacci. */

fibo(1,[0]).
fibo(2,[1,0]).
fibo(N,[H,A,B|T]) :- N>2, P is N-1, fibo(P,[A,B|T]), H is A+B.

fib(N,F) :- fibo(N,[F|_]).

fibon(N,F,Dif) :- Initial is cputime, fibo(N,[F|_]), Final is cputime, Dif is Final-Initial,nl, write('nrsec='),write(Dif).

fibonacci(N,L) :- fibo(N,L), inversa(L,M), write(M).

% Pentru scrierea sirului lui Fibonacci pana la al N-lea termen de la cap la coada.

/* In definitia lui "fibon", am folosit predicatul predefinit cputime. Diferenta Dif reprezinta timpul de executie al lui
fibo(N,[F|_]), adica timpul de rulare al interpretorului de Prolog pentru satisfacerea scopului fibo(N,[F|_]), masurat in
secunde. */

transf([],([],[])).
transf([H],([H],[])).
transf([H,K|T],([H|L],[K|M])) :- transf(T,(L,M)). 

/* "transf" e un predicat binar, satisfacut atunci cand primul argument e o lista L, iar al doilea argument al sau este
perechea (Li,Lp), unde Li e lista elementelor aflate pe pozitii impare in lista L, iar Lp e lista elementelor aflate pe
pozitii pare in lista L. */
