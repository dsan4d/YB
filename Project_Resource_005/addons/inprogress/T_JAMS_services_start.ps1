
#Get-Service -Name "JAMS Server" | Format-List -Property Name, DependentServices

#sc.exe FFVWJAMAS01D config JAMS Server start= delayed-auto

#Set-Service -Name "JAMS Server" -ComputerName FFVWJAMAS01D -startuptype Manual

Start-Service -Name "JAMSServer"


#Get-Service -Name "JAMSExecutor" | Format-List -Property Name, DependentServices

#sc.exe FFVWJAMAS01D config JAMSExecutor start= delayed-auto

#Set-Service -Name "JAMSExecutor" -ComputerName FFVWJAMAS01D -startuptype Manual

Start-Service -Name "JAMSExecutor" 



#Get-Service -Name "JAMS Scheduler" | Format-List -Property Name, DependentServices

#sc.exe FFVWJAMAS01D config JAMS Scheduler start= delayed-auto

#Set-Service -Name "JAMS Scheduler" -ComputerName FFVWJAMAS01D -startuptype Manual

Start-Service -Name "JAMS Scheduler" 


<#
Get-Service -Name "JAMSExecutor" | Format-List -Property Name, DependentServices

Stop-Service -Name "JAMSExecutor" -Force -Confirm

Set-Service -Name "JAMSExecutor" -ComputerName FFVWJAMAS01D -startuptype Manual

#Start-Service -Name "JAMSExecutor" -ComputerName FFVWJAMAS01D



Get-Service -Name "JAMSServer" | Format-List -Property Name, DependentServices

Stop-Service -Name "JAMSServer" -Force -Confirm

Set-Service -Name "JAMSExecutor" -ComputerName FFVWJAMAS01D -startuptype Manual

#Start-Service -Name "JAMSServer" -ComputerName FFVWJAMAS01D



sc config spooler start = delayed-auto

#>