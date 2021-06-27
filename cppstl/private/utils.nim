# Copyright 2019 Nouredine Hussain

# This code is licensed under MIT license (see LICENSE.txt for details)

# Define arithmetic for iterators
template iteratorsArithmetics*(name: untyped):untyped =
  proc `+`*[T: name](it: T, offset: int) : T {.importcpp: "# + #"}
  proc `-`*[T: name](it: T, offset: int) : T {.importcpp: "# - #"}
