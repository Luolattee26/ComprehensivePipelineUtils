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

    # for loop to calculation
    lapply(a_list, function(feature_a) {
      data_a <- as.numeric(tmp_data[feature_a, ])
      lapply(b_list, function(feature_b) {
        data_b <- as.numeric(tmp_data[feature_b, ])
        test <- stats::cor.test(data_a, data_b,
          method = method
        )
        df_result <- rbind(df_result, data.frame(
          feature_a = feature_a,
          feature_b = feature_b,
          correlation = test$estimate,
          p_value = test$p.value,
          stringsAsFactors = FALSE
        ))
      })
    })

    # pvalue adjustment
    df_result$p_value <- stats::p.adjust(df_result$p_value, method = adj_method)
    # get abs corr.coef
    df_result$abs_corr <- abs(df_result$correlation)

    return(df_result)
  })

  return(res)
}
