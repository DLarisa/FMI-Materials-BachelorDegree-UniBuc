"""
    Titlu Lucrare de Bază: A Dual Coordinate Descent Method for Large-Scale Linear SVM
    Autori Lucrare: Choi-Jui Hsieh, Kai-Wei Chang, Chih-Jen Lin, S. Sathiya Keerthi, S. Sundararajan
    Studenți: SAna-Maria, DLarisa
    Grupa: 341
"""



# Librării
import numpy as np
import random
import time





""" ---------------     Algoritmii Propuși     ---------------"""
# Algoritmul 1: Dual Coordinate Descent Method (simplu)
def dual_descent(alpha_start, y, x, U, Q, w_start, D, tol):
    """
        Parametrii: 
            alpha_start: alpha0, ales random (este același pentru toți cei 3 algoritmi, dar facem copie, 
                                              ca să nu modificăm valoarea originală)
            y: {+1; -1} -> eticheta pentru un x; este un array de lungime l
            x: din R^n (x = x1, x2, ..., xn), dar avem un array de lungime l de x
            U: din formula (4) din paper-ul original -> pt L1 este C (paramaterul de penalizare), iar pt L2 e inf
            Q: (4) paper 
            w_start: se obține din alpha_start (formulă în algoritm) (este același pentru toți cei 3 algoritmi, dar 
                                                facem copie, ca să nu modificăm valoarea originală)
            D: (4) paper -> pt L1 este 0; pt L2 este 1/(2C)
            tol: toleranța (o eroare)
    """
    
    l = len(y)       # lungimea
    A = np.zeros(l)  # A[i] va deveni 1 când alpha[i] devine optimal și ieșim din algoritm când toate val = 1
    k = 0            # nr pași / rata de convergență
    
    # Copiile
    w = w_start.copy()
    alpha = alpha_start.copy()
    
    # Repetăm până alpha devine optimal
    while True:
        for i in range(l):
            # a)
            G = y[i] * np.vdot(w, x[i]) - 1 + D[i][i] * alpha[i]
            
            # b)
            if abs(alpha[i]) < tol:
                PG = min(G, 0)             # PG = projected gradient
            elif U != float("inf") and abs(alpha[i] - U) < tol:
                PG = max(G, 0)
            else:
                PG = G
                
            # c)
            if abs(PG) > tol:
                alpha_aux = alpha[i]
                alpha[i] = min(max(alpha[i] - G/(Q[i][i] + D[i][i]), 0), U)
                w += (alpha[i] - alpha_aux) * y[i] * x[i]
                k += 1 # numărăm în câți pași se ajunge la un alpha optimal
            else:
                A[i] = 1  # altfel alpha[i] este optimal
        
        # verificăm dacă alpha este optimal (nu mai sunt valori de 0)
        if A.all() == 1:
            break
            
    return w, k



# Algoritmul 2: Dual Coordinate Descent Method with Randomly Selecting One Instance at a Time
def dual_descent_rand(alpha_start, y, x, U, Q, w_start, D, tol):
    l = len(y)       # lungimea
    A = np.zeros(l)  # A[i] va deveni 1 când alpha[i] devine optimal și ieșim din algoritm când toate val = 1
    k = 0            # nr pași / rata de convergență
    
    # Copiile
    w = w_start.copy()
    alpha = alpha_start.copy()
    
    # Repetăm până alpha devine optimal
    while True:
        # nu mai avem acel for (alegem random o valoare) -> reducem masiv nr de operații și timpul
        i = random.randint(0, l - 1)
        
        # a)
        G = y[i] * np.vdot(w, x[i]) - 1 + D[i][i] * alpha[i]
            
        # b)
        if abs(alpha[i]) < tol:
            PG = min(G, 0)
        elif U != float("inf") and abs(alpha[i] - U) < tol:
            PG = max(G, 0)
        else:
            PG = G
                
        # c)
        if abs(PG) > tol:
            alpha_aux = alpha[i]
            alpha[i] = min(max(alpha[i] - G/(Q[i][i] + D[i][i]), 0), U)
            w += (alpha[i] - alpha_aux) * y[i] * x[i]
            k += 1
        else:
            A[i] = 1  # altfel alpha[i] este optimal
        
        # verificăm dacă alpha este optimal (nu mai sunt valori de 0)
        if A.all() == 1:
            break
            
    return w, k



# Algoritmul 3: Dual Coordinate Descent Method with Shrinking
def dual_descent_shrinking(alpha_start, y, x, U, Q, w_start, D, eps, tol):
    """
        Parametrul Suplimentar:
            eps: epsilon 
    """
    
    l = len(y)
    M_ = float("inf")
    m_ = -1 * float("inf")
    A = list(range(l))
    A_vechi = []        # ca să verifici că s-a modificat lista originală
    k = 0
    
    alpha = alpha_start.copy()
    w = w_start.copy()
    
    while True:
        # 1.
        M = -1 * float("inf")
        m = float("inf")
        
        # 2.
        for i in A:
            # a)
            G = y[i] * np.vdot(w, x[i]) - 1 + D[i][i] * alpha[i]
            
            # b)
            PG = 0
            if abs(alpha[i]) < tol:
                if G > M_:
                    A.remove(i)
                    continue
                elif G < 0:
                    PG = G
            elif abs(alpha[i] - U) < tol:
                if G < m_:
                    A.remove(i)
                    continue
                elif G > 0:
                    PG = G
            else:
                PG = G
            
            # c)
            M = max(M, PG)
            m = min(m, PG)
            
            # d)
            if abs(PG) > tol:
                alpha_aux = alpha[i]
                alpha[i] = min(max(alpha[i] - G/(Q[i][i] + D[i][i]), 0), U)
                w += (alpha[i] - alpha_aux) * y[i] * x[i]
                k += 1
                
        # 3.        
        if M - m < eps:
            if A_vechi == A:
                break                          # converge
            A_vechi = A                        # aici suntem pe linia else
            if A == list(range(l)):
                break
            else:
                A = list(range(l))
                
        # 4.
        if M <= 0:
            M_ = float("inf")
        else:
            M_ = M
            
        # 5.
        if m >= 0:
            m_ = -1 * float('inf')
        else:
            m_ = m
            
    return w, k





""" ----------------    Citire Date de Intrare și Reprezentarea lor    ---------------- """
text = open("dataset.txt", "r").readlines()  # folosim un mini-set din dataset-ul a9a, pentru rapiditate
y = []
x = []

# punem x și y în vectori
# y sunt etichetele: +1 sau -1, de la începutul liniei
# x este prima valoare, înainte de ':'
# a doua val, după ':' este 1, deci x rămâne neschimbat (nu tb să minimizăm/maximizăm datele)
for i in range(len(text)):
    if text[i][:2] != ' ' and text[i][:2] != '\n':
        y.append(float(text[i][:2]))
        
    j = 2
    aux = []
    for k in range(14):
        if j >= len(text[i]):
            break
            
        nr = ''
        if text[i][j] == ' ':
            j += 1
        if j >= len(text[i]):
            break
            
        while j < len(text[i]) and text[i][j] != ' ' and text[i][j] != ':' and text[i][j] != '\n':
            nr += text[i][j]
            j += 1
            
        if nr != '':
            aux.append(float(nr))
        if j >= len(text[i]):
            break
        if text[i][j] == ':':
            j += 3
            
    x.append(aux)


x = np.array(x)
y = np.array(y)

# alpha_start = alpha0 (val random, date de noi)
alpha_start = np.ones(len(y))
# parametrul de penalizare (C > 0 din (1) paper)
C = 0.1
# lungime dataset
l = len(y)
# inițializare Q
Q = np.zeros((l, l), float)
# calcul Q conform (4) paper
for i in range(l):
    for j in range(i, l):
        Q[i][j] = Q[j][i] = y[i] * y[j] * np.vdot(x[i], x[j])
# n-ul -> x aparține R^n
n = len(x[0])
# inițializare w
w_start = np.zeros(n)
# calcul w după formula din algoritmul 1
for i in range(l):
    w_start += y[i] * alpha_start[i] * x[i]

# Marginile de Eroare
tol = 10**-10
eps = 10**-6

# Afișări
print("Dataset: a9a")
print("Numarul de vectori: {}".format(l))
print("Dimensiunea vectorilor: {}".format(n))
print("C (parametrul de penalizare): {}".format(C))
print("Toleranta (tol): {}".format(tol))
print("Epsilon pentru shrinking (e): {}".format(eps))





""" -----------------------      Aplicare Algoritmi pt L1 și L2      -----------------------"""
#######  L1-SVM loss
print("------------------  Loss L1-SVM  ------------------")
D = np.zeros((l, l))    # luăm datele din (4) paper

now = time.time()       # pentru a calcula timpul de rulare al algoritmilor
w, k11 = dual_descent(alpha_start, y, x, C, Q, w_start, D, tol)
timp1 = time.time() - now
print("Algoritmul 1: Dual Coordinate Descent (Simplu)")
print("W: {}".format(w))
print("Numarul de pasi: {}".format(k11))
print("Timpul: {} s".format(timp1))
print("--------------------------------------")

now = time.time()
w, k21 = dual_descent_rand(alpha_start, y, x, C, Q, w_start, D, tol)
timp2 = time.time() - now
print("Algoritmul 2: Dual Coordinate Descent Alegeri Random")
print("W: {}".format(w))
print("Numarul de pasi: {}".format(k21))
print("Timpul: {} s".format(timp2))
print("--------------------------------------")

now = time.time()
w, k31 = dual_descent_shrinking(alpha_start, y, x, C, Q, w_start, D, eps=eps, tol=tol)
timp3 = time.time() - now
print("Algoritmul 3: Dual Coordinate Descent with Shrinking")
print("W: {}".format(w))
print("Numarul de pasi: {}".format(k31))
print("Timpul: {} s".format(timp3))
print("--------------------------------------")
print("\n")



#######  L2-SVM loss
print("------------------  Loss L2-SVM  ------------------")
U = float("inf")                   # luăm datele din (4) paper
D = np.diag(np.full(l, 1/(2*C)))

now = time.time()
w, k12 = dual_descent(alpha_start, y, x, U, Q, w_start, D, tol=tol)
timp1 = time.time() - now
print("Algoritmul 1: Dual Coordinate Descent (Simplu)")
print("W: {}".format(w))
print("Numarul de pasi: {}".format(k12))
print("Timpul: {} s".format(timp1))
print("--------------------------------------")

now = time.time()
w, k22 = dual_descent_rand(alpha_start, y, x, U, Q, w_start, D, tol=tol)
timp2 = time.time() - now
print("Algoritmul 2: Dual Coordinate Descent Alegeri Random")
print("W: {}".format(w))
print("Numarul de pasi: {}".format(k22))
print("Timpul: {} s".format(timp2))
print("--------------------------------------")

now = time.time()
w, k32 = dual_descent_shrinking(alpha_start, y, x, U, Q, w_start, D, eps=eps, tol=tol)
timp3 = time.time() - now
print("Algoritmul 3: Dual Coordinate Descent with Shrinking")
print("W: {}".format(w))
print("Numarul de pasi: {}".format(k32))
print("Timpul: {} s".format(timp3))
print("--------------------------------------")