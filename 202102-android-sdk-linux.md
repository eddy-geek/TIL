Installing android tools without android studio in 2021 is still needlessly convoluted, but here we go.

We are aiming at this:

```java
$ sdkmanager --list_installed
  Path               | Version | Description                    | Location
  -------            | ------- | -------                        | -------
  build-tools;30.0.3 | 30.0.3  | Android SDK Build-Tools 30.0.3 | build-tools/30.0.3/
  emulator           | 30.3.5  | Android Emulator               | emulator/
  patcher;v4         | 1       | SDK Patch Applier v4           | patcher/v4/
  platform-tools     | 30.0.5  | Android SDK Platform-Tools     | platform-tools/
  
$ ls $ANDROID_SDK_ROOT/cmdline-tools/latest/bin $ANDROID_SDK_ROOT/tools/bin $ANDROID_SDK_ROOT/platform-tools/ $ANDROID_SDK_ROOT/build-tools/30.0.3

.../android-sdk/cmdline-tools/latest/bin:
apkanalyzer  avdmanager  lint  screenshot2  sdkmanager

.../android-sdk/tools/bin:
apkanalyzer  archquery  avdmanager  jobb  lint  monkeyrunner  screenshot2  sdkmanager  uiautomatorviewer

.../android-sdk/platform-tools/:
api dmtracedump e2fsdroid etc1tool fastboot hprof-conv lib64 make_f2fs make_f2fs_casefold mke2fs mke2fs.conf sload_f2fs sqlite3 systrace

.../android-sdk/build-tools/30.0.3:
aapt aapt2 aidl apksigner bcc_compat d8 dexdump dx lib lib64 lld lld-bin llvm-rs-cc mainDexClasses renderscript split-select zipalign
```

First put the following in .zshenv or .bash_profile ; and reload terminal:

```bash
export ANDROID_SDK_ROOT=~/Downloads/android/android-sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/tools/bin:$ANDROID_SDK_ROOT/platform-tools/:$ANDROID_SDK_ROOT/build-tools/current
```

Note: We put *cmdline-tools/latest* first because the sdkmanager that gets installed in the (deprecated) *tools/bin* path is still incompatible with Java 11 (`NoClassDefFoundError: javax/xml/bind/annotation/XmlSchema`).


Now we'll need to:

* retrieve the last version from the website (this may break, at this time url is 'https://dl.google.com/android/repository/commandlinetools-linux-6858069_latest.zip')
* rename it because sdkmanager is picky about being in *cmdline-tools/latest/bin*
* and execute it:

```bash

tools_name=$(wget -q -O- 'https://developer.android.com/studio' | grep -o 'commandlinetools-linux-\S\+.zip' | head -n 1)
mkdir -p $ANDROID_SDK_ROOT/cmdline-tools
cd $ANDROID_SDK_ROOT/cmdline-tools
wget -q "https://dl.google.com/android/repository/$tools_name" -O commandlinetools-linux-latest.zip
unzip commandlinetools-linux-latest.zip
rm -i commandlinetools-linux-*_latest.zip
mv cmdline-tools latest
sdkmanager platform-tools build-tools\;30.0.3
```

Now we can optionally set platform 30.0.3 as latest (although it will disrupt sdkmanager a bit, if anyone has a better idea...
```bash
ln -sf $ANDROID_SDK_ROOT/build-tools/{30.0.3,current}
```
