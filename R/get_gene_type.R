#' return gene type form gene ensembl ID based genecode V22 annotation
#'
#' @param genes Genes of interest
#' @param input_type Symbol or ensembl ID
#'
#' @return Gene types
#' @export
#'
#' @examples
#' library(ComprehensivePipelineUtils)
#' get_gene_type(c("H19", "HOTAIR"))
get_gene_type <- function(genes, input_type = "ID") {
  if (!(input_type %in% c("ID", "Symbol"))) {
    stop("The genes input must in gene ID or Symbol")
  }
  if (input_type == "Symbol") {
    genes <- ComprehensivePipelineUtils::symbol_to_id(genes)
  }

  df <- internal_data_list[["type_ID_pairs_based_gencodeV22"]]
  k <- df$gene_id %in% genes
  types <- unlist(df[k, ]$gene_type)

  return(types)
}
