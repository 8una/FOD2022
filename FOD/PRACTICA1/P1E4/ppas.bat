@echo off
SET THEFILE=c:\users\bar\fod\practi~1\p1e4\ej4.exe
echo Linking %THEFILE%
c:\dev-pas\bin\ldw.exe  -s   -b base.$$$ -o c:\users\bar\fod\practi~1\p1e4\ej4.exe link.res
if errorlevel 1 goto linkend
goto end
:asmend
echo An error occured while assembling %THEFILE%
goto end
:linkend
echo An error occured while linking %THEFILE%
:end
