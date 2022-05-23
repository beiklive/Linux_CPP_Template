cmake_minimum_required(VERSION 3.16.3)
project(test)

set(INSTALL_DIR ${CMAKE_SOURCE_DIR})

add_executable(test main.cpp)

INSTALL(TARGETS test DESTINATION ${INSTALL_DIR}/bin)