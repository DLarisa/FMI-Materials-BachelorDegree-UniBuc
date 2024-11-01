/* Pentru acest exercitiu, careul are o configuratie fixa, anume:
#__#__#__#
__________
#__#__#__#
__________
#__#__#__#
i.e., cu notatiile din rebus.pl: NrRanduri=NrColoane=7 si ListaPauzeCareu = 
[(1,1),(1,3),(1,5),(1,7),(3,1),(3,3),(3,5),(3,7),(5,1),(5,3),(5,5),(5,7),(7,1),(7,3),(7,5),(7,7)], iar
ListaCuvinte = [abalone,abandon,anagram,connect,elegant,enhance,a,c,e,m,n,t],
asadar putem sa notam celulele unde cuvintele de pe orizontala se intersecteaza cu cele de pe verticala cu variabilele urmatoare:
#__#__#__#
_A1_A2_A3_
#__#__#__#
_B1_B2_B3_
#__#__#__#
_C1_C2_C3_
#__#__#__#
si sa implementam, de exemplu, ca mai jos, obtinand solutia sub forma valorilor variabilelor:
V1,V2,V3, care vor fi date de cuvintele de pe coloanele 2,4,6, si
H1,H2,H3, care vor fi date de cuvintele de pe randurile 2,4,6.
Interogarea:
?- rebus(V1,V2,V3,H1,H2,H3).
va produce doua solutii.
*/

cuvant(abalone,a,b,a,l,o,n,e).
cuvant(abandon,a,b,a,n,d,o,n).
cuvant(anagram,a,n,a,g,r,a,m).
cuvant(connect,c,o,n,n,e,c,t).
cuvant(elegant,e,l,e,g,a,n,t).
cuvant(enhance,e,n,h,a,n,c,e).

rebus(V1,V2,V3,H1,H2,H3) :- cuvant(V1,_,A1,_,B1,_,C1,_), cuvant(V2,_,A2,_,B2,_,C2,_), cuvant(V3,_,A3,_,B3,_,C3,_),
                            cuvant(H1,_,A1,_,A2,_,A3,_), cuvant(H2,_,B1,_,B2,_,B3,_), cuvant(H3,_,C1,_,C2,_,C3,_).

