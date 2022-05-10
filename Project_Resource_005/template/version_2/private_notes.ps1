##Start resource Job

Import-module JAMS

#$CrtDt = (Get-Date).tostring("yyyy_MM_dd__HH_mm")

$JOBName_STR = "Davetest_$CrtDt"

$WORK_TABLE_JOB_PATH = "C:\Users\DB8.admin\Desktop\Project_Resource_test\private\WORK_TABLE_JOBS.CSV"

((Import-csv $WORK_TABLE_JOB_PATH -Header "ID","TYPE","JOBNAME","DATE_MODIFIED" | SELECT -Skip 1 | SELECT ID,@{Name='id_int';Expression={[int]$_.ID}}) | Sort -property id_int) | SELECT -Last 1 | %{ $IDX = $_.ID_INT}

[string]$IDX_STR = ($IDX +1)

$TABLE_REC = '"'+ $IDX_STR + '","START","' + $JOBName_STR + '","NULL"'

$TABLE_REC | out-file -filepath $WORK_TABLE_JOB_PATH -append -Encoding utf8 -force

cat $WORK_TABLE_JOB_PATH


function update_work_table($p_jobtype,$p_jobname) {
    $WORK_TABLE_JOB_PATH = "C:\Users\DB8.admin\Desktop\Project_Resource_test\private\WORK_TABLE_JOBS.CSV"

    #$TABLE_REC =  '"5","START","$JOBName_STR","NULL"'

    $TABLE_REC = '"' + $IDX_STR + '","' + $p_jobtype + '","' + $p_jobname + '","' + (Get-Date).tostring + '"'

    $TABLE_REC | out-file -filepath $WORK_TABLE_JOB_PATH -append -force
}

function Get_last_Start_job() {
    $WORK_TABLE_JOB_PATH = "C:\Users\DB8.admin\Desktop\Project_Resource_test\private\WORK_TABLE_JOBS.CSV"

    Import-csv $WORK_TABLE_JOB_PATH -Header "ID","TYPE","JOBNAME","DATE_MODIFIED" | ?{ $_.TYPE -eq "START"} | SORT -Property JOBNAME -Descending | SELECT -SkipLast 1 | %{ $LATEST_START_JOB = $_.JOBNAME}
    

    return $LATEST_START_JOB
}
<#
function Get_last_Stop_job() {
    $WORK_TABLE_JOB_PATH = "C:\Users\DB8.admin\Desktop\Project_Resource_test\private\WORK_TABLE_JOBS.CSV"

   Import-csv $WORK_TABLE_JOB_PATH -Header "ID","TYPE","JOBNAME","DATE_MODIFIED" | ?{ $_.TYPE -eq "STOP"} | SORT -Property JOBNAME -Descending | SELECT -SkipLast 1 | %{ $LATEST_STOP_JOB = $_.JOBNAME}
    

    return $LATEST_Stop_JOB
}
#>
#######################################

<#$WORK_TABLE_JOB_PATH = "C:\Users\DB8.admin\Desktop\Project_Resource_test\private\WORK_TABLE_JOBS.CSV"

[string]$IDX_STR = ($IDX +1)

$JOBName_STR = "Davetest_$CrtDt"

#$TABLE_REC = '"21' + $IDX_STR + '","START","' + $JOBName_STR + '","NULL"'

$TABLE_REC = '"'+ $IDX_STR + '","START","' + $JOBName_STR + '","NULL"'

$TABLE_REC | out-file -filepath $WORK_TABLE_JOB_PATH -append -Encoding utf8 -force

#$TABLE_REC =  '"5","STOP","$JOBName_STR","NULL"'
#>
########################################
#$JAMS_Resources_Search_Path = Get-Item "JAMS::localhost\Resources\Davetest\" + "Davetest"

#$CrtDt = (Get-Date).tostring("yyyy_MM_dd__HH_mm")

#$JOBName_STR = "Davetest_$CrtDt"

[string]$IDX_STR = ($IDX +1)

$WORK_TABLE_JOB_PATH = "C:\Users\DB8.admin\Desktop\Project_Resource_test\private\WORK_TABLE_JOBS.CSV"

((Import-csv $WORK_TABLE_JOB_PATH -Header "ID","TYPE","JOBNAME","DATE_MODIFIED" | SELECT -Skip 1 | SELECT ID,@{Name='id_int';Expression={[int]$_.ID}}) | Sort -property id_int) | SELECT -Last 1 | %{ $IDX = $_.ID_INT}



$TABLE_REC = '"'+ $IDX_STR + '","START","' + $JOBName_STR + '","NULL"'

$TABLE_REC | out-file -filepath $WORK_TABLE_JOB_PATH -append -Encoding utf8 -force

cat $WORK_TABLE_JOB_PATH

$resource = Get-Item JAMS::localhost\Resources\Davetest

#$input = Get-Content "D:\JAMS_Logs\Resources\Davetest\Davetest.txt"

$x = Get_last_start_job

#$input = Get-Content "D:\JAMS_Logs\Resources\Davetest\" + $x + ".txt"

##$input = Get-Content  "D:\JAMS_Logs\Resources\Davetest\Davetest_2021_10_14__12_58.txt"
$input = Get-Content  "D:\JAMS_Logs\Resources\Davetest\"

$resource.QuantityAvailable = $input

$resource.Update

