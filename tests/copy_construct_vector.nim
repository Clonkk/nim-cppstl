
import cppstl/std_vector

proc main() =
  var v = toCppVector(@[1, 2, 3])
  var v2 = initCppVector(v)
  assert v == v2  

  v = initCppVector(3, 4)
  var v3 = initCppVector(v2)
  assert v == v3
  
main()
