.. _disqus.rst:

######################
Add disqus into doc
######################

.. _`site`: http://xiaming.me
.. _`pelican`: http://blog.getpelican.com
.. _`fresh`: https://github.com/jsliang/pelican-fresh/
.. _`doc`: http://docs.getpelican.com/en/3.63/
.. _`disqus`: https://disqus.com
.. _`sphinxcontrib-newsfeed`: https://pypi.python.org/pypi/sphinxcontrib-newsfeed

One of the driven factors that I want to remake my own personal website is that one day I saw this cool `site`_. I really want to have some interaction
with unknown readers (I mean you :)) while also having some chance to keep improving based upon feedbacks (again, I mean yours :)). However,
I am reluctant to adopt the easy-out way: learn `pelican`_ --> use `fresh`_ them --> start writing. This mainly because I love Sphinx documentation style.
So clean, so elegant (BTW, even `pelican`_ use Sphinx to do their `doc`_, haha). After some experimenting, I finally make it work and I'll document it for
future reference:

******************
Do It On Your Own
******************

1. Once you register a website in `disqus`_, you will direct to *Installation* section. You choose *Universal Code* and will get a chunk of code that
asks you to "Place the following code where you'd like Disqus to load"::

    <div id="disqus_thread"></div>
         <script>
             /**
              * RECOMMENDED CONFIGURATION VARIABLES: EDIT AND UNCOMMENT THE SECTION BELOW TO INSERT DYNAMIC VALUES FROM YOUR PLATFORM OR CMS.
              * LEARN WHY DEFINING THESE VARIABLES IS IMPORTANT: https://disqus.com/admin/universalcode/#configuration-variables
              */
              /*
               var disqus_config = function () {
               this.page.url = PAGE_URL; // Replace PAGE_URL with your page's canonical URL variable
               this.page.identifier = PAGE_IDENTIFIER; // Replace PAGE_IDENTIFIER with your page's unique identifier variable
               };
               */
               var disqus_shortname = 'zeyuan'; // required: replace example with your forum shortname 
               (function() { // DON'T EDIT BELOW THIS LINE
               var d = document, s = d.createElement('script');
               s.src = '//zeyuan.disqus.com/embed.js';
               s.setAttribute('data-timestamp', +new Date());
               (d.head || d.body).appendChild(s);
               })();
         </script>
    <noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript" rel="nofollow">comments powered by Disqus.</a></noscript>

.. note::

    You need to add ``var disqus_shortname = 'zeyuan';`` to the code chunk provided by disqus, and make it look like above.

2. Then, inside Sphinx-doc, you can add the code chunk above to your preferred rst files with a 
   `raw directive <http://docutils.sourceforge.net/docs/ref/rst/directives.html#raw-data-pass-through>`_. For example, inside ``foo.rst``::

        ====================================
        Nice Example to show disqus comment
        ====================================

        I would like to show how to add disqus comment in this page.

        .. raw:: html

            <the code chunk>

3. Essentially, adding disqus to Sphinx-doc is done by step 2. However, I would like to add one more layer of encapuslation to make everything looks
   nicer. I create a rst file called ``comment.rst`` and it looks like following:

   .. literalinclude:: /comment.rst

   Then, whenever I want to add disqus comment, I can simply add::

        .. include:: comment.rst

   to wherever I want disqus comment section appear.

4. If you want to further adjust the width of disqus appears in Sphinx-Doc, I think 
   `this repo <https://github.com/whiteinge/eseth/blob/master/static/base-eseth.css>`_ should be a good reference. 

.. note::

    The repo is also a awesome study material to create your own sphinx template and make it to a blog site.

******************
Extension to Shine
******************

Of course, we can definitely look for extensions to help us to solve the problem. The plugin I use is `sphinxcontrib-newsfeed`_, it comes with a support
of Disqus. It is nice and does work for me.


