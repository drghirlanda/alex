Roadmap for alex
================

This file describes some features that are planned for alex.

Rearrange Manual
----------------

The explanation of Stimuli.csv and Phases.csv should be more
systematic, with sections "The Stimuli.csv file" and "The Phases.csv"
coming after a brief introductory example. Right now the example is
probably too long and it introduces too many features in a somewhat
unclear order.


Installation scripts
--------------------

Ideally we should have installation scripts for all systems supported
by PEBL. Linux and OS X can use the same bash script. Research needed
for Windows.


Media files
-----------

We need scalable frowny and smiley faces in the same style, black and
white.


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
