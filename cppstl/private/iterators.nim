# This code is licensed under MIT license (see LICENSE.txt for details)

type
  CppIterator*[ValueType] {.importc.} = object
  CppConstIterator*[ValueType] {.importc.} = object

type SomeCppIterator = CppIterator or CppConstIterator

proc `+`*[I: SomeCppIterator](it: I, offset: int): I {.importcpp: "# + #".}
proc `-`*[I: SomeCppIterator](it: I, offset: int): I {.importcpp: "# - #".}

proc inc*(it: SomeCppIterator) {.importcpp: "(void)(++#)".}
proc inc*(it: SomeCppIterator, offset: int) {.importcpp: "(void)(# += #)".}

proc `==`*[ValueType](it, otherIt: CppIterator[ValueType]): bool {.importcpp: "# == #".}
proc `==`*[ValueType](it, otherIt: CppConstIterator[ValueType]): bool {.importcpp: "# == #".}

proc `[]`*[ValueType](it: CppIterator[ValueType]): var ValueType {.importcpp: "*#".}
proc `[]`*[ValueType](it: CppConstIterator[ValueType]): ValueType {.importcpp: "*#".}
