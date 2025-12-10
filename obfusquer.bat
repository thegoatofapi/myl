@echo off
echo ========================================
echo Obfuscation du script.ps1
echo ========================================
echo.
cd /d "%~dp0"
powershell -ExecutionPolicy Bypass -File "%~dp0obfusquer.ps1"
echo.
echo Termine!
pause

