; AutoHotkey v2 脚本

+!l::  ; Shift + Alt + L
{
    chromePath := "D:\Program Files\Google\Chrome\Application\chrome.exe"  ; 修改为你的实际路径
    url := "https://leetcode.cn"

    if FileExist(chromePath)
    {
        Run chromePath ' "' url '"'
    }
    else
    {
        MsgBox "Chrome 路径不存在，请检查路径是否正确！"
    }
}