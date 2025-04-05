cmake_minimum_required(VERSION 3.15)
project(pesign VERSION 1.0.0 LANGUAGES C)

# 设置 C 标准
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)

# 设置输出目录
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)

# 查找必要的包
find_package(OpenSSL REQUIRED)
find_package(NSS REQUIRED)
find_package(PkgConfig REQUIRED)

# 添加子目录
add_subdirectory(src)

# 设置编译选项
if(MSVC)
    add_compile_options(/W4 /WX)
    add_definitions(-D_CRT_SECURE_NO_WARNINGS)
else()
    add_compile_options(-Wall -Wextra -Werror)
endif()

# 设置安装路径
include(GNUInstallDirs)
set(INSTALL_BINDIR ${CMAKE_INSTALL_BINDIR})
set(INSTALL_LIBDIR ${CMAKE_INSTALL_LIBDIR})
set(INSTALL_INCLUDEDIR ${CMAKE_INSTALL_INCLUDEDIR})
set(INSTALL_MANDIR ${CMAKE_INSTALL_MANDIR}) 