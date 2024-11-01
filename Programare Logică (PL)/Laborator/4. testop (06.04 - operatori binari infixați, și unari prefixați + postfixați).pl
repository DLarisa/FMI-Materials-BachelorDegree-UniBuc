/* Pentru ca a scrie, de exemplu, are(ana,mere) este contraintuitiv, sa declaram predicatul binar "are" ca operator infixat,
de precedenta (opusul prioritatii: cu cat precedenta e mai mica, cu atat operatorul e mai prioritar, leaga mai tare) 600;
folosim urmatoarea directiva: */

:- op(600,xfx,are).

ana are mere.
ana are pere.
alex are mere.
george are pere.

/* Dati interogarile:
?- ana are Ce.
?- Cine are mere.
?- Cine are Ce.
si cereti toate solutiile (cu ";" in Prologul desktop si "Next" in Prologul online).
Desigur, puteti interoga:
?- findall((Cine are Ce),Cine are Ce,L).
*/

/* Sa declaram doua predicate unare prefixate "para" si "impara", care sa determine daca o lista are lungimea para, respectiv impara
si doua predicate unare postfixate "constanta" si "crescatoare", care sa determine daca o lista e constanta, respectiv ordonata crescator: */

:- op(500,fx,para).
:- op(500,fx,impara).
:- op(500,xf,constanta).
:- op(500,xf,crescatoare).

para [].
para [_] :- fail. % optional
para [_,_|T] :- para T.

impara [] :- fail. % optional
impara [_|T] :- para T.

[] constanta.
[_] constanta.
[X,Y|T] constanta :- X=Y, [Y|T] constanta.

/* Putem interoga:
?- [X,Y,1,Z] constanta.
*/
 
[] crescatoare.
[_] crescatoare.
[X,Y|T] crescatoare :- X=<Y, [Y|T] crescatoare.
 
% Sa declaram doi operatori unari prefixati "succ" si "pred" si un predicat binar infixat "este", definit astfel:

:- op(300,fy,succ).
:- op(300,fy,pred).
:- op(400,xfx,este).

0 este 0.
succ 0 este succ 0.
pred 0 este pred 0.
succ pred X este Y :- X este Y.
pred succ X este Y :- X este Y.
succ succ X este Y :- succ X este Z, succ Z este Y.
pred pred X este Y :- pred X este Z, pred Z este Y.

/* Interogati:
?-  succ pred pred succ pred 0 este X.
Daca, in loc de atributul "fy", am fi scris "fx", atunci definitia de mai sus si aceasta interogare ar fi fost incorecte,
pentru ca "fx" cere ca precedenta operandului sa fie mai mica decat precedenta operatorului. De exemplu, sa consideram
un operator unar prefixat #, cu precedenta mai mica decat precedenta lui succ: */

:- op(200,fx,#).

/* Atunci putem interoga:
?- succ # a = X.
dar nu si:
?- # succ a = X.
*/

/* Aceeasi semnificatie o are "x" si in declaratii de operatori binari. De exemplu, nu putem interoga:
?- succ pred 0 este 0 este 0.
In schimb, daca declaram predicatul "implica" in felul urmator, atunci acesta va fi un operator binar asociativ la dreapta,
si vom putea da interogari de forma:
?- X implica false implica false.
Cereti toate solutiile si observati ca parantezarea implicita este: (X implica false) implica false. */

:- op(600,xfy,implica).

true implica false :- fail.
false implica _.
_ implica true.

/* Sa observam si ca putem folosi aceste declaratii cu liste de operatori: putem declara, in aceeasi declaratie, doua relatii binare
(i.e. predicate binare) =#< si #>, impreuna cu predicatele binare auxiliare necesare pentru definirea acestora, toate notate infixat,
astfel incat =#< si #> sa determine daca un numar intreg (indiferent de ce semn) are numarul de cifre mai mic sau egal, respectiv
strict mai mare decat al altui numar intreg, efectuand si verificarea ca operanzii sa fie numere intregi: */

:- op(400,xfx,[=#<,val_abs,nrcf,#>]).

X val_abs X :- X>=0.
X val_abs Y :- X<0, Y is -X.

X nrcf 1 :- X<10.
X nrcf C :- X>=10, Y is X div 10, Y nrcf D, C is D+1.

X=#<Y :- X val_abs A, A nrcf C, Y val_abs B, B nrcf D, C=<D.

X#>Y :- not(X=#<Y).

/* Dati interogarile:
?- 50#>23.
?- 979=#<100.
?- 979=#<1000.
?- 979#>1000.
?- 979 #> -1000. % aici e nevoie de spatiu, altfel intreaga succesiune de caractere speciale e interpretata ca un atom
?- -979=#<10.
?- -9790 #> -100. % si aici e nevoie de spatiu
*/

/* Un predicat binar infixat de tip xfx predefinit este "=..": daca t e un termen si L e o lista, atunci t=..L e satisfacut
ddaca L=[operatorul_dominant_f_al_lui_t|argumentele_lui_f], desigur, coada lui L fiind vida daca f e constanta, ca in
primele doua dintre urmatoarele exemple de interogari:
?- a=..L.
?- []=..L.
?- f(X)=..L.
?- g(a,f(b),g(X,c,Y,Z),f(1))=..L.
?- [H|T]=..L.
?- [H,K|T]=..L.
?- [H,[K|T]]=..L.
?- [1,2,3,4,5]=..L.
?- [1,2,3|[4,5]]=..L.
?- [1,2,3|[4,5|[]]]=..L.
Observati ca operatorul "[|]", care construieste liste nevide, este un operator binar, iar scrierile unei liste prin enumerarea tuturor
elementelor sale sau a primelor elemente, urmate de coada listei, sunt doar scrieri echivalente pentru termeni formati cu acest operator binar. 
*/
