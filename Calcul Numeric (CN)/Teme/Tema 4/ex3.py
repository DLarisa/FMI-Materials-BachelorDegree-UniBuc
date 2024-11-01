import numpy as np
import matplotlib.pyplot as plt

n=20


def f_lin(x):
    return 8*x-7

def f_exp(x):
    return np.exp(2*x)

def f_patr(x):
    return 5*x**2 - 9*x + 4


def regLiniara(X, Y):
    """

    :param X: Vectorul de valori x
    :param Y: Vectorul de valori random y
    :return: a si b astfel incat y = ax + b sa fie cat mai apropiata de a cuprinde penctele (xi, yi)
    """
    A = np.zeros((2, 2))
    w = np.zeros((2, 1))
    for i in range(n):
        A[0][0] += X[i]**2
        A[0][1] += X[i]
        A[1][0] += X[i]
        w[0][0] += X[i]*Y[i]
        w[1][0] += Y[i]
    A[1][1] = n
    sol = gaussPp(A, w, 10**-16)
    a = sol[0][0]
    b = sol[1][0]
    return a, b


def regPol(X, Y):
    """

    :param X: Vectorul de valori x
    :param Y: Vectorul de valori random y
    :return: a, b si c astfel incat y = ax^2 + bx + c sa fie cat mai apropiata de a cuprinde penctele (xi, yi)
    """
    A = np.zeros((3,3))
    w = np.zeros((3, 1))
    for i in range(n):
        A[0][0] += X[i]**4
        A[0][1] += X[i]**3
        A[0][2] += X[i]**2
        A[1][0] += X[i] ** 3
        A[1][1] += X[i] ** 2
        A[1][2] += X[i]
        A[2][0] += X[i] ** 2
        A[2][1] += X[i]
        w[0][0] += Y[i] * X[i]**2
        w[1][0] += Y[i] * X[i]
        w[2][0] += Y[i]
    A[2][2] = n
    sol = gaussPp(A, w, 10**-16)
    a = sol[0][0]
    b = sol[1][0]
    c = sol[2][0]
    return a, b, c


def regExp(X, Y):
    """

    :param X: Vectorul de valori x
    :param Y: Vectorul de valori random y
    :return: a si b astfel incat y = b*e^(ax) sa fie cat mai apropiata de a cuprinde penctele (xi, yi)
    """
    A = np.zeros((2,2))
    w = np.zeros((2,1))
    for i in range(n):
        A[0][0] += X[i]**2
        A[0][1] += X[i]
        A[1][0] += X[i]
        w[0][0] += np.log(Y[i])*X[i]
        w[1][0] += np.log(Y[i])
    A[1][1] = n
    sol = gaussPp(A, w, 10**-16)
    a = sol[0][0]
    b_prim = sol[1][0]
    b = np.exp(b_prim)
    return a, b


def metSubsDesc(A, b, tol):
    """
    param A: matrice patratica, superior triunghiulara, cu toate elem pe diag principala nenule
    param b: vectorul term liberi
    param tol: val numerica ft mica in rap cu care vom compara numerele apropiate de 0
    return: sol sistem
    """

    m, n = np.shape(A)
    if m != n:
        print("Matricea nu este patratica. Introduceti o alta matrice.")
        x = None
        return x

    # Verificam daca matricea este superior triunghiulara
    for i in range(m):
        for j in range(i):
            if abs(A[i][j]) > tol:
                print("Matricea nu este superior triunghiulara")
                x = None
                return x

    # Verificam daca elementele de pe diagonala principala sunt nule (sist comp det)
    for i in range(n):
        if A[i][i] == 0:
            print("Sistemul nu este compatibil determinat")
            x = None
            return x
    x = np.zeros((n, 1))
    x[n - 1] = 1 / A[n - 1][n - 1] * b[n - 1]
    k = n - 2
    while k >= 0:
        sum = 0
        for i in range(k + 1, n):
            sum += A[k][i] * x[i]
        x[k] = 1 / A[k][k] * (b[k] - sum)
        k = k - 1
    return x



def gaussPp(A, b, tol):
    """
    param A: matricea asoc sistemului, patratica
    param b: vectorul term liberi
    param tol: val cu care comparam nr nenule
    return x: solutia sistemului, numarul de interschimbari de linii si lista de pivoti
    """
    m, n = np.shape(A)
    if m != n:
        print("Matricea nu este patratica. Introduceti o alta matrice.")
        x = None
        return x

    A_extins = np.concatenate((A, b), axis=1)  # axis=0 l-ar pune pe b o noua linie, 1 il pune drept coloana
    for k in range(n - 1):
        max = A_extins[k][k]
        p = k
        for j in range(k + 1, n):
            if abs(A_extins[j][k]) > abs(max):
                max = A_extins[j][k]
                p = j
        if abs(max) <= tol:
            print("Sistemul nu admite solutie unica")
            x = None
            return x

        if (p != k):
            A_extins[[p, k]] = A_extins[[k, p]]  # swap linia p cu linia k
        for j in range(k + 1, n):
            A_extins[j] = A_extins[j] - (A_extins[j][k] / A_extins[k][k]) * A_extins[k]

    if abs(A_extins[n - 1][n - 1]) <= tol:
        print("Sistemul nu admite solutie unica")
        x = None
        return x

    x = metSubsDesc(A_extins[:, 0:n], A_extins[:, n], tol)
    return x


X = np.linspace(1, n, n)

Y = np.random.rand(n)

Y1 = f_lin(X) + Y


print("Valorile random obtinute: "+str(Y))
a, b = regLiniara(X, Y1)
p1 = a*X[0] + b
p2 = a*X[n-1] + b


plt.plot(X, Y1, 'o', color='red', markersize=10)
plt.plot([X[0], X[n-1]], [p1, p2], '-', color='blue')
plt.show()

Y2 = f_patr(X) + Y
a, b, c = regPol(X, Y2)

Y_aux = []
for i in range(n):
    Y_aux.append(a*X[i]**2+b*X[i]+c)
plt.plot(X, Y2, 'o', color='red', markersize=10)
plt.plot(X, Y_aux, '-', color='blue')
plt.show()

Y3 = f_exp(X) + Y
a, b = regExp(X, Y3)

Y_aux = []
for i in range(n):
    Y_aux.append(b*np.exp(a*X[i]))

plt.plot(X, Y3, 'o', color='red', markersize=10)
plt.plot(X, Y_aux, '-', color='blue')
plt.show()