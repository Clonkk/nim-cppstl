import std/macros

when not defined(cpp):
  {.error: "C++ backend required to use STL wrapper".}
# std::shared_ptr<T>
# -----------------------------------------------------------------------
{.push header: "<memory>".}

type
  CppSharedPtr*[T]{.importcpp: "std::shared_ptr", bycopy.} = object

func makeShared*(T: typedesc): CppSharedPtr[T] {.importcpp: "std::make_shared<'*0>()".}

func makeShared*[T](p: CppSharedPtr[T]): CppSharedPtr[T] {.importcpp: "std::make_shared<'*0>(#)".}

proc `=copy`*[T](p: var CppSharedPtr[T], o: CppSharedPtr[T]) {.noInit, importcpp: "# = #".}
proc `=sink`*[T](dst: var CppSharedPtr[T], src: CppSharedPtr[T]){.importcpp: "# = std::move(#)".}

# std::unique_ptr<T>
# -----------------------------------------------------------------------
type
  CppUniquePtr*[T]{.importcpp: "std::unique_ptr", header: "<memory>", bycopy.} = object

func makeUnique*(T: typedesc): CppUniquePtr[T] {.importcpp: "std::make_unique<'*0>()".}

proc `=copy`*[T](dst: var CppUniquePtr[T], src: CppUniquePtr[T]) {.error: "A unique ptr cannot be copied".}
proc `=sink`*[T](dst: var CppUniquePtr[T], src: CppUniquePtr[T]){.importcpp: "# = std::move(#)".}

{.pop.}

# Let C++ destructor do their things
proc `=destroy`[T](dst: var CppUniquePtr[T]) =
  discard
proc `=destroy`[T](dst: var CppSharedPtr[T]) =
  discard

# Seamless pointer access
# -----------------------------------------------------------------------
{.experimental: "dotOperators".}

# This returns var T but with strictFunc it shouldn't
func deref*[T](p: CppUniquePtr[T] or CppSharedPtr[T]): var T {.noInit, importcpp: "(* #)", header: "<memory>".}

func get*[T](p: CppUniquePtr[T] or CppSharedPtr[T]): ptr T {.noInit, importcpp: "(#.get())", header: "<memory>".}

proc `$`*[T](p: CppUniquePtr[T]): string =
  result = "CppUnique " & repr(get(p))

func `$`*[T](p: CppSharedPtr[T]): string =
  result = "CppShared " & repr(get(p))

macro `.()`*[T](p: CppUniquePtr[T] or CppSharedPtr[T], fieldOrFunc: untyped, args: varargs[untyped]): untyped =
  result = nnkCall.newTree(
    nnkDotExpr.newTree(
      newCall(bindSym"deref", p),
      fieldOrFunc
    )
  )
  copyChildrenTo(args, result)
  # echo result.repr

macro `.`*[T](p: CppUniquePtr[T] or CppSharedPtr[T], fieldOrFunc: untyped): untyped =
  result = nnkDotExpr.newTree(
      newCall(bindSym"deref", p),
      fieldOrFunc
    )
  # echo result.repr

macro `.=`*[T](p: CppUniquePtr[T] or CppSharedPtr[T], fieldOrFunc: untyped, args: untyped): untyped =

  result = newAssignment(
    nnkDotExpr.newTree(
      newCall(bindSym"deref", p),
      fieldOrFunc
    ),
    args
  )
  # echo result.repr
