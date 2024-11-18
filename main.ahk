#Requires AutoHotkey v2.0

^!r:: { ; Ctrl+Alt+R
  MsgBox("Reload")
  Reload
}

#Include "./keymap.ahk"
#Include "./control.ahk"
#Include "./combo.ahk"