#Requires AutoHotkey v2.0

delayRate := 1000

expImg := "exp.bmp"
itemImg := "item.bmp"
completeImg := "complete.bmp"
exitImg := "exit.bmp"
xImg := "x.bmp"

NobDelay(sec) {
	Sleep sec * delayRate
}

FindImg(imgPath) {
    FoundX := 0
    FoundY := 0
    try {
            if ImageSearch(&FoundX, &FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, imgPath)
            {
                OutputDebug "img found"
                return true
            }
            return false
    } catch {
        OutputDebug "IMG ERROR"
    }
    return false
}

EnterBattle() {
    Send "{w down}"
    NobDelay(1)
    Send "{w up}"
    NobDelay(1)
    Send "{enter}"
    NobDelay(1)
    Send "{enter}"
    NobDelay(3)
}

Battle(){
    While !FindImg(expImg) {
        NobDelay(1)
    }
    Send "{enter}"
    While FindImg(expImg) {
        NobDelay(1)
        Send "{enter}"
        NobDelay(1)
    }
    NobDelay(3)
    if FindImg(itemImg) {
        NobDelay(1)
        Send "{enter}"
        NobDelay(1)
    }
    ; wait exit battle
    NobDelay(5)
}

ClearComplete() {
    NobDelay(3)
    col := 0
    Loop 3 {
        if "CACACA" == PixelGetColor(529, 82) {
            MouseClick "left", 529, 82
            NobDelay(1)
            MouseClick "left", 529, 82
            NobDelay(1)
            return
        }
        NobDelay(2)
    }
}

OpenBako() {
    NobDelay(3)
    Send "{esc}"
    NobDelay(1)
    Send "{w down}"
    NobDelay(1)
    Send "{w up}"
    NobDelay(1)
    Send "{enter}"
    NobDelay(1)
    Send "{enter}"
    NobDelay(3)
    Send "{enter}"
    NobDelay(1)
}

NextFloor() {
    Send "{w down}"
    NobDelay(3)
    Send "{w up}"
    NobDelay(1)
    Send "{enter down}"
    Sleep 100
    Send "{enter up}"
    Sleep 500
    Send "{Left down}"
    Sleep 100
    Send "{Left up}"
    NobDelay(2)
    Send "{enter down}"
    Sleep 100
    Send "{enter up}"
    Sleep 500
    Send "{enter down}"
    Sleep 100
    Send "{enter up}"
    NobDelay(10)
}

if WinExist("Nobunaga") {
    WinActivate
} else {
	Pause
}

; Wait for the game to load
NobDelay(2)
CoordMode "Pixel", "Window"


; main loop
Loop {
    EnterBattle()
    Battle()
    OpenBako()
    NextFloor()
}
