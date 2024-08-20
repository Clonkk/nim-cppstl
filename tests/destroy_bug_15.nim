import cppstl/std_vector

type Foo = object
  x: int

# proc `$`*(x: Foo) : string =
#   result = "Foo(x: "
#   result &= $x
#   result &= ")"

proc `=destroy`*(a: Foo) =
  echo ("=destroy", a.x)

proc main =
  var v = initCppVector[Foo]()

  # Should be empty
  echo v
  v.add Foo(x: 10)
  v.add Foo(x: 11)

  # Should contain 10, 11
  echo v

  v.add Foo(x: 12)
  v.add Foo(x: 13)
  # Should contain 10, 11, 12, 14
  echo v
  echo "-----------"
  # Clear should call object destructor
  v.clear()

main()
