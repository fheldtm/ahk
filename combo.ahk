#Requires AutoHotkey v2.0

ComboKey := "e"
SecondKey := "w"
ComboDelay := 500  ; 콤보 시간 지연을 500ms로 설정

lastKeyDown := ""

; ComboKey를 눌렀을 때
e::
{
  MsgBox("TEST")
  ; lastKeyDown := "e"  ; 마지막 눌린 키를 기록
  ; MsgBox(lastKeyDown)
  ; return
}

; SecondKey가 콤보 키와 동시에 눌릴 때
w::
{
  if (lastKeyDown == "e") {
    ; 콤보 키가 "e"일 때 "w" 키 동작을 수행
    MsgBox "Combo activated: e + w"
    lastKeyDown := ""  ; 콤보 이후 키 상태 초기화
  }
  return
}

; 콤보 시간 지연 후 초기화
SetTimer(CheckCombo, ComboDelay)
return

CheckCombo() {
  lastKeyDown := ""  ; 콤보가 끝나면 상태 초기화
  return
}