create or replace package exam_pack is
function cal_bonus(vempno in emp.empno%type)
return number;
procedure cursor_sample02;
end;
/

create or replace package body exam_pack is
function cal_bonus(vempno in emp.empno%type)
return number
is
vsal number(7,2);
begin
select sal into vsal
from emp
where empno = vempno;
return (vsal * 200);
end;

procedure cursor_sample02
is
vdept dept%rowtype;
cursor c1
is
select * from dept;
begin
dbms_output.put_line('부서번호 / 부서명 / 지역명');
dbms_output.put_line('------------------------');
for vdept in c1 loop
exit when c1%notfound;
dbms_output.put_line(vdept.deptno||' '||vdept.dname||' '||vdept.loc);
end loop;
end;
end;
/


variable var_res number;
execute :var_res := exam_pack.cal_bonus(7788);
print var_res;
execute exam_pack.cursor_sample02;

SET SERVEROUTPUT ON;SET SERVEROUTPUT ON;

create or replace trigger trg_01
after insert
on emp01
begin
  dbms_ouput.put_line('신입사원이 입사했습니다');
 end;
/


drop table emp01;

create table emp01
as
select empno, ename, job from emp where 1=0;

select * from emp01;

insert into emp01 values(1, '전원지', '화가');
insert into emp01 values(2, '이순신', '해군');