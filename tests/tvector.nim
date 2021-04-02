# Copyright 2019 Nouredine Hussain

# This code is licensed under MIT license (see LICENSE.txt for details)
import unittest, cppstl/vector

test "test vector constructors and iterators":
  var v = initStdVector[int](3)

  check v.size == 3
  check v[0] == 0
  check v[1] == 0
  check v[2] == 0

  v = initStdVector[int](3, 1)

  check v.size == 3
  check v[0] == 1
  check v[1] == 1
  check v[2] == 1

  v = initStdVector[int]()
  v.push_back(1)
  v.push_back(2)
  v.push_back(3)

  check v.size == 3
  check v[0] == 1
  check v[1] == 2
  check v[2] == 3

  var v2 = initStdVector(v)

  check v.size == v2.size
  check v[0] == v2[0]
  check v[1] == v2[1]
  check v[2] == v2[2]

  v2 = initStdVector(begin(v), `end`(v))

  check v.size == v2.size
  check v[0] == v2[0]
  check v[1] == v2[1]
  check v[2] == v2[2]
  check v == v2

  v2 = initStdVector(rbegin(v), rend(v))

  check v.size == v2.size
  check v[0] == v2[2]
  check v[1] == v2[1]
  check v[2] == v2[0]
  check v != v2

  v2 = initStdVector(cbegin(v), cend(v))

  check v.size == v2.size
  check v[0] == v2[0]
  check v[1] == v2[1]
  check v[2] == v2[2]
  check v == v2

  v2 = initStdVector(crbegin(v), crend(v))

  check v.size == v2.size
  check v[0] == v2[2]
  check v[1] == v2[1]
  check v[2] == v2[0]
  check v != v2

test "test vector capacity methods":
  var v = initStdVector[int](3)

  check v.size == 3
  check v.capacity >= v.size
  check v.max_size >= v.size
  check not v.empty

  let oldCap = v.capacity
  let oldSz = v.size
  v.reserve(2*oldCap)

  check oldCap < v.capacity
  check oldSz == v.size

  v.resize(oldSz+1)

  check oldSz+1 == v.size

  v.shrink_to_fit

  check v.size == v.capacity

test "test vector element access methods":
  var v = initStdVector[int](3)

  check v[0] == 0
  check v.at(0) == 0

  v[0] = 100

  check v[0] == 100
  check v.at(0) == 100

  v.at(0) = 1000

  check v[0] == 1000
  check v.at(0) == 1000

  when compileOption("boundChecks"):
    expect(IndexError):
      discard v[4]
    expect(OutOfRangeException):
      discard v.at(4)

  v = initStdVector[int](5)
  for i in 0..<v.size:
    v[i] = i

  check v.front == 0
  check v.back == 4

  v = initStdVector[int](2)
  v.front() = 10
  v.back() = 11

  check v[0] == 10
  check v[1] == 11

  var pdata = v.data

  check pdata[] == 10
  check cast[ptr int](cast[int](pdata)+1*sizeof(int))[] == 11

test "test vector modifiers":
  var v = initStdVector[int]()
  for i in 0..<3:
    v.push_back i

  for i in 0..<3:
    check v[i] == i

  v.pop_back()

  check v.size == 2
  for i in 0..<v.size:
    check v[i] == i

  discard v.insert(v.`end`, 2)

  check v.size == 3
  for i in 0..<3:
    check v[i] == i

  v.pop_back()

  discard v.insert(v.cend, 2)

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

  v.push_back 2
  discard v.erase(v.begin())

  check v.size == 1
  check v[0] == 2

  v = initStdVector[int](3, 1)
  var v1 = initStdVector[int](3, 2)

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

test "test vector relational operators":
  let foo = initStdVector[int](3, 100)
  let bar = initStdVector[int](2, 200)

  check foo == foo
  check foo <= foo
  check foo >= foo
  check foo != bar
  check not (foo > bar)
  check foo < bar
  check not (foo >= bar)
  check foo <= bar

test "test vector display":
  var v = initStdVector[int]()

  check $v == "[]"

  v.push_back 1
  v.push_back 2
  v.push_back 3

  check $v == "[1, 2, 3]"
