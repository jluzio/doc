
# Include in Windows Terminal/etc
sh --login -i

## Solve strange characters (colors/unicode)
[2021-09] The shell currently used in git-bash (msys2) has issues with characters representing colors or other "special" unicode.
The current workaround is to change the active console code page to the UTF-8 code page.

`chcp 65001`

https://github.com/git-for-windows/git/issues/2806
https://stackoverflow.com/a/65688816/13181895
