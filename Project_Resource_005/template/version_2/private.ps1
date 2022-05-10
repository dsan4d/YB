$WORK_TABLE_JOB_PATH = "C:\Users\DB8.admin\Desktop\Project_Resource_test\private\WORK_TABLE_JOBS.CSV"

#Import-csv $WORK_TABLE_JOB_PATH -Header "ID","TYPE","JOBNAME","DATE_MODIFIED"

Import-csv $WORK_TABLE_JOB_PATH -Header "ID","TYPE","JOBNAME","DATE_MODIFIED" | ?{ $_.TYPE -eq "START"} | SORT -Property JOBNAME -Descending | SELECT -SkipLast 1 | %{ $LATEST_START_JOB = $_.JOBNAME}


Import-csv $WORK_TABLE_JOB_PATH -Header "ID","TYPE","JOBNAME","DATE_MODIFIED" | ?{ $_.TYPE -eq "STOP"} | SORT -Property JOBNAME -Descending | SELECT -SkipLast 1 | %{ $LATEST_STOP_JOB = $_.JOBNAME}

"FOUND_STOP: $LATEST_STOP_JOB"

"FOUND_START: $LATEST_START_JOB"