# This code is licensed under MIT license (see LICENSE.txt for details)
import std/strformat

when not defined(cpp):
  {.error: "C++ backend required to use STL wrapper".}

{.push header:"<utility>".}
# https://cplusplus.com/reference/utility/pair/

type
  CppPair*[F,S] {.importcpp:"std::pair <'0,'1>"} = object

# procs
proc first*[T1, T2](this: CppPair[T1, T2]): T1 {.importcpp: "#.first".}
proc first*[T1, T2](this: var CppPair[T1, T2]): var T1 {.importcpp: "#.first".}
proc `first=`*[T1, T2](this: var CppPair[T1, T2], val: T1) {.importcpp: "#.first = #".}
proc second*[T1, T2](this: CppPair[T1, T2]): T2 {.importcpp: "#.second".}
proc second*[T1, T2](this: var CppPair[T1, T2]): var T2 {.importcpp: "#.second".}
proc `second=`*[T1, T2](this: var CppPair[T1, T2], val: T2) {.importcpp: "#.second = #".}

# Constructor
proc initCppPair*[T1, T2](): CppPair[T1, T2] {.constructor, importcpp: "'0(@)".}
proc initCppPair*[T1, T2](x: T1, y: T2): CppPair[T1, T2] {.constructor, importcpp: "'0(@)".}
proc initCppPair*[T1, T2](p: CppPair[T1, T2]): CppPair[T1, T2] {.constructor, importcpp: "'0(@)".}

# Member functions
proc swap*[T1, T2](this, other: var CppPair[T1, T2]) {.importcpp: "#.swap(@)".}

# Non-member functions
# https://en.cppreference.com/w/cpp/utility/pair/make_pair
proc makePair*[F,S](a:F; b:S):CppPair[F,S] {.importcpp:"std::make_pair(@)" .}

proc getImpl[T1, T2](p: CppPair[T1, T2], T: typedesc[T1 or T2]): T {.importcpp: "std::get<'0>(@)".}
proc getImpl[T1, T2](n: int, p: CppPair[T1, T2], T: typedesc[T1 or T2]): T {.importcpp: "std::get<#>(@)".}

# proc `==`*[T1, T2](lhs, rhs: CppPair[T1, T2]): bool {.importcpp: "# == #".}
# proc `!=`*[T1, T2](lhs, rhs: CppPair[T1, T2]): bool {.importcpp: "# != #".}
# proc `<`*[T1, T2](lhs, rhs: CppPair[T1, T2]): bool {.importcpp: "# < #".}
# proc `<=`*[T1, T2](lhs, rhs: CppPair[T1, T2]): bool {.importcpp: "# <= #".}
# proc `>`*[T1, T2](lhs, rhs: CppPair[T1, T2]): bool {.importcpp: "# > #".}
# proc `>=`*[T1, T2](lhs, rhs: CppPair[T1, T2]): bool {.importcpp: "# >= #".}

{.pop.} # header

# Implement comparaison operator manually because for some reason NimStringV2 does not have operator==() definied in C++
proc `==`*[T1, T2](lhs, rhs: CppPair[T1, T2]): bool =
  if (lhs.first() == rhs.first()) and (lhs.second() == rhs.second()):
    result = true
  else:
    result = false

proc `!=`*[T1, T2](lhs, rhs: CppPair[T1, T2]): bool =
  if lhs == rhs:
    result = false
  else:
    result = true

proc `<`*[T1, T2](lhs, rhs: CppPair[T1, T2]): bool =
  ## If lhs.first<rhs.first, returns true. 
  ## Otherwise, if rhs.first<lhs.first, returns false. 
  ## Otherwise, if lhs.second<rhs.second, returns true. 
  ## Otherwise, returns false.

  # Workaroud due to strange Nim codegen behaviour
  # Without "and true" generated code contains a ! operator which isn't defined for all type (std::string for instance)
  if first(lhs) < first(rhs) and true:
    return true
  elif first(rhs) < first(lhs) and true:
    return false
  elif second(lhs) < second(rhs):
    return true
  else:
    return false
#
proc `<=`*[T1, T2](lhs, rhs: CppPair[T1, T2]): bool =
  ## 4) !(rhs < lhs)
  if rhs < lhs:
    result = false
  else:
    result = true

proc `>`*[T1, T2](lhs, rhs: CppPair[T1, T2]): bool =
  ## 5) rhs < lhs
  return rhs < lhs

proc `>=`*[T1, T2](lhs, rhs: CppPair[T1, T2]): bool =
  ## 6) !(lhs < rhs)
  if lhs < rhs:
    result = false
  else:
    result = true
#
#-----------
# Some sugar
#-----------

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

proc `$`*[F,S](val:CppPair[F,S]):string =
  # provides stdout for CppPair
  &"CppPair(first: {val.first}, second: {val.second})"

proc toTuple*[F,S](val:CppPair[F,S]):tuple[first:F, second:S] =
  ## converts a CppPair into a Nim's tuple
  (val.first, val.second)

proc makePair*[F, S](t: tuple[first: F, second: S]) : CppPair[F, S] = 
  result = initCppPair[F, S]()
  result.first = t.first
  result.second = t.second
