package com.example.task;

import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.InputStreamReader;

@Component
public class DatabaseBackupTask {
   /* 定义一个名为DatabaseBackupTask的类，该类用于执行数据库备份任务
   声明一个私有成员变量resourceLoader，用于加载绝对地址
  */
    private final ResourceLoader resourceLoader;
    public DatabaseBackupTask(ResourceLoader resourceLoader) {
            this.resourceLoader = resourceLoader;
    }
    // 使用@Scheduled注解定义一个定时任务，每天凌晨2点更新
    @Scheduled(fixedRate = 30000)
    public void backupDatabase() {
        // 使用mysqldump工具备份数据库
        try{
            String osName = System.getProperty("os.name");
            String command;
            ProcessBuilder processBuilder;
            if (osName.contains("Windows")) {
                Resource resource = resourceLoader.getResource("classpath:BackUp_shell/full_backup_db.bat");
                command = resource.getFile().getAbsolutePath();//获取脚本文件的绝对地址
                processBuilder = new ProcessBuilder("cmd.exe", "/c", command);//执行脚本
            }
            else
            {
                Resource resource = resourceLoader.getResource("classpath:BackUp_shell/full_backup_db.sh");
                command = resource.getFile().getAbsolutePath();//获取脚本文件的绝对地址
                processBuilder = new ProcessBuilder("bash", command);
                processBuilder.command().add(0, "chmod");
                processBuilder.command().add(1, "+x");

            }
            Process process = processBuilder.start();
            //读取脚本输出并打印到控制台
            try (BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    System.out.println(line);
                }
            }

            int Bitcode= process.waitFor();
            if(Bitcode==0) {
                System.out.println("数据库备份成功");
            }
            else {
                System.out.println("数据库备份失败"+Bitcode);
            }
        }catch (Exception e){
            System.err.println(e.getMessage());
        }
    }
}
