
Set-Variable -Name DEV_SRC -Value d:\dev\source
Set-Variable -Name DEV_DOC -Value d:\dev\doc
Set-Variable -Name DEV_HOME -Value d:\home
Set-Variable -Name DEV_ETC -Value d:\dev\etc

Set-Variable -Name JAVA_CANDIDATES_FOLDER -Value "d:\dev\tools\.sdkman\candidates\java"
function set-java { [System.Environment]::SetEnvironmentVariable("JAVA_HOME", "$JAVA_CANDIDATES_FOLDER\$args") }
function java-8 { set-java 8.0.252.hs-adpt }
function java-default { set-java jdk-default }
