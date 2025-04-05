# PESign Windows 移植版

这是 PESign 工具的 Windows 移植版本，用于对 PE 文件进行签名和验证。

## 系统要求

- Windows 10 或更高版本
- Visual Studio 2022
- CMake 3.15 或更高版本
- OpenSSL for Windows
- NSS (Network Security Services) for Windows

## 依赖项安装

1. 安装 Visual Studio 2022
   - 下载并安装 [Visual Studio 2022](https://visualstudio.microsoft.com/vs/)
   - 确保安装 "使用 C++ 的桌面开发" 工作负载

2. 安装 CMake
   - 下载并安装 [CMake](https://cmake.org/download/)
   - 确保将 CMake 添加到系统 PATH

3. 安装 OpenSSL
   - 下载 [OpenSSL for Windows](https://slproweb.com/products/Win32OpenSSL.html)
   - 安装到 `C:\OpenSSL-Win64`

4. 安装 NSS
   - 下载 [NSS for Windows](https://developer.mozilla.org/en-US/docs/Mozilla/Projects/NSS/NSS_Tools_certutil)
   - 安装到 `C:\NSS`

## 构建步骤

1. 克隆仓库：
   ```bash
   git clone https://github.com/yourusername/pesign.git
   cd pesign
   ```

2. 运行构建脚本：
   ```bash
   build.bat
   ```

3. 构建完成后，可执行文件将位于 `build/bin/Release/pesign.exe`

## 使用方法

1. 签名 PE 文件：
   ```bash
   pesign -i input.exe -o output.exe -c certificate_name -s
   ```

2. 验证签名：
   ```bash
   pesign -i signed.exe -S
   ```

3. 列出签名：
   ```bash
   pesign -i signed.exe -l
   ```

## 证书管理

1. 创建证书数据库：
   ```bash
   certutil -N -d %APPDATA%\pesign
   ```

2. 导入证书：
   ```bash
   certutil -A -n "证书昵称" -t "CT,C,C" -d %APPDATA%\pesign -i certificate.cer
   ```

## 注意事项

- 确保所有依赖项都正确安装并配置
- 证书数据库默认位置为 `%APPDATA%\pesign`
- 使用管理员权限运行可能需要签名的操作

## 故障排除

1. 如果遇到找不到 OpenSSL 或 NSS 的错误：
   - 检查环境变量是否正确设置
   - 确认依赖项安装路径是否正确

2. 如果遇到证书相关错误：
   - 确保证书数据库已正确创建
   - 检查证书权限设置

## 许可证

本项目采用 GPLv2 许可证。详见 COPYING 文件。
