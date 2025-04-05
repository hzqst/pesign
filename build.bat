@echo off
setlocal

:: Check if SolutionDir is already set and non-empty
if not defined SolutionDir (
    :: Only set SolutionDir if it's not already set
    SET "SolutionDir=%~dp0"
)

:: Ensure the path ends with a backslash
if not "%SolutionDir:~-1%"=="\" SET "SolutionDir=%SolutionDir%\"

cd /d "%SolutionDir%"

for /f "usebackq tokens=*" %%i in (`tools\vswhere -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath`) do (
  set InstallDir=%%i
)

:: 设置 Visual Studio 2022 环境
:: call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"

:: 创建构建目录
if not exist build mkdir build
cd build

:: 配置 CMake
cmake -G "Visual Studio 17 2022" -A x64 ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_PREFIX=%CD%\install ^
    -DCMAKE_PREFIX_PATH="%SolutionDir%\thirdparty\install\openssl;%SolutionDir%\thirdparty\install\NSS" ^
    ..

:: 构建项目
cmake --build . --config Release

:: 安装
cmake --install . --config Release

cd ..
echo Build completed successfully! 