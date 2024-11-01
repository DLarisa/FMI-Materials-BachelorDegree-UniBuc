% Prima cerinta:

alternsort([],[]).
alternsort([L|LL],[M|MM]) :- qsort(L,M), alternsortinv(LL,MM).

alternsortinv([],[]).
alternsortinv([L|LL],[M|MM]) :- qsort(L,I), inversa(I,M), alternsort(LL,MM).

concat([],L,L).
concat([H|T],L,[H|M]) :- concat(T,L,M).

inversa([],[]).
inversa([H|T],L) :- inversa(T,M), concat(M,[H],L).

qsort([],[]).
qsort([H|T],L) :- taie(T,H,S,D), qsort(S,M), qsort(D,N), concat(M,[H|N],L).

taie([],_,[],[]).
taie([H|T],P,[H|S],D) :- H=<P, taie(T,P,S,D).
taie([H|T],P,S,[H|D]) :- H>P, taie(T,P,S,D).

/* Dati interogarea:
?- alternsort([[2,0,1,-1],[3,5,3,7,0,10],[2,2,1,3,0],[7,2,0,7],[0,10,0,7,1]],M), write(M).
*/

% A doua cerinta:

catectnr(Term,0) :- var(Term).
catectnr(Term,0) :- nonvar(Term), Term=..[_], not(number(Term)).
catectnr(Term,1) :- nonvar(Term), Term=..[_], number(Term).
catectnr(Term,N) :- nonvar(Term), Term=..[_,H|T], catectnrlist([H|T],N).

catectnrlist([],0).
catectnrlist([H|T],N) :- catectnr(H,K), catectnrlist(T,M), N is K+M.

/* Dati interogarea:
?- catectnr(f(g(f(a,10),f(f(5.5,Y),-2)),f(X,Y)),Cate).
*/

