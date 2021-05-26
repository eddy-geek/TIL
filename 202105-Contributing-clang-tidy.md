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

*modernize-loop-convert needs an option to disable use of auto* on [bugs.llvm.org](https://bugs.llvm.org/show_bug.cgi?id=35694)

code: [LoopConvertCheck.cpp#629](https://code.woboq.org/llvm/clang-tools-extra/clang-tidy/modernize/LoopConvertCheck.cpp.html#629)
