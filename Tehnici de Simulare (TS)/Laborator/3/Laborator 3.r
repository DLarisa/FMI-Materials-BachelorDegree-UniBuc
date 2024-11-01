#SAna-Maria 341

library(cubature)
library(pracma)

#Ex4
#Integrala dubla, de la 1 la 2, si de la 3 la 4
g4 <- function(x, y){
  x*y^2
}

#teta <- adaptIntegrate(g4, lowerLimit = c(1,3), upperLimit=c(2,4))$integral

teta <- integral2(g4, 1, 2, 3, 4)$Q

n <- 10^6
x <- runif(n, 1, 2)
y <- runif(n, 3, 4)


g4U <- g4(x, y)
teta_est <- sum(g4U)/n


#Ex5
#Integrala dubla de la 0 la Inf si de la 0 la x
g5 <- function(x, y){
  3*x*exp(-x-y)
}

teta <- integrate(function(x) {sapply(x, function(x) 
{integrate(function(y) 3*x*exp(-x-y), 0, x)$value})}, 0, Inf)$value


#Schimbare de variabila, pentru x de la 0 la Inf, t va fi de la 0 la 1
#x = t/(1-t)
#t = x/(x-1)

#dx = 1/(1+t)^2

g5t <- function(t, y){
  x <- t/(1-t)
  g5(x, y)*1/(1-t)^2
  
}

n <- 10^6

t <- runif(n)
med_t <- sum(t)/n
y <- runif(n, 0, t/(1-t))

g5U <- g5t(t, y)
teta_est <- sum(g5U * t/(1-t))/n


#Caprita Catalin 341
#1.
# g(x) = 4 * x ^ 3 * exp(-x ^ 2 / 8) de integrat de la -Inf la Inf
# f(x) = 1 / 2 * sqrt(2 * pi) * exp(-x ^ 2 / 8
# h(x) = 4 * x ^ 3
n <-  1e7
X <- rnorm(n,0,2)

g <- function(x){
  4 * x ^ 3 * exp(-x ^ 2 / 8)S
}
h <- function(x){
  4 * x ^ 3
}
teta_aprox <- 2 * sqrt(2 * pi) * sum(h(X)) / n
teta <- integral(g,-Inf,Inf)
#TEMA: Aceeasi problema pornind de la o Uniforma(Schimbare de variabila) 
#si Exponentiala

#Memenduf Alen 341
require(plotrix)

n <- 10^4
x <- runif(n, -1, 1)
y <- runif(n, -1, 1)


# asp => aspect ratio
plot(x, y,asp = 1, col = ifelse(x^2 + y^2 < 1, 'white', 'gray'))
draw.circle(0, 0, 1, border = "black", lwd = 3)

# Chirut Veronica
N <- c()
for (i in 1:10 ^ 5) {
  U <- c()
  
  sum <- 0
  n <- 0
  while(sum <= 1) {
    U <- runif(1, 0, 1)
    sum <- sum + U
    n <- n + 1
  }
  
  N <- append(N, n)
}

covarianta <- function(x, y) {
  mean(x * y) - mean(x) * mean(y)
}

# a
E_N <- mean(N)

# ASA NU!
# Folosim Monte Carlo - Lab 3
Var_N <- covarianta(N, N)

# b
cazuri_favorabile <- sum(N == 2)
cazuri_posibile <- length(N)

P_2 = cazuri_favorabile / cazuri_posibile

# c
# E(N) este o aproximare a numarului lui Euler