.. sed.rst:

############
SED
############

Last Update: |today|


Delete a line containing a specific string using sed
----------------------------------------------------

::

   sed '/pattern to match/d' ./infile

.. note::

   - You can redirect the output with ``sed '/pattern to match/d' ./infile > ./newfile``.
   - If you want to do an in-place edit then you can add the ``-i`` flag to sed as in ``sed -i '/pattern to match/d' ./infile``. Note that the ``-i`` flag requires GNU sed and is not portable
