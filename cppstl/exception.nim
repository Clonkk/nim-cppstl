# Copyright 2019 Nouredine Hussain

# This code is licensed under MIT license (see LICENSE.txt for details)

type
    OutOfRangeException* {.importcpp: "std::out_of_range", header: "stdexcept".} = object of ValueError
