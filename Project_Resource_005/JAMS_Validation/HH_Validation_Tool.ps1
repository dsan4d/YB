
Import-Module JAMS

New-PSDrive JD -PSProvider JAMS -Root localhost -ErrorAction SilentlyContinue
## Be careful not to select too many jobs with -FullObject enabled, as that may cause errors.
CD JD:\
#$hour = (Get-Date).AddHours(-1)
#$startDate = (Get-Date).tostring("yyyy_MM_dd__HH_mm_ss")


$jobs = @(

Get-childitem -Path \MFT\Windows_Unix\MFT_W_U_FDCVWDB0020D -ObjectType Job -FullObject

Get-childitem -Path \MFT\Windows_Unix\MFT_W_U_FDCVWDB0015D -ObjectType Job -FullObject

Get-childitem -Path \MFT\Unix_Windows\MFT_U_W_FLODEV00_HHSERVERS_Shipping_Extracts -ObjectType Job -FullObject

Get-childitem -Path \HH\SQL_Tasks\FDCVWDB0015D\P3\HH_0017_Upload_Queue_Processing_TDBProcess -ObjectType Job -FullObject

Get-childitem -Path \HH\SQL_Tasks\FDCVWDB0020D\P3\HH_0018_Upload_Queue_Processing_GZProcess -ObjectType Job -FullObject

Get-childitem -Path \HH\SQL_Tasks\FDCVWDB0020D\P3\HH_0017_Upload_Queue_Processing_TDBProcess -ObjectType Job -FullObject

Get-childitem -Path \HH\SQL_Tasks\FDCVWDB0015D\P3\HH_0015_Upload_Flowers_Export_Queue_Processing -ObjectType Job -FullObject

)

#7300 hours = 10 months
foreach ($job in $jobs) {
if ($job.LastSuccess -gt (get-date).AddHours(-1)) {
        write-host -Object "$($job.name) $($job.LastSuccess)"

    }
}





