@echo off
REM 数据库信息
set DB_USER=root
set DB_PASSWORD=xjc200302
set DB_NAME=manage

REM 备份文件信息
set BACKUP_DIR=C:\backup
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set datetime=%%I
set DATE=%datetime:~0,8%
set FULL_BACKUP_FILE=%BACKUP_DIR%\%DB_NAME%-full-%DATE%.sql

REM 显示变量值
echo DATE: %DATE%
echo FULL_BACKUP_FILE: %FULL_BACKUP_FILE%

REM 使用mysqldump工具创建完整备份
"D:\MySQL\MySQL Server 8.0\bin\mysqldump.exe" -u %DB_USER% -p%DB_PASSWORD% --single-transaction --master-data %DB_NAME% > %FULL_BACKUP_FILE%
if errorlevel 1 (
    echo Error code: %errorlevel%
    echo mysqldump command failed. Check the MySQL server and credentials.
)

REM 检查备份是否成功
if %errorlevel% equ 0 (
    echo Full database backup successfully created at %FULL_BACKUP_FILE%
) else (
    echo Full database backup failed
)
