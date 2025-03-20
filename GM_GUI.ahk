#SingleInstance Force 
#Persistent

SetTimer, ConfineMouse, 5  ; Continuously check mouse position

; Default variables
radius := 250  ; Default radius for mouse confinement
isConfined := false  ; Mouse confinement is disabled by default
centerX := 0  
centerY := 0  

; Load saved radius from settings.ini
IniRead, radius, settings.ini, Mouse, Radius, 250  

; Create GUI window
Gui, Add, Text, vText1 x20 y20 w200 h30, Mouse Confinement: OFF
Gui, Add, Button, x20 y60 w150 h30 gToggleConfinement, Toggle Confinement
Gui, Add, Button, x20 y100 w150 h30 gIncreaseRadius, Increase Radius
Gui, Add, Button, x20 y140 w150 h30 gDecreaseRadius, Decrease Radius
Gui, Add, Button, x20 y180 w150 h30 gResetRadius, Reset Radius
Gui, Add, Button, x20 y220 w150 h30 gSaveRadius, Save Radius
Gui, Add, Button, x20 y260 w150 h30 gLoadRadius, Load Radius
Gui, Add, Button, x20 y300 w150 h30 gStopScript, Stop Script

; Add manual input for radius
Gui, Add, Edit, vRadiusInput x20 y340 w100 h25, %radius%
Gui, Add, Button, x130 y340 w90 h25 gSetManualRadius, Set Radius

; Show the GUI window at the top-left corner of the screen
Gui, Show, x0 y0 w250 h380, Mouse Confinement Controls

; Hotkeys
^t::ToggleConfinement()
^Up::IncreaseRadius()
^Down::DecreaseRadius()
^r::ResetRadius()
^s::SaveRadius()
^l::LoadRadius()
^k::StopScript()

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
    radius += 10
    ShowRadiusTooltip("Increased")
}

DecreaseRadius() {
    global radius
    radius := Max(radius - 10, 10)  ; Ensure minimum radius is 10
    ShowRadiusTooltip("Decreased")
}

ResetRadius() {
    global radius
    radius := 250
    ShowRadiusTooltip("Reset to Default")
}

SaveRadius() {
    global radius := sradius
    IniWrite, %radius%, settings.ini, Mouse, Radius
    ShowRadiusTooltip("Saved")
}

LoadRadius() {
    global radius := sradius
    IniRead, radius, settings.ini, Mouse, Radius, 250

    ; Debug: Show what was read from the file
    ToolTip, Debug - Read Radius: %radius%
    Sleep, 1500  ; Keep tooltip for 1.5 seconds for debugging

    ; Ensure it's a valid number
    if !(radius is integer) || (radius < 10) {
        radius := 250  ; Default to 250 if the value is invalid
    }

    GuiControl,, RadiusInput, %radius%  ; Update the GUI input box
    ShowRadiusTooltip("Loaded")
}

SetManualRadius() {
    global radius
    GuiControlGet, newRadius, , RadiusInput
    if (newRadius is integer) && (newRadius >= 10) {  
        radius := newRadius
        ShowRadiusTooltip("Set Manually")
    } else {
        ToolTip, Invalid Input! Enter a number ≥ 10.
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

RemoveToolTip() {
    ToolTip
}

StopScript() {
    ToolTip, Stopping Script...
    SetTimer, ConfineMouse, Off
    Sleep, 1000
    ToolTip
    ExitApp
}

