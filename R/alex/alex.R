# a function to build a 'presentation' variable that counts the number
# of times any given stimulus has been presented, for each phase of
# the experiment.
alex.presentation <- function( data ) {
    pres <- rep( NA, nrow(data) )
    n.subjects <- max( data$Subject )
    phases <- unique( data$Phase )
    for( p in phases ) {
        my.phase <- data$Phase == p
        for( s in unique( data$Stimulus ) ) {
            my.stimulus <- data$Stimulus == s
            my.trials <- data$Trial[ my.phase & my.stimulus ]
            count <- 1
            for( t in my.trials ) {
                cases <- my.phase & my.stimulus & data$Trial == t 
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
    data$Presentation <- alex.presentation( data )
    data
}

alex.hist <- function( data, variable, selection,
                      xlabel=selection,
                      xmin=0,
                      xmax=max(data[[variable]], na.rm=TRUE) ) {
    x <- strsplit( selection, ":", fixed=TRUE )[[1]]
    my.phase <- x[1]
    my.stimulus <- x[2]
    my.count <- x[3]
    my.data <- subset( data, Phase == my.phase &
                          Stimulus == my.stimulus )
    if( my.count != "*" ) {
        my.data <- subset( my.data, ResponseCount == my.count )
    }
    hist( my.data[[variable]], xlab=xlabel, main=NA,
         xlim=c(xmin, xmax) )
}
