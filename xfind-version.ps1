$PackageBase = "$env:USERPROFILE\.nuget\packages\specialtydataarchive_oci.Core"

# Get all directories inside PackageBase (version numbers)
$VersionDirs = Get-ChildItem -Path $PackageBase -Directory | Sort-Object Name -Descending

# Check if any versions exist
if ($VersionDirs.Count -eq 0) {
    Write-Output "No version folders found." | Out-File -FilePath "find-version-log.txt"
    exit 1
}

# Get the latest version folder
$LatestVersion = $VersionDirs[0].Name
$LatestVersionPath = $VersionDirs[0].FullName

# Log output
Write-Output "Latest Version: $LatestVersion" | Out-File -FilePath "find-version-log.txt"
Write-Output "Full Path: $LatestVersionPath" | Out-File -Append -FilePath "find-version-log.txt"

# Print result to console
Write-Output "Latest Version Found: $LatestVersion"
Write-Output "Full Path: $LatestVersionPath"
