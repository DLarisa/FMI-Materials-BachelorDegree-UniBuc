/*
    CREARE SCHEMĂ DLarisa
*/

drop table company_lgd cascade constraints;
drop table band_lgd cascade constraints;
drop table singer_lgd cascade constraints;
drop table album_lgd cascade constraints;
drop table song_lgd cascade constraints;
drop table prize_lgd cascade constraints;
drop table wins_lgd cascade constraints;

create table COMPANY_LGD (
company_id number(5),
name varchar(25) not null,
country varchar(25),
city varchar(25),
email varchar(25),
constraint company_pk primary key (company_id));

create table BAND_LGD (
band_id number(5),
name varchar(25) not null,
no_of_members number(2) not null,
launch_date date default sysdate,
company_id references company_lgd(company_id),
constraint band_pk primary key (band_id)
);

create table SINGER_LGD (
singer_id number(5),
leader_id number(5) references singer_lgd(singer_id),
first_name varchar(25) not null,
last_name varchar(25) not null,
birthday date not null,
phone_number varchar(15),
band_id number(5) references band_lgd(band_id),
constraint singer_pk primary key (singer_id)
);

create table ALBUM_LGD (
album_id number(5),
title varchar(25) not null,
genre varchar(25) not null,
price number(5, 2) not null,
no_of_tracks number(2) not null,
band_id number(5) references band_lgd(band_id) not null,
constraint album_pk primary key (album_id)
);

create table SONG_LGD (
song_id number(5),
title varchar(25) not null,
length number(4),
album_id references album_lgd(album_id) not null,
constraint song_pk primary key (song_id)
);

create table PRIZE_LGD (
prize_id number(5),
name varchar(25) not null,
year number(4),
country varchar(25) not null,
constraint prize_pk primary key (prize_id)
);

create table WINS_LGD (
prize_id number(5) references prize_lgd(prize_id),
band_id number(5) references band_lgd(band_id),
constraint wins_pk primary key (prize_id, band_id)
);

insert into company_lgd values (1, 'Big Hit Entertainment', 'Korea', 'Seoul', 'bhe@bhe.com');
insert into company_lgd values (2, 'SM Entertainment', 'Korea', 'Seoul', 'sm@sm.kor');
insert into company_lgd values (3, 'YG Entertainment', 'Korea', 'Seoul', NULL);
insert into company_lgd values (4, 'JYP Entertainment', 'Korea', 'Seoul', 'jyp@domain.kor');
insert into company_lgd values (5, 'Columbia Records', 'United States of America', 'New York', 'sonyrecords@usa.com');
insert into company_lgd values (6, 'Warner Music Group', 'United Kingdom', 'London', NULL);
insert into company_lgd values (7, 'MusicForYou Corporation', 'Italy', 'Rome', '');
insert into company_lgd values (8, 'HEYMusic!', 'Korea', 'Seoul', NULL);

insert into band_lgd values (10, 'BTS', 7, to_date('12-05-2013', 'dd-mm-yyyy'), 1);
insert into band_lgd values (11, 'Tomorrow X Together', 5, to_date('04-03-2019', 'dd-mm-yyyy'), 1);
insert into band_lgd values (12, '2AM', 4, to_date('21-06-2008', 'dd-mm-yyyy'), 1);
insert into band_lgd values (13, 'Glam', 5, to_date('16-06-2012', 'dd-mm-yyyy'), 1);
insert into band_lgd values (20, 'EXO', 9, to_date('03-05-2013', 'dd-mm-yyyy'), 2);
insert into band_lgd values (21, 'Super Junior', 10, to_date('16-04-2006', 'dd-mm-yyyy'), 2);
insert into band_lgd values (22, 'Red Velvet', 5, to_date('01-08-2014', 'dd-mm-yyyy'), 2);
insert into band_lgd values (30, 'BlackPink', 4, to_date('14-08-2016', 'dd-mm-yyyy'), 3);
insert into band_lgd values (31, 'BigBang', 5, to_date('22-06-2006', 'dd-mm-yyyy'), 3);
insert into band_lgd values (40, 'Twice', 9, to_date('10-10-2015', 'dd-mm-yyyy'), 4);
insert into band_lgd values (41, 'Stray Kids', 8, to_date('03-09-2018', 'dd-mm-yyyy'), 4);
insert into band_lgd values (42, 'Got7', 7, to_date('10-04-2013', 'dd-mm-yyyy'), 4);
insert into band_lgd values (50, 'AC/DC', 4, to_date('01-11-1973', 'dd-mm-yyyy'), 5);
insert into band_lgd values (51, 'Bring me the Horizon', 5, to_date('11-02-2006', 'dd-mm-yyyy'), 5);
insert into band_lgd values (52, 'Destiny Child', 3, to_date('05-05-1997', 'dd-mm-yyyy'), 5);
insert into band_lgd values (60, 'ABBA', 4, to_date('01-05-1972', 'dd-mm-yyyy'), 6);
insert into band_lgd values (61, 'Arctic Monkeys', 4, to_date('21-06-2002', 'dd-mm-yyyy'), 6);
insert into band_lgd values (70, 'Monsta X', 6, to_date('17-03-2014', 'dd-mm-yyyy'), NULL);
insert into band_lgd values (80, 'Maroon 5', 7, to_date('21-06-2001', 'dd-mm-yyyy'), NULL);

insert into singer_lgd values (100, NULL, 'Nam-joon', 'Kim', to_date('12-09-1994', 'dd-mm-yyyy'), NULL, 10);
insert into singer_lgd values (101, 100, 'Ji-min', 'Park', to_date('13-10-1995', 'dd-mm-yyyy'), NULL, 10);
insert into singer_lgd values (102, 100, 'Yoon-gi', 'Min', to_date('09-03-1993', 'dd-mm-yyyy'), NULL, 10);
insert into singer_lgd values (103, 106, 'Baek-hyun', 'Byun', to_date('06-05-1992', 'dd-mm-yyyy'), '0123456789', 20);
insert into singer_lgd values (104, 106, 'Chan-yeol', 'Park', to_date('27-11-1992', 'dd-mm-yyyy'), '988745233', 20);
insert into singer_lgd values (105, 106, 'Min-seok', 'Kim', to_date('26-03-1990', 'dd-mm-yyyy'), NULL, 20);
insert into singer_lgd values (106, NULL, 'Jun-myon', 'Kim', to_date('22-05-1991', 'dd-mm-yyyy'), NULL, 20);
insert into singer_lgd values (107, 110, 'Ji-soo', 'Kim', to_date('03-01-1995', 'dd-mm-yyyy'), '0787453216', 30);
insert into singer_lgd values (108, 110, 'Jennie', 'Kim', to_date('16-01-1996', 'dd-mm-yyyy'), NULL, 30);
insert into singer_lgd values (109, 110, 'Lisa', 'Manoban', to_date('27-03-1997', 'dd-mm-yyyy'), '1245852555', 30);
insert into singer_lgd values (110, NULL, 'Roseanne', 'Park', to_date('11-02-1997', 'dd-mm-yyyy'), NULL, 30);
insert into singer_lgd values (111, NULL, 'Beyonce', 'Knowles', to_date('04-07-1981', 'dd-mm-yyyy'), NULL, 52);
insert into singer_lgd values (112, 111, 'Kelly', 'Rowland', to_date('11-02-1981', 'dd-mm-yyyy'), '7555481232', 52);
insert into singer_lgd values (113, NULL, 'Adam', 'Levine', to_date('18-03-1979', 'dd-mm-yyyy'), NULL, 80);
insert into singer_lgd values (114, 113, 'Sam', 'Farar', to_date('29-06-1979', 'dd-mm-yyyy'), NULL, 80);
insert into singer_lgd values (115, NULL, 'Alex', 'Turner', to_date('06-01-1986', 'dd-mm-yyyy'), '7441234580', 61);
insert into singer_lgd values (116, 115, 'Jamie', 'Cook', to_date('08-07-1985', 'dd-mm-yyyy'), NULL, 61);
insert into singer_lgd values (117, NULL, 'Angus', 'Young', to_date('31-05-1955', 'dd-mm-yyyy'), '7845124545', 50);
insert into singer_lgd values (118, 117, 'Chris', 'Slade', to_date('06-01-1950', 'dd-mm-yyyy'), NULL, 50);
insert into singer_lgd values (119, NULL, 'Soo-bin', 'Choi', to_date('05-12-2000', 'dd-mm-yyyy'), NULL, 11);
insert into singer_lgd values (120, 119, 'Yeon-jun', 'Choi', to_date('13-07-1999', 'dd-mm-yyyy'), NULL, 11);
insert into singer_lgd values (121, 119, 'Huening', 'Kai', to_date('14-08-2002', 'dd-mm-yyyy'), NULL, 11);
insert into singer_lgd values (122, NULL, 'Joo-hyum', 'Bae', to_date('29-03-1991', 'dd-mm-yyyy'), NULL, 22);
insert into singer_lgd values (123, 122, 'Soo-young', 'Park', to_date('03-07-1996', 'dd-mm-yyyy'), NULL, 22);
insert into singer_lgd values (124, 106, 'Lay', 'Zhang', to_date('07-10-1991', 'dd-mm-yyyy'), '7845556322', 20);
insert into singer_lgd values (125, NULL, 'Adele', 'Adkins', to_date('05-05-1988', 'dd-mm-yyyy'), NULL, NULL);
insert into singer_lgd values (126, NULL, 'Ariana', 'Grande', to_date('05-05-1988', 'dd-mm-yyyy'), '25554882232', NULL);
insert into singer_lgd values (127, NULL, 'Michael', 'Jackson', to_date('05-05-1988', 'dd-mm-yyyy'), '8477125562', NULL);

insert into album_lgd values (100, 'Wings', 'Dance-pop', 100.50, 15, 10);
insert into album_lgd values (101, 'Love Yourself', 'Pop', 120, 11, 10);
insert into album_lgd values (102, 'Map of the Soul', 'EDM', 103.25, 16, 10);
insert into album_lgd values (103, 'The Dream Chapter: MAGIC', 'Tropical-house', 95.30, 8, 11);
insert into album_lgd values (104, 'The War', 'RB', 99.99, 10, 20);
insert into album_lgd values (105, 'Dont mess up my Tempo', 'Dance', 95, 11, 20);
insert into album_lgd values (106, 'Red Pill Blues', 'Pop', 102, 10, 80);
insert into album_lgd values (107, 'Hands all Over', 'Pop', 80.50, 12, 80);
insert into album_lgd values (108, 'Highway to Hell', 'Rock', 70, 5, 50);
insert into album_lgd values (109, 'Back in Black', 'Rock', 85, 5, 50);
insert into album_lgd values (110, 'Fly on the Wall', 'Rock', 53.25, 5, 50);
insert into album_lgd values (111, 'Survivor', 'Pop', 92, 15, 52);
insert into album_lgd values (112, 'Perfect Velvet', 'Synth-pop', 65.50, 12, 22);
insert into album_lgd values (113, '#Cookie Jar', 'Synth-pop', 78.60, 10, 22);
insert into album_lgd values (114, 'Fancy You', 'K-pop', 60, 6, 40);
insert into album_lgd values (115, 'Time Slip', 'RB', 86.30, 10, 21);

insert into song_lgd values (500, 'Intro: Boy Meets Evil', 200, 100);
insert into song_lgd values (501, 'Lie', NULL, 100);
insert into song_lgd values (502, 'Blood, Sweat and Tears', NULL, 100);
insert into song_lgd values (503, 'MAMA', 250, 100);
insert into song_lgd values (504, 'Interlude: Wings', 180, 100);
insert into song_lgd values (505, 'Fake Love', 300, 101);
insert into song_lgd values (506, 'Airplane pt. 2', 320, 101);
insert into song_lgd values (507, 'Magic Shop', NULL, 101);
insert into song_lgd values (508, 'Anpanman', 150, 101);
insert into song_lgd values (509, '9 and Three Quarters (Run Away)', 311, 103);
insert into song_lgd values (510, 'Angel or Demon', 170, 103);
insert into song_lgd values (511, 'Boy with Love', 210, 102);
insert into song_lgd values (512, 'ON', 250, 102);
insert into song_lgd values (513, 'Black Swan', NULL, 102);
insert into song_lgd values (514, 'Filter', NULL, 102);
insert into song_lgd values (515, 'Make it Right', 230, 102);
insert into song_lgd values (516, 'The Eve', NULL, 104);
insert into song_lgd values (517, 'Ko Ko Bop', 280, 104);
insert into song_lgd values (518, 'Touch it', 300, 104);
insert into song_lgd values (519, 'Power', NULL, 104);
insert into song_lgd values (520, 'Tempo', 185, 105);
insert into song_lgd values (521, 'Love Shot', NULL, 105);
insert into song_lgd values (522, '2YA2YAO!', 213, 115);
insert into song_lgd values (523, 'Fancy', 220, 114);
insert into song_lgd values (524, 'Hot', NULL, 114);
insert into song_lgd values (525, '#Cookie Jar', NULL, 113);
insert into song_lgd values (526, 'Red Flavor', NULL, 113);
insert into song_lgd values (527, 'Russian Roulette', 211, 113);
insert into song_lgd values (528, 'Survivor', 197, 111);
insert into song_lgd values (529, 'Bootylicious', 198, 111);
insert into song_lgd values (530, 'Highway to Hell', NULL, 108);
insert into song_lgd values (531, 'Touch too Much', 174, 108);
insert into song_lgd values (532, 'Misery', NULL, 106);
insert into song_lgd values (533, 'Girls like You', NULL, 106);
insert into song_lgd values (534, 'Moves like Jagger', NULL, 106);

insert into prize_lgd values (50, 'Golden Globes', 2015, 'USA');
insert into prize_lgd values (51, 'Golden Globes', 2016, 'USA');
insert into prize_lgd values (52, 'Golden Globes', 2017, 'USA');
insert into prize_lgd values (53, 'Golden Globes', 2018, 'USA');
insert into prize_lgd values (54, 'Golden Globes', 2019, 'USA');
insert into prize_lgd values (55, 'Emmy', 2015, 'USA');
insert into prize_lgd values (56, 'Emmy', 2016, 'USA');
insert into prize_lgd values (57, 'Emmy', 2017, 'USA');
insert into prize_lgd values (58, 'Emmy', 2018, 'USA');
insert into prize_lgd values (59, 'Emmy', 2019, 'USA');
insert into prize_lgd values (60, 'Golden Disc', 2014, 'Korea');
insert into prize_lgd values (61, 'Golden Disc', 2015, 'Korea');
insert into prize_lgd values (62, 'Golden Disc', 2016, 'Korea');
insert into prize_lgd values (63, 'Golden Disc', 2017, 'Korea');
insert into prize_lgd values (64, 'Golden Disc', 2018, 'Korea');
insert into prize_lgd values (65, 'Golden Disc', 2019, 'Korea');
insert into prize_lgd values (66, 'MNET Asian Music Award', 2013, 'China');
insert into prize_lgd values (67, 'MNET Asian Music Award', 2014, 'China');
insert into prize_lgd values (68, 'MNET Asian Music Award', 2015, 'China');
insert into prize_lgd values (69, 'MNET Asian Music Award', 2016, 'China');
insert into prize_lgd values (70, 'MNET Asian Music Award', 2017, 'China');
insert into prize_lgd values (71, 'MNET Asian Music Award', 2018, 'China');
insert into prize_lgd values (72, 'MNET Asian Music Award', 2019, 'China');
insert into prize_lgd values (73, 'Billboard Music Award', 2015, 'UK');
insert into prize_lgd values (74, 'Billboard Music Award', 2016, 'UK');
insert into prize_lgd values (75, 'Billboard Music Award', 2017, 'UK');
insert into prize_lgd values (76, 'Billboard Music Award', 2018, 'UK');
insert into prize_lgd values (77, 'Billboard Music Award', 2019, 'UK');

insert into wins_lgd values (50, 10);
insert into wins_lgd values (51, 10);
insert into wins_lgd values (52, 10);
insert into wins_lgd values (53, 10);
insert into wins_lgd values (54, 10);
insert into wins_lgd values (55, 10);
insert into wins_lgd values (56, 10);
insert into wins_lgd values (57, 10);
insert into wins_lgd values (58, 10);
insert into wins_lgd values (59, 10);
insert into wins_lgd values (60, 10);
insert into wins_lgd values (61, 10);
insert into wins_lgd values (62, 10);
insert into wins_lgd values (63, 10);
insert into wins_lgd values (64, 10);
insert into wins_lgd values (65, 10);
insert into wins_lgd values (66, 10);
insert into wins_lgd values (67, 10);
insert into wins_lgd values (68, 10);
insert into wins_lgd values (69, 10);
insert into wins_lgd values (70, 10);
insert into wins_lgd values (71, 10);
insert into wins_lgd values (72, 10);
insert into wins_lgd values (73, 10);
insert into wins_lgd values (74, 10);
insert into wins_lgd values (75, 10);
insert into wins_lgd values (76, 10);
insert into wins_lgd values (77, 10);
insert into wins_lgd values (50, 20);
insert into wins_lgd values (51, 20);
insert into wins_lgd values (52, 20);
insert into wins_lgd values (53, 20);
insert into wins_lgd values (54, 20);
insert into wins_lgd values (55, 20);
insert into wins_lgd values (56, 20);
insert into wins_lgd values (57, 20);
insert into wins_lgd values (58, 20);
insert into wins_lgd values (59, 20);
insert into wins_lgd values (60, 20);
insert into wins_lgd values (61, 20);
insert into wins_lgd values (62, 20);
insert into wins_lgd values (63, 20);
insert into wins_lgd values (64, 20);
insert into wins_lgd values (65, 20);
insert into wins_lgd values (66, 20);
insert into wins_lgd values (67, 20);
insert into wins_lgd values (68, 20);
insert into wins_lgd values (69, 20);
insert into wins_lgd values (70, 20);
insert into wins_lgd values (71, 20);
insert into wins_lgd values (72, 20);
insert into wins_lgd values (73, 20);
insert into wins_lgd values (74, 20);
insert into wins_lgd values (75, 20);
insert into wins_lgd values (76, 20);
insert into wins_lgd values (77, 20);
insert into wins_lgd values (53, 21);
insert into wins_lgd values (54, 21);
insert into wins_lgd values (54, 30);
insert into wins_lgd values (54, 40);
insert into wins_lgd values (54, 50);
insert into wins_lgd values (54, 60);
insert into wins_lgd values (62, 52);
insert into wins_lgd values (62, 13);
insert into wins_lgd values (62, 12);
insert into wins_lgd values (62, 80);
insert into wins_lgd values (63, 80);
insert into wins_lgd values (64, 80);
insert into wins_lgd values (65, 80);
insert into wins_lgd values (70, 80);
insert into wins_lgd values (77, 41);
insert into wins_lgd values (77, 31);
insert into wins_lgd values (77, 50);
insert into wins_lgd values (77, 70);
insert into wins_lgd values (61, 40);
insert into wins_lgd values (73, 40);
insert into wins_lgd values (62, 40);
insert into wins_lgd values (64, 40);
insert into wins_lgd values (64, 30);

rollback;
commit;