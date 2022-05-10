function update_work_table($p_jobtype,$p_jobname) {
    $WORK_TABLE_JOB_PATH = "C:\Users\DB8.admin\Desktop\Project_Resource_test\private\WORK_TABLE_JOBS.CSV"

    #$TABLE_REC =  '"5","START","$JOBName_STR","NULL"'

    $TABLE_REC = '"'+ $IDX_STR + '","' + $p_jobtype + '","' + $p_jobname + '","' + (Get-Date).tostring + '"'

    $TABLE_REC | out-file -filepath $WORK_TABLE_JOB_PATH -append -force
}

function Get_last_Start_job() {
    $WORK_TABLE_JOB_PATH = "C:\Users\DB8.admin\Desktop\Project_Resource_test\private\WORK_TABLE_JOBS.CSV"

    Import-csv $WORK_TABLE_JOB_PATH -Header "ID","TYPE","JOBNAME","DATE_MODIFIED" | ?{ $_.TYPE -eq "START"} | SORT -Property JOBNAME -Descending | SELECT -SkipLast 1 | %{ $LATEST_START_JOB = $_.JOBNAME}
    

    return $LATEST_START_JOB
}
function Get_last_Stop_job() {
    $WORK_TABLE_JOB_PATH = "C:\Users\DB8.admin\Desktop\Project_Resource_test\private\WORK_TABLE_JOBS.CSV"

   Import-csv $WORK_TABLE_JOB_PATH -Header "ID","TYPE","JOBNAME","DATE_MODIFIED" | ?{ $_.TYPE -eq "STOP"} | SORT -Property JOBNAME -Descending | SELECT -SkipLast 1 | %{ $LATEST_STOP_JOB = $_.JOBNAME}
    

    return $LATEST_Stop_JOB
}
$x = Get_last_Start_job

$y = Get_last_Stop_job

$x

$y