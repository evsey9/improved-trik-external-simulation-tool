@echo off
REM Usage: win_scr.cmd <full path to dir with program> <relative path to js file> <relative path to dir with fields> <full path to dir with TRIK studio>
for /f "tokens=2 delims=:." %%x in ('chcp') do set cp=%%x
chcp 1251>nul
SET TRIK_DIR=%4
SET PROGRAM_PATH=%1
SET FIELDS_PATH=%1\%3
echo %FIELDS_PATH%
SET DEFAULT_PROJECT=%PROGRAM_PATH%\default.qrs
IF EXIST %DEFAULT_PROJECT% (
	SET PROJECT_TYPE=xml
) ELSE (
	SET PROJECT_TYPE=qrs
)
SET mydir=%cd%
pushd "%FIELDS_PATH%"

for %%f in (*.%PROJECT_TYPE%) do (
	IF "%PROJECT_TYPE%"=="xml" (
		echo "%%f"
		"%TRIK_DIR%\patcher.exe" -f %%f "%DEFAULT_PROJECT%"
		"%TRIK_DIR%\patcher.exe" -s "%mydir%\%2" "%DEFAULT_PROJECT%"
		"%TRIK_DIR%\2D-model.exe" --mode script "%DEFAULT_PROJECT%"
	)
	IF "%PROJECT_TYPE%"=="qrs" (
		echo "%%f"
		"%TRIK_DIR%\patcher.exe" -s "%mydir%\%2" %%f 
		"%TRIK_DIR%\2D-model.exe" --mode script %%f
	)
)
chcp %cp%>nul
popd
del lastCode.py