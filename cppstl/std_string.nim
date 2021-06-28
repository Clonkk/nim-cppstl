# This code is licensed under MIT license (see LICENSE.txt for details)

import strformat
import ./private/utils
import ./std_exception
export std_exception
when not defined(cpp):
  {.error: "C++ backend required to use STL wrapper".}

{.push header: "<string>".}

type
  CppString* {.importcpp: "std::string".} = object
  CppStrIterator* {.importcpp: "std::string::iterator".} = object
  CppStrConstIterator* {.importcpp: "std::string::const_iterator".} = object

# std::string::npos is declared as the highest possible value of csize_t
# In C++ it is -1 due how overflow works
const std_npos*: csize_t = high(typedesc[csize_t])

#Constructor
proc initCppString*(): CppString {.constructor, importcpp: "std::string()".}
proc initCppString*(str: CppString): CppString {.constructor, importcpp: "std::string(@)".}
proc initCppString*(str: CppString, pos: csize_t): CppString {.constructor, importcpp: "std::string(@)".}
proc initCppString*(str: CppString, pos, len: csize_t): CppString {.constructor, importcpp: "std::string(@)".}
proc initCppString*(s: cstring): CppString {.constructor, importcpp: "std::string(@)".}
proc initCppString*(s: cstring, n: csize_t): CppString {.constructor, importcpp: "std::string(@)".}
proc initCppString*(first, last: CppStrConstIterator): CppString {.constructor, importcpp: "std::string(@)".}

# Iterators
proc begin*(x: CppString): CppStrIterator {.importcpp: "begin".}
proc `end`*(x: CppString): CppStrIterator {.importcpp: "end".}

proc rbegin*(x: CppString): CppStrIterator {.importcpp: "rbegin".}
proc rend*(x: CppString): CppStrIterator {.importcpp: "rend".}

proc cbegin*(x: CppString): CppStrConstIterator {.importcpp: "cbegin".}
proc cend*(x: CppString): CppStrConstIterator {.importcpp: "cend".}

proc crbegin*(x: CppString): CppStrConstIterator {.importcpp: "crbegin".}
proc crend*(x: CppString): CppStrConstIterator {.importcpp: "crend".}

# Capacity
proc size*(self: CppString): csize_t {.importcpp: "size".}
proc length*(s: CppString): csize_t {.importcpp: "length".}
proc max_size*(self: CppString): csize_t {.importcpp: "max_size".}
proc resize*(self: CppString, n: csize_t) {.importcpp: "resize".}
proc capacity*(self: CppString): csize_t {.importcpp: "capacity".}
proc reserve*(self: var CppString, n: csize_t) {.importcpp: "reserve".}
proc clear*(self: var CppString) {.importcpp: "clear".}
proc empty*(self: CppString): bool {.importcpp: "empty".}
proc shrink_to_fit*(self: var CppString) {.importcpp: "shrink_to_fit".}

# Element access
proc at*(self: var CppString, n: csize_t): var cchar {.importcpp: "at".}
proc at*(self: CppString, n: csize_t): cchar {.importcpp: "at".}

proc front*(self: CppString): cchar {.importcpp: "front".}
proc front*(self: var CppString): var cchar {.importcpp: "front".}

proc back*(self: CppString): cchar {.importcpp: "back".}
proc back*(self: var CppString): var cchar {.importcpp: "back".}

# Internal utility functions
proc unsafeIndex(self: var CppString, i: csize_t): var cchar {.importcpp: "#[#]".}
proc unsafeIndex(self: CppString, i: csize_t): lent cchar {.importcpp: "#[#]".}

# Modifiers
proc `+=`*(self: var CppString, str: CppString): var CppString {.importcpp: "# += #".}
proc `+=`*(self: var CppString, str: cstring): var CppString {.importcpp: "# += #".}
proc `+=`*(self: var CppString, str: cchar): var CppString {.importcpp: "# += #".}

proc append*(self: var CppString, str: CppString): var CppString {.importcpp: "append".}
proc append*(self: var CppString, str: CppString, subpos, sublen: csize_t): var CppString {.importcpp: "append".}
proc append*(self: var CppString, str: cstring): var CppString {.importcpp: "append".}
proc append*(self: var CppString, str: cstring, n: csize_t): var CppString {.importcpp: "append".}
proc append*(self: var CppString, n: csize_t, str: cchar): var CppString {.importcpp: "append".}
proc append*(self: var CppString, first, last: CppStrConstIterator): var CppString {.importcpp: "append".}

proc push_back*(self: var CppString, x: cchar): var CppString {.importcpp: "push_back".}

proc assign*(self: var CppString, str: CppString): var CppString {.importcpp: "assign".}
proc assign*(self: var CppString, str: CppString, subpos, sublen: csize_t): var CppString {.importcpp: "assign".}
proc assign*(self: var CppString, str: cstring): var CppString {.importcpp: "assign".}
proc assign*(self: var CppString, str: cstring, n: csize_t): var CppString {.importcpp: "assign".}
proc assign*(self: var CppString, n: csize_t, c: cchar): var CppString {.importcpp: "assign".}
proc assign*(self: var CppString, first, last: CppStrConstIterator): var CppString {.importcpp: "assign".}

proc insert*(self: var CppString, pos: csize_t, str: CppString): var CppString {.importcpp: "insert".}
proc insert*(self: var CppString, pos: csize_t, str: CppString, subpos, sublen: csize_t): var CppString {.
    importcpp: "insert".}
proc insert*(self: var CppString, pos: csize_t, s: cstring): var CppString {.importcpp: "insert".}
proc insert*(self: var CppString, pos: csize_t, s: cstring, n: csize_t): var CppString {.importcpp: "insert".}
proc insert*(self: var CppString, p, n: csize_t, c: cchar): var CppString {.importcpp: "insert".}
proc insert*(self: var CppString, p: CppStrConstIterator, n: csize_t, c: cchar): var CppString {.importcpp: "insert".}
proc insert*(self: var CppString, p: CppStrConstIterator, c: cchar): var CppString {.importcpp: "insert".}
proc insert*(self: var CppString, p: CppStrIterator, first, last: CppStrConstIterator): var CppString {.
    importcpp: "insert".}

proc erase*(self: var CppString): CppStrIterator {.importcpp: "erase".}
proc erase*(self: var CppString, pos: csize_t, l: csize_t = std_npos): var CppString {.importcpp: "erase".}
proc erase*(self: var CppString, pos: CppStrIterator): CppStrIterator {.importcpp: "erase".}
proc erase*(self: var CppString, first, last: CppStrIterator): CppStrIterator {.importcpp: "erase".}

proc replace*(self: var CppString, pos, l: csize_t, str: CppString): var CppString {.importcpp: "replace".}
proc replace*(self: var CppString, i1, i2: CppStrConstIterator, str: CppString): var CppString {.importcpp: "replace".}
proc replace*(self: var CppString, pos, l: csize_t, str: CppString, subpos, subl: csize_t): var CppString {.
    importcpp: "replace".}
proc replace*(self: var CppString, pos, l: csize_t, s: cstring): var CppString {.importcpp: "replace".}
proc replace*(self: var CppString, i1, i2: CppStrConstIterator, s: cstring): var CppString {.importcpp: "replace".}
proc replace*(self: var CppString, pos, l: csize_t, s: cstring, n: csize_t): var CppString {.importcpp: "replace".}
proc replace*(self: var CppString, i1, i2: CppStrConstIterator, s: cstring, n: csize_t): var CppString {.
    importcpp: "replace".}
proc replace*(self: var CppString, pos, l: csize_t, n: csize_t, c: cchar): var CppString {.importcpp: "replace".}
proc replace*(self: var CppString, i1, i2: CppStrConstIterator, n: csize_t, c: cchar): var CppString {.
    importcpp: "replace".}
proc replace*(self: var CppString, i1, i2: CppStrConstIterator, first, last: CppStrConstIterator): var CppString {.
    importcpp: "replace".}

proc swap*(self: var CppString, x: var CppString) {.importcpp: "swap".}

proc pop_back*(self: var CppString) {.importcpp: "pop_back".}

# CppString operations
# Avoid const char* vs char* issues
proc c_str*(self: CppString): cstring {.importcpp: "const_cast<char*>(#.c_str())".}
func data*(self: CppString): ptr cchar {.importcpp: "const_cast<char*>(#.data())".}

proc copy*(self: CppString, s: ptr cchar, l: csize_t, pos: csize_t = 0): csize_t {.importcpp: "copy".}

proc find*(self, str: CppString, pos: csize_t = 0): csize_t {.importcpp: "find".}
proc find*(self, str: CppString, pos, n: csize_t): csize_t {.importcpp: "find".}
proc find*(self: CppString, s: cstring, pos: csize_t = 0): csize_t {.importcpp: "find".}
proc find*(self: CppString, s: cstring, pos, n: csize_t): csize_t {.importcpp: "find".}
proc find*(self: CppString, c: cchar, pos: csize_t = 0): csize_t {.importcpp: "find".}

proc rfind*(self, str: CppString, pos: csize_t = std_npos): csize_t {.importcpp: "rfind".}
proc rfind*(self: CppString, s: CppString, pos, n: csize_t): csize_t {.importcpp: "rfind".}
proc rfind*(self: CppString, s: cstring, pos: csize_t = std_npos): csize_t {.importcpp: "rfind".}
proc rfind*(self: CppString, s: cstring, pos, n: csize_t): csize_t {.importcpp: "rfind".}
proc rfind*(self: CppString, c: cchar, pos: csize_t = std_npos): csize_t {.importcpp: "rfind".}

proc find_first_of*(self, str: CppString, pos: csize_t = 0): csize_t {.importcpp: "find_first_of".}
proc find_first_of*(self, str: CppString, pos, n: csize_t): csize_t {.importcpp: "find_first_of".}
proc find_first_of*(self: CppString, s: cstring, pos: csize_t = 0): csize_t {.importcpp: "find_first_of".}
proc find_first_of*(self: CppString, s: cstring, pos, n: csize_t): csize_t {.importcpp: "find_first_of".}
proc find_first_of*(self: CppString, c: cchar, pos: csize_t = 0): csize_t {.importcpp: "find_first_of".}

proc find_last_of*(self, str: CppString, pos: csize_t = std_npos): csize_t {.importcpp: "find_last_of".}
proc find_last_of*(self: CppString, s: CppString, pos, n: csize_t): csize_t {.importcpp: "find_last_of".}
proc find_last_of*(self: CppString, s: cstring, pos: csize_t = std_npos): csize_t {.importcpp: "find_last_of".}
proc find_last_of*(self: CppString, s: cstring, pos, n: csize_t): csize_t {.importcpp: "find_last_of".}
proc find_last_of*(self: CppString, c: cchar, pos: csize_t = std_npos): csize_t {.importcpp: "find_last_of".}

proc find_first_not_of*(self, str: CppString, pos: csize_t = 0): csize_t {.importcpp: "find_first_not_of".}
proc find_first_not_of*(self, str: CppString, pos, n: csize_t): csize_t {.importcpp: "find_first_not_of".}
proc find_first_not_of*(self: CppString, s: cstring, pos: csize_t = 0): csize_t {.importcpp: "find_first_not_of".}
proc find_first_not_of*(self: CppString, s: cstring, pos, n: csize_t): csize_t {.importcpp: "find_first_not_of".}
proc find_first_not_of*(self: CppString, c: cchar, pos: csize_t = 0): csize_t {.importcpp: "find_first_not_of".}

proc find_last_not_of*(self, str: CppString, pos: csize_t = std_npos): csize_t {.importcpp: "find_last_not_of".}
proc find_last_not_of*(self, str: CppString, pos, n: csize_t): csize_t {.importcpp: "find_last_not_of".}
proc find_last_not_of*(self: CppString, s: cstring, pos: csize_t = std_npos): csize_t {.importcpp: "find_last_not_of".}
proc find_last_not_of*(self: CppString, s: cstring, pos, n: csize_t): csize_t {.importcpp: "find_last_not_of".}
proc find_last_not_of*(self: CppString, c: cchar, pos: csize_t = std_npos): csize_t {.importcpp: "find_last_not_of".}

proc substr*(self: CppString, pos: csize_t = 0, l: csize_t = std_npos): CppString {.importcpp: "substr".}

proc compare*(self, str: CppString): cint {.importcpp: "compare".}
proc compare*(self: CppString, pos, l: csize_t, str: CppString): cint {.importcpp: "compare".}
proc compare*(self: CppString, pos, l: csize_t, str: CppString, subpos, subl: csize_t): cint {.importcpp: "compare".}
proc compare*(self: CppString, s: cstring): cint {.importcpp: "compare".}
proc compare*(self: CppString, pos, l: csize_t, str: cstring): cint {.importcpp: "compare".}
proc compare*(self: CppString, pos, l: csize_t, str: cstring, n: csize_t): cint {.importcpp: "compare".}
proc compare*(self: CppString, pos, l: csize_t, str: cstring, subpos, subl: csize_t): cint {.importcpp: "compare".}

# Non-member function overloads

proc `+`*(a: CppString, b: cchar): CppString {.importcpp: "# + char(#)".}
proc `+`*(a: cchar, b: CppString): CppString {.importcpp: "char(#) + #".}
proc `+`*(a: CppString, b: CppString): CppString {.importcpp: "# + #".}

proc `==`*(a: CppString, b: CppString): bool {.importcpp: "# == #".}
proc `!=`*(a: CppString, b: CppString): bool {.importcpp: "# != #".}
proc `<`*(a: CppString, b: CppString): bool {.importcpp: "# < #".}
proc `<=`*(a: CppString, b: CppString): bool {.importcpp: "# <= #".}
proc `>`*(a: CppString, b: CppString): bool {.importcpp: "# > #".}
proc `>=`*(a: CppString, b: CppString): bool {.importcpp: "# >= #".}

# Converter: CppStrIterator -> StrConstIterator
converter CppStrIteratorToStrConstIterator*(s: CppStrIterator): CppStrConstIterator {.importcpp: "#".}

{.pop.}


{.push inline.}
proc initCppString*(s: string): CppString =
  initCppString(s.cstring)

proc `+`*(a: CppString, b: string|cstring): CppString =
  result = (a + initCppString(b))
proc `+`*(a: string|cstring, b: CppString): CppString =
  let a = initCppString(a)
  result = (a + b)

proc `==`*(a: CppString, b: string|cstring): bool =
  let b = initCppString(b)
  result = (a == b)
proc `==`*(a: string|cstring, b: CppString): bool =
  let a = initCppString(a)
  result = (a == b)

proc `!=`*(a: CppString, b: string|cstring): bool =
  result = (a != initCppString(b))
proc `!=`*(a: string|cstring, b: CppString): bool =
  result = (initCppString(a) != b)

proc `<`*(a: CppString, b: string|cstring): bool =
  result = (a < initCppString(b))
proc `<`*(a: string|cstring, b: CppString): bool =
  result = (initCppString(a) < b)

proc `<=`*(a: CppString, b: string|cstring): bool =
  result = (a <= initCppString(b))
proc `<=`*(a: string|cstring, b: CppString): bool =
  result = (initCppString(a) <= b)

proc `>`*(a: CppString, b: string|cstring): bool =
  result = (a > initCppString(b))
proc `>`*(a: string|cstring, b: CppString): bool =
  result = (initCppString(a) > b)

proc `>=`*(a: CppString, b: string|cstring): bool =
  result = (a >= initCppString(b))
proc `>=`*(a: string|cstring, b: CppString): bool =
  result = (initCppString(a) >= b)

proc checkIndex(self: CppString, i: csize_t) =
  if i > self.size:
    raise newException(IndexDefect, &"index out of bounds: (i:{i}) <= (n:{self.size})")

proc `[]`*(self: CppString, idx: Natural): cchar =
  let i = csize_t(idx)
  # If you add a mechanism exception to operator `[]`  it simply becomes at so might as well use at directly
  when compileOption("boundChecks"): self.checkIndex(i)
  self.unsafeIndex(i)

proc `[]`*(self: var CppString, idx: Natural): var cchar =
  let i = csize_t(idx)
  # If you add a mechanism exception to operator `[]`  it simply becomes at so might as well use at directly
  when compileOption("boundChecks"): self.checkIndex(i)
  # TODO : find Nim bugs # associated
  # This strange syntax is to avoid a bug in the Nim c++ code generator
  (unsafeAddr self.unsafeIndex(i))[]

proc `[]=`*(self: var CppString, idx: Natural, val: cchar) =
  let i = csize_t(idx)
  when compileOption("boundChecks"): self.checkIndex(i)
  self.unsafeIndex(i) = val

{.pop.}

# Converter: CppString -> cstring
# converter CppCppStringToCCppString*(s: CppString): cstring = s.c_str()

# Converter: string, cstring -> CppString
# converter StringToCppCppString(s: string): CppString {.inline.} =
#   initCppString(cstring(s), len(s).csize_t)

# Converter: string -> CppString
# converter CppStringToCppCppString*(s: string): CppString = s.cstring
# Converter: CppString -> string
# converter CppCppStringToCppString*(s: CppString): string = $(s.cstring)

# Display CppString
proc `$`*(s: CppString): string {.noinit.} =
  result = $(s.c_str())

# Iterators arithmetics
iteratorsArithmetics(CppStrIterator)
iteratorsArithmetics(CppStrConstIterator)
