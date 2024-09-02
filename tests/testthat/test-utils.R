library(ggplot2)

# list_doypa_pals()
test_that("list_doypa_pals() returns a list", {
  palettes <- list_doypa_pals()
  
  # Ensure the result is a list
  expect_type(palettes, "list")
  
  # Check that the list has named elements
  expect_true(all(c("sequential", "diverging", "qualitative") %in% names(palettes)))
})

# preview_doypa_pals()
test_that("preview_doypa_pals() returns a ggplot object", {
  p <- preview_doypa_pals()
  
  # Ensure the result is a ggplot object
  expect_s3_class(p, "gg")
})

test_that("preview_doypa_pals() handles different types correctly", {
  # Test for different types
  expect_s3_class(preview_doypa_pals(type = "all"), "gg")
  expect_s3_class(preview_doypa_pals(type = "seq"), "gg")
  expect_s3_class(preview_doypa_pals(type = "div"), "gg")
  expect_s3_class(preview_doypa_pals(type = "qual"), "gg")
})

test_that("preview_doypa_pals() respects colorblind argument", {
  # Test for colorblind argument
  p_no_cb <- preview_doypa_pals(colorblind = FALSE)
  p_cb <- preview_doypa_pals(colorblind = TRUE)
  
  # Ensure both plots are ggplot objects
  expect_s3_class(p_no_cb, "gg")
  expect_s3_class(p_cb, "gg")
})

# preview_pal()
test_that("preview_pal() returns a ggplot object", {
  p <- preview_pal("buzz")
  
  # Ensure the result is a gridExtra object
  expect_s3_class(p, "gtable")
})
