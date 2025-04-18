package com.example.task;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

@Component
public class DatabaseBackupTask {

    @Scheduled(fixedRate = 30000) // 每30秒执行一次任务
    public void backupDatabase() {
        // 确保 mysqldump.exe 路径存在并使用双引号包裹路径
        String backupCommand = "\"F:\\mysql\\MySQL Server 8.0\\bin\\mysqldump.exe\" -u root -p123456 --databases farm_system > E:\\beifen\\bf.sql";

        try {
            // 使用 cmd.exe /c 执行命令
            Process process = Runtime.getRuntime().exec("cmd.exe /c " + backupCommand);

            // 获取标准输出和标准错误流
            BufferedReader inputReader = new BufferedReader(new InputStreamReader(process.getInputStream()));
            BufferedReader errorReader = new BufferedReader(new InputStreamReader(process.getErrorStream()));

            // 读取并打印标准输出
            String line;
            while ((line = inputReader.readLine()) != null) {
                System.out.println(line); // 打印正常输出
            }

            // 读取并打印错误输出
            while ((line = errorReader.readLine()) != null) {
                System.err.println(line); // 打印错误输出
            }

            // 等待命令完成并获取退出码
            int exitCode = process.waitFor();
            if (exitCode == 0) {
                System.out.println("备份成功: " + System.currentTimeMillis());
            } else {
                System.err.println("备份失败，错误码: " + exitCode);
            }

        } catch (IOException | InterruptedException e) {
            System.err.println("执行备份时出错: " + e.getMessage());
        }
    }
}
