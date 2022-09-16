# This code is licensed under MIT license (see LICENSE.txt for details)

import strformat
import ./private/utils
import ./std_exception
export std_exception
when not defined(cpp):
  {.error: "C++ backend required to use STL wrapper".}

{.push header: "<string>".}

type
  CppBasicString*[T] {.importcpp: "std::basic_string".} = object
  CppBasicStringIterator*[T] {.importcpp: "std::basic_string<'0>::iterator".} = object
  CppBasicStringConstIterator*[T] {.importcpp: "std::basic_string<'0>::const_iterator".} = object

# npos is declared as the highest possible value of csize_t
# In C++ it is -1 due how overflow works
const std_npos*: csize_t = high(typedesc[csize_t])

# Constructor
proc initCppBasicString*[T](): CppBasicString[T] {.constructor, importcpp: "std::basic_string<'*0>()".}
proc initCppBasicString*[T](str: CppBasicString[T]): CppBasicString[T] {.constructor, importcpp: "std::basic_string<'*0>(@)".}
proc initCppBasicString*[T](str: CppBasicString[T], pos: csize_t): CppBasicString[T] {.constructor, importcpp: "std::basic_string<'*0>(@)".}
proc initCppBasicString*[T](str: CppBasicString[T], pos, len: csize_t): CppBasicString[T] {.constructor, importcpp: "std::basic_string<'*0>(@)".}
proc initCppBasicString*[T](s: ptr UncheckedArray[T]): CppBasicString[T] {.constructor, importcpp: "std::basic_string<'*0>(@)".}
proc initCppBasicString*[T](s: ptr UncheckedArray[T], n: csize_t): CppBasicString[T] {.constructor, importcpp: "std::basic_string<'*0>(@)".}
proc initCppBasicString*[T](first, last: CppBasicStringConstIterator): CppBasicString[T] {.constructor, importcpp: "std::basic_string<'*0>(@)".}

# Iterators
proc begin*[T](x: CppBasicString[T]): CppBasicStringIterator[T] {.importcpp: "begin".}
proc `end`*[T](x: CppBasicString[T]): CppBasicStringIterator[T] {.importcpp: "end".}

proc rBegin*[T](x: CppBasicString[T]): CppBasicStringIterator[T] {.importcpp: "rbegin".}
proc rEnd*[T](x: CppBasicString[T]): CppBasicStringIterator[T] {.importcpp: "rend".}

proc cBegin*[T](x: CppBasicString[T]): CppBasicStringConstIterator[T] {.importcpp: "cbegin".}
proc cEnd*[T](x: CppBasicString[T]): CppBasicStringConstIterator[T] {.importcpp: "cend".}

proc crBegin*[T](x: CppBasicString[T]): CppBasicStringConstIterator[T] {.importcpp: "crbegin".}
proc crEnd*[T](x: CppBasicString[T]): CppBasicStringConstIterator[T] {.importcpp: "crend".}

# Capacity
proc size*[T](self: CppBasicString[T]): csize_t {.importcpp: "size".}
proc length*[T](s: CppBasicString[T]): csize_t {.importcpp: "length".}
proc maxSize*[T](self: CppBasicString[T]): csize_t {.importcpp: "max_size".}
proc resize*[T](self: CppBasicString[T], n: csize_t) {.importcpp: "resize".}
proc capacity*[T](self: CppBasicString[T]): csize_t {.importcpp: "capacity".}
proc reserve*[T](self: var CppBasicString[T], n: csize_t) {.importcpp: "reserve".}
proc clear*[T](self: var CppBasicString[T]) {.importcpp: "clear".}
proc empty*[T](self: CppBasicString[T]): bool {.importcpp: "empty".}
proc shrinkToFit*[T](self: var CppBasicString[T]) {.importcpp: "shrink_to_fit".}

# Element access
proc at*[T](self: var CppBasicString[T], n: csize_t): var T {.importcpp: "at".}
proc at*[T](self: CppBasicString[T], n: csize_t): T {.importcpp: "at".}

proc front*[T](self: CppBasicString[T]): T {.importcpp: "front".}
proc front*[T](self: var CppBasicString[T]): var T {.importcpp: "front".}

proc back*[T](self: CppBasicString[T]): T {.importcpp: "back".}
proc back*[T](self: var CppBasicString[T]): var T {.importcpp: "back".}

# Internal utility functions
proc unsafeIndex[T](self: var CppBasicString[T], i: csize_t): var T {.importcpp: "#[#]".}
proc unsafeIndex[T](self: CppBasicString[T], i: csize_t): lent T {.importcpp: "#[#]".}

# Modifiers
proc `+=`*[T](self: var CppBasicString[T], str: CppBasicString[T]) {.importcpp: "# += #".}
proc `+=`*[T](self: var CppBasicString[T], str: ptr UncheckedArray[T]) {.importcpp: "# += #".}
proc `+=`*[T](self: var CppBasicString[T], str: T) {.importcpp: "# += #".}

proc append*[T](self: var CppBasicString[T], str: CppBasicString[T]) {.importcpp: "append".}
proc append*[T](self: var CppBasicString[T], str: CppBasicString[T], subpos, sublen: csize_t) {.importcpp: "append".}
proc append*[T](self: var CppBasicString[T], str: ptr UncheckedArray[T]) {.importcpp: "append".}
proc append*[T](self: var CppBasicString[T], str: ptr UncheckedArray[T], n: csize_t) {.importcpp: "append".}
proc append*[T](self: var CppBasicString[T], n: csize_t, str: T) {.importcpp: "append".}
proc append*[T](self: var CppBasicString[T], first, last: CppBasicStringConstIterator[T]) {.importcpp: "append".}

proc pushBack*[T](self: var CppBasicString[T], x: T) {.importcpp: "push_back".}

proc assign*[T](self: var CppBasicString[T], str: CppBasicString[T]) {.importcpp: "assign".}
proc assign*[T](self: var CppBasicString[T], str: CppBasicString[T], subpos, sublen: csize_t) {.importcpp: "assign".}
proc assign*[T](self: var CppBasicString[T], str: ptr UncheckedArray[T]) {.importcpp: "assign".}
proc assign*[T](self: var CppBasicString[T], str: ptr UncheckedArray[T], n: csize_t) {.importcpp: "assign".}
proc assign*[T](self: var CppBasicString[T], n: csize_t, c: T) {.importcpp: "assign".}
proc assign*[T](self: var CppBasicString[T], first, last: CppBasicStringConstIterator[T]) {.importcpp: "assign".}

proc insert*[T](self: var CppBasicString[T], pos: csize_t, str: CppBasicString[T]) {.importcpp: "insert".}
proc insert*[T](self: var CppBasicString[T], pos: csize_t, str: CppBasicString[T], subpos, sublen: csize_t) {.
    importcpp: "insert".}
proc insert*[T](self: var CppBasicString[T], pos: csize_t, s: ptr UncheckedArray[T]) {.importcpp: "insert".}
proc insert*[T](self: var CppBasicString[T], pos: csize_t, s: ptr UncheckedArray[T], n: csize_t) {.importcpp: "insert".}
proc insert*[T](self: var CppBasicString[T], p, n: csize_t, c: T) {.importcpp: "insert".}
proc insert*[T](self: var CppBasicString[T], p: CppBasicStringConstIterator[T], n: csize_t, c: T) {.importcpp: "insert".}
proc insert*[T](self: var CppBasicString[T], p: CppBasicStringConstIterator[T], c: T) {.importcpp: "insert".}
proc insert*[T](self: var CppBasicString[T], p: CppBasicStringIterator[T], first, last: CppBasicStringConstIterator[T]) {.
    importcpp: "insert".}

proc erase*[T](self: var CppBasicString[T]) {.importcpp: "erase".}
proc erase*[T](self: var CppBasicString[T], pos: csize_t, l: csize_t = std_npos) {.importcpp: "erase".}
proc erase*[T](self: var CppBasicString[T], pos: CppBasicStringIterator[T]) {.importcpp: "erase".}
proc erase*[T](self: var CppBasicString[T], first, last: CppBasicStringIterator[T]) {.importcpp: "erase".}

proc replace*[T](self: var CppBasicString[T], pos, l: csize_t, str: CppBasicString[T]) {.importcpp: "replace".}
proc replace*[T](self: var CppBasicString[T], i1, i2: CppBasicStringConstIterator[T], str: CppBasicString[T]) {.importcpp: "replace".}
proc replace*[T](self: var CppBasicString[T], pos, l: csize_t, str: CppBasicString[T], subpos, subl: csize_t) {.
    importcpp: "replace".}
proc replace*[T](self: var CppBasicString[T], pos, l: csize_t, s: ptr UncheckedArray[T]) {.importcpp: "replace".}
proc replace*[T](self: var CppBasicString[T], i1, i2: CppBasicStringConstIterator[T], s: ptr UncheckedArray[T]) {.importcpp: "replace".}
proc replace*[T](self: var CppBasicString[T], pos, l: csize_t, s: ptr UncheckedArray[T], n: csize_t) {.importcpp: "replace".}
proc replace*[T](self: var CppBasicString[T], i1, i2: CppBasicStringConstIterator[T], s: ptr UncheckedArray[T], n: csize_t) {.
    importcpp: "replace".}
proc replace*[T](self: var CppBasicString[T], pos, l: csize_t, n: csize_t, c: T) {.importcpp: "replace".}
proc replace*[T](self: var CppBasicString[T], i1, i2: CppBasicStringConstIterator[T], n: csize_t, c: T) {.
    importcpp: "replace".}
proc replace*[T](self: var CppBasicString[T], i1, i2: CppBasicStringConstIterator[T], first, last: CppBasicStringConstIterator[T]) {.
    importcpp: "replace".}

proc swap*[T](self: var CppBasicString[T], x: var CppBasicString[T]) {.importcpp: "swap".}

proc popBack*[T](self: var CppBasicString[T]) {.importcpp: "pop_back".}

# CppBasicString[T] operations
# Avoid const T* vs T* issues
proc cStr*[T](self: CppBasicString[T]): ptr UncheckedArray[T] {.importcpp: "const_cast<'0'*>(#.c_str())".}
func data*[T](self: CppBasicString[T]): ptr T {.importcpp: "const_cast<'0'*>(#.data())".}

proc copy*[T](self: CppBasicString[T], s: ptr T, l: csize_t, pos: csize_t = 0): csize_t {.importcpp: "copy".}

proc find*[T](self, str: CppBasicString[T], pos: csize_t = 0): csize_t {.importcpp: "find".}
proc find*[T](self, str: CppBasicString[T], pos, n: csize_t): csize_t {.importcpp: "find".}
proc find*[T](self: CppBasicString[T], s: ptr UncheckedArray[T], pos: csize_t = 0): csize_t {.importcpp: "find".}
proc find*[T](self: CppBasicString[T], s: ptr UncheckedArray[T], pos, n: csize_t): csize_t {.importcpp: "find".}
proc find*[T](self: CppBasicString[T], c: T, pos: csize_t = 0): csize_t {.importcpp: "find".}

proc rfind*[T](self, str: CppBasicString[T], pos: csize_t = std_npos): csize_t {.importcpp: "rfind".}
proc rfind*[T](self: CppBasicString[T], s: CppBasicString[T], pos, n: csize_t): csize_t {.importcpp: "rfind".}
proc rfind*[T](self: CppBasicString[T], s: ptr UncheckedArray[T], pos: csize_t = std_npos): csize_t {.importcpp: "rfind".}
proc rfind*[T](self: CppBasicString[T], s: ptr UncheckedArray[T], pos, n: csize_t): csize_t {.importcpp: "rfind".}
proc rfind*[T](self: CppBasicString[T], c: T, pos: csize_t = std_npos): csize_t {.importcpp: "rfind".}

proc findFirstOf*[T](self, str: CppBasicString[T], pos: csize_t = 0): csize_t {.importcpp: "find_first_of".}
proc findFirstOf*[T](self, str: CppBasicString[T], pos, n: csize_t): csize_t {.importcpp: "find_first_of".}
proc findFirstOf*[T](self: CppBasicString[T], s: ptr UncheckedArray[T], pos: csize_t = 0): csize_t {.importcpp: "find_first_of".}
proc findFirstOf*[T](self: CppBasicString[T], s: ptr UncheckedArray[T], pos, n: csize_t): csize_t {.importcpp: "find_first_of".}
proc findFirstOf*[T](self: CppBasicString[T], c: T, pos: csize_t = 0): csize_t {.importcpp: "find_first_of".}

proc findLastOf*[T](self, str: CppBasicString[T], pos: csize_t = std_npos): csize_t {.importcpp: "find_last_of".}
proc findLastOf*[T](self: CppBasicString[T], s: CppBasicString[T], pos, n: csize_t): csize_t {.importcpp: "find_last_of".}
proc findLastOf*[T](self: CppBasicString[T], s: ptr UncheckedArray[T], pos: csize_t = std_npos): csize_t {.importcpp: "find_last_of".}
proc findLastOf*[T](self: CppBasicString[T], s: ptr UncheckedArray[T], pos, n: csize_t): csize_t {.importcpp: "find_last_of".}
proc findLastOf*[T](self: CppBasicString[T], c: T, pos: csize_t = std_npos): csize_t {.importcpp: "find_last_of".}

proc findFirstNotOf*[T](self, str: CppBasicString[T], pos: csize_t = 0): csize_t {.importcpp: "find_first_not_of".}
proc findFirstNotOf*[T](self, str: CppBasicString[T], pos, n: csize_t): csize_t {.importcpp: "find_first_not_of".}
proc findFirstNotOf*[T](self: CppBasicString[T], s: ptr UncheckedArray[T], pos: csize_t = 0): csize_t {.importcpp: "find_first_not_of".}
proc findFirstNotOf*[T](self: CppBasicString[T], s: ptr UncheckedArray[T], pos, n: csize_t): csize_t {.importcpp: "find_first_not_of".}
proc findFirstNotOf*[T](self: CppBasicString[T], c: T, pos: csize_t = 0): csize_t {.importcpp: "find_first_not_of".}

proc findLastNotOf*[T](self, str: CppBasicString[T], pos: csize_t = std_npos): csize_t {.importcpp: "find_last_not_of".}
proc findLastNotOf*[T](self, str: CppBasicString[T], pos, n: csize_t): csize_t {.importcpp: "find_last_not_of".}
proc findLastNotOf*[T](self: CppBasicString[T], s: ptr UncheckedArray[T], pos: csize_t = std_npos): csize_t {.importcpp: "find_last_not_of".}
proc findLastNotOf*[T](self: CppBasicString[T], s: ptr UncheckedArray[T], pos, n: csize_t): csize_t {.importcpp: "find_last_not_of".}
proc findLastNotOf*[T](self: CppBasicString[T], c: T, pos: csize_t = std_npos): csize_t {.importcpp: "find_last_not_of".}

proc substr*[T](self: CppBasicString[T], pos: csize_t = 0, l: csize_t = std_npos): CppBasicString[T] {.importcpp: "substr".}

proc compare*[T](self, str: CppBasicString[T]): cint {.importcpp: "compare".}
proc compare*[T](self: CppBasicString[T], pos, l: csize_t, str: CppBasicString[T]): cint {.importcpp: "compare".}
proc compare*[T](self: CppBasicString[T], pos, l: csize_t, str: CppBasicString[T], subpos, subl: csize_t): cint {.importcpp: "compare".}
proc compare*[T](self: CppBasicString[T], s: ptr UncheckedArray[T]): cint {.importcpp: "compare".}
proc compare*[T](self: CppBasicString[T], pos, l: csize_t, str: ptr UncheckedArray[T]): cint {.importcpp: "compare".}
proc compare*[T](self: CppBasicString[T], pos, l: csize_t, str: ptr UncheckedArray[T], n: csize_t): cint {.importcpp: "compare".}
proc compare*[T](self: CppBasicString[T], pos, l: csize_t, str: ptr UncheckedArray[T], subpos, subl: csize_t): cint {.importcpp: "compare".}

# Non-member function overloads

proc `+`*[T](a: CppBasicString[T], b: T): CppBasicString[T] {.importcpp: "# + ('2)(#)".}
proc `+`*[T](a: T, b: CppBasicString[T]): CppBasicString[T] {.importcpp: "('1)(#) + #".}
proc `+`*[T](a: CppBasicString[T], b: CppBasicString[T]): CppBasicString[T] {.importcpp: "# + #".}

proc `==`*[T](a: CppBasicString[T], b: CppBasicString[T]): bool {.importcpp: "# == #".}
proc `!=`*[T](a: CppBasicString[T], b: CppBasicString[T]): bool {.importcpp: "# != #".}
proc `<`*[T](a: CppBasicString[T], b: CppBasicString[T]): bool {.importcpp: "# < #".}
proc `<=`*[T](a: CppBasicString[T], b: CppBasicString[T]): bool {.importcpp: "# <= #".}
proc `>`*[T](a: CppBasicString[T], b: CppBasicString[T]): bool {.importcpp: "# > #".}
proc `>=`*[T](a: CppBasicString[T], b: CppBasicString[T]): bool {.importcpp: "# >= #".}

# Converter: CppBasicStringIterator[T] -> CppBasicStringConstIterator[T]
converter CppBasicStringIteratorToBasicStringConstIterator*[T](s: CppBasicStringIterator[T]): CppBasicStringConstIterator[T] {.importcpp: "#".}

{.pop.}


{.push inline.}

proc `+`*[T](a: CppBasicString[T], b: ptr UncheckedArray[T]): CppBasicString[T] =
  result = (a + initCppBasicString(b))
proc `+`*[T](a: ptr UncheckedArray[T], b: CppBasicString[T]): CppBasicString[T] =
  let a = initCppBasicString(a)
  result = (a + b)

proc `==`*[T](a: CppBasicString[T], b: ptr UncheckedArray[T]): bool =
  let b = initCppBasicString(b)
  result = (a == b)
proc `==`*[T](a: ptr UncheckedArray[T], b: CppBasicString[T]): bool =
  let a = initCppBasicString(a)
  result = (a == b)

proc `!=`*[T](a: CppBasicString[T], b: ptr UncheckedArray[T]): bool =
  result = (a != initCppBasicString(b))
proc `!=`*[T](a: ptr UncheckedArray[T], b: CppBasicString[T]): bool =
  result = (initCppBasicString(a) != b)

proc `<`*[T](a: CppBasicString[T], b: ptr UncheckedArray[T]): bool =
  result = (a < initCppBasicString(b))
proc `<`*[T](a: ptr UncheckedArray[T], b: CppBasicString[T]): bool =
  result = (initCppBasicString(a) < b)

proc `<=`*[T](a: CppBasicString[T], b: ptr UncheckedArray[T]): bool =
  result = (a <= initCppBasicString(b))
proc `<=`*[T](a: ptr UncheckedArray[T], b: CppBasicString[T]): bool =
  result = (initCppBasicString(a) <= b)

proc `>`*[T](a: CppBasicString[T], b: ptr UncheckedArray[T]): bool =
  result = (a > initCppBasicString(b))
proc `>`*[T](a: ptr UncheckedArray[T], b: CppBasicString[T]): bool =
  result = (initCppBasicString(a) > b)

proc `>=`*[T](a: CppBasicString[T], b: ptr UncheckedArray[T]): bool =
  result = (a >= initCppBasicString(b))
proc `>=`*[T](a: ptr UncheckedArray[T], b: CppBasicString[T]): bool =
  result = (initCppBasicString(a) >= b)

proc checkIndex[T](self: CppBasicString[T], i: csize_t) =
  if i > self.size:
    raise newException(IndexDefect, &"index out of bounds: (i:{i}) <= (n:{self.size})")

proc `[]`*[T](self: CppBasicString[T], idx: Natural): T =
  let i = csize_t(idx)
  # If you add a mechanism exception to operator `[]`  it simply becomes at so might as well use at directly
  when compileOption("boundChecks"): self.checkIndex(i)
  (unsafeAddr self.unsafeIndex(i))[]

proc `[]`*[T](self: var CppBasicString[T], idx: Natural): var T =
  let i = csize_t(idx)
  # If you add a mechanism exception to operator `[]`  it simply becomes at so might as well use at directly
  when compileOption("boundChecks"): self.checkIndex(i)
  # TODO : find Nim bugs # associated
  # This strange syntax is to avoid a bug in the Nim c++ code generator
  (unsafeAddr self.unsafeIndex(i))[]

proc `[]=`*[T](self: var CppBasicString[T], idx: Natural, val: T) =
  let i = csize_t(idx)
  when compileOption("boundChecks"): self.checkIndex(i)
  self.unsafeIndex(i) = val

{.pop.}

# Alias for Nim idiomatic API

proc len*[T](v: CppBasicString[T]): csize_t {.inline.} =
  ## Alias for `size proc <#size%2CCppBasicString[T]>`_.
  v.size()

proc add*[T](v: var CppBasicString[T]; elem: T) {.inline.} =
  ## Alias for `pushBack proc <#pushBack%2CCppBasicString[T][T]%2CT>`_.
  v.pushBack(elem)

proc first*[T](v: var CppBasicString[T]): var T {.inline.} =
  ## Alias for `front proc <#front%2CCppBasicString[T][T]>`_.
  v.front()

proc first*[T](v: CppBasicString[T]): T {.inline.} =
  ## Alias for `front proc <#front%2CCppBasicString[T][T]_2>`_.
  v.front()

proc last*[T](v: var CppBasicString[T]): var T {.inline.} =
  ## Alias for `back proc <#back%2CCppBasicString[T][T]>`_.
  v.back()

proc last*[T](v: CppBasicString[T]): T {.inline.} =
  ## Alias for `back proc <#back%2CCppBasicString[T][T]_2>`_.
  v.back()

# Nim Iterators
iterator items*[T](v: CppBasicString[T]): T =
  ## Iterate over all the elements in CppBasicString[T] `v`.
  for idx in 0.csize_t ..< v.len():
    yield v[idx]

iterator pairs*[T](v: CppBasicString[T]): (csize_t, T) =
  ## Iterate over `(index, value)` for all the elements in CppBasicString[T] `v`.
  for idx in 0.csize_t ..< v.len():
    yield (idx, v[idx])

iterator mitems*[T](v: var CppBasicString[T]): var T =
  ## Iterate over all the elements in CppBasicString[T] `v`.
  for idx in 0.csize_t ..< v.len():
    yield v[idx]

iterator mpairs*[T](v: var CppBasicString[T]): (csize_t, var T) =
  ## Iterate over `(index, value)` for all the elements in CppBasicString[T] `v`.
  for idx in 0.csize_t ..< v.len():
    yield (idx, v[idx])


# Iterators arithmetics
iteratorsArithmetics(CppBasicStringIterator)
iteratorsArithmetics(CppBasicStringConstIterator)
