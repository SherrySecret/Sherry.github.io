@echo off
echo ========================================
echo [The Opeartions of This Dir]:  
echo	1.dev
echo	2.build
echo	3.push
echo	4.pull

set /p n=enter the operation number: 

if "%n%"=="1"	hexo s
if "%n%"=="2"	hexo g
if "%n%"=="3"	call :1
if "%n%"=="4"	git pull

pause
goto :eof

:1
set /p commit=enter the commit for this push: 
git add .
git commit -m "%commit%"
git push