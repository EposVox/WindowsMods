; Copy this file to Startup to have it always run with your machine:
; C:\Users\Adam\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
; Adam's Windows Mods #4 - Replace Pause Key

;No tray icon... obviously. No need for this to take up space.
#NoTrayIcon
SetTitleMatchMode RegEx
return

;Before this works optimally, you probably want to open a blank
;MSPaint document, set the size to something small, then close
;it and "Don't Save" - that way your default size is small
;enough to accommodate window screenshots without extra white space! Just a tip

;Replace "Pause" key to save Window screenshot
Pause:: 
;;Send Alt-printscreen, [for full screen sendinput only {PrintScreen}]
Sendinput {Alt down}{PrintScreen}{Alt up}
IfWinExist Untitled - Paint
{
    WinActivate                                   
}
else
{
    ;;Run MSPaint
    Run %windir%\System32\mspaint.exe
    WinWait Untitled - Paint
    WinActivate                                   
}
Sendinput ^v
Sendinput {Ctrl down}{s down}{s up}{Ctrl up}
WinWait Save As
WinActivate
deskpath = %A_Desktop%
Sendinput %deskpath%{enter}
Sleep 100
ControlSetText,Edit1,,
WinWaitClose Save As
SendInput {LAlt Down}{F4 down}{F4 up}{LAlt Up}
Sleep 100
IfWinExist Paint
{
    Sendinput {Tab down}{Tab up}{Enter down}{enter up}
    return
}
else
{
    ;;The image was saved and paint was closed
    return
}