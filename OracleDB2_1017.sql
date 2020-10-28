--30번 부서 소속 사원중 커미션을 받는 사원의 수 구하기

select count(comm) from emp
where deptno = 30;

select count(distinct job) from emp;


--소속 부서별 평균 급여구하기
select deptno, avg(sal) from emp
group by deptno;

--부서별 평균 급여가 2000이상인 부서만 출력하기.
select deptno, avg(sal) from emp
group by deptno
having avg(sal) >= 2000;


select ename, dname from emp, dept
where emp.deptno = dept.deptno
and ename = 'SCOTT';

select ename, sal from emp e, dept d
where e.deptno = d.deptno
and loc = 'NEW YORK';

select ename, e.deptno from emp e, dept d
where e.deptno = d.deptno
and dname = 'ACCOUNTING';

select ename, dname from emp e, dept d
where e.deptno = d.deptno
and job = 'MANAGER';

select e2.ename, e2.job from emp e1, emp e2
where e1.ename = 'KING' and e1.empno = e2.mgr;

select e2.ename from emp e1, emp e2
where e1.ename = 'SCOTT' and e1.deptno = e2.deptno;

select * from emp
order by deptno;

select ename, dept.deptno, dept.dname 
from emp, dept
where emp.deptno(+) = dept.deptno;

select * from dept01 right outer join dept02
on dept01.deptno = dept02.deptno;

select * from dept01;
select * from dept02;


select ename, deptno from emp
where deptno =(select deptno from emp 
               where ename = 'SCOTT');
               
               
select ename, deptno from emp
where job = (select job from emp
where ename = 'SCOTT');


select ename, sal from emp
where sal >= (select sal from emp
where ename = 'SCOTT');

select ename, deptno from emp
where deptno =(select deptno from dept
where loc = 'DALLAS');

select ename, sal from emp
where deptno = (select deptno from dept
where dname = 'SALES');

select ename, sal from emp
where mgr = (select empno from emp
where ename = 'KING');

-- 평균급여보다 더 많은 급여를 받는 사원 구하기. (서브쿼리에서의 그룹함수사용)
select ename, sal from emp
where sal > (select avg(sal) from emp);

select ename, sal, deptno from emp
where deptno in (select distinct deptno from emp
where sal >= 3000);


select empno, ename, sal, deptno from emp
where sal in (select max(sal) from emp
group by deptno);

select max(sal) from emp
group by deptno;

select deptno, dname, loc from dept
where deptno in(select deptno from emp
where job = 'MANAGER');

select deptno from emp
where job = 'MANAGER';

select ename, sal from emp
where sal > all (select max(sal) from emp
where deptno = 30);

select ename, sal, job from emp
where sal > all (select max(sal) from emp
where job = 'SALESMAN');

select ename, sal from emp
where sal > any (select min(sal) from emp
where deptno = 30);


select ename, sal, job from emp
where sal > any (select min(sal) from emp
where job = 'SALESMAN')
and job <> 'SALESMAN';


--1.


--2. 
select ename, dname, sal, job from emp, dept
where emp.deptno = dept.deptno and job = (select job from emp
where ename = 'ALLEN');

--3. 
select deptno, empno, ename, hiredate, sal from emp
where deptno =(select deptno from emp
where ename = 'JONES');

--4.
select empno, ename, dname, hiredate, loc, sal from emp, dept
where emp.deptno = dept.deptno and sal > (select avg(sal) from emp);

--5.
select empno, ename, dname, hiredate, loc, emp.job from emp, dept
where emp.deptno = dept.deptno and emp.deptno = 10 and emp.job in
(select distinct job from emp where deptno = 20);

select distinct job from emp where deptno = 20;

select e.empno, e.ename, d.dname, e.hiredate, d.loc, e.job from emp e, dept d
where e.deptno = d.deptno and e.deptno = 10 and e.job in 
(select distinct job from emp
where deptno = 20);

--6.
select e.empno, e.ename, d.dname, e.hiredate, d.loc from emp e, dept d
where e.deptno = d.deptno and e.deptno = 10 and e.job not in 
(select distinct job from emp 
where deptno = 30);

--7. 
select empno, ename, sal from emp
where sal in (select sal from emp
where ename in ('MARTIN' , 'SCOTT'));

--8.
select ename, sal from emp
where sal > (select max(sal) from emp 
where deptno = 30);

--9.
select ename, sal from emp
where sal > (select min(sal) from emp where deptno = 30);

--10.
select ename, deptno from emp
where deptno = (select deptno from dept
where loc = 'DALLAS');

--11.
select deptno,sal from emp 
where sal >= 3000;