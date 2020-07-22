---
layout: default
---
- [home](/index.md)
- [lang](/lang.md)
---
# Java notes

[[Spring|lang-java-spring]]

## jstatd in openjdk:8-alpine container
```
cat > /jstatd.all.policy <<EOF
grant codebase "file:${java.home}/../lib/tools.jar" {
   permission java.security.AllPermission;
};
EOF
jstatd -p 55000 -J-Djava.security.policy=/jstatd.all.policy
jstatd -p 55000 -J-Djava.security.policy=$(echo 'grant codebase "file:${java.home}/../lib/tools.jar" {permission java.security.AllPermission;};')
jconsole
service:jmx:rmi:///jndi/rmi://10.0.0.5:9090/jmxrmi
```

## sample docker-compose setup
```
  svc1:
    command: java -Xmx1G -Dcom.sun.management.jmxremote.rmi.port=9090 \
-Dcom.sun.management.jmxremote=true \
-Dcom.sun.management.jmxremote.port=9090 \
-Dcom.sun.management.jmxremote.ssl=false \
-Dcom.sun.management.jmxremote.authenticate=false \
-Dcom.sun.management.jmxremote.local.only=false \
-Djava.rmi.server.hostname=10.0.0.5 \
-jar my.war
```

## Run one-liner scripts
```
jrunscript -e "print (javax.crypto.Cipher.getMaxAllowedKeyLength('AES'))"
```

## Main
```
class MyClass {
	public static void main(String[] args) {}
}
```

## Thread
```
threads[i] = new Thread("Thread_" + some_num) {
    @Override
    public void run() {}
};
threads[i].start();

for (int i = 0; i < threads.length; i++) {
    try { threads[i].join(); } catch(InterruptedException ex) {}
}
```

# IO
- Bytes FileInputStream
- Chars FileReader -> BufferedReader
        FileWriter -> PrintWriter


# Streams
```
Files.walk(Paths.get("/path/to/stuff/"))
     .filter(p -> p.toString().endsWith(".ext"))
     .map(p -> p.getParent().getParent())
     .distinct()
     .forEach(System.out::println);

try (Stream<String> lines = Files.lines(file, Charset.defaultCharset())) { 
 lines.forEachOrdered(System.out::println); }
```


# Read a file
```
FileInputStream fstream = new FileInputStream("textfile.txt");
BufferedReader br = new BufferedReader(new InputStreamReader(fstream));
String strLine;
while ((strLine = br.readLine()) != null) { System.out.println (strLine);}
fstream.close();
```
