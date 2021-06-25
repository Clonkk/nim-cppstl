when not compiles(nimVersion):
  const nimVersion = (major: NimMajor, minor: NimMinor, patch: NimPatch)

when nimVersion >= (1, 3, 3):
  # https://github.com/nim-lang/Nim/commit/9502e39b634eea8e04f07ddc110b466387f42322
  switch("backend", "cpp")
