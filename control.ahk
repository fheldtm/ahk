#Requires AutoHotkey v2.0

global MOUSE_MODE := false

global FORCE := 1.8
global RESISTANCE := 0.982

global VELOCITY_X := 0
global VELOCITY_Y := 0

Accelerate(velocity, pos, neg) {
  if (pos == 0 && neg == 0) {
    return 0
  } else if (pos + neg == 0) { ; smooth deceleration :)
    return velocity * 0.666
  } else { ; physics
    return velocity * RESISTANCE + FORCE * (pos + neg)
  }
}

MoveCursor() {
  global VELOCITY_X
  global VELOCITY_Y
  global MOUSE_MODE

  UP := 0
  RIGHT := 0
  DOWN := 0
  LEFT := 0

  if (MOUSE_MODE) {
    HLevel := KeyWait('h', 'D T0')
    JLevel := KeyWait('j', 'D T0')
    KLevel := KeyWait('k', 'D T0')
    LLevel := KeyWait('l', 'D T0')
    LEFT := LEFT - HLevel
    DOWN := DOWN + JLevel
    UP := UP - KLevel
    RIGHT := RIGHT + LLevel

    VELOCITY_X := Accelerate(VELOCITY_X, LEFT, RIGHT)
    VELOCITY_Y := Accelerate(VELOCITY_Y, UP, DOWN)

    MouseMove(VELOCITY_X, VELOCITY_Y, 0, "R")

    ; ToolTip('MouseMode')
    ToolTip(
      "H: " HLevel
      ", J: " JLevel
      ", K: " KLevel
      ", L: " LLevel
    )
  }
}

global g := Gui("+AlwaysOnTop -Caption -DPIScale +ToolWindow")
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
  global MOUSE_MODE
  MOUSE_MODE := true

  openOverlay("Normal")
}

EnterInsertMode() {
  global MOUSE_MODE
  MOUSE_MODE := false

  openOverlay("Insert")
  ToolTip('')
}

^!n:: EnterNormalMode()
^!i:: EnterInsertMode()

#HotIf (MOUSE_MODE)
{
  h:: return
  j:: return
  k:: return
  l:: return
  i:: MouseClick('Left')
  o:: MouseClick('Right')
  d:: Send "{WheelDown}"
  u:: Send "{WheelUp}"
}

SetTimer(MoveCursor, 16)