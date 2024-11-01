lista_noduri([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]).

lista_vecini([(1,3),(1,9),(3,5),(3,7),(7,9),(9,12),(9,13),(9,14),(12,15),(2,4),(2,6),(2,8),(2,10),(4,8)]).

/* Pentru usurinta interogarilor, dam graful direct in baza de cunostinte, sub forma listei nodurilor si a listei muchiilor.
In cazul neorientat, graful specificat mai sus are componentele conexe:
1,3,5,7,9,12,13,14,15;
2,4,6,8,10;
11 (nod izolat). */

modif([],[]).
modif([(X,Y)|T],[(X,Y),(Y,X)|L]) :- modif(T,L). 

lista_muchii(L) :- lista_vecini(V), modif(V,L). %%% cazul neorientat

/* Pentru grafuri orientate putem sterge "lista_vecini" si "modif" si, in locul listei vecinilor, sa dam direct:
lista_muchii([(1,3),(1,9),(3,5),(3,7),(7,9),(9,12),(9,13),(9,14),(12,15),(2,4),(2,6),(2,8),(2,10),(4,8)]).
sau putem sa modificam, rapid, doar definitia lui "lista_muchii", in:
lista_muchii(L) :- lista_vecini(L).
*/

apartine(_,[]) :- fail.
apartine(H,[H|_]).
apartine(X,[_|T]) :- apartine(X,T). %%% nu dam "H\=X", pentru ca vrem sa si genereze lista elementelor

% Reluam determinarea drumurilor din labirintgrafic.pl:

drum(X,Y,Drum) :- lista_muchii(M), cauta_drum(M,X,Y,[X,Y],Drum), write(Drum).

cauta_drum(Muchii,X,Y,_,[X,Y]) :- apartine((X,Y),Muchii).
cauta_drum(Muchii,X,Y,Vizitate,[X|RestulDrumului]) :- not(apartine((X,Y),Muchii)), apartine((X,Z),Muchii), not(apartine(Z,Vizitate)),
                                                      cauta_drum(Muchii,Z,Y,[Z|Vizitate],RestulDrumului).

/* Interogam:
?- drum(1,15,Drumul).
si cerem toate drumurile, cu ";"/"Next". */

/* Pentru a vedea parcurgerile grafului dat prin predicatele "lista_noduri" si "lista_muchii", interogam, pur si simplu:
?- breadth_first(L).
?- depth_first(L).
Pentru parcurgerea componentei conexe a nodului 1 sau a nodului 6, de exemplu, interogam:
?- lista_muchii(M), bfconex(1,M,[],L).
?- lista_muchii(M), dfconex(6,M,[],L).
*/

concat([],L,L).
concat([H|T],M,[H|L]) :- concat(T,M,L).

depth_first(L) :- lista_noduri(N), lista_muchii(M), df(N,M,[],L), write(L).

df([],_,_,[]).
df([Nevizitat|Nevizitate],Muchii,Vizitate,L) :- apartine(Nevizitat,Vizitate), df(Nevizitate,Muchii,Vizitate,L).
df([Nevizitat|Nevizitate],Muchii,Vizitate,L) :- not(apartine(Nevizitat,Vizitate)), dfconex(Nevizitat,Muchii,Vizitate,Parcurse), nl,
                                                concat(Vizitate,Parcurse,Viz), df(Nevizitate,Muchii,Viz,S), concat(Parcurse,S,L).

% dupa afisarea fiecarei componente conexe, trecem la linie noua

dfconex(Nod,Muchii,Vizitate,[Nod|L]) :- write(Nod), write(','), findall(Vecin, (apartine((Nod,Vecin),Muchii), not(apartine(Vecin,Vizitate))), Vecini),
                                        concat([Nod|Vizitate],Vecini,Viz), dflist(Vecini,Muchii,Viz,L).

dflist([],_,_,[]).
dflist([Nod|Noduri],Muchii,Vizitate,L) :- dfconex(Nod,Muchii,Vizitate,S), concat(Vizitate,S,Viz), dflist(Noduri,Muchii,Viz,P), concat(S,P,L).

% Lista componentelor conexe in loc de lista rezultata prin parcurgerea in adancime:

compon_conexe_df(L) :- lista_noduri(N), lista_muchii(M), conexcdf(N,M,[],L), write(L).

conexcdf([],_,_,[]).
conexcdf([Nevizitat|Nevizitate],Muchii,Vizitate,L) :- apartine(Nevizitat,Vizitate), conexcdf(Nevizitate,Muchii,Vizitate,L).
conexcdf([Nevizitat|Nevizitate],Muchii,Vizitate,[Parcurse|S]) :- not(apartine(Nevizitat,Vizitate)), dfconex(Nevizitat,Muchii,Vizitate,Parcurse),
                                                                 concat(Vizitate,Parcurse,Viz), conexcdf(Nevizitate,Muchii,Viz,S).

breadth_first(L) :- lista_noduri(N), lista_muchii(M), bf(N,M,[],L), write(L).

bf([],_,_,[]).
bf([Nevizitat|Nevizitate],Muchii,Vizitate,L) :- apartine(Nevizitat,Vizitate), bf(Nevizitate,Muchii,Vizitate,L).
bf([Nevizitat|Nevizitate],Muchii,Vizitate,L) :- not(apartine(Nevizitat,Vizitate)), bfconex([Nevizitat],Muchii,Vizitate,Parcurse), nl,
                                                concat(Vizitate,Parcurse,Viz), bf(Nevizitate,Muchii,Viz,S), concat(Parcurse,S,L).

% dupa afisarea fiecarei componente conexe, trecem la linie noua

bfconex([],_,_,[]).
bfconex([Nod|DeParcurs],Muchii,Vizitate,[Nod|L]) :- write(Nod), write(','), 
                findall(Vecin, (apartine((Nod,Vecin),Muchii), not(apartine(Vecin,Vizitate)), not(apartine(Vecin,DeParcurs))), Vecini),
                concat(DeParcurs,Vecini,ListadeParcurs), bfconex(ListadeParcurs,Muchii,[Nod|Vizitate],L).

% Lista componentelor conexe in loc de lista rezultata prin parcurgerea in latime:

compon_conexe_bf(L) :- lista_noduri(N), lista_muchii(M), conexcbf(N,M,[],L), write(L).

conexcbf([],_,_,[]).
conexcbf([Nevizitat|Nevizitate],Muchii,Vizitate,L) :- apartine(Nevizitat,Vizitate), conexcbf(Nevizitate,Muchii,Vizitate,L).
conexcbf([Nevizitat|Nevizitate],Muchii,Vizitate,[Parcurse|S]) :- not(apartine(Nevizitat,Vizitate)), bfconex([Nevizitat],Muchii,Vizitate,Parcurse), nl,
                                                concat(Vizitate,Parcurse,Viz), conexcbf(Nevizitate,Muchii,Viz,S).

