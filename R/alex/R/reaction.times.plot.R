#' @export
reaction.times.plot <- function( d ) {
  groups <- levels( d$Group )
  max.time <- max( d$S1Duration, na.rm=TRUE )
  par( mfrow=c(length(groups),1) )
  for( g in groups ) {
    g.data <- subset( d, Group==g )
    trials <- vector( mode="numeric", length(g.data$Phases) )
    p <- levels(g.data$Phase)
    x.labels <- c()
    for( i in 1:length(p) ) {
      trials[i] <- max( subset( g.data, Phase==p[i] )$Presentation )
      x.labels <- c( x.labels, 1:trials[i] )
    }
    cumtrials <- cumsum( trials )
    cumtrials <- c( 0, cumtrials )
    plot( c(1, cumtrials[ length(p)+1 ]), c(0, max.time ),
         pch=NA, xlab="Presentation", ylab="Reaction time (ms)",
         main=g, xaxt="n" )
    axis( 1, at=1:cumtrials[ length(p)+1 ], labels=x.labels )
    g.stimuli <- unique( g.data$S1 )
    legend( "topright", legend=g.stimuli, col=1:length(g.stimuli),
           lty=1, pch=16, bty="n" )
    for( i in 1:length(p) ) {
      p.data <- subset( g.data, Phase==p[i] )
      for( k in 1:length(g.stimuli) ) {
        s.data <- subset( p.data, S1==g.stimuli[k] &  KeyNum <= 1 )
        x <- s.data$Response == "<timeout>"
        s.data$RT[ x ] <- s.data$S1Duration[ x ]
        if( nrow(s.data) ) {
          y <- aggregate( RT ~ Presentation, s.data, mean )
          lines( cumtrials[i] + y$Presentation, y$RT, col=k, pch=16 )
        }
      }
    }
  }
}
