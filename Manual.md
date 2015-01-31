Alex: Associative Learning EXperiment software
==============================================


Introduction
------------

Alex is a program to run associative learning experiments specified
through a set of configuration files. This manual describe how to
configure experiments. Please refer to the README file that comes with
Alex for installation instructions.


Workflow
--------

To build and run a new experiment you create a dedicated folder, say,
MyExperiment, and within it the following sufolders:

- Design: This folder contains the files that specify experimental
  design, such as which stimuli to use, the structure of trials, and
  different treatments for subjects. See [Configuration files] below.

- Media: Here you have any image or sound files you need for your
  experiment.

- Data: This folder is created by alex if it is not found, and it
  holds the data collected during experiment runs.


Configuration files
-------------------

All configuration files are in the Design folder:

- Instructions.txt contains instructions to be displayed to subjects.

- Phases.csv describe the experimental design proper. I containes one
  or more experimental phases, each composed of a number of trials in
  which stimuli are presented, responses recorded, and outcomes
  delivered.

- Stimuli.csv defines the stimuli that are mentioned Phases.csv. The
  latter only mentions stimuli by name, while Stimuli.csv informs alex
  of what the stimuli actually are.

- Subjects.csv defines the number of subjects to be run and possibly
  different the treatments to which subjects are allocated.

- Parameters.csv defines some global parameters such as screen
  background color, text color, font, and size, the duration of
  inter-trial intervals, and so on.


Example
-------

Suppose we want to teach participants to discriminate a red square
from a white square. We then want to know how subjects respond to,
say, a pink square. The Phases.csv file might look like this:

    Phase Stimulus Presentations Reward
    1     R        20            0.9
    1     W        20            0.1
    2     P        5             0

I am displaying the file as a table, but it should be a
comma-separated file. You can edit these in any spreadhseet using the
CSV format for saving. 

**Note:** Alex wants double quotes (when needed) in CSV files. Single
quotes will result in errors. (This comes from the PEBL function that
reads CSV files.)

The above file describes an experiment with two phases. Each line
describes one type of trial that occurs in a phase. There are, for
example two kinds of trials in phase 1, specifying 20 presentations of
each of two stimuli, R and W (for 'red' and 'white'). R will be
rewarded 90% of the time, W only 10%. In phase 2, stimulus P ('pink')
is presented five times. When the experiment is run, R and W trials
will be intermixed randomly because they all pertain to phase 1. P
trials on the other hand, will be performed in phase 2 after all phase
1 trials have been run.

How does alex know that R, W, and P represent red, white and pink
squares? This information is contained in the Stimuli.csv file, which
might look like this:

    Name Type   Parameters Color       XOffset YOffset
    R    square 50         red         0       0
    W    square 50         white       0       0
    P    square 50         255,128,128 0       0

The fields should be fairly intuitive, but here is what they mean in
detail:

- Name: An arbitrary label for the stimulus, so that it can be
  referenced in Phases.csv. It can be anything that does not contain
  the characters " (double quote), + (plus sign), * (star), : (colon),
  and , (comma). These characters are reserved for special operations,
  see below.

- Type: This can be square, circle, image, or sound.

- Parameters: The meaning of parameters varies according to the
  stimulus type:

  - square: side in pixels

  - circle: radius in pixels

  - image or sound: name of file in the Media folder containing the
    desired image or sound.

- Color: the color of squares and circles. For images and sounds this
  field is ignored. Colors can either be named or given as an RGB
  triplet. As this is itself a comma-separated list, it needs to be
  double-quoted in the CSV file (spreadhseet software will do this for
  you). 

- XOffset and YOffset: offsets from the center of the screen, in
  pixel. In the example, all stimuli are centered.

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

This instructs alex that you want to run 6 subjects, all subject to
the same treatment. Often, however, subjects need to be divided in
different treatment groups. Any of the fields in the Stimuli.csv file
can be specified on a per-subject bases. If you want to test two
shades of pink, for example, you would extend the Subjects.csv file
like this:

    Subject PColor
    1       255,128,128
    2       255,128,128
    3       255,128,128
    4       255,190,190
    5       255,190,190
    6       255,190,190

And you would modify the Stimuli.csv file like this:

    Name Type   Parameters Color XOffset YOffset
    R    square 50         red   0       0
    W    square 50         white 0       0
    P    square 50         *P    0       0

The special notation *P indicates that the color of stimulus P will be
looked up, for each subject, in the column PColor of the Subects.csv
file. This syntax is available for all stimulus properties. For
example, if you want to change the size of R square across subjects
you can do:

* Stimuli.csv:

        Name Type   Parameters Color XOffset YOffset
        R    square *R         red   0       0
        W    square 50         white 0       0
        P    square 50         *P    0       0

* Subjects.csv:

        Subject PColor      RParameters
        1       255,128,128 25
        2       255,128,128 50
        3       255,128,128 75
        4       255,190,190 25
        5       255,190,190 50
        6       255,190,190 75

Global parameters
-----------------

The file Design/Parameters.csv contains some parameters that affect
the whole experiment. Here is a sample file (as above, the file is in
CSV format, displayed here as a table for lagibility):

    Parameter       Value
    CSDuration      4000
    CSUSInterval    0
    USDuration      400
    ResponseTimeMin 0
    ResponseTimeMax 4000
    MinITI          1000
    MaxITI          3000
    MaxResponses    100
    BackgroundColor gray95
    ForegroundColor black
    FontName        Vera
    FontSize        36
    Test            1

**CSDuration** is the duration of all the non-US stimuli. All
durations are in milliseconds. In future versions it will be possible
to set different durations for different stimuli, and also to present
sequences of stimuli for each trial, but right now we have only single
stimuli of a common duration. **CSUSInterval** and **USDuration**
should be self-explanatory.

**ReactionTimeMin** and **ReactionTimeMax** define at what times
within a trial subjects can respond. Responses outside this time
window are registered with a special code (see [Data format] below),
and no USs are delivered. If not specified, ResponseTimeMin is set to
0 and ResponseTimeMax to CSDuration, thus allowing responses anywhere
in the trial.
  
**MinITI** and **MaxITI** are the minimum and maximum values of the
inter-trial interval. Each inter-trial interval will be drawn between
these values with uniform distribution.

MaxResponses is the maximum number of response a subject is allowed to
make in one trial. There are essentially two useful settings. If you
set this to 1 the trial ends with the first response (the US is
delivered if appropriate, of course). If you set it to an
unrealistically large value, say 1000, you can any number of responses
per trial. Each of these may result in the US being delivered, as
described above.

The following parameters control the screen background color while the
experiment is running and the color, font, and size of text used for
instructions and other messages.

The Test parameter, if set to 1, skips instructions and acquisition of
demographic information. It is meant to quickly start the experiment
during development.

  ... To be continued ...
