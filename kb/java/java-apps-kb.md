# REPL
 - JShell (Java 9)

# IDE

## Eclipse
### Config
- Marketplace: Java 14 Support for Eclipse
- Gradle Java 14: https://download.eclipse.org/buildship/updates/e415/releases/3.x/3.1.4.v20200326-1743

### eclipse.ini
-vm
D:/dev/tools/Java/jdk-14.0.1/bin/javaw.exe

# SDKMAN
SDKMAN: https://sdkman.io/
- install on Windows
install with Git Bash to enable all functionality
dependencies install:
chocolatey install zip -y
chocolatey install unzip -y

- automatic switching
https://sdkman.io/usage#config
$HOME/.sdkman/etc/config
sdkman_auto_env=true
https://blog.mrhaki.com/2020/10/automatic-switching-of-java-versions.html

# Debug
Java 5-8: -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005
Java 9+: -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005

- suspend=y|n
Wait or don't wait for attach to start

## Maven
https://maven.apache.org/configure.html
export MAVEN_OPTS="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005"
or
.mvn/jvm.config file:
-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005

## Spring
https://docs.spring.io/spring-boot/docs/current/maven-plugin/reference/htmlsingle/#run.examples

Example with suspending at start
```xml
<project>
  <build>
    <plugins>
      <plugin>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-maven-plugin</artifactId>
        <configuration>
          <jvmArguments>
            -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005
          </jvmArguments>
        </configuration>
      </plugin>
    </plugins>
  </build>
</project>
```
or
```bash
mvn spring-boot:run -Dspring-boot.run.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005"
```

## Spring Boot + Lombok + MapStruct

```xml
<!-- Core Tools and Annotation processors -->
<dependency>
  <groupId>org.projectlombok</groupId>
  <artifactId>lombok</artifactId>
  <version>${lombok.version}</version>
  <scope>provided</scope>
</dependency>
<dependency>
  <groupId>org.mapstruct</groupId>
  <artifactId>mapstruct</artifactId>
  <version>${org.mapstruct.version}</version>
</dependency>
<dependency>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-configuration-processor</artifactId>
  <optional>true</optional>
</dependency>
<dependency>
  <groupId>org.mapstruct</groupId>
  <artifactId>mapstruct-processor</artifactId>
  <version>${org.mapstruct.version}</version>
</dependency>
<dependency>
  <groupId>org.projectlombok</groupId>
  <artifactId>lombok-mapstruct-binding</artifactId>
  <version>${lombok-mapstruct-binding.version}</version>
</dependency>
```

## Runtime Access Warnings/Errors
--add-opens <module>/<package>=ALL-UNNAMED
--add-opens java.base/java.lang=ALL-UNNAMED
java.base does not "opens java.lang"

if multiple: --add-opens <module>/<package1>=ALL-UNNAMED --add-opens <module>/<package2>=ALL-UNNAMED ...
