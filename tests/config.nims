switch("path", "$projectDir/../src")
switch("backend", "cpp")
switch("cc", "clang")
when not defined(testing):
  switch("outdir", "tests/bin")
