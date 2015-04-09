Roadmap for alex
================

This file describes some features that are planned for alex.

Toward a release
----------------

- ReadStimuli() relies on the fields being in the correct order. we
  can be more lenient and determine the order of fields from the
  header line of Stimuli.csv (as is done in other Read*() functions).

- Add a Log folder alongside data where we log information about all
  runs.

- Register also responses during ITI, perhaps with NA as
  stimulus. Whatever stimulus code is chose, note in the Manual that
  it is not allowed for regular stimuli.

- Check Manual for styles and typos.

- Example suite. Include also "cognitive" tasks like a categorization
  task with test stimuli for prototype effect and peak-shift. Other
  tasks: simple discrimination, generalization, peak shift, replicate
  some famous experiments.

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

- Causal ratings: It should be possible to ask subjects to rate causal
  relationships. This needs a scale widget and a way to configure the
  rating question, as well as a way to record the rating. The plan
  could be:

  - GetEasyChoice for rating scale. We need a version that honors the
    background color, we can grab the code from the pebl
    implementation.

  - Response type can be "rating." To configure the scale we could use
    global parameters RatingMin, RatingMax, RatingStep, or have
    parameters in the Response column, like "rating+1+10+1" for a 10
    point scale with 1-point increments. Alternatively, could Rating
    be a US?

  - We will probably have to change the OneTrial function a bit so
    that for rating trials the "Responses" data field is the rating
    rather than the number of responses.

  - What else?


Future
======

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
