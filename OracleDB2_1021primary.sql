drop table emp01;

-- 제약조건 없이 테이블생성.
create table emp01(
empno number(4),
ename varchar2(10),
job varchar2(9),
deptno number(4));

--제약조건 설정하기1. (기본키 설정)
alter table emp01
add constraint emp01_empno_pk primary key(empno);

--제약조건 설정하기2. (외래키 설정)
--constraint emp01_deptno_fk 생략가능함. 디폴트값은 sys
alter table emp01
add constraint emp01_deptno_fk
foreign key(deptno) references dept(deptno);

--제약조건 확인하기.
select table_name, constraint_type, constraint_name,
r_constraint_name, status
from user_constraints where table_name in ('EMP01', 'DEPT01');

--제약조건과 칼럼까지 확인 가능.
select * from user_cons_columns where table_name in ('emp01', 'dept01');

-- modify로 not null 제약조건 설정하기.
--constraint emp01_ename_nn 제약조건의 이름을 주는거. 생략가능.
alter table emp01
modify ename constraint emp01_ename_nn not null;

--제약조건 제거하기.
alter table emp01
drop constraint emp01_empno_pk;

--제약조건 제거하기.(not null)
alter table emp01
drop constraint emp01_ename_nn;


drop table dept01;

create table dept01(
deptno number(2) constraint dept01_deptno_pk primary key,
dname varchar2(14),
loc varchar2(13));

drop table emp01;

create table emp01(
empno number(4)
constraint emp01_empno_pk primary key,
ename varchar2(10)
constraint emp01_ename_nn not null,
job varchar2(9),
deptno number(4)
constraint emp01_deptno_fk references dept01(deptno));


insert into dept01
select * from dept;

insert into emp01 values(7499, 'ALLEN', 'SALESMAN', 10);
insert into emp01 values(7369, 'SMITH', 'CLERK', 20);
select * from emp01;

commit;

--삭제불가. deptno10은 emp01과 참조관계이기때문에 삭제불가. 
delete from dept01 where deptno=10;
--삭제가능. deptno40은 emp01에 없는 데이터이기땜에 참조관계여도 삭제가능.
delete from dept01 where deptno=40;
-- commit 후 delete 한거 되돌리기.
rollback;

--제약조건 비활성화하기.
alter table emp01
disable constraint emp01_deptno_fk;
-- deptno삭제가능해짐. 다시 활성화 하면 에러생김(참조의 무결성 위배). 정말 필요할때만 사용.
delete from dept01 where deptno = 10;
rollback;

--제약조건 활성화하기.
alter table emp01
enable constraint emp01_deptno_fk;

--기본키를 참조하고 있는 외래키가 존재하기 때문에 삭제불가.
alter table dept01
disable primary key cascade;
--enable 활성화/ disable 비활성화 

--cascade를 사용하면 참조하는 키까지 삭제시킴. 
--cascade를 사용 못하면 참조하는 외래키를 먼저 삭제하고 primary key를 삭제해야함(2번작업)
alter table dept01
drop primary key cascade;

select * from dept01;
select * from emp01;