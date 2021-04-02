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
  Vectortor*[T] {.importcpp: "std::vector".} = object
  VectorIterator*[T] {.importcpp: "std::vector<'0>::iterator".} = object
  VectorConstIterator*[T] {.importcpp: "std::vector<'0>::const_iterator".} = object

# Constructors
proc initVectortor*[T](): Vectortor[T] {.importcpp: "std::vector<'*0>(@)".}
proc initVectortor*[T](n: csize_t): Vectortor[T] {.importcpp: "std::vector<'*0>(@)".}
proc initVectortor*[T](n: csize_t, val: T): Vectortor[T] {.importcpp: "std::vector<'*0>(@)".}
proc initVectortor*[T](x: Vectortor[T]): Vectortor[T] {.importcpp: "std::vector<'*0>(@)".}
proc initVectortor*[T](first, last: VectorConstIterator[T]): Vectortor[T] {.importcpp: "std::vector<'*0>(@)".}

# Iterators
proc begin*[T](x: Vectortor[T]): VectorIterator[T] {.importcpp: "begin".}
proc `end`*[T](x: Vectortor[T]): VectorIterator[T] {.importcpp: "end".}

proc rbegin*[T](x: Vectortor[T]): VectorIterator[T] {.importcpp: "rbegin".}
proc rend*[T](x: Vectortor[T]): VectorIterator[T] {.importcpp: "rend".}

proc cbegin*[T](x: Vectortor[T]): VectorConstIterator[T] {.importcpp: "cbegin".}
proc cend*[T](x: Vectortor[T]): VectorConstIterator[T] {.importcpp: "cend".}

proc crbegin*[T](x: Vectortor[T]): VectorConstIterator[T] {.importcpp: "crbegin".}
proc crend*[T](x: Vectortor[T]): VectorConstIterator[T] {.importcpp: "crend".}

# Capacity
proc size*[T](self: Vectortor[T]): csize_t {.importcpp: "size".}
proc max_size*[T](self: Vectortor[T]): csize_t {.importcpp: "max_size".}
proc resize*[T](self: Vectortor[T], n: csize_t) {.importcpp: "resize".}
proc capacity*[T](self: Vectortor[T]): csize_t {.importcpp: "capacity".}
proc empty*[T](self: Vectortor[T]): bool {.importcpp: "empty".}
proc reserve*[T](self: var Vectortor[T], n: csize_t) {.importcpp: "reserve".}
proc shrink_to_fit*[T](self: var Vectortor[T]) {.importcpp: "shrink_to_fit".}

# Internal utility functions
proc unsafeIndex[T](self: var Vectortor[T], i: csize_t): var T {.importcpp: "#[#]".}
proc unsafeIndex[T](self: Vectortor[T], i: csize_t): T {.importcpp: "#[#]".}

proc at*[T](self: var Vectortor[T], n: csize_t): var T {.importcpp: "at".}
proc at*[T](self: Vectortor[T], n: csize_t): T {.importcpp: "at".}

proc front*[T](self: Vectortor[T]): T {.importcpp: "front".}
proc front*[T](self: var Vectortor[T]): var T {.importcpp: "front".}

proc back*[T](self: Vectortor[T]): T {.importcpp: "back".}
proc back*[T](self: var Vectortor[T]): var T {.importcpp: "back".}

proc data*[T](self: Vectortor[T]): ptr T {.importcpp: "data".}

# Modifiers
proc assign*[T](n: csize_t, val: T) {.importcpp: "assign".}
proc assign*[T](first: VectorIterator[T], last: VectorIterator[T]) {.importcpp: "assign".}

proc push_back*[T](self: var Vectortor[T], x: T) {.importcpp: "push_back".}

proc pop_back*[T](self: var Vectortor[T]) {.importcpp: "pop_back".}

proc insert*[T](self: var Vectortor[T], position: VectorConstIterator[T], x: T): VectorIterator[T] {.importcpp: "insert".}
proc insert*[T](self: var Vectortor[T], position: VectorConstIterator[T], n: csize_t, x: T): VectorIterator[T] {.importcpp: "insert".}
proc insert*[T](self: var Vectortor[T], position, first, last: VectorConstIterator[T]): VectorIterator[T] {.importcpp: "insert".}

proc erase*[T](self: var Vectortor[T], position: VectorConstIterator[T]): VectorIterator[T] {.importcpp: "erase".}
proc erase*[T](self: var Vectortor[T], first, last: VectorConstIterator[T]): VectorIterator[T] {.importcpp: "erase".}

proc swap*[T](self: var Vectortor[T], x: var Vectortor[T]) {.importcpp: "swap".}

proc clear*[T](self: var Vectortor[T]) {.importcpp: "clear".}

# Relational operators
proc `==`*[T](a: Vectortor[T], b: Vectortor[T]): bool {.importcpp: "# == #".}

proc `!=`*[T](a: Vectortor[T], b: Vectortor[T]): bool {.importcpp: "# != #".}

proc `<`*[T](a: Vectortor[T], b: Vectortor[T]): bool {.importcpp: "# < #".}

proc `<=`*[T](a: Vectortor[T], b: Vectortor[T]): bool {.importcpp: "# <= #".}

proc `>`*[T](a: Vectortor[T], b: Vectortor[T]): bool {.importcpp: "# > #".}

proc `>=`*[T](a: Vectortor[T], b: Vectortor[T]): bool {.importcpp: "# >= #".}

{.pop.}

# Nim specifics
proc checkIndex[T](self: Vectortor[T], i: csize_t) {.inline.} =
  if i >= self.size:
    raise newException(IndexDefect, &"index out of bounds: (i:{i}) <= (n:{self.size})")

# Element access
proc `[]`*[T](self: Vectortor[T], idx: Natural): T  {.inline.} =
  let i = csize_t(idx)
  when compileOption("boundChecks"): self.checkIndex(i)
  self.unsafeIndex(i)

proc `[]`*[T](self: var Vectortor[T], idx: Natural): var T {.inline.} =
  let i = csize_t(idx)
  when compileOption("boundChecks"): self.checkIndex(i)
  # this strange syntax is to avoid a bug in the Nim c++ code generator
  (addr self.unsafeIndex(i))[]

proc `[]=`*[T](self: var Vectortor[T], idx: Natural, val: T) {.inline.} =
  let i = csize_t(idx)
  when compileOption("boundChecks"): self.checkIndex(i)
  self.unsafeIndex(i) = val

# Converter: VectorIterator -> VectorConstIterator
converter VectorIteratorToVectorConstIterator*[T](x: VectorIterator[T]):
          VectorConstIterator[T] {.importcpp: "#".}

# Display the content of a vector
proc `$`*[T](v: Vectortor[T]): string {.noinit.} =
  if v.empty:
    result = "[]"
  else:
    result = "["
    for i in 0..<v.size-1:
      result = result & $v[i] & ", "
    result = result & $v[v.size-1] & "]"

# Iterators arithmetics
iteratorsArithmetics(VectorIterator)
iteratorsArithmetics(VectorConstIterator)
