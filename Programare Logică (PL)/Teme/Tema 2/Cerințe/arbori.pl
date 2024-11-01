/* Vom reprezenta astfel arborii oarecare:
nil va fi arborele vid;
arb(Radacina,ListaSubarbori) va fi un arbore nevid. */

% In predicatele de mai jos, cazul arborelui vid este doar un caz separat, nu incheie recursiile.

concat([],L,L).
concat([H|T],M,[H|L]) :- concat(T,M,L).

/* Urmatorul predicat citeste N arbori dintr-un fisier text (cu predicatele predefinite see/1 si, pentru inchiderea fisierului, seen/0)
si, in alt fisier text, scrie acesti arbori (cu predicatele predefinite tell/1 si, pentru inchiderea fisierului, told/0)
ca termeni Prolog (asa cum ii citeste, unul cate unul, cu predicatul predefinit read/1), alaturi de inaltimile lor, listele frunzelor
si parcurgerile acestor arbori in adancime si pe niveluri. */

nrarb(N) :- see('d:\\temporar\\fisarb.txt'), tell('d:\\temporar\\afisarb.txt'), arbfis(N).

arbfis(0) :- seen, told.
arbfis(N) :- N>0, read(A), harb(A,H), lfarb(A,L), depthfirst(A,D), breadthfirst(A,B),
		write(A), write(' are inaltimea: '), write(H), write(','), nl,
		write('   lista frunzelor: '), write(L), write(','), nl,
		write('   parcurgerea in adancime: '), write(D), write(','), nl,
		write('   parcurgerea pe niveluri: '), write(B), write('.'), nl,
		K is N-1, arbfis(K).

/* Eventual modificand in prealabil calea catre fisierele pentru citire (fisarb.txt) si pentru scriere (afisarb.txt), interogati:
?- nrarb(3).
apoi consultati fisierul afisarb.txt. */

% Lista frunzelor unui arbore oarecare:

lfarb(nil,[]).
lfarb(arb(F,[]),[F]).
lfarb(arb(_,[H|T]),L) :- lfarb(H,M),lflistarb(T,N),concat(M,N,L).

% predicat auxiliar: lista frunzelor unei liste de arbori:

lflistarb([],[]).
lflistarb([H|T],L) :- lfarb(H,M),lflistarb(T,N),concat(M,N,L).

% Inaltimea unui arbore oarecare:

maxim(X,Y,X) :- X>=Y.
maxim(X,Y,Y) :- X<Y.

maxlist([],0).
maxlist([H|T],M) :- maxlist(T,N),maxim(H,N,M).

harb(nil,0).
harb(arb(_,LS),H) :- hlistarb(LS,L),maxlist(L,I),H is I+1.

% predicat auxiliar: lista inaltimilor arborilor dintr-o lista:

hlistarb([],[]).
hlistarb([H|T],[I|L]) :- harb(H,I),hlistarb(T,L).

% Parcurgerea in adancime a unui arbore oarecare:

depthfirst(nil,[]).
depthfirst(arb(R,S),[R|L]) :- dflist(S,L).

dflist([],[]).
dflist([H|T],L) :- depthfirst(H,M),dflist(T,N),concat(M,N,L).

% Parcurgerea pe niveluri a unui arbore oarecare:

breadthfirst(nil,[]).
breadthfirst(arb(R,S),L) :- bflist([arb(R,S)],L).

bflist([],[]).
bflist([arb(R,S)|T],[R|L]) :- concat(T,S,U),bflist(U,L).

