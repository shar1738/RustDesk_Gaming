#Persistent
#SingleInstance Force
SetBatchLines, -1
SetWinDelay, -1

; ------------------------------
; SETTINGS & CONFIGURATIONS
; ------------------------------

; Set the RustDesk window title (Adjust to match your setup)
WindowTitle := "" #your window name 

; Screen resolution (Modify if needed)
screenWidth := 1920
screenHeight := 1080

; Mouse movement sensitivity (Adjustable for smoother control)
Sensitivity := 2.0

; Delay in milliseconds for tracking mouse (Lower = faster response)
TrackingRate := 5

SetTimer, ConfineMouse, %TrackingRate%

; Variables to track previous mouse position
lastX := 0
lastY := 0

; Variable to toggle confinement on/off
ConfineMouseState := false

; ------------------------------
; MOUSE CONFINEMENT & WRAP-AROUND
; ------------------------------

ConfineMouse:
    if (ConfineMouseState = false)
        return

    ; Get RustDesk window position and size
    WinGetPos, winX, winY, winWidth, winHeight, %WindowTitle%

    ; If the window isn't found, stop execution
    if (winX = "" or winY = "")
        return

    ; Get current mouse position
    MouseGetPos, mouseX, mouseY

    ; Calculate window edges
    winRight := winX + winWidth
    winBottom := winY + winHeight

    ; Initialize last mouse position on the first run
    if (lastX = 0 and lastY = 0) {
        lastX := mouseX
        lastY := mouseY
    }

    ; Calculate mouse movement delta (distance moved)
    moveX := mouseX - lastX
    moveY := mouseY - lastY

    ; Apply sensitivity to movement (prevents sudden jumps)
    moveX *= Sensitivity
    moveY *= Sensitivity

    ; ------------------------------
    ; INFINITE WRAP-AROUND MOVEMENT
    ; ------------------------------

    ; When mouse reaches the left edge, teleport it to the right
    if (mouseX <= winX + 5) {
        MouseMove, winRight - 10, mouseY, 0
        lastX := winRight - 10
    }
    ; When mouse reaches the right edge, teleport it to the left
    else if (mouseX >= winRight - 5) {
        MouseMove, winX + 10, mouseY, 0
        lastX := winX + 10
    }
    ; Otherwise, update last X position
    else {
        lastX := mouseX
    }

    ; When mouse reaches the top edge, teleport it to the bottom
    if (mouseY <= winY + 5) {
        MouseMove, mouseX, winBottom - 10, 0
        lastY := winBottom - 10
    }
    ; When mouse reaches the bottom edge, teleport it to the top
    else if (mouseY >= winBottom - 5) {
        MouseMove, mouseX, winY + 10, 0
        lastY := winY + 10
    }
    ; Otherwise, update last Y position
    else {
        lastY := mouseY
    }

return

; ------------------------------
; TOGGLE CONFINEMENT HOTKEY (CTRL + T)
; ------------------------------
^t::
    ConfineMouseState := !ConfineMouseState  ; Toggle the confinement state
    if (ConfineMouseState) {
        Tooltip, Mouse confinement enabled
    } else {
        Tooltip, Mouse confinement disabled
    }
    SetTimer, RemoveTooltip, -1000  ; Remove tooltip after 1 second
return

RemoveTooltip:
    Tooltip
return

; ------------------------------
; EXIT HOTKEY (CTRL + k)
; ------------------------------

^k::
    DllCall("ClipCursor", "UInt", 0)  ; Free the mouse from any constraints
    ExitApp
return


