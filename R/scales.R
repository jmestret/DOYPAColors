# DOYPAColors Scales

#' Get a DOYPAColors color palette
#' 
#' @description 
#' This function generates a color vector of n colors for a specified palette.
#' 
#' @param palette Character string specifying the desired palette name.
#' @param n Number of colors needed. Must be a positive numeric value.
#' @param reverse Logical. If 'TRUE', reverses the order of colors in the palette.
#' @param gradient Logical. If 'TRUE', interpolates a color gradient of n colors between the first and last colors of the palette. If 'FALSE', returns the first n colors of the palette.
#' @param type Character specifying the type of palettes to consider when choosing a random one.
#'   Options: "all" (default), "seq" (sequential), "div" (diverging), "qual" (qualitative).
#' @param colorblind Logical. Set to 'TRUE' for palettes designed with consideration for colorblind individuals.
#' @return A vector of 'n' colors.
#' @export
#' @examples
#' # Generate a random color palette
#' color_palette <- doypa()
#' preview_pal(colors = color_palette)
#' 
#' # Generate a color palette of 5 colors using the "buzz" palette
#' color_palette <- doypa(palette = "buzz", n = 5)
#' preview_pal(colors = color_palette)
#' 
#' @seealso
#' 'list_doypa_pals' to list available palettes.
#' 'preview_doypa_pals' to preview all color palettes.
doypa <- function(palette = NULL, n = NULL, reverse = FALSE, gradient = FALSE,
                  type = "all", colorblind = FALSE) {
  # List of messages
  random_message_list <- c(
    "We've selected a random palette for you: %s",
    "Remember, DOYPAColors stands for Don't Overthink Your PAlette of Colors! Your palette for today is: %s",
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
    # If palette is not provided, choose a random palette
    type <- match.arg(type, c("all", "seq", "div", "qual"))
    palette_options <- switch(
      type,
      all = if (colorblind) doypa_colorblind else names(doypa_pals),
      seq = if (colorblind) intersect(doypa_sequential, doypa_colorblind) else doypa_sequential,
      div = if (colorblind) intersect(doypa_diverging, doypa_colorblind) else doypa_diverging,
      qual = if (colorblind) intersect(doypa_qualitative, doypa_colorblind) else doypa_qualitative
    )
    
    palette <- sample(palette_options, 1)
    message(sprintf(random_message, palette))
  } else if (!palette %in% names(doypa_pals)) {
    stop("Invalid palette name. Choose from: ", paste(names(doypa_pals), collapse = ", "))
  }
  
  # Get palette
  col_pal <- doypa_pals[[palette]]
  
  # Reverse palette if asked
  if (reverse) {
    col_pal <- rev(col_pal)
  }
  
  # Palette length
  if (is.null(n)){
    return(col_pal)
  }
  if (!is.numeric(n) || n < 0) {
    stop("Invalid value for 'n'. 'n' must be a positive numeric value.")
  }
 
  if (n == 0) {
    col_pal <- character(0)
  } else if (n <= length(col_pal)) {
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
#' This function creates a function that generates a color vector of n colors 
#' for a specified DOYPAColors palette.
#' 
#' @param palette Character string specifying the desired palette name.
#' @param reverse Logical. If 'TRUE', reverses the order of colors in the palette.
#' @param gradient Logical. If 'TRUE', the returned function generates a color gradient (interpolation) instead of a vector of colors.
#' @param type Character specifying the type of palettes to consider when choosing a random one.
#'   Options: "all" (default), "seq" (sequential), "div" (diverging), "qual" (qualitative).
#' @param colorblind Logical. Set to 'TRUE' for palettes designed with consideration for colorblind individuals.
#' @return A function that generates a vector of 'n' colors or a color gradient.
#' @keywords internal
#' @examples
#' \dontrun{
#' # Create a function for generating colors from the "buzz" palette
#' get_buzz_palette <- doypa_palette(palette = "buzz")
#' color_palette <- get_buzz_palette(5)
#' preview_pal(colors = color_palette)
#' }
doypa_palette <- function(palette = NULL, reverse = FALSE, gradient = FALSE,
                          type = "all", colorblind = FALSE) {
  function(n) {
    doypa(palette, n, reverse, gradient, type, colorblind)
  }
}

#' Fill scale for ggplot2 with DOYPAColors color palettes
#' 
#' @description 
#' This function sets the fill scale for ggplot2 using DOYPAColors color palettes.
#' 
#' @param palette Character string specifying the desired palette name.
#' @param n Number of colors needed.
#' @param reverse Boolean indicating whether to reverse the order of colors in the palette (default: FALSE).
#' @param gradient Boolean indicating whether to use a color gradient (interpolation) or a vector of colors (default: FALSE).
#' @param discrete Boolean indicating whether to generate a discrete or continuous palette (default: continuous).
#' @param type Character specifying the type of palettes to consider when choosing a random one.
#'   Options: "all" (default), "seq" (sequential), "div" (diverging), "qual" (qualitative).
#' @param colorblind Logical. Set to 'TRUE' for palettes designed with consideration for colorblind individuals.
#' @param ... Additional parameters to pass to ggplot2's scale_fill functions.
#' @return A `ggplot2` fill scale suitable for adding to a `ggplot2` object to control fill aesthetics.
#' @export
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
#' This function sets the color scale for ggplot2 using DOYPAColors color palettes.
#' 
#' @param palette Character string specifying the desired palette name.
#' @param n Number of colors needed.
#' @param gradient Boolean indicating whether to use a color gradient (interpolation) or a vector of colors (default: FALSE).
#' @param reverse Boolean indicating whether to reverse the order of colors in the palette (default: FALSE).
#' @param discrete Boolean indicating whether to generate a discrete or continuous palette (default: continuous).
#' @param type Character specifying the type of palettes to consider when choosing a random one.
#'   Options: "all" (default), "seq" (sequential), "div" (diverging), "qual" (qualitative).
#' @param colorblind Logical. Set to 'TRUE' for palettes designed with consideration for colorblind individuals.
#' @param ... Additional parameters to pass to ggplot2's scale_color functions.
#' @return A `ggplot2` color scale suitable for adding to a `ggplot2` object to control color aesthetics.
#' @export
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
scale_color_doypa <- function(palette = NULL, n = NULL, reverse = FALSE, gradient = FALSE, 
                              discrete = FALSE, type = "all", colorblind = FALSE, ...) {
  if (discrete) {
    ggplot2::discrete_scale("color", "DOYPAColors", doypa_palette(palette, reverse, gradient, type, colorblind), ...)
  } else {
    ggplot2::scale_color_gradientn(colours = doypa(palette, n, reverse, gradient, type, colorblind), ...)
  }
}

#' Color scale for ggplot2 with DOYPAColors color palettes
#' 
#' @description 
#' This function sets the color scale for ggplot2 using DOYPAColors color palettes.
#' 
#' @param palette Character string specifying the desired palette name.
#' @param n Number of colors needed.
#' @param gradient Boolean indicating whether to use a color gradient (interpolation) or a vector of colors (default: FALSE).
#' @param reverse Boolean indicating whether to reverse the order of colors in the palette (default: FALSE).
#' @param discrete Boolean indicating whether to generate a discrete or continuous palette (default: continuous).
#' @param type Character specifying the type of palettes to consider when choosing a random one.
#'   Options: "all" (default), "seq" (sequential), "div" (diverging), "qual" (qualitative).
#' @param colorblind Logical. Set to 'TRUE' for palettes designed with consideration for colorblind individuals.
#' @param ... Additional parameters to pass to ggplot2's scale_colour functions.
#' @return A `ggplot2` color scale suitable for adding to a `ggplot2` object to control color aesthetics.
#' @export
scale_colour_doypa <- scale_color_doypa