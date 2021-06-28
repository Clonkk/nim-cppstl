import cppstl/std_vector

type Foo = object
  x: int

proc `=destroy`*(a: var Foo) {.inline.} =
  echo ("in destroy", a.x)

proc main =
  var v = initCppVector[Foo]()

  v.add Foo(x: 10)
  v.add Foo(x: 11)
  v.add Foo(x: 12)

  echo "ok0"
  echo v

  echo "ok1"
  echo v

  echo "ok2"

  # Clear should call object destructor
  v.clear()
  echo "ok3"

main()
