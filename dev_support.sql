-- 外键约束
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 't_dgap_alert_config';

--- 数据库并发连接数限制 ---
SELECT * FROM v$resource_limit WHERE resource_name IN ('processes','sessions');
ALTER system SET processes=300 scope=spfile;
--- restart oracle instance

--- 账户解锁 ---
ALTER USER gjzspt ACCOUNT UNLOCK;
alter user gjzspt identified by 12345678;

--- 表解锁 ---
ALTER SESSION SET CURRENT_SCHEMA = gjzspt;
SELECT object_name,
  machine,
  s.sid,
  s.serial#
FROM v$locked_object l,
  dba_objects o ,
  v$session s
WHERE l.object_id　=　o.object_id
AND l.session_id  =s.sid;

alter system kill session'62,5510';

SELECT * FROM v$lock;

--- 建视图 ---
ALTER SESSION SET CURRENT_SCHEMA = gjzspt;

CREATE OR REPLACE VIEW TTS_VIEW_CPXS AS
 SELECT S.ID,S.PRODUCT_PC,S.PRODUCT_AMOUNT,(S.PRODUCT_AMOUNT-S.FREEZE_COUNT-XS.XSSL) STORE_COUNT,XS.XSSL,S.FREEZE_COUNT,
CASE WHEN S.PRODUCT_AMOUNT = (XS.XSSL+S.FREEZE_COUNT) THEN '3' WHEN S.PRODUCT_AMOUNT > (XS.XSSL+S.FREEZE_COUNT)
THEN '2' WHEN S.PRODUCT_AMOUNT < (XS.XSSL+S.FREEZE_COUNT) THEN '1' END STATUS 
FROM TTS_SCLTXXCJ_SCGL S
INNER JOIN (
SELECT X.PRODUCT_SCGL_ID,SUM(X.SALE_AMOUNT) XSSL FROM TTS_SCLTXXCJ_XSDJJL X
GROUP BY PRODUCT_SCGL_ID) XS ON XS.PRODUCT_SCGL_ID = S.PRODUCT_PC ;