@ECHO OFF

sc.exe config "JAMSServer" start= delayed-auto
sc.exe config "JAMSExecutor" start= delayed-auto
sc.exe config "JAMSScheduler" start= delayed-auto

sc.exe start "JAMSServer"
sc.exe start "JAMSExecutor"
sc.exe start "JAMSScheduler"

sc.exe query "JAMSServer"
sc.exe query "JAMSExecutor"
sc.exe query "JAMSScheduler"









