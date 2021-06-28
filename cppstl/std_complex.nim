# std::complex
# -----------------------------------------------------------------------
{.push header: "<complex>".}
type
  CppComplex*[T: SomeFloat] {.importcpp: "std::complex".} = object

func initCppComplex*[T: SomeFloat](re, im: T): CppComplex[T] {.constructor, importcpp: "std::complex<'*0>(@)".}
func polar*[T: SomeFloat](r, theta: T): CppComplex[T] {.importcpp: "std::polar<'*0>(@)".}

func real*[T: SomeFloat](self: CppComplex[T]): T {.importcpp: "#.real()".}
func imag*[T: SomeFloat](self: CppComplex[T]): T {.importcpp: "#.imag()".}

proc `+=`*[T: SomeFloat](self: var CppComplex[T], arg: CppComplex[T]) {.importcpp: "(# += #)".}
proc `-=`*[T: SomeFloat](self: var CppComplex[T], arg: CppComplex[T]) {.importcpp: "(# -= #)".}
proc `*=`*[T: SomeFloat](self: var CppComplex[T], arg: CppComplex[T]) {.importcpp: "(# *= #)".}
proc `/=`*[T: SomeFloat](self: var CppComplex[T], arg: CppComplex[T]) {.importcpp: "(# /= #)".}

proc `+`*[T: SomeFloat](a, b: CppComplex[T]): CppComplex[T] {.importcpp: "(# + #)".}
proc `-`*[T: SomeFloat](a, b: CppComplex[T]): CppComplex[T] {.importcpp: "(# - #)".}
proc `*`*[T: SomeFloat](a, b: CppComplex[T]): CppComplex[T] {.importcpp: "(# * #)".}
proc `/`*[T: SomeFloat](a, b: CppComplex[T]): CppComplex[T] {.importcpp: "(# / #)".}

proc `==`*[T: SomeFloat](a, b: CppComplex[T]): bool {.importcpp: "(# == #)".}
proc `!=`*[T: SomeFloat](a, b: CppComplex[T]): bool {.importcpp: "(# != #)".}

func abs*[T: SomeFloat](self: CppComplex[T]): T {.importcpp: "std::abs(@)".}
func norm*[T: SomeFloat](self: CppComplex[T]): T {.importcpp: "std::norm(@)".}
func arg*[T: SomeFloat](self: CppComplex[T]): T {.importcpp: "std::arg(@)".}
func conj*[T: SomeFloat](self: CppComplex[T]): CppComplex[T] {.importcpp: "std::conj(@)".}

{.pop.}

import complex
proc toComplex*[T](c: CppComplex[T]): Complex[T] =
  result.re = c.real()
  result.im = c.imag()

proc toCppComplex*[T](c: Complex[T]): CppComplex[T] =
  result = initCppComplex(c.re, c.im)

proc `$`*[T](c: CppComplex[T]): string =
  result.add "("
  result.add $(c.real())
  result.add ", "
  result.add $(c.imag())
  result.add ")"
