%drawpathfile1(..) pentru subpunctul 1 si drawpathfile2(..) pentru subpunctul 2



connect((1,1),(1,2)).
connect((1,1),(2,1)).
connect((2,1),(2,2)).
connect((2,2),(3,2)).
connect((3,2),(3,3)).
connect((3,3),(4,3)).
connect((3,5),(4,5)).
connect((4,3),(4,4)).
connect((4,4),(4,5)).
connect((4,5),(4,6)).
connected(X,Y) :- connect(X,Y);connect(Y,X).
%H e celula pentru care vrem sa punem steluta
%aux(H,N,K) :-H is (O,P), undercellstar(O, P, ),N>0, M is N-1, drawmaze(M,K), nl, mazeline(N,K). 



%rightcell scrie : sau | intre celule in functie de faptul daca acestea sunt conectate sau nu
rightcell(N,K,H) :- connected((N,K),(N,H)),write(':').
rightcell(N,K,H) :- not(connected((N,K),(N,H))),write('|').
path(X,Y,Path) :- mazepath(X,Y,[X,Y],Path),write(Path).   %x si y sunt celule/tupluri
%path calculeaza drumul intre 2 celule- Path e lista de celule/drumul calculat
% in al treilea argument al lui mazepath retinem celulele vizitate pe drumul curent
mazepath(X,Y,_,[X,Y]) :- connected(X,Y).    %[x,y] e lista cu toate celulele parcurse, in final
%y fiind prima celula si x ultima
mazepath(X,Y,L,[X|T]) :- not(connected(X,Y)),connected(X,Z),not(member(Z,L)),mazepath(Z,Y,[Z|L],T).
%daca este sau nu membru al listei
member(_,[]) :- fail.
member(H,[H|_]).
member(X,[H|T]) :- H\=X,member(X,T).
%y e prima celula, x e celula de final, L e lista cu toate celulele parcurse de la inceput
%la sfarsit, retinuta in sens invers 
%N si K sunt coordonatele celulei curente
drawpath1(N,K,X,Y) :- path(X,Y,[H|T]),nl, aux1(H,N,K,T).
aux1(H,N,K,[]):-write("Pozitia curenta "), write(H),nl,
    drawmazestar1(H,N,K),nl.
aux1(H,N,K,[Head]):-write("Pozitia curenta "), write(H),nl,
    drawmazestar1(H,N,K),nl,aux1(Head,N,K,[]).
aux1(H,N,K,[Head|T]):-write("Pozitia curenta "), write(H),nl,
    drawmazestar1(H,N,K),nl,write("Next Round"),nl,aux1(Head,N,K,T).
%R e lista inversa a lui L
drawmazestar1(_,0,_).
drawmazestar1(H,N,K) :- N>0,M is N-1,drawmazestar1(H,M,K),nl,mazelinestar1(H,N,K). 
mazelinestar1(_,_,0).
mazelinestar1(H2,N,K) :- K>0,H is K-1,mazelinestar1(H2,N,H),drawcellstar1(H2,N,K).
drawcellstar1(H2,N,K) :- M is N+1,H is K+1,undercellstar1(H2,N,K,M),rightcell(N,K,H).
undercellstar1((N,K),N,K,_) :- write('*').
undercellstar1(H2,N,K,M) :- H2 \=(N,K), connected((N,K),(M,K)),write(' ').   %2 celule, una sub alta, sunt conectate
undercellstar1(H2,N,K,M) :- H2\=(N,K),not(connected((N,K),(M,K))),write('_').
%drawpathfile1(N,K,X,Y) :- tell('d:\\temporar\\mazefile1.txt'),path(X,Y,L),nl,drawmazestar1(N,K,L),told.
drawpathfile1(N,K,X,Y):-tell('subpunctul1.txt'),path(X,Y,[H|T]),nl,aux1(H,N,K,T),told.



drawpath2(N,K,X,Y) :- path(X,Y,[H|T]),nl,aux2([],H,N,K,T).
%L va fi lista cu celulele parcurse pana in prezent
aux2(L,H,N,K,[]):-write("Pozitia curenta "), write(H),nl,
    drawmazestar2(L,H,N,K),nl.
aux2(L,H,N,K,[Head|T]):-write("Pozitia curenta "), write(H),nl,    
    drawmazestar2(L,H,N,K),nl,write("Next Round"),nl,aux2([H|L],Head,N,K,T).
%R e lista inversa a lui L
drawmazestar2(_,_,0,_).
drawmazestar2(L,H,N,K) :- N>0,M is N-1,drawmazestar2(L,H,M,K),nl,mazelinestar2(L,H,N,K). 
mazelinestar2(_,_,_,0).
mazelinestar2(L,H2,N,K) :- K>0,H is K-1,mazelinestar2(L,H2,N,H),drawcellstar2(L,H2,N,K).
drawcellstar2(L,H2,N,K) :- M is N+1,H is K+1,undercellstar2(L,H2,N,K,M),rightcell(N,K,H).
undercellstar2(_,(N,K),N,K,_) :- write('*').
undercellstar2(L,H2,N,K,M) :- H2 \=(N,K), not(member((N,K),L)),connected((N,K),(M,K)),write(' ').   %2 celule, una sub alta, sunt conectate
undercellstar2(L,H2,N,K,_) :- H2 \=(N,K), member((N,K),L),write('o').
undercellstar2(L,H2,N,K,M) :- H2\=(N,K),not(member((N,K),L)),not(connected((N,K),(M,K))),write('_').
drawpathfile2(N,K,X,Y):-tell('subpunctul2.txt'),path(X,Y,[H|T]),nl,aux2([],H,N,K,T),told.




%2 celule sunt conectate<=> celula : celula
%2 celule nu sunt conectate <=> celula | celula
/* Dati interogarile:
?- drawmaze(4,6).   %deseneaza un labirint cu 4 linii si 6 coloane
?- drawpath(4,6,(1,1),(4,6)).
?- drawpath(4,6,(1,1),(3,5)).
?- drawpathfile(4,6,(1,1),(4,6)).
?- drawpathfile(4,6,(1,1),(3,5)).
*/