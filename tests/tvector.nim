# This code is licensed under MIT license (see LICENSE.txt for details)
import std/[unittest, strformat, sequtils]
import cppstl/std_vector

suite "CppVector":
  test "constructor, size/len, empty":
    var
      v1 = initCppVector[int]()
      v2 = initCppVector[int](10)

    check v1.size() == 0.csize_t
    check v2.len() == 10.csize_t
    check v1.empty() == true
    check v2.empty() == false

  test "constructors and iterators":
    var v = initCppVector[int](3)

    check v.size == 3
    check v[0] == 0
    check v[1] == 0
    check v[2] == 0

    v = initCppVector[int](3, 1)

    check v.size == 3
    check v[0] == 1
    check v[1] == 1
    check v[2] == 1

    v = initCppVector[int]()
    v.pushBack(1)
    v.pushBack(2)
    v.pushBack(3)

    check v.size == 3
    check v[0] == 1
    check v[1] == 2
    check v[2] == 3

    var v2 = initCppVector(v)

    check v.size == v2.size
    check v[0] == v2[0]
    check v[1] == v2[1]
    check v[2] == v2[2]

    v2 = initCppVector(begin(v), `end`(v))

    check v.size == v2.size
    check v[0] == v2[0]
    check v[1] == v2[1]
    check v[2] == v2[2]
    check v == v2

    v2 = initCppVector(rBegin(v), rEnd(v))

    check v.size == v2.size
    check v[0] == v2[2]
    check v[1] == v2[1]
    check v[2] == v2[0]
    check v != v2

    v2 = initCppVector(cBegin(v), cEnd(v))

    check v.size == v2.size
    check v[0] == v2[0]
    check v[1] == v2[1]
    check v[2] == v2[2]
    check v == v2

    v2 = initCppVector(crBegin(v), crEnd(v))

    check v.size == v2.size
    check v[0] == v2[2]
    check v[1] == v2[1]
    check v[2] == v2[0]
    check v != v2

  test "capacity":
    var v = initCppVector[int](3)

    check v.size == 3
    check v.capacity >= v.size
    check v.maxSize >= v.size
    check not v.empty

    let oldCap = v.capacity
    let oldSz = v.size
    v.reserve(2*oldCap)

    check oldCap < v.capacity
    check oldSz == v.size

    v.resize(oldSz+1)

    check oldSz+1 == v.size

    v.shrinkToFit()

    check v.size == v.capacity

  test "element access":
    var v = initCppVector[int](3)

    check v[0] == 0
    check v.at(0) == 0

    v[0] = 100

    check v[0] == 100
    check v.at(0) == 100

    v.at(0) = 1000

    check v[0] == 1000
    check v.at(0) == 1000

    when compileOption("boundChecks"):
      expect(IndexDefect):
        discard v[4]
      expect(OutOfRangeException):
        discard v.at(4)

    v = initCppVector[int](5)
    for i in 0..<v.size:
      v[i] = i.int

    check v.front == 0
    check v.back == 4

    v = initCppVector[int](2)
    v.front() = 10
    v.back() = 11

    check v[0] == 10
    check v[1] == 11

    var pdata = v.data

    check pdata[] == 10
    check cast[ptr int](cast[int](pdata)+1*sizeof(int))[] == 11

  test "push/add, pop, front/first, back/last":
    var
      v = initCppVector[int]()
      refSeq = @[100, 300, 400, 500] # This test will create the following Vector

    v.pushBack(100)
    check v.len() == 1.csize_t

    v.add(200)
    check v.len() == 2.csize_t

    v.popBack()
    check v.len() == 1.csize_t

    v.add(300)
    v.add(400)
    v.add(500)

    for idx in 0.csize_t ..< v.len():
      check v[idx] == refSeq[idx]

    check v.len() == 4.csize_t

    check v.first() == 100
    v.first() = 1
    check v.front() == 1

    check v.last() == 500
    v.last() = 5
    check v.back() == 5

  test "modifiers":
    var v = initCppVector[int]()
    for i in 0..<3:
      v.pushBack i

    for i in 0..<3:
      check v[i] == i

    v.popBack()

    check v.size == 2
    for i in 0..<v.size:
      check v[i] == i.int

    discard v.insert(v.`end`, 2)

    check v.size == 3
    for i in 0..<3:
      check v[i] == i.int

    v.popBack()

    discard v.insert(v.cEnd, 2)

    check v.size == 3
    for i in 0..<3:
      check v[i] == i

    discard v.insert(v.begin, 100)

    check v.size == 4
    check v[0] == 100

    discard v.insert(v.begin() + 1, 13)

    check v.size == 5
    check v[1] == 13

    discard v.insert(v.begin(), 3, 1)

    check v.size == 8
    for i in 0..<3:
      check v[i] == 1

    discard v.insert(v.`end`(), v.begin(), v.`end`())

    check v.size == 16
    for i in 0..<8:
      check v[i] == v[i+8]

    discard v.erase(v.begin()+8, v.`end`())

    check v.size == 8

    discard v.erase(v.begin()+2, v.`end`())

    check v.size == 2

    v[0] = 1
    v[1] = 2
    discard v.erase(v.begin()+1)

    check v.size == 1
    check v[0] == 1

    v.pushBack 2
    discard v.erase(v.begin())

    check v.size == 1
    check v[0] == 2

    v = initCppVector[int](3, 1)
    var v1 = initCppVector[int](3, 2)

    for i in 0..<3:
      check v[i] == 1
      check v1[i] == 2

    v.swap v1

    for i in 0..<3:
      check v1[i] == 1
      check v[i] == 2

    v.clear

    check v.size == 0
    check v.empty

  test "relational operators":
    let foo = initCppVector[int](3, 100)
    let bar = initCppVector[int](2, 200)

    check foo == foo
    check foo <= foo
    check foo >= foo
    check foo != bar
    check not (foo > bar)
    check foo < bar
    check not (foo >= bar)
    check foo <= bar

    let
      v1 = @[1, 2, 3].toCppVector()

    block: # ==, <=, >=
      let
        v2 = v1
      check v1 == v2
      check v1 <= v2
      check v1 >= v2

    block: # >, >=
      let
        v2 = @[1, 2, 4].toCppVector()
      check v2 > v1
      check v2 >= v1

    block: # >, unequal CppVector lengths
      let
        v2 = @[1, 2, 4].toCppVector()
        v3 = @[1, 2, 3, 0].toCppVector()
      check v3 > v1
      check v2 > v3

    block: # <, <=
      let
        v2 = @[1, 2, 4].toCppVector()
      check v1 < v2
      check v1 <= v2

    block: # <, unequal CppVector lengths
      let
        v2 = @[1, 2, 4].toCppVector()
        v3 = @[1, 2, 3, 0].toCppVector()
      check v1 < v3
      check v3 < v2

  test "display, $":
    block:
      var v = initCppVector[int]()
      check $v == "[]"
      v.pushBack(1)
      v.pushBack(2)
      v.pushBack(3)
      check $v == "[1, 2, 3]"
      check (v.size() == 3)

    block:
      var v = initCppVector[string]()
      v.add "hi"
      v.add "there"
      v.add "bye"
      check $v == "[hi, there, bye]"

    block:
      var v = initCppVector[float](5, 0.0'f64)
      check $v == "[0.0, 0.0, 0.0, 0.0, 0.0]"
      check v.size() == 5

  test "iterators":
    var
      refSeq = @["hi", "there", "bye"]
      v = toCppVector(refSeq)

    var i = 0
    for elem in v:
      check elem == refSeq[i]
      inc(i)

    for idx, elem in v:
      check elem == refSeq[idx]

  test "converting to/from a CppVector/mutable sequence":
    var
      s = @[1.1, 2.2, 3.3, 4.4, 5.5]
      v: CppVector[float]

    v = s.toCppVector()
    check v.toSeq() == s

  test "converting from an immutable sequence":
    let
      s = @[1.1, 2.2, 3.3, 4.4, 5.5]
    var
      v: CppVector[float]

    v = s.toCppVector()
    check v.toSeq() == s

  test "converting array -> CppVector -> sequence":
    let
      a = [1.1, 2.2, 3.3, 4.4, 5.5]
      v = a.toCppVector()
      s = a.toSeq()

    check v.toSeq() == s

  test "assign":
    var
      v: CppVector[char]

    check v.len() == 0

    v.assign(4, '.')
    check v.toSeq() == @['.', '.', '.', '.']

    v.assign(2, 'a')
    check v.toSeq() == @['a', 'a']

  test "set an element value `[]=`":
    var
      v = initCppVector[int](5)

    v[1] = 100
    v[3] = 300
    check v.toSeq() == @[0, 100, 0, 300, 0]

  test "(c)begin, (c)end, insert":
    var
      v = @[1, 2, 3].toCppVector()

    # insert elem at the beginning
    discard v.insert(v.cBegin(), 9)
    check v == @[9, 1, 2, 3].toCppVector()

    # Below, using .begin() instead of .cBegin() also
    # works.. because of the CppVectorIteratorToCppVectorConstIterator converter.
    discard v.insert(v.begin(), 10)
    check v == @[10, 9, 1, 2, 3].toCppVector()

    # insert elem at the end
    v = @[1, 2, 3].toCppVector()
    discard v.insert(v.cEnd(), 9)
    check v == @[1, 2, 3, 9].toCppVector()

    # Below, using .`end`() instead of .cEnd() also
    # works.. because of the CppVectorIteratorToCppVectorConstIterator converter.
    discard v.insert(v.`end`(), 10)
    check v == @[1, 2, 3, 9, 10].toCppVector()

    # insert copies of a val
    v = @[1, 2, 3].toCppVector()
    discard v.insert(v.cEnd(), 3, 111)
    check v == @[1, 2, 3, 111, 111, 111].toCppVector()

    # insert elements from a CppVector range
    v = @[1, 2, 3].toCppVector()
    # Below copies the whole CppVector and appends to itself at the end.
    discard v.insert(v.cEnd(), v.cBegin(), v.cEnd())
    check v == @[1, 2, 3, 1, 2, 3].toCppVector()

    # Below is a long-winded way to copy one CppVector to another.
    var
      v2: CppVector[int]
    discard v2.insert(v2.cEnd(), v.cBegin(), v.cEnd())
    check v2 == v

  test "iterator arithmetic":
    var
      v = @[1, 2, 3].toCppVector()

    # Insert elem after the first element.
    discard v.insert(v.cBegin()+1, 9)
    check v == @[1, 9, 2, 3].toCppVector()

    # Insert elem before the last element.
    discard v.insert(v.cEnd()-1, 9)
    check v == @[1, 9, 2, 9, 3].toCppVector()

  test "swap two vectors":
    var
      v1 = @['a', 'b', 'c'].toCppVector()
      v2 = @['w', 'x', 'y', 'z'].toCppVector()

    v1.swap(v2)
    check v1 == @['w', 'x', 'y', 'z'].toCppVector()
    check v2 == @['a', 'b', 'c'].toCppVector()
