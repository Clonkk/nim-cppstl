# Nim bindings for the C++ STL

![workflow](https://github.com/Clonkk/nim-cppstl/actions/workflows/ci.yml/badge.svg)
![workflow](https://github.com/Clonkk/nim-cppstl/actions/workflows/docs.yml/badge.svg)

## Introduction

This library is a Nim wrapper for C++ Standard Template Library (STL) class.
**This library is obviously only compatible with the C++ backend**

I recommand using this bindings only in two cases:
* When wrapping a C++ library (But make sure to offer a Nim idomatic API that does not expose the STL to the user if possible).
* In some performance critical code where the cost of converting Nim types to c++ types is problematic (like embeded devices).


## Installation

```
nimble install cppstl
```

Add the following lines to your `.nimble`:
```
backend = "cpp"
requires "cppstl"
```

## Limitations

``cppstl`` currently wraps :

* ``std::string``
* ``std::std_vector``
* ``std::complex``

* Smart pointers are partially supported:
  * ``std::unique_ptr``
  * ``std::shared_ptr``

## Contributions

All contributions are welcome!

If there is a missing function or class, that you need, don't be shy to open an issue or a PR.

### Running Tests

```
nimble test
```

or

```
testament p "tests/t*.nim"
```

## Usage

The documentation is here : https://clonkk.github.io/nim-cppstl/cppstl.html

You can find more use-case in the `tests` folder.

## License

This code is licensed under MIT license (see [LICENSE.txt](./LICENSE.txt) for details)
