/*
lungime/2.
concat/3.
inversa/2.
etc.
*/

/*
Formatul in care se scriu listele in Prolog:
[] este lista vida; pentru liste nevide:
[elemente separate prin virgula] sau
[primele elemente separate prin virgula|coada listei]
De exemplu: [1,2,3]=[1|[2,3]]=[1,2|[3]]=[[1,2,3]|[]].
De asemenea: [1,2,3]=[1|[2|[3]]] etc.
*/

all_a([]).
all_a([a|T]) :- all_a(T).

%putem intreba: all_a([a,X,Y,a,Z]).

maxim(X,Y,X) :- X>Y.
maxim(X,Y,Y) :- X=<Y.

max([X],X).
max([A,B|T],M) :- max([B|T],N), maxim(A,N,M).

lungime([],0).
lungime([_|T],X) :- lungime(T,Y),X is Y+1.

/*
numar_aparitii(_,[],0).
numar_aparitii(H,[H|T],N) :- numar_aparitii(H,T,K), N is K+1.  %%% (*)
numar_aparitii(X,[H|T],N) :- X\=H, numar_aparitii(X,T,N).

Daca implementam astfel acest predicat, atunci, la o interogare de forma:
?- numar_aparitii(a,[X,a,1,a,a,2,3,Y,a,4,Z],DeCateOriApare_a_inAceastaLista).
regula marcata cu (*) mai sus produce unificarea lui "a" cu capul listei,
asa ca variabilele X,Y si Z vor fi unificate cu "a", iar variabila
DeCateOriApare_a_inAceastaLista va lua valoarea 7.

Dati interogarea de mai sus pentru urmatoarea varianta de implementare
a acestui predicat, care nu numara si variabilele din lista:
*/

numar_aparitii(_,[],0).
numar_aparitii(X,[H|T],N) :- var(H), numar_aparitii(X,T,N).
numar_aparitii(X,[H|T],N) :- nonvar(H), X=H, numar_aparitii(X,T,K), N is K+1.
numar_aparitii(X,[H|T],N) :- X\=H, numar_aparitii(X,T,N).

%Testeaza daca o lista de liste e ordonata
%crescator dupa lungimea elementelor sale:

cresclung([]).
cresclung([_]). % sau: cresclung([[]]). cresclung([[_|_]]).
% aceasta a doua varianta testeaza ca avem o lista de liste
cresclung([L,M|LL]) :- lungime(L,K),lungime(M,N),K=<N,cresclung([M|LL]).

scalarMult(_,[],[]).
scalarMult(N,[H|T],[X|L]) :- X is N*H,scalarMult(N,T,L).

dot([],[],0).
dot([A|L],[B|M],P) :- dot(L,M,S),P is A*B+S.

concat([],L,L).
concat([H|T],L,[H|M]) :- concat(T,L,M).

/*
Putem intreba care liste concatenate dau aceasta lista:
?- concat(Lista1,Lista2,[1,2,3,4]).
*/

inversa([],[]).
inversa([H|T],L) :- inversa(T,M),concat(M,[H],L).

palindrome(L) :- inversa(L,L).

/*Se pot da si interogari de tipul:
?- palindrome([a,X,1,Y,X,Z,a]).
*/

palindrom(N) :- listacifre(N,L),palindrome(L).

listacifre(N,[N]) :- N<10.
listacifre(N,[H|T]) :- N>9,H is N mod 10,K is N div 10,listacifre(K,T).

listacifrelor(N,L) :- listacifre(N,M),inversa(M,L).

suma([],0).
suma([H|T],X) :- suma(T,Y),X is Y+H.

factorial(0,1).
factorial(X,F) :- X>0,Y is X-1,factorial(Y,G),F is G*X.

sirfib(1,[0]).
sirfib(2,[1,0]).
sirfib(N,L) :- N>2,M is N-1,sirfib(M,[Y,X|T]),Z is X+Y,L=[Z,Y,X|T].

fibonacci(N,F) :- sirfib(N,[F|_]).

sirfibonacci(N,L) :- sirfib(N,M),inversa(M,L).

/*
Un comportament bizar al Prolog-ului este sa nu afiseze listele care
satisfac predicatele din interogari decat sub forma [primele elemente|...],
asadar, pentru afisarea sirului lui Fibonacci, recomand interogari de tipul:
?- sirfibonacci(15,L),write(L).
Folosirea sirului lui Fibonacci pentru a calcula al N-lea termen al sau, in
locul unui calcul recursiv obisnuit, este justificata de faptul ca acel
simplu calcul recursiv presupune recalculari masive, redundante, deci e mult
mai ineficient. O solutie pentru a face un simplu calcul recursiv este ca,
la calcularea fiecarui termen din sirul lui Fibonacci pana la termenul dorit,
noul termen calculat sa fie adaugat la inceputul bazei de cunostinte, in mod
dinamic (adica in timpul executiei), cu predicatul asserta, ca mai jos.
Observati ca am folosit predicatul cut(!), care taie backtracking-ul, pentru
ca Prolog-ul sa nu caute sa satisfaca predicatul fibo(ordin,TermenSirFib) in
toate modurile posibile, ci sa dea unica solutie posibila pentru TermenSirFib,
apoi sa incheie executia. Fara !, dupa ce calculeaza fibo(N,?) folosind 
clauzele adaugate cu asserta, merge la regula din definitia lui fibo si reia
calculul.
*/

fibo(1,0).
fibo(2,1).
fibo(N,F) :- M is N-1,P is N-2,fibo(P,G),fibo(M,H),F is G+H,asserta(fibo(N,F)),!.

scris([]) :- write(*).
scris([X]) :- write(X).
scris([A,_|T]) :- write(A),write(*),scris(T).

scriscutab([]) :- write(*).
scriscutab([X]) :- tab(X).
scriscutab([A,_|T]) :- tab(A),write(*),scriscutab(T).
 
%Testeaza daca o lista e ordonata crescator:

ecresc([]).
ecresc([_]).
ecresc([X,Y|T]) :- X=<Y,ecresc([Y|T]).

%Testeaza daca o lista de liste are toate elementele ordonate crescator:

toatecresc([]).
toatecresc([L|LL]) :- ecresc(L),toatecresc(LL).

%Testeaza daca, intr-o lista, cresterile si descresterile alterneaza:

ealtern(L) :- alt1(L) ; alt2(L).

alt1([]).
alt1([_]).
alt1([X,Y|T]) :- X=<Y,alt2([Y|T]).

alt2([]).
alt2([_]).
alt2([X,Y|T]) :- X>=Y,alt1([Y|T]).

/*Pentru a obtine toate raspunsurile posibile la intrebari de tipul:
?- sublista(S,[1,2,3]),
dupa fiecare raspuns, se da ; in loc de ENTER, in SWI-Prolog-ul instalat
local, si ; sau NEXT sau numarul de urmatoare instante pe care dorim sa
le afiseze, sau, daca am dat trace, sagetuta in jos, in SWISH SWI-Prolog-ul
online.*/

/*Subliste cu elementele in ordine, dar nu neaparat pe pozitii
consecutive in lista mare:*/

%testeaza corect sublistele, dar genereaza doar prefixele:

sl([],_).
sl([_|_],[]) :- fail.
sl([H|T],[H|L]) :- sl(T,L).
sl([H|T],[X|L]) :- H\=X,sl([H|T],L).

/*testeaza corect sublistele, dar le genereaza cu duplicate, intrucat
cauta [] in toate sufixele listei initiale si, pentru fiecare sufix,
genereaza o aceeasi sublista cu coada []:*/

subl([],_).
subl([_|_],[]) :- fail.
subl([H|T],[H|L]) :- subl(T,L).
subl(T,[_|L]) :- subl(T,L).

%testeaza corect sublistele, si le genereaza pe toate, fara duplicate:

sublista([],_).
sublista([_|_],[]) :- fail.
sublista([H|T],[H|L]) :- sublista(T,L).
sublista([H|T],[_|L]) :- sublista([H|T],L).

/*Subliste cu elementele in ordine si pe pozitii consecutive in
lista mare, generate corect:*/

prefix([],_).
prefix([_|_],[]) :- fail.
prefix([H|T],[H|L]) :- prefix(T,L).

slconsec([],_).
slconsec([_|_],[]) :- fail.
slconsec([H|T],[X|L]) :- prefix([H|T],[X|L]) ; slconsec([H|T],L).

/*daca, in loc de [H|T], scriem T mai sus,
atunci sublistele sunt generate cu duplicate*/

/*Subliste cu elementele in ordine si pe pozitii consecutive in
lista mare: raspunde true corect, dar nu raspunde false (depaseste
stiva de lucru), si genereaza aceste subliste corect, dar, daca
mai cerem subliste la final, atunci depaseste stiva de lucru:*/

slcs([],_).
slcs([H|T],L) :- concat(_,[H|T],M),concat(M,_,L).

slcsc(S,L) :- concat(_,S,M),concat(M,_,L).

/*daca scriam aici T in loc de [H|T] mai sus,
atunci genera aceste subliste cu duplicate*/

permcirc([],[]).
permcirc([H|T],L) :- concat(T,[H],L).

lpermcirc(L,L,[L]).
lpermcirc(L,M,[M|LP]) :- L\=M,permcirc(M,N),lpermcirc(L,N,LP).

listpermcirc(L,LP) :- permcirc(L,M),lpermcirc(L,M,LP),write(LP).

/*stergerea unei aparitii a unui element intr-o lista,
indiferent de pe ce pozitie:*/

sterge(X,[X|L],L).
sterge(X,[H|T],[H|L]) :- sterge(X,T,L).

/*daca scriam si: sterge(X,[],[]). mai sus, atunci sterge putea
sa lase lista nemodificata, iar urmatorul predicat genera si
permutarile sublistelor*/

permut([],[]).
permut([H|T],L) :- permut(T,M),sterge(H,L,M).

/*Predicatul permut de mai sus genereaza permutarile unei liste, dar,
daca lista e cu duplicate, atunci genereaza permutarile cu duplicate.
Pentru a obtine permutarile fara duplicate si in cazul in care lista
e cu duplicate, putem colecta instantele lui permut cu ajutorul
predicatului setof(V,p(...,V,...),L) (V=variabila ale carei instante
le colectam, p=predicatul care trebuie satisfacut de V, L=lista fara
duplicate a instantelor lui V care satisfac pe p), folosind una
dintre interogarile urmatoare:
?- setof(P,permut([1,1,a,a,a],P),LP).
?- setof(P,permut([1,1,a,a,a],P),LP),write(LP).
Putem scrie un predicat care intoarce aceasta lista a permutarilor
unei liste, ca predicatul listpermut de mai jos, si putem interoga:
?- listpermut([1,1,a,a,a],LP).
?- listpermut([1,1,a,a,a],LP),write(LP).
*/

listpermut(L,LP) :- setof(P,permut(L,P),LP),write(LP).

/*
A se vedea si predicatele bagof si findall, care fac acelasi lucru
ca setof, mai putin eliminarea duplicatelor. Interogati:
?- bagof(P,permut([1,1,a,a,a],P),LP),write(LP).
?- findall(P,permut([1,1,a,a,a],P),LP),write(LP).
*/

apartine(_,[]) :- fail.
apartine(X,[X|_]).
apartine(X,[_|T]) :- apartine(X,T).

/*
Interogati:
?- setof(X,apartine(X,[2,1,2,1,1,2,0,1]),L).
?- bagof(X,apartine(X,[2,1,2,1,1,2,0,1]),L).
?- findall(X,apartine(X,[2,1,2,1,1,2,0,1]),L).
*/
