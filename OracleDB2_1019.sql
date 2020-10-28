select rowid, empno, ename from emp;

create table sam02(
year01 interval year(3) to month);

insert into sam02 values (interval '36' month(3));

select * from sam02;

select year01, sysdate, sysdate+year01 from sam02;

create table sam03(day01 interval day(3) to second);

insert into sam03 values(interval '100' day(3));

select * from sam03;

select day01, sysdate, sysdate+day01 from sam03;

create table emp01(
empno number(4),
ename varchar2(20),
sal number(7, 2));

desc emp01;


create table dept01(
deptno number(2),
dname varchar2(14),
loc varchar2(13));

desc dept01;

select * from dept01;

create table emp02 as select * from emp;

desc emp02;
desc emp;

create table emp03 as select empno, ename from emp;

desc emp03;
select * from emp03;

create table emp04 as select empno, ename, sal from emp;
desc emp04;
select * from emp04;

create table emp05 as select * from emp
where deptno = 10;

desc emp05;
select * from emp05;

create table emp06 as select * from emp where 1=0;

select * from emp06;

create table dept02 as select * from dept where 1=0;

desc dept02;
select * from dept02;

create table emp07 (a,b) as select empno, ename from emp;
desc emp07;

select * from emp07;

desc emp01;

alter table emp02 add(job2 varchar2(9));

desc emp02;

select * from emp02;

alter table dept02 add(dmgr NUMBER(4));

desc dept02;

alter table emp01 modify(job varchar2(3));


alter table dept02 modify(dmgr number(4));

alter table emp01 drop column job;

desc emp01;

alter table dept02 drop column dmgr;

desc dept02;

alter table emp02 set unused(job2);

desc emp02;

alter table emp02 drop unused columns;

drop table emp01;

select * from emp02;
truncate table emp02;
select * from emp03;

rename emp02 to test;

desc user_tables;
show user;

select * from user_tables
where table_name = 'TEST';

desc all_tables;
select * from all_tables;


select table_name, owner from dba_tables;

--테이블 생성하기

create table dept01(
deptno number(2),
dname varchar2(14),
loc varchar2(13));

select * from dept01;

--테이블 내용 생성하기 
insert into dept01
(deptno, dname, loc)
values(10, 'ACCOUNTING', 'NEW YORK');

--테이블에 속한 칼럼에 데이터를 전부 넣으려면 칼럼명을 삭제해도됨. 단, 칼럼 생성시 순서를 지켜야함. 확인은 desc 테이블명;
insert into dept01
values (20, 'RESEARCH', 'DALLAS');

select * from dept01;

--null값이 저장되지 못한다는 제약조건이 없기 때문에 null 값이 저장됨.

insert into dept01(deptno, dname)
values (90, 'RESEARCH');


create table sam01(
empno number(4),
ename varchar2(10),
job varchar2(9),
sal number(7,2));

insert into sam01
values (1020, 'ORANGE', 'DOCTOR', '25000');

select * from sam01;

desc dept;

insert into dept01(deptno, dname)
values (30,'SALES');

select * from dept01;

insert into dept01
values (40,'OPERATIONS', null);

insert into dept01
values (50, '', 'CHICAGO');

select * from sam01;

insert into sam01
values (1030, 'VERY', '', 25000);

insert into sam01
values (1040, 'CAT', '', 2000);

drop table dept02;

create table dept02
as
select * from dept where 1=0;

select * from dept02;

desc dept02;

--dept 테이블 정보 dept02에 추가하기. 입력 안된건 null 값으로 됨 
insert into dept02(deptno, dname)
select deptno, dname from dept
where deptno = 10;

select * from sam01;
desc dept02;

-- emp 테이블의 10번부서 정보 sam01 테이블에 추가하는 법. 
insert into sam01 (empno, ename,job, sal)
select empno, ename,job, sal from emp
where deptno = 10;


create table emp_hir
as
select empno, ename, hiredate from emp
where 1=0;

desc emp_hir;

create table emp_mgr
as
select empno, ename, mgr from emp 
where 1=0;

desc emp_mgr;

-- emp 테이블의 empno, ename, hiredate, mgr 정보를 각각 emp_hir과 emp_mgr에 추가해줌. 
insert all
into emp_hir values(empno, ename, hiredate)
into emp_mgr values(empno, ename, mgr)
select empno, ename, hiredate, mgr
from emp
where deptno = 20;

select * from emp_hir;
select * from emp_mgr;

create table emp_hir02
as
select empno, ename, hiredate from emp
where 1=0;

create table emp_sal
as
select empno, ename, sal from emp
where 1=0;

insert all
when hiredate > '1982/01/01' then
into emp_hir02 values(empno, ename, hiredate)
when sal > 2000 then
into emp_sal values(empno, ename, sal)
select empno, ename, hiredate, sal from emp;

select * from emp_hir02;
select * from emp_sal;

create table sales_data(
sales_id number(4),
week_id number(4),
daily_is number(4),
sales number(8, 2));

insert into sales values
(1001, 1, 200, 100, 300, 400, 500);
insert into sales values
(1002, 2, 100, 300, 200, 500, 350);

insert all
into sales_data values(sales_id, week_id, 1, mon_sales)
into sales_data values(sales_id, week_id, 2, tue_sales)
into sales_data values(sales_id, week_id, 3, wed_sales)
into sales_data values(sales_id, week_id, 4, thu_sales)
into sales_data values(sales_id, week_id, 5, fri_sales)
select sales_id, week_id, mon_sales, tue_sales, wed_sales,
thu_sales, fri_sales from sales;

select * from sales_data;
select * from sales_data order by sales_id;