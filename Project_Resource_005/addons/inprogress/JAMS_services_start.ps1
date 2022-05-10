####after patch bounce

sc.exe FFVWJAMAS01D config JAMSExecutor start= delayed-auto

sc.exe FFVWJAMAS01D start JAMSExecutor

######after patch bounce

sc.exe FFVWJAMAS01D config JAMSScheduler start= delayed-auto

sc.exe FFVWJAMAS01D start JAMSScheduler

#####after patch bounce

sc.exe FFVWJAMAS01D config JAMSServer start= delayed-auto

sc.exe FFVWJAMAS01D start JAMSServer
