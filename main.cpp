#include <iostream>
#include <hello.h>
#include <spdlog/spdlog.h>

int main(){
    std::cout << "App start ~~" << std::endl;
    Hello();
    test();
    spdlog::info("spdlog init");

    

    return 0;
}