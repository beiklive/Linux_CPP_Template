#! /bin/bash
log(){
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1"
}


APP_DIR=$(pwd)
APP_PATH="bin"
APP_NAME="app"
EXEC_PATH="exec/"
EXEC_NAME=""
LOG_PATH="log"
Params=""

init(){
    log "APP_DIR: $APP_DIR"
    log "APP: $APP_PATH/$APP_NAME"
    log "EXEC_PATH: $EXEC_PATH"
    if [ -f "$APP_DIR/$APP_PATH/$APP_NAME" ]; then
        if [ ! -d $EXEC_PATH ]; then
            cd $APP_DIR
            log "cd $(pwd)"
            mkdir $EXEC_PATH
            log "mkdir $EXEC_PATH"
            cd $APP_DIR/$EXEC_PATH
            cp -a $APP_DIR/$APP_PATH/$APP_NAME $APP_DIR/$EXEC_PATH
            log "cp -a $APP_DIR/$APP_PATH/$APP_NAME $APP_DIR/$EXEC_PATH"
            log "正在修改程序名称..."
            mv $APP_NAME $APP_NAME-$(cat /proc/sys/kernel/random/uuid)
            log "mv $APP_NAME $(ls)"
            if [ $? -eq 0 ]; then
                log "程序执行名称修改为$(ls)"
            else
                log "程序名称修改失败"
            fi
        fi
        cd $APP_DIR/$EXEC_PATH
        EXEC_NAME=$(ls)
        log "EXEC_NAME: $EXEC_NAME"
    else
        log "init: $APP_DIR/$APP_PATH/$APP_NAME not found"
        log "please execute compile.sh first"
    fi

}

startFun(){
    log "正在启动程序..."
    if [ ! -d $APP_DIR/$LOG_PATH ]; then
        mkdir $APP_DIR/$LOG_PATH
    fi
    nohup ./$EXEC_NAME $Params > $APP_DIR/$LOG_PATH/$APP_NAME-$(date +'%Y-%m-%d-%H:%M:%S').log 2>&1 &
    if [ $? -eq 0 ]; then
        log "程序pid:" `ps -aux | grep "./$EXEC_NAME"| head -n 1| awk '{print $2}'`
        log "log path: $APP_DIR/$LOG_PATH/$APP_NAME-$(date +'%Y-%m-%d-%H:%M:%S').log"
        log "程序启动成功"
    else
        log "程序启动失败"
    fi
}

closeFun(){
    log "正在停止程序..."
    ps -aux | grep "./$EXEC_NAME"| head -n 1| awk '{print $2}'| xargs kill -9
    if [ $? -eq 0 ]; then
        log "程序pid:" `ps -aux | grep "./$EXEC_NAME"| head -n 1| awk '{print $2}'`
        log "停止程序成功"
    else
        log "关闭程序出现错误"
    fi
}

# ===================================main========================================
if [ $# -eq 0 ]; then
    echo "[help]"
    echo "./startup.sh close    [关闭程序] "
    echo "./startup.sh start    [启动/重启程序] "
    echo "      携带参数   ./startup.sh start \"para1 \\\"stringpara2\\\" para3\""
    echo "./startup.sh show     [显示程序进程信息] "
    echo "./startup.sh log      [显示程序日志] "
    echo "./startup.sh clean    [清除日志和程序缓存] "
else
    init    
    if [ "$1" == "start" ]; then
        res=`ps -aux | grep -c "./$EXEC_NAME"`
        if [ $res -eq 1 ]; then
            log "程序未运行"
            if [ -z "$2" ]; then
                log "命令行参数传入"
                Params=$2
            fi
            startFun
        else
            closeFun
            sleep 1
            startFun
        fi
    fi

    if [ "$1" == "close" ]; then
        res=`ps -aux | grep -c "./$EXEC_NAME"`
        if [ $res -eq 1 ]; then
            log "程序未运行"
        else
            closeFun
        fi
    fi

    if [ "$1" == "show" ]; then
        res=`ps -aux | grep -c "./$EXEC_NAME"`
        if [ $res -eq 1 ]; then
            log "程序未运行"
        else
            log `ps -aux | grep "./$EXEC_NAME"| head -n 1`
        fi
    fi
    
    if [ "$1" == "log" ]; then
        if [ ! -d $APP_DIR/$LOG_PATH ]; then
            log "程序未运行"
        else
            clear
            logname=$(ls -lt $APP_DIR/$LOG_PATH | grep "app-*" | awk '{print $9}' | head -n 1)
            tail -f $APP_DIR/$LOG_PATH/$logname
        fi
    fi

    if [ "$1" == "clean" ]; then
        res=`ps -aux | grep -c "./$EXEC_NAME"`
        if [ $res -eq 1 ]; then
            log "正在清除缓存..."
            if [ ! -d $APP_DIR/$LOG_PATH ]; then
                log "无日志缓存可清除"
            else
                rm -rf $APP_DIR/$LOG_PATH
                log "日志清除成功"
            fi
            if [ ! -d $APP_DIR/$EXEC_PATH ]; then
                log "无程序缓存可清除"
            else
                rm -rf $APP_DIR/$EXEC_PATH
                log "程序缓存清除成功"
            fi
        else
            log "程序正在运行，无法清除缓存"
        fi
    fi
    if [ "$1" == "class" ]; then
        log "正在生成class文件..."
        touch $APP_DIR/src/$2.cpp
        echo "#include \"$2.h\"" >> $APP_DIR/src/$2.cpp
        echo "$2::$2(){}" >> $APP_DIR/src/$2.cpp
        echo "$2::~$2(){}" >> $APP_DIR/src/$2.cpp
        touch $APP_DIR/include/$2.h
        echo "#ifndef $2_H" >> $APP_DIR/include/$2.h
        echo "#define $2_H" >> $APP_DIR/include/$2.h
        echo "class $2" >> $APP_DIR/include/$2.h
        echo "{" >> $APP_DIR/include/$2.h
        echo "public:" >> $APP_DIR/include/$2.h
        echo "    $2();" >> $APP_DIR/include/$2.h
        echo "    ~$2();" >> $APP_DIR/include/$2.h
        echo "private:" >> $APP_DIR/include/$2.h
        echo "};" >> $APP_DIR/include/$2.h
        echo "#endif" >> $APP_DIR/include/$2.h
        log "生成class文件成功"
    fi
fi
# ===================================main========================================
