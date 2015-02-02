Alex: Associative Learning EXperiments
======================================

Alex is a program to help running experiments on associative
learning. Rather than writing an experiment program, you write a bunch
a configuration files that describe the experiment. Alex reads these
files and, if everything goes well, runs the experiment and collects
data. A Manual.md file is provided with the distribution. 

Alex is written using PEBL (Psychology Experiment Building Language),
which you can find at http://pebl.sourceforge.net. We are indepted to
Shane Muller, PEBL's creator and maintainer, for making alex possible.

Alex is tested only on Linux. While PEBL works on Windows an OS X, I
have not tested alex on these systems.

Scope
-----

Alex can display squares, circles, images or movies from files, and
play sound files. All of these can serve as conditioned stimuli (CSs)
or as unconditioned stimuli (USs), or, in other terms, as cues and
outcomes. Multiple CSs and USs can be presented at the same
time. Currently, alex's biggest limitations are:

- There is only one reinforcement schedule, Variable Ratio. That is,
  each response to a CS has a fixed probability of being
  reinforced. Of course, probability of 0 is extinction, and
  probability of 1 full reinforcement, or a Fixed Ratio 1 schedule.

- Only spacebar presses count as "responses." There is no provision
  for multiple responses like "left" and "right" or, in fact, any
  other response that is not a spacebar press.

- All CSs have the same duration. Although many CSs can be presented
  in each trial, they are all presented simultaneously and there is no
  possibility of enforcing a given temporal structure.

These limitations mean that, for example, one cannot present
*sequences* of CSs before a reward is scheduled, and that choice tasks
are not possible.

Contacts
--------

Please send bug reports, suggestions for improvement, patches, etc.,
to Stefano Ghirlanda, drghirlanda@gmail.com.