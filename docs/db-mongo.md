---
layout: default
---
- [home](/index.md)
- [db](/db.md)

---
# Mongo

```
mongodump --db dname --out `date '+%Y-%m-%d-mongo-'``hostname`
mongorestore --db dname --drop
mongorestore --host dev-set/10.1.5.32:27017 --db dname --drop
mongorestore --db dname --drop
mongorestore --host dev-set/10.1.5.32:27017 --db dname --drop path/to/files
mongo dname --eval 'db.systemProperties.update({"name" : "system-url"},{$set : {"value" : "https://HOST"}})'
time mongo dname --eval "db.runCommand( { repairDatabase: 1 } )"

# backup
mongodump --db dname --out $(date '+%Y-%m-%d-%H%M%S-dname')

# restore
mongorestore --db dname --drop
mongo dname --eval 'db.systemProperties.update({"name" : "system-url"},{$set : {"value" : "https://host.com"}})'
```
