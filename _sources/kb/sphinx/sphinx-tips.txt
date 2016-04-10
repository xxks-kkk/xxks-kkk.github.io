.. _sphinx-tips.rst:

################
Tips 
################

Collection of tips when working with `Sphinx-Doc`_. 


- filename provided to a directive is usually relative to the directory the current source file is contained in, but if it absolute (starting with
  :command:`/`), it is taken as relative to the top source directory.

.. topic:: Example

	   ``.. include:: links.rst`` expect a doc ``links.rst`` in the same directory as the current source file. However, ``.. include:: /links.rst``
	   assumes ``links.rst`` in top source directory, which is :command:`source/`

.. include:: /links.rst

- ``:download:`` put the files into the ``_downloads`` directory. However, the path towards this ``_downloads`` directory is absolute path. In other words,
  if you copy your source directory to a different location, and rebuild your source, then you will encounter tons of "downloadable files not found" 
  error. One workaround to this problem is that you direct links the file you want to see, instead of using ``:download:`` directive.

.. topic:: Example

        Instead of using ``:download:`romantest.py </_static/projects/notes/diveintopython/py/romantest.py>```, you can use
        ```romantest.py </_static/projects/notes/diveintopython/py/romantest.py>`_`` to avoid the problem.

.. note::

    This issue has been succesfully `reported and fixed <https://github.com/sphinx-doc/sphinx/issues/2329>`_ and it will ship to next release of 
    Sphinx soon.

- Work with ``toctree``:

   ``toctree`` can be very sensitive with the amount of leading spaces. The following is one toctree printed out under `emacs whitespace mode
   <https://www.emacswiki.org/emacs/WhiteSpace>`_ ::

        $
        ..·toctree::$
        ···:maxdepth:·1$
        $
        ···./gre/verbal.rst$
        ···./gre/writing.rst$
        
   Notice the three dots right before "./gre/verbal.rst". That means there are **three** leading blanks. This is important because based upon my
   experimentation, Sphinx won't be happy with leading blanks either smaller than three or bigger than three. If you mess up with the leading blanks
   under ``toctree``, you may get the error message looks like::

    /home/zeyuan_hu/Documents/zeyuan-s-doc/source/notes/cs/overview.rst:28: WARNING: toctree contains reference to nonexisting document u'notes/cs/ ./gre/verbal'
    /home/zeyuan_hu/Documents/zeyuan-s-doc/source/notes/cs/overview.rst:28: WARNING: toctree contains reference to nonexisting document u'notes/cs/ ./gre/writing'
    /home/zeyuan_hu/Documents/zeyuan-s-doc/source/notes/cs/overview.rst:28: WARNING: toctree contains reference to nonexisting document u'notes/cs/ ./gre/math' 
    /home/zeyuan_hu/Documents/zeyuan-s-doc/source/notes/cs/overview.rst:28: WARNING: toctree contains reference to nonexisting document u'notes/cs/ ./gre/word'    
