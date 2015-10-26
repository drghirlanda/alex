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
    data <- NULL
    filenames <- dir( paste(data.dir,"/Data",sep=""), full.names=TRUE)
    for( i in grep( "\\.csv$", filenames ) ) {
      message( paste("alex: reading", filenames[i] ) )
      subject.data <- read.csv( filenames[i] )
      subject.frame <- data.frame( subject.data )
      pk <- presentation.and.keynum( subject.frame )
      subject.frame$Presentation <- pk$Presentation
      subject.frame$KeyNum <- pk$KeyNum
      data <- rbind( data, subject.frame )
    }
    data <- data.frame( data )
    ## make sure phase factor is ordered as it appears in the data,
    ## rather than alphabetically:
    data$Phase <- factor( data$Phase,
                         levels=unique(as.character(data$Phase)),
                         ordered=TRUE )
    ## add a global subject identifier merging group and subject:
    data$GSubject <- with( data, paste( Group, Subject, sep="." ) )
    ## correct sex factor (R tends to read "F" as "FALSE"):
    data$Sex[ data$Sex != "M" ] <- "F"
    data$Sex <- factor( data$Sex, ordered=FALSE )
    data
}
