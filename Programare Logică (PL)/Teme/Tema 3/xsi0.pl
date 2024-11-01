/* Joc de x si 0 jucator contra jucator.
Putem juca si alte jocuri, eventual cu alta dimensiune a tablei si cu alte simboluri de pus in locatiile vacante de pe tabla. */

:- dynamic config/1.

start :- not(stergeconfig), asserta(config([[v,v,v],[v,v,v],[v,v,v]])), aratatabla.

/* Retragem din baza de cunostinte configuratia finala a tablei din jocul anterior si orice alta configuratie memorata, apoi
adaugam la baza de cunostinte configuratia initiala a tablei, pe care o afisam pe ecran. */

stergeconfig :- retract(config(_)), stergeconfig.

/* Conjunctia e evaluata de la stanga la dreapta, deci "stergeconfig" se va reapela pana cand "retract" intoarce false,
adica pana cand nu mai exista configuratii in baza de cunostinte, iar la final va intoarce false, motiv pentru care,
in definitia lui "start", trebuie sa il inseram negat la inceputul acelei conjunctii. */

aratatabla :- config(ListaLinii), afiseaza(ListaLinii).

afiseaza([]) :- nl.
afiseaza([L|LL]) :- scrie(L), nl, afiseaza(LL).

scrie([]).
scrie([v|T]) :- write('.'), scrie(T).   %%% Putem sa punem tab(1) sau write('_') in loc de write('.') pentru locatiile vacante.
scrie([H|T]) :- H\=v, write(H), scrie(T).

pune(Simbol,Linie,Coloana) :- retract(config(ListaLinii)), modif(Simbol,ListaLinii,Linie,Coloana,NouaListaLinii), asserta(config(NouaListaLinii)), aratatabla.

% Simbolul va fi x sau 0 in cazul jocului de x si 0.

modif(_,[],_,_,_).   %%% Ajungem aici daca am dat un numar de linie mai mare decat numarul de linii al tablei.
modif(Simbol,[LiniaCurenta|ListaLinii],1,Coloana,[NouaLinieCurenta|ListaLinii]) :- modiflin(Simbol,LiniaCurenta,Coloana,NouaLinieCurenta).
modif(Simbol,[LiniaCurenta|ListaLinii],Linie,Coloana,[LiniaCurenta|NouaListaLinii]) :- Linie>1, L is Linie-1, modif(Simbol,ListaLinii,L,Coloana,NouaListaLinii).

modiflin(_,[],_,_).   %%% Ajungem aici daca am dat un numar de coloana mai mare decat numarul de coloane al tablei.
modiflin(Simbol,[H|T],Coloana,[H|L]) :- Coloana>1, C is Coloana-1, modiflin(Simbol,T,C,L).
modiflin(Simbol,[v|T],1,[Simbol|T]).
modiflin(_,[H|T],1,[H|T]) :- H\=v, write('locatie ocupata'), nl.

/* Jocul se desfasoara in maniera urmatoare:
?- start.
?- pune(x,2,1).
?- pune(0,2,2).
?- pune(x,2,2).
Aici primim eroare: "locatie ocupata", si configuratia tablei nu se schimba.
?- pune(x,3,3).
S. a. m. d..
Desigur, se pot face imbunatatiri: daca pe tabla sunt mai multi x decat 0, sa nu se accepte punerea unui x; dupa fiecare mutare sa se verifice
daca unul dintre jucatori a castigat; daca se umple tabla, jocul sa se declare incheiat, cu sau fara victoria unuia dintre jucatori. */

