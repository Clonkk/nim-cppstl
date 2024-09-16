# This code is licensed under MIT license (see LICENSE.txt for details)

## This module contains types and procs specific to ``std::string`` (i.e.
## ``std::basic_string<char>``), including constructors and overloads that
## take Nim ``string``/``cstring``.

import ./std_basicstring
export std_basicstring

type
  CppString* = CppBasicString[cchar]
  CppStrIterator* = CppBasicStringIterator[cchar]
  CppStrConstIterator* = CppBasicStringConstIterator[cchar]

{.push header: "<string>".}

#Constructor
proc initCppString*(): CppString {.constructor, importcpp: "std::string()".}
proc initCppString*(str: CppString): CppString {.constructor, importcpp: "std::string(@)".}
proc initCppString*(str: CppString, pos: csize_t): CppString {.constructor, importcpp: "std::string(@)".}
proc initCppString*(str: CppString, pos, len: csize_t): CppString {.constructor, importcpp: "std::string(@)".}
proc initCppString*(s: cstring): CppString {.constructor, importcpp: "std::string(@)".}
proc initCppString*(s: cstring, n: csize_t): CppString {.constructor, importcpp: "std::string(@)".}
proc initCppString*(first, last: CppStrConstIterator): CppString {.constructor, importcpp: "std::string(@)".}

# Modifiers
proc `+=`*(self: var CppString, str: cstring) {.importcpp: "(# += #)".}

proc append*(self: var CppString, str: cstring) {.importcpp: "append".}
proc append*(self: var CppString, str: cstring, n: csize_t) {.importcpp: "append".}

proc assign*(self: var CppString, str: cstring) {.importcpp: "assign".}
proc assign*(self: var CppString, str: cstring, n: csize_t) {.importcpp: "assign".}

proc insert*(self: var CppString, pos: csize_t, s: cstring) {.importcpp: "insert".}
proc insert*(self: var CppString, pos: csize_t, s: cstring, n: csize_t) {.importcpp: "insert".}

proc replace*(self: var CppString, pos, l: csize_t, s: cstring) {.importcpp: "replace".}
proc replace*(self: var CppString, i1, i2: CppStrConstIterator, s: cstring) {.importcpp: "replace".}
proc replace*(self: var CppString, pos, l: csize_t, s: cstring, n: csize_t) {.importcpp: "replace".}
proc replace*(self: var CppString, i1, i2: CppStrConstIterator, s: cstring, n: csize_t) {.importcpp: "replace".}

# CppString operations
# Avoid const char* vs char* issues
proc cStr*(self: CppString): cstring {.importcpp: "const_cast<char*>(#.c_str())".}

proc find*(self: CppString, s: cstring, pos: csize_t = 0): csize_t {.importcpp: "find".}
proc find*(self: CppString, s: cstring, pos, n: csize_t): csize_t {.importcpp: "find".}

proc rfind*(self: CppString, s: cstring, pos: csize_t = std_npos): csize_t {.importcpp: "rfind".}
proc rfind*(self: CppString, s: cstring, pos, n: csize_t): csize_t {.importcpp: "rfind".}

proc findFirstOf*(self: CppString, s: cstring, pos: csize_t = 0): csize_t {.importcpp: "find_first_of".}
proc findFirstOf*(self: CppString, s: cstring, pos, n: csize_t): csize_t {.importcpp: "find_first_of".}

proc findLastOf*(self: CppString, s: cstring, pos: csize_t = std_npos): csize_t {.importcpp: "find_last_of".}
proc findLastOf*(self: CppString, s: cstring, pos, n: csize_t): csize_t {.importcpp: "find_last_of".}

proc findFirstNotOf*(self: CppString, s: cstring, pos: csize_t = 0): csize_t {.importcpp: "find_first_not_of".}
proc findFirstNotOf*(self: CppString, s: cstring, pos, n: csize_t): csize_t {.importcpp: "find_first_not_of".}

proc findLastNotOf*(self: CppString, s: cstring, pos: csize_t = std_npos): csize_t {.importcpp: "find_last_not_of".}
proc findLastNotOf*(self: CppString, s: cstring, pos, n: csize_t): csize_t {.importcpp: "find_last_not_of".}

proc compare*(self: CppString, s: cstring): cint {.importcpp: "compare".}
proc compare*(self: CppString, pos, l: csize_t, str: cstring): cint {.importcpp: "compare".}
proc compare*(self: CppString, pos, l: csize_t, str: cstring, n: csize_t): cint {.importcpp: "compare".}
proc compare*(self: CppString, pos, l: csize_t, str: cstring, subpos, subl: csize_t): cint {.importcpp: "compare".}

# Converter: CppStrIterator -> StrConstIterator
converter CppStrIteratorToStrConstIterator*(s: CppStrIterator): CppStrConstIterator {.importcpp: "#".}

# Relational operators
proc `==`*(a: CppString, b: CppString): bool {.importcpp: "(# == #)".}
proc `!=`*(a: CppString, b: CppString): bool {.importcpp: "(# != #)".}
proc `<`*(a: CppString, b: CppString): bool  {.importcpp: "(# < #)".}
proc `<=`*(a: CppString, b: CppString): bool {.importcpp: "(# <= #)".}
proc `>`*(a: CppString, b: CppString): bool  {.importcpp: "(# > #)".}
proc `>=`*(a: CppString, b: CppString): bool {.importcpp: "(# >= #)".}

{.pop.}

{.push inline.}

proc initCppString*(s: string): CppString =
  initCppString(s.cstring)

proc `+`*(a: CppString, b: string | cstring): CppString =
  result = (a + initCppString(b))

proc `+`*(a: string | cstring, b: CppString): CppString =
  let a = initCppString(a)
  result = (a + b)

proc `==`*(a: CppString, b: string | cstring): bool =
  let b = initCppString(b)
  result = (a == b)

proc `==`*(a: string | cstring, b: CppString): bool =
  let a = initCppString(a)
  result = (a == b)

proc `!=`*(a: CppString, b: string | cstring): bool =
  result = (a != initCppString(b))

proc `!=`*(a: string | cstring, b: CppString): bool =
  result = (initCppString(a) != b)

proc `<`*(a: CppString, b: string | cstring): bool =
  result = (a < initCppString(b))

proc `<`*(a: string | cstring, b: CppString): bool =
  result = (initCppString(a) < b)

proc `<=`*(a: CppString, b: string | cstring): bool =
  result = (a <= initCppString(b))

proc `<=`*(a: string | cstring, b: CppString): bool =
  result = (initCppString(a) <= b)

proc `>`*(a: CppString, b: string | cstring): bool =
  result = (a > initCppString(b))

proc `>`*(a: string | cstring, b: CppString): bool =
  result = (initCppString(a) > b)

proc `>=`*(a: CppString, b: string | cstring): bool =
  result = (a >= initCppString(b))

proc `>=`*(a: string | cstring, b: CppString): bool =
  result = (initCppString(a) >= b)

{.pop.}

# Alias for Nim idiomatic API

proc toCppString*(s: string): CppString {.inline.} =
  initCppString(cstring(s), len(s).csize_t)

proc toString*(s: CppString): string =
  $(s.cStr())

# Display CppString
proc `$`*(s: CppString): string {.noinit.} =
  result = $(s.cStr())
