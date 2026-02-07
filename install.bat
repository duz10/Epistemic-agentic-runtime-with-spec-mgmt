@echo off
REM ELCS Install Script for Windows CMD
REM Redirects to PowerShell script

SET SCRIPT_DIR=%~dp0

if "%~1"=="" (
    echo Error: Please provide a target project directory
    echo.
    echo Usage: install.bat C:\path\to\your\project
    exit /b 1
)

powershell -ExecutionPolicy Bypass -File "%SCRIPT_DIR%install.ps1" -TargetDir "%~1"
