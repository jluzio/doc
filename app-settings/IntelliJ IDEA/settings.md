# Plugins

## Useful
- Lombok
- Rainbow Brackets
- Spring Boot Assistant
- MapStruct Support
- Maven Helper
- Codota
- Sonar Lint
- Docker
- String Manipulation
- CheckStyle-IDEA
- EduTools
- Apache Camel

## Can be useful
- Swagger
- Grep Console
- BashSupport
- Key Promoter X
- Request Mapper
- Database Navigator

## Can be useful someday
- Spring Tools

# Decompiler correct line numbers
Registry (open in Actions)
```
decompiler.dump.original.lines=true
```

# Formatter off/on
Code Style -> Formatter -> Turn formatter on/off with markers in code comments
//@formatter:off
//@formatter:on

# Spring Initializr and Assistant
https://github.com/eltonsandre/intellij-spring-assistant
https://plugins.jetbrains.com/plugin/18622-spring-initializr-and-assistant

May require additional configuration in IntelliJ, such as enabling Annotation Processing or even using Maven/Gradle when building.

For Maven, the pom.xml file must include:
```xml
<dependency>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-configuration-processor</artifactId>
  <optional>true</optional>
</dependency>
```
Also, the compile plugin must be using this annotation processor.

## Issues
* IntelliJ/Plugin might not recognize the configuration metadata until refreshing the project (forcing to process the Build files) or building and refreshing.
