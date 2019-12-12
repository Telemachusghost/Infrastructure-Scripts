<#
This script only moves files that are older than a given date.
#>

## Find the source files
$dateToKeep = Read-Host "Enter a date (MM-DD-YYYY). Any records less than this date will be moved to the destination folder."
$dateToKeep = Get-Date $dateToKeep
$srcFolder = Read-Host "Enter source folder to move: "
$destFolder = Read-Host "Enter a destination folder: "
  

Get-ChildItem $srcFolder -Recurse *.txt |  foreach {
  if ($_.LastWriteTime -lt $dateToKeep) {
    ## Remove the original  root folder

    $split = $_.Fullname  -split '\\'

    $DestFile =  $split[1..($split.Length - 1)] -join '\' 

    ## Build the new  destination file path

    $DestFile =  $destFolder + '\\' + $DestFile

    ## Copy-Item won't  create the folder structure so we have to 

    ## create a blank file  and then overwrite it

    $null = New-Item -Path  $DestFile -Type File -Force

    Copy-Item -Path  $_.FullName -Destination $DestFile -Force
  } else {
    # Behaviour for not copying a file
  }  
}
