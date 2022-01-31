# Useful info

## Tools
- GitBash
- Cygwin
- Sdkman
- ConEmu
- Chocolatey

### Chocolatey
- gsudo: windows version of sudo
https://github.com/gerardog/gsudo

### 7zip with filters
7z a -tzip <archive> <target> -r -x!<exclude1> -x!<excludeN>

### Tools with Windows Subsystem for Linux
- Ubuntu

https://www.howtogeek.com/266621/how-to-make-windows-10-accept-file-paths-over-260-characters/
- Enable LongPathsEnabled:
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem]
"LongPathsEnabled"=dword:00000001
- Disable LongPathsEnabled (default):
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem]
"LongPathsEnabled"=dword:00000000


## Directory Links
- cmd:
mklink /D <link> <target-directory>
mklink /J <link> <target-directory>
- powershell:
New-Item -Path <link> -ItemType SymbolicLink -Target <target>


### Force install on other drives with links
- identify install directories
- create these on target location
- use a directory link in default install directories to trick installer to save files on target location
e.g.:
mklink /J <link> <target-directory>


## Kill processes
taskkill /IM "process name" /F


## Java
- remove Path element "C:\Program Files (x86)\Common Files\Oracle\Java\javapath" or similar
- set JAVA_HOME
- set PATH += JAVA_HOME\bin
- close apps that might hold environment references (e.g. IDEs)
- kill explorer
- start explorer


Spring Boot and long classpaths
- -Dspring-boot.run.fork=false

## PowerShell
### Profile
- Test-Path $Profile
- New-Item -Path $Profile -Type File -Force
- change $Profile target file
### Source
. <file.ps1>
### Escape params
Some flags use -<letter><value> but PowerShell doesn't like it.
Use '' to escape values for flags.
e.g.: cmd '-P*.txt'


## Config
- Default Save Locations: locations for new apps (change to other drive if C has low storage space)
- Apps & Features
 - Windows Apps may have the option to move to other drives

## Network config
- see reserved/excluded port ranges
netsh interface ipv4 show excludedportrange protocol=tcp

- modify reserved/excluded port ranges
netsh int ipv4 add excludedportrange protocol=tcp startport=<port> numberofports=1
netsh int ipv4 del excludedportrange protocol=tcp startport=<port> numberofports=1

- apps that reserve ports
https://superuser.com/questions/1579346/many-excludedportranges-how-to-delete-hyper-v-is-disabled/1610009#1610009
This is often caused by the Windows NAT Driver (winnat), stopping and restarting that service may resolve the issue.
net stop winnat
docker start ...
net start winnat

see also:
(IntelliJ)
https://youtrack.jetbrains.com/issue/IDEA-238995?_ga=2.91342814.590959948.1620758678-338863376.1610549135
net stop winnat
net start winnat


## IntelliJ
- Lombok & MapStruct workaround
https://github.com/mplushnikov/lombok-intellij-plugin/issues/952#issuecomment-741821327
-Djps.track.ap.dependencies=false

- Lombok & MapStruct fix
  - use lib versions
<org.mapstruct.version>1.4.1.Final</org.mapstruct.version>
<lombok.version>1.18.16</lombok.version>

  - add annotation processor lib to compiler
<lombok-mapstruct-binding.version>0.2.0</lombok-mapstruct-binding.version>

  - configure compiler
<plugin>
  <groupId>org.apache.maven.plugins</groupId>
  <artifactId>maven-compiler-plugin</artifactId>
  <version>3.8.1</version>
  <configuration>
    <compilerArgs>
      <arg>--enable-preview</arg>
    </compilerArgs>
    <!-- Needed to redefine annotation processors due to MapStruct -->
    <annotationProcessorPaths>
      <path>
        <groupId>org.mapstruct</groupId>
        <artifactId>mapstruct-processor</artifactId>
        <version>${org.mapstruct.version}</version>
      </path>
      <path>
        <groupId>org.projectlombok</groupId>
        <artifactId>lombok</artifactId>
        <version>${lombok.version}</version>
      </path>
      <path>
        <groupId>org.projectlombok</groupId>
        <artifactId>lombok-mapstruct-binding</artifactId>
        <version>${lombok-mapstruct-binding.version}</version>
      </path>
    </annotationProcessorPaths>
  </configuration>
</plugin>

# hosts
C:\Windows\System32\Drivers\etc\hosts
