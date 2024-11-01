#Metoda Monte Carlo
#Functia de integrat
g <- function(x)
{
  x^2*exp(-x)
}

#Calculam integrala intai folosind functia integrate
teta <- integrate(g,0,1)$value

n <- 10^6
#Calculam integrala prin metoda Monte-Carlo
#Generez n valori dintr-o uniforma pe (0,1)

U <- runif(n)
gu <- g(U)
medie_empirica <- sum(gu)/n