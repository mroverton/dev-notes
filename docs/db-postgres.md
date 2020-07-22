---
layout: default
---
- [home](/index.md)
- [db](/db.md)

---
# Postgres Notes

## Start/Stop MacOS service
```
sudo -i
su - postgres
cd /Library/PostgreSQL/9.6/bin/
./pg_ctl -D /Library/PostgreSQL/9.6/data stop -s -m fast # stop
./pg_ctl -D /Library/PostgreSQL/9.6/data -l /Library/PostgreSQL/9.6/data/pg_log/postgresql-server.log start
launchctl remove com.edb.launchd.postgresql-9.6
```
