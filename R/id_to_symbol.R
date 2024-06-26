#' return gene symbol form gene ensembl ID based genecode V22 annotation
#'
#' @param id_list gene ensembl id list
#'
#' @return Symbol of genes
#' @export
#'
#' @examples
#' library(ComprehensivePipelineUtils)
#' id_to_symbol(c("ENSG00000162444", "ENSG00000130939"))
id_to_symbol <- function(id_list) {
  df <- internal_data_list[["symbol_ID_pairs_based_gencodeV22"]]
  res <- unlist(lapply(id_list, function(x) {
    return(subset(df, df$gene_id == x)$gene_name)
  }))
  return(res)
}
