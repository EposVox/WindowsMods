;runs bat files I want in explorer folders, first by getting the active directory of focused explorer window. (Set explorer to show full path in window title)

#SingleInstance force ;only one instance of this script may run at a time!
Menu, Tray, Icon, shell32.dll, 4
;Above changes the icon in the system tray from the usual AHK icon. Play with the numbers to pick your own.

;make video directories for new projects
+!q::
WinGetTitle, Title, ahk_class CabinetWClass
;	msgbox,% Title
	Run, E:\Documents\WindowsMods\MakeVideoDirectories.bat /E:ON "%Title%" /E:ON, "%Title%"
return

;compress files in directory w/ CRF14
+!r::
WinGetTitle, Title, ahk_class CabinetWClass
;	msgbox,% Title
	Run, E:\Documents\WindowsMods\crf14.bat /E:ON "%Title%" /E:ON, "%Title%"
return

;compress files in directory w/ CRF14 (HEVC)
+!f::
WinGetTitle, Title, ahk_class CabinetWClass
;	msgbox,% Title
	Run, E:\Documents\WindowsMods\crf14_hevc.bat /E:ON "%Title%" /E:ON, "%Title%"
return
