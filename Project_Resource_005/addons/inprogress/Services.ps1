#Change this values to suit your needs:
$SvcName = 'Spooler'
$SvrName = 'remotePC'

#Initialize variables:
[string]$WaitForIt = ""
[string]$Verb = ""
[string]$Result = "FAILED"
$svc = (get-service -computername $SvrName -name $SvcName)
Write-host "$SvcName on $SvrName is $($svc.status)"
Switch ($svc.status) {
    'Stopped' {
        Write-host "Starting $SvcName..."
        $Verb = "start"
        $WaitForIt = 'Running'
        $svc.Start()}
    'Running' {
        Write-host "Stopping $SvcName..."
        $Verb = "stop"
        $WaitForIt = 'Stopped'
        $svc.Stop()}
    Default {
        Write-host "$SvcName is $($svc.status).  Taking no action."}
}
if ($WaitForIt -ne "") {
    Try {  # For some reason, we cannot use -ErrorAction after the next statement:
        $svc.WaitForStatus($WaitForIt,'00:02:00')
    } Catch {
        Write-host "After waiting for 2 minutes, $SvcName failed to $Verb."
    }
    $svc = (get-service -computername $SvrName -name $SvcName)
    if ($svc.status -eq $WaitForIt) {$Result = 'SUCCESS'}
    Write-host "$Result`: $SvcName on $SvrName is $($svc.status)"
}






