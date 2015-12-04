#' @export
drop.ITI <- function( d ) {
  d2 <- droplevels( d[ S1 != "ITI" ] )
  message(paste("alex: dropped", nrow(d)-nrow(d2), "ITI data lines"))
  d2
}
