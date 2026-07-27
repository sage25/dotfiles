@echo off
setlocal

:: 源目录（使用 %USERPROFILE% 自动定位当前用户）
set "SOURCE=%USERPROFILE%\dotfiles\windows\nvim\nvim"

:: 目标链接位置（在 %LOCALAPPDATA% 下创建名为 nvim 的链接）
set "LINK=%LOCALAPPDATA%\nvim"

:: 如果目标链接（或目录）已存在，直接删除（不备份，不报错）
if exist "%LINK%" (
    echo 目标已存在，正在删除：%LINK%
    rmdir /s /q "%LINK%"
)

:: 创建目录联接（Junction）
echo 正在创建目录联接：%LINK% -> %SOURCE%
mklink /J "%LINK%" "%SOURCE%"

echo 操作完成。
pause