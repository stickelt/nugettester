@echo off
:: Ensure PowerShell runs from a known location
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File "%~dp0copy-version.ps1"

:: Check for errors
if %errorlevel% neq 0 (
    echo PowerShell script failed! Check logs.
    exit /b %errorlevel%
)

echo Successfully copied Version.props!
