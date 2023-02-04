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

你可以选择原生支持的c++配置方法，相对的，需要配置多个json文件，同时也可以使用.coderunner插件，即开即用，还能运行多种语言，方法如下：

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
        { //这个大括号里是‘构建（build）’任务
            "label": "build", //任务名称，可以更改，不过不建议改
            "type": "shell", //任务类型，process是vsc把预定义变量和转义解析后直接全部传给command；shell相当于先打开shell再输入命令，所以args还会经过shell再解析一遍
            "command": "g++", //编译命令，这里是gcc，编译c++的话换成g++
            "args": [ //方括号里是传给gcc命令的一系列参数，用于实现一些功能
                "${file}", //指定要编译的是当前文件
                "-o", //指定输出文件的路径和名称
                "${fileDirname}\\bin\\${fileBasenameNoExtension}.exe", //承接上一步的-o，让可执行文件输出到源码文件所在的文件夹下的bin文件夹内，并且让它的名字和源码文件相同
                "-g", //生成和调试有关的信息
                "-Wall", // 开启额外警告
                "-Wno-unused-but-set-variable", // 关闭未使用变量的警告
                "-static-libgcc", // 静态链接libgcc
                "-static-libstdc++", // 静态链接libstdc++
                "-fexec-charset=GBK", // 生成的程序使用GBK编码，不加这一条会导致Win下输出中文乱码
            ],
            "group": { //group表示‘组’，我们可以有很多的task，然后把他们放在一个‘组’里
                "kind": "build", //表示这一组任务类型是构建
                "isDefault": true //表示这个任务是当前这组任务中的默认任务
            },
            "presentation": { //执行这个任务时的一些其他设定
                "echo": true, //表示在执行任务时在终端要有输出
                "reveal": "silent", //执行任务时是否跳转到终端面板，可以为always，silent，never
                "focus": false, //设为true后可以使执行task时焦点聚集在终端，但对编译来说，设为true没有意义，因为运行的时候才涉及到输入
                "panel": "new", //每次执行这个task时都新建一个终端面板，也可以设置为shared，共用一个面板，不过那样会出现‘任务将被终端重用’的提示，比较烦人
                "showReuseMessage": false, //设为false后，上面的‘任务将被终端重用’提示就不会出现了
                "close": false //设为true后，执行完这个task后会自动关闭终端面板
            },
            //"problemMatcher": "$gcc" //捕捉编译时编译器在终端里显示的报错信息，将其显示在vscode的‘问题’面板里
        },
        //修改这个大括号里的内容，可以实现运行exe文件的功能
        { //这个大括号里是‘运行(run)’任务，一些设置与上面的构建任务性质相同
            "label": "Code",
            "type": "shell",
            "dependsOn": "build", //任务依赖，因为要运行必须先构建，所以执行这个任务前必须先执行build任务，
            "command": "${fileDirname}\\bin\\${fileBasenameNoExtension}.exe", //执行exe文件，只需要指定这个exe文件在哪里就好
            "group": {
                "kind": "test", //这一组是‘测试’组，将run任务放在test组里方便我们用快捷键执行
                "isDefault": true
            },
            "presentation": {
                "echo": false,
                "reveal": "always",
                "focus": true, //这个就设置为true了，运行任务后将焦点聚集到终端，方便进行输入
                "panel": "new",
                "showReuseMessage": false //设为false后，上面的‘任务将被终端重用’提示就不会出现了
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
        {//这个大括号里是我们的‘调试(Debug)’配置
            "name": "Debug", // 配置名称
            "type": "cppdbg", // 配置类型，cppdbg对应cpptools提供的调试功能；可以认为此处只能是cppdbg
            "request": "launch", // 请求配置类型，可以为launch（启动）或attach（附加）
            "program": "${fileDirname}\\bin\\${fileBasenameNoExtension}.exe", // 将要进行调试的程序的路径
            "args": [], // 程序调试时传递给程序的命令行参数，这里设为空即可
            "stopAtEntry": false, // 设为true时程序将暂停在程序入口处，相当于在main上打断点
            "cwd": "${fileDirname}", // 调试程序时的工作目录，此处为源码文件所在目录
            "environment": [], // 环境变量，这里设为空即可
            "presentation": {
                "echo": true,
                "reveal": "always",
                "focus": true, //这个就设置为true了，运行任务后将焦点聚集到终端，方便进行输入
                "panel": "new"
            },
            "externalConsole": false, // 为true时使用单独的cmd窗口，跳出小黑框；设为false则是用vscode的内置终端，建议用内置终端
            "internalConsoleOptions": "neverOpen", // 如果不设为neverOpen，调试时会跳到“调试控制台”选项卡，新手调试用不到
            "MIMode": "gdb", // 指定连接的调试器，gdb是minGW中的调试程序
            "miDebuggerPath": "C:\\Program Files\\mingw64\\bin\\gdb.exe", // 指定调试器所在路径，如果你的minGW装在别的地方，则要改成你自己的路径，注意间隔是\\
            "preLaunchTask": "build" // 调试开始前执行的任务，我们在调试前要编译构建。与tasks.json的label相对应，名字要一样
    }]
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

我采用的是自己的配置，在cpp文件的目录下先创建了bin文件夹，然后将编译好的文件放在bin文件夹下，方便整理。


## Python配置

### 安装Python插件

首先，我们需要安装Python插件，这个插件是用来支持Python的，当然，如果你
只是想用VSCode来写C++，那么这个插件就不需要安装了。

![](https://pic.imgdb.cn/item/63d79cedface21e9ef1653fb.jpg)

### 配置Python插件

安装完Python插件之后，不需要配置python，系统会自动寻找到你的python环境（只要你安装python时加入了环境变量）。

同样的，使用的.coderunner插件配置之后，就可以直接编译执行了。无需单独配置。

## 参考

[VSCode C++配置](https://blog.csdn.net/qq_41855420/article/details/103201100)

[VSCode Python配置](https://blog.csdn.net/qq_41855420/article/details/103201100)
