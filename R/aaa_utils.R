#' Exclude NULL elements from a list
#' @note adapted by
#' \url{https://github.com/rstudio/leaflet/blob/master/R/utils.R}
#' @param x A list whose NULL elements will be filtered
#' @export
nonull <- function(x) {
  if (length(x) == 0 || !is.list(x)) return(x)
  x[!unlist(lapply(x, is.null))]
}

