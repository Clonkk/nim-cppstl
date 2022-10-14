# This code is licensed under MIT license (see LICENSE.txt for details)
import std/[unittest]
import cppstl/std_utility

suite "CppPair":
  test "constructors, first, second":
    var a:CppPair[string,int] = CppPair[string,int]()
    a.first = "hi"
    a.second = 1
    check a.first == "hi"
    check a.second == 1

    var b:CppPair[string,int] = initCppPair[string,int]("bye",2)
    check b.first == "bye"
    check b.second == 2

    # Constructor (sugar)
    var c:CppPair[string,int]
    c("nest",30)
    check c.first == "nest"
    check c.second == 30

  test "makePair and swap to CppPair's":
    var pair:CppPair[string,int] = makePair("hi", 1)
    check pair.first == "hi"
    check pair.second == 1

    var bye:CppPair[string,int] = makePair("bye", 2)
    pair.swap(bye)
    check pair.first == "bye"
    check pair.second == 2
    check bye.first == "hi"
    check bye.second == 1

  test "operator=":
    var pair1:CppPair[string,int] = makePair("hi", 1)
    var pair2 = pair1
    check pair2.first == "hi"
    check pair2.second == 1


  test "pretty print":
    var pair:CppPair[string,int] = makePair("hi", 1)
    check $pair == "CppPair( first: hi, second: 1 )"

  test "toTuple":
    var pair:CppPair[string,int] = makePair("hi", 1)
    var tmp:tuple[first:string, second:int] = ("hi",1)
    check pair.toTuple == tmp