create table emp01
as
select * from emp;

select * from emp01;

--emp01 테이블의 deptno 데이터를 전부 30으로 변경해줌. 
update emp01
set deptno = 30;

--emp01 테이블의 sal 데이터에 전부 1.1을 곱해줌.
update emp01
set sal = sal * 1.1;

--emp01 테이블의 hiredate 날짜를 오늘 날짜로 바꿔줌.
update emp01
set hiredate = sysdate;

--emp01 테이블 삭제

drop table emp01;

drop table sam01;

-- 새로 생성
create table emp01
as 
select * from emp;

-- deptno 10 -> 30 으로 변경.
update emp01
set deptno = 30
where deptno = 10;

-- sal이 3000보다 크거나 같은 데이터에 1.1배.
update emp01
set sal = sal * 1.1
where sal >= 3000;

-- substr로 문자열을 추출해서 hiredate가 87인걸 오늘날짜로 변경함. 
update emp01
set hiredate = sysdate
where substr(hiredate, 1, 2) = '87';

select * from sam01;

-- sal이 1000이상인 직원들의 급여 5000삭감하기.
update sam01
set sal = sal -5000
where sal >= 10000;

select * from emp01;

-- SCOTT의 직업 MANAGER로 변경해주기.
update emp01
set deptno = 20, job = 'MANAGER'
where ename = 'SCOTT';


update emp01
set hiredate = sysdate, sal = 50, comm = 4000
where ename = 'SCOTT';

-- loc 
update dept01
set loc = (select loc from dept01 where deptno = 10)
where deptno = 20;

-- loc null데이터 CHICAGO로 변경하기.
update dept01
set loc = (select loc from dept01 where deptno = 50)
where loc is null;

select * from dept01;

drop table sam02;

create table sam02
as
select ename, sal, hiredate, deptno from emp;

desc sam02;

select * from sam02;

-- DALLAS 에 근무하는 사람들의 급여 +1000 해주기.
update sam02
set sal = sal + 1000
where deptno = (select deptno from dept where loc = 'DALLAS');

select * from dept01;

-- deptno20의 dname과 loc를 deptno 40의 dname과 loc로 변경. 
update dept01
set (dname, loc) = (select dname, loc from dept where deptno = 40)
where deptno = 20;

select * from sam02;

-- 모든 사원의 sal과 hiredate를 KING의 sal과 hiredate로 변경. 
update sam02
set (sal, hiredate) = (select sal, hiredate from sam02 where ename = 'KING');

select * from sam01;

-- dept01 데이터 전부 삭제하기.
delete from dept01;

-- deptno가 30인 데이터만 삭제하기.
delete from dept02
where deptno = 30;

-- job이 null인 행 삭제하기.
delete from sam01
where job is null;

select * from sam02;
select * from dept;

-- emp01 테이블에서 'SALES' 부서 소속사원 삭제하기.
delete from emp01
where deptno = (select deptno from dept where dname = 'SALES');

-- sam02 테이블에서 'RESEARCH' 부서 소속사원 삭제하기.
delete from sam02
where deptno = (select deptno from dept where dname = 'RESEARCH');

drop table emp01;

create table emp01
as
select * from emp;

select * from emp02;

create table emp02
as
select * from emp
where job = 'MANAGER';

update emp02
set job = 'TEST';

insert into emp02
values(8000, 'SYJ', 'TOP', 7566,
'2009/01/12', 1200, 10, 20);

merge into emp01 using emp02 -- emp01 원래의 테이블. emp02 변동사항을 모아놓은 테이블
on(emp01.empno=emp02.empno) --기준. 이걸로 merge 하겠다. 
when matched then -- 기준조건이 일치하면 실행.
update set
emp01.ename = emp02.ename,
emp01.job = emp02.job,
emp01.mgr = emp02.mgr,
emp01.hiredate = emp02.hiredate,
emp01.sal = emp02.sal,
emp01.comm = emp02.comm,
emp01.deptno = emp02.deptno
when not matched then -- 기준조건이 불일치하면 실행.
insert values(emp02.empno, emp02.ename, emp02.job,
emp02.mgr, emp02.hiredate, emp02.sal,
emp02.comm, emp02.deptno);

commit;
select * from dept02;
delete from dept02;
commit;
rollback;

drop table dept02;

create table dept02
as
select * from dept;

select * from dept02;

delete from dept02
where deptno = 40;
-- 새로운 트랜잭션이 시작되면서 자동으로 commit이 완료된 상태.
create table dept03
as
select * from dept;
-- 여기서 rollback 
rollback;

commit;
select * from dept01;
drop table dept01;
create table dept01
as
select * from dept;

select * from dept01;

delete from dept01 where deptno = 40;

commit;

select * from dept01;

delete from dept01 where deptno = 30;

savepoint c1;

delete from dept01 where deptno = 20;

savepoint c2;

delete from dept01 where deptno = 10;

select * from dept01;

rollback to c2;
select * from dept01;
rollback to c1;
select * from dept01;
rollback;
select * from dept01;

select *
from user_cons_columns;


drop table emp01;

create table emp01
as select*from emp
where 1=0;

desc emp01;

insert into emp01
values(null,null,'SALESMAN',30);

select * from emp02;

drop table emp02;

create table emp02(
empno number(4) not null,
ename varchar2(10) not null,
job varchar2(9),
deptno number(2));

desc emp02;

insert into emp02
values(null, null, 'SALESMAN', 10);

insert into emp02
values (10, 'KBS', 'SALESMAN', '10');

select * from emp02;

drop table emp03;

--unique 데이터 중복 저장 불가.
create table emp03(
empno number(4) unique,
ename varchar2(10) not null,
job varchar2(9),
deptno number(2));

desc emp03;

insert into emp03
values (7499, 'ALLEN', 'SALESMAN', 30);

insert into emp03
values (7499, 'JONES', 'MANAGER', 20);

select * from emp03;
-- unique null값은 중복저장 가능함. 
insert into emp03
values (null, 'JONES', 'SALESMAN', 10);

insert into emp03
values (null, 'JONES', 'MANAGER', 20);


drop table emp04;

create table emp04(
empno number(4) constraint emp04_empno_uk unique,
ename varchar2(10) constraint emp04_ename_nn not null,
job varchar2(9),
deptno number(2));

desc emp04;

select * from emp04;

select constraint_name, constraint_type, table_name
from user_constraints
where table_name in ('emp04');

select * from user_cons_columns
where table_name in('emp04');

drop table emp06;
create table emp06(
empno number(4)
constraint emp06_empno_pk primary key,
ename varchar2(10)
constraint emp06_ename_nn not null,
job varchar2(9),
deptno number(2)
constraint emp06_deptno_fk references dept(deptno));


insert into emp06
values(7566, 'JONES', 'MANAGER', 50);

drop table emp07;

create table emp07(
empno number(4)
constraint emp07_empn0_pk primary key,
ename varchar2(10)
constraint emp07_ename_nn not null,
sal number(7,2)
constraint emp07_sal_ck check(sal between 500 and 5000),
gender varchar2(1)
constraint emp07_gender_ck check(gender in('M', 'F')));

insert into emp07 values(1001, 'mbc', 1000, 'M');
select * from emp07;

insert into emp07 values(1002, 'kbs', 10000, 'M');

insert into emp07 values(1002, 'kbs', 1000, 'M');


drop table dept01;

create table dept01(
deptno number(2) primary key,
dname varchar2(14),
loc varchar2(13) default'SEOUL');

insert into dept01(deptno, dname)
values(10, 'ACCOUNTING');

select * from dept01;

insert into dept01(deptno, dname, loc) values(20, 'SALES', 'DAEGU');

desc dept01;


drop table emp01;

create table emp01(
empno number(4) primary key,
ename varchar2(10) not null,
job varchar2(9) unique,
deptno number(4) references dept(deptno));


create table emp02(
empno number(4),
ename varchar2(10) not null,
job varchar2(9),
deptno number(4),
primary key(empno),
unique(job),
foreign key(deptno) references dept(deptno));


drop table emp03;

create table emp03(
empno number(4) constraint emp03_ename_nn not null,
ename varchar2(10),
job varchar2(9),
deptno number(4),
constraint emp03_empno_pk primary key(empno),
constraint emp03_job_uk unique(job),
constraint emp03_deptno_fk foreign key(deptno)
references dept(deptno)); 

create table member01(
name varchar2(10),
address varchar2(30),
hphone varchar2(16),
constraint member01_combo_pk primary key(name, hphone));