# Copyright 2019 Nouredine Hussain

# This code is licensed under MIT license (see LICENSE.txt for details)

when (NimMajor, NimMinor, NimPatch) < (1, 4, 0):
  # IndexDefect was introduced in 1.4.0
  type IndexDefect* = IndexError

type
  OutOfRangeException* {.importcpp: "std::out_of_range", header: "stdexcept".} = object of ValueError
