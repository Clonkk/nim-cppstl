when not compiles(nimVersion):
  const nimVersion = (major: NimMajor, minor: NimMinor, patch: NimPatch)

switch("backend", "cpp")

when defined(macosx):
  switch("cc", "gcc")
