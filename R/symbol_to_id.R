#' return gene ensembl ID form gene symbol based genecode V22 annotation
#'
#' @param symbol_list gene symbol list
#'
#' @return ensembl gene IDs
#' @export
#'
#' @examples
#' library(ComprehensivePipelineUtils)
#' symbol_to_id(c("H19", "HOTAIR"))
symbol_to_id <- function(symbol_list) {
  df <- internal_data_list[["symbol_ID_pairs_based_gencodeV22"]]
  res <- unlist(lapply(symbol_list, function(x) {
    return(subset(df, df$gene_name == x)$gene_id)
  }))
  return(res)
}
