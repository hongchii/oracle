--뷰의 기본테이블 생성
create table dept_copy
as
select * from dept;

create table emp_copy
as
select * from emp;

create view emp_view30
as
select empno, ename, deptno
from emp_copy
where deptno=30;

select * from emp_view20;
desc emp_view20;

--조건을 바꿔서 emp_view30(같은이름) 으로 뷰생성. (or replace)
create or replace view emp_view30
as
select empno, ename, deptno
from emp_copy
where deptno=30;

create view emp_view20
as
select empno, ename, deptno
from emp_copy
where deptno=20;

select view_name, text
from user_views;

select * from emp_view30;

-- view를 통해 emp_copy테이블에 데이터를 추가함.
insert into emp_view30
values(1111,'AAAA', 30);

select * from emp_copy;

insert into emp_view30
values(8000, 'ANGEL', 30);

select * from emp_view30;

select * from emp_copy;
commit;

delete from emp_view30 where empno=8000;

create or replace
view emp_view(사원번호, 사원명, 급여, 부서번호)
as
select empno, ename, sal, deptno
from emp_copy;

select * from emp_view
where 부서번호 = 30;


create view view_sal
as
select deptno,sum(sal) as "SalSum", avg(sal) as "SalAvg"
from emp_copy
group by deptno;

select * from view_sal;

create view emp_view_dept
as
select e.empno, e.ename, e.sal, e.deptno, d.dname, d.loc
from emp e, dept d
where e.deptno = d.deptno
order by empno desc;

select * from emp_view_dept;

-- 각 부서별 최대급여와 최소급여를 출력하는 뷰를 sal_view란 이름으로 작성.
create view sal_view
as
select d.dname, max(e.sal) as "max_sal" , min(e.sal) as "min_sal"
from emp e, dept d
where e.deptno = d.deptno
group by d.dname;

select * from sal_view;

drop view view_sal;

select * from user_views;

create or replace view emp_view30
as
select empno, ename, sal, comm, deptno
from emp_copy
where deptno=30;

select * from emp_view30;

--별칭 주기.
create or replace view emp_view20(emp_no, emp_name, dept_no, manager)
as
select empno, ename , deptno , mgr 
from emp_copy
where deptno =20;


update emp_view30 set deptno = 20
where sal >= 1200;

create or replace view view_chk30
as
select empno, ename, sal, comm, deptno
from emp_copy
where deptno=30 with check option;

update view_chk30 set deptno=20
where sal < 1200;


create or replace view view_read30
as
select empno, ename, sal, comm, deptno
from emp_copy
where deptno = 30 with read only;

select * from view_read30;

delete from view_read30;


--인라인 뷰 rownum

select rownum, empno, ename, hiredate
from emp;

select rownum, empno, ename, hiredate
from emp
order by hiredate;


create or replace view view_hire
as
select empno, ename, hiredate
from emp
order by hiredate;

select rownum, empno, ename, hiredate from view_hire;


select rownum, empno, ename, hiredate
from view_hire
where rownum <=5;

select rownum, empno, ename, hiredate
from (select empno, ename, hiredate
from emp
order by hiredate)
where rownum <=5;

select rnum, empno, ename, hiredate
from (select rownum rnum, empno, ename, hiredate
from (select empno, ename, hiredate
from emp
order by hiredate))
where rnum >= 5 and rnum <= 10;

select rnum, empno, ename, sal
from (select rownum rnum, empno, ename, sal 
from (select empno, ename, sal from emp
order by sal desc))
where rnum <=3;

