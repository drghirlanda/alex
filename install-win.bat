@echo off

net session >nul 2>&1
if not %errorLevel% == 0 (
  echo Inadequate permissions. Try to Run as administrator.
  pause
  exit /b
)

set pf=%ProgramFiles%
set alex_dir=%pf%\alex
setx path "%PATH%;%alex_dir%"

:: copy *everything* to alex_dir
xcopy %~dp0. "%alex_dir%" /e/i/o/-y

:: dub alex and alex-init PBL files
cd %alex_dir%
ren alex alex.pbl
ren alex-init alex-init.pbl

:: write .bat files for alex and alex-init
( echo @echo off
  echo "%pf%\PEBL\bin\pebl.exe" "%pf%\alex\alex.pbl" %%1 %%2 --fullscreen
) > alex.bat
( echo @echo off
  echo "%pf%\PEBL\bin\pebl.exe" "%pf%\alex\alex-init.pbl" %%1 %%2
) > alex-init.bat