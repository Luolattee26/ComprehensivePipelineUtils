test_that("id_to_symbol() funtion should return gene symbol list", {
  expect_equal(id_to_symbol(c("ENSG00000162444", "ENSG00000130939")),
               c("RBP7", "UBE4B"))
})
