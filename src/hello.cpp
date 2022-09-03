#include "hello.h"

void Hello(){
    nlohmann::json j;
    j["pi"] = 3.141;
    j["happy"] = true;
    j["name"] = "Niels";
    j["nothing"] = nullptr;
    std::cout << j << std::endl;
    std::cout << "hello world" << std::endl;

}