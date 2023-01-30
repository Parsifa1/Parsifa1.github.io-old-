---
title: VSCode关于C++和Python相关的简单配置
date: 2023-01-30 18:13:22
layout: 教程
tags: 编程
categories: 教程
index_img:  https://pic.imgdb.cn/item/63d79f26face21e9ef1a5503.jpg
---

![效果展示](https://pic.imgdb.cn/item/63d7a080face21e9ef1cd5a8.jpg)

众多周知，VSCode是一个非常好用的编辑器，支持很多的语言，而且比较轻量化。特别是对于C/C++，无需拘泥于工程这个概念，对于只写小型程序的大学生来说比较方便。但是对于C++和Python的配置是非常麻烦的，这里记录一下我自己的配置过程，希望能够帮助到大家。
<!--more-->

## C++配置

### 安装C/C++插件

首先，我们需要安装C/C++插件，这个插件是用来支持C++的。在插件中搜索c++

![](https://pic.imgdb.cn/item/63d79b3eface21e9ef133336.jpg)

选择这个下载即可。

### 安装MinGW

MinGW是一个C/C++编译器，它可以在Windows上运行，这里我们需要安装
MinGW，然后配置环境变量。

### 原生支持

你可以选择原生支持的cp配置方法，相对的，需要配置多个json文件，同时也可以使用.coderunner插件，即开即用，还能运行多种语言，方法如下：

#### 配置C/C++插件

安装完MinGW之后，我们需要配置C/C++插件，这里我们需要配置一下
`c_cpp_properties.json`文件，这个文件是用来配置C/C++插件的，这里
我们需要配置一下`includePath`和`browse.path`，这两个参数分别是
头文件的路径和库文件的路径，这里我们需要配置一下MinGW的路径，这里
我是安装在`C:\MinGW`下面的，所以我的配置如下：

```json
{
    "configurations": [
        {
            "name": "Win32",
            "includePath": [
                "${workspaceFolder}/**",
                "C:/MinGW/include"
            ],
            "defines": [],
            "compilerPath": "C:/MinGW/bin/gcc.exe",
            "cStandard": "c11",
            "cppStandard": "c++17",
            "intelliSenseMode": "gcc-x64"
        }
    ],
    "version": 4
}
```

#### 配置tasks.json

这里我们需要配置一下`tasks.json`文件，这个文件是用来配置编译器的，

```json
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "C/C++: g++.exe build active file",
            "type": "shell",
            "command": "C:/MinGW/bin/g++.exe",
            "args": [
                "-g",
                "${file}",
                "-o",
                "${fileDirname}\\${fileBasenameNoExtension}.exe"
            ],
            "options": {
                "cwd": "${workspaceFolder}"
            },
            "problemMatcher": [
                "$gcc"
            ],
            "group": {
                "kind": "build",
                "isDefault": true
            }
        }
    ]
}
```

#### 配置launch.json


这里我们需要配置一下`launch.json`文件，这个文件是用来配置调试器的，

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "C++ Launch",
            "type": "cppvsdbg",
            "request": "launch",
            "program": "${fileDirname}\\${fileBasenameNoExtension}.exe",
            "args": [],
            "stopAtEntry": false,
            "cwd": "${workspaceFolder}",
            "environment": [],
            "externalConsole": false,
            "preLaunchTask": "C/C++: g++.exe build active file"
        }
    ]
}
```
### 使用.coderunner插件配置

你也可以选择使用coderunner插件来配置。

![](https://pic.imgdb.cn/item/63d79c08face21e9ef14b98f.jpg)

只需在setting.json中配置一下即可。

```json
{
    "code-runner.executorMap": {
        "cpp": "cd $dir && g++ '$fileName' -o bin\\'$fileNameWithoutExt' -fexec-charset=gbk && .\\bin\\'$fileNameWithoutExt'",
    }
}
```

我采用的是自己的配置，在cpp文件的目录下生创建了bin文件夹，然后将编译好的文件放在bin文件夹下，方便整理。


## Python配置

### 安装Python插件

首先，我们需要安装Python插件，这个插件是用来支持Python的，当然，如果你
只是想用VSCode来写C++，那么这个插件就不需要安装了。

![](https://pic.imgdb.cn/item/63d79cedface21e9ef1653fb.jpg)

### 配置Python插件

安装完Python插件之后，我们需要配置Python插件，这里我们需要配置一下
`settings.json`文件，这个文件是用来配置Python插件的，这里我们需要配置
一下Python的路径，这里我是安装在`C:\Python37`下面的，所以我的配置如下：

```json
{
    "python.pythonPath": "C:/Python37/python.exe"
}
```

同样的，使用的.coderunner插件配置之后，就可以直接编译执行了。
无需单独配置。

## 参考

[VSCode C++配置](https://blog.csdn.net/qq_41855420/article/details/103201100)

[VSCode Python配置](https://blog.csdn.net/qq_41855420/article/details/103201100)
