#' Get tumor&normal samples from mixed TCGA data
#'
#' @param data_list list of TCGA datasets
#' @param method sample selection method
#'
#' @return A list of tumor and normal samples
#' @export
#'
#' @examples
#' NULL
tcga_sample_filter <- function(data_list, method = "best") {
  mask_tumor <- lapply(data_list, function(x) {
    tmp_data <- x
    tmp_msk <- unlist(lapply(colnames(tmp_data)[2:ncol(tmp_data)], function(x) {
      label <- strsplit(x, "-")[[1]][4]
      if (method == "best") {
        if (label == "01A") {
          return(TRUE)
        } else {
          return(FALSE)
        }
      } else if (method == "all") {
        if (grepl("01", label)) {
          return(TRUE)
        } else {
          return(FALSE)
        }
      }
    }))
    tmp_msk <- c(TRUE, tmp_msk)
    tmp_data <- tmp_data[tmp_msk]
    return(tmp_data)
  })
  names(mask_tumor) <- names(data_list)

  mask_normal <- lapply(data_list, function(x) {
    tmp_data <- x
    tmp_msk <- unlist(lapply(colnames(tmp_data)[2:ncol(tmp_data)], function(x) {
      label <- strsplit(x, "-")[[1]][4]
      if (method == "best") {
        if (label == "11A") {
          return(TRUE)
        } else {
          return(FALSE)
        }
      } else if (method == "all") {
        if (grepl("11", label)) {
          return(TRUE)
        } else {
          return(FALSE)
        }
      }
    }))
    tmp_msk <- c(TRUE, tmp_msk)
    tmp_data <- tmp_data[tmp_msk]
    return(tmp_data)
  })
  names(mask_normal) <- names(data_list)

  res <- list(tumor = mask_tumor, normal = mask_normal)

  return(res)
}
