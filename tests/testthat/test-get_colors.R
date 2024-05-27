test_that("get N colors", {
  expect_equal(get_colors(5),
               c("#40E0D0", "#20B2AA", "#808000", "#FFFF00", "#E9967A"))
})
