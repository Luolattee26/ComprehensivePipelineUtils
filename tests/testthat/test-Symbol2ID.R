test_that("Symbol2ID() should return gene ensemble ID", {
  expect_equal(Symbol2ID(c("H19", "HOTAIR")), c('ENSG00000130600', 'ENSG00000228630'))
})
