n <- 10^6 # recomandare, rulați cu 10^4 pt că programul crapă cu valoare așa mare

x <- runif(n, -1, 1)
y <- runif(n, -1, 1)


# Versiune 1
k <- 0
for (i in 1:n) 
{
  if (x[i]^2 + y[i]^2 < 1)  {k <- k + 1}
}


# Versiune 2 
k <- sum(x^2 + y^2 < 1)


PI = k / n * 4
print(PI)


# Reprezentare Grafică
# Versiune 1
plot(0, 0)
for(i in 1:n)
{
  if (x[i]^2 + y[i]^2 < 1) { points(x[i], y[i], col="magenta") }
  else { points(x[i], y[i], col="blue") }
}

# Temă: de eficentiezat metoda de reprezentare grafică (putem elimina for?) 
# și de desenat un cerc de rază 1, peste figură.