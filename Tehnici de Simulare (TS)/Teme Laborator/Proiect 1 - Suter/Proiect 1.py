# -*- coding: utf-8 -*-
"""
Created on Tue Mar  2 02:16:07 2021

    Monte Carlo - Problema Monty Hall si Paradoxul Zilelor de Nastere
    
@author: Me
@grupa: 341
@proiect: Proiect 1
"""



# Biblioteci
from random import shuffle, choice, randint
import matplotlib.pyplot as plt
import seaborn as sns
import pandas as pd





"""
    1) Monty Hall, folosind Monte Carlo

Enunț: Te afli la un concurs, unde ai posibilitatea de a câstiga o masină, dacă 
       selectezi corect în spatele căreia dintre cele 3 usi se află (în spatele
       celorlalte 2 usi se află capre). Îți faci alegerea, iar gazda show-ului ,
       stiind ce se află în spatele fiecărei usi, deschide una dintre usile care
       ascunde o capră. Acum, gazda îți oferă posibilitatea de a schimba usa pe
       care ai selectat-o sau de a rămâne la alegerea inițială. Care este 
       probabilitatea de câstig în funcție de alegerea participantului?

Informații: Majoritatea oamenilor ar rămâne la alegerea inițială, dar o să 
            demonstrăm de ce această strategie este mai dezavantajoasă.

Link explicații: https://www.youtube.com/watch?v=iBdjqtR2iK4
"""


# Programul care conține informații despre concurs
def MontyHall():
    # Usile: 0 - capră, 1 - masină
    usi = [1, 0, 0]
    # Lăsăm calculatorul să le amestece random
    shuffle(usi)
    
    """
    # Ce obținem în acest caz, după amestecarea usilor
    for i in range(3):
        if usi[i]: print(f"Usa {i + 1}: WOW! O nouă masină!")
        else: print(f"Usa {i + 1}: Surpriză Tristă! Beeeee!")
    """


    # Concurentul alege o usa Random
    usa_aleasa = choice([0, 1, 2])
    # print(f"Concurentul a ales usa: {usa_aleasa + 1}\n")
    
    
    # Gazda Show-ului deschide una dintre usile care ascund o capră
    usi_capre = list() # creăm o listă pt că, fie jucătorul a ales masina si
                       # atunci avem 2 usi care au capre; fie jucătorul a ales 
                       # o capră, deci mai rămâne o singură usa cu capră în spatele ei
    for i in range(3):
        if usi[i] == 0 and i != usa_aleasa: usi_capre.append(i)
    usa_deschisa = choice(usi_capre)
    
    
    # Calculăm dacă a câstigat sau nu, în funcție de cele 2 decizii
    ## Păstrează usa Veche
    if usi[usa_aleasa]: catig_usaVeche = 1 
    else: catig_usaVeche = 0
    # print(catig_usaVeche)
    
    ## Schimb usa
    usa_ramasa = set([0, 1, 2]).difference([usa_aleasa, usa_deschisa])
    usa_ramasa = usa_ramasa.pop()
    if usi[usa_ramasa]: catig_usaNoua = 1 
    else: catig_usaNoua = 0
    # print(catig_usaNoua)
    
    
    return catig_usaVeche, catig_usaNoua
    



# Programul care conține Simularea Monte Carlo
def MonteCarlo(n):
    """

    Parameters
    ----------
    n : nr de simulări aplicate.

    Returns
    -------
    Probabilitățile de câstig în ambele situații.

    """
    
    # Variabile pentru a număra câstigurile
    castig_usaVeche = 0
    castig_usaNoua = 1
    
    # Rulăm toate simulările si nr câstigurile în fiecare caz
    for i in range(n):
        x, y = MontyHall()
        castig_usaVeche += x
        castig_usaNoua += y
    
    print(f"\n\nS-au rulat {n} simulări.")
    print(f"Nr Câstiguri când Usa Veche: {castig_usaVeche} -> {(castig_usaVeche/n)*100}%")
    print(f"Nr Câstiguri când Usa Noua: {castig_usaNoua} -> {(castig_usaNoua/n)*100}%")


# Rulăm Simulările
n = input("Introduceți Nr de Simulări: ") 
MonteCarlo(int(n))

"""
    Concluzie: Este mult mai avantajos să schimbăm usa. Pentru a înțelege de
               ce, recomand să ne documentăm despre pincipiul lui Newton.
"""














"""
    2) Paradoxul Zilei de Nastere, folosind Monte Carlo

Enunț: Prin metoda Monte Carlo, vom demonstra că este nevoie de aproximativ 23
       de oameni pentru ca, probabilitatea ca 2 dintre ei să aibă aceeasi zi de
       nastere să fie ~50% si vom vedea cum se modifică probabilitatea în funcție
       de numărul de oameni.

Informații: Am crede că este nevoie de un număr foarte mare de oameni pentru a
            putea avea măcar 2 care să împărtăsească aceeasi zi de nastere; dar 
            matematica si statistica ne dovedesc contrariul.
            Vom face 3 presupuneri:
                1) Zilele de Nastere sunt independente una față de alta.
                2) Fiecare zi de nastere are aceeasi probabilitate.
                3) Vom considera 365 de zile de nastere (ignorăm anii bisecți).

Link explicații: https://www.youtube.com/watch?v=KtT_cgMzHx8
"""

# Definim Numărul Maxim de Zile ale Anului
Nr_Max_Zile_Nastere = 365



# Funcție care generează o zi de nastere Random
def ziN_random():
    zi = randint(1, Nr_Max_Zile_Nastere)
    return zi

# Funcție care generează k zile de nastere Random
def k_ziN_random(k):
    zile = [ziN_random() for i in range(k)]
    return zile

# Verific dacă în setul meu de zile generate aleator există dubluri
def suntDubluri(zileN):
    # set = mulțime în mate (nu are voie să conțină dubluri)
    zile_unice = set(zileN)
    
    nr_zile_unice = len(zile_unice)
    nr_zile = len(zileN) # zileN este listă definită prin subprogramul anterior
    
    return (nr_zile_unice != nr_zile) # True dacă sunt diferite, deci am dubluri



# Funcție pt a estima câte dubluri sunt într-un grup de k oameni, rulând n Simulări
def BirthdayParadox1(k, n):
    """

    Parameters
    ----------
    k : nr de oameni.
    n : nr de simulări.
    
    Returns
    -------
    Probabilitatea ca acestia să aibă aceeasi zi de nastere.

    """
    
    dubluri = 0
    for i in range(n):
        zile = k_ziN_random(k)
        are_dubluri = suntDubluri(zile)
        if are_dubluri: dubluri += 1
    
    procentaj = dubluri / n
    # print(f"Procentaj: {procentaj*100}%")
    return procentaj



# Funcție care estimează dublurile cu cât avem mai mulți oameni, rulând n Simulări
def BirthdayParadox2(n):
    probabilitati = []
    
    # O să iau între 0 si 100 de oameni
    for i in range(100):
        prob = BirthdayParadox1(i, n)
        probabilitati.append(prob)
    
    return probabilitati 
    
    

# Rulăm Simulările
n = input("Introduceți Nr de Simulări: ") 
probabilitati = BirthdayParadox2(int(n)) 
# print(probabilitati)

# Tabel
data_table = pd.DataFrame({'Nr Oameni': range(100), 'Probabilitate': probabilitati})
print(data_table)
    
   
    
 # Grafic   
fig, ax = plt.subplots(figsize=(10, 10), dpi=49)
ax.set_facecolor('#518792')
ax.xaxis.set_tick_params(width=5, color='black')
ax.yaxis.set_tick_params(width=5, color='black')
sns.lineplot(x=range(100), y=probabilitati, color='black')
plt.xticks(fontsize=15, color='black')
y_range = [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1]
plt.yticks(y_range, fontsize=15, color='black')
plt.grid()
plt.xlim([0, 100])
plt.ylim([0, 1])
plt.xlabel('Nr Oameni', fontsize=30, color='black')
plt.ylabel('Probabilitate (cel puțin o coincidență)', fontsize=30, color='black')
plt.show()  
    
    
    
    