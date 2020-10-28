create table parking(
carno VARCHAR2(15) primary key,
cartype varchar2(15),
intime number(5),
outtime number(5),
charge number(8)
);


insert into parking(carno, cartype, intime, charge) 
values(?,?,?,?);

select count(*) from parking;

select * from parking order by intime;

select * from parking where carno = ?;

update parking set outtime=? where carno=?;

delete from parking where carno=?;

select * from parking where carno=?;