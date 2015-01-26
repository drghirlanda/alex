*** NOTE: This README file is unfinished ***


Alex: Associative Learning EXperiment software
==============================================

Alex is a program to help running experiments on associative
learning. Rather than writing an experiment program, you write a bunch
a configuration files that describe the experiment, then alex reads
these files and, if everything goes well, runs the experiment for you.

Alex is written using PEBL (Psychology Experiment Building Language),
which you can find at http://pebl.sourceforge.net.

Alex is tested only on Linux. While PEBL works on Windows an OS X, I
have not tested alex on these systems.

Author
======

Alex is being developed by Stefano Ghirlanda, drghirlanda@gmail.com,
http://drghirlanda.com. Feedback is welcome.

Usage
=====

There is no manual yet. What you get is a PEBL program, alex, and the
following directories that show an example experiment:

Design: Containes files to configure the experiment 
Media:  Contains a smiley face image to use as reward
Data:   Contains the data collected (I use it just for testing)

The Design directory is where all configurations are kept. It contains
the following files:

- Instructions.txt: Instructions to be displayed at the start of the
  experiment

- Parameters.csv: Defines a bunch of parameters such as CS and US
  durations, inter-trial interval, etc.

- Stimuli.csv: Defines the experimental stimuli used

- Subjects.csv: Defines parameters that vary by subject (treatments)

- Phases.csv: Defines how stimulus presentations are organized in
  different phases of training.

Example
-------

Suppose we want to teach participants to discriminate a red square
from a white square. We then want to know how subjects respond to,
say, a pink square. The Phases.csv file might look like this (I am
displaying it as a table for simplicity, but fields should be comma
separated):

    Phase Stimulus Presentations Reward
    1     R        20            0.9
    1     W        20            0.1
    2     P        5             0

This means that in pahse we will have 20 presentations of each of
stimuli R and W (for 'red' and 'white'). R will be rewarded 90% of the
time, P only 10%. In phase 2, stimulus P ('pink') is presented.

How does alex know that R, W, and P represent red, white and pink
square? This information is contained in the Stimuli.csv file, which
might look like this:

    Name Shape  Color       XOffset YOffset
    R    square red         0       0
    W    square white       0       0
    P    square 255,128,128 0       0

Note that the pink color is given as an RGB triplet. As this is itself
comma-separated, it needs to be double-quoted in the CSV file. XOffset
and YOffset are offsets from the center of the screen, in pixel. In
this example, all stimuli are centered.

The Subjects.csv file contains information about the subjects you want
to run. If all subjects undergo the same treatment, as in the present
example, you only need to give subject numbers:

    Subject
    1
    2
    3
    4
    5
    6

This instructs alex that you want to run 6 subjects. It is more common
however, that different subjects require different treatments. Right
now, alex can only change the color of stimuli on a per-subject
basis. If you want to test two shades of pink, for example, you would
do:

    Subject PColor
    1       255,128,128
    2       255,128,128
    3       255,128,128
    4       255,190,190
    5       255,190,190
    6       255,190,190

You also need to modify the Stimuli.csv file like this:

    Name Shape  Color       XOffset YOffset
    R    square red         0       0
    W    square white       0       0
    P    square *P          0       0

The special notation *P indicates that the color of stimulus P will be
looked up, for each subject, as the corresponding value in column
PColor.

... To be continued ...
