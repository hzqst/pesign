# 收集源文件
file(GLOB_RECURSE PESIGN_SOURCES
    "*.c"
    "*.h"
)

# 排除不需要的文件
list(FILTER PESIGN_SOURCES EXCLUDE REGEX ".*\\.mdoc$")
list(FILTER PESIGN_SOURCES EXCLUDE REGEX ".*\\.in$")
list(FILTER PESIGN_SOURCES EXCLUDE REGEX ".*\\.conf\\.in$")
list(FILTER PESIGN_SOURCES EXCLUDE REGEX ".*\\.service\\.in$")
list(FILTER PESIGN_SOURCES EXCLUDE REGEX ".*\\.sysvinit\\.in$")

# 添加 Windows 特定的源文件
if(WIN32)
    list(APPEND PESIGN_SOURCES
        windows_config.h
        windows_impl.c
    )
endif()

# 创建可执行文件
add_executable(pesign ${PESIGN_SOURCES})

# 添加包含目录
target_include_directories(pesign PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${OPENSSL_INCLUDE_DIR}
    ${NSS_INCLUDE_DIR}
)

# 链接库
target_link_libraries(pesign PRIVATE
    ${OPENSSL_LIBRARIES}
    ${NSS_LIBRARIES}
)

if(WIN32)
    target_link_libraries(pesign PRIVATE
        crypt32
        ws2_32
    )
endif()

# 安装目标
install(TARGETS pesign
    RUNTIME DESTINATION ${INSTALL_BINDIR}
)

# 安装手册页
install(FILES
    pesign.1.mdoc
    pesigcheck.1.mdoc
    efikeygen.1.mdoc
    DESTINATION ${INSTALL_MANDIR}/man1
    RENAME pesign.1
    RENAME pesigcheck.1
    RENAME efikeygen.1
) 