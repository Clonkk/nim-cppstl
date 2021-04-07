# This code is licensed under MIT license (see LICENSE.txt for details)
import unittest
import cppstl/std_string

suite "CppString":
  test "constructors and iterators":
    var s = initCppString()
    check s.empty
    check s.length == 0
    check s == "".cstring

    s = initCppString("hello nim")
    check s == "hello nim".cstring
    check $s == "hello nim".cstring

    s = initCppString("hello nim", 5)
    check s == "hello".cstring

    var s1: CppString = initCppString("hello")
    check s1 == s

    s1 = initCppString(s)
    check s1 == s

    s1 = initCppString(s, 3)
    check s1 == "lo".cstring

    s1 = initCppString(s, 0, 4)
    check s1 == "hell".cstring

    s1 = initCppString(s.begin, s.`end`)
    check s1 == s

    s1 = initCppString(s.begin, s.begin+4)
    check s1 == "hell".cstring

    s1 = initCppString(s.cbegin, s.cbegin+4)
    check s1 == "hell".cstring

    s1 = initCppString(s.rbegin, s.rend)
    check s1 == "olleh".cstring

    s1 = initCppString(s.crbegin, s.crend)
    check s1 == "olleh".cstring

  test "capacity & size":
    var s: CppString = initCppString "Hello Nim!"

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

    s = initCppString("Hello")
    s.reserve(s.capacity*2)
    s.shrink_to_fit

    # check s.length == s.capacity # implementation dependent.
      # Does not allways hold

  test "accessors":
    var s: CppString = initCppString("Hello Nim!")
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
    var s: CppString = initCppString("Hello")
    var s2 = initCppString(" Nim!")
    discard s += s2

    check s == "Hello Nim!".cstring
    discard s += " Welcome!".cstring
    check s == "Hello Nim! Welcome!".cstring
    discard s += '!'
    check s == "Hello Nim! Welcome!!".cstring

    s = initCppString("Hello")
    discard s.append s2
    check s == "Hello Nim!".cstring
    discard s.append " Welcome!".cstring
    check s == "Hello Nim! Welcome!".cstring
    discard s.append(1, '!')
    check s == "Hello Nim! Welcome!!".cstring
    discard s.append(3, '!')
    check s == "Hello Nim! Welcome!!!!!".cstring

    s2 = initCppString "!!! :)"
    discard s.append(s2, 3, 3)
    check s == "Hello Nim! Welcome!!!!! :)".cstring
    discard s.append(" :)...........".cstring, 4)
    check s == "Hello Nim! Welcome!!!!! :) :).".cstring

    s2 = initCppString "I say Bye!"
    discard s.append(s2.cbegin+5, s2.cend)
    check s == "Hello Nim! Welcome!!!!! :) :). Bye!".cstring
    discard s.push_back '!'
    check s == "Hello Nim! Welcome!!!!! :) :). Bye!!".cstring

    s = initCppString ""
    s2 = initCppString "Hello"
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

    s = initCppString "H!!!"
    s2 = initCppString "ello "
    discard s.insert(1, s2)
    check s == "Hello !!!".cstring

    s = initCppString "H!!!"
    s2 = initCppString "Hello !!!"
    discard s.insert(1, s2, 1, 5)
    check s == "Hello !!!".cstring

    s = initCppString "H!!!"
    discard s.insert(1, "ello ".cstring)
    check s == "Hello !!!".cstring

    s = initCppString "H!!!"
    discard s.insert(1, "ello ???".cstring, 5)
    check s == "Hello !!!".cstring

    s = initCppString "Heo !!!"
    discard s.insert(2, 2, 'l')
    check s == "Hello !!!".cstring

    s = initCppString "Heo !!!"
    discard s.insert(s.begin+2, 2, 'l')
    check s == "Hello !!!".cstring

    s = initCppString "Hllo !!!"
    discard s.insert(s.begin+1, 'e')
    check s == "Hello !!!".cstring

    s = initCppString "H!!!"
    s2 = initCppString "Hello !!!"
    discard s.insert(s.begin+1, s2.cbegin+1, s2.cend-3)
    check s == "Hello !!!".cstring

    s = initCppString "Hello"
    discard s.erase()
    check s.empty

    s = initCppString "Hello"
    discard s.erase(1)
    check s == "H".cstring

    s = initCppString "Hello"
    discard s.erase(1, 3)
    check s == "Ho".cstring

    s = initCppString "Hello"
    discard s.erase(s.begin+1)
    check s == "Hllo".cstring

    s = initCppString "Hello"
    discard s.erase(s.begin+1, s.`end`)
    check s == "H".cstring

    s = initCppString "HELLO !"
    s2 = initCppString "ello"
    discard s.replace(1, 4, s2)
    check s == "Hello !".cstring

    s = initCppString "HELLO !"
    s2 = initCppString "ello"
    discard s.replace(s.cbegin+1, s.cend-2, s2)
    check s == "Hello !".cstring

    s = initCppString "HELLO !"
    s2 = initCppString "hhhello there"
    discard s.replace(1, 4, s2, 3, 4)
    check s == "Hello !".cstring

    s = initCppString "HELLO !"
    discard s.replace(1, 4, "ello".cstring)
    check s == "Hello !".cstring

    s = initCppString "HELLO !"
    discard s.replace(s.cbegin+1, s.cend-2, "ello".cstring)
    check s == "Hello !".cstring

    s = initCppString "HELLO !"
    discard s.replace(1, 4, "ello....".cstring, 4)
    check s == "Hello !".cstring

    s = initCppString "HELLO !"
    discard s.replace(s.cbegin+1, s.cend-2, "ello....".cstring, 4)
    check s == "Hello !".cstring

    s = initCppString "Hejjo !"
    discard s.replace(2, 2, 4, 'l')
    check s == "Hellllo !".cstring

    s = initCppString "Hejjo !"
    discard s.replace(s.cbegin+2, s.cbegin+4, 4, 'l')
    check s == "Hellllo !".cstring

    s = initCppString "HELLO !"
    s2 = initCppString "hello"
    discard s.replace(s.cbegin+1, s.cend-2, s2.cbegin+1, s2.cend)
    check s == "Hello !".cstring

    s = initCppString "HELLO !"
    s2 = initCppString "hello"
    s.swap s2
    check s == "hello".cstring
    s.pop_back
    check s == "hell".cstring

  test "test string operations":
    var s: CppString = initCppString "Hello Nim!"

    check s.c_str == "Hello Nim!".cstring
    check s.data[] == 'H'

    var s2: CppString = initCppString "Hello"
    var cstr = newSeq[cchar](4)
    discard s2.copy(addr cstr[0], 3, 2)

    check cast[cstring](addr cstr[0]) == "llo"

    s = initCppString "hello hello"
    s2 = initCppString "ll"

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

    s = initCppString "Please, replace the vowels in this sentence by asterisks."
    s2 = initCppString "aeiou"
    var found = s.find_first_of(s2);
    while found != std_npos:
      s[found] = '*'
      found = s.find_first_of(s2, found+1)

    check s == "Pl**s*, r*pl*c* th* v*w*ls *n th*s s*nt*nc* by *st*r*sks.".cstring

    s = initCppString "Please, replace the vowels in this sentence by asterisks."
    found = s.find_first_of("aeiou");
    while found != std_npos:
      s[found] = '*'
      found = s.find_first_of("aeiou", found+1)

    check s == "Pl**s*, r*pl*c* th* v*w*ls *n th*s s*nt*nc* by *st*r*sks.".cstring

    s = initCppString "Please, replace the vowels in this sentence by asterisks."
    found = s.find_first_of("aeiou", 0, 3);
    while found != std_npos:
      s[found] = '*'
      found = s.find_first_of("aeiou", found+1, 3)

    check s == "Pl**s*, r*pl*c* th* vow*ls *n th*s s*nt*nc* by *st*r*sks.".cstring
    check s.find_first_of('l', 3) == 11

    s = initCppString "/usr/bin/man"
    s2 = initCppString "/\\"

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

    s = initCppString "1293a456b7"
    s2 = initCppString "123456789"

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

    s = initCppString "green apple"
    s2 = initCppString "red apple"

    check s.compare(s2) != 0
    check s.compare("red apple".cstring) != 0
    check s.compare(0, s.length, s2) != 0
    check s.compare(0, s.length, "red apple".cstring) != 0
    check s.compare(6, 5, "apple".cstring) == 0
    check s.compare(6, 5, "red apple".cstring, 4, 5) == 0
    check s.compare(6, 5, s2, 4, 5) == 0

  test "test string non-member function overloads":
    var s1: CppString = initCppString "Hello "
    var s2: CppString = initCppString "Nim"

    check s1+s2 == "Hello Nim".cstring
    check s1+"Nim".cstring == "Hello Nim".cstring
    check "Hello ".cstring()+s2 == "Hello Nim".cstring
    check s1+'!' == "Hello !".cstring
    check '!'+s1+'!' == "!Hello !".cstring

    discard s1 += s2

    check s1 == "Hello Nim".cstring

    s1 = initCppString "alpha"
    s2 = initCppString "beta"

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

