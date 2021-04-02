switch("path", "$projectDir/../src")
switch("backend", "cpp")
when not defined(testing):
  switch("outdir", "tests/bin")
