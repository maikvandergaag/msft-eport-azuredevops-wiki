[CmdletBinding()]
Param (
    [Parameter(Mandatory = $false, Position = 0)][string]$FolderName = "wiki"
)

function ProcessWikiFolder { 
    Param (
        [Parameter(Mandatory = $true, Position = 0)][string]$Folder,
        [Parameter(Mandatory = $true, Position = 0)][string]$OutputFile
    )
    Write-Output "## start processing folder: $($Folder)" 
    $orderItem = Get-ChildItem $Folder -File -Force | Where-Object { $_.Extension -eq ".order" }
          
    if ($orderItem) {
        $orderItemLines = Get-Content $orderItem
      
        foreach ($line in $orderItemLines) {
            Write-Output "### Processing file: $($line)" 
      
            $filename = "$($line).md" 
            $file = Get-ChildItem $Folder -File $filename
                  
            if ($file) {
                $content = Get-Content $file
      
                "# $($line)" | Out-File -FilePath $OutputFile -Append
                "" | Out-File -FilePath $OutputFile -Append
      
                $content | Out-File -FilePath $outputFile -Append
      
                "" | Out-File -FilePath $OutputFile -Append
                "" | Out-File -FilePath $OutputFile -Append
                "" | Out-File -FilePath $OutputFile -Append
            }
      
                  
            $possiblePath = "$($folder)$($line)\"
      
            if (Test-Path $possiblePath) {
                ProcessWikiFolder -Folder $possiblePath -OutputFile $OutputFile
            }
        }
    }
    else {
        Write-Output "order file does not exits"
    }
}

BEGIN {
    Write-Host "Starting to create a single page wiki"
}
PROCESS {           
    $path = "$(System.DefaultWorkingDirectory)/$($FolderName)"
    if ($path -notmatch '\\$') { $path += '/' }
    
    $resultFile = $path + "singlepage-wiki.md"
      
    Write-Host "Writing information to the following file $($resultfile)"
    Out-File -FilePath $resultFile
      
    ProcessWikiFolder -Folder $path -outputFile $resultFile
}
END {
    Write-Host "Done creating a single page wiki"
}