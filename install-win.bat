@echo off

net session >nul 2>&1
if not %errorLevel% == 0 (
  echo Inadequate permissions. Try to Run as administrator.
  pause
  exit /b
)

if exist "%ProgramFiles(x86)%\PEBL" goto pfx86
if exist "%ProgramFiles(x86)%\PEBL2" goto pfx86_2
if exist "%ProgramFiles%\PEBL" goto pf
if exist "%ProgramFiles%\PEBL2" goto pf_2
else (
  echo PEBL should first be installed in the appropriate Program Files folder.
  pause
  exit /b
)

:pfx86
set pf=%ProgramFiles(x86)%
set pebl="%pf%\PEBL\bin\pebl.exe"
goto set_alex

:pfx86_2
set pf=%ProgramFiles(x86)%
set pebl="%pf%\PEBL2\bin\pebl2.exe"
goto set_alex

:pf
set pf=%ProgramFiles%
set pebl="%pf%\PEBL\bin\pebl.exe"
goto set_alex

:pf_2
set pf=%ProgramFiles%
set pebl="%pf%\PEBL2\bin\pebl2.exe"
goto set_alex

:set_alex
set alex_dir="%pf%\alex\"
setx path "%PATH%;%alex_dir:"=%"
set wd=%~dp0

:: copy *some stuff* to alex_dir
FOR %%B IN (%wd%alex*) ^
DO xcopy "%%B" %alex_dir% /i/o/-y
FOR %%F IN (Examples, Library) ^
DO xcopy "%wd%%%F" %alex_dir%%%F\ /s/i/o/-y
xcopy "%wd%README.md" %alex_dir% /i/o/-y
set wd=%~dp0Docs\
FOR %%D IN (%wd%*.pdf, %wd%*.html, %wd%Roadmap*) ^
DO xcopy "%%D" %alex_dir% /i/o/-y

:: dub alex and alex-init PBL files
cd %alex_dir%
ren alex alex.pbl
ren alex-init alex-init.pbl
ren alex-manual alex-manual.pbl

:: write .bat files for alex, alex-init, alex-manual
( echo @echo off
  echo %pebl% "%alex_dir:"=%alex.pbl" %%1 %%2 --fullscreen
) > alex.bat
( echo @echo off
  echo %pebl% "%alex_dir:"=%alex-init.pbl" %%1 %%2
) > alex-init.bat
( echo @echo off
  echo %pebl% "%alex_dir:"=%alex-manual.pbl"
) > alex-manual.bat
