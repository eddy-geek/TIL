## [Contributing](https://clang.llvm.org/extra/clang-tidy/Contributing.html) to Clang-Tidy
```sh
git clone https://github.com/llvm/llvm-project.git --depth=1
cd llvm-project
mkdir build
cd build
cmake -G Ninja -DLLVM_ENABLE_PROJECTS=clang\;clang-tools-extra -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$PWD -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ../llvm
ninja check-clang-tools
```

* `-G ninja`: as recommended
* `LLVM_ENABLE_PROJECTS=clang;clang-tools-extra`: as clang-tidy is in extra, but check-clang-tools is in clang.
* `CMAKE_EXPORT_COMPILE_COMMANDS=ON`: generate compile_commands.json (also useful for vscode). From [How To Setup Tooling For LLVM](https://clang.llvm.org/docs/HowToSetupToolingForLLVM.html)
* `CMAKE_INSTALL_PREFIX=$PWD`: change if on windows.

#### Example:

*[modernize-loop-convert](https://clang.llvm.org/extra/clang-tidy/checks/modernize-loop-convert.html) needs an option to disable use of auto* on [bugs.llvm.org](https://bugs.llvm.org/show_bug.cgi?id=35694)


Ideally, something like [modernize-use-auto](https://clang.llvm.org/extra/clang-tidy/checks/modernize-use-auto.html)'s `MinTypeNameLength` could be used. It's used like this:

```
clang-tidy --fix --config='{CheckOptions: [{key: modernize-use-auto.MinTypeNameLength, value: 40}]}' --checks=modernize-use-auto
```
The code for *use-auto* uses getTypeNameLength ([UseAutoCheck.cpp#401](https://code.woboq.org/llvm/clang-tools-extra/clang-tidy/modernize/UseAutoCheck.cpp.html#401))

The code for *loop-convert* already invelves special cases for primitive type at [LoopConvertCheck.cpp#629](https://code.woboq.org/llvm/clang-tools-extra/clang-tidy/modernize/LoopConvertCheck.cpp.html#629).


