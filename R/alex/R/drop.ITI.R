#' Drop ITI trials from an alex data.table
#'
#' @param d An alex data.table
#' @return An alex data.table with ITI rows removed 
#' @export
drop.ITI <- function( d ) {
  accept <- d[ , S1 != "ITI" ]
  message( paste( "alex: dropping", sum(!accept), "ITI data lines" ) )
  droplevels( d[ accept ] )
}
