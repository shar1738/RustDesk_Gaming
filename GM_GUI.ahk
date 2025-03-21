#SingleInstance Force
#Persistent
#InstallKeybdHook  ; Ensures hotkeys work in all windows
#UseHook           ; Explicitly use the hook method for hotkeys

SetTimer, ConfineMouse, 5  ; Continuously check mouse position

; Default variables
radius := 10
isConfined := false
centerX := 0
centerY := 0
isHotkeysEnabled := true  ; Tracks whether the hotkeys are enabled

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

; Add manual input for radius
Gui, Add, Edit, vRadiusInput x20 y340 w100 h25, %radius%
Gui, Add, Button, x130 y340 w90 h25 gSetManualRadius, Set Radius

; Show the GUI window at the top-left corner of the screen
Gui, Show, x0 y0 w250 h380, Mouse Confinement Controls

; Define universal hotkeys
~^t::ToggleConfinement()
~^Up::IncreaseRadius()
~^Down::DecreaseRadius()
~^r::SnapGuiToTopLeft()
~^s::SaveRadius()
~^l::LoadRadius()
~^k::StopScript()
~^w::ToggleGuiPosition()

; Define the Ctrl+Escape hotkey to toggle all other hotkeys
~^1::ToggleHotkeys()

ToggleHotkeys() {
    global isHotkeysEnabled
    isHotkeysEnabled := !isHotkeysEnabled

    if (isHotkeysEnabled) {
        Hotkey, ^t, ToggleConfinement, On
        Hotkey, ^Up, IncreaseRadius, On
        Hotkey, ^Down, DecreaseRadius, On
        Hotkey, ^r, SnapGuiToTopLeft, On
        Hotkey, ^s, SaveRadius, On
        Hotkey, ^l, LoadRadius, On
        Hotkey, ^k, StopScript, On
        Hotkey, ^w, ToggleGuiPosition, On
        ToolTip, Hotkeys Enabled
    } else {
        Hotkey, ^t, ToggleConfinement, Off
        Hotkey, ^Up, IncreaseRadius, Off
        Hotkey, ^Down, DecreaseRadius, Off
        Hotkey, ^r, SnapGuiToTopLeft, Off
        Hotkey, ^s, SaveRadius, Off
        Hotkey, ^l, LoadRadius, Off
        Hotkey, ^k, StopScript, Off
        Hotkey, ^w, ToggleGuiPosition, Off
        ToolTip, Hotkeys Disabled
    }

    ; Show the tooltip briefly
    SetTimer, RemoveToolTip, -1000
}

ToggleGuiPosition() {
    static isOnTop := false

    if (isOnTop) {
        Gui, -AlwaysOnTop
        ToolTip, GUI Moved to Background
    } else {
        Gui, +AlwaysOnTop
        Gui, Show
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
    statusText := (isConfined ? "ON" : "OFF")
    GuiControl,, Text1, Mouse Confinement: %statusText%

    if (isConfined) {
        SysGet, ScreenWidth, 0
        SysGet, ScreenHeight, 1
        centerX := ScreenWidth / 2
        centerY := ScreenHeight / 2
    }
}

IncreaseRadius() {
    global radius
    radius += 5  ; Increase by 5
    ShowRadiusTooltip("Increased")
}

DecreaseRadius() {
    global radius
    radius := Max(radius - 5, 0)  ; Decrease by 5, with a minimum of 0
    ShowRadiusTooltip("Decreased")
}

SnapGuiToTopLeft() {
    Gui, Show, x0 y0 w250 h380, Mouse Confinement Controls
}

ResetRadiusAction() {
    global radius
    radius := 0  ; Reset to the minimum value of 0
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

    if !(radius is integer) || (radius < 0) {
        radius := 0  ; Ensure no negative values are loaded
    }

    GuiControl,, RadiusInput, %radius%
    ShowRadiusTooltip("Loaded")
}

SetManualRadius() {
    global radius
    GuiControlGet, newRadius, , RadiusInput
    if (newRadius is integer) && (newRadius >= 0) {
        radius := newRadius
        ShowRadiusTooltip("Set Manually")
    } else {
        ToolTip, Invalid Input! Enter a number ≥ 0.
        SetTimer, RemoveToolTip, -1500
    }
}

ConfineMouse() {
    global isConfined, centerX, centerY, radius
    if (!isConfined)
        return

    SysGet, ScreenWidth, 0
    SysGet, ScreenHeight, 1
    centerX := ScreenWidth / 2
    centerY := ScreenHeight / 2

    MouseGetPos, mouseX, mouseY
    dx := mouseX - centerX
    dy := mouseY - centerY
    distance := Sqrt(dx * dx + dy * dy)

    if (distance > radius) {
        factor := radius / distance
        newX := centerX + (dx * factor)
        newY := centerY + (dy * factor)
        MouseMove, %newX%, %newY%, 0
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
