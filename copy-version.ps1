$PackageBase = "$env:USERPROFILE\.nuget\packages\specialtydataarchive_oci.Core"

# Find latest version
$VersionDirs = Get-ChildItem -Path $PackageBase -Directory | Sort-Object Name -Descending | Select-Object -First 1
if (-not $VersionDirs) {
    Write-Output "No version folders found." | Out-File -FilePath "copy-log.txt"
    exit 1
}

# Get latest version path
$LatestPropsPath = "$($VersionDirs.FullName)\build\Version.props"
if (-not (Test-Path $LatestPropsPath)) {
    Write-Output "Version.props not found in $($VersionDirs.FullName)" | Out-File -FilePath "copy-log.txt"
    exit 1
}

# Copy Version.props to solution root
Copy-Item -Path $LatestPropsPath -Destination "$PSScriptRoot\" -Force
Write-Output "Copied $LatestPropsPath to $PSScriptRoot" | Out-File -FilePath "copy-log.txt"
