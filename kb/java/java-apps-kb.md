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

SDKMAN

# Debug
Java 5-8: -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005
Java 9+: -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005

- suspend=y|n
Wait or don't wait for attach to start

## Maven
https://maven.apache.org/configure.html
MAVEN_OPTS="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005"
or
.mvn/jvm.config file:
-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005

## Spring
https://docs.spring.io/spring-boot/docs/current/maven-plugin/reference/htmlsingle/#run.examples
(example with suspending at start)
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
or
mvn spring-boot:run -Dspring-boot.run.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005"
