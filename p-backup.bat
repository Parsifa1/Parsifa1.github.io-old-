@echo off
cd E:\Aldric\desktop\blog
call git config --global user.email "2746763180@qq.com"
call git config --global user.name "Parsifa1"
git add .
set /p name=input commit:
echo please wait
git commit -m "%name%"
git push
pause