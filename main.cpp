#include <iostream>
#include <hello.h>
#include <spdlog/spdlog.h>
int main(){
    std::cout << "App start ~~" << std::endl;
    Hello();

    SPDLOG_INFO("Hello, world!");
    SPDLOG_ERROR("Error occurred");

    return 0;
}