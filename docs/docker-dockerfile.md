- [docker](/docker.md)
---
# Dockerfile and Build Notes

## Reduced image size
```
RUN true \
&& apt-get install --no-install-recommends --no-install-suggests -y a b c \
&& rm -rf /var/lib/apt/lists/* \
\
&& if [ -n "$tempDir" ]; then \
    apt-get purge -y --auto-remove \
    && rm -rf "$tempDir" /etc/apt/sources.list.d/temp.list; \
fi \
&& true
```