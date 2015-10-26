#' @export
regroup <- function( d, gList ) {
  d$Group <- as.character( d$Group )
  for( g in names(gList) ) {
    idx <- d$Group %in% gList[[g]]
    d$Group[ idx ] <- g
  }
  d$Group <- as.factor( d$Group )
  d
}
