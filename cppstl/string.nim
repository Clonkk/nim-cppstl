# Copyright 2019 Nouredine Hussain

# This code is licensed under MIT license (see LICENSE.txt for details)

import strformat
import ./private/utils
import ./exception
export exception

{.push header: "<string>".}
type
  StdString* {.importcpp: "std::string".} = object

  StdStrIterator* {.importcpp: "std::string::iterator".} = object

  StdStrConstIterator* {.importcpp: "std::string::const_iterator".} = object

# std_npos is declared as the highest possible value of csize_t
# In C++ it is -1 due how overflow works
const std_npos*: csize_t = high(typedesc[csize_t])

#Constructor
proc initStdString*(): StdString {.importcpp: "std::string()".}
proc initStdString*(str: StdString): StdString {.importcpp: "std::string(@)".}
proc initStdString*(str: StdString, pos: csize_t): StdString {.importcpp: "std::string(@)".}
proc initStdString*(str: StdString, pos, len: csize_t): StdString {.importcpp: "std::string(@)".}
proc initStdString*(s: cstring): StdString {.importcpp: "std::string(@)".}
proc initStdString*(s: cstring, n: csize_t): StdString {.importcpp: "std::string(@)".}
proc initStdString*(first, last: StdStrConstIterator): StdString {.importcpp: "std::string(@)".}

# Iterators
proc begin*(x: StdString): StdStrIterator {.importcpp: "begin".}
proc `end`*(x: StdString): StdStrIterator {.importcpp: "end".}

proc rbegin*(x: StdString): StdStrIterator {.importcpp: "rbegin".}
proc rend*(x: StdString): StdStrIterator {.importcpp: "rend".}

proc cbegin*(x: StdString): StdStrConstIterator {.importcpp: "cbegin".}
proc cend*(x: StdString): StdStrConstIterator {.importcpp: "cend".}

proc crbegin*(x: StdString): StdStrConstIterator {.importcpp: "crbegin".}
proc crend*(x: StdString): StdStrConstIterator {.importcpp: "crend".}

# Capacity
proc size*(self: StdString): csize_t {.importcpp: "size".}
proc length*(s: StdString): csize_t {.importcpp: "length".}
proc max_size*(self: StdString): csize_t {.importcpp: "max_size".}
proc resize*(self: StdString, n: csize_t) {.importcpp: "resize".}
proc capacity*(self: StdString): csize_t {.importcpp: "capacity".}
proc reserve*(self: var StdString, n: csize_t) {.importcpp: "reserve".}
proc clear*(self: var StdString) {.importcpp: "clear".}
proc empty*(self: StdString): bool {.importcpp: "empty".}
proc shrink_to_fit*(self: var StdString) {.importcpp: "shrink_to_fit".}

# Element access
proc at*(self: var StdString, n: csize_t): var cchar {.importcpp: "at".}
proc at*(self: StdString, n: csize_t): cchar {.importcpp: "at".}

proc front*(self: StdString): cchar {.importcpp: "front".}
proc front*(self: var StdString): var cchar {.importcpp: "front".}

proc back*(self: StdString): cchar {.importcpp: "back".}
proc back*(self: var StdString): var cchar {.importcpp: "back".}

# Internal utility functions
proc unsafeIndex(self: var StdString, i: csize_t): var cchar {.importcpp: "#[#]".}
proc unsafeIndex(self: StdString, i: csize_t): cchar {.importcpp: "#[#]".}

# Modifiers
proc `+=`*(self: var StdString, str: StdString): var StdString {.importcpp: "# += #".}
proc `+=`*(self: var StdString, str: cstring): var StdString {.importcpp: "# += #".}
proc `+=`*(self: var StdString, str: cchar): var StdString {.importcpp: "# += #".}

proc append*(self: var StdString, str: StdString): var StdString {.importcpp: "append".}
proc append*(self: var StdString, str: StdString, subpos, sublen: csize_t): var StdString {.importcpp: "append".}
proc append*(self: var StdString, str: cstring): var StdString {.importcpp: "append".}
proc append*(self: var StdString, str: cstring, n: csize_t): var StdString {.importcpp: "append".}
proc append*(self: var StdString, n: csize_t, str: cchar): var StdString {.importcpp: "append".}
proc append*(self: var StdString, first, last: StdStrConstIterator): var StdString {.importcpp: "append".}

proc push_back*(self: var StdString, x: cchar): var StdString {.importcpp: "push_back".}

proc assign*(self: var StdString, str: StdString): var StdString {.importcpp: "assign".}
proc assign*(self: var StdString, str: StdString, subpos, sublen: csize_t): var StdString {.importcpp: "assign".}
proc assign*(self: var StdString, str: cstring): var StdString {.importcpp: "assign".}
proc assign*(self: var StdString, str: cstring, n: csize_t): var StdString {.importcpp: "assign".}
proc assign*(self: var StdString, n: csize_t, c: cchar): var StdString {.importcpp: "assign".}
proc assign*(self: var StdString, first, last: StdStrConstIterator): var StdString {.importcpp: "assign".}

proc insert*(self: var StdString, pos: csize_t, str: StdString): var StdString {.importcpp: "insert".}
proc insert*(self: var StdString, pos: csize_t, str: StdString, subpos, sublen: csize_t): var StdString {.
    importcpp: "insert".}
proc insert*(self: var StdString, pos: csize_t, s: cstring): var StdString {.importcpp: "insert".}
proc insert*(self: var StdString, pos: csize_t, s: cstring, n: csize_t): var StdString {.importcpp: "insert".}
proc insert*(self: var StdString, p, n: csize_t, c: cchar): var StdString {.importcpp: "insert".}
proc insert*(self: var StdString, p: StdStrConstIterator, n: csize_t, c: cchar): var StdString {.importcpp: "insert".}
proc insert*(self: var StdString, p: StdStrConstIterator, c: cchar): var StdString {.importcpp: "insert".}
proc insert*(self: var StdString, p: StdStrIterator, first, last: StdStrConstIterator): var StdString {.
    importcpp: "insert".}

proc erase*(self: var StdString): StdStrIterator {.importcpp: "erase".}
proc erase*(self: var StdString, pos: csize_t, l: csize_t = std_npos): var StdString {.importcpp: "erase".}
proc erase*(self: var StdString, pos: StdStrIterator): StdStrIterator {.importcpp: "erase".}
proc erase*(self: var StdString, first, last: StdStrIterator): StdStrIterator {.importcpp: "erase".}

proc replace*(self: var StdString, pos, l: csize_t, str: StdString): var StdString {.importcpp: "replace".}
proc replace*(self: var StdString, i1, i2: StdStrConstIterator, str: StdString): var StdString {.importcpp: "replace".}
proc replace*(self: var StdString, pos, l: csize_t, str: StdString, subpos, subl: csize_t): var StdString {.
    importcpp: "replace".}
proc replace*(self: var StdString, pos, l: csize_t, s: cstring): var StdString {.importcpp: "replace".}
proc replace*(self: var StdString, i1, i2: StdStrConstIterator, s: cstring): var StdString {.importcpp: "replace".}
proc replace*(self: var StdString, pos, l: csize_t, s: cstring, n: csize_t): var StdString {.importcpp: "replace".}
proc replace*(self: var StdString, i1, i2: StdStrConstIterator, s: cstring, n: csize_t): var StdString {.
    importcpp: "replace".}
proc replace*(self: var StdString, pos, l: csize_t, n: csize_t, c: cchar): var StdString {.importcpp: "replace".}
proc replace*(self: var StdString, i1, i2: StdStrConstIterator, n: csize_t, c: cchar): var StdString {.
    importcpp: "replace".}
proc replace*(self: var StdString, i1, i2: StdStrConstIterator, first, last: StdStrConstIterator): var StdString {.
    importcpp: "replace".}

proc swap*(self: var StdString, x: var StdString) {.importcpp: "swap".}

proc pop_back*(self: var StdString) {.importcpp: "pop_back".}

# StdString operations
proc c_str*(self: StdString): cstring {.importcpp: "c_str".}

proc data*(self: StdString): ptr cchar {.importcpp: "data".}

proc copy*(self: StdString, s: ptr cchar, l: csize_t, pos: csize_t = 0): csize_t {.importcpp: "copy".}

proc find*(self, str: StdString, pos: csize_t = 0): csize_t {.importcpp: "find".}
proc find*(self, str: StdString, pos, n: csize_t): csize_t {.importcpp: "find".}
proc find*(self: StdString, s: cstring, pos: csize_t = 0): csize_t {.importcpp: "find".}
proc find*(self: StdString, s: cstring, pos, n: csize_t): csize_t {.importcpp: "find".}
proc find*(self: StdString, c: cchar, pos: csize_t = 0): csize_t {.importcpp: "find".}

proc rfind*(self, str: StdString, pos: csize_t = std_npos): csize_t {.importcpp: "rfind".}
proc rfind*(self: StdString, s: StdString, pos, n: csize_t): csize_t {.importcpp: "rfind".}
proc rfind*(self: StdString, s: cstring, pos: csize_t = std_npos): csize_t {.importcpp: "rfind".}
proc rfind*(self: StdString, s: cstring, pos, n: csize_t): csize_t {.importcpp: "rfind".}
proc rfind*(self: StdString, c: cchar, pos: csize_t = std_npos): csize_t {.importcpp: "rfind".}

proc find_first_of*(self, str: StdString, pos: csize_t = 0): csize_t {.importcpp: "find_first_of".}
proc find_first_of*(self, str: StdString, pos, n: csize_t): csize_t {.importcpp: "find_first_of".}
proc find_first_of*(self: StdString, s: cstring, pos: csize_t = 0): csize_t {.importcpp: "find_first_of".}
proc find_first_of*(self: StdString, s: cstring, pos, n: csize_t): csize_t {.importcpp: "find_first_of".}
proc find_first_of*(self: StdString, c: cchar, pos: csize_t = 0): csize_t {.importcpp: "find_first_of".}

proc find_last_of*(self, str: StdString, pos: csize_t = std_npos): csize_t {.importcpp: "find_last_of".}
proc find_last_of*(self: StdString, s: StdString, pos, n: csize_t): csize_t {.importcpp: "find_last_of".}
proc find_last_of*(self: StdString, s: cstring, pos: csize_t = std_npos): csize_t {.importcpp: "find_last_of".}
proc find_last_of*(self: StdString, s: cstring, pos, n: csize_t): csize_t {.importcpp: "find_last_of".}
proc find_last_of*(self: StdString, c: cchar, pos: csize_t = std_npos): csize_t {.importcpp: "find_last_of".}

proc find_first_not_of*(self, str: StdString, pos: csize_t = 0): csize_t {.importcpp: "find_first_not_of".}
proc find_first_not_of*(self, str: StdString, pos, n: csize_t): csize_t {.importcpp: "find_first_not_of".}
proc find_first_not_of*(self: StdString, s: cstring, pos: csize_t = 0): csize_t {.importcpp: "find_first_not_of".}
proc find_first_not_of*(self: StdString, s: cstring, pos, n: csize_t): csize_t {.importcpp: "find_first_not_of".}
proc find_first_not_of*(self: StdString, c: cchar, pos: csize_t = 0): csize_t {.importcpp: "find_first_not_of".}

proc find_last_not_of*(self, str: StdString, pos: csize_t = std_npos): csize_t {.importcpp: "find_last_not_of".}
proc find_last_not_of*(self, str: StdString, pos, n: csize_t): csize_t {.importcpp: "find_last_not_of".}
proc find_last_not_of*(self: StdString, s: cstring, pos: csize_t = std_npos): csize_t {.importcpp: "find_last_not_of".}
proc find_last_not_of*(self: StdString, s: cstring, pos, n: csize_t): csize_t {.importcpp: "find_last_not_of".}
proc find_last_not_of*(self: StdString, c: cchar, pos: csize_t = std_npos): csize_t {.importcpp: "find_last_not_of".}

proc substr*(self: StdString, pos: csize_t = 0, l: csize_t = std_npos): StdString {.importcpp: "substr".}

proc compare*(self, str: StdString): cint {.importcpp: "compare".}
proc compare*(self: StdString, pos, l: csize_t, str: StdString): cint {.importcpp: "compare".}
proc compare*(self: StdString, pos, l: csize_t, str: StdString, subpos, subl: csize_t): cint {.importcpp: "compare".}
proc compare*(self: StdString, s: cstring): cint {.importcpp: "compare".}
proc compare*(self: StdString, pos, l: csize_t, str: cstring): cint {.importcpp: "compare".}
proc compare*(self: StdString, pos, l: csize_t, str: cstring, n: csize_t): cint {.importcpp: "compare".}
proc compare*(self: StdString, pos, l: csize_t, str: cstring, subpos, subl: csize_t): cint {.importcpp: "compare".}

# Non-member function overloads

proc `+`*(a: StdString, b: cchar): StdString {.importcpp: "# + char(#)".}
proc `+`*(a: cchar, b: StdString): StdString {.importcpp: "char(#) + #".}
proc `+`*(a: StdString, b: StdString): StdString {.importcpp: "# + #".}

proc `==`*(a: StdString, b: StdString): bool {.importcpp: "# == #".}
proc `!=`*(a: StdString, b: StdString): bool {.importcpp: "# != #".}
proc `<`*(a: StdString, b: StdString): bool {.importcpp: "# < #".}
proc `<=`*(a: StdString, b: StdString): bool {.importcpp: "# <= #".}
proc `>`*(a: StdString, b: StdString): bool {.importcpp: "# > #".}
proc `>=`*(a: StdString, b: StdString): bool {.importcpp: "# >= #".}

# Converter: StdStrIterator -> StrConstIterator
converter StdStrIteratorToStrConstIterator*(s: StdStrIterator): StdStrConstIterator {.importcpp: "#".}

{.pop.}

proc initStdString*(s: string): StdString =
  initStdString(s.cstring)

proc `+`*(a: StdString, b: string|cstring): StdString =
  a + initStdString(b)

proc `==`*(a: StdString, b: string|cstring): bool =
  a == initStdString(b)

proc `!=`*(a: StdString, b: string|cstring): bool =
  a != initStdString(b)

proc `<`*(a: StdString, b: string|cstring): bool =
  a < initStdString(b)

proc `<=`*(a: StdString, b: string|cstring): bool =
  a <= initStdString(b)

proc `>`*(a: StdString, b: string|cstring): bool =
  a > initStdString(b)

proc `>=`*(a: StdString, b: string|cstring): bool =
  a >= initStdString(b)


proc `+`*(a: string|cstring, b: StdString): StdString =
  initStdString(a) + b

proc `==`*(a: string|cstring, b: StdString): bool =
  initStdString(a) == b

proc `!=`*(a: string|cstring, b: StdString): bool =
  initStdString(a) != b

proc `<`*(a: string|cstring, b: StdString): bool =
  initStdString(a) < b

proc `<=`*(a: string|cstring, b: StdString): bool =
  initStdString(a) <= b

proc `>`*(a: string|cstring, b: StdString): bool =
  initStdString(a) > b

proc `>=`*(a: string|cstring, b: StdString): bool =
  initStdString(a) >= b

proc checkIndex(self: StdString, i: csize_t) =
  if i > self.size:
    raise newException(IndexDefect, &"index out of bounds: (i:{i}) <= (n:{self.size})")

proc `[]`*(self: StdString, idx: Natural): cchar =
  let i = csize_t(idx)
  # If you add a mechanism exception to operator `[]`  it simply becomes at so might as well use at directly
  when compileOption("boundChecks"): checkIndex(self, i)
  self.unsafeIndex(i)

proc `[]`*(self: var StdString, idx: Natural): var cchar =
  let i = csize_t(idx)
  # If you add a mechanism exception to operator `[]`  it simply becomes at so might as well use at directly
  when compileOption("boundChecks"): checkIndex(self, i)
  # TODO : find Nim bugs # associated
  # This strange syntax is to avoid a bug in the Nim c++ code generator
  (addr self.unsafeIndex(i))[]

proc `[]=`*(self: var StdString, idx: Natural, val: cchar) =
  let i = csize_t(idx)
  when compileOption("boundChecks"): checkIndex(self, i)
  self.unsafeIndex(i) = val


# Converter: StdString -> cstring
# converter CppStdStringToCStdString*(s: StdString): cstring = s.c_str()

# Converter: string, cstring -> StdString
# converter StringToCppStdString(s: string): StdString {.inline.} =
#   initStdString(cstring(s), len(s).csize_t)

# Converter: string -> StdString
# converter StdStringToCppStdString*(s: string): StdString = s.cstring
# Converter: StdString -> string
# converter CppStdStringToStdString*(s: StdString): string = $(s.cstring)


# Display StdString
proc `$`*(s: StdString): string {.noinit.} =
  result = $(s.c_str())

# Iterators arithmetics
iteratorsArithmetics(StdStrIterator)
iteratorsArithmetics(StdStrConstIterator)
