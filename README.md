# Linux_CPP_Template

一个通用的C++模板，包含一些我常用的库

## 目录结构

>└───src
>    ├───3rd
>    │   ├───dpool
>    │   ├───filesystem
>    │   ├───httplib
>    │   ├───nlohmann
>    │   └───spdlog
>    └───func

`main.cpp`为整个程序的启动文件

`src/3rd`为三方库的存放目录

`src/func`为自己实现的功能

## 使用

编译

```shell
make
```

运行

```shell
make run  
# or
./main
```

## 三方库介绍

`nlohmann` 一个json库

`httplib` 一个http库

`spdlog` 一个log库

`filesystem` 一个文件操作库

`dpool` 一个简易的线程池
