
# Issues

## Small black boxes graphic issue
- Disable: `Persistent bitmap caching` and delete files in `<AppData>\Local\Microsoft\Terminal Server Client\Cache`


## Remote Desktop: Sending Ctrl-Alt-Left Arrow/Ctrl-Alt-Right Arrow to the remote PC
https://superuser.com/questions/327866/remote-desktop-sending-ctrl-alt-left-arrow-ctrl-alt-right-arrow-to-the-remote-p

    ;Send Ctrl+Alt+Left keys when user types Ctrl+Win+Left
    ^#Left::
    send !^{Left}
    return

    ;Send Ctrl+Alt+Right keys when user types Ctrl+Win+Right
    ^#Right::
    send !^{Right}
    return

    ;Send Ctrl+Alt+Up keys when user types Ctrl+Win+Up
    ^#Up::
    send !^{Up}
    return

    ;Send Ctrl+Alt+Down keys when user types Ctrl+Win+Down
    ^#Down::
    send !^{Down}
    return

    ;Send Ctrl+Alt+Shift+Left keys when user types Ctrl+Win+Shift+Left
    ^#+Left::
    send !^+{Left}
    return

    ;Send Ctrl+Alt+Shift+Right keys when user types Ctrl+Win+Shift+Right
    ^#+Right::
    send !^+{Right}
    return

    ;Send Ctrl+Alt+Shift+Up keys when user types Ctrl+Win+Shift+Up
    ^#+Up::
    send !^+{Up}
    return

    ;Send Ctrl+Alt+Shift+Down keys when user types Ctrl+Win+Shift+Down
    ^#+Down::
    send !^+{Down}
    return
