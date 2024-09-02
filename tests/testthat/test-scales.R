library(ggplot2)

# doypa()
test_that("doypa() returns a palette by name", {
  expect_equal(doypa("buzz"), c("#6036a4", "#9de26b", "#F5C290", "#B1B3B3", "#FF2400", "#ADD8E6"))
})

test_that("doypa() returns a random palette when no palette is specified", {
  set.seed(123)
  palette <- doypa()
  expect_type(palette, "character")
})

test_that("doypa() handles invalid palette names", {
  expect_error(doypa("invalid_palette"), "Invalid palette name")
})

test_that("doypa() returns the correct number of colors", {
  expect_length(doypa("buzz", n = 3), 3)
  expect_length(doypa("google", n = 2), 2)
  expect_equal(doypa("google", n = 4), c("#4285F4", "#34A853", "#FBBC05", "#EA4335"))
})

test_that("doypa() returns an empty vector when n = 0", {
  expect_equal(doypa("buzz", n = 0), character(0))
})

test_that("doypa() handles the reverse argument correctly", {
  expect_equal(doypa("buzz", reverse = TRUE), rev(c("#6036a4", "#9de26b", "#F5C290", "#B1B3B3", "#FF2400", "#ADD8E6")))
})

test_that("doypa() returns a gradient of colors when requested", {
  gradient_colors <- doypa("buzz", n = 4, gradient = TRUE)
  expect_length(gradient_colors, 4)
})

test_that("doypa() issues a warning when n exceeds palette length", {
  expect_warning(doypa("buzz", n = 10), "'n' larger than the palette length")
})

test_that("doypa() handles colorblind-friendly palettes", {
  expect_type(doypa(type = "qual", colorblind = TRUE), "character")
})

test_that("doypa() handles different palette types", {
  expect_type(doypa(type = "seq"), "character")
  expect_type(doypa(type = "div"), "character")
  expect_type(doypa(type = "qual"), "character")
})

test_that("doypa() handles invalid n values", {
  expect_error(doypa("buzz", n = -1), "Invalid value for 'n'")
  expect_error(doypa("buzz", n = "a"), "Invalid value for 'n'")
})

# doypa_palette()

test_that("doypa_palette() returns a function that generates colors", {
  get_buzz_palette <- DOYPAColors:::doypa_palette(palette = "buzz")
  colors <- get_buzz_palette(3)
  expect_equal(length(colors), 3)
  expect_equal(colors, doypa("buzz", n = 3))
})

# scale_fill_doypa()
test_that("scale_fill_doypa() works with discrete scales", {
  p <- ggplot(iris, aes(x = Species, y = Petal.Length, fill = Species)) +
    geom_boxplot() + theme_classic()
  
  p_discrete <- p + scale_fill_doypa(palette = "buzz", discrete = TRUE)
  
  # Ensure the plot object is returned without error
  expect_s3_class(p_discrete, "ggplot")
  
  # Check that the scale is added correctly
  expect_true("ScaleDiscrete" %in% class(p_discrete$scales$scales[[1]]))
})

test_that("scale_fill_doypa() works with continuous scales", {
  p <- ggplot(faithfuld, aes(waiting, eruptions, fill = density)) +
    geom_tile() + theme_classic()
  
  p_continuous <- p + scale_fill_doypa(palette = "buzz")
  
  # Ensure the plot object is returned without error
  expect_s3_class(p_continuous, "ggplot")
  
  # Check that the scale is added correctly
  expect_true("ScaleContinuous" %in% class(p_continuous$scales$scales[[1]]))
})

test_that("scale_fill_doypa() handles additional ggplot2 scale arguments", {
  p <- ggplot(faithfuld, aes(waiting, eruptions, fill = density)) +
    geom_tile() + theme_classic()
  
  p_custom <- p + scale_fill_doypa(palette = "buzz", limits = c(0, 0.04))
  
  # Ensure the plot object is returned without error
  expect_s3_class(p_custom, "ggplot")
})

# scale_color_doypa()
test_that("scale_color_doypa() works with discrete scales", {
  p <- ggplot(iris, aes(x = Petal.Width, y = Petal.Length, color = Species)) +
    geom_point() + theme_classic()
  
  p_discrete <- p + scale_color_doypa(palette = "buzz", discrete = TRUE)
  
  # Ensure the plot object is returned without error
  expect_s3_class(p_discrete, "ggplot")
  
  # Check that the scale is added correctly
  expect_true("ScaleDiscrete" %in% class(p_discrete$scales$scales[[1]]))
})

test_that("scale_color_doypa() works with continuous scales", {
  p <- ggplot(iris, aes(x = Petal.Width, y = Petal.Length, color = Sepal.Length)) +
    geom_point() + theme_classic()
  
  p_continuous <- p + scale_color_doypa(palette = "buzz")
  
  # Ensure the plot object is returned without error
  expect_s3_class(p_continuous, "ggplot")
  
  # Check that the scale is added correctly
  expect_true("ScaleContinuous" %in% class(p_continuous$scales$scales[[1]]))
})

test_that("scale_color_doypa() handles additional ggplot2 scale arguments", {
  p <- ggplot(iris, aes(x = Petal.Width, y = Petal.Length, color = Sepal.Length)) +
    geom_point() + theme_classic()
  
  p_custom <- p + scale_color_doypa(palette = "buzz", limits = c(4, 8))
  
  # Ensure the plot object is returned without error
  expect_s3_class(p_custom, "ggplot")
})
