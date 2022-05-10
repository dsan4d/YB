@ECHO OFF
 
powershell.exe -Command "& 'C:\Users\DB8.admin\Desktop\Project_Resource_test\addons\StopServices.ps1'"

rem sc.exe stop "JAMSScheduler"

rem sc.exe stop "JAMSExecutor"

rem sc.exe stop "JAMSServer"


sc.exe config "JAMSScheduler" start= demand

sc.exe config "JAMSExecutor" start= demand

sc.exe config "JAMSServer" start= demand


sc.exe query "JAMSServer"

sc.exe query "JAMSExecutor"

sc.exe query "JAMSScheduler"












































































