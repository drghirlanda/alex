@echo off

net session >nul 2>&1
if not %errorLevel% == 0 (
  echo Inadequate permissions. Try to Run as administrator.
  pause
  exit /b
)

set pf=%ProgramFiles%
set alex_dir=%pf%\alex\
setx path "%PATH%;%alex_dir%"
set wd=%~dp0

:: copy *some stuff* to alex_dir
FOR %%B IN (%wd%alex*) ^
DO xcopy "%%B" "%alex_dir%" /i/o/-y
FOR %%F IN (Examples, Library) ^
DO xcopy "%wd%%%F" "%alex_dir%%%F\" /s/i/o/-y
xcopy "%wd%README.md" "%alex_dir%" /i/o/-y
set wd=%~dp0Docs\
FOR %%D IN (%wd%*.pdf, %wd%*.html, %wd%Roadmap*) ^
DO xcopy "%%D" "%alex_dir%" /i/o/-y

:: dub alex and alex-init PBL files
cd %alex_dir%
ren alex alex.pbl
ren alex-init alex-init.pbl
ren alex-manual alex-manual.pbl

:: write .bat files for alex, alex-init, alex-manual
( echo @echo off
  echo "%pf%\PEBL\bin\pebl.exe" "%pf%\alex\alex.pbl" %%1 %%2 --fullscreen
) > alex.bat
( echo @echo off
  echo "%pf%\PEBL\bin\pebl.exe" "%pf%\alex\alex-init.pbl" %%1 %%2
) > alex-init.bat
( echo @echo off
  echo "%pf%\PEBL\bin\pebl.exe" "%pf%\alex\alex-manual.pbl"
) > alex-manual.bat
