# This code is licensed under MIT license (see LICENSE.txt for details)
import std/unittest
import cppstl/std_string
import cppstl/std_pair

proc main() =
  suite "CppPair":
    test "constructors and field access":
      block:
        var p = initCppPair[CppString, cint]()
        check p.first == initCppString()
        check p.second == 0.cint

      block:
        var p1 = initCppPair(("hello"), 42.cint)
        check p1.first == ("hello")
        check p1.second == 42.cint

        var p2 = initCppPair(p1)
        check p2.first == ("hello")
        check p2.second == 42.cint

    test "member functions":
      block:
        var
          p1 = initCppPair("hello", 42.cint)
          p2 = initCppPair("world", 100.cint)

        p1.swap(p2)
        check p1.first == ("world")
        check p1.second == 100.cint
        check p2.first == ("hello")
        check p2.second == 42.cint

    test "comparison operators":
      block:
        let
          s1 = toCppString("hello")
          s2 = toCppString("0hello")
          s3 = toCppString("zhello")

        var
          p1 = initCppPair(s1, 42.cint)
          p2 = initCppPair(toCppString("hello"), 50.cint)
          p3 = initCppPair(s2, 50.cint)
          p4 = initCppPair(s3, 50.cint)

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
        check p3 < p1
        check not (p3 >= p1)
        check p4 > p1
        check not (p4 <= p1)

      block:
        var
          p1 = initCppPair("hello", 42.cint)
          p2 = initCppPair("hello", 50.cint)
          p3 = initCppPair("0hello", 50.cint)
          p4 = initCppPair("zhello", 50.cint)

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
        check p3 < p1
        check not (p3 >= p1)
        check p4 > p1
        check not (p4 <= p1)

    test "other non-member functions":
      block:
        var p = initCppPair(initCppString("hello"), 42.cint)
        check get(CppString, p) == initCppString("hello")
        check get(cint, p) == 42.cint
        check not compiles(get(cfloat, p))

      block:
        var p = initCppPair(100.cint, 42.cint)
        check not compiles(get(cint, p))

      block:
        var p = initCppPair(initCppString("hello"), 42.cint)
        check get(0, p) == initCppString("hello")
        check get(1, p) == 42.cint
        check not compiles(get(2, p))

    test "$":
      var p = initCppPair(initCppString("hello"), 42.cint)
      check $p == "CppPair(first: hello, second: 42)"

    test "toTuple and back":
      let
        f = "Hello world"
        s = 144
      var pair: CppPair[string, int] = makePair(f, s)
      var tup = pair.toTuple()
      check tup == (first: f, second: s)
      check makePair(tup) == pair


when isMainModule:
  main()

