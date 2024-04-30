# DOYPAColors utils

#' List Available DOYPAColors Color Palettes
#' 
#' @description 
#' This function provides a list of all available DOYPAColors color palettes, categorized by type: sequential, diverging, and qualitative.
#' 
#' @return A named list containing the names of available color palettes for each type.
#' @export
#' 
#' @import ggplot2
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
#' This function generates a visual preview of DOYPAColors color palettes, facilitating the exploration and selection of color schemes for your data visualizations.
#' 
#' @param type Character string specifying the type of palettes to preview: "all", "seq" (sequential), "div" (diverging), or "qual" (qualitative).
#' @param colorblind Logical. If 'TRUE', restricts the palettes to those suitable for colorblind individuals.
#' @return A 'ggplot' visualization of DOYPAColors color palettes for exploring and selecting color schemes in your data visualizations.
#' @export
#' @examples
#' # Preview all available DOYPAColors palettes
#' preview_doypa_pals()
#' 
#' # Preview sequential DOYPAColors palettes
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
#' This function generates a visual preview of a single color palette, allowing you to explore and select color schemes for your data visualizations.
#' 
#' @param colors A vector of colors to preview.
#' @return A 'ggplot' visualization of a color palette for exploring and selecting color schemes in your data visualizations.
#' @export
#' 
#' @import ggplot2
#' 
#' @examples
#' # Preview a custom vector of colors
#' custom_colors <- c("#FF5733", "#33FF57", "#5733FF")
#' preview_pal(colors = custom_colors)
#' 
#' # Preview default DOYPAColors palettes
#' preview_pal(doypa("buzz"))
preview_pal <- function(colors = NULL){
  if (is.null(colors)) {
    return(ggplot())
  }
  
  doypa_colors <- colors
  palette_names <- "DOYPAColors"
  lvl <- "DOYPAColors"
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
