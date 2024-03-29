# Linux_CPP_Template

一个通用的C++模板，包含一些我常用的库

## 目录结构


`main.cpp`为整个程序的启动文件

`src`存放cpp文件

`include`存放cpp对应的头文件

`headonly`是我常用的headonly的库

## 使用

### 编译

```shell
./compile.sh
```

或者

```shell
cd build
cmake .. && make
```


### 运行

```shell
./startapp.sh
```  
```bash
[help]
./startup.sh close    [关闭程序]
./startup.sh start    [启动/重启程序]
    携带参数   ./startup.sh start "para1 \"stringpara2\" para3"
./startup.sh show     [显示程序进程信息]
./startup.sh log      [显示程序日志]
./startup.sh clean    [清除日志和程序缓存] 
```
## 三方库介绍

`nlohmann/json` 一个json库

`cpp-httplib` 一个http库

`spdlog` 一个log库

`filesystem` 一个文件操作库

`dpool` 一个简易的线程池
