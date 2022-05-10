

sleep 5

taskkill /im JAMSScheduler /t /f

#sc.exe stop "JAMSScheduler"

sleep 5

sc.exe stop "JAMSExecutor"

sleep 5

sc.exe stop "JAMSServer"

sleep 5

sc.exe config "JAMSScheduler" start= demand

sc.exe config "JAMSExecutor" start= demand

sc.exe config "JAMSServer" start= demand

sc.exe query "JAMSServer"

sc.exe query "JAMSExecutor"

sc.exe query "JAMSScheduler"














































































