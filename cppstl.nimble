# Package

version       = "0.1.0"
author        = "nouredine"
description   = "Bindings for the C++ Standard Template Library (STL)"
license       = "MIT"
srcDir        = "src"


# Dependencies

requires "nim >= 0.19.9"

task test, "Run tests":
    exec """nim cpp -r -o:test --passC:-std=c++11 tests/tvector.nim"""
    exec """nim cpp -r -o:test --passC:-std=c++11 tests/tstring.nim"""


task rtest, "Run tests":
    exec """nim cpp -r -o:test -d:release --passC:-std=c++11 tests/tvector.nim"""
    exec """nim cpp -r -o:test -d:release --passC:-std=c++11 tests/tstring.nim"""
