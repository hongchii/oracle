create table sungjuk(
hakbun varchar2(4) primary key,
irum varchar2(15),
kor number(3),
eng number(3),
math number(3),
tot number(3),
avg number(5, 2),
grade varchar2(4)
);

select * from sungjuk;


desc emp;


create table parking(
carno VARCHAR2(15) primary key,
cartype varchar2(15),
intime number(5),
outtime number(5),
charge number(8)
);

select * from parking;

