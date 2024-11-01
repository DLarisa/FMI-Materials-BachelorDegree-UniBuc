
% listele puterilor lui 2, respectiv 3, pana la un anumit exponent

puteri(_,0,[1]).
puteri(N,K,[X,H|T]) :- K>0,P is K-1,puteri(N,P,[H|T]),X is N*H.

% inmultirea unui numar cu fiecare element al unei liste de numere:

nrmultlist(_,[],[]).
nrmultlist(X,[H|T],[K|V]) :- K is X*H,nrmultlist(X,T,V).

% inmultirea a doua liste de numere element cu element:

inmultliste([],_,[]).
inmultliste([H|T],L,M) :- nrmultlist(H,L,R),inmultliste(T,L,S),concat(R,S,M).

% lista numerelor de forma 2^k*3^n, cu k,n naturale, k<=K, n<=N:

puteri23(K,N,L) :- puteri(2,K,R),puteri(3,N,S),inmultliste(R,S,L).

% dati interogarile:
% puteri23(2,2,L),write(L).
% puteri23(5,7,L),write(L),write('***'),nl,qsort(L,S),write(S).
% puteri23(100,100,L),write(L),write('***'),nl,qsort(L,S),write(S).

