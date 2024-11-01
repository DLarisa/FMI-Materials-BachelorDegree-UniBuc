b(1).

a(0).
a(false).
a(b(_)).

/* Nu sunt acceptate:
a(X),b(X) :- a(b(X)).
a(X);b(X).
Dati interogarea:
?- a(not(b(1))).
Raspunsul este false, pentru ca "false" si "not(b(1))" nu unifica,
si, desigur, "not(b(1))" nu unifica nici cu "0" sau "b(X)".
*/

c(X) :- not(X).

/* Dati interogarea:
?- c(not(b(1))).
Raspunsul este true, pentru ca "X" si "not(b(1))" unifica, iar "b(1)" e satisfacut, prin urmare "not(b(1))" nu e satisfacut,
asadar "not(not((b(1)))" (adica "not(X)" pentru "X" luand valoarea "not(b(1))") este satisfacut, prin urmare "c(not(b(1)))"
(adica "c(X)" pentru "X" luand valoarea "not(b(1))") e satisfacut.
*/

d(a(X),b(X)).

e(a(X);b(X)).

/* Dati interogarile:
?- d(a(2),b(2)).
Raspunsul este true, pentru ca "d(a(X),b(X))" unifica, cu acest scop.
?- e(a(2);b(2)).
Raspunsul este true, pentru ca "e(a(X);b(X))" unifica, cu acest scop. 
?- e(a(2),b(2)).
Raspunsul este false, pentru ca "e(a(X);b(X))" nu unifica, cu acest scop. 
*/

f(X) :- a(X),b(X).

g(X) :- a(X);b(X).

h(a(X),b(X)) :- a(b(X)).
h(a(X);b(X)) :- a(X),b(X).

/* La fiecare dintre interogarile:
?- f(2).
?- g(2).
raspunsul este false, pentru ca nici "a(2),b(2)", nici "a(2);b(2)" nu sunt satisfacute.
La interogarea:
?- h(a(X),b(Y)).
raspunsul va fi "X=Y", pentru ca "a(b(X))" e intotdeauna satisfacut, conform ultimului fapt din definitia predicatului "a".
La interogarea:
?- h(a(X);b(X)).
raspunsul va fi "false", pentru ca nu exista valoare a variabilei "X" care sa satisfaca ambele predicate "a" si "b".
*/
