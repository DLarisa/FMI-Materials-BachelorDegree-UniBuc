/* Predicatul care va gasi solutia rebusului dintr-o lista de cuvinte este: rebus(NrRanduri,NrColoane,ListaPauzeCareu,ListaCuvinte).
Dam cuvintele sub forma unor constante cu numele formate din litere mici sau siruri de caractere formate numai din litere mici, apoi
le transformam in liste de litere mici cu predicatul predefinit "string_chars", apoi, cu predicatul predefinit "asserta", adaugam la
baza de cunostinte termenii de forma cuvant(NrLitere,ListaLitere); putem calcula lungimile listelor formate ca mai sus sau putem
folosi predicatul predefinit "string_length": */

:- dynamic cuvant/2.
:- dynamic rand/2.
:- dynamic coloana/2.

formeaza_cuvinte([]).
formeaza_cuvinte([Cuvant|ListaCuvinte]) :- string_chars(Cuvant,ListaLitere), string_length(Cuvant,LungimeCuvant),
                                      asserta(cuvant(LungimeCuvant,ListaLitere)), formeaza_cuvinte(ListaCuvinte).

/* Tot cu "asserta" vom adauga la baza de cunostinte termeni de forma rand(Nr,ListaPauzeRandulNr) si coloana(Nr,ListaPauzeColoanaNr); sa
presupunem ca nu dam pauzele (Rand,Coloana) din ListaPauzeCareu neaparat in ordine crescatoare; putem implementa comod, folosind si predicatul
predefinit "retract", precum si un predicat "insert" care insereaza un numar intr-o lista sortata astfel incat lista sa ramana sortata: */

insert(X,[],[X]).
insert(X,[H|T],[X,H|T]) :- X=<H.
insert(X,[H|T],[H|L]) :- X>H, insert(X,T,L).

randuri_vide(0).
randuri_vide(N) :- N>0, asserta(rand(N,[])), M is N-1, randuri_vide(M).

coloane_vide(0).
coloane_vide(N) :- N>0, asserta(coloana(N,[])), M is N-1, coloane_vide(M).

formeaza_careul(NrRanduri,NrColoane,[]) :- randuri_vide(NrRanduri), coloane_vide(NrColoane).
formeaza_careul(NrRanduri,NrColoane,[(R,C)|ListaPauze]) :- formeaza_careul(NrRanduri,NrColoane,ListaPauze), 
                                             retract(rand(R,LpR)), insert(C,LpR,LPR), asserta(rand(R,LPR)), 
                                       retract(coloana(C,LpC)), insert(R,LpC,LPC), asserta(coloana(C,LPC)).

concat([],L,L).
concat([H|T],L,[H|M]) :- concat(T,L,M).

orizontala(N,NrColoane,LiniaOriz) :- rand(N,LP), Capat is NrColoane+1, concat([0|LP],[Capat],LPBordata), constr_linie(LPBordata,[#|LiniaOriz]).

verticala(N,NrRanduri,LiniaVert) :- coloana(N,LP), Capat is NrRanduri+1, concat([0|LP],[Capat],LPBordata), constr_linie(LPBordata,[#|LiniaVert]).

constr_linie([_],[]). 
constr_linie([P1,P2|T],Linie) :- constr_linie([P2|T],SfarsitLinie), Dif is P2-P1-1, (Dif=0,L=[] ; Dif>0,cuvant(Dif,L)), concat([#|L],SfarsitLinie,Linie). 

primelem([],[]).
primelem([[H|_]|ListaListe],[H|Lista]) :- primelem(ListaListe,Lista).

taieprimelem([],[]).
taieprimelem([[_|T]|ListaListe],[T|Liste]) :- taieprimelem(ListaListe,Liste).

compara([[]|_],[]).
compara(ListaLiniiOriz,[Vert|ListaVert]) :- primelem(ListaLiniiOriz,Vert), taieprimelem(ListaLiniiOriz,ListaOriz), compara(ListaOriz,ListaVert).
 
formeaza_orizontalele(0,_,[]).
formeaza_orizontalele(N,NrColoane,ListaOrizontale) :- N>0, orizontala(N,NrColoane,Oriz), M is N-1,formeaza_orizontalele(M,NrColoane,ListaOriz),
                                                      concat(ListaOriz,[Oriz],ListaOrizontale).

formeaza_verticalele(0,_,[]).
formeaza_verticalele(N,NrRanduri,ListaVerticale) :- N>0, verticala(N,NrRanduri,Vert), M is N-1, formeaza_verticalele(M,NrRanduri,ListaVert),
                                                    concat(ListaVert,[Vert],ListaVerticale).

rebus(NrRanduri,NrColoane,ListaPauzeCareu,ListaCuvinte) :- formeaza_careul(NrRanduri,NrColoane,ListaPauzeCareu), formeaza_cuvinte(ListaCuvinte),
                            formeaza_orizontalele(NrRanduri,NrColoane,ListaLiniiOriz), formeaza_verticalele(NrColoane,NrRanduri,ListaLiniiVert),
                            compara(ListaLiniiOriz,ListaLiniiVert), scrie(ListaLiniiOriz).

scrie([]).
scrie([Oriz|ListaLiniiOriz]) :- string_chars(OrizontalacaSir,Oriz), write(OrizontalacaSir), nl, scrie(ListaLiniiOriz).

% Dupa o interogare, putem da retractall pentru a putea da o alta interogare fara a suprapune bazele de cunostinte:

retractall :- findall(cuvant(N,L),cuvant(N,L),LCuv), findall(rand(R,LPR),rand(R,LPR),LR), findall(coloana(C,LPC),coloana(C,LPC),LCol),
              concat(LCuv,LR,List), concat(List,LCol,Lista), retractlist(Lista).

retractlist([]).
retractlist([H|T]) :- retract(H), retractlist(T).

/* Dati interogarile urmatoare, si cereti toate solutiile, cu ";"/"Next" (pentru a obtine toate solutiile, nu putem da "retractall" in definitia lui "rebus"):
?- rebus(3,5,[(1,2),(2,1),(1,5)],[s,as,eter,stele,et,ate,sel,re]).
?- retractall.
?- rebus(3,5,[(1,2),(2,1),(1,5)],[a,x,s,as,eter,stele,et,ate,sel,re]).
?- retractall.
?- rebus(3,5,[(1,2),(2,1),(1,5)],[s,as,eter,stele,et,ate,sel,re,ax,xel]).
?- retractall.
Acum sa optimizam definitia predicatului "rebus", folosind faptul ca predicatul "compara" functioneaza si sub forma:
?- compara([[a,#,b],[#,c,a]],CuCe).
*/

formeaza_randuri(NrRanduri,[]) :- randuri_vide(NrRanduri).
formeaza_randuri(NrRanduri,[(R,C)|ListaPauze]) :- formeaza_randuri(NrRanduri,ListaPauze), retract(rand(R,LpR)), insert(C,LpR,LPR), asserta(rand(R,LPR)).

rebusop(NrRanduri,NrColoane,ListaPauzeCareu,ListaCuvinte) :- formeaza_randuri(NrRanduri,ListaPauzeCareu), formeaza_cuvinte(ListaCuvinte),
                                       formeaza_orizontalele(NrRanduri,NrColoane,ListaLiniiOriz), compara(ListaLiniiOriz,ListaLiniiVert),
                                       testeaza_verticalele(ListaLiniiVert), scrie(ListaLiniiOriz).

testeaza_verticalele([]).
testeaza_verticalele([Vert|ListaVert]) :- test_verticala(Vert,[]), testeaza_verticalele(ListaVert).

test_verticala([],[]).
test_verticala([],[L|LL]) :- cuvant(_,[L|LL]).
test_verticala([#|T],[]) :- test_verticala(T,[]).
test_verticala([#|T],[L|LL]) :- cuvant(_,[L|LL]), test_verticala(T,[]).
test_verticala([H|T],C) :- H \= #, concat(C,[H],D), test_verticala(T,D).

/* Dati interogarile:
?- rebusop(5,6,[(1,6),(4,4),(4,6),(5,3),(5,5)],[radar,avatar,satira,ara,a,da,ra,rasad,rasar,avara,data,ati,rara]).
?- retractall.
?- rebusop(7,6,[(1,6),(4,4),(4,6),(5,3),(5,5),(6,2)],[radar,avatar,satira,ara,a,ra,e,i,avar,turela,rasarit,avara,u,data,ar,ati,ave,rara,al,era]).
?- retractall.
Prologul desktop raspunde la interogarea anterioara cu o intarziere (de cateva secunde pe laptopul meu).
Aceasta implementare nu este destul de eficienta pentru careuri de dimensiunea celui din rebusop.pl:
?- rebusop(7,7,[(1,1),(1,3),(1,5),(1,7),(3,1),(3,3),(3,5),(3,7),(5,1),(5,3),(5,5),(5,7),(7,1),(7,3),(7,5),(7,7)],[abalone,abandon,anagram,connect,elegant,enhance,a,c,e,m,n,t]).
Nu am avut curiozitatea sa las aceasta din urma interogare sa ruleze pana da un raspuns.
*/
