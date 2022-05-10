

#Get-Service -Name "JAMSScheduler" | Format-List  -ComputerName FFVWJAMAS01D -Property Name, DependentServices

Stop-Service -Name "JAMSScheduler" -Force

Set-Service -Name "JAMSScheduler" -ComputerName FFVWJAMAS01D -startuptype Manual

#Start-Service -Name "JAMSScheduler" -ComputerName FFVWJAMAS01D




#Get-Service -Name "JAMSExecutor" | Format-List -ComputerName FFVWJAMAS01D -Property Name, DependentServices

Stop-Service -Name "JAMSExecutor" -Force 

Set-Service -Name "JAMSExecutor" -ComputerName FFVWJAMAS01D -startuptype Manual

#Start-Service -Name "JAMSExecutor" -ComputerName FFVWJAMAS01D



#Get-Service -Name "JAMSServer" | Format-List -ComputerName FFVWJAMAS01D -Property Name, DependentServices

Stop-Service -Name "JAMSServer" -Force

Set-Service -Name "JAMSServer" -ComputerName FFVWJAMAS01D -startuptype Manual

#Start-Service -Name "JAMSServer" -ComputerName FFVWJAMAS01D