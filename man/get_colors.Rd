% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_colors.R
\name{get_colors}
\alias{get_colors}
\title{get N colors from a certain color list}
\usage{
get_colors(colors_number, random_seed = 2028, custom_colors = NULL)
}
\arguments{
\item{colors_number}{The number of colors you want.}

\item{random_seed}{random_seed used to sample colors.}

\item{custom_colors}{If you want to set a custom color list.}
}
\value{
colors_got
}
\description{
get N colors from a certain color list
}
\examples{
get_colors(colors_number = 5, random_seed = 2028, custom_colors = NULL)
}
