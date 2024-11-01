line(0).
line(N) :- N>0,write(*),tab(1),M is N-1,line(M).

tree(0,_).
tree(K,N) :- K>0,tab(K),line(N),nl,H is K-1,M is N+1,tree(H,M).

startree(N) :- M is N+1,tree(M,0).

treearg(0,_) :- write(0).
treearg(K,N) :- K>0,write(K),write(','),write(N),tab(K),line(N),nl,H is K-1,M is N+1,treearg(H,M).

startreearg(N) :- M is N+1,treearg(M,0).

