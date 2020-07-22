---
layout: default
---
- [home](/index.md)
- [tools](/tools.md)

---
# jq
- <https://stedolan.github.io/jq/>
- <https://stedolan.github.io/jq/manual/>

```
cat file |jq 'keys' # to learn structure
cat file |jq '.items[0]|keys' # to learn structure

jq '{ user: .username, email: (.attributes[] | select(.name == "email") |.value)}'

cat mro.users |jq '{ user: .username, email: (.attributes[] | select(.name == "email") |.value), status: .user_status}'|jq '. | select(.status != "FORCE_CHANGE_PASSWORD")'

cat mro.users |jq -c '. | select(.user_status != "FORCE_CHANGE_PASSWORD")'|jq -c '{ user: .username, email: (.attributes[] | select(.name == "email") |.value), status: .user_status}'

npm search aws -json |jq '[.[] |{date,name,version}]'|jq 'sort_by(.date)'

# convert splunk output
cat from-splunk.json |jq '.result._raw|fromjson' |less
```