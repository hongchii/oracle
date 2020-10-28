select * from tab;

desc emp; 

select * from emp;

select ename, sal, hiredate from emp;

select ename, sal, sal * 12 from emp;

select sal + comm from emp;

select sal - 100 from emp;

select sal * 12 from emp;

select sal / 2 from emp;

select ename, sal, job, comm, sal * 12, sal *12+comm from emp;

select ename, comm, sal * 12 + comm, nvl(comm, 0), sal * 12 +nvl(comm, 0) from emp;

select deptno, dname from dept;

select ename from emp
where ename = 'JONES';

insert into emp  
values(  
 7788, 'SCOTT', 'ANALYST', 7566,  
 to_date('13-07-1987','dd-mm-yyyy') - 85,  
 3000, null, 20  
);

insert into emp  
values(  
 7902, 'FORD', 'ANALYST', 7566,  
 to_date('3-12-1981','dd-mm-yyyy'),  
 3000, null, 20  
);

insert into emp  
values(  
 7369, 'SMITH', 'CLERK', 7902,  
 to_date('17-12-1980','dd-mm-yyyy'),  
 800, null, 20  
);

insert into emp  
values(  
 7499, 'ALLEN', 'SALESMAN', 7698,  
 to_date('20-2-1981','dd-mm-yyyy'),  
 1600, 300, 30  
);

insert into emp  
values(  
 7521, 'WARD', 'SALESMAN', 7698,  
 to_date('22-2-1981','dd-mm-yyyy'),  
 1250, 500, 30  
);

insert into emp  
values(  
 7654, 'MARTIN', 'SALESMAN', 7698,  
 to_date('28-9-1981','dd-mm-yyyy'),  
 1250, 1400, 30  
);

insert into emp  
values(  
 7844, 'TURNER', 'SALESMAN', 7698,  
 to_date('8-9-1981','dd-mm-yyyy'),  
 1500, 0, 30  
);

insert into emp  
values(  
 7876, 'ADAMS', 'CLERK', 7788,  
 to_date('13-07-1987', 'dd-mm-yyyy') - 51,  
 1100, null, 20  
);

insert into emp  
values(  
 7900, 'JAMES', 'CLERK', 7698,  
 to_date('3-12-1981','dd-mm-yyyy'),  
 950, null, 30  
);

insert into emp  
values(  
 7934, 'MILLER', 'CLERK', 7782,  
 to_date('23-1-1982','dd-mm-yyyy'),  
 1300, null, 10  
);

select ename, dname, job, empno, hiredate, loc  
from emp, dept  
where emp.deptno = dept.deptno  
order by ename;

select dname, count(*) count_of_employees
from dept, emp
where dept.deptno = emp.deptno
group by DNAME
order by 2 desc;

select * from emp;

select distinct deptno from emp;

select distinct job from emp;

select deptno, ename, sal from emp
where sal <= 1500;

select empno, ename, sal from emp
where ename = 'SCOTT';

select ename, hiredate from emp
where hiredate >= '1982/01/01';

select * from emp
where not deptno = 10;

select ename, deptno, job from emp
where deptno = 10 and job = 'MANAGER';

select ename, deptno, job from emp
where deptno = 10 or job = 'MANAGER';

select ename, deptno, job from emp
where not deptno = 10;