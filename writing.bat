@echo off
set /p name=input pages name:
echo please wait
cd E:\Aldric\desktop\blog
call hexo new null %name%
start E:\Aldric\desktop\blog\source\_posts\%name%.md
pause