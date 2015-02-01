Alex: Associative Learning EXperiment software
==============================================


Introduction
------------

Alex is a program to run associative learning experiments specified
through a set of configuration files. This manual describe how to
configure experiments. Please refer to the README file that comes with
alex for installation instructions. The README also describes what
alex can and cannot do.


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

- Phases.csv:

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

- Stimuli.csv:

        Name Type   Parameters Color       XOffset YOffset
        R    square 50         red         0       0
        W    square 50         white       0       0
        P    square 50         255,128,128 0       0

The fields should be fairly intuitive, but here is what they mean in
detail:

- **Name**: An arbitrary label for the stimulus, so that it can be
  referenced in Phases.csv. It can be anything that does not contain
  the characters " (double quote), + (plus), * (star), : (colon), and
  , (comma). These characters are reserved for special operations, see
  below.

- **Type**: This can be square, circle, image, or sound.

- **Parameters**: The meaning of parameters varies according to the
  stimulus type:

  - square: side in pixels

  - circle: radius in pixels

  - image or sound: name of file in the Media folder containing the
    desired image or sound.

- **Color**: the color of squares and circles. For images and sounds
  this field is ignored. Colors can either be named or given as an RGB
  triplet. As the latter are themselves comma-separated lists, they
  need to be double-quoted in the CSV file (spreadhseet software will
  do this for you).

- **XOffset** and **YOffset**: offsets from the center of the screen, in
  pixel. In the example, all stimuli are centered.

The Subjects.csv file contains information about the subjects you want
to run. If all subjects undergo the same treatment, as in the present
example, you only need to give subject numbers:

- Subjects.csv:

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

- Subjects.csv:

        Subject PColor
        1       255,128,128
        2       255,128,128
        3       255,128,128
        4       255,190,190
        5       255,190,190
        6       255,190,190

And you would modify the Stimuli.csv file like this:

- Stimuli.csv:

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


Special notation for stimuli
----------------------------

We mentioned above one bit of special notation in the definition of
stimuli, namely the construction * (star) + stimulus name (see the end
of the previous section). There are two more bits of special notation,
explained next.

Sometimes we want some stimuli to share characteristics. For example,
they should be of the same color. We can express the fact that we want
a stimulus characteristic to equal that of another stimulus using a
colon (:) followed by the stimulus name (we would have liked to use =
rather than :, but unfortunately some spreadsheet software interprets
= as introducing a formula). Consider the example above, with three
squares of the same size as stimuli. We can write the following in
Stimuli.csv:

- Stimuli.csv:

        Name Type   Parameters Color XOffset YOffset
        R    square 50         red   0       0
        W    square :R         white 0       0
        P    square :R         *P    0       0

This notation has two advantages: it makes explicit our intention of
having three squares of equal size, and it reduces the possibility of
typing errors. In fact, we could go all the way and have:
 
-Stimuli.csv:

        Name Type   Parameters Color XOffset YOffset
        R    square 50         red   0       0
        W    :R     :R         white :R      :R
        P    :R     :R         *P    :R      :R

which makes explict that we want the three stimuli to differ only in
color.

Another bit of special notation is + (plus), which is used to present
stimuli together (compound stimuli). Suppose that, after training a
discrimination between red and white squares, we want to test the red
and white squares together. We can use the following files:

- Phases.csv:

        Phase Stimulus Presentations Reward
        1     R        20            0.9
        1     W        20            0.1
        2     R+W      5             0

- Stimuli:csv:

        Name Type   Parameters Color XOffset YOffset
        R    square 50         red   0       0
        W    :R     :R         white 60      :R

Note that we have now offset the white square, otherwise it would
overlap with the red one.


Global parameters
-----------------

The file Design/Parameters.csv contains some parameters that affect
the whole experiment. Here is a sample file (as above, the file is in
CSV format, displayed here as a table for legibility):

- Parameters.csv:

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

**MaxResponses** is the maximum number of response a subject is
allowed to make in one trial. There are essentially two useful
settings. If you set this to 1 the trial ends with the first response
(the US is delivered if appropriate, of course). If you set it to an
unrealistically large value, say 1000, you can any number of responses
per trial. Each of these may result in the US being delivered, as
described above.

The following parameters control the screen background color while the
experiment is running and the color, font, and size of text used for
instructions and other messages.

The **Test** parameter, if set to 1, skips instructions and
acquisition of demographic information. It is meant to quickly start
the experiment during development.


Data Format
-----------

When you run an experiment with alex, data are saved in the Data
folder (which alex creates if it does not find) in CSV files named
with subject numbers, i.e., Data/1.dat and so on. These files have a
header followed by one data line per trial. The first columns
replicate the Subjects.csv line for the particular subject. This is so
that each line identifies all independent variables it pertains to (so
called "long format" in statistical software). Another reason for
including this information is that in this way you don't have to load
it into your statistical software from other files. 

The other columns of the data files are as follows:

 - **Sex**: subject sex (collected by alex at the start of
   experiments).

 - **Age**: subject sex (ditto).

 - **Phase**: experimental phase the trial belongs to.

 - **Trial**: trial number within the phase.

 - **Stimulus**: stimulus presented in the trial (one of those defined
   in the Stimulu.csv design file).

 - **RewardPr**: reward probability assigned to the stimulus (from the
   Phases.csv design file).

 - **Responses**: The number of times the subject responded to the
   stimulus. This includes *all* responses, even those that may have
   bee registered at invalid times (see ReactionTimeMin and
   ReactionTimeMax above). See *Rewards* below for how to obtaine
   detailed information about valid and invalid responses.

 - **RTs**: Reaction times for *all* registered responses (see
    *Responses*). This is a comma-separated list.

 - **Rewards**: A comma-separated list of rewards received for each
   response. Each element has three possible values:
    
   - 1: The response was rewarded (the US was presented)

   - 0: The response was not rewarded (no US presented)

   - -1: The response was invalid, i.e., it fell outside of the window
       delimited by ReactionTimeMin and ReactionTimeMax, see above. No
       US is presented on such responses.

We think this information characterizes subject behavior competely,
but please do let us know if you think details could be added.

Conclusion
----------

Please send suggestions to improve alex or this manual to Stefano
Ghirlanda, drghirlanda@gmail.com.

