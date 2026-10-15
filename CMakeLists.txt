cmake_minimum_required(VERSION 3.20)
project(test_cicd_repo VERSION 0.1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")

add_library(greeting src/greeting.cpp)
target_include_directories(greeting PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/include")
target_compile_options(greeting PRIVATE -Wall -Wextra -Wpedantic)

add_executable(hello src/main.cpp)
target_link_libraries(hello PRIVATE greeting)

enable_testing()
add_executable(greeting_test tests/greeting_test.cpp)
target_link_libraries(greeting_test PRIVATE greeting)
add_test(NAME greeting_unit COMMAND greeting_test)
add_test(NAME hello_default COMMAND hello)
set_tests_properties(hello_default PROPERTIES PASS_REGULAR_EXPRESSION "Hello, world!")
add_test(NAME hello_custom COMMAND hello runner)
set_tests_properties(hello_custom PROPERTIES PASS_REGULAR_EXPRESSION "Hello, runner!")
