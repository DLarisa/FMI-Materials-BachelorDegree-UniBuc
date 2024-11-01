-- Subiect 1
create table categories(id number(11) not null PRIMARY KEY, title varchar(25) not null);
insert into categories values (1, 'Boy-Groups');
insert into categories values (2, 'Girl-Groups');
insert into categories values (3, 'Boy-Solo');
insert into categories values (4, 'Girl-Solo');

create table products(id number(11) not null PRIMARY KEY, title varchar(225) not null, 
                      price number(5,2) not null, cat_id number(11));
insert into products values(1, 'A1', 10.20, 1);
insert into products values(2, 'A2', 15.70, 2);
insert into products values(3, 'B1', 30, 3);
insert into products values(4, 'B2', 25, 4);
insert into products values(5, 'B3', 17.89, 1);
insert into products values(6, 'C1', 44, 2);
insert into products values(7, 'C2', 18.99, 3);

create table orders(id number(11) not null PRIMARY KEY, prod_id number(11) not null,
                    quantity number(3));
insert into orders values(1, 1, 3);
insert into orders values(2, 2, 5);
insert into orders values(3, 3, 7);
insert into orders values(4, 1, 4);
insert into orders values(5, 2, 10);

alter table products
add foreign key(cat_id) references categories(id);

alter table orders
add foreign key(prod_id) references products(id);


select *
from products;




-- Subiect 2
--- a) O cheie primară ajută la identificarea în mod unic a înregistrărilor dintr-un tabel.
---    Este o coloană (sau un set de coloane) din tabel și este doar una în fiecare tabel. 
---    Spre ex, în schema de mai sus, toate atributele 'id' din fiecare tabel sunt PK.
---    O cheie externă este un set de atribute dintr-un tabel care face referire la 
---    cheia primară dintr-un alt tabel al bazei de date. Astfel se pot definii relațiile de
---    1:1, 1:m, m:n. Cheia externă face legătura între 2 tabele ale bazei de date. 
---    Spre exemplu, în tabelul order, există o cheie externă prod_id, care face referire
---    la cheia primară id a tabelului products.

--- b) Vectori și tablou imbricat
---    Asemănări: 1 - pot fi folosite atât în PL/SQL, cât și în SQL.
---               2 - amândouă sunt date de tip colecții și trebuie inițializate și/sau 
---                   extinse pentru a se putea lucra cu ei.
---    Deosebiri: 1 - pt vectori trebuie să specificăm lungimea maximă, nu și pt tablouri imbricate
---               2 - ordinea elementelor în vectori este păstrată, nu și pt tablouri imbricate

---- c) Un cursor este un pointer la o zonă de memorie, numită context area (folosită de sistemul
---     Oracle pentru a procesa o comandă SQL). Deosebiri cursor dinamic și predefinit: 
---     Cursorul predefinit este fix (obiect static), poate fi modificat puțin cu ajutorul parametrilor
---     și dacă fac modificări în tabele după ce am deschis acest cursor, ele nu se reflectă în cursor.
---     Cel dinamic este 'modificabil' (este pointer la un cursor), în sensul în care 
---     toate modificările făcute asupra tabelului se reflectă în cursor în timp ce acesta e deschis.

---- d) cu select poti să apelezi funcții, nu proceduri
---     select functie(param) from dual;
---     create or replace function functie(id number) return varchar -> returneaza titlul produsului cand e dat id-ul acestuia

---- e) Asemănări: 1 - triggeri LMD
---                2 - pot avea before și after
---     Deosebiri: 1 - for each row și when doar la triggeri de linie;
---                2 - triggeri la nivl de linie se execută pt fiecare linie din tranzacție, dar cel tabel se execută o singură dată (pt o tranzacție)





set serveroutput on;
set echo off;
set verify off;

-- Subiect 3
--- 1:n -> categories și products (într-o categorie sunt mai multe produse; un produs aparține unei singure categorii)
--- a)
create or replace type vector as varray(10) of varchar(225);
create table tabel1(id number(11), valori vector);

create or replace type tablou_imbricat is table of vector;
create table tabel2(id number(11), valori tablou_imbricat)
nested table valori store as tabel2_valori_nested;
drop type tablou_imbricat;
drop table tabel2;


--- b)
create or replace procedure p1 (id_categorie number) is
  v    vector := vector();
  nr   number := 1;
  
  cursor c is select * from products
              where id_categorie = cat_id;
begin
  for i in c loop
    v.extend;
    v(nr) := i.title;
    nr := nr + 1;
  end loop;
  
  insert into tabel1 values(id_categorie, v);
end;
/

execute p1(1);
execute p1(2);
execute p1(3);
execute p1(4);

select * 
from tabel1;
rollback;


--- c)
create or replace procedure p2 is
  t    tablou_imbricat := tablou_imbricat();
  nr   number := 1;

  cursor c is select *
              from tabel1
              order by id;
begin 
  for i in c loop
    t.extend;
    t(nr) := i.valori;
    nr := nr + 1;
  end loop;
  
  insert into tabel2 values(1, t);
end;
/

execute p2;

select * 
from tabel2;


--- d)
declare
  pret   products.price%type := &Dati_Pretul;
  nr     number := 0;
  
  cursor c(parametru number) is
    select *
    from products 
    where price < parametru
    order by price;
begin
  for i in c(pret) loop
    dbms_output.put_line(i.title || ' are pretul: ' || i.price);
    nr := nr + 1;
  end loop;
  if nr = 0 then dbms_output.put_line('Nu exista info in tabel');
  end if;
end;
/




-- 2
create or replace trigger t1
for insert or update on products
COMPOUND TRIGGER
-- vector de id*uri
TYPE vector is table of number index by pls_integer;
v    vector;   
nr   number := 0;
    
--Executed before DML statement
BEFORE STATEMENT IS
BEGIN
  for i in (select id from products)
  loop
    v(nr) := i.id;
    nr := nr + 1;
  end loop;
END BEFORE STATEMENT;
   
--Executed before each row change- :NEW, :OLD are available
BEFORE EACH ROW IS
BEGIN
  if inserting then
    for i in v.first..v.last loop
      if v(i) = :new.id then raise_application_error(-20000, 'Eroare!');
      end if;
    end loop;
  end if;
END BEFORE EACH ROW;
   
--Executed aftereach row change- :NEW, :OLD are available
AFTER EACH ROW IS
BEGIN
  if updating then
  for i in v.first..v.last loop
    if v(i) = :new.id then raise_application_error(-20005, 'Eroare!');
    end if;
  end loop;
  end if;
END AFTER EACH ROW;

END;
/

insert into products values (1, 'as', 20.50, 3);
update products set id = 1;