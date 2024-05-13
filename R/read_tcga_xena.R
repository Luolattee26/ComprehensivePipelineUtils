#' Read TCGA mRNA profile from Xena platform in a dir
#'
#' @param folder_path the dir path of TCGA data
#' @param file_pattern file name pattern of TCGA data
#' @param use_all_cores whether use full cores
#' @param cores cores number to use
#'
#' @return list of data and file path
#' @export
#'
#' @examples
#' NULL
read_tcga_xena <- function(folder_path, file_pattern = "*.tsv",
                           use_all_cores = FALSE, cores = 4) {
  files <- list.files(folder_path, full.names = TRUE, pattern = file_pattern)
  file_names <- lapply(list.files(folder_path), function(x) {
    strsplit(x, "\\.")[[1]][1]
  })

  pb <- utils::txtProgressBar(min = 0, max = length(files), style = 3)

  if (use_all_cores) {
    doParallel::registerDoParallel(cores = parallel::detectCores())
  } else {
    doParallel::registerDoParallel(cores = cores)
  }

  i <- files
  result <- foreach::foreach(
    i = seq_along(i)
  ) %dopar% {
    utils::setTxtProgressBar(pb, i)
    list(
      file = files[i],
      data = read.table(files[i],
        header = TRUE,
        sep = "\t", check.names = FALSE
      )
    )
  }

  close(pb)

  names(result) <- file_names
  return(result)
}
