@echo off
set "LOGFILE=%~dp0SystemCheck_Log.txt"

echo =========================================== > "%LOGFILE%"
echo   SYSTEM REPAIR & MALWARE SCAN LOG         >> "%LOGFILE%"
echo   Date/Time: %DATE% %TIME%                 >> "%LOGFILE%"
echo =========================================== >> "%LOGFILE%"

echo Processing... Check %LOGFILE% for details.

:: 1. Malware Scan
echo [1/3] Updating and Scanning for Malware...
echo --- Microsoft Defender Scan --- >> "%LOGFILE%"
"C:\Program Files\Windows Defender\MpCmdRun.exe" -SignatureUpdate >> "%LOGFILE%" 2>&1
"C:\Program Files\Windows Defender\MpCmdRun.exe" -Scan -ScanType 1 >> "%LOGFILE%" 2>&1
echo Defender Scan Task Finished. >> "%LOGFILE%"

:: 2. DISM Repair
echo [2/3] Repairing System Image...
echo --- DISM RestoreHealth --- >> "%LOGFILE%"
dism /online /cleanup-image /restorehealth >> "%LOGFILE%" 2>&1

:: 3. SFC Scan
echo [3/3] Repairing System Files...
echo --- SFC Scannow --- >> "%LOGFILE%"
sfc /scannow >> "%LOGFILE%" 2>&1

echo. >> "%LOGFILE%"
echo Task Completed at %TIME% >> "%LOGFILE%"
echo =========================================== >> "%LOGFILE%"

echo.
echo All tasks finished. Results saved to:
echo %LOGFILE%
pause