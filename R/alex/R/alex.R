# a function to build 'Presentation' and 'KeyNum' variables. The first
# is the trial number for a given stimulus and phase, the second
# identifies responses within presentations
presentation.and.keynum <- function( data ) {
  pres <- rep( NA, nrow(data) )
  keynum <- rep( NA, nrow(data) )
  phases <- unique( data$Phase )
  gsubjects <- unique( data$GSubject )
  for( gs in gsubjects ) {
    my.gsubject <- data$GSubject == gs
    for( p in phases ) {
      my.phase <- data$Phase == p
      for( s in unique( data$S1 ) ) {
        my.stimulus <- data$S1 == s
        my.trials <- data$Trial[ my.phase & my.stimulus ]
        count <- 1
        for( t in sort( unique(my.trials) ) ) {
          cases <- my.gsubject & my.phase & my.stimulus & data$Trial==t 
          r <- sum(cases)
          if( r ) {
            pres[ cases ] <- count
            keynum[ cases ] <- seq( 1, r, 1 )
            count <- count + 1
          }
        }
      }
    }
  }
  keynum[ data$Key=="<timeout>" ] <- 0
#  print( rep("-", 10) )
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
    ## add global subject identifier
    data$GSubject <- with( data, paste( Group, Subject, sep="." ) )
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
