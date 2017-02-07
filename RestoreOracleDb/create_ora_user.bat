@echo off

GOTO START

:HELP

echo Creates a new oracle user/database

echo %0 ^<Connection string^> ^<Database/User name^> [password]
echo.
echo Connection string:   ex: SYS/RedPrairie1 (Must be a SYSDBA)
echo Database/User name:  ex: tmora
echo Password (optional): ex: tmora (Defaults to database name)
echo.
echo Example usage: %0 SYS/RedPrairie1 tmora
echo                %0 SYS/RedPrairie1 tmora pass

exit /b 1
:START

IF "%1" EQU "" (
    GOTO HELP
)
IF "%2" EQU "" (
    GOTO HELP
)

SET UPPERNAME=
SET PASSWORD=%3
IF "%PASSWORD%" EQU "" (SET PASSWORD=%2)
FOR /F "tokens=*" %%A IN ('CALL C:\hudson\script\changecase.bat UPPER %2') do (
    SET UPPERNAME=%%A
)
IF "%UPPERNAME%" EQU "" (echo ERROR: Missing username & exit /b 1)

IF "%ORACLE_HOME%" EQU "" (
    (IF EXIST "C:\oracle\product\11.1.0\db_1" (
        SET ORACLE_HOME=C:\oracle\product\11.1.0\db_1
    ))
    (IF EXIST "C:\oracle\product\11.2.0\dbhome_1" (
        SET ORACLE_HOME=C:\oracle\product\11.2.0\dbhome_1
    ))
    (IF "%ORACLE_HOME%" EQU "" (
        echo ERROR: Unable to determine ORACLE_HOME.  Please specify it explicitly.
        exit /b 1
    ))
)

IF "%HUDSON_DB_SCRIPT_DIR%" EQU "" (SET HUDSON_DB_SCRIPT_DIR=%CD%)

(sqlplus -L %1 AS SYSDBA "@%HUDSON_DB_SCRIPT_DIR%\create_oracle_user.sql" "%UPPERNAME%" "%PASSWORD%" "%1" "%ORACLE_HOME%" < NUL)

IF ERRORLEVEL 1 (EXIT /b 1)
