#' return gene symbol form gene ensembel ID based genecode V22 annotation
#'
#' @param ID_list
#'
#' @return res
#' @export
#'
#' @examples
#' library(ComprehensivePipelineUtils)
#' ID_2_Symbol(c("ENSG00000162444", "ENSG00000130939"))
ID_2_Symbol <- function(ID_list) {
  load("data/symbol_ID_pairs_based_gencodeV22.rda")
  res <- unlist(lapply(ID_list, function(x) {
    return(subset(symbol_ID_pairs_based_gencodeV22, gene_id == x)$gene_name)
  }))
  return(res)
}
