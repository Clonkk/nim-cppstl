import cppstl/vector
export vector
import cppstl/string
export string

## Nim C++ STL wrapper for std::string and std::vector
##   * std::vector mapped to Vector
##   * std::string mapped to CppString to avoid name conflict (string is too generic)
##
## Examples :

runnableExamples:
   var stdstr = initCppString("AZERTY")
   echo stdstr
   assert stdstr == "AZERTY"
   stdstr.insert("UIOP")
   assert stdstr == "AZERTYUIOP"
   stdstr.replace("AZ", "QW")
   assert stdstr == "QWERTYUIOP"

runnableExamples:
   import math
   var vec = initVector[float64](10)
   for i in 0..<5:
     vec.push_back(sqrt(i))
   echo vec
   assert vec[0] == sqrt 0
   assert vec[1] == sqrt 1
   assert vec[2] == sqrt 2
   assert vec[3] == sqrt 3

when not defined(cpp):
  {.error: "C++ backend required to use STL wrapper".}
{.passC: "-std=c++11".}
