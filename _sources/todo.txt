.. _todo:

.. this is just a list of features or bugs about this website that
   I need to implement or fix someday in the future.

.. manually add strikethrough. see <http://stackoverflow.com/questions/6518788/rest-strikethrough>

.. role:: strike
   :class: strike

===============
About this site
===============

Last Update: |today|

Why zhu45.org?
--------------

This is a really really good question and I'm glad you have thought about to ask in your mind :). "zhu45" comes from my
email address back to college, which is "zhu45@wisc.edu" (I believe it comes from [z]eyuan [hu], and I'm the 45th "zhu").
Sometimes, people guess my lastname based upon it. So, sometimes, I got addressed as "Mr. Zhu", and it can happen even
for my new friends. So, I think it is funny to keep using this old email address even for my website. Also, one side
note, "zhu" in Chinse has same prounciation as "猪", which is "pig" in English. Pig represents fortune and luck in 
Chinse culture. "45" sounds like "是我" in Chinsese, and means "This is me". 
Those two parts combined into "我是猪" in Chinse, and "I'm a pig" in English. This gives a very cute scene in my mind if 
you can equate pig with `Piglet <https://en.wikipedia.org/wiki/Piglet_%28Winnie-the-Pooh%29>`_  

Why Sphinx?
------------

Reasons that why I choose Sphinx to implement my personal website are the following:

* extremely organizable toolset that allows me to document the projects easily and efficiently.

* a great learning tool for me to transit into Django Web framework.

* Use Python to manage the whole website!


Why not a blog?
---------------

This is the question that I have asked myself several times since I began to want to construct a personal website back
to 2012. It seems more like a web design question. However, I don't have rigorous training about web design. The only
thing I know is that the design has to serve my pupose well. Then, I start to think about it. Of course, the first thing
is a showcase of who I really am, and more importantly, I want to carefully document my knowledge in certain way that
I can easily browse to find what I have done in the past to avoid reinventing wheels. Of course, this is also for my
audience: someone who happen to come to my world to look for something that might be useful for them. By this standard, 
blog format may not be appropriate:

* Blog doesn't organize stuff in an intuitive way. Most of them are based upon timestamp or the word cloud, which is 
  not quite fit with one of my goals (*document knowledge*).

* Blog puts much pressure on the writer (me). It offers you a lot impulse to write something that may not worth to write
  about at the first place. If you scan through the archives, and you may get terrified on how lazy you can possibly be.
  And this may get you some energy button to start a new post talking about how nice today's weather is.

* Blog has to be written in an article way. This may be an extension of the point above. I have to care about the structure
  of the content, and the sentence I use. The major part of the site is just want to doucment stuff. I don't really 
  care about I should offer some intro to shell language if all I want to do is to document ``echo 'hello world'`` usage. 

**UPDATE(03/13/16):** OK, I got a :ref:`blog <blog.rst>`. So, I guess above doesn't hold anymore.

TODO List
-----------

This is a collection of features or bugs about this website that
I need to implement or fix someday in the future.

* :strike:`change the project list page to make some subtitle.`

* indicate the progress of each project (done or under development) at the end of each title:
  ie. Myproject (*done*) or Myproject2 (*under development*)

* customize the pygments code highlighting color.
  
  This is one `coloring example <http://www.dellsystem.me/posts/pi-code/>`_ 
  I really like

* add the exception highlighting into ipython_highlighting extension.

* add one config value to newsfeed extension to not allow disqus to autoload.

* :strike:`customize more about navbar to make it more "fashion"`

* add python gallery like `matplotlib`_, present all the graph I have done so far via python.

* build *IDLE* style for pygments

* :strike:`fix the weird display of the heading "regular expression" in
  projects > study notes > dive into python study notes > general python
  programming > regular expression`

* :strike:`figure out how to add metadata (i.e. keywords, author, description) into
  the HTML pages.`

* figure out a way to better organize blog article:

    - allow group "blogs" by tags
    - archive by dates

.. include:: links.rst
