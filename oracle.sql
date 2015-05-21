#check usage of tablespace
SELECT a.tablespace_name,
a.bytes total,
b.bytes used,
c.bytes free,
(b.bytes * 100) / a.bytes "% USED ",
(c.bytes * 100) / a.bytes "% FREE "
FROM sys.sm$ts_avail a, sys.sm$ts_used b, sys.sm$ts_free c
WHERE a.tablespace_name = b.tablespace_name
AND a.tablespace_name = c.tablespace_name;

#change archive log enable/disable.
startup mount;
alter database archivelog
alter database noarchivelog

#enable/disable flashback.
alter database flashback off/on;

#resize datafile
alter database datafile 'D:\ORAPP\ORADAT\TBS\USERS.DBF' resize 3000M;