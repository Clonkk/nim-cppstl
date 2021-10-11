import cppstl/std_vector

type Foo = object
  x: int

proc `=destroy`*(a: var Foo) {.inline.} =
  echo ("=destroy", a.x)

proc main =
  var v = initCppVector[Foo]()

  v.add Foo(x: 10)
  v.add Foo(x: 11)

  echo "ok0"
  echo v
  v.add Foo(x: 12)

  echo "ok1"
  echo v

  # Clear should call object destructor
  v.clear()
  echo "ok2"

main()
