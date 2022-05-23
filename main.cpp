#include <iostream>
#include <hello.h>
#include <spdlog/spdlog.h>
#include <nlohmann/json.hpp>
using nlohmann::json;
int main(){
    std::cout << "App start ~~" << std::endl;
    Hello();
    test();
    spdlog::info("spdlog init");
    json j;
    j["pi"] = 3.141;
    j["happy"] = true;
    j["name"] = "Niels";
    j["nothing"] = nullptr;
    j["answer"]["everything"] = 42;
    j["list"] = { 1, 0, 2 };
    j["object"] = { {"currency", "USD"}, {"value", 42.99} };
    std::cout << j << '\n';
    

    return 0;
}