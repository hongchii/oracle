set serveroutput on

declare --변수선언.
vempno number(4);
vename varchar2(20);
vdeptno emp.deptno%type;
vdname varchar2(20) := null;

begin
select empno, ename, deptno into vempno, vename, vdeptno
from emp
where empno = 7788;

if (vdeptno = 10) then
vdname := 'ACCOUNTING';
end if;
if (vdeptno = 20) then
vdname := 'RESEARCH';
end if;
if (vdeptno = 30) then
vdname := 'SALES';
end if;
if (vdeptno = 40) then
vdname := 'OPERATIONS';
end if;

dbms_output.put_line('사번     이름     부서명');
dbms_output.put_line(vempno||'  '||vename||'  '||vdname);
end;
/


declare
vemp emp%rowtype;
annsal number(7,2);
begin
dbms_output.put_line('사번 / 이름 / 연봉');
dbms_output.put_line('-------------------');

select * into vemp
from emp
where ename = 'SCOTT';

if vemp.comm is null then
vemp.comm := 0;
end if;

annsal:=vemp.sal*12+vemp.comm;
dbms_output.put_line(vemp.empno||'/'||vemp.ename||'/'||annsal);
end;
/


 


declare
vemp emp%rowtype;
vdname varchar2(14);
begin
dbms_output.put_line('사번 / 이름 / 부서명');
dbms_output.put_line('------------------------');

select * into vemp
from emp
where ename = 'SCOTT';


if (vemp.deptno = 10) then
vdname := 'ACCOUNTING';
elsif (vemp.deptno =20) then
vdname := 'RESEARCH';
elsif (vemp.deptno = 30) then
vdname := 'SALES';
elsif (vemp.deptno = 40) then
vdname := 'OPERATIONS';
end if;

dbms_output.put_line(vemp.empno||'/'||
vemp.ename||'/'||vdname);
end;
/


declare
n number :=1;
begin
loop
dbms_output.put_line(n);
n := n+1;
if n > 5 then
exit;
end if;
end loop;
end;
/


declare
n number :=1;
begin
loop
dbms_output.put_line(n);
n := n+1;
--if n > 5 then
exit when n > 5;
--end if;
end loop;
end;
/

declare
dan number := 5;
i number := 1;
begin
loop
dbms_output.put_line(dan || ' *' || i ||' = '||(dan * i));
i := i + 1 ;

if i > 9 then
exit when i > 9;
end if;
end loop;
end;
/


declare
begin
for n in reverse 1..5 loop --reverse를 붙이면 5,4,3,2,1
dbms_output.put_line(n);
end loop;
end;
/



declare
odd number :=0;
even number := 0;

begin
for n in 1..100 loop
if mod(n,2) = 0 then
  odd := odd + n;
  else
  even := even +n;
  end if;
  end loop;
dbms_output.put_line('홀수의 합 = ' || odd);
dbms_output.put_line('짝수의 합 = ' || even);
end;
/




declare
vdept dept%rowtype;
begin
dbms_output.put_line('부서번호/ 부서명 / 지역명');
dbms_output.put_line('-----------------------');

for cnt in 1..4 loop
select * into vdept
from dept
where deptno = 10* cnt;
dbms_output.put_line(vdept.deptno||'/'||vdept.dname||'/'||vdept.loc);
end loop;
end;
/


declare
n number := 1;
begin
while n <= 5 loop
dbms_output.put_line(n);
n := n+1;
end loop;
end;
/


declare
 v_cnt number := 1;
 v_str varchar2(10) := null;
begin
while v_cnt <= 5 loop
  v_str := v_str || '*';
  dbms_output.put_line(v_str);
  v_cnt := v_cnt+1;
 end loop;
end;
/


create or replace procedure del_all
is
begin
delete from emp01;
end;
/

select * from emp01;

execute del_all;

desc user_source;

select * from user_source;

create or replace procedure
del_ename(vename emp01.ename%type)
is
begin
delete from emp01 where ename = vename;
end;
/

drop table emp01;

create table emp01
as
select * from emp;

select * from emp01;

execute del_ename('SMITH');

select * from emp01;

rollback;


create or replace procedure sel_empno
(vempno in emp.empno%type,
 vename out emp.ename%type,
 vsal out emp.sal%type,
 vjob out emp.job%type,
 vdeptno out emp.deptno%type,
 vdname out dept.dname%type
)
is
begin
 select ename, sal, job, emp.deptno, dname into vename, vsal, vjob, vdeptno, vdname
 from emp, dept
 where empno = vempno and emp.deptno = dept.deptno;
end;
/

variable var_ename varchar2(15);
variable var_sal number;
variable var_job varchar2(9);
variable var_deptno number;
variable var_dname varchar2(14);

execute sel_empno(7788, :var_ename, :var_sal, :var_job, :var_deptno, :var_dname)

print var_dname;


create or replace function cal_bonus(vempno in emp.empno%type)
return number
is
vsal number(7, 2);
begin
select sal into vsal
from emp
where empno = vempno;

return (vsal * 200);
end;
/

variable var_res number;

execute :var_res := cal_bonus(7788);

print var_res;


create or replace procedure cursor_sample01
is
vdept dept%rowtype;
cursor c1
is
select * from dept;
begin
  dbms_output.put_line('부서번호 / 부서명 / 지역명');
  dbms_output.put_line('-----------------------------');

open c1;

loop
  fetch c1 into vdept.deptno, vdept.dname, vdept.loc;

  exit when c1%notfound;
  
  dbms_output.put_line(vdept.deptno||' '||vdept.dname||' '||vdept.loc);
  end loop;
  
  close c1;
end;
/

execute cursor_sample01;

select*from emp;


create or replace procedure cursor_sample01
(vdeptno in emp.deptno%type)
is
vemp emp%rowtype;
cursor c1
is
select * from emp
where deptno = vdeptno;

begin
  dbms_output.put_line('사원번호 / 사원이름 / 업무 / mgr / 입사일 / 급여 / 커미션 / 부서번호');
  dbms_output.put_line('----------------------------------------------------------');
  
open c1;

loop
  fetch c1 into vemp;
  
  exit when c1%notfound;
  
  dbms_output.put_line(vemp.empno||' '||vemp.ename||' '||vemp.job||' '||vemp.mgr||' '||
  vemp.hiredate||' '||vemp.sal||' '||vemp.comm||' '||vemp.deptno);
  end loop;
  
  close c1;
end;
/

execute cursor_sample01(20);


create or replace procedure cursor_sample02
is
vdept dept%rowtype;
cursor c1
is
select * from dept;
begin
dbms_output.put_line('부서번호/부서명/지역명');
dbms_output.put_line('---------------------');
--for문 사용시 오픈,패치,클로즈 없이 심플하게 사용가능함. 
for vdept in c1 loop
exit when c1%notfound;
dbms_output.put_line(vdept.deptno||' '||vdept.dname||' '||vdept.loc);
end loop;
end;
/

execute cursor_sample02;




create or replace procedure cursor_sample01
(vdeptno in emp.deptno%type)
is
vemp emp%rowtype;
cursor c1
is
select * from emp
where deptno = vdeptno;

begin
  dbms_output.put_line('사원번호 / 사원이름 / 업무 / mgr / 입사일 / 급여 / 커미션 / 부서번호');
  dbms_output.put_line('----------------------------------------------------------');
  
for vemp in c1 loop
 
  exit when c1%notfound;
  
  dbms_output.put_line(vemp.empno||' '||vemp.ename||' '||vemp.job||' '||vemp.mgr||' '||
  vemp.hiredate||' '||vemp.sal||' '||vemp.comm||' '||vemp.deptno);
  end loop;
  
end;
/

execute cursor_sample01(20);


--부서번호를 전달 받아 해당 부서에 근무하는 사원의 사원번호, 이름, 부서명, 지역, 급여를
--급여가 많은 순으로 출력하시오.
---<처리조건>
--레코드 타입을 정의해서 작성할것.



create or replace procedure test01
(vdeptno in emp.deptno%type)
is
vempno number(4);
vename varchar2(20);
vjob varchar2(20);
vloc varchar2(20);
vsal number;

cursor c1
is
select emp.deptno, ename, job, dept.loc, sal into vempno, vename, vjob, vloc, vsal
from emp, dept
where emp.deptno = vdeptno
order by vsal;

begin
  dbms_output.put_line('사원번호 / 사원이름 / 업무 / 지역 / 급여');
  dbms_output.put_line('---------------------------------');

for vemp in c1 loop

   exit when c1%notfound;
   dbms_output.put_line(vemp.empno||' '||vemp.ename||' '||vemp.job||' '||vdept.loc||' '||vemp.sal);
  end loop;
  
end;
/




create or replace procedure cursor_ex01(vdeptno in emp.deptno %type)
is
type emp_dept_redord_type is record(
empno emp.empno%type,
ename emp.ename&type,
dname dept.dname%type,
loc   dept.loc%type,
sal   emp.sal%type);
emp_dept_record emp_dept_record_type);
cursor c1 is select e.ename, d.dname, d.loc, e.sal
from emp e, dept d
where e.deptno = d.deptno and e.detpno = vdeptno
order by e.sal desc;

begin
  dbms_output.put_line('사원번호 / 사원이름 / 업무 / 지역 / 급여');
  dbms_output.put_line('---------------------------------');
for emp_dept_record in c1 loop
exit when c1%notfound;
   dbms_output.put_line(vemp.empno||' '||vemp.ename||' '||vemp.job||' '||vdept.loc||' '||vemp.sal);
  end loop;
  
end;
/

execute cursor_ex01(10);