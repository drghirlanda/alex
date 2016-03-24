#' Read alex data residing in a Data directory under \code{data.dir}. Presentation
#' and KeyNum variables are added. The first is the number of the current presentation
#' for the current stimulus (as opposed to Trial, which spans across stimuli). The second is
#' the number of the current response in the current trial. See the alex manual (look for
#' AlexManual.pdf in your alex installation, or use the command alex-manual, or look online
#' at http://github.com/drghirlanda/alex). A GSubject (global subject) identified is also added
#' by merging group and subject identifiers.
#'
#' @param data.dir The directory where the alex Data folder resides (default: the working directory)
#' @return a data.table containing all read data
#' @examples
#' my.data <- read.alex()
#' my.data <- read.alex( "Some/Directory" )
#' @import data.table
#' @export
read.alex <- function( data.dir=getwd() ) {
  dt <- NULL
  filenames <- dir( paste(data.dir,"/Data",sep=""), full.names=TRUE)
  for( i in grep( "\\.csv$", filenames ) ) {
    message( paste("alex: reading", basename(filenames[i]) ) )
    subject.dt <- data.table( read.csv( filenames[i] ) )
    ## R reads F as FALSE but we mean 'female'
    if( is.logical( subject.dt$Sex ) ) {
      subject.dt[ , Sex := NULL ]
      subject.dt[ , Sex := "F" ]
    }
    setattr( subject.dt, "alex", TRUE )
    presentation.and.keynum( subject.dt )
    dt <- rbind( dt, subject.dt )
  }
  dt <- as.data.table( dt )
  ## make sure phase factor is ordered as it appears in the data,
  ## rather than alphabetically:
  dt$Phase <- factor( dt$Phase,
                     levels=unique(as.character(dt$Phase)),
                     ordered=TRUE )
  ## but issue a warning if different subjects have different orders:
  if( "PhaseOrder" %in% names(dt) ) {
    if( length(unique(dt$PhaseOrder)) > 1 ) {
      warning( "alex: different subjects have different phase orders:" )
      warning( "alex: phases cannot be uniquely ordered" )
      warning( "alex: (this is fine if intended!)" )
    }
  }
  ## add a global subject identifier merging group and subject:
  dt[ , GSubject := paste( Group, Subject, sep="." ) ]
  dt
}
