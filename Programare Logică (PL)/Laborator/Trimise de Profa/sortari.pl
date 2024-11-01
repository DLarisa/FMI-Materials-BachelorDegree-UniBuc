%Sortarea prin insertie directa:

inssort([],[]).
inssort([H|T],L) :- inssort(T,M),insert(H,M,L).

insert(H,[],[H]).
insert(H,[X|L],[H,X|L]) :- H=<X.
insert(H,[X|L],[X|C]) :- H>X,insert(H,L,C).

%Bubblesort-ul:

parcurge([],[],true).
parcurge([X],[X],true).
parcurge([X,Y|T],[X|C],B) :- X=<Y,parcurge([Y|T],C,B).
parcurge([X,Y|T],[Y|C],false) :- X>Y,parcurge([X|T],C,_).

bsort(L,S) :- parcurge(L,S,true) ; (parcurge(L,M,false),bsort(M,S)).

%Putem afisa lista obtinuta dupa fiecare parcurgere, astfel:

bblsort(L,S) :- write(L),nl,((parcurge(L,S,true),write(S),nl) ; (parcurge(L,M,false),write(M),nl,bblsort(M,S))).

%Sortarea prin interclasare:

sparge([],[],[]).
sparge([A],[A],[]).
sparge([A,B|T],[A|U],[B|V]) :- sparge(T,U,V).

merge([],L,L).
merge(L,[],L).
merge([A|T],[B|U],[A|L]) :- A=<B,merge(T,[B|U],L).
merge([A|T],[B|U],[B|L]) :- A>B,merge([A|T],U,L).

mergesort([],[]).
mergesort([X],[X]).
mergesort([A,B|T],S) :- sparge([A,B|T],M,N),mergesort(M,Q),mergesort(N,R),merge(Q,R,S).

/*Daca nu cerem decat un rezultat, merge si urmatoarea sortare prin interclasare,
care, insa, pentru fiecare satisfacere a lui concat([X|M],[Y|N],[A,B|T]),
intoarce acelasi rezultat, deci da lista sortata de atatea ori cate posibilitati
are pentru satisfacerea lui concat([X|M],[Y|N],[A,B|T]) la toti pasii sortarii.*/

concat([],L,L).
concat([H|T],M,[H|L]) :- concat(T,M,L).

msort([],[]).
msort([X],[X]).
msort([A,B|T],S) :- concat([X|M],[Y|N],[A,B|T]),msort([X|M],Q),msort([Y|N],R),merge(Q,R,S).

%Am folosit, pentru interclasare, predicatul merge de mai sus.

/*Quicksort-ul, folosind concatenarea de mai sus:
La fiecare iteratie, pivotul va fi capul listei care se sorteaza la pasul respectiv:*/

taie(_,[],[],[]).
taie(P,[H|T],[H|L],M) :- H=<P,taie(P,T,L,M).
taie(P,[H|T],L,[H|M]) :- H>P,taie(P,T,L,M).

qsort([],[]).
qsort([P|T],S) :- taie(P,T,M,N),qsort(M,Q),qsort(N,R),concat(Q,[P|R],S).
