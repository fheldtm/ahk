#Requires AutoHotkey v2.0

^!r:: { ; Ctrl+Alt+R
  MsgBox("Reload")
  Reload
}

loop {
  JLevel := KeyWait('j', 'D T0.05')
  KLevel := KeyWait('k', 'D T0.05')

  if (JLevel && KLevel) {
    ; Send("{Escape}")
  }
}