---
layout: default
---
- [home](/index.md)
- [build](/build.md)

# Jenkins Notes

## Remove Old Jobs
```
import hudson.model.*

for(item in Hudson.instance.items) {
    if (!item.isBuilding()) {
        println("Deleting old builds of job " + item.name)
        for (build in item.getBuilds()) {
            //delete all except the last
            if (build.getNumber() < item.getLastBuild().getNumber()) {
                println "delete " + build
                try {
                    build.delete()
                } catch (Exception e) {
                    println e
                }
            }
        }
    } else {
        println("Skipping job " + item.name + ", currently building")
    }
}
```

## remove workspaces
```
import hudson.model.*
// For each project
for(item in Hudson.instance.items) {
  // check that job is not building
  if(!item.isBuilding()) {
    println("Wiping out workspace of job "+item.name)
    item.doDoWipeOutWorkspace()
  }
  else {
    println("Skipping job "+item.name+", currently building")
  }
}
```

## Get initial admin password from jenkins container
```
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```

