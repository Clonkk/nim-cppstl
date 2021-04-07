# Copyright 2019 Nouredine Hussain
# Copyright 2021 Caillaund Regis

# self code is licensed under MIT license (see LICENSE.txt for details)

import strformat
import ./private/utils
import ./exception
export exception
when not defined(cpp):
  {.error: "C++ backend required to use STL wrapper".}

{.push header: "<vector>".}

type
  CppVector*[T] {.importcpp: "std::vector".} = object
  CppVectorIterator*[T] {.importcpp: "std::vector<'0>::iterator".} = object
  CppVectorConstIterator*[T] {.importcpp: "std::vector<'0>::const_iterator".} = object

# Constructors
proc initCppVector*[T](): CppVector[T] {.importcpp: "std::vector<'*0>(@)".}
proc initCppVector*[T](n: csize_t): CppVector[T] {.importcpp: "std::vector<'*0>(@)".}
proc initCppVector*[T](n: csize_t, val: T): CppVector[T] {.importcpp: "std::vector<'*0>(@)".}
proc initCppVector*[T](x: CppVector[T]): CppVector[T] {.importcpp: "std::vector<'*0>(@)".}
proc initCppVector*[T](first, last: CppVectorConstIterator[T]): CppVector[T] {.importcpp: "std::vector<'*0>(@)".}

# Iterators
proc begin*[T](x: CppVector[T]): CppVectorIterator[T] {.importcpp: "begin".}
proc `end`*[T](x: CppVector[T]): CppVectorIterator[T] {.importcpp: "end".}

proc rbegin*[T](x: CppVector[T]): CppVectorIterator[T] {.importcpp: "rbegin".}
proc rend*[T](x: CppVector[T]): CppVectorIterator[T] {.importcpp: "rend".}

proc cbegin*[T](x: CppVector[T]): CppVectorConstIterator[T] {.importcpp: "cbegin".}
proc cend*[T](x: CppVector[T]): CppVectorConstIterator[T] {.importcpp: "cend".}

proc crbegin*[T](x: CppVector[T]): CppVectorConstIterator[T] {.importcpp: "crbegin".}
proc crend*[T](x: CppVector[T]): CppVectorConstIterator[T] {.importcpp: "crend".}

# Capacity
proc size*[T](self: CppVector[T]): csize_t {.importcpp: "size".}
proc max_size*[T](self: CppVector[T]): csize_t {.importcpp: "max_size".}
proc resize*[T](self: CppVector[T], n: csize_t) {.importcpp: "resize".}
proc capacity*[T](self: CppVector[T]): csize_t {.importcpp: "capacity".}
proc empty*[T](self: CppVector[T]): bool {.importcpp: "empty".}
proc reserve*[T](self: var CppVector[T], n: csize_t) {.importcpp: "reserve".}
proc shrink_to_fit*[T](self: var CppVector[T]) {.importcpp: "shrink_to_fit".}

# Internal utility functions
proc unsafeIndex[T](self: var CppVector[T], i: csize_t): var T {.importcpp: "#[#]".}
proc unsafeIndex[T](self: CppVector[T], i: csize_t): T {.importcpp: "#[#]".}

proc at*[T](self: var CppVector[T], n: csize_t): var T {.importcpp: "at".}
proc at*[T](self: CppVector[T], n: csize_t): T {.importcpp: "at".}

proc front*[T](self: CppVector[T]): T {.importcpp: "front".}
proc front*[T](self: var CppVector[T]): var T {.importcpp: "front".}

proc back*[T](self: CppVector[T]): T {.importcpp: "back".}
proc back*[T](self: var CppVector[T]): var T {.importcpp: "back".}

proc data*[T](self: CppVector[T]): ptr T {.importcpp: "data".}

# Modifiers
proc assign*[T](n: csize_t, val: T) {.importcpp: "assign".}
proc assign*[T](first: CppVectorIterator[T], last: CppVectorIterator[T]) {.importcpp: "assign".}

proc push_back*[T](self: var CppVector[T], x: T) {.importcpp: "push_back".}

proc pop_back*[T](self: var CppVector[T]) {.importcpp: "pop_back".}

proc insert*[T](self: var CppVector[T], position: CppVectorConstIterator[T], x: T): CppVectorIterator[T] {.importcpp: "insert".}
proc insert*[T](self: var CppVector[T], position: CppVectorConstIterator[T], n: csize_t, x: T): CppVectorIterator[T] {.importcpp: "insert".}
proc insert*[T](self: var CppVector[T], position, first, last: CppVectorConstIterator[T]): CppVectorIterator[T] {.importcpp: "insert".}

proc erase*[T](self: var CppVector[T], position: CppVectorConstIterator[T]): CppVectorIterator[T] {.importcpp: "erase".}
proc erase*[T](self: var CppVector[T], first, last: CppVectorConstIterator[T]): CppVectorIterator[T] {.importcpp: "erase".}

proc swap*[T](self: var CppVector[T], x: var CppVector[T]) {.importcpp: "swap".}

proc clear*[T](self: var CppVector[T]) {.importcpp: "clear".}

# Relational operators
proc `==`*[T](a: CppVector[T], b: CppVector[T]): bool {.importcpp: "# == #".}

proc `!=`*[T](a: CppVector[T], b: CppVector[T]): bool {.importcpp: "# != #".}

proc `<`*[T](a: CppVector[T], b: CppVector[T]): bool {.importcpp: "# < #".}

proc `<=`*[T](a: CppVector[T], b: CppVector[T]): bool {.importcpp: "# <= #".}

proc `>`*[T](a: CppVector[T], b: CppVector[T]): bool {.importcpp: "# > #".}

proc `>=`*[T](a: CppVector[T], b: CppVector[T]): bool {.importcpp: "# >= #".}

{.pop.}

# Nim specifics
proc checkIndex[T](self: CppVector[T], i: csize_t) {.inline.} =
  if i >= self.size:
    raise newException(IndexDefect, &"index out of bounds: (i:{i}) <= (n:{self.size})")

# Element access
proc `[]`*[T](self: CppVector[T], idx: Natural): T {.inline.} =
  let i = csize_t(idx)
  when compileOption("boundChecks"): self.checkIndex(i)
  self.unsafeIndex(i)

proc `[]`*[T](self: var CppVector[T], idx: Natural): var T {.inline.} =
  let i = csize_t(idx)
  when compileOption("boundChecks"): self.checkIndex(i)
  # this strange syntax is to avoid a bug in the Nim c++ code generator
  (addr self.unsafeIndex(i))[]

proc `[]=`*[T](self: var CppVector[T], idx: Natural, val: T) {.inline.} =
  let i = csize_t(idx)
  when compileOption("boundChecks"): self.checkIndex(i)
  self.unsafeIndex(i) = val

# Converter: CppVectorIterator -> CppVectorConstIterator
converter CppVectorIteratorToCppVectorConstIterator*[T](x: CppVectorIterator[T]):
          CppVectorConstIterator[T] {.importcpp: "#".}

# Display the content of a vector
proc `$`*[T](v: CppVector[T]): string =
  let size = v.size()
  if size > 0:
    result = "["
    for i in 0..<size-1:
      result.add $(v.at(i.csize_t))
      result.add ", "
    result.add $(v.at(size-1))
    result.add "]"
  else:
    result = "[]"

# Iterators arithmetics
iteratorsArithmetics(CppVectorIterator)
iteratorsArithmetics(CppVectorConstIterator)
