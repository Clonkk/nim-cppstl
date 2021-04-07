# std::complex
# -----------------------------------------------------------------------
{.push cdecl.}
{.push header: "<complex>".}
type
  CppComplex*[T: SomeFloat] {.importcpp: "c10::complex".} = object

func initCppComplex*[T: SomeFloat](re, im: T) : CppComplex[T] {.importcpp: "std::complex".}

func real*[T: SomeFloat](self : CppComplex[T]): T {.importcpp: "#.real()".}
func imag*[T: SomeFloat](self : CppComplex[T]): T {.importcpp: "#.imag()".}

proc `+`*[T: SomeFloat](a, b: CppComplex[T]) : CppComplex[T] {.importcpp: "(# + #)" .}
proc `-`*[T: SomeFloat](a, b: CppComplex[T]) : CppComplex[T] {.importcpp: "(# - #)" .}
proc `*`*[T: SomeFloat](a, b: CppComplex[T]) : CppComplex[T] {.importcpp: "(# * #)" .}
proc `/`*[T: SomeFloat](a, b: CppComplex[T]) : CppComplex[T] {.importcpp: "(# / #)" .}

proc `=+`*[T: SomeFloat](self: var CppComplex[T], arg: CppComplex[T]) {.importcpp: "(# += #)" .}
proc `=-`*[T: SomeFloat](self: var CppComplex[T], arg: CppComplex[T]) {.importcpp: "(# -= #)" .}
proc `=*`*[T: SomeFloat](self: var CppComplex[T], arg: CppComplex[T]) {.importcpp: "(# *= #)" .}
proc `=/`*[T: SomeFloat](self: var CppComplex[T], arg: CppComplex[T]) {.importcpp: "(# /= #)" .}

proc `==`*[T: SomeFloat](a, b: CppComplex[T]) : bool {.importcpp: "(# == #)" .}
proc `!=`*[T: SomeFloat](a, b: CppComplex[T]) : bool {.importcpp: "(# != #)" .}

func abs*[T: SomeFloat](self : CppComplex[T]): T {.importcpp: "std::abs(@)".}
func arg*[T: SomeFloat](self : CppComplex[T]): T {.importcpp: "std::arg(@)".}
func norm*[T: SomeFloat](self : CppComplex[T]): T {.importcpp: "std::norm(@)".}

{.pop.}


