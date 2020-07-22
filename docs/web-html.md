---
layout: default
---
- [home](/index.md)
- [web](/web.md)
- [CSS](/web-css.md)
- [JS](/web-js.md)

---
# HTML

## Ref
- <https://developer.mozilla.org/en-US/docs/Glossary/HTML>
- <https://www.w3schools.com/html/>
- [bash href](https://www.w3.org/TR/html5/document-metadata.html#the-base-element)

## Check SSL Certs
```
echo |openssl s_client -connect localhost:443
echo |openssl s_client -host hostname.com -port 443
```
## sample index.html
```
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title></title>
    <base href="/">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/x-icon" href="favicon.ico">
    <script>
        var global = global || window;
    </script>
</head>
<body>
</body>
</html>
```
