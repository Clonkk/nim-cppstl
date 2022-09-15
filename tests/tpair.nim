# This code is licensed under MIT license (see LICENSE.txt for details)
import unittest
import cppstl/std_pair

suite "CppPair":
  test "constructors and field access":
    block:
      var p = initCppPair[cfloat, cint]()
      check p.first == 0.cfloat
      check p.second == 0.cint

    block:
      var p1 = initCppPair(100.cfloat, 42.cint)
      check p1.first == 100.cfloat
      check p1.second == 42.cint

      var p2 = initCppPair(p1)
      check p2.first == 100.cfloat
      check p2.second == 42.cint

  test "member functions":
    var
      p1 = initCppPair(100.cfloat, 42.cint)
      p2 = initCppPair(200.cfloat, 100.cint)
    p1.swap(p2)
    check p1.first == 200.cfloat
    check p1.second == 100.cint
    check p2.first == 100.cfloat
    check p2.second == 42.cint

  test "comparison operators":
    block:
      var
        p1 = initCppPair(100.cfloat, 42.cint)
        p2 = initCppPair(100.cfloat, 50.cint)
      check not (p1 == p2)
      check not (p2 == p1)
      check p1 != p2
      check p2 != p1
      check p1 < p2
      check not (p2 < p1)
      check p1 <= p2
      check not (p2 <= p1)
      check not (p1 > p2)
      check p2 > p1
      check not (p1 >= p2)
      check p2 >= p1

  test "other non-member functions":
    block:
      var p = initCppPair(100.cfloat, 42.cint)
      check get(cfloat, p) == 100.cfloat
      check get(cint, p) == 42.cint

    block:
      var p = initCppPair(100.cfloat, 42.cint)
      check get(0, p) == 100.cfloat
      check get(1, p) == 42.cint
      check not compiles(get(2, p))
