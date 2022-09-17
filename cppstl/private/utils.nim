# Copyright 2019 Nouredine Hussain

# This code is licensed under MIT license (see LICENSE.txt for details)

# Define arithmetic for iterators
template iteratorsArithmetics*(name: untyped):untyped {.deprecated: "use iteratorsOperators instead".} =
  iteratorsOperators(name)

# Define operators for iterators
# TODO take a valueType parameter and generate `[]`
template iteratorsOperators*(name: untyped): untyped =
  proc `+`*[T: name](it: T, offset: int) : T {.importcpp: "# + #"}
  proc `-`*[T: name](it: T, offset: int) : T {.importcpp: "# - #"}

  proc inc*(it: name) {.importcpp: "(void)(++#)".}
  proc inc*(it: name, offset: int) {.importcpp: "(void)(# += #)".}

  proc `==`*(it, otherIt: name): bool {.importcpp: "# == #".}
