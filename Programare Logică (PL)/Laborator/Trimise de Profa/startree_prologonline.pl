/*
Daca lucram in SWISH SWI-Prolog-ul online (editie limitata, de exemplu nu recunoaste predicatul tab/1 si nu executa
write(' ') la inceputul unui rand), atunci putem inlocui tab(N) cu scrielin(N) sau scriepct(N), definite astfel:
*/
scrielin(0).
scrielin(N) :- N>0,K is N-1,write('-'),scrielin(K).

scriepct(0).
scriepct(N) :- N>0,K is N-1,write('.'),scriepct(K).

bradut(N) :- randuri(N,N).

randuri(_,0).
randuri(N,K) :- K>0,P is K-1,randuri(N,P),nl,T is N-K,scriepct(T),scrie(K).

scrie(0).
scrie(K) :- K>0,P is K-1,scrie(P),write(*),write(' ').

bradutarg(N) :- randuriarg(N,N).

randuriarg(_,0) :- write(0).
randuriarg(N,K) :- K>0,write(N),write(','),write(K),write('.'),P is K-1,randuriarg(N,P),nl,T is N-K,write(N),write(','),write(K),scriepct(T),scrie(K).
