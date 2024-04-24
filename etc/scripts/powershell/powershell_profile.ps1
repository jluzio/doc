
Set-Variable -Name DEV_SRC -Value c:\dev\source
Set-Variable -Name DEV_DOC -Value c:\dev\doc
Set-Variable -Name DEV_HOME -Value c:\home
Set-Variable -Name DEV_ETC -Value c:\dev\etc

Set-Variable -Name JAVA_CANDIDATES_FOLDER -Value "C:\Users\jluzio\.sdkman\candidates\java"
function set-java { [System.Environment]::SetEnvironmentVariable("JAVA_HOME", "$JAVA_CANDIDATES_FOLDER\$args") }
function java-8 { set-java 8.0.292.hs-adpt }
function java-default { set-java current }

Set-Variable -Name SDKMAN_SPRINGBOOT -Value C:\Users\jluzio\.sdkman\candidates\springboot\current\bin
$env:Path += ";" + $SDKMAN_SPRINGBOOT

# Custom Keys
Set-PSReadLineKeyHandler -Key Ctrl+u -Function BackwardDeleteLine
Set-PSReadlineKeyHandler -Key ctrl+d -Function ViExit
