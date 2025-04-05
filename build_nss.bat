@echo off
setlocal

:: 设置环境变量
set NSS_VERSION=3.89
set NSS_SOURCE_DIR=%~dp0nss
set NSS_BUILD_DIR=%~dp0build\nss
set NSS_INSTALL_DIR=%~dp0thirdparty\install\NSS

:: 创建必要的目录
if not exist "%NSS_BUILD_DIR%" mkdir "%NSS_BUILD_DIR%"
if not exist "%NSS_INSTALL_DIR%" mkdir "%NSS_INSTALL_DIR%"

:: 克隆 NSS 源码（如果不存在）
if not exist "%NSS_SOURCE_DIR%" (
    git clone https://github.com/nss-dev/nss.git
    cd nss
    git checkout NSS_%NSS_VERSION%_RELEASE
    cd ..
)

:: 进入构建目录
cd "%NSS_BUILD_DIR%"

:: 运行 NSS 构建脚本
call "%NSS_SOURCE_DIR%\build.sh" ^
    --target=x64 ^
    --opt ^
    --enable-libpkix ^
    --enable-fips ^
    --enable-tests ^
    --with-nspr=%NSS_INSTALL_DIR%\nspr ^
    --prefix=%NSS_INSTALL_DIR%

:: 复制构建结果到安装目录
xcopy /E /I /Y "%NSS_BUILD_DIR%\dist\Release\bin\*" "%NSS_INSTALL_DIR%\bin"
xcopy /E /I /Y "%NSS_BUILD_DIR%\dist\Release\include\*" "%NSS_INSTALL_DIR%\include"
xcopy /E /I /Y "%NSS_BUILD_DIR%\dist\Release\lib\*" "%NSS_INSTALL_DIR%\lib"

echo NSS build completed! 