import cppstl/std_vector
export std_vector
import cppstl/std_basicstring
export std_basicstring
import cppstl/std_string
export std_string
import cppstl/std_smartptrs
export std_smartptrs
import cppstl/std_complex
export std_complex
import cppstl/std_pair
export std_pair

when not defined(cpp):
  {.error: "C++ backend required to use STL wrapper".}
# std=c++11 at least needed
# {.passC: "-std=c++11".}

## Nim wrapper for C++ STL :
##   * ``std::vector`` mapped to ``CppVector``
##   * ``std::basic_string`` mapped to ``CppBasicString``
##   * ``std::string`` mapped to ``CppString`` (alias for ``CppBasicString[cchar]``)
##   * ``std::complex`` mapped to ``CppComplex``
##   * ``std::shared_ptr`` mapped to ``CppSharedPtr``
##   * ``std::unique_ptr`` mapped to ``CppUniquePtr``
##   * ``std::pair`` mapped to ``CppPair``

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
  import complex
  var z = initCppComplex[float32](41.0, 31.0)
  var conj_z = z.conj()
  assert conj_z.real == z.real
  assert conj_z.imag == -z.imag


