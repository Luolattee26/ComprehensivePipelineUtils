test_that("ID_2_Symbol() function should return gene symbol", {
  expect_equal(ID_2_Symbol(c("ENSG00000162444", "ENSG00000130939")), c('RBP7', 'UBE4B'))
})
