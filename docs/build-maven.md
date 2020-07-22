- [[home]]
- [[build]]
---
http://docs.codehaus.org/display/MAVENUSER/Multi-modules+projects
http://docs.codehaus.org/display/MAVENUSER/Dependency+Mechanism
http://www.ibm.com/developerworks/java/library/j-5things13/index.html
http://maven.apache.org/plugins/maven-deploy-plugin/
http://maven.apache.org/plugins/maven-deploy-plugin/deploy-file-mojo.html
http://maven.apache.org/maven-release/maven-release-plugin/

## Search for packages
- http://search.maven.org

## Skip Tests
```
-Dmaven.test.skip=true # will not compile or run tests
-DskipTests            # will compile but not run tests
```

## Check versions 
```
mvn versions:display-dependency-updates

mvn archetype:generate -DgroupId=com.mycompany.app -DartifactId=my-app -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
```

## resume a broken build
```
mvn <goals> -rf :<last step>
./mvnw -Dmaven.test.skip=true clean install -rf :mydairycentral-ui
```
## install maven wrapper mvnw
```
mvn -N io.takari:maven:wrapper
```

## Get name
```
mvn help:evaluate -Dexpression=project.name | grep "^[^\[]"
```
## Get version
```
mvn help:evaluate -Dexpression=project.version | grep "^[^\[]"
```

## Get plugin help
```
mvn help:describe -Dplugin=pluginname
```

## Run spring with profiles
```
SPRING_PROFILES_ACTIVE=cfg-consul mvn -Dmaven.test.skip=true spring-boot:run
```
