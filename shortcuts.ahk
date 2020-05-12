#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
Menu, Tray, Icon, C:\Users\Mikolaj\OneDrive\Documents\AHK\icons\typing.png,, 0

; Media Keys
^F8::
Send {Media_Play_Pause}
return

^F9::
Send {Media_Prev}
return
 
^F10::
Send {Media_Next}
return
 
^F11::
Send {Volume_Down 5}
return

^F12::
Send {Volume_Up 5}
return

^m::
Send {Volume_Mute}
return

; Global
<^q::Send !{f4}

#If WinActive("ahk_exe discord.exe")
^w::
  WinClose
return