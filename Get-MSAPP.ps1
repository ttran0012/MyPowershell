<#
    Description: This script targets APPX Package and Removes it. All Version of it...
        -Change the path for list of computers (If need to)
    Date: 08/07/2024 
    Change: Added an array "$storeAns" to store all result 
            - Change output to  Out-File so that it can override existing results
#>

# Get List of Computer
$getComputer = GC 'C:\Users\alt.tan.tran\Desktop\Scripts\Scripts\txt_file\get_MSAPPStore_Name.txt'
$storeAns =@()
$listOfApps = @(

  "Microsoft.RawImageExtension"
  # "Microsoft.WebMediaExtensions",
  # "Microsoft.WebpImageExtension"
  # "Microsoft.MSPaint"
  # "Microsoft.WindowsTerminal"
 #  "Microsoft.HEIFImageExtension",
 #  "Microsoft.Microsoft3DViewer",
  # "Microsoft.Print3D"
  #"Microsoft.ScreenSketch"
 #  "Microsoft.Microsoft3DViewer"
 #"Microsoft.VP9VideoExtensions"
  
)

ForEach ($computer in $getComputer){
    Write-Host "Processing $computer"


    #looping through $listOfApps (MS APPS)
    ForEach ($App in $listOfApps){
       
       Write-Host "Retreiving $App from $computer `n"

       # Invoke-Command to remove Appx Package for All users
      $result = Invoke-Command -ComputerName $computer -ScriptBlock{
        param($package)
        Get-AppxPackage  -Name $package -AllUsers | Select-Object Name, PackageFullName
       } -ArgumentList $App
       $storeAns+=$result

    } $storeAns | Out-File 'C:\Users\alt.tan.tran\Desktop\Scripts\Scripts\result_dump\get_MSAPPStore_Name_dump.txt'
    #closing remote Sesiion
   # Remove-PSSession -Session $session
    Write-Host "Completed Processing on $computer `n $result `n"
 }
