CREATE USER qatest IDENTIFIED BY 12345678;;
GRANT CONNECT TO qatest;
GRANT RESOURCE TO qatest;

DROP USER qatest;

ALTER USER qatest ACCOUNT UNLOCK

---
select * from xxxxx;