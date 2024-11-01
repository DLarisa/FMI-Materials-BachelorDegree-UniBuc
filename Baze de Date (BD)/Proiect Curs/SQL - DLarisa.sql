/*
    QUERY DLarisa
*/

-- DISTINCT + Subinterogare în WHERE (Numele tuturor formațiilor care au câștigat toate premiile posibile)
select distinct l.name
from band_lgd l join wins_lgd w on l.band_id = w.band_id
where l.band_id in (
SELECT DISTINCT band_id
FROM wins_lgd a
WHERE NOT EXISTS (SELECT 1
                  FROM prize_lgd p
                  WHERE p.year = 2015
                  AND NOT EXISTS (SELECT 'x'
                                  FROM wins_lgd b
                                  WHERE p.prize_id = b.prize_id
                                  AND b.band_id = a.band_id))
);


-- Subinterogare în HAVING + MAX + COUNT + TO_CHAR + GROUP BY(Se afișează toți cântăreții care au luna de naștere egală cu luna în care s-au născut cât mai mulți dintre ei)
select singer_id, last_name||' '||first_name Nume, birthday
from singer_lgd
where to_char(birthday, 'mm') in 
(select to_char(birthday, 'mm')
from singer_lgd
group by to_char(birthday, 'mm')
having count(*) = (select max(count(*))
                   from singer_lgd
                   group by to_char(birthday, 'mm')));
                   

-- Subinterogare în SELECT + COUNT + AVG + ROUND + NVL + LEFT JOIN + LOWER (LIKE) + ORDER BY (Să se afișeze, ordonat după medie nr membrii, id-ul, nume, nr de formații, media nr de membrii pe formație, țara, orașul, mailul - dacă există, dacă nu, un mesaj - pt toate companiile care se află într-o țară care conține litera K)
select d.company_id, d.name,

      (select count(band_id) 
       from band_lgd
       where d.company_id=company_id) Nr_formatii,
       
       nvl((select round(avg(no_of_members), 2)
       from band_lgd
       where d.company_id=company_id), 0) as Medie_nr_Membrii,
       
       country, city, nvl(email, 'Nu exista adresa de mail') email
from company_lgd d left join band_lgd b
on d.company_id = b.company_id
where lower(country) like '%k%'
group by d.company_id, d.name, country, city, email
order by 4;


-- MONTHS_BETWEEN + Subinterogare în FROM (Pt fiecare formație, să se afișeze albumul/albumele care are pretul > media preturilor tuturor albumelor sale și nu are mai mult de 100 de săptămâni vechime)
select name, title, pret_mediu, price, nr_albume, launch_date
from album_lgd e join band_lgd d on e.band_id = d.band_id
join 

     (select round(avg(price), 2) pret_mediu, count(*) nr_albume, band_id
      from album_lgd
      group by band_id) aux
      
on d.band_id = aux.band_id
where price >= pret_mediu and months_between(sysdate, launch_date) < 100;


-- START WITH + CONNECT BY + UPPER + REPLACE (Să se afișeze toți membrii care îl au ca lider pe Kim Jun-myon, începând cu liderul)
with suho as (select singer_id
              from singer_lgd
              where upper(replace(last_name||first_name, '-')) = 'KIMJUNMYON')                 
select leader_id, singer_id, first_name||' '||last_name Nume, birthday, phone_number, level
from singer_lgd
start with singer_id = (select *
                        from suho)
connect by prior singer_id = leader_id;


-- MINUS (Operații pe Mulțimi: Cântăreții care nu aparțin de niciun grup)
select first_name||' '||last_name as nume
from singer_lgd
minus
select first_name||' '||last_name as num
from singer_lgd
where band_id is not null;


-- SUM + ANY + INNER JOIN (Să se afișeze toate albumele care au genul POP, mai mult de 7 melodii și durata albumului este mai mare decât oricare durată a oricărui album)
select a.album_id, a.title, durata, a.no_of_tracks
from album_lgd a join 
                    (select album_id, sum(length) durata
                     from song_lgd
                     group by album_id) cantece
on a.album_id = cantece.album_id
inner join album_lgd b on a.album_id = b.album_id
where lower(a.genre) like '%pop%' and b.no_of_tracks >= 7 and durata > any(select sum(length)
                                                                           from song_lgd
                                                                           group by album_id);
                                                                           
                                                                           
-- FULL JOIN + INTERSECT + ROWNUM (Să se afișeze primii 10 câtăreți, în ordine alfabetică, care fac parte dintr-o formație muzicală)
with query as (select last_name||' '||first_name Nume, s.band_id, b.band_id, b.name
               from singer_lgd s full outer join band_lgd b on s.band_id = b.band_id
               intersect
               select last_name||' '||first_name Nume, s.band_id, b.band_id, b.name
               from singer_lgd s join band_lgd b on s.band_id = b.band_id
               order by 1)
select Nume, name
from query
where rownum <= 10;


-- MIN + RIGHT JOIN + ADD_MONTHS + CASE + DECODE
select c.company_id, c.name, b.band_id, b.name formatie, no_of_members, c.country, 
       add_months(b.launch_date, 
                                case 
                                when c.country = 'Korea' then 200
                                when c.country = 'United Kingdom' then 150
                                when c.country = 'United States of America' then 100
                                else 120
                                end) "Contractul va Expira"
from company_lgd c right join band_lgd b on c.company_id = b.company_id
where no_of_members * 0.7 >= (select min(no_of_members)
                              from band_lgd);
/*la case, puteam să folosim și decode, astfel: 
select c.company_id, c.name, b.band_id, b.name formatie, no_of_members, c.country, 
       add_months(b.launch_date, 
                                decode(c.country, 'Korea', 200,
                                                  'United Kingdom', 150,
                                                  'United States of America', 100,
                                                    120)) "Contractul va Expira"
from company_lgd c right join band_lgd b on c.company_id = b.company_id
where no_of_members * 0.7 >= (select min(no_of_members)
                              from band_lgd);
*/
                              

-- SUBSTR + ROLLUP + SUM + TO_DATE + LAST_DAY + UNION
select band_id, album_id, sum(length)
from band_lgd join album_lgd using (band_id)
join song_lgd using (album_id)
where substr(band_lgd.name, 1, 1) = 'T'
group by rollup(band_id, album_id)
union
select band_id, album_id, sum(length)
from band_lgd join album_lgd using (band_id)
join song_lgd using (album_id)
where last_day(launch_date) = to_date('31-05-2013', 'dd-mm-yyyy')
group by rollup(band_id, album_id);


-- NULLIF + NOT EXISTS
select company_id, name, country
from company_lgd c
where not exists(select 'x'
                 from band_lgd
                 where c.company_id = company_id)
and nullif(country, 'Italy')= country;


-- INSTR + VARIABILE
select a.singer_id, a.last_name, a.first_name, a.leader_id, b.last_name||' '||b.first_name Leader
from singer_lgd a join singer_lgd b on a.leader_id = b.singer_id
start with a.singer_id in (select singer_id 
                           from singer_lgd
                           where instr(lower(last_name||first_name), '&y') = &x)
connect by prior a.singer_id = a.leader_id;


--
select company_id,
case
  when lower(country) like 's%' 
  then (select count(*) 
        from band_lgd 
        where company_id = j.company_id)
        
  when (select max(no_of_members) 
        from band_lgd
        where company_id = j.company_id) = (select max(no_of_members) 
                                            from band_lgd)    
  then (select round(avg(no_of_members), 2) 
        from band_lgd)
        
  else (select min(no_of_members) 
        from band_lgd 
        where company_id = j.company_id)
end info
from company_lgd j;


-- 
select a.title, min(length)
from album_lgd a join song_lgd s on a.album_id = s.album_id
group by a.title
having avg(length) = (select max(avg(length))
                      from song_lgd
                      group by album_id);
                      

-- UNION ALL
select title
from album_lgd
where no_of_tracks >= 10
union all
select title
from song_lgd
where length >= 200;