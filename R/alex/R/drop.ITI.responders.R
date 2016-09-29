#' Remove participants responding too often during inter-trial
#' intervals (ITIs), whih potentially signals lack of attention
#' to the experiment).
#'
#' @param d An alex data.table
#' @param threshold Fraction of ITI trials above which a participant is flagged for removal
#' @param drop If TRUE, the flagged participants are removed, if FALSE they are not
#' @return With drop=TRUE, return the data.table after removing all rows pertaining to the flagged participants. When drop=FALSE, return the original data.table
#' @export
drop.ITI.responders <- function( d, threshold, drop=TRUE ) {
  temp <- d
  if( ! require(car) ) {
    stop( "alex: drop.ITI.responders requires the 'car' package" )
  }
  temp$S1 <- recode( temp$S1, "'ITI'='ITI'; else='S'" )
  print( iti.table )
  iti.table <- with( temp, table( GSubject, S1 ) )
  r <- iti.table[,1] / iti.table[,2]
  bad <- rownames(iti.table)[ r > threshold ]
  if( length(bad) ) {
    if( drop ) {
      message( "alex: dropping subjects:" )
    } else {
      message( "alex: these subjects would be dropped:" )
    }      
    for( b in bad ) {
      message( paste( b, paste(iti.table[b,], collapse=" ") ) )
    }
    if( drop ) {
      d <- subset( d, ! GSubject %in% bad ) 
    }
  } else {
    message( "alex: no subjects to drop" )
  }
  d
}
