#' Drop responses that occurred during the S2
#'
#' @param d An alex data frame
#'
#' @return A copy of the original data frame after dropping the relevant rows 
#' @export
drop.S2.responses <- function( d ) {
  accept <- with( d, S2On==FALSE )
  message( paste("alex: dropping", sum(!accept),
                 "responses during S2" ) )
  subset( d, accept )
}
