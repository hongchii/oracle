--시퀀스

create sequence dept_deptno_seq
increment by 10
start with 10;
-- start 값부터 실행할때마다 새로운 값을 만들어냄
select dept_deptno_seq.nextval from dual;
-- 시퀀스의 현재값
select dept_deptno_seq.currval from dual;

select * from user_sequences;

create sequence emp_seq
start with 1
increment by 1
maxvalue 100000;

create table emp01(
empno number(4) primary key,
ename varchar(10),
hiredate date);

insert into emp01
values(emp_seq.nextval, 'JULIA', sysdate);

create sequence dept_Seq
start with 10
INCREMENT by 10;

insert into dept_example
values(dept_seq.nextval, '인사과', '서울');
insert into dept_example
values(dept_seq.nextval, '인사과', '서울');
insert into dept_example
values(dept_seq.nextval, '인사과', '서울');
insert into dept_example
values(dept_seq.nextval, '인사과', '서울');

