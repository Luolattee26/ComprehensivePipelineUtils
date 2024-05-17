
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ComprehensivePipelineUtils

<!-- badges: start -->

[![R-CMD-check](https://github.com/Luolattee26/ComprehensivePipelineUtils/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/Luolattee26/ComprehensivePipelineUtils/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of ComprehensivePipelineUtils is to package some useful code
tools.

- The name of this tool is a result of my personal indulgence.
- Please don’t mind it :D

## Installation

You can install the development version of ComprehensivePipelineUtils
from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("Luolattee26/ComprehensivePipelineUtils")
```

## Example

This is a basic example how to use
CPU_toolkit(ComprehensivePipelineUtils):

``` r
library(ComprehensivePipelineUtils)
## basic example code
```

``` r
tcga.data <- read_tcga_xena(folder_path = 'path/to/xena_data',
                            file_pattern = '*.tsv',
                            use_all_cores = TRUE)
```

- This function `read_tcga_xena` will return a list of data (tcga.data).
- The names(tcga.data) will in the pattern `TCGA-XXXX`.
- Each element in the list is a dataframe.
- Each column in the dataframe is a case sample and each row is a mRNA
  (feature).
- It is recommended that users use all CPUs to improve performance.

``` r
tumor.data <- tcga_sample_filter(tcga.data)[["tumor"]]
tumor.data <- fpkm_to_tpm(
  data_list = tumor.data,
  is_logged = TRUE,
  get_logged = TRUE
)
```

- You can use the data get from function `read_tcga_xena` to get tumor
  data.
- And change it into `tpm` or `log2(tpm + 1)`.

## Code of Conduct

Please note that the ComprehensivePipelineUtils project is released with
a [Contributor Code of
Conduct](https://contributor-covenant.org/version/2/1/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
