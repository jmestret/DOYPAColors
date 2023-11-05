###########################
#                         #
#       DOYPAColors       #
#   COLORS and PALETTES   #
#                         #
###########################

#' @import ggplot2

doypa_pals <- list(
  # Astro palette
  astro = c(
    "#1D313C", "#F6733A", "#ECD6C3", "#4FA3AB", "#387654"
  ),
  
  # Blue2Red Palette
  blue2red = c(
    "#1984c5", "#22a7f0", "#63bff0", "#a7d5ed", "#e2e2e2",
    "#e1a692", "#de6e56", "#e14b31", "#c23728"
  ),
  
  # Buzz Palette
  buzz = c(
    "#6036a4", "#9de26b", "#F5C290", "#B1B3B3", "#FF2400", "#ADD8E6"
  ),
  
  # Cool Blues Palette
  cool_blues = c(
    "#E0FFFF", "#ADD8E6", "#87CEEB", "#0000FF"
  ),
  
  # Cyberpunk Palette
  cyberpunk = c(
    "#DFD828", "#61A059", "#085857", "#313638", "#ff2a6d", "#B0BA83"
  ),
  
  # Deep Palette
  deep = c(
    "#255e65", "#d9bea1", "#a2a8a9", "#a88565", "#3591a0"
  ),
  
  # Earth Palette
  earth = c(
    "#D52429", "#F1602C", "#EC8922", "#915018", "#6C3F18"
  ),
  
  # Goofy Palette
  goofy = c(
    "#F58221", "#00AEEF", "#313638", "#F3D9CE", "#A6CE39"
  ),
  
  # Google Palette
  google = c(
    "#4285F4", "#34A853", "#FBBC05", "#EA4335"
  ),
  
  # Groovy Palette
  groovy = c(
    "#2BAF90", "#A1D4B1", "#F1A512", "#DD4111", "#8C0027"
  ),
  
  # High Contrast Palette
  high_contrast = c(
    "#00B5B0", "#00FF28", "#FFC700", "#FF0000", "#C70083", "#9500AC"
  ),
  
  # Nature Palette
  nature = c(
    "#228B22", "#8B4513", "#87CEEB", "#D2B48C", "#84CA67",
    "#BF530D", "#376362"
  ),
  
  # Purple2Green Palette
  purple2green = c(
    "#742881", "#986EAC", "#C3A4CF", "#E5D4E8", "#F9F9F9",
    "#D9F1D5", "#ADD4A0", "#5CAE63", "#1B7939"
  ),
  
  # Retro Palette
  retro = c(
    "#D54751", "#EF9A48", "#FFFCC7", "#4DA394", "#59322B"
  ),
  
  # Rookie Palette
  rookie = c(
    "#ff7f00", "#ff4500", "#836fff", "#00ff7f", "#f9f9f9"
  ),
  
  # Snack Palette
  snack = c(
    "#0D1282", "#EEEDED", "#F0DE36", "#D71313"
  ),
  
  # Sunset Palette
  sunset = c(
    "#FF4500", "#FF2400", "#FF007F", "#800080"
  ),
  
  # Tidy Palette
  tidy = c(
    "#1C4EAA", "#E36C14", "#666667", "#ADD8E6", "#FBE870"
  ),
  
  # Vaporwave Palette
  vaporwave = c(
    "#511940", "#F86A2A", "#07B7AD", "#0B60E1", "#E7C6AE"
  ),
  
  # Vintage Palette
  vintage = c(
    "#FBD0A6", "#F37022", "#B11016", "#2ABA9E", "#007096"
  )
)

#' Get a DOYPAColors color palette
#' 
#' @description 
#' This function generates a color vector of n colors for a specified palette.
#' 
#' @param palette Character string specifying the desired palette name.
#'   Available palettes: list_doypa_pals().
#' @param n Number of colors needed.
#' @param reverse Logical. If 'TRUE', reverses the order of colors in the palette.
#' @param ramp Logical. If 'TRUE', returns a color ramp (interpolation) instead of a vector of colors.
#' @return A vector of 'n' colors.
#' @export
#' @examples
#' # Generate a random color palette
#' color_palette <- doypa()
#' preview_doypa_pals(colors = color_palette)
#' 
#' # Generate a color palette of 5 colors using the "buzz" palette
#' color_palette <- doypa(palette = "buzz", n = 5)
#' preview_doypa_pals(colors = color_palette, palette = "buzz")
#' 
#' @seealso
#' 'list_doypa_pals' to list available palettes.
#' 'preview_doypa_pals' to preview color palettes.
doypa <- function(palette = NULL, n = NULL, reverse = FALSE, ramp = FALSE) {
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
    random_palette <- sample(names(doypa_pals), 1)
    palette <- random_palette
    message(sprintf(random_message, palette))
  } else if (!palette %in% names(doypa_pals)) {
    stop("Invalid palette name. Choose from: ", paste(names(doypa_pals), collapse = ", "))
  }
  
  col.pal <- doypa_pals[[palette]]
  names(col.pal) <- NULL
  
  if (is.null(n)){
    if (reverse == TRUE) {
      col.pal <- rev(col.pal)
    }
    return(col.pal)
  }
  
  if (!is.numeric(n) || n < 0) {
    stop("Invalid value for 'n'. 'n' must be a positive numeric value.")
  }
  
  if (n == 0) {
    return(character(0))
  }
  
  if (ramp){
    col.pal <- grDevices::colorRampPalette(col.pal)(n)
    if (reverse == TRUE) {
      col.pal <- rev(col.pal)
    }
    return(col.pal)
  }
  
  if (n < length(col.pal)) {
    col.pal <- col.pal[1:n]
    if (reverse == TRUE) {
      col.pal <- rev(col.pal)
    }
    return(col.pal)
  }
  
  col.pal <- grDevices::colorRampPalette(col.pal)(n)
  if (reverse == TRUE) {
    col.pal <- rev(col.pal)
  }
  return(col.pal)
}

#' Create a DOYPAColors color palette function
#' 
#' @description 
#' This function creates a function that generates a color vector or ramp of n colors 
#' for a specified DOYPAColors palette.
#' 
#' @param palette Character string specifying the desired palette name.
#'   Available palettes: list_doypa_pals().
#' @param reverse Logical. If 'TRUE', reverses the order of colors in the palette.
#' @param ramp Logical. If 'TRUE', the returned function generates a color ramp (interpolation) instead of a vector of colors.
#' @return A function that generates a vector of 'n' colors or a color ramp.
#' @export
#' @examples
#' # Create a function for generating colors from the "buzz" palette
#' get_buzz_palette <- doypa_palette(palette = "buzz")
#' colors <- get_buzz_palette(5)
#' preview_doypa_pals(colors = colors, palette = "buzz")
doypa_palette <- function(palette = NULL, reverse = FALSE, ramp = FALSE) {
  function(n) {
    doypa(palette, n, reverse, ramp)
  }
}

#' List available DOYPAColors color palettes
#' 
#' @description 
#' This function provides a list of all available DOYPAColors color palettes.
#' 
#' @return A character vector containing the names of available color palettes.
#' @export
#' @examples
#' # List available DOYPAColors color palettes
#' palette_names <- list_doypa_pals()
#' print(palette_names)
list_doypa_pals <- function() {
  return(names(doypa_pals))
}

#' Preview DOYPAColors palettes
#' 
#' @description 
#' This function generates a visual preview of DOYPAColors color palettes, allowing you to explore and select color schemes for your data visualizations.
#' 
#' @param palette Character string specifying the name of a specific DOYPAColors palette to preview. If provided, this overrides 'colors'.
#' @param colors A vector of colors to preview.
#' @return A 'ggplot' visualization of DOYPAColors color palettes for exploring and selecting color schemes in your data visualizations.
#' @export
#' @examples
#' # Preview a specific DOYPAColors palette by name
#' preview_doypa_pals(palette = "buzz")
#' 
#' # Preview a custom vector of colors
#' custom_colors <- c("#FF5733", "#33FF57", "#5733FF")
#' preview_doypa_pals(colors = custom_colors)
#' 
#' # Preview all available DOYPAColors palettes
#' preview_doypa_pals()
preview_doypa_pals <- function(palette = NULL, colors = NULL){
  if (!is.null(palette)) {
    doypa.colors <- doypa(palette = palette)
    palette.names <- palette
    lvl <- names(doypa_pals)
  } else if (!is.null(colors)){
    doypa.colors <- colors
    palette.names <- "DOYPAColors"
    lvl <- "DOYPAColors"
  } else {
    doypa.colors <- do.call(c, doypa_pals)
    palette.names <- c()
    for (i in names(doypa_pals)){
      palette.names <- c(palette.names, rep(i, length(doypa_pals[[i]])))
    }
    lvl <- names(doypa_pals)
  }
  
  data <- data.frame(id = palette.names, cols = doypa.colors, value = 1)
  data$id <- factor(data$id, levels = lvl)
  
ggplot(data, aes(fill = .data$cols, y = .data$value, x = .data$value)) +
    geom_bar(position = "fill", stat = "identity", fill = data$cols, width = 0.9) +
    coord_flip() +
    facet_wrap(id ~ ., strip.position = "bottom") +
    guides(fill = "none") +
    theme(axis.title.x = element_blank(),
          axis.text.x = element_blank(),
          axis.ticks.x = element_blank(),
          axis.title.y = element_blank(),
          axis.text.y = element_blank(),
          axis.ticks.y = element_blank(),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.background = element_blank(),
          strip.text = element_text(size = 10, face = "plain", 
                                    color = "#888a89", vjust = 1, hjust = 0),
          strip.background = element_blank())
}

#' Fill scale for ggplot2 with DOYPAColors color palettes
#' 
#' @description 
#' This function sets the fill scale for ggplot2 using DOYPAColors color palettes.
#' 
#' @param palette Character string specifying the desired palette name.
#'   Available palettes: list_doypa_pals().
#' @param n Number of colors needed.
#' @param reverse Boolean indicating whether to reverse the order of colors in the palette (default: FALSE).
#' @param ramp Boolean indicating whether to use a color ramp (gradient) or a vector of colors (default: FALSE).
#' @param discrete Boolean indicating whether to generate a discrete or continuous palette (default: continuous).
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
scale_fill_doypa <- function(palette = NULL, n = NULL, reverse = FALSE, ramp = FALSE, discrete = FALSE, ...) {
  if (discrete) {
    if (ramp){
      ggplot2::discrete_scale("fill", "DOYPAColors", doypa_palette(palette, reverse, ramp), ...)
    } else {
      ggplot2::scale_fill_manual(values = doypa(palette, n, reverse, ramp), ...)
    }
  } else {
    ggplot2::scale_fill_gradientn(colours = doypa(palette, 256, reverse, ramp), ...)
  }
}

#' Color scale for ggplot2 with DOYPAColors color palettes
#' 
#' @description 
#' This function sets the color scale for ggplot2 using DOYPAColors color palettes.
#' 
#' @param palette Character string specifying the desired palette name.
#'   Available palettes: list_doypa_pals().
#' @param n Number of colors needed.
#' @param ramp Boolean indicating whether to use a color ramp (gradient) or a vector of colors (default: FALSE).
#' @param reverse Boolean indicating whether to reverse the order of colors in the palette (default: FALSE).
#' @param discrete Boolean indicating whether to generate a discrete or continuous palette (default: continuous).
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
scale_color_doypa <- function(palette = NULL, n = NULL, reverse = FALSE, ramp = FALSE, discrete = FALSE, ...) {
  if (discrete) {
    if (ramp){
      ggplot2::discrete_scale("color", "DOYPAColors", doypa_palette(palette, reverse, ramp), ...)
    } else {
      ggplot2::scale_color_manual(values = doypa(palette, n, reverse, ramp), ...)
    }
  } else {
    ggplot2::scale_color_gradientn(colours = doypa(palette, 256, reverse, ramp), ...)
  }
}

#' Color scale for ggplot2 with DOYPAColors color palettes
#' 
#' @description 
#' This function sets the color scale for ggplot2 using DOYPAColors color palettes.
#' 
#' @param palette Character string specifying the desired palette name.
#'   Available palettes: list_doypa_pals().
#' @param n Number of colors needed.
#' @param ramp Boolean indicating whether to use a color ramp (gradient) or a vector of colors (default: FALSE).
#' @param reverse Boolean indicating whether to reverse the order of colors in the palette (default: FALSE).
#' @param discrete Boolean indicating whether to generate a discrete or continuous palette (default: continuous).
#' @param ... Additional parameters to pass to ggplot2's scale_color functions.
#' @return A `ggplot2` color scale suitable for adding to a `ggplot2` object to control color aesthetics.
#' @export
scale_colour_doypa <- scale_color_doypa


