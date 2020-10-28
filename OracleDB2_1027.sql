create or replace procedure call_select(
v_member_cursor out sys_refcursor
)
is
begin
open v_member_cursor
for
select * from member
order by hakbun;
end;
/



create or replace procedure call_insert(hakbun MEMBER.HAKBUN%TYPE,
name MEMBER.NAME%TYPE, addr MEMBER.ADDR%TYPE,
phone MEMBER.PHONE%TYPE)
is
begin
    insert into member values(hakbun, name, addr, phone);
end;
/



create or replace procedure call_update (p_hakbun MEMBER.HAKBUN%TYPE,
p_addr MEMBER.ADDR%TYPE, p_phone MEMBER.PHONE%TYPE)
is
begin
update member set addr = p_addr, phone = p_phone where hakbun = p_hakbun;
end;
/


create or replace procedure call_delete (p_hakbun MEMBER.HAKBUN%TYPE)
is
begin
delete from member where hakbun = p_hakbun;
end;
/