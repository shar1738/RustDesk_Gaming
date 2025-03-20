#SingleInstance Force  ; Prevent multiple script instances
#Persistent  ; Keep the script running
SetTimer, ConfineMouse, 5  ; Check mouse position every 5ms for smooth movement

; Initialize the radius for the invisible boundary circle
radius := 250  ; Default radius for confinement circle

; Variable to track whether the mouse is confined or not
isConfined := true

; Hotkey to toggle confinement (Ctrl + T)
^t::
    isConfined := !isConfined  ; Toggle the confinement
    statusText := (isConfined ? "ON" : "OFF")
    ToolTip, Mouse Confinement: %statusText%  ; Show current status
    SetTimer, RemoveToolTip, -1000  ; Remove tooltip after 1 second
return

; Hotkey to increase the radius (Ctrl + Up)
^Up::
    radius += 10
    ToolTip, Radius Increased to: %radius%
    SetTimer, RemoveToolTip, -1000
return

; Hotkey to decrease the radius (Ctrl + Down)
^Down::
    radius -= 10
    if (radius < 50)  ; Prevent radius from becoming too small
        radius := 50
    ToolTip, Radius Decreased to: %radius%
    SetTimer, RemoveToolTip, -1000
return

; Hotkey to reset radius (Ctrl + R)
^r::
    radius := 250  ; Reset radius to default value
    ToolTip, Radius Reset to Default: %radius%
    SetTimer, RemoveToolTip, -1000
return

ConfineMouse:
    if (!isConfined)
        return

    ; Dynamically calculate the center of the screen
    SysGet, ScreenWidth, 0
    SysGet, ScreenHeight, 1
    centerX := ScreenWidth / 2
    centerY := ScreenHeight / 2

    ; Get the current mouse position
    MouseGetPos, mouseX, mouseY
    dx := mouseX - centerX
    dy := mouseY - centerY
    distance := Sqrt(dx * dx + dy * dy)

    ; Prevent the mouse from moving outside the circle's boundary
    if (distance > radius)
    {
        ; Limit mouse movement to the circle's edge
        factor := radius / distance
        newX := centerX + (dx * factor)
        newY := centerY + (dy * factor)
        MouseMove, %newX%, %newY%, 0  ; Move the mouse to the circle's edge
    }
return

RemoveToolTip:
    ToolTip  ; Clear any displayed tooltip
return

; Ensure 'Ctrl + K' stops everything immediately
^k::
    SetTimer, ConfineMouse, Off  ; Stop the confinement timer
    ExitApp  ; Exit the script
return
