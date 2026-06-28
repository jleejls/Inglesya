@echo off
setlocal EnableExtensions EnableDelayedExpansion

REM ============================================================
REM  PNG Detector - Whole Program Scan
REM
REM  Put this BAT file in the main program folder.
REM  It does NOT change anything.
REM
REM  It checks for:
REM    1. Actual files ending in .png
REM    2. Code/text files that still mention .png
REM
REM  Results are written to:
REM    PNG_SCAN_RESULTS.txt
REM ============================================================

cd /d "%~dp0"

set "REPORT=PNG_SCAN_RESULTS.txt"

echo PNG Scan Results > "%REPORT%"
echo Folder scanned: %CD% >> "%REPORT%"
echo Date/time: %DATE% %TIME% >> "%REPORT%"
echo. >> "%REPORT%"

echo ============================================================
echo  PNG Detector - Whole Program Scan
echo ============================================================
echo.
echo Scanning folder:
echo %CD%
echo.
echo This will NOT change anything.
echo.

echo ============================================================ >> "%REPORT%"
echo ACTUAL .PNG FILES FOUND >> "%REPORT%"
echo ============================================================ >> "%REPORT%"

set "PNG_FILE_COUNT=0"

for /R %%F in (*.png) do (
    set /A PNG_FILE_COUNT+=1
    echo %%~fF >> "%REPORT%"
)

if "%PNG_FILE_COUNT%"=="0" (
    echo None found. >> "%REPORT%"
)

echo. >> "%REPORT%"
echo ============================================================ >> "%REPORT%"
echo TEXT/CODE FILES THAT MENTION .PNG >> "%REPORT%"
echo ============================================================ >> "%REPORT%"

set "PNG_TEXT_COUNT=0"

for /R %%F in (*.html *.htm *.js *.css *.json *.txt *.bat) do (
    findstr /I /C:".png" "%%~fF" >nul 2>nul
    if not errorlevel 1 (
        set /A PNG_TEXT_COUNT+=1
        echo. >> "%REPORT%"
        echo FILE: %%~fF >> "%REPORT%"
        findstr /N /I /C:".png" "%%~fF" >> "%REPORT%"
    )
)

if "%PNG_TEXT_COUNT%"=="0" (
    echo None found. >> "%REPORT%"
)

echo. >> "%REPORT%"
echo ============================================================ >> "%REPORT%"
echo SUMMARY >> "%REPORT%"
echo ============================================================ >> "%REPORT%"
echo Actual .png files found: %PNG_FILE_COUNT% >> "%REPORT%"
echo Text/code files mentioning .png: %PNG_TEXT_COUNT% >> "%REPORT%"

echo ============================================================
echo  Finished.
echo ============================================================
echo.
echo Actual .png files found: %PNG_FILE_COUNT%
echo Text/code files mentioning .png: %PNG_TEXT_COUNT%
echo.
echo Report created:
echo %CD%\%REPORT%
echo.
echo Open PNG_SCAN_RESULTS.txt to see the details.
echo.
pause
endlocal
