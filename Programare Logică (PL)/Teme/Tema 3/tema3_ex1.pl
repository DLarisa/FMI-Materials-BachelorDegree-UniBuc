 %arbbin.pl
/* Vom reprezenta astfel arborii binari:
nil va fi arborele vid;
arb(Radacina,SubarboreStang,SubarboreDrept) va fi un arbore nevid. */

concat([],L,L).
concat([H|T],M,[H|L]) :- concat(T,M,L).

% Parcurgerile in preordine, inordine, postordine:

pre(nil,[]).
pre(arb(R,S,D),L) :- pre(S,M),pre(D,N),concat([R|M],N,L).

ino(nil,[]).
ino(arb(R,S,D),L) :- ino(S,M),ino(D,N),concat(M,[R|N],L).

post(nil,[]).
post(arb(R,S,D),L) :- post(S,M),post(D,N),concat(M,N,T),concat(T,[R],L).

/* Putem interoga:
?- pre(arb(1,arb(2,nil,arb(3,nil,nil)),arb(4,arb(5,nil,nil),arb(6,nil,nil))),L).
?- pre(arb(1,arb(2,nil,arb(3,nil,nil)),arb(4,arb(5,nil,nil),arb(6,nil,nil))),L),write(L).
*/

/* Putem afisa nodurile pe masura ce le parcurgem,
in loc sa le retinem intr-o lista: */

preord(nil).
preord(arb(R,S,D)) :- write(R),write(','),preord(S),preord(D).

% Lista frunzelor unui arbore binar:

lf(nil,[]).
lf(arb(F,nil,nil),[F]).
lf(arb(_,S,D),L) :- (S\=nil;D\=nil),lf(S,M),lf(D,N),concat(M,N,L).

/* pentru a nu fi generata de mai multe ori ca raspuns,
ar trebui analizate, pe rand, toate cazurile de
arbori stangi/drepti vizi/nevizi (TEMA FACULTATIVA) */

% Inaltimea unui arbore binar:

maxim(X,Y,X) :- X>=Y.
maxim(X,Y,Y) :- X<Y.

h(nil,0).
h(arb(_,S,D),H) :- h(S,Hs),h(D,Hd),maxim(Hs,Hd,Hm),H is Hm+1.

% Parcurgerea pe niveluri a unui arbore binar:

nivel(A,L) :- parcniv([A],L).

parcniv([],[]).
parcniv([nil|ListArb],L) :- parcniv(ListArb,L).
parcniv([arb(R,S,D)|ListArb],[R|L]) :- concat(ListArb,[S,D],ListaArbori),parcniv(ListaArbori,L).

/* Parcurgerea pe niveluri a unui arbore binar, cu
scrierea nodurilor pe ecran in timpul parcurgerii
in loc sa le retinem intr-o lista: */

niveluri(A) :- parcnivel([A]).

parcnivel([]).
parcnivel([nil|ListArb]) :- parcnivel(ListArb).
parcnivel([arb(R,S,D)|ListArb]) :- write(R),write(','),concat(ListArb,[S,D],ListaArbori),parcnivel(ListaArbori).

/* Reprezentarea grafica a unui arbore binar,
crescand din stanga ecranului: */

repr(A) :- desen(A,0).

desen(nil,_).
desen(arb(R,S,D),N) :- M is N+3,desen(D,M),nl,tab(N),write(R),nl,desen(S,M).
desen(L,N):-scrie(" ",N),write("["),scrie_lista(L),write("]"),nl.
scrie(A,N):-K is N-1,K>=0,write(A),scrie(A,K).
scrie(_,_).
scrie_lista([H|T]):-length([H|T],A),A>=2,write(" "),write(H),write(","),scrie_lista(T).
scrie_lista([R]):-write(" "), write(R).


/* pentru folosire in SWISH SWI-Prolog-ul online,
a se inlocui tab(N) cu afisarea a N caractere
de alt tip (a se vedea liste.pl) */

minim(X,Y,X) :- X=<Y.
minim(X,Y,Y) :- X>Y.

% Valoarea minima dintr-un arbore binar:

minarb(arb(R,nil,nil),R).
minarb(arb(R,nil,arb(D,SD,RD)),M) :- minarb(arb(D,SD,RD),MD),minim(R,MD,M).
minarb(arb(R,arb(S,SS,RS),nil),M) :- minarb(arb(S,SS,RS),MS),minim(R,MS,M).
minarb(arb(R,arb(S,SS,RS),arb(D,SD,RD)),M) :- minarb(arb(S,SS,RS),MS),minarb(arb(D,SD,RD),MD),minim(MS,MD,MM),minim(R,MM,M).

% Valoarea maxima dintr-un arbore binar:

maxarb(arb(R,nil,nil),R).
maxarb(arb(R,nil,arb(D,SD,RD)),M) :- maxarb(arb(D,SD,RD),MD),maxim(R,MD,M).
maxarb(arb(R,arb(S,SS,RS),nil),M) :- maxarb(arb(S,SS,RS),MS),maxim(R,MS,M).
maxarb(arb(R,arb(S,SS,RS),arb(D,SD,RD)),M) :- maxarb(arb(S,SS,RS),MS),maxarb(arb(D,SD,RD),MD),maxim(MS,MD,MM),maxim(R,MM,M).

% Testam daca un arbore binar e arbore binar de cautare:

ecaut(nil).
ecaut(arb(_,nil,nil)).
ecaut(arb(R,nil,arb(D,SD,RD))) :- minarb(arb(D,SD,RD),MD),R<MD.
ecaut(arb(R,arb(S,SS,RS),nil)) :- maxarb(arb(S,SS,RS),MS),MS=<R.
ecaut(arb(R,arb(S,SS,RS),arb(D,SD,RD))) :- minarb(arb(D,SD,RD),MD),R<MD,maxarb(arb(S,SS,RS),MS),MS=<R.

/* Interogati:
?- ecaut(arb(1,arb(2,nil,arb(3,nil,nil)),arb(4,arb(5,nil,nil),arb(6,nil,nil)))).
?- ecaut(arb(10,arb(2,nil,arb(7,nil,nil)),arb(40,arb(15,nil,nil),arb(60,nil,nil)))).
?- ecaut(arb(10,arb(2,nil,arb(10,nil,nil)),arb(40,arb(15,nil,nil),arb(60,nil,nil)))).
?- ecaut(arb(10,arb(2,nil,arb(7,nil,nil)),arb(40,arb(10,nil,nil),arb(60,nil,nil)))).
 */

% Sortare de liste cu arbori binari de cautare:

arbsort(L,S) :- crearb(L,A),ino(A,S).

crearb([],nil).
crearb([H|T],B) :- crearb(T,A),insert(H,A,B).

insert(X,nil,arb(X,nil,nil)).
insert(X,arb(R,S,D),A) :- X=<R,insert(X,S,B),A=arb(R,B,D).
insert(X,arb(R,S,D),A) :- X>R,insert(X,D,B),A=arb(R,S,B).

/* Interogati:
?- arbsort([2,1,0,3,2,0,1,-1,3,0,-1],S).
?- arbsort([2,1,0,3,2,0,1,-1,3,0,-1],S),write(S).
 */

/*  Odata cu sortarea cu arbori binari de cautare, sa scriem, intr-un fisier arbcaut.txt, care e creat si deschis
de predicatul predefinit tell/1 (predicat unar; in aceasta scriere, 1 reprezinta aritatea, adica numarul de argumente),
dar poate fi si suprascris la urmatoarea apelare a predicatului arbsortfis/2 (predicat binar) de mai jos,
si este inchis de predicatul predefinit told/0 (predicat zeroar), arborele de cautare creat de predicatul crearb,
ca termen Prolog si grafic, crescand din stanga ecranului, impreuna cu lista obtinuta prin sortare. */

arbsortfis(L,S) :- tell('d:\\temporar\\arbcaut.txt'),crearb(L,A),ino(A,S),write(A),nl,write(S),nl,repr(A),told.

/* Eventual modificand in prealabil calea catre fisierul pentru scriere arbcaut.txt, interogati:
?- arbsortfis([2,1,-2,0,5,10,3,2,0,1,-1,3,0,-1],S).
apoi consultati fisierul arbcaut.txt. */



%liniar liste termeni arbori expresii.pl
/* A se revedea urmatoarele predicate din lectia de laborator atasata Cursului I si lectia video screenshot
in care acestea sunt descrise. Observati ca am modificat definitia predicatului identice: chiar daca X si Y
sunt constante, le aplic operatorul "=..", si recurenta se opreste cand aceste liste sunt de lungime 1: */

identicelist([],[]).
identicelist([H|T],[K|U]) :- identice(H,K), identicelist(T,U).

identice(X,Y) :- nonvar(X), nonvar(Y), X=..L, Y=..M, (L=[A], M=[A]; L=[_,_|_], M=[_,_|_], identicelist(L,M)). 
identice(X,Y) :- var(X), var(Y). 

numaraparitii(_,[],0).
numaraparitii(X,[H|T],N) :- identice(X,H), numaraparitii(X,T,K), N is K+1.
numaraparitii(X,[H|T],N) :- not(identice(X,H)), numaraparitii(X,T,N).

/* Si o implementare a predicatului de mai sus in care se cauta in lista numai termenii literal identici cu
elementul cautat, deci coincizand cu acesta inclusiv in numele variabilelor care apar in acesti termeni: */

numardeaparitii(_,[],0).
numardeaparitii(X,[H|T],N) :- X==H, numardeaparitii(X,T,K), N is K+1.
numardeaparitii(X,[H|T],N) :- X\==H, numardeaparitii(X,T,N).

/* Urmatorul predicat "liniarizeaza" listele de liste, adica inlocuieste orice element de tip lista X al unei liste L
cu o sublista a lui L formata din elementele listei X, si itereaza procedeul, pentru elementele de tip lista ale lui X.
Spre exemplu, dati interogarile:
?- liniarlist([a,b,[1,2,3],c],ListaRezultat).
?- liniarlist([a,b,[1,2,3,f(X,Y)],c,f(A,B)],ListaRezultat).
?- liniarlist([a,b,[1,2,3],c,f(A,B),[4,X,5,[Y,Z,g(d)],f(6,7)],ListaRezultat).
?- liniarlist([a,b,[1,2,3],c,X,Y,[4,5,[p,q]],Z,d,[6,7,8,[r,s,[9,[t,u,v,T,U,w,x]]],[y,[10,11]],z,W]],ListaRezultat).
Observati dubla recursie, realizata cu predicatul auxiliar liniarelem, care permite si interogari de forma:
?- liniarelem([a,b,[1,2,3],c],ListaRezultat).
?- liniarelem(X,ListaRezultat).
?- liniarelem(f(X),ListaRezultat).
astfel ca, daca primul argument nu e lista, sa nu se intoarca false, ci lista cu acel argument ca unic element.
*/



liniarelem(X,[]) :- nonvar(X), X=[].
liniarelem(X,LX) :- nonvar(X), X=[_|_], liniarlist(X,LX).
liniarelem(X,[X]) :- var(X) ; nonvar(X), X\=[], X\=[_|_].

liniarlist(L,[]) :- nonvar(L), L=[].
liniarlist(L,LL) :- nonvar(L), L=[H|T], liniarelem(H,LH), liniarlist(T,LT), concat(LH,LT,LL).

/* Urmatorul predicat "liniarizeaza" termenii, transformandu-i in liste de nume de operatii si variabile
(liste liniarizate, intrucat listele sunt fie termenul constant [], fie termeni cu operatia dominanta binara [|]).
Dati interogarile:
?- liniarterm(X,ListaRezultat).
?- liniarterm(c,ListaRezultat).
?- liniarterm(f(X),ListaRezultat).
?- liniarterm(g(f(X),f(c)),ListaRezultat).
?- liniarterm(g(f(X),g(f(c),f(f(Y)))),ListaRezultat).
?- liniarterm([a,b,[1,2,3],c],ListaRezultat),write(ListaRezultat).
?- liniarterm([a,f(X),b,[1,g(f(X),f(c)),2,3,[t,u]],c],ListaRezultat),write(ListaRezultat).
In scrierea listei rezultat cu predicatul write, numele de variabile vor fi inlocuite cu nume de variabile temporare.
La fel pentru numele de variabile din termenii afisati cu predicatul write in interogarile de mai jos.
*/

liniarterm(X,[X]) :- var(X).
liniarterm(X,LX) :- nonvar(X), X=..L, (L=[_], LX=L; L=[H,K|T], liniarterm(H,LH), liniartermlist([K|T],LL), concat(LH,LL,LX)).

liniartermlist(L,[]) :- nonvar(L), L=[].
liniartermlist(L,LL) :- nonvar(L), L=[H|T], liniarterm(H,LH), liniartermlist(T,LT), concat(LH,LT,LL).

/* Urmatorul predicat transforma un termen in arborele oarecare nevid asociat expresiei date de acel termen. Predicatul auxiliar
listarblistterm transforma o lista de termeni in lista arborilor asociati acelor termeni. Desigur, termenii pot fi si liste.
Dati interogarile:
?- arbterm(a,ArbExpr).
?- arbterm(X,ArbExpr).
?- arbterm(g(f(X),g(f(c),f(f(Y)))),ArbExpr), write(ArbExpr).
?- arbterm([a,b,[1,2,3],c],ArbExpr).
?- arbterm(h(a,b,[1,2,3],h(x,f(Y),z,g(c,f(d)))),ArbExpr), write(ArbExpr).
*/

arbterm(X,arb(X,[])) :- var(X).
arbterm(X,AX) :- nonvar(X), X=..L, (L=[H], AX=arb(H,[]); L=[H,K|T], listarblistterm([K|T],ListSubarb), AX=arb(H,ListSubarb)).

listarblistterm(L,[]) :- nonvar(L), L=[].
listarblistterm(L,[AH|LAT]) :- nonvar(L), L=[H|T], arbterm(H,AH), listarblistterm(T,LAT).

/* Urmatorul predicat transforma un termen format numai cu variabile, constante, operatii unare si operatii binare intr-un
arbore binar nevid asociat expresiei date de acel termen. Desigur, termenul poate fi si o lista de termeni formati cu astfel
de operatii, intrucat [] este o constanta, iar [|] este o operatie binara. Observati ca am supraincarcat operatorul arb,
care este binar in predicatul anterior si ternar in predicatul de mai jos. Dati interogarile:
?- arbbinterm(a,ArbBinExpr).
?- arbbinterm(X,ArbBinExpr).
?- arbbinterm(f(X),ArbBinExpr).
?- arbbinterm(g(X,Y),ArbBinExpr).
?- arbbinterm(g(f(X),g(f(c),f(f(Y)))),ArbBinExpr).
?- arbbinterm([a,b,[1,2,3],c],ArbBinExpr).
?- arbbinterm([a,b,[1,2,3],c,X,Y,[4,5,[p,q]],Z,d,[6,7,8,[r,s,[9,[t,u,v,T,U,w,x]]],[y,[10,11]],z,W]],ArbBinExpr), write(ArbBinExpr).
?- arbbinterm(h(a,b,[1,2,3],h(x,f(Y),z,g(c,f(d)))),ArbBinExpr).
Raspunsul la ultima interogare de mai sus este false, pentru ca termenul contine operatia h de aritate 4.
*/

arbbinterm(X,arb(X,nil,nil)) :- var(X).
arbbinterm(X,AX) :- nonvar(X), X=..L, (L=[R], AX=arb(R,nil,nil); 
L=[R,S], arbbinterm(S,AS), AX=arb(R,AS,nil);  L=[R,S,D], arbbinterm(S,AS), arbbinterm(D,AD), AX=arb(R,AS,AD)).
arbbinterm(X,AX) :- nonvar(X), X=..[H1,H2|T],length([H1,H2|T],A),A>3,arbbinterm(H2,AS),AX=arb(H1,AS,[H2|T]).


/* Acum incarcati in Prolog fisierul arbbin.pl din lectia cu arbori binari, si dati urmatoarele interogari, in care folosim predicatul
repr din acest fisier pentru reprezentarea arborilor binari asociati expresiilor de mai sus crescand din stanga ecranului spre dreapta:
?- arbbinterm(f(X),ArbBinExpr), repr(ArbBinExpr).
?- arbbinterm(g(X,Y),ArbBinExpr), repr(ArbBinExpr).
?- arbbinterm(g(f(X),g(f(c),f(f(Y)))),ArbBinExpr), repr(ArbBinExpr).
?- arbbinterm([a,b,[1,2,3],c],ArbBinExpr), repr(ArbBinExpr).
?- arbbinterm([a,b,[1,2,3],c,X,Y,[4,5,[p,q]],Z,d,[6,7,8,[r,s,[9,[t,u,v,T,U,w,x]]],[y,[10,11]],z,W]],ArbBinExpr), repr(ArbBinExpr).
*/