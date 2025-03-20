; Get the width and height of the primary monitor
SysGet, MonitorWidth, 0  ; 0 is the ID for the primary monitor
SysGet, MonitorHeight, 1  ; 1 is the ID for the primary monitor's height

; Display the resolution in a message box
MsgBox, Monitor Resolution: %MonitorWidth% x %MonitorHeight%
