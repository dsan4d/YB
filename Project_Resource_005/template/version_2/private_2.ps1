$CrtDt = (Get-Date).tostring("yyyy_MM_dd__HH_mm")

$JOBName_STR = "Davetest_$CrtDt"

$WORK_TABLE_JOB_PATH = "C:\Users\DB8.admin\Desktop\Project_Resource_test\private\WORK_TABLE_JOBS.CSV"

((Import-csv $WORK_TABLE_JOB_PATH -Header "ID","TYPE","JOBNAME","DATE_MODIFIED" | SELECT -Skip 1 | SELECT ID,@{Name='id_int';Expression={[int]$_.ID}}) | Sort -property id_int) | SELECT -Last 1 | %{ $IDX = $_.ID_INT}

[string]$IDX_STR = ($IDX +1)

$TABLE_REC = '"'+ $IDX_STR + '","START","' + $JOBName_STR + '","NULL"'

$TABLE_REC | out-file -filepath $WORK_TABLE_JOB_PATH -append -Encoding utf8 -force

cat $WORK_TABLE_JOB_PATH
