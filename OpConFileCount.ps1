<#
Purpose: To see if a directory has X amount of files 
Syntax: OpConFileCount.ps1 -SourceDirectory "C:\ProgramData\OpConxps\temp\New folder" -Count 26  -Time 3
Note: Time is for how long do you want to wait on getting the file count
Written By: David Cornelius
Tested: 05/04/2022
ExitCode: 20 = Unable to reach the SourceDirectory Path
#>

param (
    [parameter(mandatory=$true)]
    [string]$SourceDirectory,
    [parameter(mandatory=$true)]
    [string]$Count,
    [parameter(mandatory=$true)]
    [string]$Time
)
 
$ErrorActionPreference = "Stop"

#Making sure we can reach the Directory
 if ((Test-Path $SourceDirectory)) 
    {
        Write-output [$(Get-Date)]:"Able to access $SourceDirectory"
    }
else
    {
        $rc = 20
        Write-output [$(Get-Date)]:"Unable to access $SourceDirectory"
        [Environment]::Exit($rc)
    }

#Starting File count
Write-output [$(Get-Date)]:"Starting File Count"
do
{
   $directoryInfo = Get-ChildItem "$SourceDirectory" | Measure-Object
   $directoryInfo.count
   start-sleep $Time
}
until ($directoryInfo.count -eq $Count)

Write-output [$(Get-Date)]:"Folder Now has $Count" 