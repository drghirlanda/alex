# a function to build 'Presentation' and 'KeyNum' variables. The first
# is the trial number for a given stimulus and phase, the second
# identifies responses within presentations
presentation.and.keynum <- function( data ) {
  pres <- rep( NA, nrow(data) )
  keynum <- rep( NA, nrow(data) )
  phases <- unique( data$Phase )
  gsubjects <- unique( data$GSubject )
  for( p in phases ) {
    my.phase <- data$Phase == p
    for( s in unique( data$S1 ) ) {
      my.stimulus <- data$S1 == s
      my.trials <- data$Trial[ my.phase & my.stimulus ]
      count <- 1
      for( t in sort( unique(my.trials) ) ) {
        cases <- my.phase & my.stimulus & data$Trial==t 
        r <- sum(cases)
        if( r ) {
          pres[ cases ] <- count
          keynum[ cases ] <- seq( 1, r, 1 )
          count <- count + 1
        }
      }
    }
  }
  keynum[ data$Key=="<timeout>" ] <- 0
  list( Presentation=pres, KeyNum=keynum )
}

# a function to read data output by our PEBL programs
read.alex <- function( data.dir="." ) {
    data <- NULL
    filenames <- dir( paste(data.dir,"/Data",sep=""), full.names=TRUE)
    for( i in grep( "\\.csv$", filenames ) ) {
        print( paste("Reading", filenames[i] ) )
        subject.data <- read.csv( filenames[i] )
        subject.frame <- data.frame( subject.data )
        pk <- presentation.and.keynum( subject.frame )
        subject.frame$Presentation <- pk$Presentation
        subject.frame$KeyNum <- pk$KeyNum
        data <- rbind( data, subject.frame )
    }
    data <- data.frame( data )
    ## add global subject identifier
    data$GSubject <- with( data, paste( Group, Subject, sep="." ) )
    ## make phase an unordered factor
    data$Phase <- factor( data$Phase, ordered=FALSE )
    ## correct sex factor (R reads F as "FALSE")
    data$Sex[ data$Sex != "M" ] <- "F"
    data$Sex <- factor( data$Sex, ordered=FALSE )
    data
}
