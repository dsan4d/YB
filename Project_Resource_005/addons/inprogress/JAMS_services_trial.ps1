sc.exe FFVWJAMAS01D stop JAMSExecutor

sc.exe FFVWJAMAS01D config JAMSExecutor start= Manual

####after patch bounce

sc.exe FFVWJAMAS01D config JAMSExecutor start= delayed-auto

sc.exe FFVWJAMAS01D start JAMSExecutor



sc.exe FFVWJAMAS01D stop JAMSScheduler

sc.exe FFVWJAMAS01D config JAMSScheduler start= Manual

######after patch bounce

sc.exe FFVWJAMAS01D config JAMSScheduler start= delayed-auto

sc.exe FFVWJAMAS01D start JAMSScheduler




sc.exe FFVWJAMAS01D stop JAMSServer

sc.exe FFVWJAMAS01D config JAMSServer start= Manual

#####after patch bounce

sc.exe FFVWJAMAS01D config JAMSServer start= delayed-auto

sc.exe FFVWJAMAS01D start JAMSServer






#Get-Service -Name "JAMSExecutor" | Format-List  Property Name, DependentServices

#Get-Service "JAMSServer*" 

Get-Service "JAMS*" -ComputerName FFVWJAMAS01D | Sort-Object status



<#
Stop-Service -Name "JAMSExecutor" -ComputerName -Force -Confirm

Set-Service -Name "JAMSExecutor" -ComputerName -startuptype Manual

Start-Service -Name "JAMSExecutor" -ComputerName


Get-Service -Name "JAMSScheduler" | Format-List -Property Name, DependentServices

Stop-Service -Name "JAMSScheduler" -Force -Confirm

Start-Service -Name "JAMSScheduler"



Get-Service -Name "JAMSServer" | Format-List -Property Name, DependentServices

Stop-Service -Name "JAMSServer" -Force -Confirm

Start-Service -Name "JAMSServer"


Get-Service -Name "JAMSAgent" | Format-List -Property Name, DependentServices

Stop-Service -Name "JAMSAgent" -Force -Confirm

Start-Service -Name "JAMSAgent"

########################################################################################
Set-Service -Name "JAMSServer" -ComputerName -startuptype Manual



Set-Service -Name "JAMSScheduler" -ComputerName -startuptype Manual


Set-Service -Name "JAMSScheduler" -ComputerName -startuptype Manual
#>

##Stop-Service -Name "JAMSExecutor"  -ComputerName FFVWJAMAS01D

#Set-Service -Name "JAMSExecutor"  -ComputerName FFVWJAMAS01D -startuptype Manual

#Start-Service -ComputerName FFVWJAMAS01D -Name "JAMSExecutor" | Start-Service