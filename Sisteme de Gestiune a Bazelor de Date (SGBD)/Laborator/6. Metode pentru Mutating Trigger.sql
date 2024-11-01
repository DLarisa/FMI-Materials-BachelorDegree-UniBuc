/* Cerință: Să se implementeze un trigger prin care să se adauge constrângerea 
ca într-un departament să nu existe mai mulți de 30 de angajați */





---- Mutating Trigger cu Pachete Globale și 3 Triggere Separate

create or replace package aux is
type depinfo is record(nr number, info number);
type deplista is table of depinfo index by pls_integer;
deps deplista;
end;
/

create or replace trigger limitadep_bf 
before insert or update of department_id on emp_lgd
begin
  aux.deps.delete;
  for d in (select department_id, count(employee_id) nrang
            from emp_lgd right join departments using(department_id)
            group by department_id) loop
    aux.deps(d.department_id).nr:=d.nrang;
    aux.deps(d.department_id).info:=0;
  end loop;
end;
/

create or replace trigger limitadep_bf_row 
before insert or update of department_id on emp_lgd
for each row
begin
if :new.department_id is not null then
      aux.deps(:new.department_id).nr:=aux.deps(:new.department_id).nr+1;
      aux.deps(:new.department_id).info:=1;
    if inserting then
      if aux.deps(:new.department_id).nr>30 then
       raise_application_error(-20345,'prea multi angajati la inserare in dep '||:new.department_id);
      end if;
    end if;
end if;
if updating and :old.department_id is not null then
    aux.deps(:old.department_id).nr:=aux.deps(:old.department_id).nr-1;
end if;
end;
/

create or replace trigger limitadep_af 
after update of department_id on emp_lgd
declare 
poz number;
begin
poz:=aux.deps.first;
 for i in 1..aux.deps.count loop
  if aux.deps(poz).info=1 and aux.deps(poz).nr>30 then
   raise_application_error(-20345,'prea multi angajati la modificare in dep '||poz ||
   '('||aux.deps(poz).nr||' angajati)');
  end if;
  poz:=aux.deps.next(poz);
 end loop;
end;
/






---- Trigger Compus

CREATE OR REPLACE TRIGGER limita_dep
FOR INSERT or UPDATE of department_id ON emp_lgd
COMPOUND TRIGGER
type depinfo is record(nr number, info number);
type deplista is table of depinfo index by pls_integer;
deps deplista;
poz number;

     BEFORE STATEMENT IS
     BEGIN
         
         for d in (select department_id, count(employee_id) nrang
            from emp_lgd right join departments using(department_id)
            group by department_id) loop
          deps(d.department_id).nr:=d.nrang;
          deps(d.department_id).info:=0;
         end loop;
     END BEFORE STATEMENT;
   
     BEFORE EACH ROW IS
     BEGIN
      if :new.department_id is not null then
       deps(:new.department_id).nr:=deps(:new.department_id).nr+1;
       deps(:new.department_id).info:=1;
     if inserting then
      if deps(:new.department_id).nr>30 then
       raise_application_error(-20345,'prea multi angajati la inserare in dep '||:new.department_id);
      end if;
     end if;
    end if;
     if updating and :old.department_id is not null then
      deps(:old.department_id).nr:=deps(:old.department_id).nr-1;
     end if;
     END BEFORE EACH ROW;
   
     AFTER STATEMENT IS
     BEGIN
       poz:=deps.first;
        for i in 1..deps.count loop
          if deps(poz).info=1 and deps(poz).nr>30 then
           raise_application_error(-20345,'prea multi angajati la modificare in dep '||poz ||
             '('||deps(poz).nr||' angajati)');
         end if;
        poz:=deps.next(poz);
       end loop;
     END AFTER STATEMENT;

END limita_dep;
/