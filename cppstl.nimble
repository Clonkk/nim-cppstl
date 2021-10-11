# Package

version       = "0.5.0"
author        = "Clonkk"
description   = "Bindings for the C++ Standard Template Library (STL)"
license       = "MIT"


# Dependencies

requires "nim >= 1.0.0"

backend = "cpp"

task gendoc, "gen doc":
  exec("nimble doc --backend:cpp --project cppstl.nim --out:docs/")

task test, "Run the tests":
  # run the manually to change the compilation flags
  exec "nim cpp -r tests/destroy_bug_15.nim"
  exec "nim cpp -r --gc:arc tests/destroy_bug_15.nim"
  exec "nim cpp -r tests/tvector.nim"
  exec "nim cpp -r --gc:arc tests/tvector.nim"
  exec "nim cpp -r tests/tstring.nim"
  exec "nim cpp -r --gc:arc tests/tstring.nim"
  exec "nim cpp -r tests/tcomplex.nim"
  exec "nim cpp -r --gc:arc tests/tcomplex.nim"
  # the following should compile and *not* produce a codegen error
  exec "nim cpp --gc:arc -r tests/tdestructor_codegen_bug.nim"
  exec "nim cpp -r tests/tdestructor_codegen_bug.nim"
