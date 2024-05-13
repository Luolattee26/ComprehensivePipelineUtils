#' From FPKM to TPM
#'
#' @param data_list FPKM data list
#' @param is_logged whther FPKM data is in log(X + 1) unit
#' @param get_logged whther to get TPM data in log(X + 1) unit
#'
#' @return TPM data list
#' @export
#'
#' @examples
#' NULL
fpkm_to_tpm <- function(data_list, is_logged = TRUE, get_logged = TRUE) {
  fpkm_2_tpm <- function(fpkm) {
    fpkm / sum(fpkm) * 1e6
  }

  res <- lapply(data_list, function(x) {
    if (is_logged) {
      message("the input data is log2(fpkm + 1)")
      id_info <- x[1]
      tmp_data <- x[-1]
      tmp_data <- 2^tmp_data - 1
    } else {
      message("the input data is fpkm")
      id_info <- x[1]
      tmp_data <- x[-1]
    }

    # transformation
    if (get_logged) {
      message("the output data is log2(tpm + 1)")
      tmp_data <- as.data.frame(log2(apply(tmp_data, 2, fpkm_2_tpm) + 1))
    } else {
      message("the output data is tpm")
      tmp_data <- as.data.frame(apply(tmp_data, 2, fpkm_2_tpm))
    }

    tmp_data <- cbind(id_info, tmp_data)
    return(tmp_data)
  })

  return(res)
}
