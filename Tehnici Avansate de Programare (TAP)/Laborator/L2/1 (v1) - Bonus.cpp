/*
    Bonus
*/
#include <iostream>
#include <list>
using namespace std;

struct Interval
{
    int x, y;
};

int cmp(const void *a, const void *b)
{
    Interval *fa=(Interval*)a;
    Interval *fb=(Interval*)b;

    if(fa->x==fb->x) return fa->y>fb->y;
    return fa->x>fb->x;
};

int main()
{
    Interval I;
    cout<<"Dati Intervalul Principal: "; cin>>I.x>>I.y;
    int nr, i;
    cout<<"Dati Nr Intervale: "; cin>>nr;
    Interval V[nr], maxi;
    list<Interval> Solutie;
    cout<<"Dati Intervalele: "<<endl;
    for(i=0; i<nr; i++) cin>>V[i].x>>V[i].y;

    qsort(V, nr, sizeof(Interval), cmp);

    int st=I.x, dr=I.y;
    bool ok=true;

    if(V[0].x<=st) maxi=V[0];
    else ok=false;

    for(i=0; i<nr-1; i++)
        if(V[i+1].x<st)
            if(maxi.y<V[i].y) maxi=V[i];
            else;
        else
        {
            Solutie.push_back(maxi);
            st=maxi.y;
            maxi.x=0;
            maxi.y=0;
        }

    if(st<dr && V[nr-1].x<=st)
        if(maxi.y<V[nr-1].y)
        {
            Solutie.push_back(V[nr-1]);
            st=V[nr-1].y;
        }
        else
        {
            Solutie.push_back(maxi);
            st=maxi.y;
        }

    if(st<dr) ok=false;
    cout<<"Solutie: "<<endl;
    if(ok==false) cout<<-1<<endl;
    else
        for(auto i=Solutie.begin(); i!=Solutie.end(); i++) cout<<i->x<<' '<<i->y<<endl;

    return 0;

}
