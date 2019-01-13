# Copyright 2019 Nouredine Hussain

# This code is licensed under MIT license (see LICENSE.txt for details)

import strformat, ./private/utils, ./exception

export exception

type
  Vector*[T] {.importcpp: "std::vector", header: "vector".} = object

  VecIterator*[T] {.importcpp: "std::vector<'0>::iterator",
                    header: "vector".} = object

  VecConstIterator*[T] {.importcpp: "std::vector<'0>::const_iterator",
                         header: "vector".} = object

# Constructors
proc initVector*[T](): Vector[T]
  {.importcpp: "std::vector<'*0>(@)", header: "vector".}

proc initVector*[T](n: csize): Vector[T]
  {.importcpp: "std::vector<'*0>(@)", header: "vector".}

proc initVector*[T](n: csize, val: T): Vector[T]
  {.importcpp: "std::vector<'*0>(@)", header: "vector".}

proc initVector*[T](x: Vector[T]): Vector[T]
  {.importcpp: "std::vector<'*0>(@)", header: "vector".}

proc initVector*[T](first, last: VecConstIterator[T]): Vector[T]
  {.importcpp: "std::vector<'*0>(@)", header: "vector".}

# Iterators
proc begin*[T](x: Vector[T]): VecIterator[T]
  {.importcpp: "begin", header: "vector".}

proc `end`*[T](x: Vector[T]): VecIterator[T]
  {.importcpp: "end", header: "vector".}

proc rbegin*[T](x: Vector[T]): VecIterator[T]
  {.importcpp: "rbegin", header: "vector".}

proc rend*[T](x: Vector[T]): VecIterator[T]
  {.importcpp: "rend", header: "vector".}

proc cbegin*[T](x: Vector[T]): VecConstIterator[T]
  {.importcpp: "cbegin", header: "vector".}

proc cend*[T](x: Vector[T]): VecConstIterator[T]
  {.importcpp: "cend", header: "vector".}

proc crbegin*[T](x: Vector[T]): VecConstIterator[T]
  {.importcpp: "crbegin", header: "vector".}

proc crend*[T](x: Vector[T]): VecConstIterator[T]
  {.importcpp: "crend", header: "vector".}

# Capacity
proc size*[T](this: Vector[T]): csize
  {.importcpp: "size", header: "vector".}

proc max_size*[T](this: Vector[T]): csize
  {.importcpp: "max_size", header: "vector".}

proc resize*[T](this: Vector[T], n: csize)
  {.importcpp: "resize", header: "vector".}

proc capacity*[T](this: Vector[T]): csize
  {.importcpp: "capacity", header: "vector".}

proc empty*[T](this: Vector[T]): bool
  {.importcpp: "empty", header: "vector".}

proc reserve*[T](this: var Vector[T], n: csize)
  {.importcpp: "reserve", header: "vector".}

proc shrink_to_fit*[T](this: var Vector[T])
  {.importcpp: "shrink_to_fit", header: "vector".}

# Internal utility functions
proc unsafeIndex[T](this: var Vector[T], i: csize): var T
  {.importcpp: "#[#]", header: "vector".}

proc unsafeIndex[T](this: Vector[T], i: csize): T
  {.importcpp: "#[#]", header: "vector".}

when compileOption("boundChecks"):
  proc checkIndex[T](this: Vector[T], i: csize) {.inline.} =
    if 0 > i or i > this.size:
      raise newException(IndexError,
            &"index out of bounds: 0 <= (i:{i}) <= (n:{this.size})")

# Element access
proc `[]`*[T](this: Vector[T], i: Natural): T {.inline.} =
  when compileOption("boundChecks"):
    this.checkIndex i
  result = this.unsafeIndex(i)

proc `[]`*[T](this: var Vector[T], i: Natural): var T {.inline, noinit.} =
  when compileOption("boundChecks"):
    this.checkIndex i
  # This strange syntax is to avoid a bug in the Nim c++ code generator
  result = (addr this.unsafeIndex(i))[]

proc `[]=`*[T](this: var Vector[T], i: Natural, val: T) {.inline, noinit.} =
  when compileOption("boundChecks"):
    this.checkIndex i
  this.unsafeIndex(i) = val

proc at*[T](this: var Vector[T], n: csize): var T
  {.importcpp: "at", header: "vector".}

proc at*[T](this: Vector[T], n: csize): T
  {.importcpp: "at", header: "vector".}

proc front*[T](this: Vector[T]): T
  {.importcpp: "front", header: "vector".}

proc front*[T](this: var Vector[T]): var T
  {.importcpp: "front", header: "vector".}

proc back*[T](this: Vector[T]): T
  {.importcpp: "back", header: "vector".}

proc back*[T](this: var Vector[T]): var T
  {.importcpp: "back", header: "vector".}

proc data*[T](this: Vector[T]): ptr T
  {.importcpp: "data", header: "vector".}

# Modifiers
proc assign*[T](n: csize, val: T)
  {.importcpp: "assign", header: "vector".}

proc assign*[T](first: VecIterator[T], last: VecIterator[T])
  {.importcpp: "assign", header: "vector".}

proc push_back*[T](this: var Vector[T], x: T)
  {.importcpp: "push_back", header: "vector".}

proc pop_back*[T](this: var Vector[T])
  {.importcpp: "pop_back", header: "vector".}

proc insert*[T](this: var Vector[T], position: VecConstIterator[T],
                x: T): VecIterator[T]
  {.importcpp: "insert", header: "vector".}

proc insert*[T](this: var Vector[T], position: VecConstIterator[T],
                n: csize, x: T): VecIterator[T]
  {.importcpp: "insert", header: "vector".}

proc insert*[T](this: var Vector[T], position,
                first, last: VecConstIterator[T]): VecIterator[T]
  {.importcpp: "insert", header: "vector".}

proc erase*[T](this: var Vector[T],
               position: VecConstIterator[T]): VecIterator[T]
  {.importcpp: "erase", header: "vector".}

proc erase*[T](this: var Vector[T],
               first, last: VecConstIterator[T]): VecIterator[T]
  {.importcpp: "erase", header: "vector".}

proc swap*[T](this: var Vector[T], x: var Vector[T])
  {.importcpp: "swap", header: "vector".}

proc clear*[T](this: var Vector[T])
  {.importcpp: "clear", header: "vector".}

# Relational operators
proc `==`*[T](a: Vector[T], b: Vector[T]): bool
  {.importcpp: "# == #", header: "vector".}

proc `!=`*[T](a: Vector[T], b: Vector[T]): bool
  {.importcpp: "# != #", header: "vector".}

proc `<`*[T](a: Vector[T], b: Vector[T]): bool
  {.importcpp: "# < #", header: "vector".}

proc `<=`*[T](a: Vector[T], b: Vector[T]): bool
  {.importcpp: "# <= #", header: "vector".}

proc `>`*[T](a: Vector[T], b: Vector[T]): bool
  {.importcpp: "# > #", header: "vector".}

proc `>=`*[T](a: Vector[T], b: Vector[T]): bool
  {.importcpp: "# >= #", header: "vector".}

# Nim specifics

# Converter: VecIterator -> VecConstIterator
converter VecIteratorToVecConstIterator*[T](x: VecIterator[T]):
          VecConstIterator[T] {.importcpp: "#".}

# Display the content of a vector
proc `$`*[T](v: Vector[T]): string {.noinit.} =
  if v.empty:
    result = "[]"
  else:
    result = "["
    for i in 0..<v.size-1:
      result = result & $v[i] & ", "
    result = result & $v[v.size-1] & "]"

# Iterators arithmetics
iteratorsArithmetics(VecIterator)
iteratorsArithmetics(VecConstIterator)
