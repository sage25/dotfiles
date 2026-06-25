#Requires AutoHotkey v2.0

chromePath := "D:\Program Files\Google\Chrome\Application\chrome.exe"

;=========================
; Insert + F1 ~ F12
;=========================

Insert & F1::OpenUrl("https://leetcode.cn/")
Insert & F2::OpenUrl("https://en.cppreference.com/cpp")
Insert & F3::OpenUrl("https://example.com/3")
Insert & F4::OpenUrl("https://example.com/4")
Insert & F5::OpenUrl("https://example.com/5")
Insert & F6::OpenUrl("https://example.com/6")
Insert & F7::OpenUrl("https://example.com/7")
Insert & F8::OpenUrl("https://example.com/8")
Insert & F9::OpenUrl("https://example.com/9")
Insert & F10::OpenUrl("https://example.com/10")
Insert & F11::OpenUrl("https://example.com/11")
Insert & F12::OpenUrl("https://example.com/12")

OpenUrl(url)
{
    chromePath := "D:\Program Files\Google\Chrome\Application\chrome.exe"

    ; 已有 Chrome 窗口
    if WinExist("ahk_exe chrome.exe")
    {
        ; Chrome 会把网址发送给已有实例
        Run '"' chromePath '" "' url '"'
    }
    else
    {
        ; 启动 Chrome 并打开网址
        Run '"' chromePath '" "' url '"'
    }
}