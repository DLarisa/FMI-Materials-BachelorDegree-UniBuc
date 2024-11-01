# Metoda Monte Carlo


# Nr Puncte pt Distribuția Uniformă
n <- 10^6



# Funcția 1 de Integrat 
aux1 <- function(x)
{
  (1 - x)^(3/2) * x^(5/2)
}

# Funcția 2 de Integrat 
aux2 <- function(x)
{
  exp(exp(x))
}

# Funcția 3 de Integrat
aux3 <- function(x)
{
  exp(x + x^2)
}

# Funcția 4 de Integrat 
aux4 <- function(x)
{
  exp(-(x^2))
}



# Calcul Integrală (teta = medie_empirica)
teta1 <- integrate(aux1, 0, 1)$value
teta2 <- integrate(aux2, 0, 1)$value
teta3 <- integrate(aux3, -2, 2)$value
teta4 <- integrate(aux4, -Inf, Inf)$value



# Generez n Valori pt Distribuția Uniformă a fiecărei Integrale
U1 <- runif(n, min = 0, max = 1)
U2 <- runif(n, min = 0, max = 1)
U3 <- runif(n, min = -2, max = 2)
U4 <- runif(n, min = -10000, max = 10000) #runif nu merge cu Inf, conform documentației



# Calculez Integrala prin Metoda Monte-Carlo
## Funcțiile Calculate pt U
f1 <- aux1(U1)
f2 <- aux2(U2)
f3 <- aux3(U3)
f4 <- aux4(U4)

## Medie Empirică
medie_empirica1 <- sum(f1)/n
medie_empirica2 <- sum(f2)/n
medie_empirica3 <- 4 * (sum(f3)/n)   
medie_empirica4 <- 20000 * (sum(f4)/n)

print(medie_empirica1)
print(medie_empirica2)
print(medie_empirica3)
print(medie_empirica4)