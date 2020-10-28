
SET SERVEROUTPUT ON;
create or replace procedure cursor_ex01(vdeptno in emp.deptno%type)
is
type emp_dept_record_type is record(
empno emp.empno%type,
ename emp.ename%type,
dname dept.dname%type,
loc   dept.loc%type,
sal   emp.sal%type);
emp_dept_record emp_dept_record_type;
CURSOR c1 is select emp.empno, emp.ename, dept.dname, dept.loc, emp.sal
from emp , dept 
where emp.deptno = dept.deptno and emp.detpno = vdeptno
order by emp.sal desc;

begin
  dbms_output.put_line('사원번호 / 사원이름 / 업무 / 지역 / 급여');
  dbms_output.put_line('---------------------------------');
for emp_dept_record in c1 loop
   exit when c1%notfound;
   dbms_output.put_line(emp_dept_record.empno||' '||emp_dept_record.ename||' '||emp_dept_record.job||' 
   '||emp_dept_record.loc||' '||emp_dept_record.sal);
  end loop;
  
end;
/

execute cursor_ex01(10);

desc emp;

select * from emp;