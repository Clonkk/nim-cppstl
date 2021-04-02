# Copyright 2019 Nouredine Hussain

# self code is licensed under MIT license (see LICENSE.txt for details)

import strformat
import ./private/utils
import ./exception
export exception

{.push header: "<vector>".}
type
  StdVector*[T] {.importcpp: "std::vector".} = object

  StdVecIterator*[T] {.importcpp: "std::vector<'0>::iterator".} = object

  StdVecConstIterator*[T] {.importcpp: "std::vector<'0>::const_iterator".} = object

# Constructors
proc initStdVector*[T](): StdVector[T] {.importcpp: "std::vector<'*0>(@)".}
proc initStdVector*[T](n: csize_t): StdVector[T] {.importcpp: "std::vector<'*0>(@)".}
proc initStdVector*[T](n: csize_t, val: T): StdVector[T] {.importcpp: "std::vector<'*0>(@)".}
proc initStdVector*[T](x: StdVector[T]): StdVector[T] {.importcpp: "std::vector<'*0>(@)".}
proc initStdVector*[T](first, last: StdVecConstIterator[T]): StdVector[T] {.importcpp: "std::vector<'*0>(@)".}

# Iterators
proc begin*[T](x: StdVector[T]): StdVecIterator[T] {.importcpp: "begin".}
proc `end`*[T](x: StdVector[T]): StdVecIterator[T] {.importcpp: "end".}

proc rbegin*[T](x: StdVector[T]): StdVecIterator[T] {.importcpp: "rbegin".}
proc rend*[T](x: StdVector[T]): StdVecIterator[T] {.importcpp: "rend".}

proc cbegin*[T](x: StdVector[T]): StdVecConstIterator[T] {.importcpp: "cbegin".}
proc cend*[T](x: StdVector[T]): StdVecConstIterator[T] {.importcpp: "cend".}

proc crbegin*[T](x: StdVector[T]): StdVecConstIterator[T] {.importcpp: "crbegin".}
proc crend*[T](x: StdVector[T]): StdVecConstIterator[T] {.importcpp: "crend".}

# Capacity
proc size*[T](self: StdVector[T]): csize_t {.importcpp: "size".}

proc max_size*[T](self: StdVector[T]): csize_t {.importcpp: "max_size".}

proc resize*[T](self: StdVector[T], n: csize_t) {.importcpp: "resize".}

proc capacity*[T](self: StdVector[T]): csize_t {.importcpp: "capacity".}

proc empty*[T](self: StdVector[T]): bool {.importcpp: "empty".}

proc reserve*[T](self: var StdVector[T], n: csize_t) {.importcpp: "reserve".}

proc shrink_to_fit*[T](self: var StdVector[T]) {.importcpp: "shrink_to_fit".}

# Internal utility functions
proc unsafeIndex[T](self: var StdVector[T], i: csize_t): var T {.importcpp: "#[#]".}
proc unsafeIndex[T](self: StdVector[T], i: csize_t): T {.importcpp: "#[#]".}

when compileOption("boundChecks"):
  proc checkIndex[T](self: StdVector[T], i: csize_t) {.inline.} =
    if i >= self.size:
      raise newException(IndexDefect, &"index out of bounds: (i:{i}) <= (n:{self.size})")

# Element access
proc `[]`*[T](self: StdVector[T], i: Natural): T {.inline.} =
  let i = csize_t(i)
  when compileOption("boundChecks"):
    self.checkIndex i
  result = self.unsafeIndex(i)

proc `[]`*[T](self: var StdVector[T], i: Natural): var T {.inline, noinit.} =
  let i = csize_t(i)
  when compileOption("boundChecks"):
    self.checkIndex i
  # this strange syntax is to avoid a bug in the Nim c++ code generator
  result = (addr self.unsafeIndex(i))[]

proc `[]=`*[T](self: var StdVector[T], i: Natural, val: T) {.inline, noinit.} =
  let i = csize_t(i)
  when compileOption("boundChecks"):
    self.checkIndex i
  self.unsafeIndex(i) = val

proc at*[T](self: var StdVector[T], n: csize_t): var T {.importcpp: "at".}
proc at*[T](self: StdVector[T], n: csize_t): T {.importcpp: "at".}

proc front*[T](self: StdVector[T]): T {.importcpp: "front".}
proc front*[T](self: var StdVector[T]): var T {.importcpp: "front".}

proc back*[T](self: StdVector[T]): T {.importcpp: "back".}
proc back*[T](self: var StdVector[T]): var T {.importcpp: "back".}

proc data*[T](self: StdVector[T]): ptr T {.importcpp: "data".}

# Modifiers
proc assign*[T](n: csize_t, val: T) {.importcpp: "assign".}
proc assign*[T](first: StdVecIterator[T], last: StdVecIterator[T]) {.importcpp: "assign".}

proc push_back*[T](self: var StdVector[T], x: T) {.importcpp: "push_back".}

proc pop_back*[T](self: var StdVector[T]) {.importcpp: "pop_back".}

proc insert*[T](self: var StdVector[T], position: StdVecConstIterator[T], x: T): StdVecIterator[T] {.importcpp: "insert".}
proc insert*[T](self: var StdVector[T], position: StdVecConstIterator[T], n: csize_t, x: T): StdVecIterator[T] {.importcpp: "insert".}
proc insert*[T](self: var StdVector[T], position, first, last: StdVecConstIterator[T]): StdVecIterator[T] {.importcpp: "insert".}

proc erase*[T](self: var StdVector[T], position: StdVecConstIterator[T]): StdVecIterator[T] {.importcpp: "erase".}
proc erase*[T](self: var StdVector[T], first, last: StdVecConstIterator[T]): StdVecIterator[T] {.importcpp: "erase".}

proc swap*[T](self: var StdVector[T], x: var StdVector[T]) {.importcpp: "swap".}

proc clear*[T](self: var StdVector[T]) {.importcpp: "clear".}

# Relational operators
proc `==`*[T](a: StdVector[T], b: StdVector[T]): bool {.importcpp: "# == #".}

proc `!=`*[T](a: StdVector[T], b: StdVector[T]): bool {.importcpp: "# != #".}

proc `<`*[T](a: StdVector[T], b: StdVector[T]): bool {.importcpp: "# < #".}

proc `<=`*[T](a: StdVector[T], b: StdVector[T]): bool {.importcpp: "# <= #".}

proc `>`*[T](a: StdVector[T], b: StdVector[T]): bool {.importcpp: "# > #".}

proc `>=`*[T](a: StdVector[T], b: StdVector[T]): bool {.importcpp: "# >= #".}

# Nim specifics

# Converter: StdVecIterator -> StdVecConstIterator
converter StdVecIteratorToStdVecConstIterator*[T](x: StdVecIterator[T]):
          StdVecConstIterator[T] {.importcpp: "#".}

# Display the content of a vector
proc `$`*[T](v: StdVector[T]): string {.noinit.} =
  if v.empty:
    result = "[]"
  else:
    result = "["
    for i in 0..<v.size-1:
      result = result & $v[i] & ", "
    result = result & $v[v.size-1] & "]"

# Iterators arithmetics
iteratorsArithmetics(StdVecIterator)
iteratorsArithmetics(StdVecConstIterator)
