---
layout: default
---
- [home](/index.md)
- [tools](/tools.md)
---
```
awk 'BEGIN { SUM = 0 } // { SUM += $2 } END { printf("%.2f\n",SUM / NR) }'

awk -F'|' \
'BEGIN { SUM = 0 } // { if ($3 == 1151 && $4 > 0 && $5 == "+")  SUM += $4 } END { printf("%.2f\n",SUM) }’ \
my_posted_bbb.txt

awk '/Start Extra .* Records/,/End Extra .* Records/{print}' *Post*

awk '/^Extra/,/---/{print}' file

# Progress
while true; do clear; date; tail -1 deltaLoad.log |awk '{print ($3/$5) * 100 "%"}'; sleep 10; done
```
