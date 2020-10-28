select empno, ename, emp.deptno, dname from emp, dept
where emp.deptno = dept.deptno;
-- deptno는 emp와 dept 테이블에 동시에 존재하는 칼럼이기때문에 deptno 앞에는 조회하려는 테이블명을 붙여줘야한다.


select ename, dname from emp, dept
where emp.deptno=dept.deptno and ename='SCOTT';


select e.ename, d.dname, e.deptno, e.deptno from emp e, dept d
where e.deptno = d.deptno and e.ename = 'SCOTT';
--from 뒤에 테이블명을 적고 그 뒤에 별칭을 붙여줘서 간단하게 조회할수 있다. 


--뉴욕에 근무하는 사원의 이름과 급여 출력하기.
select e.ename, e.sal from emp e, dept d
where e.deptno = d.deptno and d.loc = 'NEW YORK';


--ACCOUNTING 부서 사원의 이름과 입사일 출력하기.
select e.ename, e.hiredate from emp e, dept d
where e.deptno = d.deptno and d.dname = 'ACCOUNTING';


--직급이 MANAGER인 사원의 이름과 부서명 출력하기.
select e.ename, d.dname from emp e, dept d
where e.deptno = d.deptno and e.job = 'MANAGER'; 


select enmae, sal, grade from emp, salgrade
where sal between losal and hisal;

-- 한개의 테이블 내부에서 조인하기 (self join) 테이블 한개에 별칭을 2개 준다.
-- SMITH의 상사(mgr) 구하기.
select e2.ename from emp e1, emp e2
where e1.ename = 'SMITH' and e1.mgr = e2.empno;

--매니저가 KING 인 사원들 이름과 직급 출력.
select e2.ename, e2.job from emp e1, emp e2
where e1.ename = 'KING' and e1.empno = e2.mgr;
--self join을 사용할시엔 기준을 잘 잡아줘야한다.

--SCOTT과 동일한 근무지에서 근무하는 사원의 이름 출력하기.
select e2.ename from emp e1, emp e2
where e1.ename = 'SCOTT' and e1.deptno = e2.deptno and e2.ename <> 'SCOTT';


--조건에 만족하지 못하더라도 해당 로우를 나타내고 싶을때 사용하는 외부 조인(outer join).
--외부조인은 null값이라 배제된 행을 결과에 포함시킬수 있음.
--정보가 부족한 칼럼 이름 뒤에 (+) 기호를 붙여줌.
select employee.ename || '의 매니저는' || manager.ename || '입니다.' from emp employee, emp manager
where employee.mgr = manager.empno(+);

--emp에 없는 deptno 40 출력하기. 
select e.ename, d.deptno, d.dname from emp e, dept d
where d.deptno = e.deptno(+);
--40이 없는 emp deptno 뒤에 (+) 연산자를 붙여주면 됨.


select * from emp cross join dept;
select * from emp, dept;


-- ansi inner join - from 다음에 inner join을 사용하여 조인할 테이블 이름을 명시하고,
-- on 절을 사용하여 조인 조건을 명시함
select ename, dname from emp inner join dept
on emp.deptno = dept.deptno
--on절 뒤에 나오는 같다(=)는 equi join에 해당하는 개념.
where ename = 'SCOTT';


select emp.ename, dept.dname from emp inner join dept
using (deptno)
--공통된 칼럼 using을 통해 사용하기.
where ename = 'SCOTT';


--natural join을 사용하면 공통된 칼럼을 기준으로 equi join이 됨.
select emp.ename, dept.dname from emp natural join dept;


-- 새로운 테이블 만들기 

create table dept02(
 deptno number(2),
 dname varchar2(14)
 );
 
 
 insert into dept02 values(10, 'ACCOUNTING');
 
 insert into dept02 values(30, 'SALES');
 
 
 select * from dept02;
 
 
 select * from dept01 full outer join dept02 
 on dept01.deptno = dept02.deptno;
 
 select * from dept01, dept02
 where dept01.deptno(+) = dept02.deptno;
 
 
 
 --1. emp와 dept테이블을 조인하여 부서 번호, 이름, 급여를 출력하시오.
 select e.deptno, ename, sal from emp e ,dept d;
 
 select d.deptno, d.dname, e.ename, e.sal from emp e, dept d
 where e.deptno = d.deptno;
 
 select deptno, dept.dname, emp.ename, emp.sal from emp inner join dept using (deptno);
 --using을 사용하게 되면 공통된 칼럼 앞에 규정자를 사용하지 않음.
 
 select deptno, dname, ename, sal from emp natural join dept;
 
 --2. 이름이 'ALLEN'인 사원의 부서명을 출력하시오.
 select dname from emp e, dept d
 where e.deptno = d.deptno and ename = 'ALLEN';
 
 select dname from emp e inner join dept d on e.deptno = d.deptno and e.ename = 'ALLEN';
 --select * from emp, dept
 --order by emp.deptno desc;
 
 --3. emp 테이블의 데이터를 출력하되 해당사원에 대한 상관번호와 상관의 성명을 함께 출력하시오.
 select e1.ename, e1.mgr, e2.ename from emp e1, emp e2
 where e1.mgr = e2.empno;
 
 select A.ename, A.mgr, B.ename mgr_name from emp A, emp B
 where A.mgr = B.empno;

 select A.ename, A.mgr, B.ename mgr_name from emp A inner join emp B on A.mgr = B.empno;
 
 
 --4. 10번 부서에 근무하는 사원의 사원번호, 이름, 부서명, 지역, 급여를 급여가 많은 순으로 출력하시오.
 select empno, enamem, d.dname, loc, sal from emp e, dept d
 where d.deptno = e.deptno;
 
 
 select e.empno, e.ename, d.dname, d.loc, e.sal from emp e, dept d
 where e.deptno = d.deptno and e.deptno = 10
 order by e.sal desc;
 
  select e.empno, e.ename, d.dname, d.loc, e.sal from emp e, dept d
 where e.deptno = d.deptno and e.deptno = 10
 order by e.sal desc;
 
 
 --5. 사원번호, 부서번호, 부서명을 출력하세요. 단, 사원이 근무하지 않는 부서명도 같이 출력하시오.
 select empno, e.deptno, ename from emp e, dept d
 where e.deptno(+)=d.deptno;
 
 select e.empno, d.deptno, d.dname from emp e right outer join dept d on e.deptno = d.deptno;
 
 select dname from dept
 where deptno = ( select deptno from emp where ename ='SCOTT');
 
 
 
 
 
 --1. 'SCOTT'과 같은 부서에서 근무하는 사원의 이름과 부서 번호를 출력하기.
 select ename, deptno from emp
 where deptno = (select deptno from emp where ename = 'SCOTT')
 -- 등호가 붙은 서브쿼리는 단일행 서브쿼리만 사용가능함.
 and ename <> 'SCOTT';
 
 --2. 'SCOTT'과 동일한 직급을 가진 사원 출력하기.
 select * from emp
 where job = (select job from emp where ename = 'SCOTT')
 and ename <> 'SCOTT';
 
 --3. 'SCOTT'의 급여와 동일하거나 더 많이 받는 사원 이름과 급여 출력하기.
 select ename, sal from emp
 where sal >= (select sal from emp where ename = 'SCOTT')
 and ename <> 'SCOTT';
 
 --4. 'DALLAS'에서 근무하는 사원의 이름 , 부서번호 출력하기.
 select ename, deptno from emp
 where deptno = (select deptno from dept where loc = 'DALLAS');
 --emp와 dept는 deptno이라는 동일한 칼럼이 있어서 그걸로 연결함.
 
 --5. 'SALES' 부서에서 근무하는 모든 사원의 이름과 급여 출력하기.
  select ename, sal from emp
 where deptno = (select deptno from dept where dname = 'SALES'); 
 
 --6. 직속상관이 'KING'인 사원의 이름과 급여 출력하기.
 select ename, sal from emp
 where mgr = (select empno from emp where ename = 'KING');
 
 
 
 select ename, sal from emp
 where sal > (select avg(sal) from emp);
 
 select ename, sal, deptno from emp
 where deptno in (select distinct deptno from emp where sal >= 3000);
 
 
 
 --7. 부서별로 가장 급여를 많이 받는 사원의 정보(사원 번호, 사원 이름, 급여, 부서번호)를 출력(in 연산자 사용)
 select empno, ename, sal, deptno from emp
 where sal in (select max(sal) from emp group by deptno);
 
 
 --8. 직급이 MANAGER인 사람의 속한 부서의 부서번호와 부서명과 지역을 출력하기.
 select deptno, dname, loc from dept
 where deptno in (select deptno from emp where job = 'MANAGER');
 
 
 select ename, sal, deptno from emp
 where sal > all(select sal from emp where deptno = 30);
 
 select * from dept;
 
 --9. 영업사원들보다 급여를 많이 받는 사원들의 이름과 급여와 직급(담당 업무)를 출력하되 영업사원은 출력하지 않기.
 select ename, sal, job from emp 
 where sal > all(select sal from emp where job = 'SALESMAN')
 and job <> 'SALESMAN';
 --and절 빼도 결과 같음. 
 
 
  select ename, sal from emp
 where sal > any (select sal from emp where deptno = 30); 
 
 --10. 영업 사원들의 최소 급여보다 많이 받는 사원들의 이름과 급여와 직급(담당업무)를 출력하되 영업 사원은 출 력하지 않음.
 select ename, sal, job from emp
 where sal > any (select sal from emp where job = 'SALESMAN')
 and job <> 'SALESMAN';
 
 select sal from emp where job = 'SALESMAN';
 
 
 
 
 --1.
select * from dept
where deptno not in ( select distinct deptno from emp);


select * from dept
where deptno not in (select deptno from emp group by deptno having count(*) > 0);

--2.
select e.ename, d.dname, e.sal, e.job from emp e, dept d
where e.deptno = d.deptno and e.job = (select job from emp where ename = 'ALLEN');

--3.
select empno, ename, hiredate, sal from emp
where deptno = (select deptno from emp where ename = 'JONES');

--4.
select e.empno, e.ename, d.dname, e.hiredate, d.loc, e.sal from emp e join dept d
on e.deptno = d.deptno and e.sal > (select avg(sal) from emp);

--5.
select e.empno, e.ename, d.dname, e.hiredate, d.loc, e.job from emp e, dept d
where e.deptno = d.deptno and e.deptno = 10 and e.job in (select distinct job from emp
where deptno = 20);

--6.
select e.empno, e.ename, d.dname, e.hiredate, d.loc, e.job from emp e, dept d
where e.deptno = d.deptno and e.deptno = 10 and e.job not in (select distinct job from emp
where deptno = 30);

--7.
select empno, ename, sal from emp
where sal in (select sal from emp where ename in ('MARTIN', 'SCOTT'));
--and ename <> 'MARTIN' and ename <> 'SCOTT';

--8.
select ename, sal from emp
where sal > all(select sal from emp where deptno = 30);

select ename, sal from emp
where sal > (select max(sal) from emp where deptno = 30);

--9.
select ename, sal from emp
where sal > any(select sal from emp where deptno = 30);

select ename, sal from emp
where sal > (select min(sal) from emp where deptno = 30);


--10.
select ename, deptno from emp
where deptno = (select deptno from dept where loc = 'DALLAS');


--11.
select ename, sal deptno from emp
where deptno in (select deptno from emp where sal >= 3000);

--12.
select empno, sal, deptno from emp
where sal in (select max(sal) from emp group by deptno);