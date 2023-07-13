@echo off
cd D:\Aldric\desktop\blog
call git config --global user.email "2746763180@qq.com"
call git config --global user.name "Parsifa1"
git add .
git commit -m "hexobackup"
git push
pause