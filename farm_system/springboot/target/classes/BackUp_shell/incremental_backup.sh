#!/bin/bash

# 数据库信息
DB_USER="your_db_username"
DB_PASSWORD="your_db_password"
DB_NAME="your_db_name"

# 备份文件信息
BACKUP_DIR="/path/to/backup"
DATE=$(date +"%Y%m%d_%H%M%S")
LATEST_FULL_BACKUP_FILE=$(find "${BACKUP_DIR}" -name "${DB_NAME}-full-*.sql" -type f -printf '%T+ %p\n' | sort -r | head -n 1 | awk '{print $2}')
INCREMENTAL_BACKUP_FILE="${BACKUP_DIR}/${DB_NAME}-incremental-${DATE}.sql"

# 检查是否找到最新的完整备份文件
if [ -z "${LATEST_FULL_BACKUP_FILE}" ]; then
    echo "No full backup file found. Please run full backup first."
    exit 1
fi

# 使用mysqldump工具创建差异备份
# shellcheck disable=SC2046
mysqldump -u "${DB_USER}" -p"${DB_PASSWORD}" --single-transaction --master-data --databases "${DB_NAME}" --since=$(date -r "${LATEST_FULL_BACKUP_FILE}" +"%Y-%m-%d %H:%M:%S") > "${INCREMENTAL_BACKUP_FILE}"
# 检查备份是否成功
# shellcheck disable=SC2181
if [ $? -eq 0 ]; then
    echo "Incremental database backup successfully created at ${INCREMENTAL_BACKUP_FILE}"
else
    echo "Incremental database backup failed"
fi
