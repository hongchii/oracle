select mod (27, 2), mod (27,5), mod (27,7) from dual;

select floor(34.5678), trunc(34.5678, -1) from dual;

select 34.5678, floor(34.5678) from dual;

select 34.5678, round(34.5678) from dual;

select * from emp
where mod (empno,2)<>0; 

select 'welcome to Oracle', upper('welcome to oracle') from dual;
select 'welcome to oracle', lower('welcome to oracle') from dual;
select 'welcome to oracle', initcap('welcome to oracle') from dual;

select empno, ename, job from emp
where job = upper('manager');
-- where lower(job) = 'manager';

select length('Oracle'), length('오라클') from dual;

select lengthb('Oracle'), lengthb('오라클') from dual;

select substr('Welcome to Oracle', 4, 3) from dual;
--             123456789           4부터 3글자.
select substr('Welcome to Oracle', -4, 3) from dual;
--             123456789    -3-2-1    뒤에서 4부터 3글자.

select substr(hiredate, 1, 2) 년도, substr(hiredate, 4, 2) 달, substr(hiredate, 7, 2) 일 from emp;

select * from emp
where substr(hiredate, 4,2) = '09';

select * from emp
where substr(hiredate, 1,2) = '87';

select * from emp
where substr(ename, -1, 1) = 'E';

select substr('웰컴투오라클', 3,4), substrb('웰컴투오라클',3,4) from dual;

select instr('welcome to oracle', 'o', 6, 2) from dual;

select instr('데이터베이스', '이', 3,1), instrb('데이터베이스', '이', 3, 1) from dual;

select lpad('oracle', 20, '#') from dual;
select rpad('oracle', 20, '#') from dual;

select ltrim('      oracle') from dual;
select rtrim('    oracle        ') from dual;
select trim('              orcle        1       ') from dual;
select trim('a' from 'aaddaaaoracleaa') from dual;

select sysdate from dual;

select sysdate-1 어제, sysdate 오늘, sysdate+1 내일 from dual; 

select sysdate-hiredate 근무일수 from emp;

select hiredate, trunc(hiredate, 'MONTH') from emp;

select hiredate, round(hiredate, 'month') from emp;

select ename, sysdate, hiredate, trunc(months_between (sysdate, hiredate)) 근무개월수 from emp;

select ename, hiredate, add_months(hiredate, 6) 반년후 from emp;

select sysdate, next_day(sysdate,'일요일') from dual;

select hiredate, last_day(hiredate) from emp;

select sysdate, to_char(sysdate, 'YYYY-MM-DD') from dual;

select sysdate, to_char(hiredate, 'MM-DD DY') from emp;

select to_char(sysdate, 'YYYY/MM/DD, AM HH24:MI:SS') from dual;

select to_char(1230000), 1230000 숫자다다다다 from dual;

--select ename, sal, to_char (sal,'L000,000)') from emp;

select to_char(123456, '000000'), to_char (12345678, '999,999,999') from dual;

select ename, hiredate from emp
where hiredate = to_date(19810220,'YY/MM/DD');

select trunc(sysdate - to_date('2008/01/01', 'YYYY/MM/DD')) from dual;

select to_number('90,000', '99,999') - to_number('10,000', '99,999') from dual;

select empno, ename, 'CEO' as MANAGER from emp
where mgr is null;

select empno, ename, nvl(to_char(mgr),'ceo') from emp
where mgr is null;

select ename, deptno, decode(deptno, 10, 'ACCOUNTING', 
20, 'RESEARCH', 30, 'SALES', 40, 'OPERATIONS') AS DNAME from emp;

select empno, ename, job, sal, decode(job, 'ANAIYST', sal*1.05, 'SALESMAN', sal*1.1, 'MANAGER', 
sal*1.15, 'CLERK', sal*1.2) as upsal from emp;

select ename, deptno, case when deptno = 10 then 'ACCOUNTUING' when deptno = 20 then 'RESEARCH' 
when deptno = 30 then 'SALES' when deptno = 40 then 'OPERATIONS' end as dname from emp;

select round(123.45678, 2) from dual;

select round(123.456) from dual;

select trunc(123.456,1) from dual;

select mod (100,11) from dual;

select mod (sal * 12 , 1000) from emp;

select mod (sal *12 +nvl(comm,0), 1000) from emp;

select sum(sal) as 합계 from emp;

select sum(comm) from emp;
-- 그룹 함수를 사용하게 되면 테이블 하나가 그룹이 되기 때문에 comm, sum(comm) 사용불가 null 값은 제외.

select round (avg(sal),2) from emp;

select max(sal), min(sal) from emp;

select max(hiredate) as 입사일 , min(hiredate) as 입사일 from emp;

select count(comm) from emp;

select count(mgr) from emp;

select count(*) from emp;

select count(comm) from emp
where deptno = 30;

select count (job) 업무수 from emp;

select count(distinct job) 업무수 from emp;

select deptno from emp
group by deptno;

select job, sum(sal) from emp
group by job;

select deptno, sum(sal), count(*) from emp
group by deptno;
-- group by 로 그룹화 해준 컬럼만 select 뒤에 사용가능.

select deptno, max(sal), min(sal) from emp
group by deptno;

select deptno, count(comm), count(*) from emp
group by deptno;

select deptno, trunc (avg(sal)) from emp
group by deptno having avg(sal) >= 2000;

select deptno, max(sal), min(sal) from emp
group by deptno having max(sal) > 2900;


--1 급여가 1000 이상인 사원들의 부서별 평균 급여를 출력해보세요
-- 단, 부서별 평균 급여가 2000 이상인 부서만 출력하시오.

select deptno, avg(sal) from emp
where sal >= 1000
group by deptno having avg(sal) >=2000;

--2 각 부서별 같은 업무(job)를 하는 사람의 인원수를 구해서 부서번호, 업무(job), 인원수를 부서번호에 대해서 오름차순으로 출력하시오.

select deptno, job, count(*) from emp
group by deptno, job order by deptno;

--3 부서별로, 업무별로 그룹을 지어서 부서번호, 업무, 인원수, 급여의 평균, 합계를 구하시오.

select deptno, job, count(*), avg(sal), sum(sal) from emp
group by deptno, job;


--4 부서별로 사원의 수가 4명 이상인 사원의 부서번호, 급여의 합계를 구하시오.

select deptno, sum(sal), /*count(*)*/ from emp
group by deptno having count(*) >= 4;

--5. emp테이블에서 직급이 SALESMAN이 아닌 사원에 대한 부서별로 급여의 합이 4000이상인 부서의 정보를 출력하시오.
--(부서번호, 급여의 합계순으로)
select deptno, sum(sal) from emp
--where not job = 'SALESMAN' -- 그룹절보다 먼저 기술할것.
--where job <> 'SALESMAN'
where job != 'SALESMAN'
group by deptno having sum(sal) >= 4000
order by deptno, sum(sal); -- 마지막에 기술할것.


--6. emp테이블에서 전체 급여가 5000을 초과하는 각 업무에 대해서 업무와 월급여의 합계를 출력하시오.
--(업무중에서 CLERK는 제외, 월급여의 합계로 내림차순)
select job, sum(sal) from emp
where not job = 'CLERK'
group by job having sum(sal)> 5000
order by job, sum(sal) desc;
