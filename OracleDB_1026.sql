desc dba_objects;

select object_name from dba_objects
where object_type='PACKAGE' and object_name like 'DBMS_%'
order by object_name;