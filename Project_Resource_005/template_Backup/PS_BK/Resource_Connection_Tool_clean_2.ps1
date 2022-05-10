#---------------------------------------------------------------------------
#Describe: Jams ...
#
#Process: first draft completed
#
#Modify Date User    all pieces are working!!!!
#----------- ------- -------------------------------------------------------
#10/01/2021 DWS      ...
#---------------------------------------------------------------------------

cls
#Path to template and generated files
$f_template_start_Path = "C:\Users\DB8.admin\Desktop\Project_Resource_test\template\t_Job_source_stop.txt"
$f_generated_start_Path = "C:\Users\DB8.admin\Desktop\Project_Resource_test\generated\g_Job_source_stop.txt"

$f_template_stop_Path = "C:\Users\DB8.admin\Desktop\Project_Resource_test\template\t_Job_source_start.txt"
$f_generated_stop_Path = "C:\Users\DB8.admin\Desktop\Project_Resource_test\generated\g_Job_source_start.txt"

$CreateDate = (Get-Date).tostring("yyyy_MM_dd__HH_mm_ss")

#Add JAMS Module
Import-module JAMS

Add-Type -AssemblyName System.Windows.Forms

$DISPLAY_NULL = "(null)"


#Function Reset
function message_reset {
    $message_lbl.text = ""
}

#Function Begin Maintenance
function datepicker_begin_lbl_Click {
    $begin_date_dte_sel = DatePicker("Begin Day Date")
    if ($begin_date_dte_sel -eq $NULL)  {
        $DatePicker_begin_edit_lbl.text = $DISPLAY_NULL  
    } else {
         
        $DatePicker_begin_edit_lbl.text = ($begin_date_dte_sel).tostring("MM/dd/yyyy")        
    }
    write-host $DatePicker_begin_edit_lbl.text

    message_reset
}

#Function End Maintenance
function datepicker_end_lbl_Click {
    $end_date_dte_sel = DatePicker("End Day Date")
    if ($end_date_dte_sel -eq $NULL)  {
        $DatePicker_end_edit_lbl.text = $DISPLAY_NULL   
    } else {
        
        $DatePicker_end_edit_lbl.text = ($end_date_dte_sel).tostring("MM/dd/yyyy")        
    }
    write-host $DatePicker_end_edit_lbl.text

    message_reset
}

#Function Button Submit
function submit_btn_Click {
    message_reset
    if ($DatePicker_end_edit_lbl.text -eq $DISPLAY_NULL){
        $Message_lbl.text = "ERROR: Entry must be valid $DISPLAY_NULL not allowed"
        
    } else {


        [datetime]$r1 = $stime.selectedItem.value
        [datetime]$r2 = $etime.selectedItem.value

        $DatePicker_begin_lbl.text
        $r1_stime_str = $r1.tostring('hh:mm tt')
        $r2_stime_str = $r2.tostring('hh:mm tt')
        
        $Begin_DateSelected_str = $DatePicker_begin_edit_lbl.text + " " + $r1_stime_str 
        $End_DateSelected_str = $DatePicker_end_edit_lbl.text + " " + $r2_stime_str 
        write-host "time selected is: $Begin_DateSelected_str -->  $End_DateSelected_str" 
    
        if ($true) {
            $Name = $resourceBox.SelectedItem
            $JAMS_Resources_Search_Path = "JAMS::localhost\Resources\" + $Name
            write-host "searching... $JAMS_Resources_Search_Path" 

            $resource = Get-Item $JAMS_Resources_Search_Path 
            

            #Path for job in Folder
            ###$job_Search_path = "JD:\\!!!DAVE_DEMO\" + $Name
            #$job_Search_path_Stop = "JD:\\!!!DAVE_DEMO\Start_" + $Name
            #$job_Search_path_Start = "JD:\\!!!DAVE_DEMO\Stop_" + $Name
             $job_Search_path_Stop = "JD:\\\Basis_DBA\Start_" + $Name + "_" + $CreateDate
             $job_Search_path_Start = "JD:\\\Basis_DBA\Stop_" + $Name + "_" + $CreateDate



            #if (test-path $job_Search_path) {remove-item $job_Search_path -force}
            #if (test-path $job_Search_path_Start) {remove-item $job_Search_path_Start -force}
            #if (test-path $job_Search_path_Stop) {remove-item $job_Search_path_Stop -force}

            ###$job = New-Item $job_Search_path -itemtype Job -MethodName PowerShell
            $job_start = New-Item $job_Search_path_Start -itemtype Job -MethodName PowerShell
            $job_end = New-Item $job_Search_path_Stop -itemtype Job -MethodName PowerShell

            #$job = New-Item JD:\\Basis_DBA\MyJob1234 -itemtype Job -MethodName PowerShell
            $job_start.Description = "This job was added, with success " + $Name
            $job_end.Description = "This job was added, with success " + $Name

            (Get-Content $f_template_stop_Path).Replace("<DWSJAMS_JobNameDWS>",$Name) | Out-File $f_generated_stop_Path -force
       
            $job_end.source = ""
            (get-content $f_generated_stop_Path) | %{$job_end.source  += $_ + [char]13+[char]10}

            (Get-Content $f_template_start_Path).Replace("<DWSJAMS_JobNameDWS>",$Name) | Out-File $f_generated_start_Path -force
       
            $job_start.source = ""
            (get-content $f_generated_start_Path) | %{$job_start.source  += $_ + [char]13+[char]10}

            #start/Begin Trigger
           
            $Schedule_start = $DatePicker_begin_edit_lbl.text
            $Schedule_end = $DatePicker_end_edit_lbl.text
        
            ###$ScheduleTrigger = [MVPSI.JAMS.ScheduleTrigger]::New("$Schedule_start",[MVPSI.JAMS.TimeOfDay]"$r1_stime_str") #09/28/2021 03:30 AM
            $ScheduleTrigger_begin = [MVPSI.JAMS.ScheduleTrigger]::New("$Schedule_start",[MVPSI.JAMS.TimeOfDay]"$r1_stime_str") #09/28/2021 03:30 AM
            $ScheduleTrigger_end = [MVPSI.JAMS.ScheduleTrigger]::New("$Schedule_end",[MVPSI.JAMS.TimeOfDay]"$r2_stime_str") #09/28/2021 03:30 AM
            
            #####Enabled/Disable Job
            $job_start.Properties.setvalue("Enabled",$True)
            $job_end.Properties.setvalue("Enabled",$True)           
            $ScheduleTrigger_begin.Enabled = $True
            $ScheduleTrigger_end.Enabled = $True

            ###$job.Elements.Add($ScheduleTrigger)
            $job_start.Elements.Add($ScheduleTrigger_begin)
            $job_end.Elements.Add($ScheduleTrigger_end)

            ###Execute AS ID 
            $job_start.ExecuteAsName = "JAMS"
            $job_end.ExecuteAsName = "JAMS"

            
            # Update the Job object for changes to take effect
            $prm = new-object MVPSI.JAMS.Param
            $prm.ParamName = "JAMSTraceLevel1"
            $prm.DefaultValue = "Verbose"
            $prm.DataType = [MVPSI.JAMS.DataType]::Text
            $prm.Length = 10
            $job_start.Parameters.Add($prm)
            $job_end.Parameters.Add($prm)
            ###$job.Elements.Add($ScheduleTrigger)
            $job_start.Elements.Add($ScheduleTrigger_begin)
            $job_end.Elements.Add($ScheduleTrigger_end)


            $job_start.Update()
            $job_end.Update()
        }
    }

    ##CALL JAMS API here...
    
}



#Function Cancel Button
function cancel_btn_Click {
    write-host  "in cancel addclick"
    $main_form.close()
}
#Function Calendar
function DatePicker($title) {
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
    $global:date = $null
    $form = New-Object Windows.Forms.Form
    $form.Size = New-Object Drawing.Size(233,190)
    $form.StartPosition = "CenterScreen"
    $form.KeyPreview = $true
    $form.FormBorderStyle = "FixedSingle"
    $form.Text = $title
    $calendar = New-Object System.Windows.Forms.MonthCalendar
    $calendar.ShowTodayCircle = $false
    $calendar.MaxSelectionCount = 1
    $form.Controls.Add($calendar)
    $form.TopMost = $true
    $form.add_KeyDown({
        if($_.KeyCode -eq "Escape") {
            $global:date = $false
            $form.Close()
        }
    })


    $calendar.add_DateSelected({
        $global:date = $calendar.SelectionStart
        $form.Close()
    })
    [void]$form.add_Shown($form.Activate())
    [void]$form.ShowDialog()
    return $global:date
}
cls

#string.split ('$arrfile = join-path $env:TEMP "LoadArr.txt" - $arrfile_ = join-path $env:TEMP "LoadArr.txt"')

[string] $arrfile = join-path $env:TEMP "LoadArr.txt"

#Start_Time array
$combo_start_time_DS = [collections.arraylist]@(

    [pscustomobject]@{name='12:00 AM';value='12:00 AM'}
    [pscustomobject]@{name='12:15 AM';value='12:15 AM'}
    [pscustomobject]@{name='12:30 AM';value='12:30 AM'}
    [pscustomobject]@{name='12:45 AM';value='12:45 AM'}

    [pscustomobject]@{name='01:00 AM';value='01:00 AM'}
    [pscustomobject]@{name='01:15 AM';value='01:15 AM'}
    [pscustomobject]@{name='01:30 AM';value='01:30 AM'}
    [pscustomobject]@{name='01:45 AM';value='01:45 AM'}

    [pscustomobject]@{name='02:00 AM';value='02:00 AM'}
    [pscustomobject]@{name='02:15 AM';value='02:15 AM'}
    [pscustomobject]@{name='02:30 AM';value='02:30 AM'}
    [pscustomobject]@{name='02:45 AM';value='02:45 AM'}

    [pscustomobject]@{name='03:00 AM';value='03:00 AM'}
    [pscustomobject]@{name='03:15 AM';value='03:15 AM'}
    [pscustomobject]@{name='03:30 AM';value='03:30 AM'}
    [pscustomobject]@{name='03:45 AM';value='03:45 AM'}

    [pscustomobject]@{name='04:00 AM';value='04:00 AM'}
    [pscustomobject]@{name='04:15 AM';value='04:15 AM'}
    [pscustomobject]@{name='04:30 AM';value='04:30 AM'}
    [pscustomobject]@{name='04:45 AM';value='04:45 AM'}
	
	[pscustomobject]@{name='05:00 AM';value='05:00 AM'}
    [pscustomobject]@{name='05:15 AM';value='05:15 AM'}
    [pscustomobject]@{name='05:30 AM';value='05:30 AM'}
    [pscustomobject]@{name='05:45 AM';value='05:45 AM'}

    [pscustomobject]@{name='06:00 AM';value='06:00 AM'}
    [pscustomobject]@{name='06:15 AM';value='06:15 AM'}
    [pscustomobject]@{name='06:30 AM';value='06:30 AM'}
    [pscustomobject]@{name='06:45 AM';value='06:45 AM'}

    [pscustomobject]@{name='07:00 AM';value='07:00 AM'}
    [pscustomobject]@{name='07:15 AM';value='07:15 AM'}
    [pscustomobject]@{name='07:30 AM';value='07:30 AM'}
    [pscustomobject]@{name='07:45 AM';value='07:45 AM'}

    [pscustomobject]@{name='08:00 AM';value='08:00 AM'}
    [pscustomobject]@{name='08:15 AM';value='08:15 AM'}
    [pscustomobject]@{name='08:30 AM';value='08:30 AM'}
    [pscustomobject]@{name='08:45 AM';value='08:45 AM'}

    [pscustomobject]@{name='09:00 AM';value='09:00 AM'}
    [pscustomobject]@{name='09:15 AM';value='09:15 AM'}
    [pscustomobject]@{name='09:30 AM';value='09:30 AM'}
    [pscustomobject]@{name='09:45 AM';value='09:45 AM'}
	
	[pscustomobject]@{name='10:00 AM';value='10:00 AM'}
    [pscustomobject]@{name='10:15 AM';value='10:15 AM'}
    [pscustomobject]@{name='10:30 AM';value='10:30 AM'}
    [pscustomobject]@{name='10:45 AM';value='10:45 AM'}

    [pscustomobject]@{name='11:00 AM';value='11:00 AM'}
    [pscustomobject]@{name='11:15 AM';value='11:15 AM'}
    [pscustomobject]@{name='11:30 AM';value='11:30 AM'}
    [pscustomobject]@{name='11:45 AM';value='11:45 AM'}

    [pscustomobject]@{name='12:00 PM';value='12:00 PM'}
    [pscustomobject]@{name='12:15 PM';value='12:15 PM'}
    [pscustomobject]@{name='12:30 PM';value='12:30 PM'}
    [pscustomobject]@{name='12:45 PM';value='12:45 PM'}

    [pscustomobject]@{name='01:00 PM';value='01:00 PM'}
    [pscustomobject]@{name='01:15 PM';value='01:15 PM'}
    [pscustomobject]@{name='01:30 PM';value='01:30 PM'}
    [pscustomobject]@{name='01:45 PM';value='01:45 PM'}

    [pscustomobject]@{name='02:00 PM';value='02:00 PM'}
    [pscustomobject]@{name='02:15 PM';value='02:15 PM'}
    [pscustomobject]@{name='02:30 PM';value='02:30 PM'}
    [pscustomobject]@{name='02:45 PM';value='02:45 PM'}

    [pscustomobject]@{name='03:00 PM';value='03:00 PM'}
    [pscustomobject]@{name='03:15 PM';value='03:15 PM'}
    [pscustomobject]@{name='03:30 PM';value='03:30 PM'}
    [pscustomobject]@{name='03:45 PM';value='03:45 PM'}

    [pscustomobject]@{name='04:00 PM';value='04:00 PM'}
    [pscustomobject]@{name='04:15 PM';value='04:15 PM'}
    [pscustomobject]@{name='04:30 PM';value='04:30 PM'}
    [pscustomobject]@{name='04:45 PM';value='04:45 PM'}
	
	[pscustomobject]@{name='05:00 PM';value='05:00 PM'}
    [pscustomobject]@{name='05:15 PM';value='05:15 PM'}
    [pscustomobject]@{name='05:30 PM';value='05:30 PM'}
    [pscustomobject]@{name='05:45 PM';value='05:45 PM'}

    [pscustomobject]@{name='06:00 PM';value='06:00 PM'}
    [pscustomobject]@{name='06:15 PM';value='06:15 PM'}
    [pscustomobject]@{name='06:30 PM';value='06:30 PM'}
    [pscustomobject]@{name='06:45 PM';value='06:45 PM'}

    [pscustomobject]@{name='07:00 PM';value='07:00 PM'}
    [pscustomobject]@{name='07:15 PM';value='07:15 PM'}
    [pscustomobject]@{name='07:30 PM';value='07:30 PM'}
    [pscustomobject]@{name='07:45 PM';value='07:45 PM'}

    [pscustomobject]@{name='08:00 PM';value='08:00 PM'}
    [pscustomobject]@{name='08:15 PM';value='08:15 PM'}
    [pscustomobject]@{name='08:30 PM';value='08:30 PM'}
    [pscustomobject]@{name='08:45 PM';value='08:45 PM'}

    [pscustomobject]@{name='09:00 PM';value='09:00 PM'}
    [pscustomobject]@{name='09:15 PM';value='09:15 PM'}
    [pscustomobject]@{name='09:30 PM';value='09:30 PM'}
    [pscustomobject]@{name='09:45 PM';value='09:45 PM'}
	
	[pscustomobject]@{name='10:00 PM';value='10:00 PM'}
    [pscustomobject]@{name='10:15 PM';value='10:15 PM'}
    [pscustomobject]@{name='10:30 PM';value='10:30 PM'}
    [pscustomobject]@{name='10:45 PM';value='10:45 PM'}

    [pscustomobject]@{name='11:00 PM';value='11:00 PM'}
    [pscustomobject]@{name='11:15 PM';value='11:15 PM'}
    [pscustomobject]@{name='11:30 PM';value='11:30 PM'}
    [pscustomobject]@{name='11:45 PM';value='11:45 PM'}
	
	)
	
#End_Time array
$combo_end_time_DS = [collections.arraylist]@(


    [pscustomobject]@{name='12:00 AM';value='12:00 AM'}
    [pscustomobject]@{name='12:15 AM';value='12:15 AM'}
    [pscustomobject]@{name='12:30 AM';value='12:30 AM'}
    [pscustomobject]@{name='12:45 AM';value='12:45 AM'}

    [pscustomobject]@{name='01:00 AM';value='01:00 AM'}
    [pscustomobject]@{name='01:15 AM';value='01:15 AM'}
    [pscustomobject]@{name='01:30 AM';value='01:30 AM'}
    [pscustomobject]@{name='01:45 AM';value='01:45 AM'}

    [pscustomobject]@{name='02:00 AM';value='02:00 AM'}
    [pscustomobject]@{name='02:15 AM';value='02:15 AM'}
    [pscustomobject]@{name='02:30 AM';value='02:30 AM'}
    [pscustomobject]@{name='02:45 AM';value='02:45 AM'}

    [pscustomobject]@{name='03:00 AM';value='03:00 AM'}
    [pscustomobject]@{name='03:15 AM';value='03:15 AM'}
    [pscustomobject]@{name='03:30 AM';value='03:30 AM'}
    [pscustomobject]@{name='03:45 AM';value='03:45 AM'}

    [pscustomobject]@{name='04:00 AM';value='04:00 AM'}
    [pscustomobject]@{name='04:15 AM';value='04:15 AM'}
    [pscustomobject]@{name='04:30 AM';value='04:30 AM'}
    [pscustomobject]@{name='04:45 AM';value='04:45 AM'}
	
	[pscustomobject]@{name='05:00 AM';value='05:00 AM'}
    [pscustomobject]@{name='05:15 AM';value='05:15 AM'}
    [pscustomobject]@{name='05:30 AM';value='05:30 AM'}
    [pscustomobject]@{name='05:45 AM';value='05:45 AM'}

    [pscustomobject]@{name='06:00 AM';value='06:00 AM'}
    [pscustomobject]@{name='06:15 AM';value='06:15 AM'}
    [pscustomobject]@{name='06:30 AM';value='06:30 AM'}
    [pscustomobject]@{name='06:45 AM';value='06:45 AM'}

    [pscustomobject]@{name='07:00 AM';value='07:00 AM'}
    [pscustomobject]@{name='07:15 AM';value='07:15 AM'}
    [pscustomobject]@{name='07:30 AM';value='07:30 AM'}
    [pscustomobject]@{name='07:45 AM';value='07:45 AM'}

    [pscustomobject]@{name='08:00 AM';value='08:00 AM'}
    [pscustomobject]@{name='08:15 AM';value='08:15 AM'}
    [pscustomobject]@{name='08:30 AM';value='08:30 AM'}
    [pscustomobject]@{name='08:45 AM';value='08:45 AM'}

    [pscustomobject]@{name='09:00 AM';value='09:00 AM'}
    [pscustomobject]@{name='09:15 AM';value='09:15 AM'}
    [pscustomobject]@{name='09:30 AM';value='09:30 AM'}
    [pscustomobject]@{name='09:45 AM';value='09:45 AM'}
	
	[pscustomobject]@{name='10:00 AM';value='10:00 AM'}
    [pscustomobject]@{name='10:15 AM';value='10:15 AM'}
    [pscustomobject]@{name='10:30 AM';value='10:30 AM'}
    [pscustomobject]@{name='10:45 AM';value='10:45 AM'}

    [pscustomobject]@{name='11:00 AM';value='11:00 AM'}
    [pscustomobject]@{name='11:15 AM';value='11:15 AM'}
    [pscustomobject]@{name='11:30 AM';value='11:30 AM'}
    [pscustomobject]@{name='11:45 AM';value='11:45 AM'}

    [pscustomobject]@{name='12:00 PM';value='12:00 PM'}
    [pscustomobject]@{name='12:15 PM';value='12:15 PM'}
    [pscustomobject]@{name='12:30 PM';value='12:30 PM'}
    [pscustomobject]@{name='12:45 PM';value='12:45 PM'}

    [pscustomobject]@{name='01:00 PM';value='01:00 PM'}
    [pscustomobject]@{name='01:15 PM';value='01:15 PM'}
    [pscustomobject]@{name='01:30 PM';value='01:30 PM'}
    [pscustomobject]@{name='01:45 PM';value='01:45 PM'}

    [pscustomobject]@{name='02:00 PM';value='02:00 PM'}
    [pscustomobject]@{name='02:15 PM';value='02:15 PM'}
    [pscustomobject]@{name='02:30 PM';value='02:30 PM'}
    [pscustomobject]@{name='02:45 PM';value='02:45 PM'}

    [pscustomobject]@{name='03:00 PM';value='03:00 PM'}
    [pscustomobject]@{name='03:15 PM';value='03:15 PM'}
    [pscustomobject]@{name='03:30 PM';value='03:30 PM'}
    [pscustomobject]@{name='03:45 PM';value='03:45 PM'}

    [pscustomobject]@{name='04:00 PM';value='04:00 PM'}
    [pscustomobject]@{name='04:15 PM';value='04:15 PM'}
    [pscustomobject]@{name='04:30 PM';value='04:30 PM'}
    [pscustomobject]@{name='04:45 PM';value='04:45 PM'}
	
	[pscustomobject]@{name='05:00 PM';value='05:00 PM'}
    [pscustomobject]@{name='05:15 PM';value='05:15 PM'}
    [pscustomobject]@{name='05:30 PM';value='05:30 PM'}
    [pscustomobject]@{name='05:45 PM';value='05:45 PM'}

    [pscustomobject]@{name='06:00 PM';value='06:00 PM'}
    [pscustomobject]@{name='06:15 PM';value='06:15 PM'}
    [pscustomobject]@{name='06:30 PM';value='06:30 PM'}
    [pscustomobject]@{name='06:45 PM';value='06:45 PM'}

    [pscustomobject]@{name='07:00 PM';value='07:00 PM'}
    [pscustomobject]@{name='07:15 PM';value='07:15 PM'}
    [pscustomobject]@{name='07:30 PM';value='07:30 PM'}
    [pscustomobject]@{name='07:45 PM';value='07:45 PM'}

    [pscustomobject]@{name='08:00 PM';value='08:00 PM'}
    [pscustomobject]@{name='08:15 PM';value='08:15 PM'}
    [pscustomobject]@{name='08:30 PM';value='08:30 PM'}
    [pscustomobject]@{name='08:45 PM';value='08:45 PM'}

    [pscustomobject]@{name='09:00 PM';value='09:00 PM'}
    [pscustomobject]@{name='09:15 PM';value='09:15 PM'}
    [pscustomobject]@{name='09:30 PM';value='09:30 PM'}
    [pscustomobject]@{name='09:45 PM';value='09:45 PM'}
	
	[pscustomobject]@{name='10:00 PM';value='10:00 PM'}
    [pscustomobject]@{name='10:15 PM';value='10:15 PM'}
    [pscustomobject]@{name='10:30 PM';value='10:30 PM'}
    [pscustomobject]@{name='10:45 PM';value='10:45 PM'}

    [pscustomobject]@{name='11:00 PM';value='11:00 PM'}
    [pscustomobject]@{name='11:15 PM';value='11:15 PM'}
    [pscustomobject]@{name='11:30 PM';value='11:30 PM'}
    [pscustomobject]@{name='11:45 PM';value='11:45 PM'}
	
	)



#New-PSDrive JD JAMS localhost -ErrorAction SilentlyContinue
New-PSDrive JD -PSProvider JAMS -Root localhost -ErrorAction SilentlyContinue

#Main Window
$jobs = (Get-ChildItem -Path JD:\resources).Name
$main_form = New-Object System.Windows.Forms.Form
$main_form.Text ='Resource Maintenance Tool'
$main_form.Width = 600
$main_form.Height = 400
$main_form.AutoSize = $true
$main_form.BackColor = "AntiqueWhite"


#Resource_Text on GUI
New-Object System.Drawing.Point(500,40)
$resource_lbl = New-Object System.Windows.Forms.Label
$resource_lbl.Text = "Resource Name:"
$resource_lbl.Location  = New-Object System.Drawing.Point(11,15)
$resource_lbl.AutoSize = $true

#Begin Maintenance_Text on GUI
$begin_main_lbl = New-Object System.Windows.Forms.Label
$begin_main_lbl.Text = "Begin Maintenance:"
$begin_main_lbl.Location  = New-Object System.Drawing.Point(11,40)
$begin_main_lbl.AutoSize = $true

#Submit_Text on GUI
$SubmitButton = New-Object System.Windows.Forms.Button
$SubmitButton.Location = New-Object System.Drawing.Size(100,400)
$SubmitButton.Size = New-Object System.Drawing.Size(120,23)
$SubmitButton.Text = "Submit"
$SubmitButton.Add_Click({submit_btn_Click})

#Cancel_Text on GUI
$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Size(200,400)
$CancelButton.Size = New-Object System.Drawing.Size(120,23)
$CancelButton.Text = "Cancel"
$CancelButton.Add_Click({cancel_btn_Click})

#End Maintenance_Text on GUI
$end_main_lbl = New-Object System.Windows.Forms.Label
$end_main_lbl.Text = "End Maintenance:"
$end_main_lbl.Location  = New-Object System.Drawing.Point(11,80)
$end_main_lbl.AutoSize = $true

#Resource_Combobox on GUI
$resourceBox = New-Object System.Windows.Forms.ComboBox
$resourceBox.Width = 300
$resourceBox.datasource=$jobs
$resourceBox.DisplayMember = "Name"
$resourceBox.Location  = New-Object System.Drawing.Point(125,10)

#Start_Time_Combobox on GUI
$stime = New-Object System.Windows.Forms.ComboBox
$stime.Width = 80
$stime.Location  = New-Object System.Drawing.Point(250,40)
$stime.DataSource = $combo_start_time_DS 
$stime.DisplayMember = 'name'

#End_Time_Combobox on GUI
$etime = New-Object System.Windows.Forms.ComboBox
$etime.Width = 80
$etime.Location  = New-Object System.Drawing.Point(250,80)
$etime.DataSource =  $combo_end_time_DS
$etime.DisplayMember = 'name'

#Begin_Main Dropdown Content
$DatePicker_begin_edit_lbl = New-Object System.Windows.Forms.Label
$DatePicker_begin_edit_lbl.Size ='85,23'
$DatePicker_begin_edit_lbl.Location  = New-Object System.Drawing.Point(125,40)
$DatePicker_begin_edit_lbl.BackColor = [System.Drawing.color]::white
$DatePicker_begin_edit_lbl.text = $DISPLAY_NULL

#End_Main Dropdown Content
$DatePicker_end_edit_lbl = New-Object System.Windows.Forms.Label
$DatePicker_end_edit_lbl.Location  = New-Object System.Drawing.Point(125,80)
$DatePicker_end_edit_lbl.size = '85,23'
$DatePicker_end_edit_lbl.BackColor = [System.Drawing.color]::white
$DatePicker_end_edit_lbl.text = $DISPLAY_NULL

#error label
$message_lbl = New-Object System.Windows.Forms.Label
$message_lbl.Location  = New-Object System.Drawing.Point(50,350)
$message_lbl.size = '500,23'
$message_lbl.BackColor = [System.Drawing.color]::white
$message_lbl.ForeColor = [System.Drawing.color]::red
$message_lbl.text = ""
$message_lbl.BackColor = "AntiqueWhite"

#confirm label, Spare Box
$confirm_lbl = New-Object System.Windows.Forms.Label
$confirm_lbl.Location  = New-Object System.Drawing.Point(50,325)
$confirm_lbl.size = '500,23'
$confirm_lbl.BackColor = [System.Drawing.color]::white
$confirm_lbl.ForeColor = [System.Drawing.color]::red
$confirm_lbl.text = ""
$confirm_lbl.BackColor = "AntiqueWhite"

#Calendar_Begin_Maintenance Icon Image
$DatePicker_begin_lbl = New-Object System.Windows.Forms.Label
$DatePicker_begin_lbl.BackgroundImage = [System.drawing.image]::FromFile('C:\Users\DB8.admin\Desktop\Project_Resource_test\images\CalendarPic.gif')
$DatePicker_begin_lbl.Size = '23,23'
$DatePicker_begin_lbl.Location  = New-Object System.Drawing.Point(225,40)
$DatePicker_begin_lbl.AutoSize = $true
$DatePicker_begin_lbl.text = "      "
$DatePicker_begin_lbl.Add_Click({datepicker_begin_lbl_Click})

#Calendar_End_Maintenance Icon Image
$DatePicker_end_lbl = New-Object System.Windows.Forms.Label
$DatePicker_end_lbl.BackgroundImage = [System.drawing.image]::FromFile('C:\Users\DB8.admin\Desktop\Project_Resource_test\images\CalendarPic.gif')
$DatePicker_end_lbl.Size = '23,23'
$DatePicker_end_lbl.Location  = New-Object System.Drawing.Point(225,80)
$DatePicker_end_lbl.AutoSize = $true
$DatePicker_end_lbl.text =  "      "   
$DatePicker_end_lbl.Add_Click({datepicker_end_lbl_Click})
###

#------------------------------------------------------------------------------
#Form Control
$main_form.Controls.Add($resource_lbl)
$main_form.Controls.Add($begin_main_lbl)
$main_form.Controls.Add($end_main_lbl)
$main_form.Controls.Add($resourceBox)
$main_form.Controls.Add($resourceBox_lbl)
$main_form.Controls.Add($bmain)
$main_form.Controls.Add($emain)
$main_form.Controls.Add($stime)
$main_form.Controls.Add($etime)
$main_form.Controls.Add($DatePicker_begin_edit_lbl)
$main_form.Controls.Add($DatePicker_end_edit_lbl)
$main_form.Controls.Add($DatePicker_begin_lbl)
$main_form.Controls.Add($DatePicker_end_lbl)
$main_form.Controls.Add($message_lbl)
$main_form.Controls.Add($confirm_lbl)
$main_form.Controls.Add($SubmitButton)
$main_form.Controls.Add($CancelButton)

$main_form.ShowDialog()


[datetime] $mydate = get-date
$nd = $mydate.tostring("MM/dd/yyyy")
$nd 