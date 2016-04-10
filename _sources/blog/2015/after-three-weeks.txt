.. _after-three-weeks.rst:

######################
After three weeks ...
######################

2015-09-01

As a fresh new grad, I have been work as a software developer at IBM China Software Development Laboratory for three weeks. Here are some…well…thoughts:)

My job \@IBM is to incorporate cutting-edge technology into DB2 Federation Server (FS). Even though I am entitled with Software Developer, 
I also need to play some role as a L3 Technical Support. This role can be either interesting or boring to hell…  
Usually, the request for L3 support is submitted by L2 support. Depending on the type of problems or the level of expertise of L2 support themselves, 
the request can be extremely clear or extremely unclear. By clear, I mean they can identify the root cause of the problems; and by unclear, 
I mean they only observe the problems, and can provide some description about what causes the problem. 
The former one is interesting to me because if L2 support can actually discover the root cause, 
then usually the problem is we omit some bugs in our product. Then, as a fresh grad, I can learn a ton about product code-wise. 
However, the latter one can be extremely boring: incompetent L2 support tries to spam alert emails all day long even calling your late night in order to 
tell you how serious they think the problem are, and then you skimmed the problem with sleepy eyes, and the problems turn out to be some config issues… 
This experience can transcend from boring to frustrating when 90% of requests can be fallen into this category…

However, the bright side is even in those boring cases, you can still learn a ton about product, which cannot easily obtain by staring at code solely. 
It is called user experience. My first impression with our team’s product is that it is extremely powerful: user can query different kind of data sources 
(i.e. Oracle, Teradata) with DB2 interface only. This is cool… but the price that imposed on the user is that they need to go through some tedious setup 
procedures: check if the type of ODBC driver matches with product; check if ODBC env variables are correctly set; 
check if FS env variables are correctly set. All those things are not included in installation script, which means that user have to do them manually. 
After seeing all those trivial requests, I think automation has to be done fast and right… So, lucky enough, my team’s tech lead support my idea, 
and I’m on my way to save life. I will never sort out how important the automation setup of our product can be without reading through tons of config 
type of problem requests sent out by L2 support.

So, the conclusion of this verbose whining is that: I’m pretty happy with my job for now.

Have a nice day!

.. disqus::
