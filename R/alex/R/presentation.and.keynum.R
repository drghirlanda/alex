#' Build 'Presentation' and 'KeyNum' variables for alex data. The
#' first is the trial number for a given stimulus and phase, the
#' second numbers responses within presentations.
#'
#' @param data An alex data.frame
#' @return A list with Presentation and KeyNum members
#' @examples
#' This function is meant for internal use
presentation.and.keynum <- function( data ) {
  ## create pres and keynum vectors:
  pres <- rep( NA, nrow(data) )
  keynum <- rep( NA, nrow(data) )
  ## get information about phases and subjects:
  phases <- unique( data$Phase )
  gsubjects <- unique( data$GSubject )
  ## loop through all phases, because presentations are calculated
  ## within each phase:
  for( p in phases ) {
    ## selector for this phase:
    my.phase <- data$Phase == p
    ## loop through all stimuli, because presentaions are
    ## stimulus-specific:
    for( s in unique( data$S1 ) ) {
      ## selector for this stimulus:
      my.stimulus <- data$S1 == s
      ## trials for this stimulus and this phase: 
      my.trials <- data$Trial[ my.phase & my.stimulus ]
      ## presentation counter:
      count <- 1
      ## loop through all trials. we cannot use simply 1:max(
      ## my.trials ) because this s1 is not, generally, presented on
      ## all trials:
      for( t in sort( unique(my.trials) ) ) { 
        ## data line selector for this trial:
        cases <- my.phase & my.stimulus & data$Trial==t
        ## number of data lines
        r <- sum(cases) 
        ## if found data lines:
        if( r ) {
          ## all these data lines are for the same presentation:
          pres[ cases ] <- count
          ## but they are keynums 1 through r:
          keynum[ cases ] <- seq( 1, r, 1 )
          ## increment presentation counter:
          count <- count + 1
        }
      }
    }
  }
  ## the above calculations for keynum are incorrect for <timeout>
  ## trials. here the subject never responded, hence we set keynum=0:
  keynum[ data$Key=="<timeout>" ] <- 0
  ## the following assigns to each ITI presentations the same number
  ## as the following stimulus. it relies on the fact that each trial
  ## is preceeded by an ITIs:
  iti <- which( data$S1 == "ITI" )
  pres[ iti ] <- pres[ iti+1 ]
  list( Presentation=pres, KeyNum=keynum )
}
