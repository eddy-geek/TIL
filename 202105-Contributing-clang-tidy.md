## [Contributing](https://clang.llvm.org/extra/clang-tidy/Contributing.html) to Clang-Tidy
```sh
git clone https://github.com/llvm/llvm-project.git --depth=1
cd llvm-project
mkdir build
cd build
cmake -G Ninja -DLLVM_ENABLE_PROJECTS=clang\;clang-tools-extra -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$PWD ../llvm
ninja check-clang-tools
```

#### Example:

*[modernize-loop-convert](https://clang.llvm.org/extra/clang-tidy/checks/modernize-loop-convert.html) needs an option to disable use of auto* on [bugs.llvm.org](https://bugs.llvm.org/show_bug.cgi?id=35694)


Ideally, something like [modernize-use-auto](https://clang.llvm.org/extra/clang-tidy/checks/modernize-use-auto.html)'s `MinTypeNameLength` could be used. It's used like this:

```
clang-tidy --fix --config='{CheckOptions: [{key: modernize-use-auto.MinTypeNameLength, value: 40}]}' --checks=modernize-use-auto
```
The code for *use-auto* uses getTypeNameLength ([UseAutoCheck.cpp#401](https://code.woboq.org/llvm/clang-tools-extra/clang-tidy/modernize/UseAutoCheck.cpp.html#401))

The code for *loop-convert* already invelves special cases for primitive type at [LoopConvertCheck.cpp#629](https://code.woboq.org/llvm/clang-tools-extra/clang-tidy/modernize/LoopConvertCheck.cpp.html#629).


