# a function to build a 'presentation' variable that counts the number
# of times any given stimulus has been presented, for each phase of
# the experiment.
alex.presentation <- function( data ) {
    pres <- rep( NA, nrow(data) )
    
    n.subjects <- max( data$Subject )
    phases <- unique( data$Phase )

    for( p in phases ) {
        my.phase <- subset( data, Phase==p )
        my.cs <- with( subset( data, my.phase, Stimulus )
        for( s in stimuli ) {
            trials <- with( subset( data, my.phase & my.cs ), Trial )
            count <- 1
            for( t in unique(trials) ) {
                cases <- my.phase & my.cs & data$Trial == t 
                pres[ cases ] <- count
                count <- count + 1
            }
        }
    }

    pres
}

# a function to read data output by our PEBL programs
alex.read <- function( data.dir="." ) {
    data <- NULL
    filenames <- dir( paste(data.dir,"/Data",sep=""), full.names=TRUE)
    for( i in grep( "\\.dat$", filenames ) ) {
        subject.data <- read.table( filenames[i], head=TRUE )
        data <- rbind( data, subject.data )
    }
  data <- data.frame( data )
  ## make phase an unordered factor
  data$Phase <- factor( data$Phase, ordered=FALSE )
  ## correct sex factor (R reads F as "FALSE")
  data$Sex[ data$Sex != "M" ] <- "F"
  data$Sex <- factor( data$Sex, ordered=FALSE )
  data$Presentation <- alex.presentation( data )
  data
}

