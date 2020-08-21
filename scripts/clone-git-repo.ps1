[CmdletBinding()]
Param (
    [Parameter(Mandatory = $true, Position = 0)][string]$Repo,
    [Parameter(Mandatory = $true, Position = 1)][string]$DevOpsPat,
    [Parameter(Mandatory = $false, Position = 2)][string]$FolderName = "wiki"
)

BEGIN {
    Write-Host "Starting to clone git repository - $($Repo)"

    $folder = "$(System.DefaultWorkingDirectory)/$($FolderName)"    
    Write-Host "# Repository will be cloned in: $folder"

    $env:GIT_REDIRECT_STDERR = '2>&1'
    git config --global user.name "MSFTPlayground"
}
PROCESS {      
    $repoWithAuth = $Repo -Replace "://", ("://{0}@" -f $DevOpsPat)
    
    git clone $repoWithAuth $folder --verbose
}
END {
    Write-Host "Done cloning git repository"
}