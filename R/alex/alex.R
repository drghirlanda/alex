# a function to build a 'presentation' variable that counts the number
# of times any given stimulus has been presented, for each phase of
# the experiment.
alex.presentation <- function( data,
                              subject="subject",
                              cs="CS",
                              phase="phase" ) {
  pres <- rep( NA, nrow(data) )

  subject1 <- try( min( data[[subject]] ), silent=TRUE )
  if( class(subject1) == "try-error" | !is.finite(subject1) ) {
    stop( paste("no", subject, "variable found" ) )
  }
  n.subjects <- length( unique( data[[subject]] ) )
  n.trials <- nrow(data) / n.subjects
  print( paste( "Subjects:", n.subjects ) )
  print( paste( "Trials:", n.trials ) )
  
  phases <- unique( data[[phase]] )
  print( paste( "Found phases:", paste(phases, collapse=" " ) ) )

  for( p in phases ) {
    print( paste( "Analyzing phase", p ) )
    my.phase <- data[[phase]] == p
    stimuli <- unique( data[[cs]][ my.phase ])
    print( paste( "Found stimuli:", paste(stimuli, collapse=" " ) ) )

    for( s in stimuli ) {
      my.cs <- data[[cs]] == s
      n.pres <- sum( my.phase & my.cs & data[[subject]]==subject1 )
      print( paste( "Found", n.pres, "presentations of", s ) )
      pres[ my.phase & my.cs ] <- 1:n.pres
    }
  }

  pres
}

# a function to read data output by our PEBL programs
read.alex.data <- function( data.dir="." ) {
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
  data
}

