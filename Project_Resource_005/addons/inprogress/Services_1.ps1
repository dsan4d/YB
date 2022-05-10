

Get-Service -Name "JAMSScheduler" | Format-List -Property Name, DependentServices

Stop-Service -Name "JAMSExecutor" -ComputerName FFVWJAMAS01D -Force -Confirm

Set-Service -Name "JAMSExecutor" -ComputerName FFVWJAMAS01D -startuptype Manual

Start-Service -Name "JAMSExecutor" -ComputerName FFVWJAMAS01D




Get-Service -Name "JAMSScheduler" | Format-List -Property Name, DependentServices

Stop-Service -Name "JAMSScheduler" -Force -Confirm

Set-Service -Name "JAMSExecutor" -ComputerName FFVWJAMAS01D -startuptype Manual

Start-Service -Name "JAMSScheduler" -ComputerName FFVWJAMAS01D



Get-Service -Name "JAMSServer" | Format-List -Property Name, DependentServices

Stop-Service -Name "JAMSServer" -Force -Confirm

Start-Service -Name "JAMSServer" -ComputerName FFVWJAMAS01D