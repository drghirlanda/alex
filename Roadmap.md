Roadmap for alex
================

This file descirbes some features that are planned for alex.

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


