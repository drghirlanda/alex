#' Drop responses with fast reaction times. All occurring before
#' \code{threshold} ms (default: 100 ms) following trial start are
#' dropped.
#'
#' @param d An alex data frame
#' @param threshold Response threshold
#'
#' @return A copy of the original data frame after dropping the relevant rows 
#' @export
drop.too.fast <- function( d, threshold=100 ) {
  accept <- with( d, is.na(RT) | RT>=threshold )
  message( paste("alex: dropping", sum(!accept),
                 "responses with RT <", threshold, "ms" ) )
  subset( d, accept )
}
