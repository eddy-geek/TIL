I wanted to use to get column statistics with

`parquet-tools column-size foo.parquet`

but the [PARQUET-1821: Add 'column-size' command](https://github.com/apache/parquet-mr/commit/d00b2f105f9f732e310ed43c7bfb318213e1ac81) is (was?) not released yet.

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

Nte that this will take ages especially "Parquet Column"

```
[INFO] Reactor Summary for Apache Parquet MR 1.12.0-SNAPSHOT:
[INFO] 
[INFO] Apache Parquet MR .................................. SUCCESS [  2.261 s]
[INFO] Apache Parquet Format Structures ................... SUCCESS [ 11.821 s]
[INFO] Apache Parquet Generator ........................... SUCCESS [ 13.160 s]
[INFO] Apache Parquet Common .............................. SUCCESS [ 34.010 s]
[INFO] Apache Parquet Encodings ........................... SUCCESS [  8.854 s]
[INFO] Apache Parquet Column .............................. SUCCESS [23:31 min]
[INFO] Apache Parquet Arrow ............................... SUCCESS [ 47.884 s]
[INFO] Apache Parquet Jackson ............................. SUCCESS [ 24.727 s]
[INFO] Apache Parquet MR .................................. SUCCESS [  2.352 s]
[INFO] Apache Parquet Format Structures ................... SUCCESS [  2.402 s]
[INFO] Apache Parquet Generator ........................... SUCCESS [  1.102 s]
[INFO] Apache Parquet Common .............................. SUCCESS [  1.660 s]
[INFO] Apache Parquet Encodings ........................... SUCCESS [  6.983 s]
[INFO] Apache Parquet Column .............................. SUCCESS [  7.452 s]
[INFO] Apache Parquet Arrow ............................... SUCCESS [  0.465 s]
[INFO] Apache Parquet Jackson ............................. SUCCESS [  0.942 s]
[INFO] Apache Parquet Hadoop .............................. SUCCESS [  4.536 s]
[INFO] Apache Parquet Avro ................................ SUCCESS [01:00 min]
[INFO] Apache Parquet Benchmarks .......................... SUCCESS [ 34.025 s]
[INFO] Apache Parquet Pig ................................. SUCCESS [01:45 min]
[INFO] Apache Parquet Thrift .............................. SUCCESS [ 33.318 s]
[INFO] Apache Parquet Cascading ........................... SUCCESS [ 28.279 s]
[INFO] Apache Parquet Cascading (for Cascading 3.0 onwards) SUCCESS [ 18.008 s]
[INFO] Apache Parquet Command-line ........................ SUCCESS [ 13.917 s]
[INFO] Apache Parquet Pig Bundle .......................... SUCCESS [  0.896 s]
[INFO] Apache Parquet Protobuf ............................ SUCCESS [02:46 min]
[INFO] Apache Parquet Scala ............................... SUCCESS [02:37 min]
[INFO] Apache Parquet Scrooge ............................. SUCCESS [01:34 min]
[INFO] Apache Parquet Hadoop Bundle ....................... SUCCESS [  1.033 s]
[INFO] Apache Parquet Hive ................................ SUCCESS [  0.043 s]
[INFO] Apache Parquet Hive Binding Parent ................. SUCCESS [  0.027 s]
[INFO] Apache Parquet Hive Binding Interface .............. SUCCESS [  7.926 s]
[INFO] Apache Parquet Hive 0.10 Binding ................... SUCCESS [02:48 min]
[INFO] Apache Parquet Hive 0.12 Binding ................... SUCCESS [ 46.695 s]
[INFO] Apache Parquet Hive Binding Factory ................ SUCCESS [  0.130 s]
[INFO] Apache Parquet Hive Binding Bundle ................. SUCCESS [ 12.829 s]
[INFO] Apache Parquet Hive Storage Handler ................ SUCCESS [  0.510 s]
[INFO] Apache Parquet Hive Bundle ......................... SUCCESS [  0.994 s]
[INFO] Apache Parquet Tools ............................... SUCCESS [ 24.509 s]
```

* you're good to go

`java -jar parquet-tools/target/parquet-tools-1.12.0-SNAPSHOT.jar column-size --help`
