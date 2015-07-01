# a function to build 'Presentation' and 'KeyNum' variables. The first
# is the trial number for a given stimulus and phase, the second
# identifies responses within presentations
presentation.and.keynum <- function( data ) {
  pres <- rep( NA, nrow(data) )
  keynum <- rep( NA, nrow(data) )
  n.subjects <- max( data$Subject )
  phases <- unique( data$Phase )
  for( p in phases ) {
    my.phase <- data$Phase == p
    for( s in unique( data$S1 ) ) {
      my.stimulus <- data$S1 == s
      my.trials <- data$Trial[ my.phase & my.stimulus ]
      count <- 1
      for( t in unique(my.trials) ) {
        cases <- my.phase & my.stimulus & data$Trial == t 
        pres[ cases ] <- count
        keynum[ cases ] <- seq( 1, sum(cases), 1 )
        count <- count + 1
      }
    }
  }
  list( Presentation=pres, KeyNum=keynum )
}

# a function to read data output by our PEBL programs
read.alex <- function( data.dir="." ) {
    data <- NULL
    filenames <- dir( paste(data.dir,"/Data",sep=""), full.names=TRUE)
    for( i in grep( "\\.csv$", filenames ) ) {
        print( paste("Reading", filenames[i] ) )
        subject.data <- read.csv( filenames[i] )
        data <- rbind( data, subject.data )
    }
    data <- data.frame( data )
    ## make phase an unordered factor
    data$Phase <- factor( data$Phase, ordered=FALSE )
    ## correct sex factor (R reads F as "FALSE")
    data$Sex[ data$Sex != "M" ] <- "F"
    data$Sex <- factor( data$Sex, ordered=FALSE )
    ## add presentation variable
    pk <- presentation.and.keynum( data )
    data$Presentation <- pk$Presentation
    data$KeyNum <- pk$KeyNum
    data
}
