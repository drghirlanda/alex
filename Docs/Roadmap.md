Roadmap for alex
================

This file describes some features that are planned for alex.

Toward a release
----------------

- Make RunExperiment.bat work!

- Add section on steady state testing in manual, perhaps as an
  example.

- Decide whether to rename alex to alex.pbl

- ReadStimuli() relies on the fields being in the correct order. We
  can be more lenient and determine the order of fields from the
  header line of Stimuli.csv (as is done in other Read*() functions).

- Example suite: reaction time, causal rating, categorization. 

- A paper describing alex.

- Installation scripts. We should have installation scripts for all
  systems supported by PEBL. Linux and OS X can use the same bash
  script but will probably have to install into different
  folders. Research needed for Windows.

- R package. 

  - Creating presentation variable is slow. It could be faster to
    create it for each subject as they are read, rather than for all
    subjects at the end (less looping, shorter arrays to sort, etc.).

  - Descriptive stats for response time distributions and response
    count distributions to the different stimuli and phases.

  - Future: It is possible to figure out which independent variables
    were manipulated between and within subjects, present the
    experimental design in a table, etc.


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
single stimuli, in each trial. For example a sequence of two stimuli A
and B, lasting 1 and 2 seconds, respectively, could be described in
Phases.csv as:

    Phase Stimulus Durations Trials Rewards USs
    1     A|B      1000|2000 10     1       Smiley

But we need a clean syntax to specify onset and offset of all stimuli
in the sequence...


Phase sequences
---------------

We could have a PhaseOrder column in Groups.csv that allows for
alternate phase sequences as a type of group treatment.


Multiple responses
------------------

It should be possible to make rewards specific to stimulus/key
combinations. Possible syntax:

    Phase Stimulus Trials Rewards   USs
    1     A        10     a:1,l:0.5 a:Smiley,l:Smiley

Indicating a 100% probability of reward when 'a' is pressed and a 50%
probability when 'b' is pressed. It would also be possible to have
different USs, such as Smiley and Frown.
