# Problema 1

## Exercitiul 1

### Repartitia Binomiala Bin(n, p)

bin <- rbinom(10, 1000, 0.1)
mediaBin = mean(bin)
variantaBin = var(bin)
print ("Media: ")
print(mediaBin)
print("Varianta: ")
print(variantaBin)


### Repartitia Poisson Pois(lambda)

pois = rpois(1000, sqrt(2))
mediaPois = mean(pois)
variantaPois = var(pois)
print ("Media: ")
print(mediaPois)
print("Varianta: ")
print(variantaPois)

### Repartitia Exponentiala Exp(lambda)

exp = rexp(1000, rate = 2) # lambda = 2
mediaExp = mean(exp)
variantaExp = var(exp)
print ("Media: ")
print(mediaExp)
print("Varianta: ")
print(variantaExp)


### Repartitia Normala 

norm = rnorm(1000)
mediaNorm = mean(norm)
varinataNorm = var(norm)
print ("Media: ")
print(mediaExp)
print("Varianta: ")
print(variantaExp)



######################

## Exercitiile 2 si 3


### Repartitia Binomiala


plot(1:40,dbinom(1:40, 100, 0.05),type="l", col="red",
     xlab = "k",
     ylab = "P(x = k)", 
     main = "Functia de masa a repartitiei binomiale",
)
lines(1:15, dbinom(1:15, 100, 0.1), col="green")
lines(1:25, dbinom(1:25, 100, 0.15), col = "blue")
lines(1:30, dbinom(1:30, 100, 0.08), col = "black")
lines(1:35, dbinom(1:35, 100, 0.2), col = "purple")
legend("topright", c("B(40, 0.05)", "B(15, 0.1)", "B(25, 0.15)", "B(30, 0.08)", "B(35, 0.2)"),
       fill = c("red", "green", "blue", "black", "purple")
)


plot(1:40,pbinom(1:40, 100, 0.05),type="l", col="red",
     xlab = "x",
     ylab = "F(x)", 
     main = "Functia de repartitie Binomiala",
)
lines(1:15, pbinom(1:15, 100, 0.1), col="green")
lines(1:25, pbinom(1:25, 100, 0.15), col = "blue")
lines(1:30, pbinom(1:30, 100, 0.08), col = "black")
lines(1:35, pbinom(1:35, 100, 0.2), col = "purple")
legend("bottomright", c("B(40, 0.05)", "B(15, 0.1)", "B(25, 0.15)", "B(30, 0.08)", "B(35, 0.2)"),
       fill = c("red", "green", "blue", "black", "purple")
)


### Repartitia Poisson - Functia de masa si Functia de repartitie


x = 1:10

plot(x,dpois(x, 1.5),type="l", col="red",
     xlab = "k",
     ylab = "P(x = k)", 
     main = "Functia de masa a repartitiei Poisson",
)
lines(x, dpois(x, 4), col="green")
lines(x, dpois(x, 3), col = "blue")
lines(x, dpois(x, 2.5), col = "black")
lines(x, dpois(x, 2), col = "purple")
legend("topright", c("Pois(1.5)", "Pois(4)", "Pois(3)", "Pois(2.5)", "Pois(2)"),
       fill = c("red", "green", "blue", "black", "purple")
)

y = 1:10

plot(y,ppois(y, 1.5),type="l", col="red",
     xlab = "x",
     ylab = "F(x)", 
     main = "Functia de repartitie Poisson",
)
lines(y, ppois(y, 4), col="green")
lines(y, ppois(y, 3), col = "blue")
lines(y, ppois(y, 2.5), col = "black")
lines(y, ppois(y, 2), col = "purple")
legend("bottomright", c("Pois(1.5)", "Pois(4)", "Pois(3)", "Pois(2.5)", "Pois(2)"),
       fill = c("red", "green", "blue", "black", "purple")
)



### Repartitia Exponentiala - Densitatea si Functia de repartitie

x = 0:3

plot(x,dexp(x, rate = 2),
     type="l", col="red",
     xlab = "x",
     ylab = "f(x)", 
     main = "Densitatea repartitiei exponentiale",
)
lines(x, dexp(x, rate = 1.5), col="green")
lines(x, dexp(x, rate = 2.5), col = "blue")
lines(x, dexp(x, rate = 3.5), col = "black")
lines(x, dexp(x, rate = 5), col = "purple")
legend("topright", c("Exp(2)", "Exp(1.5)", "Exp(2.5)", "Exp(3.5)", "Exp(5)"),
       fill = c("red", "green", "blue", "black", "purple")
)

plot(x,pexp(x, rate = 2),
     type="l", col="red",
     xlab = "x",
     ylab = "F(x)", 
     main = "Functia de repartitie a exponentialei",
)
lines(x, pexp(x, rate = 1.5), col="green")
lines(x, pexp(x, rate = 2.5), col = "blue")
lines(x, pexp(x, rate = 3.5), col = "black")
lines(x, pexp(x, rate = 5), col = "purple")
legend("bottomright", c("Exp(2)", "Exp(1.5)", "Exp(2.5)", "Exp(3.5)", "Exp(5)"),
       fill = c("red", "green", "blue", "black", "purple")
)


### Repartitia Normala - Densitatea si Functia de repartitie

x = -4:4

plot(x,dnorm(x, mean = 0, sd = 0.2),
     type="l", col="red",
     xlab = "x",
     ylab = "f(x)", 
     main = "Densitatea",
)
lines(x, dnorm(x, mean = 1, sd = 0.5), col="green")
lines(x, dnorm(x, mean = 2, sd = 0.8), col = "blue")
lines(x, dnorm(x, mean = 3, sd = 0.3), col = "black")
lines(x, dnorm(x, mean = 0, sd = 0.6), col = "purple")
legend("topleft", c("Norm(0, 0.2)", "Norm(1, 0.5)", "Norm(2, 0.8)", "Norm(3, 0.3)", "Norm(0, 0.6)"),
       fill = c("red", "green", "blue", "black", "purple")
)


######################

## Exercitiul 4

### Functie care calculeaza aproximarile - Functia de masa

aproxFunctiaDeMasa <- function(n, p, a, b) {
  lambda = n*p;
  x = matrix(numeric((b - a + 1) * 5), 
             ncol = 5,
             dimnames = list(a:b, c("Binomiala", "Poisson", "Normala", "Normala corectie", "Camp-Paulson")))
  y = rnorm(n, n * p, sqrt(n * p * (1 - p)))
  x[, 1] = dbinom(a:b, n, p) # binomiala
  x[, 2] = dpois(a:b, lambda) # poisson
  x[, 3] = dnorm(a:b - mean(y))/sd(y)  # fara coeficient de corelatie
  x[, 4] = dnorm((a:b + 0.5) - mean(y))/sd(y) # cu coeficient de corelatie
  
  a1 = 1 / (n - a:b)
  b1 = 1 / (a:b + 1)
  r = ((a:b + 1)*(1 - p)) / (p * (n - a:b))
  c = (1 - b1) * (r^(1 / 3))
  sigma = sqrt(a1 + b1 * r ^ (2 / 3))
  miu = 1 - a1
  
  x[, 5] = dnorm((c - miu) / sigma) # Camp-Paulson
  
  cat("Aproximari pentru n = ", n, " p = ", p, " - Functia de masa\n")
  print(x)
}
aproxFunctiaDeMasa(25, 0.05, 1, 10)
aproxFunctiaDeMasa(50, 0.05, 1, 10)
aproxFunctiaDeMasa(100, 0.05, 1, 10)
aproxFunctiaDeMasa(25, 0.1, 1, 10)
aproxFunctiaDeMasa(50, 0.1, 1, 10)
aproxFunctiaDeMasa(100, 0.1, 1, 10)


### Functie care calculeaza aproximarile - Functia de repartitie

aproxFunctiaDeRepartitie <- function(n, p, a, b) {
  lambda = n*p;
  x = matrix(numeric((b - a + 1) * 5), 
             ncol = 5,
             dimnames = list(a:b, c("Binomiala", "Poisson", "Normala", "Normala corectie", "Camp-Paulson")))
  y = rnorm(n, n * p, sqrt(n * p * (1 - p)))
  x[, 1] = pbinom(a:b, n, p) # binomiala
  x[, 2] = ppois(a:b, lambda) # poisson
  x[, 3] = pnorm((a:b - mean(y))/sd(y))  # fara coeficient de corelatie
  x[, 4] = pnorm(((a:b + 0.5) - mean(y))/sd(y)) # cu coeficient de corelatie
  
  a1 = 1 / (n - a:b)
  b1 = 1 / (a:b + 1)
  r = ((a:b + 1)*(1 - p)) / (p * (n - a:b))
  c = (1 - b1) * (r^(1 / 3))
  sigma = sqrt(a1 + b1 * r ^ (2 / 3))
  miu = 1 - a1
  #y = rnorm(miu, sigma)
  x[, 5] = pnorm((c - miu) / sigma) # Camp-Paulson
  
  cat("Aproximari pentru n = ", n, " p = ", p, " - Functia de repartitie\n")
  print(x)
}
aproxFunctiaDeRepartitie(25, 0.05, 1, 10)
aproxFunctiaDeRepartitie(50, 0.05, 1, 10)
aproxFunctiaDeRepartitie(100, 0.05, 1, 10)
aproxFunctiaDeRepartitie(25, 0.1, 1, 10)
aproxFunctiaDeRepartitie(50, 0.1, 1, 10)
aproxFunctiaDeRepartitie(100, 0.1, 1, 10)


######################

## Exercitiul 5

### Functie care ilustreaza grafic erorile maximale absolute
eroareMaxAbs <- function(n, p, a, b) {
  errPois = errNorm = errNormCoef = errCamp = 0
  bin = pbinom(a:b, n, p) # binomiala
  lambda = n*p;
  for(i in 1:1000) {
    y = rnorm(n, n * p, sqrt(n * p * (1 - p)))
    nrm = ((a:b + 0.5) - mean(y))/sd(y) # cu coeficient de corelatie
    normCoef = pnorm(nrm)
    nrm = (a:b - mean(y))/sd(y)  # fara coeficient de corelatie
    norm = pnorm(nrm)
    pois = ppois(a:b, lambda) # poisson
    
    a1 = 1 / (9*(n - a:b))
    b1 = 1 / (9*(a:b + 1))
    r = ((a:b + 1)*(1 - p)) / (p * (n - a:b))
    c = (1 - b1) * (r^(1 / 3))
    sigma = sqrt(a1 + b1 * (r ^ (2 / 3)))
    miu = 1 - a1
    
    camp = pnorm((c - miu) / sigma) # Camp-Paulson
    
  }
  
  errPois = max(abs(bin - pois))
  errNorm = max(abs(bin - norm))
  errNormCoef = max(abs(bin - normCoef))
  errCamp = max(abs(bin - camp))
  print(errPois)
  print(errNorm)
  print(errNormCoef)
  print(errCamp)
  
  plot(1:4, c(errPois, errNorm, errNormCoef, errCamp), type = "h", 
       main = paste("Erorile maximale absolute: n = ", n, " p = ", p), xlab = "x", ylab = "Eroarea",
       lwd = 10, col = c("red", "green", "purple", "blue"))
  legend("topright", c("Poisson", "Normala", "Normala - coeficient", "Camp-Paulson"),
         fill = c("red", "green", "purple", "blue")
  )
  
}


eroareMaxAbs(25, 0.1, 1, 10)

eroareMaxAbs(50, 0.05, 1, 10)

eroareMaxAbs(100, 0.15, 1, 10)

#### Observatii: 
#### Aproximarile normala si normala cu coeficient sunt cu atat mai bune cu cat n este mai mare, iar p se apropie de 0.5
#### Se poate ca aproximarea normala fara coeficient sa aiba o eroare mai mica decat cea cu coeficient
#### Aproximarea Camp-Paulson are eroarea cea mai apropiata de 0


######################

## Exercitiul 6

### Functie care determina densitatea repartitiei normal-asimetrice

dsnorm <- function(x, miu = 0, sigma = 1, lambda) {
  dens = dnorm((x - miu)/sigma)
  rep = pnorm(lambda*((x - miu)/sigma))
  return ((2 / sigma)* dens * rep)
}


plot(-5:5, dsnorm(-5:5, 0, 1, -4),type="l", col="red",
     xlab = "x",
     ylab = "f(x)", 
     main = "Densitatea repartitiei normal-asimetrice",
     lwd = 3
)
lines(-5:5, dsnorm(-5:5, 0, 1, -1), col="green", lwd = 3)
lines(-5:5, dsnorm(-5:5, 0, 1, 0), col = "blue", lwd = 3)
lines(-5:5, dsnorm(-5:5, 0, 1, 1), col = "black", lwd = 3)
lines(-5:5, dsnorm(-5:5, 0, 1, 4), col = "purple", lwd = 3)
legend("topright", c("lambda = -4", "lambda = -1", "lambda = 0", "lambda = 1", "lambda = 4"),
       fill = c("red", "green", "blue", "black", "purple")
)

######################

## Exercitiul 7

### Functie care determina cei lambda, sigma si miu

valoriParam <- function(n, p) {
  
  f <- function(x) ((1 - (2 / pi) * (x / (1 + x)))^3) / ((2 / pi) * ((4 / pi - 1)^2) * 
                                                           (x / (1 + x))^3) - (n * p * (1 - p)) / ((1 - 2 * p)^2)      
  
  val = uniroot(f, lower = 0, upper = 1, extendInt = "yes")
  
  x = as.numeric(val[1])
  
  lambda = sign(1 - 2 * p) * sqrt(x)
  
  sigma = sqrt((n * p * (1 - p)) / (1 - (2 / pi) * (x / (1 + x))))
  
  miu = n * p - sigma * sqrt((2 / pi) * (x / (1 + x)))
  
  return(list(lambda, sigma, miu))
  
  
}

# p = 0.05
par = as.numeric(valoriParam(25, 0.05))

var = rbind(dbinom(1:10, 25, 0.05), dsnorm(1:10, par[3], par[2], par[1]))
barplot(var, beside = T,
        col = c("red", "blue"), 
        main = paste("Repartitia Binomiala si Densitatea Normalei Asimetrice, p = ", 0.05))
legend("topright", c("binomiala", "normala asimetrica"),
       fill = c("red", "blue"))

# p = 0.1
par = as.numeric(valoriParam(25, 0.1))

var = rbind(dbinom(1:10, 25, 0.1), dsnorm(1:10, par[3], par[2], par[1]))
barplot(var, beside = T,
        col = c("red", "blue"), 
        main = paste("Repartitia Binomiala si Densitatea Normalei Asimetrice, p = ", 0.1))
legend("topright", c("binomiala", "normala asimetrica"),
       fill = c("red", "blue"))


######################

## Exercitiul 8

### Functie care calculeaza eroarea de aproximare prin normala asimetrica - Functia de masa
aproxNormStandDens <- function(n, p, a, b) {
  lambda = n*p;
  par = as.numeric(valoriParam(n, p))
  x = matrix(numeric((b - a + 1) * 2), 
             ncol = 2,
             dimnames = list(a:b, c("Binomiala", "Normala Asimentrica Standard")))
  
  x[, 1] = dbinom(a:b, n, p) # binomiala
  x[, 2] = dsnorm(a:b, par[3], par[2], par[1])
  
  cat("Aproximari pentru n = ", n, " p = ", p, " - Functia de masa\n\n")
  print(x)
  error = max(abs(x[, 1] - x[, 2]))
  print(error)
  return(error)
}

err1 = aproxNormStandDens(25, 0.05, 1, 10)
err2 = aproxNormStandDens(25, 0.1, 1, 10)
err3 = aproxNormStandDens(50, 0.05, 1, 10)
err4 = aproxNormStandDens(50, 0.1, 1, 10)
err5 = aproxNormStandDens(100, 0.05, 1, 10)
err6 = aproxNormStandDens(100, 0.1, 1, 10)


plot(1:6, c(err1, err2, err3, err4, err5, err6), type = "h", lwd = 10,
     col = c("red", "green", "purple", "orange", "blue", "yellow"), 
     main = "Erorile maxime absolute - Functia de masa", 
     xlab = "", ylab = "eroarea")
legend("topright", c("n = 25, p = 0.05", "n = 25, p = 0.1", "n = 50, p = 0.05", "n = 50, p = 0.01",
                     "n = 100, p = 0.05", "n = 100, p = 0.1"), 
       fill = c("red", "green", "purple", "orange", "blue", "yellow"))


## Functie care calculeaza eroarea de aproximare prin normala asimetrica - Functia de repartitie
aproxNormStandFuncRep <- function(n, p, a, b) {
  
  par = as.numeric(valoriParam(n, p))
  lambda = as.numeric(par[1])
  miu = as.numeric(par[2])
  sigma = as.numeric(par[3])
  
  x = matrix(numeric((b - a + 1) * 2), 
             ncol = 2,
             dimnames = list(a:b, c("Binomiala", "Normala Asimentrica Standard")))
  
  x[, 1] = pbinom(a:b, n, p) # binomiala
  
  t = (x - miu) / sigma
  
  psi <-function(t) 2 * dnorm(t) * pnorm(lambda * t)
  
  for (i in a:b) {
    y = integrate(psi, lower = -Inf, upper = (i + 0.5 - miu) /sigma)
    
    x[i, 2] = as.numeric(y[1])
  }
  
  
  cat("Aproximari pentru n = ", n, " p = ", p, " - Functia de masa\n\n")
  print(x)
  error = max(abs(x[, 1] - x[, 2]))
  print(error)
  return(error)
}

err1 = aproxNormStandFuncRep(25, 0.05, 1, 10)
err2 = aproxNormStandFuncRep(25, 0.1, 1, 10)
err3 = aproxNormStandFuncRep(50, 0.05, 1, 10)
err4 = aproxNormStandFuncRep(50, 0.1, 1, 10)
err5 = aproxNormStandFuncRep(100, 0.05, 1, 10)
err6 = aproxNormStandFuncRep(100, 0.1, 1, 10)


plot(1:6, c(err1, err2, err3, err4, err5, err6), type = "h", lwd = 10,
     col = c("red", "green", "purple", "orange", "blue", "yellow"), 
     main = "Erorile maxime absolute - Functia de repartitie", 
     xlab = "", ylab = "eroarea")
legend("topleft", c("n = 25, p = 0.05", "n = 25, p = 0.1", "n = 50, p = 0.05", "n = 50, p = 0.01",
                    "n = 100, p = 0.05", "n = 100, p = 0.1"), 
       fill = c("red", "green", "purple", "orange", "blue", "yellow"))




##################################################################

# Problema 2

## Metoda de Simulare prin Acceptare si Respingere

for(i in 1:1000)
{
  x <- c(x, runif(1, -1, 1))
  y <- c(y, runif(1, -1, 1)) 
}
plot (x, y, main="Metoda de Simulare prin Acceptare si Respingere", 
      col = ifelse(x*x+y*y<=1, "blue", "red"))

s = 0
nr = 0
for(i in 1:1000)
  if(x[i]*x[i]+y[i]*y[i]<=1)
  {
    distanta = sqrt(x[i]*x[i]+y[i]*y[i]) 
    s = s+distanta
    nr = nr + 1
  } 
print(s/nr)







##################################################################

# Problema 3

## Subpunct A
f <- function(t, z)
{return(t^(z-1)*exp(-t))}


fgam <- function(x)
{
  if(x==1) return(1)
  else if(x%%1==0 && x>0) #daca e nr natural mai mare de 0
  {
    count <- 1
    for(i in 1:(x-1)) count = count * i
    return(count)
  }
  else if(x==1/2)
  {
    return(sqrt(pi))
  }
  else if(x>1) return((x-1) * fgam(x-1))
  else if(x>0 && x<1)
  {
    return(integrate(f, lower=0, upper=Inf, z=x)$value)
  }
}


######################

## Subpunct B
fbet <- function(a, b)
{
  if(a>0 && b>0 && a+b==1)
  {return(pi/sin(a*pi))}
  return(fgam(a)*fgam(b)/fgam(a+b))
}



######################

## Subpunct C
Gamma <- function(a, b, x)
{return(1/(b^a*fgam(a))*x^(a-1)*exp(-x/b))}
Beta <- function(a, b, x)
{return(1/fbet(a, b)*x^(a-1)*(1-x)^(b-1))}

fprobgamma1 <- function(a, b)
{return(integrate(Gamma, 0, 3, a=a, b=b)$value)}

fprobgamma2 <- function(a, b)
{return(integrate(Gamma, 2, 5, a=a, b=b)$value)}

fprobgamma3 <- function(a, b)
{
  x=integrate(Gamma, 3, 4, a=a, b=b)$value
  y=integrate(Gamma, 2, Inf, a=a, b=b)$value
  return(x/y)
}

fprobbeta4 <- function(a, b)
{return(ceiling(1-integrate(Beta, 0, 1, a=a, b=b)$value))}

fprobgamma5 <- function(a, b)
{return(integrate(Gamma, 4, 6, a=a, b=b)$value)}

fprobgamma6 <- function(a, b)
{
  x=integrate(Gamma, 0, 1, a=a, b=b)$value
  y=integrate(Gamma, 0, 7, a=a, b=b)$value
  return(x/y)
}

fcomuna <- function(x, y, a, b) #pt ca sunt independente
{return(1/(b^a*fgam(a))*x^(a-1)*exp(-x/b)*1/fbet(a, b)*y^(a-1)*(1-y)^(b-1))}

fprob7 <- function(a, b) 
{
  integrate(function(y, a, b) 
  {
    sapply(y, function(y) 
    {
      integrate(function(x, a, b) fcomuna(x, y, a, b), 0, 5-y, a=a, b=b)$value
    })
  }, 0, 1, a=a, b=b)$value
}

fprob8 <- function(a, b)
{return(1-integrate(function(y, a, b) 
{
  sapply(y, function(y) 
  {
    integrate(function(x, a, b) fcomuna(x, y, a, b), 0, 0.5+y, a=a, b=b)$value
  })
}, 0, 1, a=a, b=b)$value)
}


### Exemple:

fprobgamma1(1, 2)
fprobgamma1(2, 2)
fprobgamma1(3, 5)

fprobgamma2(1, 2)
fprobgamma2(2, 2)
fprobgamma2(3, 5)

fprobgamma3(1, 2)
fprobgamma3(2, 2)
fprobgamma3(3, 5)

fprobbeta4(1, 2)
fprobbeta4(2, 2)
fprobbeta4(3, 5)

fprobgamma5(1, 2)
fprobgamma5(2, 2)
fprobgamma5(3, 5)

fprobgamma6(1, 2)
fprobgamma6(2, 2)
fprobgamma6(3, 5)

fprob7(1, 2)
fprob7(2, 2)
fprob7(3, 5)

fprob8(1, 2)
fprob8(2, 2)
fprob8(3, 5)



######################

## Subpunct D

m = c(  0, fprobgamma1(1, 2), 0, fprobgamma2(1, 2), 
         0, fprobgamma3(1, 2), 0, fprobbeta4(1,2), 
         0, fprobgamma5(1, 2), 0, fprobgamma6(1, 2),
         0, fprob7(1, 2), 0, fprob8(1, 2))

m[1]  = pgamma(q = 3, shape = 1, scale = 2)
m[3]  = pgamma(q = 5, shape = 1, scale = 2) - pgamma(q = 2, shape = 1, scale = 2)
m[5]  = (pgamma(q = 4, shape = 1, scale = 2) - pgamma(q = 3, shape = 1, scale = 2)) / (1 - pgamma(q = 2, shape = 1, scale = 2))
m[7]  = 1 - pbeta(q = 2, 1, 2)
m[9]  = pgamma(q = 6, shape = 1, scale = 2) - pgamma(q = 4, shape = 1, scale = 2)
m[11] = (pgamma(q = 1, shape = 1, scale = 2) - pgamma(q = 0, shape = 1, scale = 2)) / pgamma(q = 7, shape = 1, scale = 2)
m[13] = pgamma(q = 5, shape = 1, scale = 2) * pbeta(q = 1, 1, 2)
m[15] = 1 - pgamma(q = 0.5, shape = 1, scale = 2) * pbeta(q = 1, 1, 2)

MATRICE <- matrix(m, ncol=2, byrow=TRUE)

colnames(MATRICE) = c("R","Punct C")
rownames(MATRICE) = c("P(X < 3)","P(2 < X < 5)","P(3 < X < 4 | X > 2)","P(Y > 2)","P(4 < X < 6)","P(0 < X < 1 | X < 7)", "P(X + Y < 5)", "P(X - Y > 0.5)")
MATRICE <- as.table(MATRICE)

MATRICE