[![Build status](https://ci.appveyor.com/api/projects/status/69nfpsujg5qg0jq3?svg=true)](https://ci.appveyor.com/project/neochief/squirrel-lang-sdk)

# What is this?

This repository was created to ease the cross-platform use of the Squirrel language. Official distribution of Squirrel
does not include a debugger, which you can hardly find and compile on non Windows OS.

So, here's what this repository contains:

- Unmodified Squirrel 3.0.7.
- Fork of the squirrel debugger (sqdbg), with a better cross-platform support.
- Unit tests for debugger.

## What is in this distribution?

### src/squirrel:
    static library implementing the compiler and interpreter of the language

### src/sqstdlib
    the standard utility libraries
    
### src/sq
    stand alone interpreter

### src/sqdbg
    squirrel debugger

### doc
    The manual
    
### doc/minimal
    a minimalistic embedding sample 

### doc/samples
    samples squirrel scripts    

# How to compile and build

Note: In all cases build results will be placed into "output" directory.

### Command line

Note: **Windows** users will need to install MinGW-w64 with _win32 threads_ and _sjlj_ exceptions prior to compilation.

```
mkdir build; cd build
cmake -G "MinGW Makefiles" --build ..
make
```

### Visual Studio

Initially you need to run this from CMD to build Visual Studio solution files:

```
mkdir build; cd build
cmake -G "Visual Studio 14 2015 Win64" --build .. 
./squirrel.sln
```

Then, you can always open build/squirrel.sln.

Note: if you own different version of VS, run the "cmake --help" and scroll down to find the build name for your version.

### CLion

Open root directory as new project and build all targets.

Note: **Windows** users will need MinGW-w64 with _win32 threads_ and _sjlj_ exceptions as a toolchain.

### Other IDEs

Run the "cmake --help" and scroll down to find the build name for your version. Then run this in project root:

```
mkdir build; cd build
cmake -G "<PUT HERE YOUR IDE'S BUILD STRING>" --build .. 
```

Most likely you will find project files of your IDE in build directory.