# Export/Import
- export
wsl --export <image-name> <export-file>
- import
wsl --import <image-name> <wsl-distro-storage-folder> <export-file>

export-file: distro.tar
wsl-distro-storage-folder: C:\wslDistroStorage\<distro>

## Issues with copy text becoming unformatted
https://github.com/microsoft/terminal/issues/52
@strarsis are you holding shift while you're copying (via right click)? In conhost, when the user holds shift while copying, we won't "trim whitespace", leaving the space at the end of the line as part of the copied text. This also applies to using ctrl+shift+c for copying from conhost.

# mount usb flash drive in WSL
> https://www.scivision.dev/mount-usb-drives-windows-subsystem-for-linux/

- Inside the wsl distribution
(may not require sudo depending on permissions or parameters)
~~~bash
sudo mkdir /mnt/f
sudo mount -t drvfs f: /mnt/f
~~~