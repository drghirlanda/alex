#' Build 'Presentation' and 'KeyNum' variables for alex data. The
#' first is the trial number for a given stimulus and phase, the
#' second numbers responses within presentations.
#'
#' @param data An alex data.table
#' @return Nothing, the original data.table is modified in place to have KeyNum and Presentation variables
#' @examples
#' This function is meant for internal use
#' @export
presentation.and.keynum <- function( dt ) {
  require(data.table)
  if( !is.alex( dt ) ) {
    stop("alex: argument does not seem to be an alex data.table")
  }
  for( p in unique(dt$Phase) ) {
    for( s in setdiff(unique(dt[ Phase==p, S1 ]), "ITI") ) {
      dt[ Phase==p & S1==s, Presentation := .GRP, by=Trial ]
      dt[ Phase==p & S1==s, KeyNum := 1:.N, by=Trial ]
    }
  }
  dt[ Key=="<timeout>", KeyNum:=0 ]
  ## the following assigns to each ITI presentations the same number
  ## as the following stimulus. it relies on the fact that each trial
  ## is preceeded by an ITIs:
  i <- which( dt$S1=="ITI" )
  dt[ i, Presentation := dt$Presentation[ i+1 ] ]
  return()
}
