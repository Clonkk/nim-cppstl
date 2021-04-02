# Nim bindings for the C++ STL

This library is a Nim wrapper for ``std::vector`` and ``std::string`` C++ Standard Template Library (STL). 
**This library is obviously only compatible with the C++ backend**

I recommand using this bindings only in two cases:
* When wrapping a C++ library (But make sure to offer a Nim idomatic API that does not expose the STL to the user if possible).
* In some performance critical code where the cost of converting Nim types to c++ types is problematic (like embeded devices).

If you need another STL type wrapped, don't be shy and open an issue or, even better, a PR !

## Installation

``nimble install cppstl``

Add the following lines to your `.nimble`:
```
backend = "cpp"
requires "cppstl"
```

## Usage

The tests are the best examples as I tray to cover every wrapped c++ code.

## License

Copyright 2019 Nouredine Hussain
Copyright 2021 Ca 

This code is licensed under MIT license (see LICENSE.txt for details)
