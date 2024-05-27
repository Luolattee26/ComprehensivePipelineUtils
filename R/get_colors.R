#' get N colors from a certain color list
#'
#' @param colors_number The number of colors you want.
#' @param random_seed random_seed used to sample colors.
#' @param custom_colors If you want to set a custom color list.
#'
#' @return colors_got
#' @export
#'
#' @examples
#' get_colors(5)
#' c("#40E0D0", "#20B2AA", "#808000", "#FFFF00", "#E9967A")
get_colors <- function(colors_number, random_seed = 2028,
                       custom_colors = NULL) {
  allcolour <- c(
    "#DC143C", "#0000FF", "#20B2AA", "#FFA500",
    "#9370DB", "#98FB98", "#F08080", "#1E90FF",
    "#7CFC00", "#FFFF00", "#808000", "#FF00FF",
    "#FA8072", "#7B68EE", "#9400D3", "#800080",
    "#A0522D", "#D2B48C", "#D2691E", "#87CEEB",
    "#40E0D0", "#5F9EA0", "#FF1493", "#0000CD",
    "#008B8B", "#FFE4B5", "#8A2BE2", "#228B22",
    "#E9967A", "#4682B4", "#32CD32", "#F0E68C",
    "#FFFFE0", "#EE82EE", "#FF6347", "#6A5ACD",
    "#9932CC", "#8B008B", "#8B4513", "#DEB887"
  )
  if (!is.null(custom_colors)) {
    allcolour <- custom_colors
  }
  set.seed(random_seed)
  if (colors_number > length(allcolour)) {
    stop("Number of colors u want is larger than colors in database!")
  }
  colors_got <- sample(allcolour,
                       colors_number,
                       replace = F)
  return(colors_got)
}
