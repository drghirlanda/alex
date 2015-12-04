#' @export
drop.ITI.responders <- function( d, threshold, drop=TRUE ) {
  d[ , x := sum(S1=="ITI"), by=GSubject ]
  d[ , y := sum(S1!="ITI"), by=GSubject ]
  bad <- unique( d[ x/y > threshold, GSubject ] )
  d[ , (c("x","y")):=NULL ]
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
      d <- d[ ! GSubject %in% bad ]
    }
  } else {
    message( "alex: no subjects to drop" )
  }
  d
}
