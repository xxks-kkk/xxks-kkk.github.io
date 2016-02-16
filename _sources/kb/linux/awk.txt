.. _awk.rst:

###########
AWK
###########

************
Case Study
************

**GOAL:** Kill all the quicktest process

::

    (iidev20@maradona) /home/iidev20
    $ ps -ef | grep -i quicktest
    iidev20 49814180        1   0   Jan 12      -  0:00 quicktest 55556,671,760.mod OP 2 ITR 3000 CLIENT 5 NCLIENT 30 SEED 1452586352
    iidev20 49945254        1   0   Jan 12      -  0:00 quicktest 55556,671,760.mod OP 2 ITR 3000 CLIENT 15 NCLIENT 30 SEED 1452586362
    iidev20 50010822        1   0   Jan 12      -  0:00 quicktest 55556,671,760.mod OP 2 ITR 3000 CLIENT 14 NCLIENT 30 SEED 1452586361
    iidev20 51124770        1   0   Jan 12      -  0:00 quicktest 55556,671,760.mod OP 2 ITR 3000 CLIENT 9 NCLIENT 30 SEED 1452586356
    iidev20 51911254        1   0   Jan 12      -  0:00 quicktest 55556,671,760.mod OP 2 ITR 3000 CLIENT 26 NCLIENT 30 SEED 1452586373
    iidev20 52238890        1   0   Jan 12      -  0:00 quicktest 55556,671,760.mod OP 2 ITR 3000 CLIENT 11 NCLIENT 30 SEED 1452586358
    iidev20 52501070        1   0   Jan 12      -  0:00 quicktest 55556,671,760.mod OP 2 ITR 3000 CLIENT 10 NCLIENT 30 SEED 1452586357
    iidev20 54401732        1   0   Jan 12      -  0:00 quicktest 55556,671,760.mod OP 2 ITR 3000 CLIENT 20 NCLIENT 30 SEED 1452586367
    iidev20 54794868        1   0   Jan 12      -  0:00 quicktest 55556,671,760.mod OP 2 ITR 3000 CLIENT 22 NCLIENT 30 SEED 1452586369
    iidev20 29825944        1   0   Jan 12      -  0:00 quicktest 55556,671,760.mod OP 2 ITR 3000 CLIENT 8 NCLIENT 30 SEED 1452586355
    iidev20 35789764        1   0   Jan 12      -  0:00 quicktest 55556,671,760.mod OP 2 ITR 3000 CLIENT 19 NCLIENT 30 SEED 1452586366
    iidev20 36838170        1   0   Jan 12      -  0:00 quicktest 55556,671,760.mod OP 2 ITR 3000 CLIENT 13 NCLIENT 30 SEED 1452586360
    iidev20 36903922        1   0   Jan 12      -  0:00 quicktest 55556,671,760.mod OP 2 ITR 3000 CLIENT 24 NCLIENT 30 SEED 1452586371

.. topic:: Solution

      ::

         kill -9 `ps -ef | grep $USER | awk '$9 ~ /quicktest/ {print $2}'`

.. note::

     ``$9 ~ /quicktest/`` means that "looking for 'quicktest' within $9"



************
HowTos
************

- `How to find if substring is in a variable in awk <http://stackoverflow.com/questions/6256174/how-to-find-if-substring-is-in-a-variable-in-awk>`_

************
Resources
************

- `AWK short tutorial <http://coolshell.cn/articles/9070.html>`_
