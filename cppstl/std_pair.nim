# This code is licensed under MIT license (see LICENSE.txt for details)

when not defined(cpp):
  {.error: "C++ backend required to use STL wrapper".}

{.push header: "<utility>".}

type
  CppPair*[T1, T2] {.importcpp: "std::pair".} = object

# Fields
# Codegen breaks if you try to declare these as actual fields on the CppPair object -- Nim generates functions (incl. =destroy) that take std::pair without template parameters, which don't compile.

proc first*[T1, T2](this: CppPair[T1, T2]): T1 {.importcpp: "#.first".}
proc second*[T1, T2](this: CppPair[T1, T2]): T2 {.importcpp: "#.second".}

# Constructor

proc initCppPair*[T1, T2](): CppPair[T1, T2] {.constructor, importcpp: "'0(@)".}
proc initCppPair*[T1, T2](x: T1, y: T2): CppPair[T1, T2] {.constructor, importcpp: "'0(@)".}
proc initCppPair*[T1, T2](p: CppPair[T1, T2]): CppPair[T1, T2] {.constructor, importcpp: "'0(@)".}

# Member functions

proc swap*[T1, T2](this, other: var CppPair[T1, T2]) {.importcpp: "#.swap(@)".}

# Non-member functions

proc `==`*[T1, T2](lhs, rhs: CppPair[T1, T2]): bool {.importcpp: "# == #".}
proc `!=`*[T1, T2](lhs, rhs: CppPair[T1, T2]): bool {.importcpp: "# != #".}
proc `<`*[T1, T2](lhs, rhs: CppPair[T1, T2]): bool {.importcpp: "# < #".}
proc `<=`*[T1, T2](lhs, rhs: CppPair[T1, T2]): bool {.importcpp: "# <= #".}
proc `>`*[T1, T2](lhs, rhs: CppPair[T1, T2]): bool {.importcpp: "# > #".}
proc `>=`*[T1, T2](lhs, rhs: CppPair[T1, T2]): bool {.importcpp: "# >= #".}

proc getImpl[T1, T2](p: CppPair[T1, T2], T: typedesc[T1 or T2]): T {.importcpp: "std::get<'0>(@)".}

proc getImpl[T1, T2](n: int, p: CppPair[T1, T2], T: typedesc[T1 or T2]): T {.importcpp: "std::get<#>(@)".}

{.pop.} # header

proc get*[T1, T2](T: typedesc, p: CppPair[T1, T2]): auto =
  when T1 is T2:
    {.error: "ambiguous call to `get` with a pair whose two elements are of the same type".}
  getImpl(p, T)

proc get*[T1, T2](n: static int, p: CppPair[T1, T2]): auto =
  when n == 0:
    type ResultType = T1
  elif n == 1:
    type ResultType = T2
  else:
    {.error: "index in pair must be 0 or 1".}
  getImpl(n, p, ResultType)

# Nim niceties

proc `$`*[T1, T2](p: CppPair[T1, T2]): string =
  "(" & $p.first & ", " & $p.second & ")"
