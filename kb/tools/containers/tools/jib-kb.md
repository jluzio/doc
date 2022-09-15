# JIB
## References
- https://github.com/GoogleContainerTools/jib
- https://github.com/GoogleContainerTools/jib/tree/master/jib-maven-plugin
- https://github.com/GoogleContainerTools/jib-extensions
- https://github.com/GoogleContainerTools/jib-extensions/tree/master/first-party/jib-layer-filter-extension-maven


## Example for extending an image and removing added files
```
<profile>
  <id>docker-image-dev</id>
  <build>
    <plugins>
      <plugin>
        <groupId>com.google.cloud.tools</groupId>
        <artifactId>jib-maven-plugin</artifactId>
        <version>3.2.0</version>
        <dependencies>
          <dependency>
            <groupId>com.google.cloud.tools</groupId>
            <artifactId>jib-layer-filter-extension-maven</artifactId>
            <version>0.2.0</version>
          </dependency>
        </dependencies>
        <executions>
          <execution>
            <phase>package</phase>
            <goals>
              <goal>dockerBuild</goal>
            </goals>
            <configuration>
              <to>
                <image>some-image-name:some-tag</image>
              </to>
              <from>
                <image>some-remote-image:some-tag</image>
              </from>
              <container>
                <entrypoint>INHERIT</entrypoint>
              </container>
              <extraDirectories>
                <paths>
                  <path>
                    <from>target</from>
                    <into>/providers</into>
                    <includes>
                      <include>some-jar.jar</include>
                    </includes>
                  </path>
                </paths>
              </extraDirectories>
              <pluginExtensions>
                <pluginExtension>
                  <implementation>com.google.cloud.tools.jib.maven.extension.layerfilter.JibLayerFilterExtension</implementation>
                  <configuration
                    implementation="com.google.cloud.tools.jib.maven.extension.layerfilter.Configuration">
                    <filters>
                      <!-- Delete all files included by JIB (from dependencies). -->
                      <filter>
                        <glob>/app/**</glob>
                      </filter>
                    </filters>
                  </configuration>
                </pluginExtension>
              </pluginExtensions>
            </configuration>
          </execution>
        </executions>
      </plugin>
    </plugins>
  </build>
</profile>
```
