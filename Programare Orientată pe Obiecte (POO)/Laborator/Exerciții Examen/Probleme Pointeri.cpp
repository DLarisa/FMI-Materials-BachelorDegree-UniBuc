// Introducere (la tabla.)
#include <iostream>
#include <string>

int main()
{
    int array[] = {1 , 3};
    int *p = array;
    std::cout << *p++;
    std::cout << *p;
}

////////////////////////////

1.

#include <stdio.h>
void fun(int x)
{
    x = 30;
}

int main()
{
    int y = 20;
    fun(y);
    printf("%d", y);
    return 0;
}

2.

#include <iostream>
using namespace std;
int main()
{
    int x = 10, y = 15, i;
    for (i = 0; i < 1; i++) {
        int x = 20, y = 15;
    }
    int mul = x * y;
    cout << x << "*" << y << " = " << mul;
    return 0;
}

3.

#include <iostream>
using namespace std;
int main()
{
    int x[5] = { 1, 2, 3, 4, 5 };

    int* p = x;
    int i;

    for (i = 0; i < 2; i++) {
        int temp = *(p + i);
        *(p + i) = *(p + 4 - i);
        *(p + 4 - i) = temp;
    }

    for (i = 0; i < 5; i++)
        cout << x[i] << " ";
    return 0;
}

4.

#include <stdio.h>
int main()
{
    int num = 10; // Presupunem ca num se afla la adresa 500.
    printf("num = %d addresss of num = %u", num, &num);
    num++;
    printf("\n num = %d addresss of num = %u", num, &num);
    return 0;
}

5.

#include <stdio.h>
int main()
{
    int a = 36;
    int* ptr;
    ptr = &a;
    printf("%u %u", *&ptr, &*ptr);
    return 0;
}

6.

#include <iostream>
using namespace std;
int main()
{
    int arr[] = { 4, 5, 6, 7 };
    int* p = (arr + 1);
    cout << *arr + 10;
    return 0;
}

7.

#include <iostream>
using namespace std;

int main()
{
    const int i = 20;
    const int* const ptr = &i;
    (*ptr)++;
    int j = 15;
    ptr = &j;
    cout << i;
    return 0;
}

8.

#include<stdio.h>
int main()
{
    int x = 20, *y, *z;

    // Presupunem adresa lui X ca fiind 500.
    y = &x;  //ia adresa lui x adica 500
    z = y;
    *y++;  //pt ca e int creste cu 4 octeti (se muta cum ar veni in vector)
    *z++;
    x++;
    printf("x = %d, y = %d, z = %d \n", x, y, z);
    return 0;
}

9.

#include <iostream>
using namespace std;

int main()
{
    int a = 32, *ptr = &a;
    char ch = 'A', &cho = ch; //cho ia valoarea lui ch, arata inspre el (sunt identice)
    // ASCII pentru 'A' este 65.

    cho += a;
    *ptr += ch;
    cout << a << ", " << ch << endl;
    return 0;
}

10.

#include <iostream>
using namespace std;
int main()
{
    int num[5];
    int* p;
    p = num; //p=num[0]
    *p = 10; //num[0]=10
    p++; //p=num[1]
    *p = 20; //num[1]=20;
    p = &num[2]; //p=num[2] (num[2]=*(num+2)---> cu & din fata se anuleaza)
    *p = 30; //num[2]=30
    p = num + 3; //p=num[0]+ 3 int-i=num[3]
    *p = 40; //num[3]=40
    p = num; //p=num[0]
    *(p + 4) = 50; //p=num[4]=50
    for (int i = 0; i < 5; i++)
        cout << num[i] << ", ";
    return 0;
}

11.

#include <iostream>
using namespace std;

int main()
{
    int track[] = { 10, 20, 30, 40 }, *striker;

    striker = track;
    track[1] += 30;
    cout << "Striker>" << *striker << " ";
    *striker -= 10;
    striker++;
    cout << "Next@" << *striker << " ";
    striker += 2;
    cout << "Last@" << *striker << " ";
    cout << "Reset To" << track[0] << " ";

    return 0;
}

12.

#include <iostream>
using namespace std;
#include <stdio.h>
int main()
{
    char* str[] = { "AAAAA", "BBBBB", "CCCCC", "DDDDD" }; //matrice
    char** sptr[] = { str + 3, str + 2, str + 1, str }; //tablou tridimensional ---> la str le ia pe toate de mai sus
    char*** pp; //are 4 dimensiuni

    pp = sptr; //pp==DDDDD
    ++pp; //pp== CCCCC DDDDD
    printf("%s", **++pp + 2); //stelutele se fac ultimele
    return 0;
}










