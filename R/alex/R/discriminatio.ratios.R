#' @export
discrimination.ratios <- function( pos, neg, data ) {
  gs <- unique( data$GSubject )
  dr <- vector( mode="numeric", length(gs) )
  names(dr) <- gs
  for( s in gs ) {
    pos.data <- subset( data, GSubject==s & S1 %in% pos )
    pos.data <- aggregate( KeyNum ~ Presentation, pos.data, max )
    p <- mean( pos.data$KeyNum )
    neg.data <- subset( data, GSubject==s & S1 %in% neg )
    neg.data <- aggregate( KeyNum ~ Presentation, neg.data, max )
    n <- mean( neg.data$KeyNum )
    dr[[s]] <- p / (p + n)
  }
  dr
}
