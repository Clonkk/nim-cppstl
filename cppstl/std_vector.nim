# self code is licensed under MIT license (see LICENSE.txt for details)

import std/[strformat]
import ./private/utils
import ./std_exception
export std_exception

when not defined(cpp):
  {.error: "C++ backend required to use STL wrapper".}

{.push header: "<vector>".}

type
  CppVector*[T] {.importcpp: "std::vector".} = object
  # https://nim-lang.github.io/Nim/manual.html#importcpp-pragma-importcpp-for-objects
  CppVectorIterator*[T] {.importcpp: "std::vector<'0>::iterator".} = object
  CppVectorConstIterator*[T] {.importcpp: "std::vector<'0>::const_iterator".} = object

# Constructors
# https://nim-lang.github.io/Nim/manual.html#importcpp-pragma-importcpp-for-procs
proc initCppVector*[T](): CppVector[T] {.constructor, importcpp: "std::vector<'*0>(@)".}
proc initCppVector*[T](n: csize_t): CppVector[T] {.constructor, importcpp: "std::vector<'*0>(@)".}
proc initCppVector*[T](n: csize_t, val: T): CppVector[T] {.constructor, importcpp: "std::vector<'*0>(@)".}
proc initCppVector*[T](x: CppVector[T]): CppVector[T] {.constructor, importcpp: "std::vector<'*0>(@)".}
proc initCppVector*[T](first, last: CppVectorConstIterator[T]): CppVector[T] {.constructor, importcpp: "std::vector<'*0>(@)".}

# Iterators
proc begin*[T](v: CppVector[T]): CppVectorIterator[T] {.importcpp: "begin".} =
  ## Return a mutable C++ iterator pointing to the beginning position of the CppVector.
  ##
  ## https://www.cplusplus.com/reference/CppVector/CppVector/begin/
  runnableExamples:
    var
      v = @[1, 2, 3].toCppVector()
    discard v.insert(v.begin(), 100)
    doAssert v.toSeq() == @[100, 1, 2, 3]

proc `end`*[T](v: CppVector[T]): CppVectorIterator[T] {.importcpp: "end".} =
  ## Return a mutable C++ iterator pointing to *after* the end position of the CppVector.
  ##
  ## https://www.cplusplus.com/reference/CppVector/CppVector/end/
  runnableExamples:
    var
      v = @[1, 2, 3].toCppVector()
    discard v.insert(v.`end`(), 100)
    doAssert v.toSeq() == @[1, 2, 3, 100]

proc cBegin*[T](v: CppVector[T]): CppVectorConstIterator[T] {.importcpp: "cbegin".} =
  ## Return an immutable C++ iterator pointing to the beginning position of the CppVector.
  ##
  ## https://www.cplusplus.com/reference/CppVector/CppVector/begin/
  runnableExamples:
    var
      v = @[1, 2, 3].toCppVector()
    discard v.insert(v.cBegin(), 100)
    doAssert v.toSeq() == @[100, 1, 2, 3]

proc cEnd*[T](v: CppVector[T]): CppVectorConstIterator[T] {.importcpp: "cend".} =
  ## Return an immutable C++ iterator pointing to *after* the end position of the CppVector.
  ##
  ## https://www.cplusplus.com/reference/CppVector/CppVector/end/
  runnableExamples:
    var
      v = @[1, 2, 3].toCppVector()
    discard v.insert(v.cEnd(), 100)
    doAssert v.toSeq() == @[1, 2, 3, 100]

proc rBegin*[T](x: CppVector[T]): CppVectorIterator[T] {.importcpp: "rbegin".}
proc rEnd*[T](x: CppVector[T]): CppVectorIterator[T] {.importcpp: "rend".}

proc crBegin*[T](x: CppVector[T]): CppVectorConstIterator[T] {.importcpp: "crbegin".}
proc crEnd*[T](x: CppVector[T]): CppVectorConstIterator[T] {.importcpp: "crend".}

# Capacity
proc size*(v: CppVector): csize_t {.importcpp: "size".} =
  ## Return the number of elements in the CppVector.
  ##
  ## This has an alias proc `len <#len%2CCppVector>`_.
  ##
  ## https://en.cppreference.com/w/cpp/container/CppVector/size
  runnableExamples:
    var
      v = initCppVector[int]()
    doAssert v.size() == 0

    v.add(100)
    v.add(200)
    doAssert v.len() == 2
    doAssert v.size() == 2

proc maxSize*[T](self: CppVector[T]): csize_t {.importcpp: "max_size".}
proc resize*[T](self: CppVector[T], n: csize_t) {.importcpp: "resize".}
proc capacity*[T](self: CppVector[T]): csize_t {.importcpp: "capacity".}

proc empty*(v: CppVector): bool {.importcpp: "empty".} =
  ## Check if the CppVector is empty i.e. has zero elements.
  ##
  ## https://en.cppreference.com/w/cpp/container/CppVector/empty
  runnableExamples:
    var
      v = initCppVector[int]()
    doAssert v.empty()

    v.add(100)
    doAssert not v.empty()

proc reserve*[T](self: var CppVector[T], n: csize_t) {.importcpp: "reserve".}
proc shrinkToFit*[T](self: var CppVector[T]) {.importcpp: "shrink_to_fit".}

# Internal utility functions
proc unsafeIndex[T](self: var CppVector[T], i: csize_t): var T {.importcpp: "#[#]".}
proc unsafeIndex[T](self: CppVector[T], i: csize_t): lent T {.importcpp: "#[#]".}

proc at*[T](self: var CppVector[T], n: csize_t): var T {.importcpp: "at".}
proc at*[T](self: CppVector[T], n: csize_t): T {.importcpp: "at".}

proc front*[T](v: var CppVector[T]): var T {.importcpp: "front".} =
  ## Return the reference to the first element of the CppVector.
  ##
  ## This has an alias proc `first <#first%2CCppVector[T]>`_.
  ##
  ## https://en.cppreference.com/w/cpp/container/CppVector/front
  runnableExamples:
    var
      v = initCppVector[int]()

    v.add(100)
    v.add(200)
    doAssert v.front() == 100

    v.front() = 300
    doAssert v.front() == 300
proc front*[T](v: CppVector[T]): T {.importcpp: "front".}

proc back*[T](v: var CppVector[T]): var T {.importcpp: "back".} =
  ## Return the reference to the last element of the CppVector.
  ##
  ## This has an alias proc `last <#last%2CCppVector[T]>`_.
  ##
  ## https://www.cplusplus.com/reference/CppVector/CppVector/back/
  runnableExamples:
    var
      v = initCppVector[int]()

    v.add(100)
    v.add(200)
    doAssert v.back() == 200

    v.back() = 300
    doAssert v.back() == 300
proc back*[T](v: CppVector[T]): T {.importcpp: "back".}

proc data*[T](self: CppVector[T]): ptr T {.importcpp: "data".}

# Modifiers
proc assign*[T](v: var CppVector[T], num: csize_t, val: T) {.importcpp: "assign".} =
  ## Return a CppVector with `num` elements assigned to the specified value `val`.
  ##
  ## https://en.cppreference.com/w/cpp/container/CppVector/assign
  runnableExamples:
    var
      v: CppVector[float]

    v.assign(5, 1.0)
    doAssert v.toSeq() == @[1.0, 1.0, 1.0, 1.0, 1.0]

    v.assign(2, 2.3)
    doAssert v.toSeq() == @[2.3, 2.3]

proc assign*[T](n: csize_t, val: T) {.importcpp: "assign".}
proc assign*[T](first: CppVectorIterator[T], last: CppVectorIterator[T]) {.importcpp: "assign".}

proc pushBack*[T](v: var CppVector[T], elem: T){.importcpp: "push_back".} =
  ## Append a new element to the end of the CppVector.
  ##
  ## This has an alias proc `add <#add%2CCppVector[T]%2CT>`_.
  ##
  ## https://en.cppreference.com/w/cpp/container/CppVector/push_back
  runnableExamples:
    var
      v = initCppVector[int]()
    doAssert v.len() == 0

    v.pushBack(100)
    v.pushBack(200)
    doAssert v.len() == 2

proc popBack*[T](v: var CppVector[T]) {.importcpp: "pop_back".} =
  ## Remove the last element of the CppVector.
  ## This proc does not return anything.
  ##
  ## https://www.cplusplus.com/reference/CppVector/CppVector/pop_back/
  runnableExamples:
    var
      v = initCppVector[int]()
    doAssert v.len() == 0

    v.add(100)
    doAssert v.len() == 1

    v.popBack()
    doAssert v.len() == 0

proc insert*[T](v: var CppVector[T], position: CppVectorConstIterator[T], val: T): CppVectorIterator[T] {.importcpp: "insert".} =
  ## Insert an element before the specified position.
  runnableExamples:
    var
      v = @['a', 'b'].toCppVector()
    discard v.insert(v.cBegin(), 'c')
    doAssert v.toSeq() == @['c', 'a', 'b']

proc insert*[T](v: var CppVector[T], position: CppVectorConstIterator[T], count: csize_t, val: T): CppVectorIterator[T] {.importcpp: "insert".} =
  ## Insert `count` copies of element before the specified position.
  runnableExamples:
    var
      v = @['a', 'b'].toCppVector()
    discard v.insert(v.cBegin(), 3, 'c')
    doAssert v.toSeq() == @['c', 'c', 'c', 'a', 'b']

proc insert*[T](v: var CppVector[T], position, first, last: CppVectorConstIterator[T]): CppVectorIterator[T] {.importcpp: "insert".} =
  ## Insert elements from range `first` ..< `last` before the specified position.
  runnableExamples:
    let
      v1 = @['a', 'b'].toCppVector()
    var
      v2: CppVector[char]
    discard v2.insert(v2.cBegin(), v1.cBegin(), v1.cEnd())
    doAssert v2.toSeq() == @['a', 'b']

proc swap*[T](v1, v2: var CppVector[T]) {.importcpp: "swap".} =
  ## Swap the contents of vectors `v1` and `v2`.
  ##
  ## https://en.cppreference.com/w/cpp/container/CppVector/swap
  runnableExamples:
    var
      v1 = @[1, 2, 3].toCppVector()
      v2 = @[7, 8, 9].toCppVector()
    v1.swap(v2)
    doAssert v1.toSeq() == @[7, 8, 9]
    doAssert v2.toSeq() == @[1, 2, 3]

proc erase*[T](self: var CppVector[T], position: CppVectorConstIterator[T]): CppVectorIterator[T] {.importcpp: "erase".}
proc erase*[T](self: var CppVector[T], first, last: CppVectorConstIterator[T]): CppVectorIterator[T] {.importcpp: "erase".}

proc clear*[T](self: var CppVector[T]) {.importcpp: "clear".}

# Relational operators
proc `==`*[T](a: CppVector[T], b: CppVector[T]): bool {.importcpp: "# == #".} =
  ## Return `true` if the contents of lhs and rhs are equal, that is,
  ## they have the same number of elements and each element in lhs compares
  ## equal with the element in rhs at the same position.
  ##
  ## https://en.cppreference.com/w/cpp/container/CppVector/operator_cmp
  runnableExamples:
    let
      v1 = @[1, 2, 3].toCppVector()
      v2 = v1
    doAssert v1 == v2

proc `!=`*[T](a: CppVector[T], b: CppVector[T]): bool {.importcpp: "# != #".} =
  ## Return `true` if the contents of lhs and rhs are not equal, that is,
  ## either they do not have the same number of elements, or one of the elements
  ## in lhs does not compare equal with the element in rhs at the same position.
  ##
  ## https://en.cppreference.com/w/cpp/container/CppVector/operator_cmp
  runnableExamples:
    let
      v1 = @[1, 2, 3].toCppVector()
    var
      v2 = v1
      v3 = v1
    v2.add(4)
    doAssert v2 != v1

    v3[0] = 100
    doAssert v3 != v1

proc `<`*[T](a: CppVector[T], b: CppVector[T]): bool {.importcpp: "# < #".} =
  ## Return `true` if `a` is `lexicographically <https://en.cppreference.com/w/cpp/algorithm/lexicographical_compare>`_
  ## less than `b`.
  ##
  ## https://en.cppreference.com/w/cpp/container/CppVector/operator_cmp
  runnableExamples:
    let
      v1 = @[1, 2, 3].toCppVector()
    var
      v2 = v1
    doAssert not (v1 < v2)

    v2.add(4)
    doAssert v1 < v2

    v2[2] = 0
    doAssert v2 < v1

proc `<=`*[T](a: CppVector[T], b: CppVector[T]): bool {.importcpp: "# <= #".} =
  ## Return `true` if `a` is `lexicographically <https://en.cppreference.com/w/cpp/algorithm/lexicographical_compare>`_
  ## less than or equal to `b`.
  ##
  ## https://en.cppreference.com/w/cpp/container/CppVector/operator_cmp
  runnableExamples:
    let
      v1 = @[1, 2, 3].toCppVector()
    var
      v2 = v1
    doAssert v1 <= v2

    v2.add(4)
    doAssert v1 <= v2

    v2[2] = 0
    doAssert v2 <= v1

proc `>`*[T](a: CppVector[T], b: CppVector[T]): bool {.importcpp: "# > #".} =
  ## Return `true` if `a` is `lexicographically <https://en.cppreference.com/w/cpp/algorithm/lexicographical_compare>`_
  ## greater than `b`.
  ##
  ## https://en.cppreference.com/w/cpp/container/CppVector/operator_cmp
  runnableExamples:
    let
      v1 = @[1, 2, 3].toCppVector()
    var
      v2 = v1
    doAssert not (v2 > v1)

    v2.add(4)
    doAssert v2 > v1

    v2[2] = 0
    doAssert v1 > v2

proc `>=`*[T](a: CppVector[T], b: CppVector[T]): bool {.importcpp: "# >= #".} =
  ## Return `true` if `a` is `lexicographically <https://en.cppreference.com/w/cpp/algorithm/lexicographical_compare>`_
  ## greater than or equal to `b`.
  ##
  ## https://en.cppreference.com/w/cpp/container/CppVector/operator_cmp
  runnableExamples:
    let
      v1 = @[1, 2, 3].toCppVector()
    var
      v2 = v1
    doAssert v2 >= v1

    v2.add(4)
    doAssert v2 >= v1

    v2[2] = 0
    doAssert v1 >= v2

{.pop.} # {.push header: "<vector>".}

# Nim specifics
proc checkIndex[T](self: CppVector[T], i: csize_t) {.inline.} =
  if i >= self.size:
    raise newException(IndexDefect, &"index out of bounds: (i:{i}) <= (n:{self.size})")

# Element access
proc `[]`*[T](self: CppVector[T], idx: Natural): lent T {.inline.} =
  ## Return the reference to `self[idx]`.
  let i = csize_t(idx)
  when compileOption("boundChecks"): self.checkIndex(i)
  self.unsafeIndex(i)

proc `[]`*[T](self: var CppVector[T], idx: Natural): var T {.inline.} =
  ## Return the reference to `self[idx]`.
  runnableExamples:
    var
      v = initCppVector[char]()
    v.add('a')
    v.add('b')
    v.add('c')

    v[1] = 'z'
    doAssert v[0] == 'a'
    doAssert v[1] == 'z'
    doAssert v[2] == 'c'
  #
  let i = csize_t(idx)
  when compileOption("boundChecks"): self.checkIndex(i)
  # this strange syntax is to avoid a bug in the Nim C++ code generator
  (addr self.unsafeIndex(i))[]

proc `[]=`*[T](self: var CppVector[T], idx: Natural, val: T) {.inline.} =
  ## Set the value at `v[idx]` to the specified value `val`.
  runnableExamples:
    var
      v = initCppVector[int](2)
    doAssert v.toSeq() == @[0, 0]

    v[0] = -1
    doAssert v.toSeq() == @[-1, 0]
  #
  let i = csize_t(idx)
  when compileOption("boundChecks"): self.checkIndex(i)
  self.unsafeIndex(i) = val

# Converter: CppVectorIterator -> CppVectorConstIterator
converter CppVectorIteratorToCppVectorConstIterator*[T](x: CppVectorIterator[T]):
          CppVectorConstIterator[T] {.importcpp: "#".}
  ## Implicitly convert mutable C++ iterator to immutable C++ iterator.

# Display the content of a vector
proc `$`*[T](v: CppVector[T]): string =
  ## The `$` operator for CppVector type variables.
  ## This is used internally when calling `echo` on a CppVector type variable.
  runnableExamples:
    var
      v = initCppVector[int]()
    doAssert $v == "[]"

    v.add(100)
    v.add(200)
    doAssert $v == "[100, 200]"
  #
  if v.empty():
    result = "[]"
  else:
    result = "["
    for idx in 0.csize_t ..< v.size()-1:
      result.add($v[idx] & ", ")
    result.add($v.last() & "]")

# Iterators arithmetics
iteratorsArithmetics(CppVectorIterator)
iteratorsArithmetics(CppVectorConstIterator)

# Aliases

proc len*(v: CppVector): csize_t {.inline.} =
  ## Alias for `size proc <#size%2CCppVector>`_.
  v.size()

proc add*[T](v: var CppVector[T]; elem: T) {.inline.} =
  ## Alias for `pushBack proc <#pushBack%2CCppVector[T]%2CT>`_.
  runnableExamples:
    var
      v = initCppVector[int]()
    doAssert v.len() == 0

    v.add(100)
    v.add(200)
    doAssert v.len() == 2
  #
  v.pushBack(elem)

proc first*[T](v: var CppVector[T]): var T {.inline.} =
  ## Alias for `front proc <#front%2CCppVector[T]>`_.
  runnableExamples:
    var
      v = initCppVector[int]()

    v.add(100)
    v.add(200)
    doAssert v.first() == 100

    v.first() = 300
    doAssert v.first() == 300
  #
  v.front()

proc first*[T](v: CppVector[T]): T {.inline.} =
  ## Alias for `front proc <#front%2CCppVector[T]_2>`_.
  v.front()

proc last*[T](v: var CppVector[T]): var T {.inline.} =
  ## Alias for `back proc <#back%2CCppVector[T]>`_.
  runnableExamples:
    var
      v = initCppVector[int]()

    v.add(100)
    v.add(200)
    doAssert v.last() == 200

    v.last() = 300
    doAssert v.last() == 300
  #
  v.back()

proc last*[T](v: CppVector[T]): T {.inline.} =
  ## Alias for `back proc <#back%2CCppVector[T]_2>`_.
  v.back()

# Nim Iterators

iterator items*[T](v: CppVector[T]): T =
  ## Iterate over all the elements in CppVector `v`.
  runnableExamples:
    var
      v: CppVector[int]
      sum: int

    v.assign(3, 5)

    for elem in v:
      sum += elem
    doAssert sum == 15
  #
  for idx in 0.csize_t ..< v.len():
    yield v[idx]

iterator pairs*[T](v: CppVector[T]): (csize_t, T) =
  ## Iterate over `(index, value)` for all the elements in CppVector `v`.
  runnableExamples:
    var
      v: CppVector[int]
      sum: int

    v.assign(3, 5)

    for idx, elem in v:
      sum += idx.int + elem
    doAssert sum == 18
  #
  for idx in 0.csize_t ..< v.len():
    yield (idx, v[idx])

# To and from seq
proc toSeq*[T](v: CppVector[T]): seq[T] =
  ## Convert a CppVector to a sequence.
  runnableExamples:
    var
      v: CppVector[char]
    v.assign(3, 'k')

    doAssert v.toSeq() == @['k', 'k', 'k']
  #
  for elem in v:
    result.add(elem)

proc toCppVector*[T](s: openArray[T]): CppVector[T] =
  ## Convert an array/sequence to a CppVector.
  runnableExamples:
    let
      s = @[1, 2, 3]
      a = [1, 2, 3]

    doAssert s.toCppVector().toSeq() == s
    doAssert a.toCppVector().toSeq() == s
  #
  for elem in s:
    result.add(elem)
