#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
Menu, Tray, Icon, C:\Users\Mikolaj\OneDrive\Documents\AHK\icons\terminal.png,, 0

;*CapsLock::Return

; How much height of screen size the terminal window takes.
VRatio := 0.4
; The path to the Windows Terminal exe file.
WtPath = "%LOCALAPPDATA%\Microsoft\WindowsApps\wt.exe"

;#SC29::ToggleTerminal()
;<!F2::ToggleTerminal()
*CapsLock::ToggleTerminal()

ShowAndPositionTerminal()
{
    ScreenX := GetScreenLeft()
    ScreenY := GetScreenTop()
    ScreenWidth := GetScreenWidth()
    ScreenHeight := GetScreenHeight()
    global VRatio

    WinShow ahk_class CASCADIA_HOSTING_WINDOW_CLASS
    WinActivate ahk_class CASCADIA_HOSTING_WINDOW_CLASS

    WinMove, ahk_class CASCADIA_HOSTING_WINDOW_CLASS,, ScreenX-5, ScreenY-10, ScreenWidth+10, ScreenHeight * VRatio,
}

ToggleTerminal()
{
    WinMatcher := "ahk_class CASCADIA_HOSTING_WINDOW_CLASS"

    DetectHiddenWindows, On

    if WinExist(WinMatcher)
    ; Window Exists
    {
        DetectHiddenWindows, Off

        ; Check if its hidden
        if !WinExist(WinMatcher) || !WinActive(WinMatcher)
        {
            ShowAndPositionTerminal()
        }
        else if WinExist(WinMatcher)
        {
            ; Script sees it without detecting hidden windows, so..
            WinHide ahk_class CASCADIA_HOSTING_WINDOW_CLASS
            Send !{Esc}
        }
    }
    else
    {
        global WtPath
        Run %WtPath%
        Sleep, 1000
        ShowAndPositionTerminal()
    }
}

; Gets the edge that the taskbar is docked to.  Returns:
;   "top"
;   "right"
;   "bottom"
;   "left"
GetTaskbarEdge() {
  WinGetPos,TX,TY,TW,TH,ahk_class Shell_TrayWnd,,,

  if (TW = A_ScreenWidth) { ; Vertical Taskbar
    if (TY = 0) {
      return "top"
    } else {
      return "bottom"
    }
  } else { ; Horizontal Taskbar
    if (TX = 0) {
      return "left"
    } else {
      return "right"
    }
  }
}

GetScreenTop() {
  WinGetPos,TX,TY,TW,TH,ahk_class Shell_TrayWnd,,,
  TaskbarEdge := GetTaskbarEdge()

  if (TaskbarEdge = "top") {
    return TH
  } else {
    return 0
  }
}

GetScreenLeft() {
  WinGetPos,TX,TY,TW,TH,ahk_class Shell_TrayWnd,,,
  TaskbarEdge := GetTaskbarEdge()

  if (TaskbarEdge = "left") {
    return TW
  } else {
    return 0
  }
}

GetScreenWidth() {
  WinGetPos,TX,TY,TW,TH,ahk_class Shell_TrayWnd,,,
  TaskbarEdge := GetTaskbarEdge()

  if (TaskbarEdge = "top" or TaskbarEdge = "bottom") {
    return A_ScreenWidth
  } else {
    return A_ScreenWidth - TW
  }
}

GetScreenHeight() {
  WinGetPos,TX,TY,TW,TH,ahk_class Shell_TrayWnd,,,
  TaskbarEdge := GetTaskbarEdge()

  if (TaskbarEdge = "top" or TaskbarEdge = "bottom") {
    return A_ScreenHeight - TH
  } else {
    return A_ScreenHeight
  }
}