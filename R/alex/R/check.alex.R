check.alex <- function( d ) {
  if( ! "alex" in class(d) ) {
    stop( "alex: not an alex data.table" )
  }
}
