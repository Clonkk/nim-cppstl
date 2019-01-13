# Copyright 2019 Nouredine Hussain

# This code is licensed under MIT license (see LICENSE.txt for details)

import strformat, ./private/utils, ./exception

export exception

type
  String* {.importcpp: "std::string", header: "string".} = object

  StrIterator* {.importcpp: "std::string::iterator",
                 header: "string".} = object

  StrConstIterator* {.importcpp: "std::string::const_iterator",
                      header: "string".} = object

const npos: csize = -1

#Constructor
proc initString*(): String
  {.importcpp: "std::string()", header: "string".}

proc initString*(str: String): String
  {.importcpp: "std::string(@)", header: "string".}

proc initString*(str: String, pos: csize): String
  {.importcpp: "std::string(@)", header: "string".}

proc initString*(str: String, pos, len: csize): String
  {.importcpp: "std::string(@)", header: "string".}

proc initString*(s: cstring): String
  {.importcpp: "std::string(@)", header: "string".}

proc initString*(s: cstring, n: csize): String
  {.importcpp: "std::string(@)", header: "string".}

proc initString*(first, last: StrConstIterator): String
  {.importcpp: "std::string(@)", header: "string".}

# Iterators
proc begin*(x: String): StrIterator
  {.importcpp: "begin", header: "string".}

proc `end`*(x: String): StrIterator
  {.importcpp: "end", header: "string".}

proc rbegin*(x: String): StrIterator
  {.importcpp: "rbegin", header: "string".}

proc rend*(x: String): StrIterator
  {.importcpp: "rend", header: "string".}

proc cbegin*(x: String): StrConstIterator
  {.importcpp: "cbegin", header: "string".}

proc cend*(x: String): StrConstIterator
  {.importcpp: "cend", header: "string".}

proc crbegin*(x: String): StrConstIterator
  {.importcpp: "crbegin", header: "string".}

proc crend*(x: String): StrConstIterator
  {.importcpp: "crend", header: "string".}

# Capacity
proc size*(this: String): csize
  {.importcpp: "size", header: "string".}

proc length*(s: String): csize
  {.importcpp: "length", header: "string".}

proc max_size*(this: String): csize
  {.importcpp: "max_size", header: "string".}

proc resize*(this: String, n: csize)
  {.importcpp: "resize", header: "string".}

proc capacity*(this: String): csize
  {.importcpp: "capacity", header: "string".}

proc reserve*(this: var String, n: csize)
  {.importcpp: "reserve", header: "string".}

proc clear*(this: var String)
  {.importcpp: "clear", header: "string".}

proc empty*(this: String): bool
  {.importcpp: "empty", header: "string".}

proc shrink_to_fit*(this: var String)
  {.importcpp: "shrink_to_fit", header: "string".}

# Internal utility functions
proc unsafeIndex(this: var String, i: csize): var cchar
  {.importcpp: "#[#]", header: "string".}

proc unsafeIndex(this: String, i: csize): cchar
  {.importcpp: "#[#]", header: "string".}

when compileOption("boundChecks"):
  proc checkIndex(this: String, i: csize) {.inline.} =
    if 0 > i or i > this.size:
      raise newException(IndexError,
            &"index out of bounds: 0 <= (i:{i}) <= (n:{this.size})")

# Element access
proc `[]`*(this: String, i: Natural): cchar {.inline.} =
  when compileOption("boundChecks"):
    this.checkIndex i
  result = this.unsafeIndex(i)

proc `[]`*(this: var String, i: Natural): var cchar {.inline, noinit.} =
  when compileOption("boundChecks"):
    this.checkIndex i
  # This strange syntax is to avoid a bug in the Nim c++ code generator
  result = (addr this.unsafeIndex(i))[]

proc `[]=`*(this: var String, i: Natural, val: cchar) {.inline, noinit.} =
  when compileOption("boundChecks"):
    this.checkIndex i
  this.unsafeIndex(i) = val

proc at*(this: var String, n: csize): var cchar
  {.importcpp: "at", header: "string".}

proc at*(this: String, n: csize): cchar
  {.importcpp: "at", header: "string".}

proc front*(this: String): cchar
  {.importcpp: "front", header: "string".}

proc front*(this: var String): var cchar
  {.importcpp: "front", header: "string".}

proc back*(this: String): cchar
  {.importcpp: "back", header: "string".}

proc back*(this: var String): var cchar
  {.importcpp: "back", header: "string".}

# Modifiers
proc `+=`*(this: var String, str: String): var String
  {.importcpp: "# += #", header: "string".}

proc `+=`*(this: var String, str: cstring): var String
  {.importcpp: "# += #", header: "string".}

proc `+=`*(this: var String, str: cchar): var String
  {.importcpp: "# += #", header: "string".}

proc append*(this: var String, str: String): var String
  {.importcpp: "append", header: "string".}

proc append*(this: var String, str: String, subpos, sublen: csize): var String
  {.importcpp: "append", header: "string".}

proc append*(this: var String, str: cstring): var String
  {.importcpp: "append", header: "string".}

proc append*(this: var String, str: cstring, n: csize): var String
  {.importcpp: "append", header: "string".}

proc append*(this: var String, n: csize, str: cchar): var String
  {.importcpp: "append", header: "string".}

proc append*(this: var String, first, last: StrConstIterator): var String
  {.importcpp: "append", header: "string".}

proc push_back*(this: var String, x: cchar): var String
  {.importcpp: "push_back", header: "string".}

proc assign*(this: var String, str: String): var String
  {.importcpp: "assign", header: "string".}

proc assign*(this: var String, str: String, subpos, sublen: csize): var String
  {.importcpp: "assign", header: "string".}

proc assign*(this: var String, str: cstring): var String
  {.importcpp: "assign", header: "string".}

proc assign*(this: var String, str: cstring, n: csize): var String
  {.importcpp: "assign", header: "string".}

proc assign*(this: var String, n: csize, c: cchar): var String
  {.importcpp: "assign", header: "string".}

proc assign*(this: var String, first, last: StrConstIterator): var String
  {.importcpp: "assign", header: "string".}

proc insert*(this: var String, pos: csize, str: String): var String
  {.importcpp: "insert", header: "string".}

proc insert*(this: var String, pos: csize, str: String, subpos,
             sublen: csize): var String
  {.importcpp: "insert", header: "string".}

proc insert*(this: var String, pos: csize, s: cstring): var String
  {.importcpp: "insert", header: "string".}

proc insert*(this: var String, pos: csize, s: cstring, n: csize): var String
  {.importcpp: "insert", header: "string".}

proc insert*(this: var String, p, n: csize, c: cchar): var String
  {.importcpp: "insert", header: "string".}

proc insert*(this: var String, p: StrConstIterator, n: csize,
             c: cchar): var String
  {.importcpp: "insert", header: "string".}

proc insert*(this: var String, p: StrConstIterator, c: cchar): var String
  {.importcpp: "insert", header: "string".}

proc insert*(this: var String, p: StrIterator, first,
             last: StrConstIterator): var String
  {.importcpp: "insert", header: "string".}

proc erase*(this: var String): StrIterator
  {.importcpp: "erase", header: "string".}

proc erase*(this: var String, pos: csize, l: csize = npos): var String
  {.importcpp: "erase", header: "string".}

proc erase*(this: var String, pos: StrIterator): StrIterator
  {.importcpp: "erase", header: "string".}

proc erase*(this: var String, first, last: StrIterator): StrIterator
  {.importcpp: "erase", header: "string".}

proc replace*(this: var String, pos, l: csize, str: String): var String
  {.importcpp: "replace", header: "string".}

proc replace*(this: var String, i1, i2: StrConstIterator,
              str: String): var String
  {.importcpp: "replace", header: "string".}

proc replace*(this: var String, pos, l: csize,
              str: String, subpos, subl: csize): var String
  {.importcpp: "replace", header: "string".}

proc replace*(this: var String, pos, l: csize, s: cstring): var String
  {.importcpp: "replace", header: "string".}

proc replace*(this: var String, i1, i2: StrConstIterator,
              s: cstring): var String
  {.importcpp: "replace", header: "string".}

proc replace*(this: var String, pos, l: csize, s: cstring,
              n: csize): var String
  {.importcpp: "replace", header: "string".}

proc replace*(this: var String, i1, i2: StrConstIterator,
              s: cstring, n: csize): var String
  {.importcpp: "replace", header: "string".}

proc replace*(this: var String, pos, l: csize, n: csize,
              c: cchar): var String
  {.importcpp: "replace", header: "string".}

proc replace*(this: var String, i1, i2: StrConstIterator,
              n: csize, c: cchar): var String
  {.importcpp: "replace", header: "string".}

proc replace*(this: var String, i1, i2: StrConstIterator,
              first, last: StrConstIterator): var String
  {.importcpp: "replace", header: "string".}

proc swap*(this: var String, x: var String)
  {.importcpp: "swap", header: "string".}

proc pop_back*(this: var String)
  {.importcpp: "pop_back", header: "string".}

# String operations
proc c_str*(this: String): cstring
  {.importcpp: "c_str", header: "string".}

proc data*(this: String): ptr cchar
  {.importcpp: "data", header: "string".}

proc copy*(this: String, s: ptr cchar, l: csize, pos: csize = 0): csize
  {.importcpp: "copy", header: "string".}

proc find*(this, str: String, pos: csize = 0): csize
  {.importcpp: "find", header: "string".}

proc find*(this: String, s: cstring, pos: csize = 0): csize
  {.importcpp: "find", header: "string".}

proc find*(this: String, s: cstring, pos, n: csize): csize
  {.importcpp: "find", header: "string".}

proc find*(this: String, c: cchar, pos: csize = 0): csize
  {.importcpp: "find", header: "string".}

proc rfind*(this, str: String, pos: csize = npos): csize
  {.importcpp: "rfind", header: "string".}

proc rfind*(this: String, s: cstring, pos: csize = npos): csize
  {.importcpp: "rfind", header: "string".}

proc rfind*(this: String, s: cstring, pos, n: csize): csize
  {.importcpp: "rfind", header: "string".}

proc rfind*(this: String, c: cchar, pos: csize = npos): csize
  {.importcpp: "rfind", header: "string".}

proc find_first_of*(this, str: String, pos: csize = 0): csize
  {.importcpp: "find_first_of", header: "string".}

proc find_first_of*(this: String, s: cstring, pos: csize = 0): csize
  {.importcpp: "find_first_of", header: "string".}

proc find_first_of*(this: String, s: cstring, pos, n: csize): csize
  {.importcpp: "find_first_of", header: "string".}

proc find_first_of*(this: String, c: cchar, pos: csize = 0): csize
  {.importcpp: "find_first_of", header: "string".}

proc find_last_of*(this, str: String, pos: csize = npos): csize
  {.importcpp: "find_last_of", header: "string".}

proc find_last_of*(this: String, s: cstring, pos: csize = npos): csize
  {.importcpp: "find_last_of", header: "string".}

proc find_last_of*(this: String, s: cstring, pos, n: csize): csize
  {.importcpp: "find_last_of", header: "string".}

proc find_last_of*(this: String, c: cchar, pos: csize = npos): csize
  {.importcpp: "find_last_of", header: "string".}

proc find_first_not_of*(this, str: String, pos: csize = 0): csize
  {.importcpp: "find_first_not_of", header: "string".}

proc find_first_not_of*(this: String, s: cstring, pos: csize = 0): csize
  {.importcpp: "find_first_not_of", header: "string".}

proc find_first_not_of*(this: String, s: cstring, pos, n: csize): csize
  {.importcpp: "find_first_not_of", header: "string".}

proc find_first_not_of*(this: String, c: cchar, pos: csize = 0): csize
  {.importcpp: "find_first_not_of", header: "string".}

proc find_last_not_of*(this, str: String, pos: csize = npos): csize
  {.importcpp: "find_last_not_of", header: "string".}

proc find_last_not_of*(this: String, s: cstring, pos: csize = npos): csize
  {.importcpp: "find_last_not_of", header: "string".}

proc find_last_not_of*(this: String, s: cstring, pos, n: csize): csize
  {.importcpp: "find_last_not_of", header: "string".}

proc find_last_not_of*(this: String, c: cchar, pos: csize = npos): csize
  {.importcpp: "find_last_not_of", header: "string".}

proc substr*(this: String, pos: csize = 0, l: csize = npos): String
  {.importcpp: "substr", header: "string".}

proc compare*(this, str: String): cint
  {.importcpp: "compare", header: "string".}

proc compare*(this: String, pos, l: csize, str: String): cint
  {.importcpp: "compare", header: "string".}

proc compare*(this: String, pos, l: csize,
              str: String, subpos, subl: csize): cint
  {.importcpp: "compare", header: "string".}

proc compare*(this: String, s: cstring): cint
  {.importcpp: "compare", header: "string".}

proc compare*(this: String, pos, l: csize, str: cstring): cint
  {.importcpp: "compare", header: "string".}

proc compare*(this: String, pos, l: csize, str: cstring, n: csize): cint
  {.importcpp: "compare", header: "string".}

# Non-member function overloads
proc `+`*(a: String, b: String): String
  {.importcpp: "# + #", header: "string".}

proc `+`*(a: String, b: cchar): String
  {.importcpp: "# + char(#)", header: "string".}

proc `+`*(a: cchar, b: String): String
  {.importcpp: "char(#) + #", header: "string".}

proc `==`*(a: String, b: String): bool
  {.importcpp: "# == #", header: "string".}

proc `!=`*(a: String, b: String): bool
  {.importcpp: "# != #", header: "string".}

proc `<`*(a: String, b: String): bool
  {.importcpp: "# < #", header: "string".}

proc `<=`*(a: String, b: String): bool
  {.importcpp: "# <= #", header: "string".}

proc `>`*(a: String, b: String): bool
  {.importcpp: "# > #", header: "string".}

proc `>=`*(a: String, b: String): bool
  {.importcpp: "# >= #", header: "string".}

# Converter: StrIterator -> StrConstIterator
converter StrIteratorToStrConstIterator*(s: StrIterator): StrConstIterator {.
  importcpp: "#".}

# Converter: String -> cstring
# converter CppStringToCString*(s: String): cstring = s.c_str()

# Converter: cstring -> String
converter CStringToCppString*(s: cstring): String {.inline.} = initString(s)

# Converter: string -> String
# converter StringToCppString*(s: string): String = s.cstring

# Converter: String -> string
# converter CppStringToString*(s: String): string = $(s.cstring)

# Display String
proc `$`*(s: String): string {.noinit.} =
  result = $(s.c_str())

# Iterators arithmetics
iteratorsArithmetics(StrIterator)
iteratorsArithmetics(StrConstIterator)
