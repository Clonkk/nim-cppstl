# without the definiton of the `=destroy` hook this gives a code gen error
import cppstl/std_smartptrs

type
  Obj = object
  XorNet = CppSharedPtr[Obj]

proc init*(T: type XorNet): XorNet =
  discard

proc main() =
  var model = XorNet.init()

main()
