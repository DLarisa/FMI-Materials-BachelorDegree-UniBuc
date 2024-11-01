constrfraza(F,Coada) :- subiect(F,C), predicat(C,D), substantiv(D,E), coadafraza(E,Coada).

coadafraza(F,Coada) :- cuvantlegatura(F,C), predicat2(C,D), substantiv2(D,Coada).

subiect([H|T],T) :- numepropriu(H).

substantiv([H|T],T) :- substcomun(H).
substantiv([H,K|T],T) :- substadj(H,K).
substantiv2([H|T],T) :- substcomun2(H).

cuvantlegatura([H|T],T) :- conjunctie(H).

predicat([H|T],T) :- verb(H).
predicat2([H|T],T) :- verb2(H).

numepropriu('Ana').
numepropriu('Ion').

verb('are').
verb('produce').
verb2('detesta').
verb2('iubeste').

substcomun('mere').
substcomun('electronice').
substcomun2('munca').

substadj('mere','rosii').
substadj('electronice','performante').

conjunctie('si').

fraza(F) :- constrfraza(F,[]).

scriefraza([]).
scriefraza([H|T]) :- write(H), tab(1), scriefraza(T).

genereaza :- fraza(F), scriefraza(F), nl, fail.

/* Dam "fail" pentru ca, dupa ce afiseaza o fraza, Prologul sa incerce sa satisfaca
predicatul zeroar "genereaza" construind o alta fraza, astfel ca interogarea:
?- genereaza.
sa produca afisarea tuturor frazelor care se pot construi cu aceasta gramatica. */