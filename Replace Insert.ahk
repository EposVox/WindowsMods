; Copy this file to Startup to have it always run with your machine:
; C:\Users\Adam\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
; Adam's Windows Mods #3 - Replace Insert Key

;No tray icon... obviously. No need for this to take up space.
#NoTrayIcon
SetTitleMatchMode RegEx
return

;Replace "Insert" key with CTRL+V
Ins::^v
