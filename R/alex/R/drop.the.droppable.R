#' Combines \code{drop.phases}, \code{drop.S2.responses},
#' \code{drop.ITI}, and \code{drop.too.fast}
#'
#' @param d An alex data frame
#' @param phases A list of phases for \code{drop.phases}
#' @param rt Reaction time threshold (see \code{drop.too.fast})
#' @param iti Drop responses during ITI if \code{TRUE}
#'
#' @return A copy of the original data frame after dropping the relevant rows 
#' @export
drop.the.droppable <- function( d, phases=c(), rt=100, iti=TRUE ) {
  d <- drop.phases( d, phases )
  d <- drop.S2.responses( d )
  if( iti ) {
    d <- drop.ITI( d )
  }
  d <- drop.too.fast( d, rt )
  d
}
