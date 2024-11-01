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

concat([],L,L).
concat([H|T],L,[H|M]) :- concat(T,L,M).

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
arbbinterm(X,AX) :- nonvar(X), X=..L, (L=[R], AX=arb(R,nil,nil); L=[R,S], arbbinterm(S,AS), AX=arb(R,AS,nil);  L=[R,S,D], arbbinterm(S,AS), arbbinterm(D,AD), AX=arb(R,AS,AD)).

/* Acum incarcati in Prolog fisierul arbbin.pl din lectia cu arbori binari, si dati urmatoarele interogari, in care folosim predicatul
repr din acest fisier pentru reprezentarea arborilor binari asociati expresiilor de mai sus crescand din stanga ecranului spre dreapta:
?- arbbinterm(f(X),ArbBinExpr), repr(ArbBinExpr).
?- arbbinterm(g(X,Y),ArbBinExpr), repr(ArbBinExpr).
?- arbbinterm(g(f(X),g(f(c),f(f(Y)))),ArbBinExpr), repr(ArbBinExpr).
?- arbbinterm([a,b,[1,2,3],c],ArbBinExpr), repr(ArbBinExpr).
?- arbbinterm([a,b,[1,2,3],c,X,Y,[4,5,[p,q]],Z,d,[6,7,8,[r,s,[9,[t,u,v,T,U,w,x]]],[y,[10,11]],z,W]],ArbBinExpr), repr(ArbBinExpr).
*/
