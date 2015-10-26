#' @export
drop.ITI <- function( d ) {
  accept <- with( d, S1 != "ITI" )
  message( paste( "alex: dropping", sum(!accept), "ITI data lines" ) )
  droplevels( subset( d, accept ) )
}
