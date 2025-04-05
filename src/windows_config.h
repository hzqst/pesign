#ifndef WINDOWS_CONFIG_H
#define WINDOWS_CONFIG_H

// Windows 特定的定义
#define _CRT_SECURE_NO_WARNINGS
#define WIN32_LEAN_AND_MEAN

// 包含 Windows 头文件
#include <windows.h>
#include <wincrypt.h>

// 定义一些 Linux 特定的函数和类型
typedef int mode_t;
typedef int uid_t;
typedef int gid_t;

// 定义一些必要的宏
#define O_RDONLY 0x0000
#define O_WRONLY 0x0001
#define O_RDWR   0x0002
#define O_CREAT  0x0100
#define O_TRUNC  0x0200
#define O_APPEND 0x0400

// 定义文件权限
#define S_IRUSR 0400
#define S_IWUSR 0200
#define S_IXUSR 0100
#define S_IRGRP 0040
#define S_IWGRP 0020
#define S_IXGRP 0010
#define S_IROTH 0004
#define S_IWOTH 0002
#define S_IXOTH 0001

// 定义错误码映射
#define ENOENT ERROR_FILE_NOT_FOUND
#define EACCES ERROR_ACCESS_DENIED
#define EEXIST ERROR_FILE_EXISTS
#define EINVAL ERROR_INVALID_PARAMETER
#define ENOMEM ERROR_NOT_ENOUGH_MEMORY

// 函数声明
int mkdir(const char *path, mode_t mode);
int chmod(const char *path, mode_t mode);
char *getenv(const char *name);
int setenv(const char *name, const char *value, int overwrite);
void *mmap(void *addr, size_t length, int prot, int flags, int fd, off_t offset);
int munmap(void *addr, size_t length);
int mprotect(void *addr, size_t len, int prot);

#endif /* WINDOWS_CONFIG_H */ 