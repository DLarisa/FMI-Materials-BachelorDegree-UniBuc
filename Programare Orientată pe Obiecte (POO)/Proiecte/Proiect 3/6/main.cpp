#include <iostream>
#include "Farmacie.h"
#include "Fizica.h"
#include "Online.h"
#include "GestionareFarmacii.h"
using namespace std;

int main()
{
    GestionareFarmacii <Online> a;
    Online b, c; cin >> b>> c;
    a += b; a+=c;
    a.print();

    return 0;
}
