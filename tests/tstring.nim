# Copyright 2019 Nouredine Hussain

# This code is licensed under MIT license (see LICENSE.txt for details)
import unittest, cppstl/string

test "test string constructors and iterators":
    var s = initString()

    check s.empty
    check s.length == 0
    check s == ""

    s = initString("hello nim")

    check s == "hello nim"
    check $s == "hello nim"

    s = initString("hello nim", 5)

    check s == "hello"

    var s1 : String = "hello".cstring

    check s1 == s

    s1 = initString(s)

    check s1 == s

    s1 = initString(s, 3)

    check s1 == "lo"

    s1 = initString(s, 0, 4)

    check s1 == "hell"

    s1 = initString(s.begin, s.`end`)

    check s1 == s

    s1 = initString(s.begin, s.begin+4)

    check s1 == "hell"

    s1 = initString(s.cbegin, s.cbegin+4)

    check s1 == "hell"

    s1 = initString(s.rbegin, s.rend)

    check s1 == "olleh"

    s1 = initString(s.crbegin, s.crend)

    check s1 == "olleh"

test "test string capacity methods":
    var s: String = "Hello Nim!".cstring

    check s.size == s.length
    check s.max_size > s.size

    s.resize 5

    check s == "Hello"
    check s.capacity >= s.size

    let oldCap = s.capacity
    s.reserve(2*oldCap)

    check s.capacity == 2*oldCap

    s.clear

    check s.empty
    check s == ""

    s = "Hello".cstring
    s.reserve(s.capacity*2)
    s.shrink_to_fit

    # check s.length == s.capacity # implementation dependent. Does not allways hold

test "test string element access methods":
    var s: String = "Hello Nim!".cstring

    check s[1] == 'e'
    check s.at(1) == 'e'
    check s.front == 'H'
    check s.back == '!'

    s[1] = 'o'

    check s[1] == 'o'

    s.at(1) = 'e'
    s.front() = 'h'
    s.back() = '?'

    check s == "hello Nim?"

    when compileOption("boundChecks"):
        expect(IndexError):
            discard s[100]
        expect(OutOfRangeException):
            discard s.at(100)

test "test string modifiers":
    var s: String = "Hello".cstring
    var s2 = initString(" Nim!")
    s += s2

    check s == "Hello Nim!"

    s += " Welcome!".cstring

    check s == "Hello Nim! Welcome!"

    s += '!'

    check s == "Hello Nim! Welcome!!"

    s = "Hello".cstring
    s.append s2

    check s == "Hello Nim!"

    s.append " Welcome!".cstring

    check s == "Hello Nim! Welcome!"

    s.append(1, '!')

    check s == "Hello Nim! Welcome!!"

    s.append(3, '!')

    check s == "Hello Nim! Welcome!!!!!"

    s2 = "!!! :)".cstring
    s.append(s2, 3, 3)

    check s == "Hello Nim! Welcome!!!!! :)"

    s.append(" :)...........".cstring, 4)

    check s == "Hello Nim! Welcome!!!!! :) :)."

    s2 = "I say Bye!".cstring
    s.append(s2.cbegin+5, s2.cend)

    check s == "Hello Nim! Welcome!!!!! :) :). Bye!"

    s.push_back '!'

    check s == "Hello Nim! Welcome!!!!! :) :). Bye!!"

    s = "".cstring
    s2 = "Hello".cstring
    s.assign(s2)

    check s == s2

    s.assign(s2, 1, 3)

    check s == "ell"

    s.assign("hi".cstring)

    check s == "hi"

    s.assign("hello".cstring, 4)

    check s == "hell"

    s.assign(3, '6')

    check s == "666"

    s = "H!!!".cstring
    s2 = "ello ".cstring
    s.insert(1, s2)

    check s == "Hello !!!"

    s = "H!!!".cstring
    s2 = "Hello !!!".cstring
    s.insert(1, s2, 1, 5)

    check s == "Hello !!!"

    s = "H!!!".cstring
    s.insert(1, "ello ".cstring)

    check s == "Hello !!!"

    s = "H!!!".cstring
    s.insert(1, "ello ???".cstring, 5)

    check s == "Hello !!!"

    s = "Heo !!!".cstring
    s.insert(2, 2, 'l')

    check s == "Hello !!!"

    s = "Heo !!!".cstring
    s.insert(s.begin+2, 2, 'l')

    check s == "Hello !!!"

    s = "Hllo !!!".cstring
    s.insert(s.begin+1, 'e')

    check s == "Hello !!!"

    s = "H!!!".cstring
    s2 = "Hello !!!".cstring
    s.insert(s.begin+1, s2.cbegin+1, s2.cend-3)

    check s == "Hello !!!"

    s = "Hello".cstring
    discard s.erase()

    check s.empty

    s = "Hello".cstring
    discard s.erase(1)

    check s == "H"

    s = "Hello".cstring
    discard s.erase(1, 3)

    check s == "Ho"

    s = "Hello".cstring
    discard s.erase(s.begin+1)

    check s == "Hllo"

    s = "Hello".cstring
    discard s.erase(s.begin+1, s.`end`)

    check s == "H"

    s = "HELLO !".cstring
    s2 = "ello".cstring
    discard s.replace(1, 4, s2)

    check s == "Hello !"

    s = "HELLO !".cstring
    s2 = "ello".cstring
    discard s.replace(s.cbegin+1, s.cend-2, s2)

    check s == "Hello !"

    s = "HELLO !".cstring
    s2 = "hhhello there".cstring
    discard s.replace(1, 4, s2, 3, 4)

    check s == "Hello !"

    s = "HELLO !".cstring
    discard s.replace(1, 4, "ello".cstring)

    check s == "Hello !"

    s = "HELLO !".cstring
    discard s.replace(s.cbegin+1, s.cend-2, "ello".cstring)

    check s == "Hello !"

    s = "HELLO !".cstring
    discard s.replace(1, 4, "ello....".cstring, 4)

    check s == "Hello !"

    s = "HELLO !".cstring
    discard s.replace(s.cbegin+1, s.cend-2, "ello....".cstring, 4)

    check s == "Hello !"

    s = "Hejjo !".cstring
    discard s.replace(2, 2, 4, 'l')

    check s == "Hellllo !"

    s = "Hejjo !".cstring
    discard s.replace(s.cbegin+2, s.cbegin+4, 4, 'l')

    check s == "Hellllo !"

    s = "HELLO !".cstring
    s2 = "hello".cstring
    discard s.replace(s.cbegin+1, s.cend-2, s2.cbegin+1, s2.cend)

    check s == "Hello !"

    s = "HELLO !".cstring
    s2 = "hello".cstring
    s.swap s2

    check s == "hello"

    s.pop_back

    check s == "hell"

test "test string operations":
  var s: String = "Hello Nim!".cstring

  check s.c_str == "Hello Nim!".cstring
  check s.data[] == 'H'

  var s2: String = "Hello".cstring
  var cstr = newSeq[cchar](4)
  discard s2.copy(addr cstr[0], 3, 2)

  check cast[cstring](addr cstr[0]) == "llo"

  s = "hello hello".cstring
  s2 = "ll".cstring

  check s.find(s2) == 2
  check s.find(s2, 5) == 8
  check s.find("ll".cstring) == 2
  check s.find("ll".cstring, 5) == 8
  check s.find("ll0".cstring, 5, 3) == -1
  check s.find("ll0".cstring, 5, 2) == 8
  check s.find('e') == 1
  check s.find('e', 3) == 7

  check s.rfind(s2) == 8
  check s.rfind(s2, 5) == 2
  check s.rfind("ll".cstring) == 8
  check s.rfind("ll".cstring, 5) == 2
  check s.rfind("ll0".cstring, 5, 3) == -1
  check s.rfind("ll0".cstring, 5, 2) == 2
  check s.rfind('e') == 7
  check s.rfind('e', 3) == 1

  s = "Please, replace the vowels in this sentence by asterisks.".cstring
  s2 = "aeiou".cstring
  var found = s.find_first_of(s2);
  while found != -1:
    s[found] = '*'
    found = s.find_first_of(s2, found+1)

  check s == "Pl**s*, r*pl*c* th* v*w*ls *n th*s s*nt*nc* by *st*r*sks."

  s = "Please, replace the vowels in this sentence by asterisks.".cstring
  found = s.find_first_of("aeiou");
  while found != -1:
    s[found] = '*'
    found = s.find_first_of("aeiou", found+1)

  check s == "Pl**s*, r*pl*c* th* v*w*ls *n th*s s*nt*nc* by *st*r*sks."

  s = "Please, replace the vowels in this sentence by asterisks.".cstring
  found = s.find_first_of("aeiou", 0, 3);
  while found != -1:
    s[found] = '*'
    found = s.find_first_of("aeiou", found+1, 3)

  check s == "Pl**s*, r*pl*c* th* vow*ls *n th*s s*nt*nc* by *st*r*sks."
  check s.find_first_of('l', 3) == 11

  s = "/usr/bin/man".cstring
  s2 = "/\\".cstring
  found = s.find_last_of(s2)

  check s.substr(found+1) == "man"

  found = s.find_last_of(s2, found-1)

  check s.substr(found+1) == "bin/man"

  found = s.find_last_of("/\\")

  check s.substr(found+1) == "man"

  found = s.find_last_of("/\\", found-1)

  check s.substr(found+1) == "bin/man"

  found = s.find_last_of("/\\lll", -1, 3)

  check s.substr(found+1) == "man"

  found = s.find_last_of("/\\", found-1, 3)

  check s.substr(found+1) == "bin/man"

  found = s.find_last_of('m')

  check s.substr(found) == "man"

  found = s.find_last_of('b', found-1)

  check s.substr(found) == "bin/man"

  s = "1293a456b7".cstring
  s2 = "123456789".cstring

  check s.find_first_not_of(s2) == 4
  check s.find_first_not_of(s2, 5) == 8
  check s.find_first_not_of("123456789".cstring) == 4
  check s.find_first_not_of("123456789".cstring, 5) == 8
  check s.find_first_not_of("123456789".cstring, 0, 3) == 2
  check s.find_first_not_of("123456789".cstring, 4, 3) == 4
  check s.find_first_not_of('1') == 1
  check s.find_first_not_of('1', 1) == 1

  check s.find_last_not_of(s2) == 8
  check s.find_last_not_of(s2, 5) == 4
  check s.find_last_not_of("123456789".cstring) == 8
  check s.find_last_not_of("123456789".cstring, 5) == 4
  check s.find_last_not_of("123456789".cstring, -1, 3) == 9
  check s.find_last_not_of("123456789".cstring, 4, 3) == 4
  check s.find_last_not_of('1') == 9
  check s.find_last_not_of('1', 1) == 1
