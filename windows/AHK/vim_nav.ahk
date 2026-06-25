#Requires AutoHotkey v2.0

; CapsLock 不再切换大小写
SetCapsLockState "AlwaysOff"

; =========================
; Vim 风格方向键
; =========================

CapsLock & h::Send "{Left}"
CapsLock & j::Send "{Down}"
CapsLock & k::Send "{Up}"
CapsLock & l::Send "{Right}"

; =========================
; 常用导航
; =========================

CapsLock & u::Send "{Home}"
CapsLock & o::Send "{End}"

CapsLock & i::Send "{PgUp}"
CapsLock & ,::Send "{PgDn}"

; =========================
; 删除
; =========================

CapsLock & n::Send "{Delete}"
CapsLock & m::Send "{Backspace}"

; =========================
; Esc（超级舒服）
; =========================

CapsLock::Send "{Esc}"



CapsLock & b::ToggleTaskbarAutoHide()

; 切换任务栏自动隐藏状态
ToggleTaskbarAutoHide() {
    ; 获取任务栏窗口句柄
    hTray := WinExist("ahk_class Shell_TrayWnd")
    if !hTray
        return

    ; 根据系统位数计算 APPBARDATA 结构大小和偏移
    static cbSize := (A_PtrSize == 8) ? 48 : 36
    static hWndOffset  := (A_PtrSize == 8) ? 8 : 4
    static lParamOffset := (A_PtrSize == 8) ? 40 : 32
    static ABM_GETSTATE := 0x4
    static ABM_SETSTATE := 0xA
    static ABS_AUTOHIDE := 0x1

    ; 创建缓冲区并填写必要字段
    buf := Buffer(cbSize)
    NumPut("UInt", cbSize, buf, 0)
    NumPut("UPtr", hTray, buf, hWndOffset)

    ; 获得当前任务栏状态
    state := DllCall("shell32.dll\SHAppBarMessage", "UInt", ABM_GETSTATE, "Ptr", buf, "UInt")

    ; 翻转自动隐藏位
    newState := (state & ABS_AUTOHIDE) ? (state & ~ABS_AUTOHIDE) : (state | ABS_AUTOHIDE)

    ; 设置新状态
    NumPut("UPtr", newState, buf, lParamOffset)
    DllCall("shell32.dll\SHAppBarMessage", "UInt", ABM_SETSTATE, "Ptr", buf)

    ; 系统会自动调整工作区，所有最大化/全屏窗口将立即适应新尺寸
}