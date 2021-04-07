import cppstl/vector
export vector
import cppstl/string
export string
import cppstl/smartptrs
export smartptrs
import cppstl/complex
export complex

## Nim wrapper for C++ STL ``std::string`` and ``std::vector``
##   * ``std::vector`` mapped to ``CppVector``
##   * ``std::string`` mapped to ``CppString`` to avoid name conflict (String was too close to ``string``)
##

runnableExamples:
  import cppstl
  var stdstr = initCppString("AZERTY")
  assert stdstr == "AZERTY"
  discard stdstr.append("UIOP")
  assert stdstr == "AZERTYUIOP"
  let startportion = stdstr.find("AZ")
  if startportion != std_npos:
    let endportion = startportion + len("AZ")
    discard stdstr.replace(startportion, endportion, "QW")
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

when not defined(cpp):
  {.error: "C++ backend required to use STL wrapper".}
# std=c++11 at least needed
# {.passC: "-std=c++11".}
