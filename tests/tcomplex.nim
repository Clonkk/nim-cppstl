# This code is licensed under MIT license (see LICENSE.txt for details)
import unittest
import complex
import cppstl/std_complex

suite "CppComplex":
  test "constructors":
    var a = initCppComplex[float32](41.0, 31.0)
    var refa = Complex32(re: 41.0, im: 31.0)
    check refa.re == a.real
    check refa.im == a.imag

  test "+":
    var a = initCppComplex[float64](0.77, 3.6)
    var b = initCppComplex[float64](1.23, 0.4)
    var res = a+b
    check res == initCppComplex(2.0, 4.0)
    check res.real == 2.0
    check res.imag == 4.0
  test "-":
    var a = initCppComplex[float64](1.77, 3.6)
    var b = initCppComplex[float64](0.50, 0.4)
    var res = a-b
    check res == initCppComplex(1.27, 3.2)
    check res.real == 1.27
    check res.imag == 3.2

  test "*":
    var
      a = initCppComplex[float64](141.571, 124.412)
      b = initCppComplex[float64](22.17843, 0.523)
      refa = toComplex(a)
      refb = toComplex(b)
      refres = refa*refb
      res = a*b
    check res == toCppComplex(refres)

