###########################
#                         #
#    COLORS & PALETTES    #
#                         #
###########################

#' doypa color palettes
doypa_palettes <- list(
  `main` = c(
    `pastel_blue` = "#6DB3FC",
    `pastel_violet` = "#CFB7D5",
    `skin` = "#F99690"
  ),
  `tidy` = c(
    `blue` = "#1C4EAA",
    `pumpkin` = "#E36C14",
    `dark_grey` = "#666667",
    `light_blue` = "#ADD8E6",
    `yellow` = "#FBE870"
  ),
  
  `buzz` = c(
    `purple` = "#6036a4",
    `light_green` = "#9de26b",
    `skin` = "#F5C290",
    `broken_white` = "#F8F7F3",
    `grey` = "#B1B3B3",
    `red` = "#FF2400",
    `light_blue` = "#ADD8E6"
  ),
  
  `tokyo` = c(
    `dark_blue` = "#052240",
    `blue` = "#004B6B",
    `wine` = "#750037",
    `pink` = "#FA1593",
    `light_blue` = "#95DEFF"
  )
)


#' Return doypa palettes
#' 
#' @description 
#' Returns all doypa color palettes.
#' 
#' @export
get_doypa_palettes <- function(){
  return(doypa_palettes)
}

#' Plot doypa palettes
#' 
#' @description 
#' Plot all doypa color palettes.
#' 
#' @export
plot_doypa_palettes <- function(){
  doypa.colors <- do.call(c, doypa_palettes)
  palette.names <- c()
  for (i in names(doypa_palettes)){
    palette.names <- c(palette.names, rep(i, length(doypa_palettes[[i]])))
  }
  data <- data.frame(id = palette.names, cols = doypa.colors, value = 1)
  data$id <- factor(data$id, levels = rev(names(doypa_palettes)))
  ggplot(data, aes(fill=cols, y=value, x=id)) +
    geom_bar(position="fill", stat="identity", fill=data$cols, width = 0.9) +
    coord_flip() +
    guides(fill="none") +
    theme(axis.title.x = element_blank(),
          axis.text.x=element_blank(),
          axis.ticks.x=element_blank(),
          axis.title.y = element_blank(),
          axis.text.y = element_text(color="black", size=14, face="bold", hjust = 1),
          axis.ticks.y=element_blank(),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.background = element_blank())
}

#' doypa color palette generator
#' 
#' @description 
#' This is a function to turn the default color schemes
#' into a compatible color palette with ggplot.
#' 
#' @details 
#' See \code{\link[doypa]{get_doypa_palettes}} for detailed
#' information of the color palettes.`
#' 
#' @param palette Character string of the desired palette:
#' \itemize{
#'  \item "main"
#'  \item "tidy"
#'  \item "autumn"
#'  \item "forest"
#'  \item "ocean"
#'  \item "magma"
#'  \item "neon"
#'  \item "luxury"
#'  \item "santapola"
#'  \item "chinatown"
#'  \item "bahamas"
#' }
#' @param ... Additional parameters of grDevices::colorRampPalette
doypa <- function(palette = "main", ...){
  col.pal <- doypa_palettes[[palette]]
  return(grDevices::colorRampPalette(col.pal, ...))
}


#' doypa color generator
#' 
#' @description 
#' This is a function generates a color vector of n colors.
#'
#' @param n Number of colors needed
#' @param palette Character string of the desired palette:
#' \itemize{
#'  \item "main"
#'  \item "tidy"
#'  \item "autumn"
#'  \item "forest"
#'  \item "ocean"
#'  \item "magma"
#'  \item "neon"
#'  \item "luxury"
#'  \item "santapola"
#'  \item "chinatown"
#'  \item "bahamas"
#' }
#' 
#' @examples
#' library(doypa)
#' treatmentColor <- color_doypa(3, palette = "main")
#' boxplot(PlantGrowth$weight ~ PlantGrowth$group, col = treatmentColor)
#' 
#' @export
color_doypa <- function(n, palette = "main") {
  if (!palette %in% names(doypa_palettes)){
    message("WARNING The palette does not exist, it must be one of the following: ", paste0(names(doypa_palettes), collapse = ", "), ".\n'main' will be used instead")
    palette = "main"
  }
  
  if (n < length(get_doypa_palettes()[[palette]])){
    return(get_doypa_palettes()[[palette]][1:n])
  }
  
  return(doypa(palette = palette)(n))
}


#' Fill scale for ggplot2
#' 
#' @description 
#' Scale fill function for \code{\link[ggplot2]{ggplot2}}.
#' 
#' @param palette Character string of the desired palette:
#' \itemize{
#'  \item "main"
#'  \item "tidy"
#'  \item "autumn"
#'  \item "forest"
#'  \item "ocean"
#'  \item "magma"
#'  \item "neon"
#'  \item "luxury"
#'  \item "santapola"
#'  \item "chinatown"
#'  \item "bahamas"
#' }
#' @param discrete Boolean indicating whether generating a
#' discrete or continuous palette (default: generate continuous \code{FALSE}).
#' @param ... Parameters of \code{\link[ggplot2]{discrete_scale}} or
#' \code{\link[ggplot2]{scale_fill_gradientn}}, deppending if discrete
#' is TRUE or FALSE. 
#' 
#' @examples 
#' library(doypa)
#' library(ggplot2)
#' gg <- ggplot(mtcars, aes(x=as.factor(cyl), fill=cyl)) + geom_bar()
#' gg <- gg + + scale_fill_doypa(palette = "main", discrete = F)
#' 
#' @export
scale_fill_doypa <- function(palette = "main", discrete = FALSE, ...){
  if (!palette %in% names(doypa_palettes)){
    message("WARNING The palette does not exist, it must be one of the following: ", paste0(names(doypa_palettes), collapse = ", "), ".\n'main' will be used instead")
    palette = "main"
  }
  
  col.pal <- doypa(palette = palette)
  
  if (discrete){
    ggplot2::discrete_scale("fill", paste0("doypa_", palette), palette = col.pal, ...)
  } else{
    ggplot2::scale_fill_gradientn(colours = col.pal(256), ...)
  }
}


#' Color scale for ggplot2
#' 
#' @description 
#' Scale color function for \code{\link[ggplot2]{ggplot2}}.
#' 
#' @param palette Character string of the desired palette:
#' \itemize{
#'  \item "main"
#'  \item "tidy"
#'  \item "autumn"
#'  \item "forest"
#'  \item "ocean"
#'  \item "magma"
#'  \item "neon"
#'  \item "luxury"
#'  \item "santapola"
#'  \item "chinatown"
#'  \item "bahamas"
#' }
#' @param discrete Boolean indicating whether generating a
#' discrete or continuous palette (default: generate continuous \code{FALSE}).
#' @param ... Parameters of \code{\link[ggplot2]{discrete_scale}} or
#' \code{\link[ggplot2]{scale_fill_gradientn}}, deppending if discrete
#' is TRUE or FALSE. 
#' 
#' @examples 
#' library(doypa)
#' library(ggplot2)
#' gg <- ggplot(mtcars, aes(x=as.factor(cyl), color=cyl)) + geom_bar()
#' gg <- gg + + scale_color_doypa(palette = "main", discrete = F)
#' 
#' @export
scale_color_doypa <- function(palette = "main", discrete = FALSE, ...){
  if (!palette %in% names(doypa_palettes)){
    message("WARNING The palette does not exist, it must be one of the following: ", paste0(names(doypa_palettes), collapse = ", "), ".\n'main' will be used instead")
    palette = "main"
  }
  
  col.pal <- doypa(palette = palette)
  
  if (discrete){
    ggplot2::discrete_scale("colour", paste0("doypa_", palette), palette = col.pal, ...)
  } else{
    ggplot2::scale_color_gradientn(colours = col.pal(256), ...)
  }
}
