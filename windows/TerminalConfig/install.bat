@echo off
setlocal enabledelayedexpansion

:: 源文件路径：使用 %USERPROFILE% 定位到当前用户的 home 目录
set "SOURCE=%USERPROFILE%\dotfiles\windows\TerminalConfig\settings.json"

:: 目标目录：使用 %LOCALAPPDATA% 定位到 Windows Terminal 的配置目录
set "TARGET_DIR=%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
set "TARGET_FILE=%TARGET_DIR%\settings.json"

:: 确保目标目录存在（一般默认存在，但以防万一）
if not exist "%TARGET_DIR%" mkdir "%TARGET_DIR%"

:: 仅当原配置文件存在时才备份（带时间戳），不存在则静默跳过，不报错
if exist "%TARGET_FILE%" (
    set "BACKUP=%TARGET_FILE%.%date:~0,4%%date:~5,2%%date:~8,2%_%time:~0,2%%time:~3,2%%time:~6,2%.bak"
    set "BACKUP=!BACKUP: =0!"   :: 将时间中的空格替换为0
    echo 正在备份原配置文件到：!BACKUP!
    move "%TARGET_FILE%" "!BACKUP!"
) else (
    echo 未找到现有配置文件，跳过备份。
)

:: 创建符号链接（源文件即使不存在，链接也会创建成功，不会报错）
echo 正在创建符号链接...
mklink "%TARGET_FILE%" "%SOURCE%"

echo 操作完成。
pause