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
  echo "---------------------------"
  echo "=destroy : ", x.id
  echo "=destroy : ", x.isDestroyed
  x.isDestroyed = true
  echo "---------------------------"

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
  var o1 = SharedPtrObj.init("shared_o1")
  echo "o1>", o1

  var o2 = o1
  o2.id = "shared_o2"
  echo "o1>", o1
  echo "o2>", o2
  echo "----"

  var o = UniquePtrObj.init("unique_o")
  # Create a codegen bug
  # See https://github.com/nim-lang/Nim/issues/18982
  # echo o
  echo o.id


  echo "END"

main()
