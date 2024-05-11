#' return gene ensembel ID form gene symbol based genecode V22 annotation
#'
#' @param Symbol_list
#'
#' @return res
#' @export
#'
#' @examples
#' library(ComprehensivePipelineUtils)
#' Symbol2ID(c('H19', 'HOTAIR'))
Symbol2ID <- function(Symbol_list) {
  load('data/symbol_ID_pairs_based_gencodeV22.rda')
  res <- unlist(lapply(Symbol_list, function(x) {
    return(subset(symbol_ID_pairs_based_gencodeV22, gene_name == x)$gene_id)
  }))
  return(res)
}

