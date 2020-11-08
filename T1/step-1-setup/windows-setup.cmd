@echo off
:: The `@echo off` command ensures that the commands that are run during this script are not displayed on the command console
setlocal
:: The `setLocal` command ensures that any variables that are set do not exist after the script exits.

:: The author disclaims copyright to this source code.  In place of
:: a legal notice, here is a blessing:
::    May you do good and not evil.
::    May you find forgiveness for yourself and forgive others.
::    May you share freely, never taking more than you give.


echo Checking system 32 or 64 bit...
reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT
if %OS%==32BIT (set cygwinUrl=https://cygwin.com/setup-x86.exe
	echo 32 Bit system found
	set cygwinPath=C:\cygwin)
if %OS%==64BIT (set cygwinUrl=https://cygwin.com/setup-x86_64.exe
	echo 64 Bit system found
	set cygwinPath=C:\cygwin64)

echo Downloading cygwin setup...
if not exist %USERPROFILE%\Downloads mkdir %USERPROFILE%\Downloads
:: download Cygwin setup application
bitsadmin /transfer mydownloadjob /download /priority normal "%cygwinUrl%" "%USERPROFILE%\Downloads\cygwin-setup.exe" > NUL
echo Download completed.

echo Checking if cygwin is installed...
:: if cygwin isn't installed then install it
if not exist %cygwinPath% (
	echo Will run cygwin installer after any key. Install with defaults.
	pause
	%USERPROFILE%\Downloads\cygwin-setup.exe
	echo Wait to click any key until after setup is complete.
	pause
	)


:: double-check that Cygwin was installed to the correct path
if not exist %cygwinPath%\bin echo %cygwinPath%\bin not found. Check Cygwin installation path. && exit /B

:: check to see that the environmental variables have the cygwin path
echo %PATH% | find /i "%cygwinPath%\bin" > nul && set CYGWIN_PATH_BIN_SET=TRUE || set CYGWIN_PATH_BIN_SET=
if defined CYGWIN_PATH_BIN_SET (
	echo Cygwin\bin found in system PATH.
	) else (echo Adding '%cygwinPath%\bin' to PATH.
	setx /M PATH "%PATH%;%cygwinPath%\bin")

:: BUG, Does not check the Path length first to ensure that
:: the Cygwin bin path can be added.
:: TODO: Check the Path length to see if
:: adding would exceed the max length. If so then 
:: alert the user to edit the path first then run again.

:: then install Git, TCL, Expect, GCC and other developer programs
echo Updating Cygwin to latest and installing development programs...
%USERPROFILE%\Downloads\cygwin-setup.exe -qvg -P python27 -P python27-devel -P python27-numpy -P python27-pip -P python36 -P python36-devel -P python36-numpy -P python36-pip -P tcl -P expect -P git -P gcc-g++ -P make -P astyle -P diffutils -P libmpfr-devel -P libgmp-devel -P libmpc-devel -P cmake -P gdb

pause

goto :eof
