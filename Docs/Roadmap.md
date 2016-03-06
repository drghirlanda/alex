Roadmap for alex
================

This file describes some features that are planned for alex.

Toward a release
----------------

- For consistency with other lists, use + to delimit RGB colors rather
  than -

- Document inf?

- Document that "NA" is not a valid stimulus name because it is used
  as "not available" to indicate lack of S2

- Document "Onset" stimulus parameter and explain how it makes
  possible to show arbitrary sequences of stimuli as S1 and S2.

- Document the feature displaying the subject number and group and
  explain why it is there. Perhaps a section on "Running alex" with
  the RunExperiment stuff plus this info.

- Add "Subject demographics" section to the manual. Document there the
  AskID, AskAge, AskSex, AskRace parameters. Remove mentions to "test"
  mode if present, which is superseded by these parameters

- ReadStimuli() relies on the fields being in the correct order. We
  can be more lenient and determine the order of fields from the
  header line of Stimuli.csv (as is done in other Read*() functions)

- Example suite: reaction time, causal rating, categorization.

- Add to troubleshooting section that on Windows you don't get error
  messages on console. If no log file, it means that alex cannot read
  subject information or create the log file itself.

- R package

  - Descriptive stats for response time distributions and response
    count distributions to the different stimuli and phases

  - Future: It is possible to figure out which independent variables
    were manipulated between and within subjects, present the
    experimental design in a table, etc.

- Document configurable timing tolerance and explain why it's there

- README: installation instructions (inc. assumed PEBL locations)


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


Multiple responses
------------------

It should be possible to make rewards specific to stimulus/key
combinations. Possible syntax:

    Phase Stimulus Trials Rewards   USs
    1     A        10     a:1+l:0.5 a:Smiley+l:Smiley

Indicating a 100% probability of reward when 'a' is pressed and a 50%
probability when 'b' is pressed. It would also be possible to have
different USs, such as Smiley and Frown.
