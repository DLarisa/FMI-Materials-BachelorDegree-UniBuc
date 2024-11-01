% Aceasta implementare va functiona numai in Prologul desktop.

% apartine(_,[]) :- fail.
apartine(X,[X|_]).
apartine(X,[_|T]) :- apartine(X,T).
% nu doar testeaza apartenenta, ci genereaza in primul argument membrii listei din al doilea argument

implica(X,Y) :- not(X);Y.

echivalent(X,Y) :- implica(X,Y),implica(Y,X).

aenunt(A,B,C) :- echivalent(A,echivalent((B,C),C)).

benunt(A,B,C) :- echivalent(B,implica((A,C),not(implica((B,C),A)))).

cenunt(A,B,C) :- echivalent(C,echivalent(not(B),(A;B))).

rezolv(A,B,C) :- apartine(A,[true,false]),apartine(B,[true,false]),apartine(C,[true,false]),aenunt(A,B,C),benunt(A,B,C),cenunt(A,B,C).

