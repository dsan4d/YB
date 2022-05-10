#Function_Table_Date
function update_work_table($p_jobtype,$p_jobname) {
    $WORK_TABLE_JOB_PATH = "C:\Users\DB8.admin\Desktop\Project_Resource_test\private\WORK_TABLE_JOBS.CSV"

    #$TABLE_REC =  '"5","START","$JOBName_STR","NULL"'

    $TABLE_REC = '"'+ $IDX_STR + '","' + $p_jobtype + '","' + $p_jobname + '","' + (Get-Date).tostring + '"'

    $TABLE_REC | out-file -filepath $WORK_TABLE_JOB_PATH -append -force
}