# Copyright 2019 Nouredine Hussain

# This code is licensed under MIT license (see LICENSE.txt for details)
import unittest
import cppstl/string

suite "StdString":
  test "constructors and iterators":
    var s = initStdString()
    check s.empty
    check s.length == 0
    check s == "".cstring

    s = initStdString("hello nim")
    check s == "hello nim".cstring
    check $s == "hello nim".cstring

    s = initStdString("hello nim", 5)
    check s == "hello".cstring

    var s1: StdString = initStdString("hello")
    check s1 == s

    s1 = initStdString(s)
    check s1 == s

    s1 = initStdString(s, 3)
    check s1 == "lo".cstring

    s1 = initStdString(s, 0, 4)
    check s1 == "hell".cstring

    s1 = initStdString(s.begin, s.`end`)
    check s1 == s

    s1 = initStdString(s.begin, s.begin+4)
    check s1 == "hell".cstring

    s1 = initStdString(s.cbegin, s.cbegin+4)
    check s1 == "hell".cstring

    s1 = initStdString(s.rbegin, s.rend)
    check s1 == "olleh".cstring

    s1 = initStdString(s.crbegin, s.crend)
    check s1 == "olleh".cstring

  test "capacity & size":
    var s: StdString = initStdString "Hello Nim!"

    check s.size == s.length
    check s.max_size > s.size

    s.resize 5

    check s == "Hello".cstring
    check s.capacity >= s.size

    let oldCap = s.capacity
    s.reserve(2*oldCap)

    check s.capacity == 2*oldCap

    s.clear

    check s.empty
    check s == "".cstring

    s = initStdString("Hello")
    s.reserve(s.capacity*2)
    s.shrink_to_fit

    # check s.length == s.capacity # implementation dependent.
                                   # Does not allways hold

  test "accessors":
    var s: StdString = initStdString("Hello Nim!")
    check s[1] == 'e'
    check s.at(1) == 'e'
    check s.front == 'H'
    check s.back == '!'

    s[1] = 'o'

    check s[1] == 'o'

    s.at(1) = 'e'
    s.front() = 'h'
    s.back() = '?'

    check s == "hello Nim?".cstring

    when compileOption("boundChecks"):
      expect(IndexDefect):
        discard s[100]
      expect(OutOfRangeException):
        discard s.at(100)

  test "test string modifiers":
    var s: StdString = initStdString("Hello")
    var s2 = initStdString(" Nim!")
    discard s += s2

    check s == "Hello Nim!".cstring
    discard s += " Welcome!".cstring
    check s == "Hello Nim! Welcome!".cstring
    discard s += '!'
    check s == "Hello Nim! Welcome!!".cstring

    s = initStdString("Hello")
    discard s.append s2
    check s == "Hello Nim!".cstring
    discard s.append " Welcome!".cstring
    check s == "Hello Nim! Welcome!".cstring
    discard s.append(1, '!')
    check s == "Hello Nim! Welcome!!".cstring
    discard s.append(3, '!')
    check s == "Hello Nim! Welcome!!!!!".cstring

    s2 = initStdString "!!! :)"
    discard s.append(s2, 3, 3)
    check s == "Hello Nim! Welcome!!!!! :)".cstring
    discard s.append(" :)...........".cstring, 4)
    check s == "Hello Nim! Welcome!!!!! :) :).".cstring

    s2 = initStdString "I say Bye!"
    discard s.append(s2.cbegin+5, s2.cend)
    check s == "Hello Nim! Welcome!!!!! :) :). Bye!".cstring
    discard s.push_back '!'
    check s == "Hello Nim! Welcome!!!!! :) :). Bye!!".cstring

    s = initStdString ""
    s2 = initStdString "Hello"
    discard s.assign(s2)
    check s == s2
    discard s.assign(s2, 1, 3)
    check s == "ell".cstring
    discard s.assign("hi".cstring)
    check s == "hi".cstring
    discard s.assign("hello".cstring, 4)
    check s == "hell".cstring
    discard s.assign(3, '6')
    check s == "666".cstring

    s = initStdString "H!!!"
    s2 = initStdString "ello "
    discard s.insert(1, s2)
    check s == "Hello !!!".cstring

    s = initStdString "H!!!"
    s2 = initStdString "Hello !!!"
    discard s.insert(1, s2, 1, 5)
    check s == "Hello !!!".cstring

    s = initStdString "H!!!"
    discard s.insert(1, "ello ".cstring)
    check s == "Hello !!!".cstring

    s = initStdString "H!!!"
    discard s.insert(1, "ello ???".cstring, 5)
    check s == "Hello !!!".cstring

    s = initStdString "Heo !!!"
    discard s.insert(2, 2, 'l')
    check s == "Hello !!!".cstring

    s = initStdString "Heo !!!"
    discard s.insert(s.begin+2, 2, 'l')
    check s == "Hello !!!".cstring

    s = initStdString "Hllo !!!"
    discard s.insert(s.begin+1, 'e')
    check s == "Hello !!!".cstring

    s = initStdString "H!!!"
    s2 = initStdString "Hello !!!"
    discard s.insert(s.begin+1, s2.cbegin+1, s2.cend-3)
    check s == "Hello !!!".cstring

    s = initStdString "Hello"
    discard s.erase()
    check s.empty

    s = initStdString "Hello"
    discard s.erase(1)
    check s == "H".cstring

    s = initStdString "Hello"
    discard s.erase(1, 3)
    check s == "Ho".cstring

    s = initStdString "Hello"
    discard s.erase(s.begin+1)
    check s == "Hllo".cstring

    s = initStdString "Hello"
    discard s.erase(s.begin+1, s.`end`)
    check s == "H".cstring

    s = initStdString "HELLO !"
    s2 = initStdString "ello"
    discard s.replace(1, 4, s2)
    check s == "Hello !".cstring

    s = initStdString "HELLO !"
    s2 = initStdString "ello"
    discard s.replace(s.cbegin+1, s.cend-2, s2)
    check s == "Hello !".cstring

    s = initStdString "HELLO !"
    s2 = initStdString "hhhello there"
    discard s.replace(1, 4, s2, 3, 4)
    check s == "Hello !".cstring

    s = initStdString "HELLO !"
    discard s.replace(1, 4, "ello".cstring)
    check s == "Hello !".cstring

    s = initStdString "HELLO !"
    discard s.replace(s.cbegin+1, s.cend-2, "ello".cstring)
    check s == "Hello !".cstring

    s = initStdString "HELLO !"
    discard s.replace(1, 4, "ello....".cstring, 4)
    check s == "Hello !".cstring

    s = initStdString "HELLO !"
    discard s.replace(s.cbegin+1, s.cend-2, "ello....".cstring, 4)
    check s == "Hello !".cstring

    s = initStdString "Hejjo !"
    discard s.replace(2, 2, 4, 'l')
    check s == "Hellllo !".cstring

    s = initStdString "Hejjo !"
    discard s.replace(s.cbegin+2, s.cbegin+4, 4, 'l')
    check s == "Hellllo !".cstring

    s = initStdString "HELLO !"
    s2 = initStdString "hello"
    discard s.replace(s.cbegin+1, s.cend-2, s2.cbegin+1, s2.cend)
    check s == "Hello !".cstring

    s = initStdString "HELLO !"
    s2 = initStdString "hello"
    s.swap s2
    check s == "hello".cstring
    s.pop_back
    check s == "hell".cstring

  test "test string operations":
    var s: StdString = initStdString "Hello Nim!"

    check s.c_str == "Hello Nim!".cstring
    check s.data[] == 'H'

    var s2: StdString = initStdString "Hello"
    var cstr = newSeq[cchar](4)
    discard s2.copy(addr cstr[0], 3, 2)

    check cast[cstring](addr cstr[0]) == "llo"

    s = initStdString "hello hello"
    s2 = initStdString "ll"

    check s.find(s2) == 2
    check s.find(s2, 5) == 8
    check s.find("ll".cstring) == 2
    check s.find("ll".cstring, 5) == 8
    check s.find("ll0".cstring, 5, 3) == std_npos
    check s.find("ll0".cstring, 5, 2) == 8
    check s.find('e') == 1
    check s.find('e', 3) == 7

    check s.rfind(s2) == 8
    check s.rfind(s2, 5) == 2
    check s.rfind("ll".cstring) == 8
    check s.rfind("ll".cstring, 5) == 2
    check s.rfind("ll0".cstring, 5, 3) == std_npos
    check s.rfind("ll0".cstring, 5, 2) == 2
    check s.rfind('e') == 7
    check s.rfind('e', 3) == 1

    s = initStdString "Please, replace the vowels in this sentence by asterisks."
    s2 = initStdString "aeiou"
    var found = s.find_first_of(s2);
    while found != std_npos:
      s[found] = '*'
      found = s.find_first_of(s2, found+1)

    check s == "Pl**s*, r*pl*c* th* v*w*ls *n th*s s*nt*nc* by *st*r*sks.".cstring

    s = initStdString "Please, replace the vowels in this sentence by asterisks."
    found = s.find_first_of("aeiou");
    while found != std_npos:
      s[found] = '*'
      found = s.find_first_of("aeiou", found+1)

    check s == "Pl**s*, r*pl*c* th* v*w*ls *n th*s s*nt*nc* by *st*r*sks.".cstring

    s = initStdString "Please, replace the vowels in this sentence by asterisks."
    found = s.find_first_of("aeiou", 0, 3);
    while found != std_npos:
      s[found] = '*'
      found = s.find_first_of("aeiou", found+1, 3)

    check s == "Pl**s*, r*pl*c* th* vow*ls *n th*s s*nt*nc* by *st*r*sks.".cstring
    check s.find_first_of('l', 3) == 11

    s = initStdString "/usr/bin/man"
    s2 = initStdString "/\\"

    found = s.find_last_of(s2)
    check s.substr(found+1) == "man".cstring
    found = s.find_last_of(s2, found-1)
    check s.substr(found+1) == "bin/man".cstring
    found = s.find_last_of("/\\")
    check s.substr(found+1) == "man".cstring
    found = s.find_last_of("/\\", found-1)
    check s.substr(found+1) == "bin/man".cstring
    found = s.find_last_of("/\\lll", std_npos, 3)
    check s.substr(found+1) == "man".cstring
    found = s.find_last_of("/\\", found-1, 3)
    check s.substr(found+1) == "bin/man".cstring
    found = s.find_last_of('m')
    check s.substr(found) == "man".cstring
    found = s.find_last_of('b', found-1)
    check s.substr(found) == "bin/man".cstring

    s = initStdString "1293a456b7"
    s2 = initStdString "123456789"

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
    check s.find_last_not_of("123456789".cstring, std_npos, 3) == 9
    check s.find_last_not_of("123456789".cstring, 4, 3) == 4
    check s.find_last_not_of('1') == 9
    check s.find_last_not_of('1', 1) == 1

    s = initStdString "green apple"
    s2 = initStdString "red apple"

    check s.compare(s2) != 0
    check s.compare("red apple".cstring) != 0
    check s.compare(0, s.length, s2) != 0
    check s.compare(0, s.length, "red apple".cstring) != 0
    check s.compare(6, 5, "apple".cstring) == 0
    check s.compare(6, 5, "red apple".cstring, 4, 5) == 0
    check s.compare(6, 5, s2, 4, 5) == 0

  test "test string non-member function overloads":
    var s1: StdString = initStdString "Hello "
    var s2: StdString = initStdString "Nim"

    check s1+s2 == "Hello Nim".cstring
    check s1+"Nim".cstring == "Hello Nim".cstring
    check "Hello ".cstring()+s2 == "Hello Nim".cstring
    check s1+'!' == "Hello !".cstring
    check '!'+s1+'!' == "!Hello !".cstring

    discard s1 += s2

    check s1 == "Hello Nim".cstring

    s1 = initStdString "alpha"
    s2 = initStdString "beta"

    check s1 != s2
    check s1 != "beta".cstring
    check "alpha".cstring != s2
    check not (s1 == s2)
    check not (s1 == "beta".cstring)
    check not ("alpha".cstring == s2)
    check s1 < s2
    check not (s1 > s2)
    check s1 > "aaaaaaaaaaaaa".cstring
    check s1 <= s2
    check not (s1 >= s2)
    check s1 >= "aaaaaaaaaaaaa".cstring
