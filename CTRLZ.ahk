;"CTRLZ.ahk" - Disables the use of CTRL + Z in Windows Explorer. 
;"Undo" never works how you expect in Explorer, and it's been the cause of many files of mine to go missing. 
;This disables the keyboard shortcut. The Ribbon "Undo" buttons still work fine.
; Adam Taylor aka EposVox
; http://youtube.com/eposvox
; VIDEO TUTORIAL: https://www.youtube.com/watch?v=zjLCP9yJ87A
; Add file to startup so it always starts up (set it and forget it)
; C:\Users\Adam\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup

;No tray icon... obviously. No need for this to take up space.
#NoTrayIcon
SetTitleMatchMode RegEx
return

; Disable Ctrl+Z KEYBOARD shortcut in Windows Explorer
#IfWinActive ahk_class ExploreWClass|CabinetWClass
^z::
SoundBeep, 900, 500
return
#IfWinActive