#Requires AutoHotkey v2.0

#SuspendExempt
^!n:: EnterNormalMode()
^!i:: EnterInsertMode()
#SuspendExempt false

global DEFAULT_MOUSE_SPEED := 5

global g := Gui("+AlwaysOnTop -Caption -DPIScale +ToolWindow")
global IS_MOUSE_DOWN := false

openOverlay(msg) {
  global g

  g.Destroy()

  vWidth := 150
  vHeight := 50
  vLeft := 0
  vTop := 0

  g := Gui("+AlwaysOnTop -Caption -DPIScale +ToolWindow +Border")
  g.BackColor := "White"
  g.SetFont("s16 w700 Q0 cBlack", "Noto Sans KR")
  g.Add("Text", "Center", msg)
  g.Show("NoActivate")

  SetTimer(closeOverlay, -1000)
}

closeOverlay() {
  global g

  g.Destroy()
}

EnterNormalMode() {
  openOverlay("Normal")
  Suspend(0)
  Pause(0)
}

EnterInsertMode() {
  closeOverlay()
  ToolTip('')
  Suspend(1)
  Pause(1)
}

h:: return
j:: return
k:: return
l:: return
+h:: return
+j:: return
+k:: return
+l:: return
^h:: return
^j:: return
^k:: return
^l:: return
+^h:: return
+^j:: return
+^k:: return
+^l:: return
i:: {
  global IS_MOUSE_DOWN
  IS_MOUSE_DOWN := false
  MouseClick('Left')
}
o:: {
  global IS_MOUSE_DOWN
  IS_MOUSE_DOWN := false
  MouseClick('Right')
}
d:: Send("{WheelDown}{WheelDown}{WheelDown}{WheelDown}{WheelDown}{WheelDown}")
u:: Send("{WheelUp}{WheelUp}{WheelUp}{WheelUp}{WheelUp}{WheelUp}")
v:: {
  global IS_MOUSE_DOWN
  if (IS_MOUSE_DOWN) {
    Send "{LButton up}"
    IS_MOUSE_DOWN := false
  } else {
    Send "{LButton down}"
    IS_MOUSE_DOWN := true
  }
}
y:: Send("^c")

openOverlay("Insert")
Suspend(1)
Pause(1)

MouseCursor() {
  global DEFAULT_MOUSE_SPEED

  HLevel := KeyWait('h', 'D T0')
  JLevel := KeyWait('j', 'D T0')
  KLevel := KeyWait('k', 'D T0')
  LLevel := KeyWait('l', 'D T0')

  IS_SHIFT := KeyWait('LShift', 'D T0')
  IS_CTRL := KeyWait('LCtrl', 'D T0')

  MOUSE_SPEED := DEFAULT_MOUSE_SPEED

  if (IS_SHIFT) {
    MOUSE_SPEED := MOUSE_SPEED * 4
  }

  if (IS_CTRL) {
    MOUSE_SPEED := MOUSE_SPEED * 4
  }

  X := 0 - HLevel
  Y := 0 + JLevel
  Y := Y - KLevel
  X := X + LLevel

  VELOCITY_X := X * MOUSE_SPEED
  VELOCITY_Y := Y * MOUSE_SPEED

  MouseMove(VELOCITY_X, VELOCITY_Y, 0, "R")

  ToolTip('NORMAL')
}

SetTimer(MouseCursor, 16)