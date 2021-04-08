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

  test "Operators":
    block:
      var
        a = initCppComplex[float64](141.571, 124.412)
        b = initCppComplex[float64](22.17843, 0.523)
        refa = toComplex(a)
        refb = toComplex(b)
        refres = refa+refb
        res = a+b
      check res == toCppComplex(refres)
    block:
      var
        a = initCppComplex[float64](141.571, 124.412)
        b = initCppComplex[float64](22.17843, 0.523)
        refa = toComplex(a)
        refb = toComplex(b)
        refres = refa-refb
        res = a-b
      check res == toCppComplex(refres)
    block:
      var
        a = initCppComplex[float64](141.571, 124.412)
        b = initCppComplex[float64](22.17843, 0.523)
        refa = toComplex(a)
        refb = toComplex(b)
        refres = refa*refb
        res = a*b
      check res == toCppComplex(refres)
    block:
      var
        a = initCppComplex[float64](141.571, 124.412)
        b = initCppComplex[float64](22.17843, 0.523)
        refa = toComplex(a)
        refb = toComplex(b)
        refres = refa/refb
        res = a/b
      check res == toCppComplex(refres)

  test "abs":
    var
      a = initCppComplex[float64](141.571, 124.412)
      refa = toComplex(a)

    check abs(a) == abs(refa)

  test "norm":
    var
      a = initCppComplex[float64](141.571, 124.412)
      refa = toComplex(a)

    check norm(a) == abs2(refa)

  test "conj":
    var
      a = initCppComplex[float64](141.571, 124.412)
      refa = toComplex(a)

    check conj(a) == conjugate(refa).toCppComplex()

  test "polar":
    var
      a = initCppComplex[float64](141.571, 124.412)
      refa = toComplex(a)
      # Use Nim to calculate polar coordinate of refa
      polcoord = polar(refa)
      b = polar(polcoord.r, polcoord.phi)

    check (a - b).real < 1e-12
    check (a - b).imag < 1e-12

  test "display":
    var a = initCppComplex[float64](141.571, 124.412)
    check `$`(a) == "(141.571, 124.412)"
