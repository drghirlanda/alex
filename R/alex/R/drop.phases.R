#' Remove data that come from one or more experimental phases
#'
#' @param d A data frame returned by \code{read.alex}
#' @param unwanted A list of names of experimental phases to be removed
#' @return A data frame without data rows from the unwanted phases
#' @examples
#' my.data <- drop.phases( d, c("Instructions") )
#'
#' @return A copy of the original data frame after dropping the relevant rows 
#' @export
drop.phases <- function( d, unwanted ) {
  d2 <- droplevels( d[ ! Phase %in% unwanted ] )
  message(paste("alex: dropped", nrow(d)-nrow(d2), "data lines in phases:"))
  message( paste("  ", unwanted, collapse="") )
  d2
}
