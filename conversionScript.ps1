<#
    * STASS CONVERSION *
    Date Realse: 07/26/2024
    Date Modify: 08/09/2024
    Description: STASS Conversion SCRIPT for AUDIOLOGY

    Changes: 
        - Udate "Auto" grab user name
        - Add in Auto file creation with Date
        - Update : Add date in path & renaming old hears 
        - Update : Automaticall move to designated week folder

#>

# S:\Fleet Medicine\BLDG 1523\Audiology\STASS CONVERSION 
# Auto Grab the user name
$getUserName = $env:USERNAME
$rawData = "C:\Users\" + $getUserName.ToString() + "\Downloads\HEARS.txt"
$getRawData = GC -Path $rawData
$oldNamePath = "C:\Users\" + $getUserName.ToString() + "\Downloads\HEARS.txt"

$getDate = Get-Date -Format 'yyyy-MM-dd'
$newFileName = "HEARS_" + $getDate.ToString() + ".txt"
$reNameOldFile = "HEARS_old_" + $getDate.ToString() + ".txt"
$path = "C:\Users\" + $getUserName + "\Downloads\$newFileName"


$processData = @()

foreach ($line in $getRawData) {
    #split line into fields (assuming delimiter, eg. commas)
    $fields = $line -split ','

    #convert name and date fields
    #Extracting Each fields
    $id = $fields[0].Trim()
    $firstName = $fields[1].Trim().ToUpper()
    $lastName  = $fields[2].Trim().ToUpper()
    $initial   = $fields[3].Trim().ToUpper()
    $date      = [datetime]::ParseExact($fields[4].Trim(), 'yyyyMMdd', $null).ToString('MM/dd/yyyy')
    $sex       = $fields[5].Trim().ToUpper()
    $dodComp   = $fields[6].Trim().ToUpper()
    $serComp   = $fields[7].Trim().ToUpper()
    $payGrade  = $fields[8].Trim().ToUpper()

    #additional Line that added after ? it part of the MS Access ...
    $additionalLine = ""

    $processedLine = "$id,$firstName,$lastName,$initial,$date,$sex,$dodComp,$serComp,$payGrade,$additionalLine"

    # Write-Host "$processedLine"
    
    #add the line to the array
    $processData+=$processedLine

    
   
} 
  
    # Rename-Item -Path $oldNamePath -NewName $newNamePath
    Remove-Item -Path $oldNamePath # Removing - Hears txt file
    $processData | Out-File $path # Create new txt | over-write same txt file

# Create folder path 
$folderPath = ""
$currentDate = (Get-Date).DayOfWeek

# map match date with folders 
    # ex. currentdate = Monday then "Monday" {"folder"}
$targetFolder = switch ($currentDate){
    "Monday" {"a Monday"}
    "Tuesay" {"b Tuesday"}
    "Wednesday" {"c Wednesday"}
    "Thursday" {"d Thursday"}
    "Friday" {"e Friday"}
}

# Join the folderpath with the match date and its folder
$targetPath = Join-Path -Path $folderPath -ChildPath $targetFolder
# Then copy the item to the target "date" folder
Copy-Item -Path $path -Destination $targetPath
