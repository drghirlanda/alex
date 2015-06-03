Roadmap for alex
================

This file describes some features that are planned for alex.

Toward a release
----------------

- Right now responses during USs are not registered. This violates the
  principle that we record everything the participant does. We could
  register also these responses by putting the code to print a data
  line into a function, so that it can be easily called from different
  points. We have to be careful about semantics, though. In
  particular, it should be possible to distinguish easily between
  responses emitted when the US was present vs. those emitted in the
  absence of the US.

- Redesign data lines to include info about CS, CSDuration, US,
  USDuration, USProb, USPres, USOn.

- In fact, it might be worth emphasizing a more neutral terminology,
  like S1 and S2 rather than CS and US, to appeal to people less
  entrained in animal learning jargon.

- Add section on steady state testing in manual.

- Decide whether to rename alex to alex.pbl

- ReadStimuli() relies on the fields being in the correct order. We
  can be more lenient and determine the order of fields from the
  header line of Stimuli.csv (as is done in other Read*() functions).

- Check Manual for styles and typos.

- Example suite. Include also "cognitive" tasks like a categorization
  task with test stimuli for prototype effect-shift. Other tasks:
  simple discrimination, generalization, peak shift, replicate some
  famous experiments, reaction times to bright or faint stimuli.

- A paper describing alex.

- Installation scripts. We should have installation scripts for all
  systems supported by PEBL. Linux and OS X can use the same bash
  script but will probably have to install into different
  folders. Research needed for Windows.

- R package. Minimum requirements: a way to read in alex data into
  data.frames, descriptive stats for response time distributions and
  response count distributions to the different stimuli. It is also
  possible to figure out which independent variables were manipulated
  between and within subjects, present the experimental design in a
  table, etc.

- Extend * notation for Phases.csv, so that different groups can
  differ in e.g., length of phases or reward probabilities.


Future
======

Optimizations
-------------

If there are reports of time lags, flickering stimuli, or anything
related to performance, there are a number of potential optimizations
that could be made. Because the experiment does not change, a lot of
things that now are looked up dynamically (e.g., whether a phase has a
defined background stimulus or not) could be determined once for all
and cached in suitable lists.


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
