test_that("symbol_to_id() funtion should return gene ensemble id", {
  expect_equal(
    symbol_to_id(c("H19", "HOTAIR")),
    c("ENSG00000130600", "ENSG00000228630")
  )
})
