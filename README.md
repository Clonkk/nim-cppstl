# Nim bindings for the C++ STL

This library is an attempt at wrapping some of the C++ Standard Template Library (STL). This library is *NOT* intended to replace the Nim standard library nor to be used in normal Nim code.

**This library is obviously only compatible with the C++ backend**

I recommand using this bindings only in two cases:

* When wrapping a C++ library (But make sure to offer a Nim idomatic API that does not expose the STL to the user if possible).

* In some performance critical code where the cost of converting Nim types to c++ types is problematic (like embeded devices).

## What parts of the STL have been wrapped ?

For now only the following parts have been wrapped:

* string
* vector

I intend to add other parts of the STL as I need them. 

Pull requests are welcome of course.

## Installation

TO DO

## Usage

The tests are the best examples as I tray to cover every wrapped c++ code.

## License

Copyright 2019 Nouredine Hussain

This code is licensed under MIT license (see LICENSE.txt for details)