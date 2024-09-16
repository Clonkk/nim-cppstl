switch("path", "$projectDir/..")
# switch("cc", "clang")
switch("backend", "cpp")
switch("cc", "gcc")
when not defined(testing):
  switch("outdir", "tests/bin")

