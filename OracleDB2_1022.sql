set serveroutput on

declare --변수선언.
vempno number(4);
vename varchar2(10);
begin 
vempno := 7788;
vename := 'SCOTT';
dbms_output.put_line('사번 / 이름');
dbms_output.put_line('---------');
dbms_output.put_line(vempno || '/' || vename);
end;
/

select empno, ename
from emp
where job = 'MANAGER';

declare
vempno emp.empno%TYPE;
vename emp.ename%TYPE;
begin
dbms_output.put_line('사번/이름');
dbms_output.put_line('-------');

select empno,ename into vempno,vename
from emp
where job = 'MANAGER';
dbms_output.put_line(vempno||'/'||vename);
end;
/

declare
type ename_table_type is table of emp.ename%type
index by binary_integer;
type job_table_type is table of emp.job%type
index by binary_integer;
ename_table ename_table_type;
job_table job_table_type;

i binary_integer := 0;
begin
for k in(select ename, job from emp) loop
i:=i+1;
ename_table(i):=k.ename;
job_table(i):=k.job;
end loop;

for j in 1..i loop
dbms_output.put_line(rpad(ename_table(j),12)||'/'|| rpad(job_table(j),9));
end loop;
end;
/

declare
type emp_record_type is record(
v_empno emp.empno%type,
v_ename emp.ename%type,
v_job emp.job%type,
v_deptno emp.deptno%type);

emp_record emp_record_type;
begin
select empno, ename, job, deptno
into emp_record
from emp
where ename = upper('SCOTT');

dbms_output.put_line('사원번호:' ||
to_char(emp_record.v_empno));
dbms_output.put_line('이   름:' ||
emp_record.v_ename);
dbms_output.put_line('담당업무:' ||
to_char(emp_record.v_deptno));
end;
/
declare
type emp_dept_record_type is record(
v_empno emp.empno%type,
v_ename emp.ename%type,
v_job emp.job%type,
v_deptno emp.deptno%type,
v_dname dept.dname%type);

emp_dept_record emp_dept_record_type;

begin
select empno, ename, job, emp.deptno, dname into emp_dept_record
from emp,dept
where ename = upper('SCOTT')and emp.deptno = dept.deptno;

dbms_output.put_line('사원번호:' ||
to_char(emp_dept_record.v_empno));
dbms_output.put_line('이   름:' ||
emp_dept_record.v_ename);
dbms_output.put_line('담당업무:' ||
emp_dept_record.v_job);
dbms_output.put_line('부서번호:' ||
to_char(emp_dept_record.v_deptno));
dbms_output.put_line('부서명:' ||
emp_dept_record.v_dname);
end;
/
