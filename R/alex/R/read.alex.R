#' Read alex data residing in a Data directory under \code{data.dir}. Presentation
#' and a KeyNum variables are added. The first is the number of the current presentation
#' for the current stimulus (as opposed to Trial, which spans across stimuli). The second is
#' the number of the current response in the current trial. See the alex manual (look for
#' AlexManual.pdf in your alex installation, or use the command alex-manual, or look online
#' at http://github.com/drghirlanda/alex).
#'
#' @param data.dir The directory where Data is found (default: the working directory)
#' @return a data frame containing all read data
#' @examples
#' my.data <- read.alex()
#' my.data <- read.alex( "Some/Directory" )
#' @export
read.alex <- function( data.dir=getwd() ) {
  filenames <- dir( paste(data.dir,"/Data",sep=""), full.names=TRUE)
  data <- foreach( i = grep( "\\.csv$", filenames ), .combine=rbind ) {
    subject.data <- read.csv( filenames[i] )
    subject.table <- data.table( subject.data )
    pk <- presentation.and.keynum( subject.table )
    subject.table[ , Presentation := pk$Presentation ]
    subject.table[ , KeyNum := pk$KeyNum ]
    data <- rbind( data, subject.table )
  }
  data <- data.table( data )
  ## make sure phase factor is ordered as it appears in the data,
  ## rather than alphabetically:
  data$Phase <- factor( data$Phase,
                       levels=unique(as.character(data$Phase)),
                       ordered=TRUE )
  ## add a global subject identifier merging group and subject:
  data[ , GSubject := paste(Group, Subject, sep=".") ]
  ## correct sex factor (R tends to read "F" as "FALSE"):
  data[ Sex!="M", Sex := "F" ]
  data[ , Sex := factor( Sex, ordered=FALSE ) ]
  data
}
