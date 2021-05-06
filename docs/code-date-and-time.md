---
layout: default
---
- [home](/index.md)

---
# Date and Time Manipulation

- Never forget there are two dates at all times!

## Convert text from one timezone to another
```
TZ="UTC"                 date --date='TZ="America/Los_Angeles" 2014-09-21 22:00:06' '+%Y-%m-%d %T' # linux
TZ="America/Los_Angeles" date --date='TZ="UTC" 2014-09-21 22:00:06' '+%Y-%m-%d %T'                 # linux
TZ="America/Denver"      date --date='TZ="UTC" 00:00:00' '+%Y-%m-%d %T'                            # linux
date -j -f "%m-%d-%Y %H:%M:%S %Z" "12-02-2013 23:00:00 America/Los_Angeles" "+%m-%d-%Y %H:%M:%S"   # mac
```

## Date to ms
```
date --date='TZ="America/Los_Angeles" 2014-09-21 23:00:00' '+%s000'               # linux
TZ="America/Los_Angeles" date -j -f "%Y-%m-%d %T" "2014-03-12 23:00:00" "+%s000"  # mac
```

## Convert milliseconds to date
```
TZ="America/Los_Angeles" date -r `expr 1366727538749 '/' 1000`  # mac

date --date=@<seconds> # linux
date -d @1620324590


# mac
TZ=America/Los_Angeles date -r 1390948560
TZ=America/Denver      date -r 1390948560
TZ=UTC                 date -r 1390948560
```

## Various formatting
```
# linux or mac
TZ=America/Los_Angeles date '+%FT%T%z'

# Add/Sub days
date -d -30days '+%Y%m%d%H%M%S' # linux

# mysql client Only works on Linux
SET time_zone = 'America/Los_Angeles';
```
## NTP
```
watch -n2 ntpq --numeric --peers

## Golang parse time/date
- https://golang.org/pkg/time/#Parse

```
