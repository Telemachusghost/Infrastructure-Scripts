<#
This script copies files while maintaining their folder structure
#>

## Find the source files

  $srcFolder = Read-Host "Enter src folder to copy: "
  $destFolder = Read-Host "Enter a dest folder: "

  Get-ChildItem $srcFolder -Recurse *.txt |  foreach {

    ## Remove the original  root folder

    $split = $_.Fullname  -split '\\'

    $DestFile =  $split[1..($split.Length - 1)] -join '\' 

    ## Build the new  destination file path

    $DestFile =  $destFolder + '\\' + $DestFile

    ## Copy-Item won't  create the folder structure so we have to 

    ## create a blank file  and then overwrite it

    $null = New-Item -Path  $DestFile -Type File -Force

    Copy-Item -Path  $_.FullName -Destination $DestFile -Force
  }
