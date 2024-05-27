#' To calculate corr.coef between 2 feature lists
#'
#' @param data_list data list of sample-feature
#' @param a_list feature list 1 (in Ensemble ID)
#' @param b_list feature list 2 (in Ensemble ID)
#' @param method method used to get corr.coef (pearson or spearman)
#' @param adj_method method to adjust p-value
#'
#' @return result list of corr.coef data frame
#' @export
#'
#' @examples
#' NULL
corr_rank <- function(data_list, a_list, b_list,
                      method = "pearson", adj_method = "BH") {
  res <- lapply(data_list, function(x) {
    # pre-process
    tmp_data <- x
    tmp_data[, 1] <- unlist(lapply(tmp_data[, 1], function(x) {
      strsplit(x, "\\.")[[1]][1]
    }))
    rownames(tmp_data) <- tmp_data[, 1]
    tmp_data <- tmp_data[-1]

    # init result df
    df_result <- data.frame(
      feature_a = character(),
      feature_b = character(),
      correlation = numeric(),
      p_value = numeric(),
      stringsAsFactors = FALSE
    )

    # use Hmisc::rcorr to calculate correlation
    feature_list_mixed <- c(unlist(a_list), unlist(b_list))
    data_mat <- t(as.matrix(tmp_data[feature_list_mixed, ]))
    cor_res <- Hmisc::rcorr(data_mat, type = method)
    cor_mat <- as.data.frame(cor_res$r)
    p_mat <- as.data.frame(cor_res$P)

    # for loop to summarize the result
    for (feature_a in a_list) {
      for (feature_b in b_list) {
        df_result <- rbind(df_result, data.frame(
          feature_a = feature_a,
          feature_b = feature_b,
          correlation = cor_mat[feature_a, feature_b],
          p_value = p_mat[feature_a, feature_b],
          stringsAsFactors = FALSE
        ))
      }
    }

    # pvalue adjustment
    df_result$p_value <- stats::p.adjust(df_result$p_value, method = adj_method)
    # get abs corr.coef
    df_result$abs_corr <- abs(df_result$correlation)

    return(df_result)
  })

  return(res)
}
