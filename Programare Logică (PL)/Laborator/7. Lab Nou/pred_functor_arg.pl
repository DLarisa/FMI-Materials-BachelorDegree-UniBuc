/* Sa scriem un predicat "toarbbin" care transforma un arbore oarecare in arbore binar pastrand doar primii doi subarbori
ai radacinii si iterand acest procedeu. Operatorul binar arb(Radacina,ListaSubarbori) va da arborii oarecare, iar operatorul
ternar arb(Radacina,SubarboreStang,SubarboreDrept) va construi arborii binari. Constanta "nil" va reprezenta arborele vid. */

toarbbin(nil,nil).
toarbbin(arb(Frunza,[]),arb(Frunza,nil,nil)).
toarbbin(arb(Radacina,[UnicSubarb]),arb(Radacina,SubarbStg,nil)) :- toarbbin(UnicSubarb,SubarbStg).
toarbbin(arb(Radacina,[Arb1,Arb2|_]),arb(Radacina,SubarbStg,SubarbDr)) :- toarbbin(Arb1,SubarbStg),toarbbin(Arb2,SubarbDr).

/* Acum sa modificam predicatul de mai sus inlocuind arborii binari cu arbori oarecare reprezentati sub forma:
              arb(Radacina,Subarb1,Subarb2,...,SubarbN).
Nu se va sterge niciun subarbore al arborelui oarecare, i se va schimba doar modul de reprezentare.
A se vedea predicatul "=.." in lectiile anterioare. Dati urmatoarea interogare:
?- T=..[fct,1,a,X,g(X,f(Y)),g(1,2),f(Z),f(a)].
Observati ca acest predicat functioneaza si cu variabila in membrul stang: construieste un termen dintr-o lista. */

transfarb(_,nil,nil).
transfarb(arb(Frunza,[]),arb(Frunza)).
transfarb(arb(Radacina,[Arb|Listarb]),A) :- transflistarb([Arb|Listarb],L), A=..[arb,Radacina|L]. 

transflistarb([Arb],[A]) :- transfarb(Arb,A).
transflistarb([Arb1,Arb2|ListArb],[A|LA]) :- transfarb(Arb1,A), transflistarb([Arb2|ListArb],LA).

/* Dati interogarile:
?- toarbbin(arb(r,[arb(r1,[]),arb(r2,[arb(r21,[]),arb(r22,[arb(r221,[])]),arb(r23,[])]),arb(r3,[]),arb(r4,[]),arb(r5,[arb(r51,[])])]),A).
?- transfarb(arb(r,[arb(r1,[]),arb(r2,[arb(r21,[]),arb(r22,[arb(r221,[])]),arb(r23,[])]),arb(r3,[]),arb(r4,[]),arb(r5,[arb(r51,[])])]),A).
Acum sa testam predicatele functor(Termen,OperatorDominant,Aritate) si arg(N,Termen,Argumentul_alNlea):
?- functor(fct(1,a,X,g(X,f(Y)),g(1,2),f(Z),f(a)),Op,Nr).
?- functor(T,fct,7).
?- arg(4,fct(1,a,X,g(X,f(Y)),g(1,2),f(Z),f(a)),Arg).
Si acum sa gasim al 5-lea subarbore al radacinii arborelui produs de interogarea cu "transfarb" de mai sus:
?- transfarb(arb(r,[arb(r1,[]),arb(r2,[arb(r21,[]),arb(r22,[arb(r221,[])]),arb(r23,[])]),arb(r3,[]),arb(r4,[]),arb(r5,[arb(r51,[])])]),Arb), arg(6,Arb,Subarborele).
Putem folosi un fisier text, in care sa scriem astfel de arbori ca termeni urmati de punct - lasati Prologul sa creeze acest fisier, modificand, daca e nevoie, calea:
?- tell('d:\\temporar\\arb_cu_aritate_variabila.txt').
?- transfarb(arb(r,[arb(r1,[]),arb(r2,[arb(r21,[]),arb(r22,[arb(r221,[])]),arb(r23,[])]),arb(r3,[]),arb(r4,[]),arb(r5,[arb(r51,[])])]),Arb), write(Arb), write('.').
?- nl.
?- toarbbin(arb(r,[arb(r1,[]),arb(r2,[arb(r21,[]),arb(r22,[arb(r221,[])]),arb(r23,[])]),arb(r3,[]),arb(r4,[]),arb(r5,[arb(r51,[])])]),ArbBin), write(ArbBin), write('.').
?- told.
La interogarile cu "transfarb" si "toarbbin" nu cereti mai multe raspunsuri, deci nu apasati ";"/"Next"!
?- see('d:\\temporar\\arb_cu_aritate_variabila.txt'), read(Arb), arg(6,Arb,Subarborele), seen.
Acum sa aflam al doilea subarbore al celui de-al doilea subarbore al fiecaruia dintre cei doi arbori scrisi in fisierul text de mai sus:
?- see('d:\\temporar\\arb_cu_aritate_variabila.txt').
?- read(Arb), arg(3,Arb,Subarb), arg(3,Subarb,Subarborele).
?- read(Arb), arg(3,Arb,Subarb), arg(3,Subarb,Subarborele).
?- seen.
Chiar dupa ce acest fisier e inchis cu "seen" sau "told", va fi in continuare utilizat de interpretorul de Prolog.
Daca doriti sa-l cititi, modificati sau stergeti, va trebui sa inchideti interpretorul Prologului.
Daca doriti sa reveniti la citirea primului termen din acest fisier text cu predicatul "read", puteti inchide, apoi redeschide interpretorul Prologului.
*/
