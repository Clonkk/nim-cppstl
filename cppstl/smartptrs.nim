import std/macros

# std::shared_ptr<T>
# -----------------------------------------------------------------------
{.push header: "<memory>".}

type
  CppSharedPtr*[T]{.importcpp: "std::shared_ptr", bycopy.} = object

func make_shared*(T: typedesc): CppSharedPtr[T] {.importcpp: "std::make_shared<'*0>()".}

when defined(gcDestructors):
  # TODO Fix copy on shared_ptr
  proc `=copy`*[T](dst: var CppSharedPtr[T], src: CppSharedPtr[T]) {.error: "A shared_ptr cannot be copied".}
  # proc `=destroy`*[T](dst: var CppSharedPtr[T]){.importcpp: "#.~'*1()".}
  # proc `=sink`*[T](dst: var CppSharedPtr[T], src: CppSharedPtr[T]){.importcpp: "# = std::move(#)".}


# std::unique_ptr<T>
# -----------------------------------------------------------------------
type
  CppUniquePtr*[T]{.importcpp: "std::unique_ptr", header: "<memory>", bycopy.} = object

func make_unique*(T: typedesc): CppUniquePtr[T] {.importcpp: "std::make_unique<'*0>()".}


when defined(gcDestructors):
  proc `=copy`*(dst: var CppUniquePtr[T], src: CppUniquePtr[T]) {.error: "A unique ptr cannot be copied".}
  # proc `=destroy`*(dst: var CppUniquePtr[T]){.importcpp: "#.~'*1()".}
  # proc `=sink`*(dst: var CppUniquePtr[T], src: CppUniquePtr[T]){.importcpp: "# = std::move(#)".}

{.pop.}

# Seamless pointer access
# -----------------------------------------------------------------------
{.experimental: "dotOperators".}

# This returns var T but with strictFunc it shouldn't
func deref*[T](p: CppUniquePtr[T] or CppSharedPtr[T]): var T {.noInit, importcpp: "(* #)", header: "<memory>".}

macro `.()`*[T](p: CppUniquePtr[T] or CppSharedPtr[T], fieldOrFunc: untyped, args: varargs[untyped]): untyped =
  result = nnkCall.newTree(
    nnkDotExpr.newTree(
      newCall(bindSym"deref", p),
      fieldOrFunc
    )
  )
  copyChildrenTo(args, result)

macro `.`*[T](p: CppUniquePtr[T] or CppSharedPtr[T], fieldOrFunc: untyped, args: varargs[untyped]): untyped =
  result = nnkDotExpr.newTree(
      newCall(bindSym"deref", p),
      fieldOrFunc
    )
  #echo result.repr
  #copyChildrenTo(args, result)

macro `.=`*[T](p: CppUniquePtr[T] or CppSharedPtr[T], fieldOrFunc: untyped, args: untyped): untyped =
  result = newAssignment(
    nnkDotExpr.newTree(
      newCall(bindSym"deref", p),
      fieldOrFunc
    ),
    args
  )
  #echo result.repr
  #copyChildrenTo(args, result)

