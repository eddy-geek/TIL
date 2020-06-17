* Clone

`git clone https://github.com/apache/parquet-format`

* Change thrift version (for example conda install throft will give you 2.13 ; while apt-get install thrift-compiler will give you [different versions](https://packages.ubuntu.com/search?keywords=thrift-compiler&searchon=names))

```
parquet-tools ❯❯❯ gd | cat
diff --git i/pom.xml w/pom.xml
index 2ee4bd251..6a44f9b5b 100644
--- i/pom.xml
+++ w/pom.xml
@@ -94,8 +94,8 @@
     <thrift-maven-plugin.version>0.10.0</thrift-maven-plugin.version>
-    <thrift.version>0.12.0</thrift.version>
-    <format.thrift.version>0.12.0</format.thrift.version>
+    <thrift.version>0.13.0</thrift.version>
+    <format.thrift.version>0.13.0</format.thrift.version>
     <fastutil.version>8.2.3</fastutil.version>
     <semver.api.version>0.9.33</semver.api.version>
     <slf4j.version>1.7.22</slf4j.version>
```

* Build everything
 
 `mvn package -Plocal -DskipTests`
 
We build everything because parquet-tools pre-release depends on the same pre-release version (e.g. `1.12.0-SNAPSHOT`) for some dependencies like parquet-format and parquet itself.
 
So if you try building the master branch it fails with stuff like':
 
 > Failed to transfer file: .../org/apache/parquet/parquet/1.12.0-SNAPSHOT/parquet-1.12.0-SNAPSHOT.pom. Return code is: 409 , ReasonPhrase:Conflict.

Instead you can further tweak the versions in parquet-mr/pom.xml and also parquet-mr/parquet-tools/pom.xml as [here](https://mapr.com/support/s/article/How-to-build-and-use-parquet-tools-to-read-parquet-files)... if you think versions are source-compatible.

I added -DskipTests to work around this:

>   testZstdConfWithMr(org.apache.parquet.hadoop.TestZstandardCodec): Job failed!

> [INFO] Apache Parquet Hadoop .............................. FAILURE [05:01 min]

