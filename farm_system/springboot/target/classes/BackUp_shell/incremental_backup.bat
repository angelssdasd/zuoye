@echo off
REM 数据库信息
set DB_USER=your_db_username
set DB_PASSWORD=your_db_password
set DB_NAME=your_db_name

REM 备份文件信息
set BACKUP_DIR=C:\path\to\backup
set DATE=%date:~-4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%
set LATEST_FULL_BACKUP_FILE=%BACKUP_DIR%\%DB_NAME%-full-*.sql
set INCREMENTAL_BACKUP_FILE=%BACKUP_DIR%\%DB_NAME%-incremental-%DATE%.sql

REM 查找最新的完整备份文件
for /f "delims=" %%i in ('dir /b /s /o-d "%LATEST_FULL_BACKUP_FILE%"') do (
    set LATEST_FULL_BACKUP=%%i
    goto :break
)
:break

REM 使用mysqldump工具创建差异备份
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysqldump.exe" -u %DB_USER% -p%DB_PASSWORD% --single-transaction --master-data --databases %DB_NAME% --since=%LATEST_FULL_BACKUP% > %INCREMENTAL_BACKUP_FILE%

REM 检查备份是否成功
if %errorlevel% equ 0 (
    echo Incremental database backup successfully created at %INCREMENTAL_BACKUP_FILE%
) else (
    echo Incremental database backup failed
)
