cd /d  E:\Aldric\desktop\blog
title HexoGoGoGo
cd 
call git config --global user.email "2746763180@qq.com"
call git config --global user.name "Parsifa1"
git config --global core.autocrlf false 
cls
call hexo clean
call hexo g
call hexo d
echo
pause