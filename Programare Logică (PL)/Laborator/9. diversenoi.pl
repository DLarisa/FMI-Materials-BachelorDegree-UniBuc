:- op(700,xfy,optest).
:- op(700,yfx,altoptest).
:- op(700,xfx,[apartine,in]).

a optest b optest c :- write('abc').
a optest (b optest c) :- write('a(bc)').
(a optest b) optest c :- write('(ab)c').

u altoptest v altoptest w :- write('uvw').
u altoptest (v altoptest w) :- write('u(vw)').
(u altoptest v) altoptest w :- write('(uv)w').

u apartine v altoptest w :- write('uvw').
u apartine (v altoptest w) :- write('u(vw)').
(u apartine v) altoptest w :- write('(uv)w').

_ apartine [] :- fail.
X apartine [X|_] :- !.
X apartine [_|T] :- X aapartine T.

_ in [] :- fail.
X in [X|_].
X in [_|T] :- X in T.

stergetot(_,[],[]).
stergetot(X,[X|T],L) :- stergetot(X,T,L).
stergetot(X,[H|T],[H|L]) :- H\=X, stergetot(X,T,L).

elimdup([],[]).
elimdup([H|T],L) :- H apartine T, elimdup(T,L).
elimdup([H|T],[H|L]) :- not(H apartine T), elimdup(T,L).

stergeprim(_,[],[]).
stergeprim(X,[X|T],T).
stergeprim(X,[H|T],[H|L]) :- H\=X, stergeprim(X,T,L).

stergeultim(_,[],[]).
stergeultim(X,[X|T],T) :- not(X apartine T).
stergeultim(X,[X|T],[X|L]) :- X apartine T, stergeultim(X,T,L).
stergeultim(X,[H|T],[H|L]) :- H\=X, stergeultim(X,T,L).

:- op(650,xf,e_multime).
:- op(670,xfx,e_submultime).

L e_multime :- elimdup(L,L).

[] e_submultime _.
[_|_] e_submultime [] :- fail.
[H|T] e_submultime [H|L] :- T e_submultime L.
[H|T] e_submultime [_|L] :- [H|T] e_submultime L.

parti(M,PM) :- setof(S,S e_submultime M,PM).

prodcart(A,B,P) :- setof((X,Y), (X in A,Y in B), P).

%^ testsetofcut(A,B,P) :- setof(X, (X in A,_ in B), P).

test0setof(A,B,L) :- prodcart(A,B,P), setof(X, ((X,Y) in P,X=<Y), L).

:- op(500,xf,potrivit).

test0findall(A,B,L) :- prodcart(A,B,P), findall(X potrivit, ((X,Y) in P,X=<Y), L).

testsetof(A,B,P) :- setof(X, (X in A,_ in B), P).

testbagof(A,B,P) :- bagof(X, (X in A,_ in B), P).

testfindall(A,B,P) :- findall(X, (X in A,_ in B), P).

testfindallfdup(A,B,M) :- findall(X, (X in A,_ in B), P), elimdup(P,M).

:- op(600,xf,[epp,epperf]).
:- op(400,xfx,!).

N epp :- integer(N), N>=0, testpp(0,N).

testpp(K,N) :- K*K>N, fail.
testpp(K,N) :- K*K=:=N.
testpp(K,N) :- K*K<N, H is K+1, testpp(H,N).

testepp(N) :- I is cputime, (N epp; not(N epp)), F is cputime, D is F-I, write(D), write(' secunde').

alttestepp(N) :- I is cputime, _ = N epp, F is cputime, D is F-I, write(D), write(' secunde').

N epperf :- integer(N), N>=0, genlistpp(0,N,L), N apartine L.

genlistpp(K,N,[]) :- K*K>N.
genlistpp(K,N,[H|T]) :- H is K*K, H=<N, S is K+1, genlistpp(S,N,T).

testepperf(N) :- I is cputime, (N epp; not(N epp)), F is cputime, D is F-I, write(D), write(' secunde').

alttestepperf(N) :- I is cputime, _ = N epperf, F is cputime, D is F-I, write(D), write(' secunde').

0 ! 1.
N ! F :- integer(N), N>0, P is N-1, P ! G, F is N*G.
