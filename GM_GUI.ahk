#SingleInstance Force
#Persistent

SetTimer, ConfineMouse, 5  ; Continuously check mouse position

; Default variables
radius := 250  ; Default radius for mouse confinement
isConfined := false  ; Mouse confinement is disabled by default
centerX := 0  ; Initialize center coordinates
centerY := 0  ; Initialize center coordinates

; Create GUI window
Gui, Add, Text, vText1 x20 y20 w200 h30, Mouse Confinement: OFF
Gui, Add, Button, x20 y60 w150 h30 gToggleConfinement, Toggle Confinement
Gui, Add, Button, x20 y100 w150 h30 gIncreaseRadius, Increase Radius
Gui, Add, Button, x20 y140 w150 h30 gDecreaseRadius, Decrease Radius
Gui, Add, Button, x20 y180 w150 h30 gResetRadius, Reset Radius
Gui, Add, Button, x20 y220 w150 h30 gStopScript, StopScript
Gui, Show, w200 h300, Mouse Confinement Controls

; Hotkeys
^t::
    isConfined := !isConfined
    statusText := (isConfined ? "ON" : "OFF")
    GuiControl,, Text1, Mouse Confinement: %statusText%

    if (isConfined) {
        ; Recalculate the center of the screen relative to the desktop when confinement is enabled
        SysGet, ScreenWidth, 0
        SysGet, ScreenHeight, 1
        centerX := ScreenWidth / 2
        centerY := ScreenHeight / 2
    }

return

^Up::
    radius += 10
    ToolTip, Radius Increased to: %radius%
    SetTimer, RemoveToolTip, -1000
return

^Down::
    radius -= 10
    if (radius < 50)
        radius := 50
    ToolTip, Radius Decreased to: %radius%
    SetTimer, RemoveToolTip, -1000
return

^r::
    radius := 250
    ToolTip, Radius Reset to Default: %radius%
    SetTimer, RemoveToolTip, -1000
return

ResetRadius:
    radius := 250
    ToolTip, Radius Reset to Default: %radius%
    SetTimer, RemoveToolTip, -1000
return

ConfineMouse:
    if (!isConfined)  ; Exit if confinement is disabled
        return

    ; Get the current screen width and height, independent of the GUI
    SysGet, ScreenWidth, 0
    SysGet, ScreenHeight, 1
    ; Calculate the center of the screen based on actual screen dimensions
    centerX := ScreenWidth / 2
    centerY := ScreenHeight / 2

    ; Get current mouse position
    MouseGetPos, mouseX, mouseY
    dx := mouseX - centerX
    dy := mouseY - centerY
    distance := Sqrt(dx * dx + dy * dy)

    if (distance > radius)  ; If the mouse is outside the boundary
    {
        ; Calculate the new position to confine the mouse within the circle
        factor := radius / distance
        newX := centerX + (dx * factor)
        newY := centerY + (dy * factor)

        ; Move the mouse to the new position
        MouseMove, %newX%, %newY%, 0
    }
return

RemoveToolTip:
    ToolTip
return

; Button actions
ToggleConfinement:
    isConfined := !isConfined
    statusText := (isConfined ? "ON" : "OFF")
    GuiControl,, Text1, Mouse Confinement: %statusText%

    if (isConfined) {
        ; Recalculate the center of the screen every time confinement is toggled on
        SysGet, ScreenWidth, 0
        SysGet, ScreenHeight, 1
        centerX := ScreenWidth / 2
        centerY := ScreenHeight / 2
    }

return

IncreaseRadius:
    radius += 50
    ToolTip, Radius Increased to: %radius%
    SetTimer, RemoveToolTip, -1000
return

DecreaseRadius:
    radius -= 50
    if (radius < 50)
        radius := 50
    ToolTip, Radius Decreased to: %radius%
    SetTimer, RemoveToolTip, -1000
return

; Stop the script and show a tooltip before exiting
StopScript:
    ToolTip, StopScript: %StopScript%
    SetTimer, ConfineMouse, Off  ; Stop the confinement timer
    Sleep, 1000  ; Wait 1 second to display the tooltip
    ToolTip  ; Clear the tooltip
    ExitApp  ; Exit the script
return

; Hotkey to stop the script (Ctrl + K)
^k::
    GoSub, StopScript  ; Call the StopScript label
return
