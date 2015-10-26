#' Calculate mean response rates per S1, Group, Presentation, and Phase
#'
#' @param d An alex data frame
#' @return A data frame with Rate and RateSE columns added, the second
#'   being the standard error of the response rate
#' @examples
#' d <- read.alex()
#' r <- mean.response.dates( d )
#' @export
response.rates <- function( d ) {
  ## we first aggregate preserving subject identity and using max to
  ## get the number of responses to a given stimulus in a
  ## presentation:
  d <- aggregate( I(1000*KeyNum/S1Duration) ~
                 S1 + Group + Presentation + Phase + GSubject,
                 max,
                 data=d )
  names( d )[ length(names(d)) ] <- "Rate"
  r <- aggregate( Rate ~ S1 + Group + Presentation + Phase, mean,
                 data=d )
  rate.se <- aggregate( Rate ~ S1 + Group + Presentation + Phase,
                       function(x){ sd(x)/sqrt(length(x)-1) },
                       data=d )
  r$RateSE <- rate.se$Rate
  r
}
