{.experimental: "callOperator".}
#[
# self code is licensed under MIT license (see LICENSE.txt for details)
Partial support provided. Not full API
]#
when not defined(cpp):
  {.error: "C++ backend required to use STL wrapper".}


{.push header:"<utility>".}
# https://cplusplus.com/reference/utility/pair/
type
  CppPair*[F,S] {.importcpp:"std::pair <'0,'1>"} = object

# Member values
proc first*[F,S](p:CppPair[F,S]):F {.importcpp:"#.first" .}

proc second*[F,S](p:CppPair[F,S]):S {.importcpp:"#.second" .}

proc `first=`*[F,S](p:var CppPair[F,S];val:F) {.importcpp:"#.first = #" .}

proc `second=`*[F,S](p:var CppPair[F,S];val:S) {.importcpp:"#.second = #" .}

#proc first_type*[T,P](p:CppPair[T,P]):T {.importcpp:"#.first_type" .}

#proc second_type*[T,P](p:CppPair[T,P]):T {.importcpp:"#.second_type" .}

# Constructors
proc initCppPair*[F,S](first:F,second:S):CppPair[F,S] {.constructor,importcpp:"std::pair <'1,'2>(#,#)" .} 

#proc `()`*[F,S](this:var CppPair[F,S]; first:F; second:S) {.constructor,importcpp:"std::pair <'1,'2>(#,#)" .} 


# FAILING - copy
#proc initCppPair*[F,S](val:CppPair[F,S]):CppPair[F,S] {.constructor,importcpp:"std::pair < '1 ,'2 >(#)",nodecl .} 


#https://en.cppreference.com/w/cpp/utility/pair/make_pair
proc makePair*[F,S](a:F; b:S):CppPair[F,S] {.importcpp:"std::make_pair(@)" .}
  ## Constructs a pair object with its first element set to `a` and its second element set to `b`.
  ##
  ## https://cplusplus.com/reference/utility/make_pair/
 

# Member functions
# Note: No need to define: operator=  https://cplusplus.com/reference/utility/pair/operator=/

proc swap*[F,S](a, b:var CppPair[F,S]) {.importcpp:"#.swap(#)" .}
  ## Exchanges the contents between `a` and `b`.
  ##
  ## https://cplusplus.com/reference/utility/pair/swap/
  


{.pop.}

#-----------
# Some sugar
#-----------
import std/strformat

proc `$`*[F,S](val:CppPair[F,S]):string =
  ## provides stdout for CppPair
  &"CppPair( first: {val.first}, second: {val.second} )"
   
converter toTuple*[F,S](val:CppPair[F,S]):tuple[first:F, second:S] =
  ## converts a CppPair into a Nim's tuple
  (val.first, val.second)

proc `()`*[F,S](this:var CppPair[F,S]; first:F; second:S) =
  ## call operator to populate a CppPair
  this.first = first
  this.second = second

#------

when isMainModule:
  #var pair:CppPair[string,int] = makePair("hola",20)
  #assert pair.first == "hola"
  #assert pair.second == 20

  #pair.first = "hello"
  #pair.second = 21
  #assert pair.first == "hello"
  #assert pair.second == 21

  #var a:CppPair[string,int] = CppPair[string,int]("bye",10)
  #var a:CppPair[string,int] = CppPair[string,int]()
  #a.first = "hi"
  #a.second = 22
  #assert a.first == "hi"
  #assert a.second == 22

  # Init val
  #var b:CppPair[string,int] = initCppPair[string,int]("bye",10)
  #var a = initCppPair[string,int]("hi",22)
  #assert b.first == "bye"
  #assert b.second == 10

  # Copy
  #var c:CppPair[string,int] = initCppPair[string,int](b)  
  #assert c.first == "bye"
  #assert c.second == 10

  # operator=
  #var d = b
  #assert d.first == "bye"
  #assert d.second == 10  

  echo a
  echo a.toTuple

  # Constructor
  var f:CppPair[string,int]
  f("nest",30)
  assert f.first == "nest"
  assert f.second == 30