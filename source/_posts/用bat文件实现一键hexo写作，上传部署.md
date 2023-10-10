---
title: 用bat文件实现一键hexo写作，上传部署
date: 2022-08-02 16:32:46
layout: 教程
tags: 网站
categories: 教程
index_img: https://i2.woh.to/2023/10/09/0578c1ba90cf0faf09fbb7f9aecb63e1aedc46616f9a0223.webp
---

![](https://i2.woh.to/2023/10/09/0578c1ba90cf0faf09fbb7f9aecb63e1aedc46616f9a0223.webp)

## 你首先需要已经完成基本hexo的部署！！

<!--more-->

---

1. 确保和github的连接方式为ssh，且设置passphrase为空  （**很重要！**

2. 确保没有其他小问题;

3. 祈祷自己不会遇到bug（不是

---

1.一键完成文章的命名：

> @echo off
> set /p name=input pages name:
> echo please wait
> cd C:\a\\b\blog
> call hexo new null %name%
> start C:\a\\b\blog\source\_posts\%name%.md
> pause

**其中的C:\a\b\blog需填入你自己博客的根目录，其他照旧**

![例子](https://s2.loli.net/2022/08/02/zsRQuxrcDhTiwSp.png)

输入需要的文章标题即可，会自动打开文章md文件，写作即可！

---

2.文章一键部署发布

> cd /d  C:\a\b\c\blog 
> title HexoGoGoGo
> cd 
> call hexo clean
> call hexo g
> call hexo d
> echo
> pause

**具体填入要求同上**

效果如下：

![例子](https://s2.loli.net/2022/08/02/ZIObvKweG8XyJAR.png)

# 有这两个批处理文件，hexo的使用就相对没那么繁杂啦！
