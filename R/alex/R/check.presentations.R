## this function checks that all subjects has seen all stimuli the
## same number of times. if this is supposed to be true, it helps
## catch aborted experiments.
#' @export
check.presentations <- function( d ) {
  ## get max number of presentations per stimulus, phase, and subject:
  t <- aggregate( Presentation ~ S1 + Phase + GSubject, data=d, max )
  t <- t[ , c(3,2,1,4) ] # reorder so that GSubject is first:
  bad <- c() # list of bad subjects
  for( s in unique( t$S1 ) ) { # for all stimuli
    for( p in unique( t$Phase ) ) { # for all phases
      u <- subset( t, S1==s & Phase==p ) 
      if( nrow(u) ) { # if stimulus presented in this phase, check
                      # whether there are subjects that have seen it
                      # fewer times:
        idx <- u$Presentation != max(u$Presentation) 
        if( sum(idx) ) {
          bad <- c( bad, unique( u$GSubject[idx] ) )
        }
      }
    }
  }
  ## if 'bad' subjects found, display some info:
  if( length(bad) ) {
    for( b in unique( bad ) ) {
      message(paste( "alex: subject", b,
                    "has fewer stimulus presentations:" ))
      print( subset( t, GSubject==b ) ) # all data for this subject
    }
  }
  ## return for furhter processing:
  bad
}
