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
