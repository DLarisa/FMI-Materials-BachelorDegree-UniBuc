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

undercell(N,K,M) :- connected((N,K),(M,K)),write('..').
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

drawpath(N,K,X,Y) :- path(X,Y,L),drawmazestar(N,K,L).

drawmazestar(0,_,_).
drawmazestar(N,K,L) :- N>0,M is N-1,drawmazestar(M,K,L),nl,mazelinestar(N,K,L). 

mazelinestar(_,0,_).
mazelinestar(N,K,L) :- K>0,H is K-1,mazelinestar(N,H,L),drawcellstar(N,K,L).

drawcellstar(N,K,L) :- M is N+1,H is K+1,undercellstar(N,K,M,L),rightcell(N,K,H).

undercellstar(N,K,_,L) :- member((N,K),L),write('*').
undercellstar(N,K,M,L) :- not(member((N,K),L)),connected((N,K),(M,K)),write('..').
undercellstar(N,K,M,L) :- not(member((N,K),L)),not(connected((N,K),(M,K))),write('_').

/* Dati interogarile:
?- drawmaze(4,6).
?- drawpath(4,6,(1,1),(4,6)).
?- drawpath(4,6,(1,1),(3,5)).
*/
