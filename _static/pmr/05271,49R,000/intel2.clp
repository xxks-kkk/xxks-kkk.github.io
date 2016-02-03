!db2trc on -f intel.dmp; 
select * from n5;
!db2trc off;
!db2trc flw intel.dmp intel.flw;
!db2trc fmt intel.dmp intel.fmt;




