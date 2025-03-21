#SingleInstance Force
#Persistent
SetTitleMatchMode, 2  ; Allows partial matching of window titles

global selectedWindow := ""

Gui, Add, ListBox, vWindowList x20 y20 w300 h200 gSelectWindow
Gui, Add, Button, x20 y230 w140 h30 gRefreshWindowList, Refresh List
Gui, Add, Button, x180 y230 w140 h30 gCopyToClipboard, Copy to Clipboard
Gui, Add, Button, x20 y270 w300 h30 gExitScript, Exit

RefreshWindowList()
Gui, Show, x200 y200 w350 h320, Select a Window

RefreshWindowList() {
    GuiControl,, WindowList,  ; Clear ListBox
    WinGet, windowList, List  ; Get all window handles

    Loop, %windowList% {
        WinGetTitle, title, % "ahk_id " windowList%A_Index%
        if (title != "")  ; Ignore empty titles
            GuiControl, , WindowList, %title%
    }
}

SelectWindow() {
    GuiControlGet, selectedWindow,, WindowList
}

CopyToClipboard() {
    GuiControlGet, selectedWindow,, WindowList
    if (selectedWindow != "") {
        Clipboard := selectedWindow
        MsgBox, Window Name Copied: %selectedWindow%
    } else {
        MsgBox, Please select a window first.
    }
}

; Double-click to copy
GuiControlGet, selectedWindow,, WindowList
GuiControl, +gCopyToClipboard, WindowList

; Ctrl+C hotkey to copy
^c::
    CopyToClipboard()
    return

ExitScript() {
    ExitApp
}

Return
