switch("path", "$projectDir/..")
# switch("cc", "clang")
when not defined(testing):
  switch("outdir", "tests/bin")
