
sc.exe \\FFVWJAMAS01D stop "JAMSScheduler"

sc.exe \\FFVWJAMAS01D stop "JAMSExecutor"

sc.exe \\FFVWJAMAS01D stop "JAMSServer"

sc.exe \\FFVWJAMAS01D config "JAMSScheduler" start= demand

sc.exe \\FFVWJAMAS01D config "JAMSExecutor" start= demand

sc.exe \\FFVWJAMAS01D config "JAMSServer" start= demand

sc.exe \\FFVWJAMAS01D query "JAMSServer"

sc.exe \\FFVWJAMAS01D query "JAMSExecutor"

sc.exe \\FFVWJAMAS01D query "JAMSScheduler"














































































