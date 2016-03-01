#' Rename experimantal groups in an alex data.table
#'
#' @param d An alex data.table
#' @param gList a list of the form list( new1=old1, new2=old2, ... ) where new1, new2, etc., are new group labels, and old1, old2, etc., are old group labels (scalars or vectors) to be renamed)
#' @return Nothing, the data.table is modified in-place
#' @examples
#' regroup( d, list( Training=c("Training1", "Training2") ) )
#' @export
regroup <- function( d, gList ) {
  d$Group <- as.character( d$Group )
  for( g in names(gList) ) {
    d[ Group %in% gList[[g]], Group := g ]
  }
  d$Group <- as.factor( d$Group )
  d
}
