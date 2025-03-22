#SingleInstance Force
#Persistent
#InstallKeybdHook  
#UseHook           

SetTimer, ConfineMouse, 5  

; Default variables
global radius := 10
global isConfined := false
global centerX := 0
global centerY := 0
global isHotkeysEnabled := true  

; Load saved radius from settings.ini
IniRead, radius, settings.ini, Mouse, Radius, 10

; Create GUI window
Gui, Add, Text, vText1 x20 y20 w200 h30, Mouse Confinement: OFF
Gui, Add, Button, x20 y60 w150 h30 gToggleConfinement, Toggle Confinement
Gui, Add, Button, x20 y100 w150 h30 gIncreaseRadius, Increase Radius
Gui, Add, Button, x20 y140 w150 h30 gDecreaseRadius, Decrease Radius
Gui, Add, Button, x20 y180 w150 h30 gResetRadiusAction, Reset Radius
Gui, Add, Button, x20 y220 w150 h30 gSaveRadius, Save Radius
Gui, Add, Button, x20 y260 w150 h30 gLoadRadius, Load Radius
Gui, Add, Button, x20 y300 w150 h30 gStopScript, Stop Script

Gui, Add, Edit, vRadiusInput x20 y340 w100 h25, %radius%
Gui, Add, Button, x130 y340 w90 h25 gSetManualRadius, Set Radius

Gui, Show, x0 y0 w250 h380, Mouse Confinement Controls

; Define universal hotkeys
global keys := "^t,^Up,^Down,^r,^s,^l,^k,^w,^1"
Loop, Parse, keys, `,
    Hotkey, %A_LoopField%, HandleHotkey

HandleHotkey:
    key := A_ThisHotkey
    if (key = "^t") 
        ToggleConfinement()
    else if (key = "^Up") 
        IncreaseRadius()
    else if (key = "^Down") 
        DecreaseRadius()
    else if (key = "^r") 
        SnapGuiToTopLeft()
    else if (key = "^s") 
        SaveRadius()
    else if (key = "^l") 
        LoadRadius()
    else if (key = "^k") 
        StopScript()
    else if (key = "^w") 
        ToggleGuiPosition()
    else if (key = "^1") 
        ToggleHotkeys()
return

ToggleHotkeys() {
    global isHotkeysEnabled, keys
    isHotkeysEnabled := !isHotkeysEnabled

    Loop, Parse, keys, `,
        Hotkey, %A_LoopField%, % (isHotkeysEnabled ? "On" : "Off")

    ToolTip, Hotkeys % (isHotkeysEnabled ? "Enabled" : "Disabled")
    SetTimer, RemoveToolTip, -1000
}

ToggleGuiPosition() {
    static isOnTop := false

    if (isOnTop) {
        Gui, -AlwaysOnTop
        ToolTip, GUI Moved to Background
    } else {
        Gui, +AlwaysOnTop
        ToolTip, GUI Brought to Top
    }

    isOnTop := !isOnTop
    SetTimer, RemoveToolTip, -1000
}

RemoveToolTip() {
    ToolTip
}

ToggleConfinement() {
    global isConfined, centerX, centerY
    isConfined := !isConfined
    GuiControl,, Text1, Mouse Confinement: % (isConfined ? "ON" : "OFF")

    if (isConfined) {
        SysGet, ScreenWidth, 0
        SysGet, ScreenHeight, 1
        centerX := ScreenWidth / 2
        centerY := ScreenHeight / 2
    }
}

IncreaseRadius() {
    global radius
    radius += 5  
    ShowRadiusTooltip("Increased")
}

DecreaseRadius() {
    global radius
    radius := Max(radius - 5, 0)  
    ShowRadiusTooltip("Decreased")
}

SnapGuiToTopLeft() {
    Gui, Show, x0 y0 w250 h380, Mouse Confinement Controls
}

ResetRadiusAction() {
    global radius
    radius := 0  
    ShowRadiusTooltip("Reset to Minimum")
}

SaveRadius() {
    global radius
    IniWrite, %radius%, settings.ini, Mouse, Radius
    ShowRadiusTooltip("Saved")
}

LoadRadius() {
    global radius
    IniRead, radius, settings.ini, Mouse, Radius, 0
    if radius is not integer  
        radius := 0  

    GuiControl,, RadiusInput, %radius%
    ShowRadiusTooltip("Loaded")
}

SetManualRadius() {
    global radius
    GuiControlGet, newRadius, , RadiusInput
    if newRadius !=  
        if newRadius >= 0  
            radius := newRadius
            ShowRadiusTooltip("Set Manually")
        else {
            ToolTip, Invalid Input! Enter a number ≥ 0.
            SetTimer, RemoveToolTip, -1500
        }
}

ConfineMouse() {
    global isConfined, centerX, centerY, radius
    static lastScreenWidth, lastScreenHeight  

    if (!isConfined)
        return

    SysGet, ScreenWidth, 0
    SysGet, ScreenHeight, 1

    if (ScreenWidth != lastScreenWidth || ScreenHeight != lastScreenHeight) {
        centerX := ScreenWidth / 2
        centerY := ScreenHeight / 2
        lastScreenWidth := ScreenWidth
        lastScreenHeight := ScreenHeight
    }

    MouseGetPos, mouseX, mouseY
    dx := mouseX - centerX, dy := mouseY - centerY
    distance := Sqrt(dx * dx + dy * dy)

    if (distance > radius) {
        factor := radius / distance
        MouseMove, % centerX + dx * factor, % centerY + dy * factor, 0
    }
}

ShowRadiusTooltip(action) {
    global radius
    ToolTip, Radius %action%: %radius%
    SetTimer, RemoveToolTip, -1000
}

StopScript() {
    ToolTip, Stopping Script...
    SetTimer, ConfineMouse, Off
    Sleep, 1000
    ToolTip
    ExitApp
}
