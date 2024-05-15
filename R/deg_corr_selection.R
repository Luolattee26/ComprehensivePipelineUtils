#' To select DEGs related to iPSC-factors in d2i analysis pipeline.
#'
#' @param corr_list corr.coef list get from corr_rank function
#' @param deg_df deg info get from deseq2 (all cancer types)
#' @param top top n genes to chose
#' @param corr_padj_threshold adjustment p-value threshold for corr.coef
#' @param deg_padj_threshold adjustment p-value threshold for deg test
#' @param test_factor_col column name of test factor (drivers) in corr.coef
#' @param target_factor_col column name of iPSC-factor in corr.coef
#' @param rra_intergration whether use RRA algorithm to integrate LFC&corr ranks
#'
#' @return result list of each cancer types.
#' @export
#'
#' @examples
#' NULL
deg_corr_selection <- function(corr_list, deg_df, top = 15,
                               corr_padj_threshold = 0.05,
                               deg_padj_threshold = 0.01,
                               test_factor_col = "feature_a",
                               target_factor_col = "feature_b",
                               rra_intergration = TRUE) {
  top_by_group_list <- lapply(names(corr_list), function(cancer) {
    tmp_corr <- corr_list[[cancer]]
    tmp_deg <- subset(deg_df, deg_df$cancer_type == cancer)
    tmp_group_list <- split(tmp_corr, tmp_corr[[target_factor_col]])
    top_by_group <- lapply(tmp_group_list, function(df) {
      df <- df[df$p_value < corr_padj_threshold, ]
      df <- df[order(df$abs_corr, decreasing = TRUE), ]
      df_selected <- df[seq_len(min(top, nrow(df))), ]
      tmp_deg_selected <- tmp_deg[match(
        df_selected[[test_factor_col]],
        tmp_deg$Ensembl_ID
      ), ]
      df_selected$log2FoldChange <- tmp_deg_selected$log2FoldChange
      df_selected$padj <- tmp_deg_selected$padj
      df_selected$cancer_type <- tmp_deg_selected$cancer_type

      df_selected <- subset(df_selected, df_selected$padj < deg_padj_threshold)

      df_selected$abs_corr_rank <- rank(-df_selected$abs_corr,
        ties.method = "min"
      )
      df_selected$abs_log2FoldChange_rank <-
        rank(-abs(df_selected$log2FoldChange), ties.method = "min")

      if (rra_intergration) {
        df <- df_selected
        glist <- list(
          abs_corr_rank =
            df[[test_factor_col]][unlist(df$abs_corr_rank)],
          abs_log2FoldChange_rank =
            df[[test_factor_col]][unlist(df$abs_log2FoldChange_rank)]
        )
        if (length(glist[[1]]) == 0 | length(glist[[2]]) == 0) {
          return(df_selected)
        } else {
          ag <- RobustRankAggreg::aggregateRanks(glist)
          ag <- ag[match(df_selected[[test_factor_col]], ag$Name), ]
          df_selected$RRA_score <- ag$Score
          df_selected$Rank <- rank(df_selected$RRA_score, ties.method = "min")
          df_selected <-
            df_selected[order(df_selected$Rank, decreasing = FALSE), ]
          return(df_selected)
        }
      } else {
        return(df_selected)
      }
    })
    return(top_by_group)
  })
  names(top_by_group_list) <- names(corr_list)

  return(top_by_group_list)
}
