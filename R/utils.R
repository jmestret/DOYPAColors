# DOYPAColors utils

#' List Available DOYPAColors Color Palettes
#' 
#' @description 
#' This function provides a list of all available DOYPAColors color palettes, categorized by type: sequential, diverging, and qualitative.
#' It helps users to explore the various color palettes available for use in their visualizations.
#' 
#' @return A named list containing the names of available color palettes for each type: "sequential", "diverging", and "qualitative".
#' 
#' @export
#' 
#' @examples
#' # List available DOYPAColors color palettes by type
#' palette_names <- list_doypa_pals()
#' print(palette_names)
list_doypa_pals <- function() {
  palettes <- list(
    sequential = names(doypa_sequential),
    diverging = names(doypa_diverging),
    qualitative = names(doypa_qualitative)
  )
  return(palettes)
}

#' Preview DOYPAColors Palettes
#' 
#' @description 
#' This function generates a visual preview of DOYPAColors color palettes. It helps users explore and select color schemes for their data visualizations by displaying each palette in a grid format.
#' 
#' @param type Character string specifying the type of palettes to preview. Options are: "all" (default), "seq" (sequential), "div" (diverging), or "qual" (qualitative).
#' @param colorblind Logical. If `TRUE`, restricts the preview to palettes designed with colorblind individuals in mind.
#' @return A `ggplot` visualization displaying the DOYPAColors color palettes, facilitating exploration and selection of color schemes for data visualizations.
#' @export
#' @examples
#' # Preview all available DOYPAColors palettes
#' preview_doypa_pals()
#' 
#' # Preview only sequential DOYPAColors palettes
#' preview_doypa_pals(type = "seq")
#' 
#' # Preview colorblind-friendly DOYPAColors palettes
#' preview_doypa_pals(colorblind = TRUE)
preview_doypa_pals <- function(type = "all", colorblind = FALSE) {
  type <- match.arg(type, c("all", "seq", "div", "qual"))
  
  selected_pals <- switch(
    type,
    "all" = doypa_pals,
    "seq" = doypa_pals[names(doypa_pals) %in% doypa_sequential],
    "div" = doypa_pals[names(doypa_pals) %in% doypa_diverging],
    "qual" = doypa_pals[names(doypa_pals) %in% doypa_qualitative]
  )
  
  if (colorblind) {
    selected_pals <- selected_pals[names(selected_pals) %in% doypa_colorblind]
  }
  
  doypa_colors <- do.call(c, selected_pals)
  palette_names <- c()
  for (i in names(selected_pals)) {
    palette_names <- c(palette_names, rep(i, length(selected_pals[[i]])))
  }
  lvl <- names(selected_pals)
  
  data <- data.frame(id = palette_names, cols = doypa_colors, value = 1)
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


#' Preview a Single Color Palette
#' 
#' @description 
#' This function generates a visual preview of a DOYPAColors palette with multiple plots. It includes a direct palette preview, a scatter plot, a bar plot, and a heatmap, each using the specified palette.
#' 
#' @param palette A character string specifying the name of the palette to use.
#' @param seed An optional seed for reproducibility of random numbers.
#' @return A `ggplot` object with multiple plots arranged in a grid, showcasing the color palette in different visualizations.
#' @export
#' 
#' @import ggplot2
#' @import gridExtra
#' @importFrom stats rnorm runif
#' 
#' @examples
#' # Preview a DOYPAColors palette with multiple plots
#' preview_pal(palette = "buzz")
preview_pal <- function(palette, seed = NULL) {
  if (missing(palette) || is.null(palette)) {
    stop("You must provide a palette name.")
  }
  
  set.seed(seed)
  doypa_colors <- doypa(palette)
  
  # Bar Plot
  bar_data <- data.frame(
    category = factor(1:length(doypa_colors)),
    value = runif(length(doypa_colors), min = 0.5, max = 2)  # Random values for bar heights
  )
  
  bar_plot <- ggplot(bar_data, aes(x = .data$category, y = .data$value, fill = .data$category)) +
    geom_bar(stat = "identity") +
    scale_fill_doypa(palette = palette, discrete = TRUE, guide = "none") +
    theme_minimal() +
    labs(title = "Bar Plot", x = "Category", y = "Value") +
    theme(axis.title.x = element_blank(),
          axis.text.x = element_text(angle = 45, hjust = 1),
          axis.title.y = element_blank())
  
  # Scatter Plot with Clustered Data
  cluster_means <- matrix(runif(2 * length(doypa_colors), min = -length(doypa_colors), max = length(doypa_colors)), ncol = 2)
  scatter_data <- do.call(rbind, lapply(1:length(doypa_colors), function(i) {
    data.frame(
      x = rnorm(100, mean = cluster_means[i, 1], sd = 1),
      y = rnorm(100, mean = cluster_means[i, 2], sd = 1),
      group = factor(i)
    )
  }))
  
  scatter_plot <- ggplot(scatter_data, aes(x = .data$x, y = .data$y, color = .data$group)) +
    geom_point(size = 3, alpha = 0.7) +
    scale_color_doypa(palette = palette, discrete = TRUE) +
    theme_minimal() +
    labs(title = "Scatter Plot", color = "Group") +
    theme(axis.title.x = element_blank(),
          axis.title.y = element_blank())
  
  # 2D Density Plot
  a <- data.frame(x = rnorm(20000, 10, 1.9), y = rnorm(20000, 10, 1.2))
  b <- data.frame(x = rnorm(20000, 14.5, 1.9), y = rnorm(20000, 14.5, 1.9))
  c <- data.frame(x = rnorm(20000, 9.5, 1.9), y = rnorm(20000, 15.5, 1.9))
  density_data <- rbind(a, b, c)
  
  density_plot <- ggplot(density_data, aes(x = .data$x, y = .data$y)) +
    geom_hex() +
    scale_fill_doypa(palette = palette) +
    theme_minimal() +
    labs(title = "2D Density Plot", fill = "Count") +
    theme(axis.title.x = element_blank(),
          axis.title.y = element_blank(),
          legend.position = "none")
  
  # Raster Map or Heatmap
  if (requireNamespace("terra", quietly = TRUE) & requireNamespace("tidyterra", quietly = TRUE)) {
    raster_data <- terra::rast(system.file("ex/elev.tif", package = "terra"))
    
    raster_plot <- ggplot() +
      tidyterra::geom_spatraster(data = raster_data) +
      scale_fill_doypa(palette, na.value = NA) +
      theme_minimal() +
      labs(title = "Raster Map", fill = "Palette") +
      theme(axis.title.x = element_blank(),
            axis.title.y = element_blank(),
            legend.position = "right")
  } else {
    # Simulate a continuous heatmap with fake data
    n <- 20
    heatmap_data <- expand.grid(x = 1:n, y = 1:n)
    heatmap_data$z <- with(heatmap_data, sin(x / n * 2 * pi) * cos(y / n * 2 * pi) * 10)
    
    raster_plot <- ggplot(heatmap_data, aes(x = .data$x, y = .data$y, fill = .data$z)) +
      geom_tile() +
      scale_fill_doypa(palette) +
      theme_minimal() +
      labs(title = "Heatmap", fill = "Value") +
      theme(legend.position = "right")
  }
  
  # Arrange the plots
  gridExtra::grid.arrange(bar_plot, scatter_plot, density_plot, raster_plot, nrow = 2)
}

