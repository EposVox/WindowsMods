; Epos Windows Mods compilation
; Add the AHK or a shortcut to it to your startup folder so you never have to think twice about it.
; C:\Users\Adam\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup

;No tray icon... obviously. No need for this to take up space.
#NoTrayIcon
SetTitleMatchMode RegEx
return




;begin windows mods

;"CTRLZ.ahk" - Disables the use of CTRL + Z in Windows Explorer. 
;"Undo" never works how you expect in Explorer, and it's been the cause of many files of mine to go missing. 
;This disables the keyboard shortcut. The Ribbon "Undo" buttons still work fine.
; Adam Taylor aka EposVox
; http://youtube.com/eposvox
; VIDEO TUTORIAL: https://www.youtube.com/watch?v=zjLCP9yJ87A

; Disable Ctrl+Z KEYBOARD shortcut in Windows Explorer
#IfWinActive ahk_class ExploreWClass|CabinetWClass
^z::
SoundBeep, 900, 500
return
#IfWinActive

;TOGGLES FILE EXTENSIONS (in Windows Explorer)
;toggle extensions script - checks status of file extension viewing, toggles it, refreshes Explorer window.
f_ToggleFileExt()
{
Global lang_ToggleFileExt, lang_ShowFileExt, lang_HideFileExt
RootKey = HKEY_CURRENT_USER
SubKey  = Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced
RegRead, HideFileExt    , % RootKey, % SubKey, HideFileExt
if HideFileExt = 1
  {
  RegWrite, REG_DWORD, % RootKey, % SubKey, HideFileExt, 0
  f_RefreshExplorer()
  }
else
{
    RegWrite, REG_DWORD, % RootKey, % SubKey, HideFileExt, 1
  f_RefreshExplorer()
}
return
}

f_RefreshExplorer() ;refreshes explorer so you see the results
{
WinGet, id, ID, ahk_class Progman
SendMessage, 0x111, 0x1A220,,, ahk_id %id%
WinGet, id, List, ahk_class CabinetWClass
Loop, %id%
{
  id := id%A_Index%
   SendMessage, 0x111, 0x1A220,,, ahk_id %id%
}
WinGet, id, List, ahk_class ExploreWClass
Loop, %id%
{
  id := id%A_Index%
  SendMessage, 0x111, 0x1A220,,, ahk_id %id%
}
WinGet, id, List, ahk_class #32770
Loop, %id%
{
  id := id%A_Index%
  ControlGet, w_CtrID, Hwnd,, SHELLDLL_DefView1, ahk_id %id%
  if w_CtrID !=
  SendMessage, 0x111, 0x1A220,,, ahk_id %w_CtrID%
}
return
}
;maps toggle to Win+Y
#y::f_ToggleFileExt()
;end of file extensions mod

; WINDOWS KEY + H TOGGLES HIDDEN FILES 
#h:: ;Win+H shortcut
RegRead, HiddenFiles_Status, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden  ;checks for hidden file status and changes
If HiddenFiles_Status = 2  
RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 1 
Else  
RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 2 
WinGetClass, eh_Class,A 
If (eh_Class = "#32770" OR A_OSVersion >= "WIN_VISTA") ;if your Windows OS is Vista or newer
send, {F5} 
Else PostMessage, 0x111, 28931,,, A 
f_RefreshExplorer() ;calls the refresh command agian so you see your results
Return
;end of hidden files mod

;Hope this helps!

;Alt-3 Maximizes a window
!3::WinMaximize, A

;Replace "Insert" key with CTRL+V
Ins::^v
;happy pasting!

;Replace "Pause" key to save Window screenshot
;Before this works optimally, you probably want to open a blank
;MSPaint document, set the size to something small, then close
;it and "Don't Save" - that way your default size is small
;enough to accommodate window screenshots without extra white space! Just a tip
;Pause:: 
;;Send Alt-printscreen, [for full screen sendinput only {PrintScreen}]
;Sendinput {Alt down}{PrintScreen}{Alt up}
;IfWinExist Untitled - Paint
;{
;    WinActivate                                   
;}
;else
;{
;    ;;Run MSPaint
;    Run %windir%\System32\mspaint.exe
;    WinWait Untitled - Paint
;    WinActivate                                   
;}
;Sendinput ^v
;Sendinput {Ctrl down}{s down}{s up}{Ctrl up}
;WinWait Save As
;WinActivate
;deskpath = %A_Desktop%
;Sendinput %deskpath%{enter}
;Sleep 100
;ControlSetText,Edit1,,
;WinWaitClose Save As
;SendInput {LAlt Down}{F4 down}{F4 up}{LAlt Up}
;Sleep 100
;IfWinExist Paint
;{
;    Sendinput {Tab down}{Tab up}{Enter down}{enter up}
;    return
;}
;else
;{
;    ;;The image was saved and paint was closed
;    return
;}


;replace capslock with search 
;CapsLock::
;{
; Send, ^c
; Sleep 50
; Run, http://www.google.com/search?q=%clipboard%
; Return
;}

;paste in cmd
#IfWinActive ahk_class ConsoleWindowClass
^V::
SendInput {Raw}%clipboard%
return
#IfWinActive


