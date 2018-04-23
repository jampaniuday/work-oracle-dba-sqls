select 'alter table '||table_name||' allocate extent;' from user_tables where num_rows=0;

BEGIN
   FOR atable IN (select table_name from user_tables where num_rows=0) LOOP
      execute IMMEDIATE 'alter table '|| atable.table_name ||' allocate extent';
   END LOOP;
END;

alter system set deferred_segment_creation=false scope=both;
