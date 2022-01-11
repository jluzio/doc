
## Issues with copy text becoming unformatted
https://github.com/microsoft/terminal/issues/52
@strarsis are you holding shift while you're copying (via right click)? In conhost, when the user holds shift while copying, we won't "trim whitespace", leaving the space at the end of the line as part of the copied text. This also applies to using ctrl+shift+c for copying from conhost.