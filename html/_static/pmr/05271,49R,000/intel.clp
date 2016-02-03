--db2 list db directory|grep -i testdb || db2 create db testdb;

connect to intel;

drop wrapper net8;
create wrapper net8 options(DB2_FENCED 'Y');

drop server orardb;
--!db2trc on -f pmr.dmp;
--create server orardb type oracle version 11.0 wrapper net8 authorization "J15USER2" password "J15USER2" options
--(node 'ora11gcsdl2'
  --   ,DB2_MAXIMAL_PUSHDOWN  'Y'
    -- ,DB2_REQUESTS_IO_BLOCK_BUF  '170'
     --);
create server orardb type oracle version 11.0 wrapper net8 authorization "J15USER2" password "J15USER2" options
      (node 'ora11gcsdl2'
           ,DB2_MAXIMAL_PUSHDOWN  'Y'
           ,DB2_REQUESTS_IO_BLOCK_BUF  '1024'
     );     
--!db2trc off;
--!db2trc flw pmr.dmp pmr.flw;
--!db2trc fmt pmr.dmp pmr.fmt;

create user mapping for user server orardb options (REMOTE_AUTHID 'J15USER2', REMOTE_PASSWORD 'J15USER2' );

--set passthru orardb;
--drop table t1992;
--create table t1992(i int);
--insert into t1992 values (10);
--insert into t1992 values (20);
--set passthru reset;

drop nickname n5;
--!db2trc on -f pmr1.dmp; 
create nickname n5 for orardb.j15user2.t1992;
--!db2trc off;
--!db2trc flw pmr1.dmp pmr1.flw;
--!db2trc fmt pmr1.dmp pmr1.fmt;




