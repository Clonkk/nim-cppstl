# Package

version       = "0.3.0"
author        = "Clonkk"
description   = "Bindings for the C++ Standard Template Library (STL)"
license       = "MIT"


# Dependencies

requires "nim >= 1.0.0"

backend = "cpp"

task gendoc, "gen doc":
  exec("nimble doc --backend:cpp --project cppstl.nim --out:docs/")
