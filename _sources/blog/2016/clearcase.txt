.. _clearcase.rst:

#######################
Why use ClearCase?
#######################

2016-04-15

I have never heard about `ClearCase <http://www-03.ibm.com/software/products/en/clearcase>`_ before joining IBM. All I
have when I was in college about version control is git.

In this post, I will try my best to record my experience working with ClearCase and trying to understand why my team
use ClearCase specifically as our version control tool.


***********************
Security is the key
***********************

Yesterday morning (04/15/16), when I first came to the office, I got a bad news from my manager: he was informed by
security that I had an abnormal checkout of code on Monday, 04/11/16. The way how things work regarding source code
security in our lab and probably in IBM other labs is that security will track each developer the frequency and
quanity of checkout each day. They collect some statistics and alert the first-line manager when something potentially
terrible happened. For instance, if I usually checkout code twice per day and each time around 20 source files, but
on 04/15/16, I checkout 3456 files in day will certainly set off the alarm. Believe me, this number is exactly the number
I was informed from my manager. What did I do on that day? It turns out that I need to make a special build for a client
and I need include all the code branch regarding this client in the past plus my code this time. Here, some implictly
merge will happen and one cannot change the code without check them out.

However, how did the security know that? That brings in one single beauty of ClearCase is that

git -> fork (get whole project)  vs. CC -> get some files (if all files in project -> bad)