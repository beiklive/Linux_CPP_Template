set(PRO_NAME app)

cmake_minimum_required(VERSION 2.8)

project(${PRO_NAME})

set (EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/bin)


aux_source_directory(src SRC_LIST)
message("[INFO] SRC_LIST: ${SRC_LIST}")

include_directories(include)
message("[INFO] add directory 'include'")

include_directories(headonly)
message("[INFO] add directory 'headonly'")


add_compile_options(-std=c++11 -Wall -lpthread) 

add_executable(${PRO_NAME} main.cpp ${SRC_LIST})