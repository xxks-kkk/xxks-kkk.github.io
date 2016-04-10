.. _software-engineer.rst:

#####################
Way to be pro
#####################

2015-09-05


This is some experience I got after I have worked *professionally* as a progrmmer in the industry for a few months.

**********************************************
Be aware of coding convention used in the file
**********************************************

What’s the difference between the following two chunks of code?

.. code-block:: cpp
   :caption: block A

    if (block_buf > REQUESTS_BLOCK_BUF_MAX){

    my_requests_block_buf = REQUESTS_BLOCK_BUF_MAX;

    } else {

    my_requests_block_buf = block_buf;

    }

.. code-block:: cpp
   :caption: block B

    if (block_buf > REQUESTS_BLOCK_BUF_MAX)
    {
      my_requests_block_buf = REQUESTS_BLOCK_BUF_MAX;
    }
    else
    {
      my_requests_block_buf = block_buf;
    }

I guess you would say they are literally the same. In fact, that was what I thought initially, and I chose to write the code like the first one. 
However, in the code review, this chunk of code is commented by reviewer “Note the coding convention in the file.” 
Then I realized with more than 3,000 lines of code, all the condition structure is following the second one I listed above. 
So, consistency in style is really the key in professional programming. By the way, block A follows 1TBS style while block B follows Allman style. More
info on `wiki indent style <https://en.wikipedia.org/wiki/Indent_style>`_

***********************************
Don’t add redundant debug statement
***********************************

Following the code chunk I added above, it is probably natural to add a printout statement to see if ``my_requests_block_buf`` is actually set to the 
right value. So, I added:

.. code-block:: cpp

    pdTraceData1(FUNCTION_TRACE_ID, 
                 1992, 
                 PD_SINT(my_requests_block_buf));

However, this statement may not be OK in the professional setting. There is a clear cutline between what can include in development phase and what should 
include in actual product. The debug statement is OK for development phase: developer need to immediately make sure everything work correctly so far 
before moving on to next part, and this is exactly the incremental development philosophy. But, once developer are pretty sure the value he get is correct, 
he need to delete the debug statement. With excessive debug statements, the performance of product hurts. 

********************************
Treat comment as serious as code
********************************

I developed a bad habit to joke around in the comment during the college, and I somewhat carry it out to the real job. This is one of the comments I wrote 
in my recent work:

.. code-block:: cpp

    // cheat on initialize_server() function
    #define REQUESTS_BLOCK_BUF_MAX_OLD 1024  

If this comment appears in a hobby project or the project that shared with limited people, it will be fine. 
However, it might not be appropriate when comes to real business. And, this comment is essentially useless: 
why named “OLD”? What do you mean by “cheating”? My fellow developers will have no clue what I am trying to convey here.


.. disqus::
