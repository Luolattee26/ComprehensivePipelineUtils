% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/deg_corr_selection.R
\name{deg_corr_selection}
\alias{deg_corr_selection}
\title{To select DEGs related to iPSC-factors in d2i analysis pipeline.}
\usage{
deg_corr_selection(
  corr_list,
  deg_df,
  top = 15,
  corr_padj_threshold = 0.05,
  deg_padj_threshold = 0.01,
  test_factor_col = "feature_a",
  target_factor_col = "feature_b",
  rra_intergration = TRUE
)
}
\arguments{
\item{corr_list}{corr.coef list get from corr_rank function}

\item{deg_df}{deg info get from deseq2 (all cancer types)}

\item{top}{top n genes to chose}

\item{corr_padj_threshold}{adjustment p-value threshold for corr.coef}

\item{deg_padj_threshold}{adjustment p-value threshold for deg test}

\item{test_factor_col}{column name of test factor (drivers) in corr.coef}

\item{target_factor_col}{column name of iPSC-factor in corr.coef}

\item{rra_intergration}{whether use RRA algorithm to integrate LFC&corr ranks}
}
\value{
result list of each cancer types.
}
\description{
To select DEGs related to iPSC-factors in d2i analysis pipeline.
}
\examples{
NULL
}
