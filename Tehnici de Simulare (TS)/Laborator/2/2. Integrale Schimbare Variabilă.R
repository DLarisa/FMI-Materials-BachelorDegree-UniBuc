# Integrala este de la 0 la Inf
g2 <- function(x) {
  return(x ^ 2 / (1 + x^6))
}

# Valoarea este de fapt pi / 6
teta = integrate(g2, 0, Inf)$value

# Efectuam o schimbare de variabila 
# u = 1 / ( 1 + x ^ 6)
# x = ((1 - u) / u ) ^ (1/6)
# Tema:  de terminat calculele

g3 <- function(x) {
  return(exp(-x ^ 2))
}

#Integrala Euler-Poisson aprox sqrt(pi)
teta = integrate(g3, -Inf, Inf)$value
# Functia g3 este para, deci putem integra de la 0 la Inf si inmultim cu 2
# Efectuam Schimbarea de variabila 
# x <- t / ( 1 - t)
# dx = 1 / ((1 - t) ^ 2)

# x-> inf => t = 1
# x = 0 => t = 0
# Noile capete: 0 si 1
g3t <- function(t) {
  2 * exp(- t ^ 2 / (1 - t) ^2) * 1 / ((1 - t) ^ 2) 
}

n <- 1e6
U <- runif(n,0,1)
g3tU <-  g3t(U)
teta_est <- sum(g3tU) / n
pi_est <- teta_est ^ 2
