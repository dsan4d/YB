
sc.exe \\FFVWJAMAS02P stop "JAMSScheduler"

sc.exe \\FFVWJAMAS02P stop "JAMSExecutor"

sc.exe \\FFVWJAMAS02P stop "JAMSServer"

sc.exe \\FFVWJAMAS02P config "JAMSScheduler" start= demand

sc.exe \\FFVWJAMAS02P config "JAMSExecutor" start= demand

sc.exe \\FFVWJAMAS02P config "JAMSServer" start= demand

sc.exe \\FFVWJAMAS02P query "JAMSServer"

sc.exe \\FFVWJAMAS02P query "JAMSExecutor"

sc.exe \\FFVWJAMAS02P query "JAMSScheduler"


sc.exe \\FFVWJAMAS01P stop "JAMSScheduler"

sc.exe \\FFVWJAMAS01P stop "JAMSExecutor"

sc.exe \\FFVWJAMAS01P stop "JAMSServer"

sc.exe \\FFVWJAMAS01P config "JAMSScheduler" start= demand

sc.exe \\FFVWJAMAS01P config "JAMSExecutor" start= demand

sc.exe \\FFVWJAMAS01P config "JAMSServer" start= demand

sc.exe \\FFVWJAMAS01P query "JAMSServer"

sc.exe \\FFVWJAMAS01P query "JAMSExecutor"

sc.exe \\FFVWJAMAS01P query "JAMSScheduler"













































































