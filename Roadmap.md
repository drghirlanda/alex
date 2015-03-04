Roadmap for alex
================

This file describes some features that are planned for alex.

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