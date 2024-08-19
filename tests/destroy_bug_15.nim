import cppstl/std_vector

type Foo = object
  x: int

proc `=destroy`*(a: Foo) =
  echo ("=destroy", a.x)

proc main =
  var v = initCppVector[Foo]()

  echo v
  v.add Foo(x: 10)
  v.add Foo(x: 11)
  echo v

  v.add Foo(x: 12)
  v.add Foo(x: 13)

  echo "-----------"
  echo v
  # Clear should call object destructor
  v.clear()

main()
