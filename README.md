** NOTE: This README file is unfinished **

Alex: Associative Learning EXperiments
======================================

Alex is a program to help running experiments on associative
learning. Rather than writing an experiment program, you write a bunch
a configuration files that describe the experiment. Alex reads these
files and, if everything goes well, runs the experiment and collects
data. A Manual.md file is provided with the distribution

Alex is written using PEBL (Psychology Experiment Building Language),
which you can find at http://pebl.sourceforge.net.

Alex is tested only on Linux. While PEBL works on Windows an OS X, I
have not tested alex on these systems.

Author
------

Alex is being developed by Stefano Ghirlanda, <drghirlanda@gmail.com>,
<http://drghirlanda.com>. Feedback is welcome.

Scope
-----

Alex can display squares, circles, arbitrary images, and play
sounds. All of these can serve as CSs or USs. Multiple CSs and USs can
be presented at the same time. Alex's biggest current limitations are:

- There is only one reinforcement schedule, Variable Ratio. That is,
  each response to a CS has a fixed probability of being
  reinforced. Of course, probability of 0 is extinction, and
  probability of 1 full reinforcement, or a Fixed Ratio 1 schedule.

- Only spacebar presses count as "responses." There is no provision
  for multiple responses like "left" and "right" or, in fact, any
  other response that is not a spacebar press.

These limitations mean that, for example, one cannot present
*sequences* of CSs before a reward is scheduled, and that choice tasks
are not possible.
