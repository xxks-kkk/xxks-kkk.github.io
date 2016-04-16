.. _clearcase.rst:

#######################
Source code security
#######################

2016-04-15

Yesterday morning (04/15/16), when I came to the office, I got a bad news from my manager: he was informed by
security that I had an abnormal checkout of code on Monday, 04/11/16. The way how things work regarding source code
security in our lab and probably in IBM other labs is that security will track each developer the frequency and
quanity of checkout each day. They collect some statistics and alert the first-line manager when something potentially
terrible happened. For instance, if I usually checkout code twice per day and each time around 20 source files, but
on 04/15/16, I checkout 3456 files in day will certainly set off the alarm. Believe me, this number is exactly the number
I was informed from my manager. What did I do on that day? It turns out that I need to make a special build on top of a GA build 
for a client and I need include all the code change specifically for this client in the past plus my code this time. The way to make
a special build is that we use some scripts to check out the source files that are needed to be changed and merge the code, and 
run test buckets on them. Those will involve tons of checkout & checkin. After all, I successfully explain this to my manager and everything
works out at last.

What interests to me for this incident is that this is the first time I realize the power of `ClearCase <http://www-03.ibm.com/software/products/en/clearcase>`_. I have never heard of ClearCase until I join IBM. Back to the college, I solely work with Git and I feel extremely uncomfortable when I firstly work
with ClearCase. However, from this incident, I personally start to feel like ClearCase is probably more powerful than Git on security level. Basically, in
Git world, I need to fork or clone the repository so that I can have a local copy of ALL the source code and to start work on my branch. There has some
problem in terms of security because I literally need to have all the code locally before I can work on my stuff. Make branch on the remote repository also
has this issue. However, in ClearCase, I only need to first make a dynamic view and only check out the files I need to modify. If I check out too many files
that will raise warning like this time. This security checking mechanism works great with ClearCase because:

  - There is a central server to hold all the source code. A Corporation can simply monitor the checkout behavior of this central code repository.
  - the quantity of checkout is different from person to person. In Git, it feels like a standard way for everyone to checkout all source files even
    you only need to modify one. However, with ClearCase, that can be different from person to person. This will the statistics monitoring checkout
    becomes meaningful.

I'm not saying Git is bad. In fact, in IBM, we are starting to have GitHub Enterprise that hosts on SoftLayer behind IBM firewall. That is really a great
news for me because I can finally have "social coding" experience that I have been enjoying so far outside of the work. It will make some work I have done
tailored specifically to fellow IBMers more organized and easy to get. I don't need to attach the code inside emails sent to each member of the team that 
we collaborat with one by one. I can simply send the git repo to their team lead and each member of their team can access simultaneously. Plus, having Github
inside IBM also helps me to track issue with the code I own and again, saves ton of communication cost for me.


.. disqus::
