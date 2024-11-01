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

drawmaze(0,_).
drawmaze(N,K) :- N>0,M is N-1,drawmaze(M,K),nl,mazeline(N,K). 

mazeline(_,0).
mazeline(N,K) :- K>0,H is K-1,mazeline(N,H),drawcell(N,K).

drawcell(N,K) :- M is N+1,H is K+1,undercell(N,K,M),rightcell(N,K,H).

undercell(N,K,M) :- connected((N,K),(M,K)),write(' ').
undercell(N,K,M) :- not(connected((N,K),(M,K))),write('_').

rightcell(N,K,H) :- connected((N,K),(N,H)),write(':').
rightcell(N,K,H) :- not(connected((N,K),(N,H))),write('|').

path(X,Y,Path) :- mazepath(X,Y,[X,Y],Path),write(Path).

% in al treilea argument al lui mazepath retinem celulele vizitate pe drumul curent

mazepath(X,Y,_,[X,Y]) :- connected(X,Y).
mazepath(X,Y,L,[X|T]) :- not(connected(X,Y)),connected(X,Z),not(member(Z,L)),mazepath(Z,Y,[Z|L],T).

member(_,[]) :- fail.
member(H,[H|_]).
member(X,[H|T]) :- H\=X,member(X,T).

drawpathnsteps(N,K,X,Y) :- path(X,Y,L),nl,drawmazensteps(N,K,L). % predicatul pt. cerinta (i)/Exercitiul 1

concat([],L,L).
concat([H|T],L,[H|M]) :- concat(T,L,M).

drawmazensteps(N,K,[]) :- drawmaze(N,K).
drawmazensteps(N,K,L) :- concat(P,[X],L),drawmazensteps(N,K,P),nl,drawmazesglstar(N,K,X).

drawmazesglstar(0,_,_).
drawmazesglstar(N,K,X) :- N>0,M is N-1,drawmazesglstar(M,K,X),nl,mazelinesglstar(N,K,X). 

mazelinesglstar(_,0,_).
mazelinesglstar(N,K,X) :- K>0,H is K-1,mazelinesglstar(N,H,X),drawcellsglstar(N,K,X).

drawcellsglstar(N,K,X) :- M is N+1,H is K+1,undercellsglstar(N,K,M,X),rightcell(N,K,H).

undercellsglstar(N,K,_,(N,K)) :- write('*').
undercellsglstar(N,K,M,(N1,K1)) :- (N\=N1;K\=K1),connected((N,K),(M,K)),write(' ').
undercellsglstar(N,K,M,(N1,K1)) :- (N\=N1;K\=K1),not(connected((N,K),(M,K))),write('_').

/* Dati interogarile:
?- drawpathnsteps(4,6,(1,1),(4,6)).
?- drawpathnsteps(4,6,(1,1),(3,5)).
*/

