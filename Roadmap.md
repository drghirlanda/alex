Roadmap for alex
================

This file describes some features that are planned for alex.

Installation scripts
--------------------

Ideally we should have installation scripts for all systems supported
by PEBL. Linux and OS X can use the same bash script. Research needed
for Windows.


Media files
-----------

We need some media files: big and small frowny and smiley face
(ideally we would be able to scale a single file, but it doesn't look
like PEBL has this capability yet).


Per-stimulus durations
----------------------

If Stimuli.csv has a Duration column, that value should be used,
falling back on the global values if no specific value is given. Note:
the global value will be different between CS and US, so that should
be taken into account.


Text files and messages between phases
--------------------------------------

It should be possible to insert messages in between phases and wait
until the subject presses some key before going ahead. This would be
automatically possible by implementing to features that are desirable
in themselves:

- A 'textfile' stimulus type, displaying the text file on screen as a
  stimulus.

- A blocking trial type requiring a response in order to move on. For
  starters, 'blocking' could be a parameter of 'textfile'

This would be useful as we could display instructions and end messages
in the same way we display files, no special cases.

Also, if we have 'rating' and 'demographics' stimulus types, these
things could also be in the Phases.csv file. 

Init script
-----------

We should have an alex-init script that initializes an experiment with
the correct folder structure, and default files and parameter values
when possible, and comments in Parameters.csv to briefly explain the
meaning of parameters. The alex installation would store these files
somewhere, and alex-init would just copy them in a new folder with a
name provided by the user.

Because we can copy files in PEBL using AppendFile, it makes sense to
write alex-init in PEBL so that users do not need to install something
just to run alex-init.


Causal ratings
--------------

It should be possible to ask subjects to rate causal
relationships. This needs a scale widget (already there in PEBL? Check
out GetEasyChoice) and a way to configure the rating question, as well
as a way to record the rating

Stimulus sequences
------------------

It should be possible to display sequences of stimuli, rather than
single stimuli, in each trial. The comma charatcter (,) has been
reserved for the specification of sequences. A Durations field is
planned for Stimuli.csv. For example a sequence of two stimuli A and
B, lasting 1 and 2 seconds, respectively, could be described in
Phases.csv:

    Phase Stimulus Durations Trials Rewards USs
    1     A,B      1000,2000 10     1       Smiley

Multiple responses
------------------

It should be possible to instruct alex to record any keypress, and
make rewards specific to stimulus/key combinations. Proposed syntax:

    Phase Stimulus Trials Rewards USs
    1     A        10     a:1     Smiley
    1     B        10     l:1     Smiley

This would indicate that presses of the 'a' key should be rewarded
with a smiley when stimulus A is presented, while when B is presented
the rewarded key is 'l'. Multiple stimulus/key pairs could be entered
as:

    Phase Stimulus Trials Rewards   USs
    1     A        10     a:1,l:0.5 a:Smiley,l:Smiley

Indicating a 100% probability of reward when 'a' is pressed and a 50%
probability when 'b' is pressed. It would also be possible to have
different USs, such as Smiley and Frown.


Collecting judgments
--------------------

It should be possible to ask subjects for ratings, such as "how likely
do you think this stimulus will be followd by this outcome?" The
format could be:

    Phase  Stimulus Trials Rewards USs
    2      A        1              Rating

When the special "USs" Rating is specified, a special trial is run
with a rating scale and rating text. The scale and text could be given
in dedicated configuration files. Or, the "Rewards" field could be
abused to give the start, end, and step of the rating scale, such as
"1,7,1" for a 7 point Likert scale, or "0,100,10" for an 11 point
percentage scale. But we also need a way to specify the scale text.