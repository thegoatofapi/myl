@echo off
echo ========================================
echo Deobfuscation du script.ps1
echo ========================================
echo.
cd /d "%~dp0"
powershell -ExecutionPolicy Bypass -File "%~dp0deobfusquer.ps1"
echo.
echo Termine!
pause

