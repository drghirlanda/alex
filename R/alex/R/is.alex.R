#' Check whether an object is an alex data.table
#'
#' @param d an R object
#' @return TRUE/FALSE
#' @export
is.alex <- function( d ) {
  if( "data.table" %in% class(d) & attr(d,"alex")==TRUE ) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}
