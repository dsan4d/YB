sc.exe \\FFVWJAMAS01D config "JAMSServer" start= delayed-auto

sc.exe \\FFVWJAMAS01D config "JAMSExecutor" start= delayed-auto

sc.exe \\FFVWJAMAS01D config "JAMSScheduler" start= delayed-auto

sleep 5

sc.exe \\FFVWJAMAS01D start "JAMSServer"

sleep 5

sc.exe  \\FFVWJAMAS01D start "JAMSExecutor"

sleep 5

sc.exe \\FFVWJAMAS01D start "JAMSScheduler"


sc.exe \\FFVWJAMAS01D query "JAMSServer"

sc.exe \\FFVWJAMAS01D query "JAMSExecutor"

sc.exe \\FFVWJAMAS01D query "JAMSScheduler"











