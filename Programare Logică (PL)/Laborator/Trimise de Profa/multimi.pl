%concatenarea a doua liste:

concat([],L,L).
concat([H|T],L,[H|M]) :- concat(T,L,M).

%stergerea tuturor aparitiilor unui element intr-o lista:

stergetot(_,[],[]).
stergetot(X,[X|L],M) :- stergetot(X,L,M).
stergetot(X,[H|L],[H|M]) :- X\=H,stergetot(X,L,M).

/*eliminarea duplicatelor dintr-o lista, transformand, astfel,
lista in multime:*/

elimdup([],[]).
elimdup([H|T],[H|L]) :- stergetot(H,T,M),elimdup(M,L).

%reuniunea de multimi, sau de liste, ca multimi:

reun(L,M,R) :- concat(L,M,C),elimdup(C,R).

%testarea aparitiei unui element intr-o lista:

element_of(X,[X|_]).
element_of(X,[_|L]) :- element_of(X,L).

%testam daca o lista e multime, adica nu are duplicate:

emult([]).
emult([H|T]) :- emult(T),not(element_of(H,T)).

%intersectia de multimi:

inters([],_,[]).
inters([H|T],L,[H|M]) :- element_of(H,L),inters(T,L,M).
inters([H|T],L,M) :- not(element_of(H,L)),inters(T,L,M).

%intersectia de liste ca multimi:

interslist(L,M,R) :- elimdup(L,L1),elimdup(M,M1),inters(L1,M1,R).

%diferenta de multimi:

dif([],_,[]).
dif([H|T],L,[H|M]) :- not(element_of(H,L)),dif(T,L,M).
dif([H|T],L,M) :- element_of(H,L),dif(T,L,M).

/*varianta: scrierea diferentei recursiv dupa al doilea
argument al sau, folosind predicatul stergetot:*/

dif2(M,[],M).
dif2(M,[H|T],R) :- stergetot(H,M,L),dif2(L,T,R).

%diferenta de liste ca multimi:

diflist(L,M,R) :- elimdup(L,L1),elimdup(M,M1),dif(L1,M1,R).

%puteam elimina duplicatele numai din L

%diferenta simetrica de multimi, sau de liste ca multimi:

difsim(L,M,R) :- dif(L,M,C),dif(M,L,D),reun(C,D,R).

/*
Ca mai sus se poate proceda pentru scrierea urmatoarelor
operatii pentru liste ca multimi, adica pentru liste
arbitrare carora li se elimina, mai intai, duplicatele.
*/

%produsul cartezian de multimi:

prodcart(L,M,P) :- setof((X,Y),(element_of(X,L),element_of(Y,M)),P).

/*Aplicat unei multimi, urmatorul predicat obtine
submultimile acesteia:*/

sublista([],_).
sublista([_|_],[]) :- fail.
sublista([H|T],[H|L]) :- sublista(T,L).
sublista([H|T],[_|L]) :- sublista([H|T],L).

/*Multimea partilor unei multimi, adica a
submultimilor acesteia:*/

parti(M,P) :- setof(S,sublista(S,M),P).

/*TEMA FACULTATIVA: scrieti produsul cartezian si generarea
partilor unei multimi recursiv, fara a va folosi de predicatul
setof sau de alte predicate predefinite.*/

/*Pentru multimi mai lungi, puteti interoga si sub forma:
?- prodcart([1,2,3,4,5],[a,b,c],P),write(P).
?- parti([1,2,3,4,5],P),write(P).
*/
