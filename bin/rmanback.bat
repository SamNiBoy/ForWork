rman target sys/sys@maint nocatalog cmdfile 'D:\oracle\myscripts\rmanback.txt'
LOG 'D:\oracle\myscripts\rman_backup_%DATE:~0,2%%DATE:~5,2%%DATE:~8,2%.log'