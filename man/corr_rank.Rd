% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/corr_rank.R
\name{corr_rank}
\alias{corr_rank}
\title{To calculate corr.coef between 2 feature lists}
\usage{
corr_rank(data_list, a_list, b_list, method = "pearson", adj_method = "BH")
}
\arguments{
\item{data_list}{data list of sample-feature}

\item{a_list}{feature list 1 (in Ensemble ID)}

\item{b_list}{feature list 2 (in Ensemble ID)}

\item{method}{method used to get corr.coef (pearson or spearman)}

\item{adj_method}{method to adjust p-value}
}
\value{
result list of corr.coef data frame
}
\description{
To calculate corr.coef between 2 feature lists
}
\examples{
NULL
}
