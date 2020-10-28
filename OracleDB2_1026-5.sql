create table sal01(
salno number(4) primary key,
sal number(7, 2),
empno number(4) references emp01(empno)
);

drop table emp01;
create table emp01(
empno number(4) primary key,
ename varchar2(10),
job varchar2(9)
);

create sequence sal01_salno_seq;

create or replace trigger trg_02
after insert
on emp01
for each row
begin
insert into sal01 values(sal01_salno_seq.nextval, 100, :new.empno);
end;
/

insert into emp01 values(2, '전수빈', '프로그');
insert into emp01 values(3, '홍길동', '게이머');
insert into emp01 values(4, '임꺽정', '회사원');


select * from emp01;
select * from sal01;


create or replace trigger trg_03
after delete on emp01
for each row
begin
delete from sal01 where empno=:old.empno;
end;
/

delete from emp01 where empno=4;
select * from emp01;
select * from sal01; 

select * from user_source;

drop trigger trg_02;

create table 상품(
상품코드 char(6) primary key,
상품명   varchar2(12) not null,
제조사  varchar(12),
소비자가격 number(8),
재고수량 number default 0
);

create table 입고(
입고번호 number(6) primary key,
상품코드 char(6) references 상품(상품코드),
입고일자 date default sysdate,
입고수량 number(6),
입고단가 number(8),
입고금액 number(8)
);

insert into 상품(상품코드, 상품명, 제조사, 소비자가격)
values('A00001','세탁기','LG',500);
insert into 상품(상품코드, 상품명, 제조사, 소비자가격)
values('A00002','컴퓨터','LG',700);
insert into 상품(상품코드, 상품명, 제조사, 소비자가격)
values('A00003','냉장고','삼성',600);


create or replace trigger trg_04
after insert on 입고
for each row
begin
update 상품
set 재고수량 = 재고수량 + :new.입고수량
where 상품코드 = :new.상품코드;
end;
/

insert into 입고(입고번호, 상품코드, 입고수량, 입고단가, 입고금액)
values(1, 'A00001', 5, 320, 1600);
select * from 입고;
select * from 상품;

insert into 입고(입고번호, 상품코드, 입고수량, 입고단가, 입고금액)
values(2, 'A00002', 10, 680, 6800);

create or replace trigger trg03
after update on 입고
for each row
begin
update 상품
set 재고수량 = 재고수량 + (-:old.입고수량+:new.입고수량)
where 상품코드 = :new.상품코드;
end;
/

update 입고 set 입고수량 =10, 입고금액 = 2200
where 입고번호 = 3;
select * from 입고 order by 입고번호;
select * from 상품;

create or replace trigger trg04
after delete on 입고
for each row
begin
update 상품
set 재고수량 = 재고수량 - :old.입고수량
where 상품코드 = :old.상품코드;
end;
/

delete 입고 where 입고번호 = 3;
select * from 입고 order by 입고번호;
select * from 상품;


create table member(
hakbun char(4) primary key,
name varchar2(10),
addr varchar2(10),
phone char(13)
);

select * from member;