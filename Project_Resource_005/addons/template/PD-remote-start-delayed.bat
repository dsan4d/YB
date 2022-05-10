sc.exe \\FFVWJAMAS01P config "JAMSServer" start= delayed-auto

sc.exe \\FFVWJAMAS01P config "JAMSExecutor" start= delayed-auto

sc.exe \\FFVWJAMAS01P config "JAMSScheduler" start= delayed-auto


sc.exe \\FFVWJAMAS01P start "JAMSServer"

sc.exe \\FFVWJAMAS01P start "JAMSExecutor"

sc.exe \\FFVWJAMAS01P start "JAMSScheduler"


sc.exe \\FFVWJAMAS01P query "JAMSServer"

sc.exe \\FFVWJAMAS01P query "JAMSExecutor"

sc.exe \\FFVWJAMAS01P query "JAMSScheduler"

rem

sc.exe \\FFVWJAMAS02P config "JAMSServer" start= delayed-auto

sc.exe \\FFVWJAMAS02P config "JAMSExecutor" start= delayed-auto

sc.exe \\FFVWJAMAS02P config "JAMSScheduler" start= delayed-auto


sc.exe \\FFVWJAMAS02P start "JAMSServer"

sc.exe \\FFVWJAMAS02P start "JAMSExecutor"

sc.exe \\FFVWJAMAS02P start "JAMSScheduler"


sc.exe \\FFVWJAMAS02P query "JAMSServer"

sc.exe \\FFVWJAMAS02P query "JAMSExecutor"

sc.exe \\FFVWJAMAS02P query "JAMSScheduler"
cmd /k








