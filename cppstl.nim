import cppstl/std_vector
export std_vector
import cppstl/std_string
export std_string
import cppstl/std_smartptrs
export std_smartptrs
import cppstl/std_complex
export std_complex

## Nim wrapper for C++ STL :
##   * ``std::vector`` mapped to ``CppVector``
##   * ``std::string`` mapped to ``CppString``
##   * ``std::complex`` mapped to ``CppComplex``
##   * ``std::shared_ptr`` mapped to ``CppSharedPtr``
##   * ``std::unique_ptr`` mapped to ``CppUniquePtr``

runnableExamples:
  import cppstl
  var stdstr = initCppString("AZERTY")
  assert stdstr == "AZERTY"
  stdstr.append("UIOP")
  assert stdstr == "AZERTYUIOP"
  let startportion = stdstr.find("AZ")
  if startportion != std_npos:
    let endportion = startportion + len("AZ")
    stdstr.replace(startportion, endportion, "QW")
    assert stdstr == "QWERTYUIOP"

runnableExamples:
  import cppstl
  import math
  var vec = initCppVector[float64]()
  for i in 0..<5:
    vec.push_back(sqrt(i.float64))
  assert vec[0] == sqrt 0.0
  assert vec[1] == sqrt 1.0
  assert vec[2] == sqrt 2.0
  assert vec[3] == sqrt 3.0

runnableExamples:
  import cppstl
  import complex
  var z = initCppComplex[float32](41.0, 31.0)
  var conj_z = z.conj()
  assert conj_z.real == z.real
  assert conj_z.imag == -z.imag

when not defined(cpp):
  {.error: "C++ backend required to use STL wrapper".}
# std=c++11 at least needed
# {.passC: "-std=c++11".}
