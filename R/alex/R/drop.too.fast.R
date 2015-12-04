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
  d2 <- d[ is.na(RT) | RT>=threshold ]
  message(npaste("alex: dropping", nrow(d)-nrow(d2),                 
                 "responses with RT <", threshold, "ms"))
  d2
}
