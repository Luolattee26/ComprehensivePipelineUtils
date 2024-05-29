test_that("return gene type form gene ensembl ID", {
  expect_equal(
    get_gene_type(c("H19", "HOTAIR"),
      input_type = "Symbol"
    ),
    c("processed_transcript", "antisense")
  )
})
