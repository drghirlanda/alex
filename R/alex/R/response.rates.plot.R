#' @export
response.rates.plot <- function( d ) {
  groups <- levels( d$Group )
  d$RateSE[ is.na(d$RateSE) ] <- 0
  max.rate <- max( d$Rate + d$RateSE, na.rm=TRUE )
  par( mfrow=c(length(groups),1), mar=c(4,4,4,7), xpd=TRUE )
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
    plot( c(1, cumtrials[ length(p)+1 ]), c(0, max.rate ),
         pch=NA, xlab="Presentation", ylab="Response / s",
         main=g, xaxt="n" )
    axis( 1, at=1:cumtrials[ length(p)+1 ], labels=x.labels )
    g.stimuli <- sort( unique( g.data$S1 ) )
    legend( "topleft", legend=g.stimuli, col=1:length(g.stimuli),
           lty=1, pch=16, bty="n", inset=c(1.01,0) )
    for( i in 1:length(p) ) {
      p.data <- subset( g.data, Phase==p[i] )
      for( k in 1:length(g.stimuli) ) {
        s.data <- subset( p.data, S1==g.stimuli[k] )
        if( nrow(s.data) ) {
          x <- cumtrials[i] + s.data$Presentation
          y <- s.data$Rate
          j <- rnorm( length(x), mean=0, sd=0.1 )
          points( x+j, y, type="b", col=k, pch=16 )
          segments( x+j, y+s.data$RateSE, x+j, y-s.data$RateSE, col=k, lwd=0.5 )
        }
      }
    }
  }
}
