Gui, +AlwaysOnTop +ToolWindow
Gui, Add, Button, gGuiClose w20 h20, X

; Get screen dimensions
SysGet, ScreenWidth, 78
SysGet, ScreenHeight, 79

; Set GUI size
GuiWidth := 1
GuiHeight := 1

; Calculate position for centering
X := (ScreenWidth - GuiWidth) / 2
Y := (ScreenHeight - GuiHeight) / 2

Gui, Show, w%GuiWidth% h%GuiHeight% x%X% y%Y%, On Top Window
Return

GuiClose:
ExitApp
