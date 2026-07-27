#Requires AutoHotkey v2.0

browserPath := "C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe"
browserProcess := "brave.exe"

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
    global browserPath, browserProcess

    ; 已有浏览器窗口
    if WinExist("ahk_exe " browserProcess)
    {
        ; 浏览器会把网址发送给已有实例
        Run '"' browserPath '" "' url '"'
    }
    else
    {
        ; 启动浏览器并打开网址
        Run '"' browserPath '" "' url '"'
    }
}