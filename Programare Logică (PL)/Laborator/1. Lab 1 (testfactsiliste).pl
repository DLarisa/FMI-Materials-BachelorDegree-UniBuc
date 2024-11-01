:- op(200,xfx,!).

factorial(0,1).
factorial(X,F) :- X>0, Y is X-1, factorial(Y,G), F is G*X.

fact(0,1).
fact(X,F) :- X>0, Y is X-1, fact(Y,G), F=G*X.

0 ! 1.
X ! F :- X>0, Y is X-1, Y ! G, F is G*X.

lung([],0).
lung([_|T],N) :- lung(T,K), N is K+1.

concat([],L,L).
concat([H|T],L,[H|M]) :- concat(T,L,M).

nraparitii(_,[],0).
nraparitii(H,[H|T],N) :- nraparitii(H,T,K), N is K+1.
nraparitii(X,[H|T],N) :- X\=H, nraparitii(X,T,N).

nr_aparitii(_,[],0).
nr_aparitii(X,[H|T],N) :- nonvar(H), X=H, nr_aparitii(X,T,K), N is K+1.
nr_aparitii(X,[H|T],N) :- var(H), nr_aparitii(X,T,N).
nr_aparitii(X,[H|T],N) :- X\=H, nr_aparitii(X,T,N).

% A se vedea operatorul =.. in lectia de laborator cu operatori binari infixati si operatori unari prefixati sau postfixati.

identiclist([],[]).
identiclist([H|T],[K|U]) :- identic(H,K), identiclist(T,U).

identic(X,Y) :- nonvar(X), nonvar(Y), not(atomic(X)), not(atomic(Y)), X=..L, Y=..M, identiclist(L,M). 
identic(X,Y) :- nonvar(X), nonvar(Y), atomic(X), atomic(Y), X=Y. 

numar_aparitii(_,[],0).
numar_aparitii(X,[H|T],N) :- identic(X,H), numar_aparitii(X,T,K), N is K+1.
numar_aparitii(X,[H|T],N) :- not(identic(X,H)), numar_aparitii(X,T,N).

identicelist([],[]).
identicelist([H|T],[K|U]) :- identice(H,K), identicelist(T,U).

identice(X,Y) :- nonvar(X), nonvar(Y), not(atomic(X)), not(atomic(Y)), X=..L, Y=..M, identicelist(L,M). 
identice(X,Y) :- nonvar(X), nonvar(Y), atomic(X), atomic(Y), X=Y. 
identice(X,Y) :- var(X), var(Y). 

numaraparitii(_,[],0).
numaraparitii(X,[H|T],N) :- identice(X,H), numaraparitii(X,T,K), N is K+1.
numaraparitii(X,[H|T],N) :- not(identice(X,H)), numaraparitii(X,T,N).

