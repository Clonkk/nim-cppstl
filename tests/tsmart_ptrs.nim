import cppstl/std_smartptrs
import std/unittest
import std/strutils

type
  Obj = object
    id: int
    name: string

var guid = 0

type
  SharedPtrObj = CppSharedPtr[Obj]
  UniquePtrObj = CppUniquePtr[Obj]

proc init*(T: type SharedPtrObj, name: string): SharedPtrObj =
  inc(guid)
  result = makeShared(Obj)
  result.name = name
  result.id = guid

proc init*(T: type UniquePtrObj, name: string): UniquePtrObj =
  inc(guid)
  result = makeUnique(Obj)
  result.name = name
  result.id = guid

proc testShared() =
  test "SharedPtr":
    var sp1 = SharedPtrObj.init("ptr_1")

    check: sp1.id == 1

    check: sp1.name == "ptr_1"

    sp1.name = "ptr_2"
    check: sp1.name == "ptr_2"

    var sp2 = sp1
    check: sp2.id == 1
    check: sp2.name == "ptr_2"

    sp2.name = "ptr_3"
    check: sp1.name == "ptr_3"
    check sp1.name.len() == 5

    when defined(gcArc) or defined(gcOrc):
      check: $(sp1) == "CppShared ptr Obj(id: 1, name: \"ptr_3\")"
    else:
      check: contains($(sp1), """CppShared ptr""")
      check: contains($(sp1), """[id = 1,
name =""")
      check: contains($(sp1), """"ptr_3"]""" )

proc testUnique() =
  test "UniquePtr":
    var up1 = UniquePtrObj.init("ptr_1")

    check: up1.id == 2

    check: up1.name == "ptr_1"

    up1.name = "ptr_2"
    check: up1.name == "ptr_2"
    # Create a codegen bug
    # See https://github.com/nim-lang/Nim/issues/18982
    # check: $(up1) == "CppUnique ptr Obj(id: 2, name: \"ptr_2\")"


when isMainModule:
  testShared()
  testUnique()
