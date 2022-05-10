sc stop JAMSExecutor
<#
sc <server> [command] [service name] <option1> <option2>.

##Start-Sleep -45 5

sc.exe FFVWJAMAS01D config JAMSExecutor start= Manual


sc.exe FFVWJAMAS01D stop JAMSScheduler

##Start-Sleep -45 5

sc.exe FFVWJAMAS01D config JAMSScheduler start= Manual


sc.exe FFVWJAMAS01D stop JAMSServer

##Start-Sleep -45 5

sc.exe FFVWJAMAS01D config JAMSServer start= Manual

#>