sc.exe config "JAMSServer" start= delayed-auto

sc.exe config "JAMSExecutor" start= delayed-auto

sc.exe config "JAMSScheduler" start= delayed-auto


sc.exe start "JAMSServer"

sc.exe start "JAMSExecutor"

sc.exe start "JAMSScheduler"


sc.exe \\FFVWJAMAS01D query "JAMSServer"

sc.exe \\FFVWJAMAS01D query "JAMSExecutor"

sc.exe \\FFVWJAMAS01D query "JAMSScheduler"











