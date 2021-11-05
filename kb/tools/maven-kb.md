
# Reference
- Pom Reference
https://maven.apache.org/pom.html
- Configuration Inheritance
https://maven.apache.org/pom.html#Plugins
https://maven.apache.org/pom.html#advanced_configuration_inheritance


# Password Encryption
https://maven.apache.org/guides/mini/guide-encryption.html


# test skip flags
-DskipTests
compile but don't run, doesn't work with all tests

-Dmaven.test.skip=true
don't compile and run

-Dmaven.test.skip.exec=true
compile but don't run, works with all tests


# Debug
https://maven.apache.org/configure.html
export MAVEN_OPTS="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005"
or
.mvn/jvm.config file:
-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005
(see also: java kb)

# versions
mvn versions:set -DnewVersion=1.0.9 -DgroupId=* -DartifactId=*
mvn versions:set -DnewVersion=1.0.9 -DgroupId=* -DartifactId=* -DoldVersion=*
mvn versions:revert


# evaluate
- evaluate any expression for pom data (e.g.: ${project.version}, ${some-prop} for properties in <properties>)
mvn help:evaluate
- just output result of expression
mvn help:evaluate -q -DforceStdout -Dexpression=default-prop -Pdev


# add sources / javadoc
mvn source:jar package
mvn javadoc:jar package

Alternative: Configuring plugins in pom to run automatically

<plugin>
  <groupId>org.apache.maven.plugins</groupId>
  <artifactId>maven-source-plugin</artifactId>
  <executions>
    <execution>
      <id>attach-sources</id>
      <goals>
        <goal>jar</goal>
      </goals>
    </execution>
  </executions>
</plugin>

<plugin>
  <groupId>org.apache.maven.plugins</groupId>
  <artifactId>maven-javadoc-plugin</artifactId>
  <executions>
    <execution>
      <id>attach-javadocs</id>
      <goals>
        <goal>jar</goal>
      </goals>
    </execution>
  </executions>
</plugin>

## Runtime Access Warnings/Errors
--add-opens <module>/<package>=ALL-UNNAMED

<plugin>
  <groupId>org.apache.maven.plugins</groupId>
  <artifactId>maven-surefire-plugin</artifactId>
  <version>3.0.0-M5</version>
  <configuration>
    <argLine>--add-opens java.base/java.lang=ALL-UNNAMED</argLine>
 </configuration>
</plugin>


# Process running
- Spring Boot process path limit
Run with
-Dspring-boot.run.fork=false
or configure plugin


# generate-sources
Generated sources in the directory ${project.build.directory}/generate-sources/<src_root> are recognized in Maven and IDEs (IntelliJ)
If using a different one, see build-helper-maven-plugin.


# Unrecognized source folder
- Maven pom.xml
<plugin>
  <groupId>org.codehaus.mojo</groupId>
  <artifactId>build-helper-maven-plugin</artifactId>
  <version>3.2.0</version>
  <executions>
    <execution>
      <id>add-source</id>
      <phase>generate-sources</phase>
      <goals>
        <goal>add-source</goal>
      </goals>
      <configuration>
        <sources>
          <source>SOURCE_FOLDER</source>
        </sources>
      </configuration>
    </execution>
  </executions>
</plugin>

Note: if using ${project.build.directory}/generated-sources it seems to be required to have a sub-folder (e.g. IntelliJ)
e.g.: ${project.build.directory}/generated-sources/<tool>


- IntelliJ
Project Structure → Modules → Click the generated-sources folder and make it a sources folder.

# Versions
mvn dependency:tree

mvn -Dplugin=: help:describe
e.g.:
mvn -Dplugin=org.jacoco:jacoco-maven-plugin help:describe

mvn help:effective-pom


# maven-blade-plugin
mvn com.backbase.oss:blade-maven-plugin:run


# Issues
The forked VM terminated without saying properly goodbye. VM crash or System.exit called
Add updated surefire to build/plugins (not build/dependencyManagement/plugins)
<plugin>
    <groupId>org.jacoco</groupId>
    <artifactId>jacoco-maven-plugin</artifactId>
    <version>0.8.6</version>
</plugin>
