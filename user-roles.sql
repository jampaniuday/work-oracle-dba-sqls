/* bps_ora */
create user bps_ora identified by 12345678;
grant connect to bps_ora;
grant resource to bps_ora;
grant all privileges to bps_ora;

/**     **/
alter user gjzspt_demo2 identified by Oe123qwe###;
alter user gjzspt_demo2 identified by 12345678;

alter user gjzspt_demo2_dev account unlock;
alter user gjzspt_demo2 account unlock;
alter user gjzspt_demo2_dev identified by 12345678;

/* */
select * from dba_role_privs where grantee = 'GJZSPT_DEMO2';

select * from dba_sys_privs where grantee = 'GJZSPT';
select * from dba_sys_privs where grantee = 'GJZSPT_DEMO';
select * from dba_sys_privs where grantee = 'GJZSPT_DEMO2';
select * from dba_sys_privs where grantee = 'GJZSPT_DEMO2_DEV';
select * from dba_sys_privs where grantee = 'GJZSPT_DEMO2_ADMIN';

grant create table to GJZSPT_DEMO2;
select * from role_sys_privs where role in (select granted_role from dba_role_privs where grantee = 'GJZSPT');
select * from role_sys_privs where role in (select granted_role from dba_role_privs where grantee = 'GJZSPT_DEMO');
select * from role_sys_privs where role in (select granted_role from dba_role_privs where grantee = 'GJZSPT_DEMO2');
select * from role_sys_privs where role in (select granted_role from dba_role_privs where grantee = 'GJZSPT_DEMO2_DEV');
select * from role_sys_privs where role in (select granted_role from dba_role_privs where grantee = 'GJZSPT_DEMO2_ADMIN');
select * from role_sys_privs where role = 'DBA';
select * from role_sys_privs where role = 'SELECT_CATALOG_ROLE';

select * from session_privs;

select * from session_roles;

/** begin securites setting up **/
create user GJZSPT_DEMO2_DEV identified by 12345678;
grant connect to GJZSPT_DEMO2_DEV;

grant SELECT ANY TABLE to GJZSPT_DEMO2_DEV;
grant UPDATE ANY TABLE to GJZSPT_DEMO2_DEV;
grant DELETE ANY TABLE to GJZSPT_DEMO2_DEV;
grant INSERT ANY TABLE to GJZSPT_DEMO2_DEV;

create or replace trigger GJZSPT_DEMO2_DEV.AFTER_LOGON_GJZSPT_DEMO2_DEV
AFTER LOGON ON DATABASE
BEGIN
   IF (ora_login_user = 'GJZSPT_DEMO2_DEV') THEN
    EXECUTE IMMEDIATE 'ALTER SESSION SET current_schema=GJZSPT_DEMO2';
   END IF;
END;

--gjzspt_demo2_dev

select sys_context( 'userenv', 'current_schema' ) from dual; 

revoke CREATE ANY TABLE from GJZSPT_DEMO2_DEV;
revoke DROP ANY TABLE from GJZSPT_DEMO2_DEV;

--drop trigger GJZSPT_DEMO2_DEV.AFTER_LOGON_GJZSPT_DEMO2_DEV;
--ALTER TRIGGER GJZSPT_DEMO2_DEV.AFTER_LOGON_GJZSPT_DEMO2_DEV enable;

--GRANT SELECT_CATALOG_ROLE TO GJZSPT_DEMO2_DEV; 
--grant select any dictionary to GJZSPT_DEMO2_DEV; 

/** begin reverse setting up **/
revoke resource from GJZSPT_DEMO2;
revoke resource from GJZSPT_DEMO2_ADMIN;
grant resource to GJZSPT_DEMO2_ADMIN;
BEGIN
   FOR aTab IN (SELECT table_name FROM all_tables WHERE owner = 'GJZSPT_DEMO2') LOOP
      execute IMMEDIATE 'REVOKE ALL ON GJZSPT_DEMO2.'||aTab.table_name||' FROM GJZSPT_DEMO2_ADMIN';
   END LOOP;
END;

BEGIN
   FOR aTab IN (SELECT table_name FROM all_tables WHERE owner = 'GJZSPT_DEMO2') LOOP
      execute IMMEDIATE 'GRANT ALL ON GJZSPT_DEMO2.'||aTab.table_name||' TO GJZSPT_DEMO2_ADMIN';
   END LOOP;
END;

/** begin securites setting up **/
drop user GJZSPT_DEMO2_ADMIN cascade;
create user GJZSPT_DEMO2_ADMIN identified by gjzspt_testteam;
grant connect to GJZSPT_DEMO2_ADMIN;

grant CREATE ANY TABLE to GJZSPT_DEMO2_ADMIN;
grant DROP ANY TABLE to GJZSPT_DEMO2_ADMIN;
grant ALTER ANY TABLE to GJZSPT_DEMO2_ADMIN;

grant CREATE ANY INDEX to GJZSPT_DEMO2_ADMIN;
grant ALTER ANY INDEX to GJZSPT_DEMO2_ADMIN;
grant DROP ANY INDEX to GJZSPT_DEMO2_ADMIN;

grant SELECT ANY TABLE to GJZSPT_DEMO2_ADMIN;
grant UPDATE ANY TABLE to GJZSPT_DEMO2_ADMIN;
grant DELETE ANY TABLE to GJZSPT_DEMO2_ADMIN;
grant INSERT ANY TABLE to GJZSPT_DEMO2_ADMIN;

create or replace trigger GJZSPT_DEMO2_ADMIN.AFTER_LOGON_GJZSPT_DEMO2_ADMIN
AFTER LOGON ON DATABASE
BEGIN
  IF (ora_login_user = 'GJZSPT_DEMO2_ADMIN') THEN
    EXECUTE IMMEDIATE 'ALTER SESSION SET current_schema=GJZSPT_DEMO2';
  END IF;
END;

/** GJZSPT_DEMO2_ADMIN **/
alter session set current_schema=GJZSPT_DEMO2;

select * from t_dgap_resource;

select * from session_privs;
select * from session_roles;
