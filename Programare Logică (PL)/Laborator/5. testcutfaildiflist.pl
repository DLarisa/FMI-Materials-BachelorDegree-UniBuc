/* Predicatul "fail" intotdeauna esueaza, adica e evaluat la false.
Exemplu de utilizare: cum putem colecta instantele unui predicat fara findall/bagof/setof?
O varianta este sa facem predicatul sa esueze dupa fiecare instanta gasita, astfel incat, pentru a-l satisface,
Prologul sa trebuiasca sa caute celelalte instante, ca in predicatul scrie_toti_prietenii de mai jos. Interogati:
?- scrie_prieteni.  %%% aici va trebui sa cereti toate instantele, cu ";"/"Next"
?- scrie_toti_prietenii.
*/

prieteni(ana,alex).
prieteni(ana,maria).
prieteni(maria,elena).
prieteni(mihai,valentin).
prieteni(valentin,ecaterina).

scrie_prieteni :- prieteni(X,Y), write(prieteni(X,Y)).

scrie_toti_prietenii :- prieteni(X,Y), write(prieteni(X,Y)), write(','), fail.

% Predicatul predefinit cut ("!") are functia de a taia backtrackingul executat pentru satisfacerea unui scop dintr-o interogare:

membru(_,[]) :- fail.
membru(H,[H|_]).
membru(X,[_|T]) :- membru(X,T).

apartine(_,[]) :- fail.
apartine(H,[H|_]) :- !.
apartine(X,[_|T]) :- apartine(X,T).

/* Dati interogarile:
?- membru(a,[X,a,1,Y,a,a,2,3]).
?- apartine(a,[X,a,1,Y,a,a,2,3]).
si cereti toate variantele de satisfacere (cu ";"/"Next").
*/

/* Faptele si regulile sunt aplicate in ordinea in care sunt scrise in baza de cunostinte.
De exemplu, implementarea predicatului predefinit "not" sau "\+" este:
not(P) :- P,!,fail.  %%% esueaza daca P e adevarat, si taie backtrackingul
not(_). %%% in caz contrar, deci cand P e fals, e satisfacut
Avand in vedere ca un termen X e variabila ddaca X unifica, cu doua constante diferite a si b,
putem folosi not pentru a implementa un predicat care functioneaza precum cel predefinit "var":
*/

variabila(X) :- not(not(X=a)),not(not(X=b)).

fibo(N,X,Y) :- Z is X+Y, ((Z>N, !); (Z=<N, write(Z), write(','), fibo(N,Y,Z))).

/* Daca Z a depasit pe N, se taie backtrackingul; altfel se continua generarea sirului.
Disjunctia logica ";" de mai sus are rol de "sau exclusiv", pentru ca am separat cazurile in Z>N si Z=<N.
Pentru afisarea elementelor mai mici sau egale cu 5000 ale sirului lui Fibonacci, dati interogarea:
?- fibo(5000,0,1).
Prologul desktop raspunde imediat si la interogarea:
?- fibo(10000000000000,0,1).
*/ 

% Putem modifica predicatul de mai sus astfel incat sa generam sirul lui Fibonacci intr-o lista:

concat([],L,L).
concat([H|T],L,[H|M]) :- concat(T,L,M).

inversa([],[]).
inversa([H|T],L) :- inversa(T,M), concat(M,[H],L).

sirfibo(N,X,Y,L,S) :- Z is X+Y, ((Z>N, inversa(L,S), !); (Z=<N, write(Z), write(','), sirfibo(N,Y,Z,[Z|L],S))).

fibonacci(N,S) :- sirfibo(N,0,1,[0,1],S),nl,write(S).

/* Dati interogarea:
?- fibonacci(10000,S).
Dar cum putem evita inversarea listei la finalul executiei predicatului "fibonacci"? Concatenarea de mai sus functioneaza in timp liniar
dupa lungimea primului sau argument (pentru ca, in regula din definitia sa, elementele listei [H|T] sunt adaugate unul cate unul la lista L),
asadar ar fi contraproductiv sa o folosim la fiecare pas al executiei lui "sirfibo" pentru a adauga cate un element la sfarsitul listei L.
In schimb, urmatoarea varianta de concatenare functioneaza in timp constant, si la fel si predicatul "adelem" pentru adaugarea unui element
la sfarsitul unei liste; pe acesta din urma il folosim pentru o alta varianta de generare a sirului lui Fibonacci.
Pentru implementarea urmatoarelor predicate pentru lucrul cu liste, folosim un operator binar infixat "-" cu operanzii de tip lista, cu
semnificatia urmatoare: pentru orice elemente X1,...,Xn si orice lista T, [X1,...,Xn|T]-T va reprezenta lista [X1,...,Xn]; nu definim efectiv
acest operator, adica nu va da lista [X1,...,Xn] ca rezultat al diferentei de liste [X1,...,Xn|T]-T, ci folosim aceasta reprezentare a listelor
pentru a defini predicate de tipul concatenarii care sa dea rezultatul interogarilor in timp constant in loc de timp liniar.
*/

concatdif(K-L,L-M,K-M).  /* Nu vom folosi aceasta varianta de concatenare pentru urmatoarea generare a sirului lui Fibonacci. Sa retinem doar ca
poate fi utilizata in interogari de forma urmatoare: daca dorim sa obtinem intr-o lista L concatenarea listei [1,2,3] cu lista [a,b], interogam:
?- concatdif([1,2,3|T]-T, [a,b,c,d|U]-U, L).
si obtinem rezultatul concatenarii sub forma L=[1,2,3,a,b,c,d|U]-U.
*/

concatdif(K-L,L-M,K-M).

/* Urmatorul predicat poate fi folosit in interogari de forma:
?- adelem([1,2,3,4,5|T]-T,a,L).
iar lista L obtinuta prin adaugarea elementului "a" la sfarsitul listei [1,2,3,4,5] va fi obtinuta sub forma L=[1,2,3,4,5,a|U]-U.
*/

adelem(L-[H|T],H,L-T).

sirfib(N,X,Y,L,S) :- Z is X+Y, ((Z>N, L=S, !); (Z=<N, write(Z), write(','), adelem(L,Z,M), sirfib(N,Y,Z,M,S))).

fib(N,S) :- sirfib(N,0,1,[0,1|T]-T,S),nl,write(S).

/* Interogati la fel ca pentru predicatul "fibonacci":
?- fib(100,S).
?- fib(1000000,S).
*/
