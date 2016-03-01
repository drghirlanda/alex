## This is a simple R file analyzing data collected by the
## ReactionTime sample experiment in the alex distribution. It is
## meant as a basic example of how alex data can be loaded and used
## from within R.

## Ensure we can load alex.R even if not installed:
.libPaths( "../R/alex/R" )
## Load alex R functions:
library(alex)
library(data.table)

## The read.alex function loads all .csv files in Data (or another
## folder, if given) and collects them in a single data frame:
rtData <- read.alex()

## We are only interested in Test trials, not in instructions and
## messages to the participant:
rtData <- drop.phases( rtData, c("Start","End") )

## You can get an idea of what data have been collected like so:
str( rtData )

## The following is just a sample analysis. We check whether reaction
## times are longer after a sohrt inter-trial interval (ITI).

## The duration of ITIs is the S1Duration when S1 is the ITI:
ITIDuration <- rtData[ S1=="ITI", S1Duration ]

## These are the reaction times to the stimulus (a white circle):
CircleRT <- rtData[ S1=="Circle", RT ]

## We extract subject identifiers because the data is partly within
## subjects:
MySubject <- rtData[ S1=="Circle", GSubject ]

## NOTE: The analysis relies on the fact that there is always one ITI
## before each trial, so that the entries in ITIDuration and CircleRT
## are correctly matched. (MySubject entries are also matched, but we
## could have used GSubject[ S1=="ITI" ] as well.)

## This is a plot of the reaction time vs. ITI data:
plot( ITIDuration, CircleRT, pch=16, frame=F,
     xlim=c( 200, 2000 ),
     ylim=c( 100, 500 ),
     xaxt="n",
     yaxt="n",
     xlab="ITI Duration (ms)",
     ylab="Reaction time (ms)" )
axis( 1, c(200, 500, 800, 1100, 1400, 1700, 2000) )
axis( 2, c(100, 200, 300, 400, 500) )
abline( lm( CircleRT ~ ITIDuration ) )

## This is an ANOVA of the data:
rtAov <- aov( CircleRT ~ ITIDuration + Error(MySubject) )
summary( rtAov )
