# DOYPAColors Scales

#' DOYPAColors Palette Selector
#'
#' @description
#' This function provides access to the DOYPAColors palettes, which are categorized into sequential, diverging, and qualitative types. 
#' You can select a palette, define the number of colors, reverse the order, and interpolate colors as a gradient.
#'
#' @param palette A character string specifying the name of the palette to use. If `NULL`, a random palette will be selected.
#' @param n An integer specifying the number of colors to return. If `NULL`, the full palette is returned.
#' @param reverse A logical value indicating whether to reverse the order of colors in the palette. Default is `FALSE`.
#' @param gradient A logical value indicating whether to interpolate colors as a  gradient of `n` colors between the first and last colors of the palette. If `FALSE`, returns the first `n` colors of the palette.
#' @param type A character string specifying the type of palettes to select from: "all", "seq" (sequential), "div" (diverging), or "qual" (qualitative). Default is "all".
#' @param colorblind A logical value indicating whether to restrict the palette to colorblind-friendly options. Default is `FALSE`.
#'
#' @return A character vector of colors.
#'
#' @examples
#' # Get a palette by name
#' colors <- doypa("buzz")
#' print(colors)
#'
#' # Get a random palette
#' colors <- doypa()
#' print(colors)
#'
#' # Get a palette with a specific number of colors
#' colors <- doypa("google", n = 3)
#' print(colors)
#'
#' # Reverse the order of the palette
#' colors <- doypa("buzz", reverse = TRUE)
#' print(colors)
#'
#' # Interpolate colors as a gradient
#' colors <- doypa("buzz", n = 10, gradient = TRUE)
#' print(colors)
#' 
#' @seealso
#' 'list_doypa_pals' to list available palettes.
#' 'preview_doypa_pals' to preview all color palettes.
#'
#' @export
doypa <- function(palette = NULL, n = NULL, reverse = FALSE, gradient = FALSE,
                  type = "all", colorblind = FALSE) {
  
  # Validate the 'type' argument
  type <- match.arg(type, c("all", "seq", "div", "qual"))
  
  # Random messages
  random_message_list <- c(
    "We've selected a random palette for you: %s",
    "DOYPAColors stands for Don't Overthink Your Palette of Colors! Your palette for today is: %s",
    "Ready to splash some color? Today's choice is the '%s' palette. Enjoy!",
    "Guess what? '%s' palette's the star today. No worries, we've got you covered!",
    "Ready, set, color! We've gone with the '%s' palette - no need to sweat it!",
    "Look what the palette fairy brought - it's the '%s' palette! Now, let's get creative!",
    "We've handpicked the exciting '%s' palette for you - no overthinking required!",
    "Ta-da! A surprise with the '%s' palette, just for you. Don't stress the small stuff!",
    "Surprise! You've got the '%s' palette ready to roll. Less thinking, more plotting!"
  )
  
  # Choose a random message
  random_message <- sample(random_message_list, 1)
  
  if (is.null(palette)) {
    # Choose a random palette based on type and colorblind settings
    palette_options <- switch(
      type,
      all = if (colorblind) doypa_colorblind else names(doypa_pals),
      seq = if (colorblind) intersect(doypa_sequential, doypa_colorblind) else doypa_sequential,
      div = if (colorblind) intersect(doypa_diverging, doypa_colorblind) else doypa_diverging,
      qual = if (colorblind) intersect(doypa_qualitative, doypa_colorblind) else doypa_qualitative
    )
    
    if (length(palette_options) == 0) {
      stop("No palettes available for the specified type and colorblind setting.")
    }
    
    palette <- sample(palette_options, 1)
    message(sprintf(random_message, palette))
  } else if (!palette %in% names(doypa_pals)) {
    stop("Invalid palette name. Choose from: ", paste(names(doypa_pals), collapse = ", "))
  }
  
  # Get the chosen palette
  col_pal <- doypa_pals[[palette]]
  
  # Reverse the palette if requested
  if (reverse) {
    col_pal <- rev(col_pal)
  }
  
  # Palette length
  if (is.null(n)) {
    return(col_pal)
  }
  
  if (!is.numeric(n) || n < 0) {
    stop("Invalid value for 'n'. 'n' must be a positive numeric value.")
  }
 
  if (n == 0) {
    return(character(0))
  }
  
  # Return the palette with n colors
  if (n <= length(col_pal)) {
    if (gradient) {
      col_pal <- grDevices::colorRampPalette(col_pal)(n)
    } else {
      col_pal <- col_pal[1:n]
    }
  } else if (n > length(col_pal)){
    warning(paste("'n' larger than the palette length. Returning", palette, "palette with interpolated colors."))
    col_pal <- grDevices::colorRampPalette(col_pal)(n)
  }
  
  return(col_pal)
}

#' Create a DOYPAColors color palette function
#' 
#' @description 
#' This function creates a function that generates a color vector of `n` colors 
#' for a specified DOYPAColors palette. The generated function allows you to 
#' easily create customized color palettes with a specified number of colors.
#' 
#' @param palette A character string specifying the name of the palette to use. If `NULL`, a random palette will be selected.
#' @param reverse A logical value indicating whether to reverse the order of colors in the palette. Default is `FALSE`.
#' @param gradient A logical value indicating whether to interpolate colors as a  gradient of `n` colors between the first and last colors of the palette. If `FALSE`, returns the first `n` colors of the palette.
#' @param type A character string specifying the type of palettes to select from: "all", "seq" (sequential), "div" (diverging), or "qual" (qualitative). Default is "all".
#' @param colorblind A logical value indicating whether to restrict the palette to colorblind-friendly options. Default is `FALSE`.
#' 
#' @return A function that generates a vector of `n` colors or a color gradient.
#' 
#' @examples
#' # Create a function for generating colors from the "buzz" palette
#' get_buzz_palette <- DOYPAColors:::doypa_palette(palette = "buzz")
#' color_palette <- get_buzz_palette(5)
#' print(color_palette)
#' 
#' @keywords internal
doypa_palette <- function(palette = NULL, reverse = FALSE, gradient = FALSE,
                          type = "all", colorblind = FALSE) {
  function(n) {
    doypa(palette, n, reverse, gradient, type, colorblind)
  }
}

#' Fill scale for ggplot2 with DOYPAColors color palettes
#' 
#' @description 
#' This function sets the fill scale for ggplot2 using DOYPAColors color palettes, allowing you to 
#' use these palettes in your ggplot2 visualizations for both discrete and continuous data.
#' 
#' @param palette A character string specifying the name of the palette to use. If `NULL`, a random palette will be selected.
#' @param n Number of colors needed. If `NULL`, it will default to the number of levels for discrete scales or to a continuous gradient for continuous scales.
#' @param reverse A logical value indicating whether to reverse the order of colors in the palette. Default is `FALSE`.
#' @param gradient A logical value indicating whether to interpolate colors as a  gradient of `n` colors between the first and last colors of the palette. If `FALSE`, returns the first `n` colors of the palette.
#' @param discrete Boolean indicating whether to generate a discrete or continuous palette (default: continuous).
#' @param type A character string specifying the type of palettes to select from: "all", "seq" (sequential), "div" (diverging), or "qual" (qualitative). Default is "all".
#' @param colorblind A logical value indicating whether to restrict the palette to colorblind-friendly options. Default is `FALSE`.
#' @param ... Additional parameters passed to ggplot2's `scale_fill_*` functions.
#' 
#' @return A `ggplot2` fill scale suitable for adding to a `ggplot2` object to control fill aesthetics.
#' 
#' @examples
#' library(ggplot2)
#' 
#' # Discrete data
#' data(iris)
#' disc <- ggplot(iris, aes(x = Species, y = Petal.Length, fill = Species)) +
#'   geom_boxplot() + theme_classic()
#' disc <- disc + scale_fill_doypa(palette = "buzz", discrete = TRUE)
#' print(disc)
#' 
#' # Continuous data
#' cont <- ggplot(faithfuld, aes(waiting, eruptions, fill = density)) + 
#'   geom_tile() + theme_classic()
#' cont <- cont + scale_fill_doypa(palette = "buzz")
#' print(cont)
#' 
#' # Colorblind-friendly palette
#' disc_colorblind <- ggplot(iris, aes(x = Species, y = Petal.Length, fill = Species)) +
#'   geom_boxplot() + theme_classic()
#' disc_colorblind <- disc_colorblind + scale_fill_doypa(colorblind = TRUE, discrete = TRUE)
#' print(disc_colorblind)
#' 
#' @export
scale_fill_doypa <- function(palette = NULL, n = NULL, reverse = FALSE, gradient = FALSE, 
                             discrete = FALSE, type = "all", colorblind = FALSE, ...) {
  if (discrete) {
    ggplot2::discrete_scale("fill", "DOYPAColors", doypa_palette(palette, reverse, gradient, type, colorblind), ...)
  } else {
    ggplot2::scale_fill_gradientn(colours = doypa(palette, n, reverse, gradient, type, colorblind), ...)
  }
}

#' Color scale for ggplot2 with DOYPAColors color palettes
#' 
#' @description 
#' This function sets the color scale for ggplot2 using DOYPAColors color palettes, allowing you to 
#' apply these palettes to both discrete and continuous data.
#' 
#' @param palette A character string specifying the name of the palette to use. If `NULL`, a random palette will be selected.
#' @param n Number of colors needed. If `NULL`, it will default to the number of levels for discrete scales or to a continuous gradient for continuous scales.
#' @param reverse A logical value indicating whether to reverse the order of colors in the palette. Default is `FALSE`.
#' @param gradient A logical value indicating whether to interpolate colors as a  gradient of `n` colors between the first and last colors of the palette. If `FALSE`, returns the first `n` colors of the palette.
#' @param discrete Boolean indicating whether to generate a discrete or continuous palette (default: continuous).
#' @param type A character string specifying the type of palettes to select from: "all", "seq" (sequential), "div" (diverging), or "qual" (qualitative). Default is "all".
#' @param colorblind A logical value indicating whether to restrict the palette to colorblind-friendly options. Default is `FALSE`.
#' @param ... Additional parameters passed to ggplot2's `scale_color_*` functions.
#' 
#' @return A `ggplot2` color scale suitable for adding to a `ggplot2` object to control color aesthetics.
#' 
#' @examples 
#' library(ggplot2)
#' 
#' # Discrete data
#' data(iris)
#' disc <- ggplot(iris, aes(x = Petal.Width, y = Petal.Length, color = Species)) +
#'   geom_point() + theme_classic()
#' disc <- disc + scale_color_doypa(palette = "buzz", discrete = TRUE)
#' print(disc)
#' 
#' # Continuous data
#' cont <- ggplot(iris, aes(x = Petal.Width, y = Petal.Length, color = Sepal.Length)) +
#'   geom_point() + theme_classic()
#' cont <- cont + scale_color_doypa(palette = "buzz")
#' print(cont)
#' 
#' # Colorblind-friendly palette
#' disc_colorblind <- ggplot(iris, aes(x = Petal.Width, y = Petal.Length, color = Species)) +
#'   geom_point() + theme_classic()
#' disc_colorblind <- disc_colorblind + scale_color_doypa(colorblind = TRUE, discrete = TRUE)
#' print(disc_colorblind)
#' 
#' @export
scale_color_doypa <- function(palette = NULL, n = NULL, reverse = FALSE, gradient = FALSE, 
                              discrete = FALSE, type = "all", colorblind = FALSE, ...) {
  if (discrete) {
    ggplot2::discrete_scale("color", palette = doypa_palette(palette, reverse, gradient, type, colorblind), ...)
  } else {
    ggplot2::scale_color_gradientn(colours = doypa(palette, n, reverse, gradient, type, colorblind), ...)
  }
}

#' Color scale for ggplot2 with DOYPAColors color palettes
#' 
#' @description 
#' This function sets the color scale for ggplot2 using DOYPAColors color palettes, allowing you to 
#' apply these palettes to both discrete and continuous data.
#' 
#' @param palette A character string specifying the name of the palette to use. If `NULL`, a random palette will be selected.
#' @param n Number of colors needed. If `NULL`, it will default to the number of levels for discrete scales or to a continuous gradient for continuous scales.
#' @param reverse A logical value indicating whether to reverse the order of colors in the palette. Default is `FALSE`.
#' @param gradient A logical value indicating whether to interpolate colors as a  gradient of `n` colors between the first and last colors of the palette. If `FALSE`, returns the first `n` colors of the palette.
#' @param discrete Boolean indicating whether to generate a discrete or continuous palette (default: continuous).
#' @param type A character string specifying the type of palettes to select from: "all", "seq" (sequential), "div" (diverging), or "qual" (qualitative). Default is "all".
#' @param colorblind A logical value indicating whether to restrict the palette to colorblind-friendly options. Default is `FALSE`.
#' @param ... Additional parameters passed to ggplot2's `scale_colour_*` functions.
#' 
#' @return A `ggplot2` color scale suitable for adding to a `ggplot2` object to control color aesthetics.
#' @export
scale_colour_doypa <- scale_color_doypa