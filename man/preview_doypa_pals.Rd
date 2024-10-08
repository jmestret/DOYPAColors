% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{preview_doypa_pals}
\alias{preview_doypa_pals}
\title{Preview DOYPAColors Palettes}
\usage{
preview_doypa_pals(type = "all", colorblind = FALSE)
}
\arguments{
\item{type}{Character string specifying the type of palettes to preview. Options are: "all" (default), "seq" (sequential), "div" (diverging), or "qual" (qualitative).}

\item{colorblind}{Logical. If `TRUE`, restricts the preview to palettes designed with colorblind individuals in mind.}
}
\value{
A `ggplot` visualization displaying the DOYPAColors color palettes, facilitating exploration and selection of color schemes for data visualizations.
}
\description{
This function generates a visual preview of DOYPAColors color palettes. It helps users explore and select color schemes for their data visualizations by displaying each palette in a grid format.
}
\examples{
# Preview all available DOYPAColors palettes
preview_doypa_pals()

# Preview only sequential DOYPAColors palettes
preview_doypa_pals(type = "seq")

# Preview colorblind-friendly DOYPAColors palettes
preview_doypa_pals(colorblind = TRUE)
}
