@echo off
set /p name=input pages name:
echo please wait
cd C:\Users\Parsifal\Desktop\blog
call hexo new null %name%
start C:\Users\Parsifal\Desktop\blog\source\_posts\%name%.md
pause