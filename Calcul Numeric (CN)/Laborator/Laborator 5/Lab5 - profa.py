import numpy as np
import time as time
 
# Exercitiul 1 punctul b)

def subsdesc(A,b,ptol):
    """
    subsdesc rezolva sisteme superior triungiulare
    Input: A = matricea asociata sistemului
           b = vectorul termenilor liberi
           ptol = valoarea numerica in raport cu care comparam numerele egale cu 0
    Output: x = solitia sistemului Ax = b
    """
    #---------------------------------------------
    #Verificare daca matricea este patratica
    dim = np.shape(A)
    m = dim[0] #Numarul de linii
    n = dim[1] #Numarul de coloane
    if m != n:
        print('Matricea nu este patratica')
        x = None
        return
    
    #----------------------------------------------
    #Verificare daca matricea este superior triunghiulara
    for i in range(m):
        for j in range(i):
            if (np.abs(A[i][j])>ptol):
                print('Matricea nu este superior triunghiulara')
                x = None
                return
    
    #------------------------------------------------------
    x = np.zeros((n,1)) 
    x[n-1] = b[n-1]/A[n-1][n-1]
    k = n-2
    while k>-1:
        sum = 0
        for j in range(k+1,n):
            sum = sum + A[k][j] * x[j]
        x[k] = (b[k] - sum)/A[k][k]
        k = k - 1
    
    return x



# A = np.array([[1.0,2.0,3.0], [0 , 2.0,3.0], [0, 0 ,3.0]])
# b = np.array([[1.0],[2.0],[3.0]])
# x = subsdesc(A,b,10**(-12))
# print('Solutia sistemului Ax = b\n')
# print('A = \n',A)
# print('b = \n',b)
# print('x = \n',x)


def subsasc(A,b,ptol):
    """
    subsdesc rezolva sisteme inferior triungiulare
    Input: A = matricea asociata sistemului
           b = vectorul termenilor liberi
           ptol = valoarea numerica in raport cu care comparam numerele egale cu 0
    Output: x = solitia sistemului Ax = b
    """
    #---------------------------------------------
    #Verificare daca matricea este patratica
    dim = np.shape(A)
    m = dim[0] #Numarul de linii
    n = dim[1] #Numarul de coloane
    if m != n:
        print('Matricea nu este patratica')
        x = None
        return
    
    #----------------------------------------------
    #Verificare daca matricea este superior triunghiulara
    for j in range(m):
        for i in range(j):
            if (np.abs(A[i][j])>ptol):
                print('Matricea nu este superior triunghiulara')
                x = None
                return
    
    #------------------------------------------------------
    x = np.zeros((n,1)) 
    x[0] = b[0]/A[0][0]
    for k in range(1,n):
        sum = 0
        for j in range(k):
            sum = sum + A[k][j] * x[j]
        x[k] = (b[k] - sum)/A[k][k]    
    return x

# A = np.array([[1.0,0.0,0.0], [3 , 2.0,0.0], [4., 5. ,3.0]])
# b = np.array([[1.0],[2.0],[3.0]])
# x = subsasc(A,b,10**(-12))
# print('Solutia sistemului Ax = b\n')
# print('A = \n',A)
# print('b = \n',b)
# print('x = \n',x)

def GaussPP(A,b,tol):
    '''
    Parameters
    ----------
    A : float
        Matricea asociata sistemului
    b : TYPE
        DESCRIPTION.
    metoda : TYPE
        DESCRIPTION.
    tol : TYPE
        DESCRIPTION.

    Returns
    -------
    x = solutia sistemului
    '''
    #--------------------------------------
    #Se verifica daca matricea este patratica
    dim = np.shape(A)
    m = dim[0]
    n = dim[1]
    if m!=n:
        print('Matricea nu este patratica.')
    
    #---------------------------------------
    #Definim matricea extinsa
    Aext = np.concatenate((A,b),axis = 1)
    aux = np.zeros((1,n+1))
    #---------------------------------------
    for k in range(n-1):
        max = np.abs(Aext[k][k])
        p = k
        for j in range(k+1,n):
            if np.abs(Aext[j][k])>max:
                max = np.abs(Aext[j][k])
                p = j
        if p!=k:
            aux [:]= Aext[k]
            Aext[k] = Aext[p]
            Aext[p] = aux
        for l in range(k+1,n):
            Aext[l,k+1:n+1] = Aext[l,k+1:n+1] - Aext[l,k]/Aext[k,k] * Aext[k,k+1:n+1]
            Aext[l][k] = 0
    if (np.abs(Aext[n-1][n-1])<=tol):
        print('Sistemul nu admite solutii')
        x = None
        return
    x = subsdesc(Aext[:,0:n],Aext[:,n],tol)
    return x
 
def FactLU(A,tol):
    nr_lin = np.shape(A)[0]
    nr_col = np.shape(A)[1]
 
    L = np.eye(nr_lin, nr_col) # Return a 2-D array with ones on the diagonal and zeros elsewhere
    W = np.arange(0, nr_lin) # array cu elem de la 0 la nr_lin - 1
 
    U = np.copy(A) # copie a matricei A
 
    for k in range(0, nr_lin - 1):
        max = abs(U[k][k])
        p = k
        for j in range(k + 1, nr_lin):
            if abs(U[j][k]) > max:
                max = abs(U[j][k])
                p = j
 
        if abs(U[p][k]) <= tol:
            print('A nu admite factorizarea LU') # Aici in loc de == scriem <=
            return None, None, None
 
        if p != k:
            U[[p, k],:] = U[[k, p], :]
            W[[p, k]] = W[[k, p]]
 
            if k > 0:
                L[[p, k], 0 :k] = L[[k, p], 0:k]
 
        for l in range(k + 1, nr_lin):
            L[l][k] = U[l][k]  / U[k][k] 
            U[l][k] = 0
            U[l, k+1:nr_lin]  = U[l, k+1:nr_lin] - L[l][k] * U[k, k+1:nr_lin]
 
    if abs(U[nr_lin - 1][nr_lin - 1]) <= tol: # Aici in loc de == scriem <=
        print('A nu admite factorizarea LU')
        return None, None, None
 
    return L, U, W
 
# print('--PARTEA 1--nn')
 
# A1 = np.array([[0., 1., 1.], [2., 1., 5.], [4., 2., 1.]])
# b1 = np.array([[3.], [1.], [5.]])
# tol = 10**(-10)
 
# L1, U1, W1 = FactLU(A1, tol)
 
# print('--SOLUTIE 1--\n')
 
# print('Matricea L este \n {}'.format(L1))
 
# print('Matricea U este \n {}'.format(U1))

# print('Vectorul W este \n {}'.format(W1))
 
 
# print('--VERIFICARE 1--n')
 
# print('Matricea A este  \n {}'.format(A1))
 
# print('Inmultire LU =   \n {}'.format(L1@U1))
 
# print('LU = A cu liniile inversate conform Wn')
 
# bPrim = np.copy(b1)
# for i in range(len(bPrim)):
#     bPrim[i] = b1[W1[i]]
 
# print('--VECTORUL b DUPA INVERSAREA W  \n {}'.format(bPrim))
 
# y = subsasc(L1, bPrim, tol) # Aici se foloseste metoda substitutiei ascendente
# x = subsdesc(U1, y, tol)
 
# print('--X  \n {}'.format(x))
# print('--VERIFICARE (Ax = b)  \n {} = \n {}'.format(A1@x,b1))
 

print('--PARTEA 2--nn')
print('n--SUBPUNCTUL B--n')
 
A2 = np.random.rand(100,100)*10
 
b2 = np.zeros((100, 1))
 
for i in range(100):
    b2[i] = np.sum(A2[i])
 
print('Vectorul coloana b este \n {}'.format(b2))
 
t1 = time.time()

tol = 10**(-10)
L2, U2, W2 = FactLU(A2, tol)
 
bPrim2 = np.copy(b2)
 
for i in range(len(b2)):
    bPrim2[i] = b2[W2[i]]
 
y2 = subsasc(L2, bPrim2, tol)
 
x2 = subsdesc(U2, y2, tol)
 
print('Solutia sistemului este \n {}'.format(x2))
 
print('--PARTEA 3--\n')
print('--SUBPUNCTUL C--\n')

 
t1 = time.time()

tol = 10**(-10)
L2, U2, W2 = FactLU(A2, tol) 
x_old = np.copy(x2)
bPrim3 = np.copy(b2)
 
for k in range(100):
      for i in range(len(b2)):
        bPrim3[i] = x_old[W2[i]] + 2.
      y3 = subsasc(L2, bPrim3, tol)
      x_new = subsdesc(U2, y3, tol)
      x_old = x_new
 
#print('Solutia sistemului este \n {}'.format(x_old))
t2 = time.time()
 
print('Solutia finala prin LU(primele 5 elemente)  \n {}'.format(x_old[0:5,0]))
 
print('Timp de executie \n' + str(t2 - t1))
 

t1 = time.time()
x_old_Gauss = np.copy(x2)
for k in range(100):
    x_old_Gauss += 2
    x_new_Gauss = GaussPP(A2, x_old_Gauss, tol)
    x_old_Gauss = x_new_Gauss
    
    
t2 = time.time()


 
print('n---------------------------------------------n')
 
print('Solutia finala prin GPP (primele 5 elemente)  \n {}'.format(x_old_Gauss[0:5,0]))
 
print('Timp de executie \n' + str(t2 - t1))
 
#Pentru verificaare

# t1 = time.time()
# x_old_linalg = np.copy(x2)
# for k in range(100):
#     x_old_linalg +=2
#     x_new_linalg = np.linalg.solve(A2, x_old_linalg)
#     x_old_linalg = x_new_linalg 
    
    
# t2 = time.time()


 
# print('n---------------------------------------------n')
 
# print('Solutia finala prin linalg (primele 5 elemente)  \n {}'.format(x_old_linalg[0:5,0]))
 
# print('Timp de executie \n' + str(t2 - t1))