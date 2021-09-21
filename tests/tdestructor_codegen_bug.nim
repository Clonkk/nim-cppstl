# without the definiton of the `=destroy` hook this gives a code gen error
import cppstl/std_smartptrs

type
  Obj = object
    id: string
    isDestroyed: bool

type
  SharedPtrObj = CppSharedPtr[Obj]
  UniquePtrObj = CppUniquePtr[Obj]

proc `=destroy`*(x: var Obj) =
  echo "=destroy : ", x.id
  echo "=destroy : ", x.isDestroyed
  x.isDestroyed = true

proc init*(T: type SharedPtrObj, id: string): SharedPtrObj =
  result = make_shared(Obj)
  result.id = id
  result.isDestroyed = false

proc init*(T: type UniquePtrObj, id: string): UniquePtrObj=
  result = make_unique(Obj)
  result.id = id
  result.isDestroyed = false

proc main() =
  echo "BEGIN"
  var o1 = SharedPtrObj.init("123456")
  echo "o1>", o1

  var o2 = o1
  o2.id = "o2 indaplace"
  echo "o1>", o1
  echo "o2>", o2
  echo "----"

  # var o2 = make_shared(o1)
  # echo o2
  # o2.id = "shared1"
  # echo o1.id
  #
  # var o = UniquePtrObj.init()
  # echo o.id
  # echo o2

  echo "END"

main()
