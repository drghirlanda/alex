#' Drop responses that occurred during the S2
#'
#' @param d An alex data frame
#'
#' @return A copy of the original data frame after dropping the relevant rows 
#' @export
drop.S2.responses <- function( d ) {
  d2 <- d[ S2ON==TRUE ]
  message(paste("alex: dropped", nrow(d)-nrow(d2), "responses during S2"))
  d2
}
