import cppstl/vector
export vector
import cppstl/string
export string
when not defined(cpp):
  {.error: "C++ backend required to use STL wrapper".}
{.passC: "-std=c++11".}
