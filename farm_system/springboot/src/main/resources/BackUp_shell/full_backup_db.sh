#!/bin/bash

# 数据库信息
DB_USER="your_db_username"
DB_PASSWORD="your_db_password"
DB_NAME="your_db_name"

# 备份文件信息
BACKUP_DIR="/path/to/backup"
DATE=$(date +"%Y%m%d")
FULL_BACKUP_FILE="${BACKUP_DIR}/${DB_NAME}-full-${DATE}.sql"

# 使用mysqldump工具创建完整备份
mysqldump -u "${DB_USER}" -p"${DB_PASSWORD}" --single-transaction --master-data "${DB_NAME}" > "${FULL_BACKUP_FILE}"

# 检查备份是否成功
if [ $? -eq 0 ]; then
    echo "Full database backup successfully created at ${FULL_BACKUP_FILE}"
else
    echo "Full database backup failed"
fi
