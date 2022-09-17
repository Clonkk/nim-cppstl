# Copyright 2019 Nouredine Hussain

# This code is licensed under MIT license (see LICENSE.txt for details)

# Define arithmetic for iterators
template iteratorsArithmetics*(name: untyped):untyped =
  proc `+`*[T: name](it: T, offset: int) : T {.importcpp: "# + #"}
  proc `-`*[T: name](it: T, offset: int) : T {.importcpp: "# - #"}

# Define operators for iterators
template iteratorsOperators*(name: untyped, isConst: static bool): untyped =
  proc `+`*[T](it: name[T], offset: int): T {.importcpp: "# + #"}
  proc `-`*[T](it: name[T], offset: int): T {.importcpp: "# - #"}

  proc inc*[T](it: name[T]) {.importcpp: "(void)(++#)".}
  proc inc*[T](it: name[T], offset: int) {.importcpp: "(void)(# += #)".}

  proc `==`*[T](it, otherIt: name[T]): bool {.importcpp: "# == #".}

  when isConst:
    proc `[]`*[T](it: name[T]): T {.importcpp: "*#".}
  else:
    proc `[]`*[T](it: name[T]): var T {.importcpp: "*#".}
