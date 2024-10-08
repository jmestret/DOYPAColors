% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{preview_pal}
\alias{preview_pal}
\title{Preview a Single Color Palette}
\usage{
preview_pal(palette, seed = NULL)
}
\arguments{
\item{palette}{A character string specifying the name of the palette to use.}

\item{seed}{An optional seed for reproducibility of random numbers.}
}
\value{
A `ggplot` object with multiple plots arranged in a grid, showcasing the color palette in different visualizations.
}
\description{
This function generates a visual preview of a DOYPAColors palette with multiple plots. It includes a direct palette preview, a scatter plot, a bar plot, and a heatmap, each using the specified palette.
}
\examples{
# Preview a DOYPAColors palette with multiple plots
preview_pal(palette = "buzz")
}
