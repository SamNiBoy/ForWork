USE [master]
RESTORE DATABASE [fit-8.2]
   FROM DISK = 'D:\dbbackup\8.2Fitness\dcs-release-8.2-bootstrapped.bak' WITH REPLACE
Go