.. _linux-cmd.rst:

#####################
Useful Linux Cmds
#####################

Last Update: |today|

Collections of linux commands that I collect during the work and other fun activities. 

- cat line X (i.e. ``46``) to line Y (i.e. ``396``) on a file (i.e. ``db2odbct_statement.h``)::

        awk 'NR<=396 && NR >=46' db2odbct_statement.h > $HOME/hive_server_opts.txt


- terminate telnet session::

        "ctrl" "]"
        "enter"
        telnet> quit (enter)
        
- sort the files in a directory by modification date::

        ls -lrt

- find certain files from /root::

        find / -name version.h

- cd back into the directory where I come from::

        cd -

- tar a directory::

        tar -cf vmblock.tar vmblock-only

- tar a directory with gzip::

        tar -zcvf archive-name.tar.gz directory-name

.. note::

        -z: using gzip
        -c: Create archive
        -v: Verbose; diplay progress while creating archive
        -f: Archive file name

.. note::

        If GNU tar is not supported, then try
        ``tar -cvf - file1 file2 dir3 | gzip > archive.tar.gz``

- untar a directory::

        tar -xvf vmblock.tar

- untar ``tar.gz``::

        tar -zxvf prog-1-jan-2005.tar.gz

.. note::

        1. To change directory using ``-C`` option: ``tar -zxvf data.tar.gz -C /data/projects``
      
- To view a detailed table of contents (list all files) for this archive::

        tar -tzvf data.tar.gz

- recursively remove all the files under certain directory (force)::

        rm -rf [dirname]

- list all network interface::

        ifconfig -a

- Enter text mode in RHEL::

      "ctrl" + "Alt" + "F5"

- Exit text mode in RHEL (aka back to GUI mode in RHEL)::

      "ctrl" + "Alt" + "F1"

- Bring up VNC menu::

      "F8"

- Check memory info::

      cat /proc/meminfo

- Create a symboli link::

      ln -s [path] [symbol]

- view pdf on RHEL::

      evince [pdf file]

- compile tex to pdf::

      pdflatex [tex file]

- quickly find the function get called in terminal

For example, I want to find out where ``foo`` get called in the code under
current directory. I can do ``grep "foo" ./*``

- invert match with ``grep``

For example, I want to find out where ``foo`` exist in a file called ``test.txt`` but
I know ``foo`` pattern also appears in ``fooBar``. I am only interested in ``foo`` not ``fooBar`` and I want
to exclude ``fooBar`` from my ``grep`` result. So, I do the following::

    grep -i "foo" test.txt | grep -i -v "Bar"

``-v`` will do invert-match and select non-matching lines.

- find the size of files and directory under the current path::

        $ du -sh ./*                      
        8.0K    ./010616.txt
        12K     ./autorun
        86M     ./autosetup
        35M     ./bin
        4.0K    ./build
        ...

- find the total size of current path::

        $ du -slh
        1.5G    .

- Convert decimal to hex::

        $ printf "%x\n" 4095      
        fff

- Convert hex to decimal::

        $ printf "%d\n" 0xfff
        4095

- untar tar.gz file in AIX::

        gzip -dc ../iidev3/LL.tar.gz | tar xf -

- re-execute the last command::

        !!        

- check the current key bindings (ie. 'C-z' means suspend job) in linux::

        stty -a

.. note::

        ``stty sane`` alows you to reset linux key bindings to default

- view the last few lines of a growing file, updated continuously. Typically used on log files.::

        tail -f <fname>

- How do I terminate all the subshell processes?

.. topic:: situation & solution

   Before running ``quicktest``, I need to do some environment cleanup. One is the following:
   bunch of ksh subshell spawned by previous failling run of the ``quicktest``
   
   ::

     $ ps -ef | grep $USER | grep -i  ksh
     iidev20 41884258        1   0   Jan 12      -  0:00 /bin/ksh
     iidev20 47847944        1   0   Jan 12      -  0:00 /bin/ksh
     iidev20 48175782        1   0   Jan 12      -  0:00 /bin/ksh
     iidev20 48568844        1   0   Jan 12      -  0:00 /bin/ksh
     iidev20 48962098        1   0   Jan 12      -  0:00 /bin/ksh
     iidev20 51452430        1   0   Jan 12      -  0:00 /bin/ksh
     iidev20 51911282 42670878   0 20:01:22 pts/14  0:00 -ksh
     iidev20 52435526        1   0   Jan 12      -  0:00 /bin/ksh
     iidev20 53353172 51911282   0 20:10:10 pts/14  0:00 grep -i ksh
     iidev20 53746290 51452430   0 20:10:12      -  0:00 [ksh]
     iidev20 54925980        1   0   Jan 12      -  0:00 /bin/ksh
     iidev20 54991516        1   0   Jan 12      -  0:00 /bin/ksh
     iidev20 55319050        1   0   Jan 12      -  0:00 /bin/ksh
     iidev20 56564280        1   1   Jan 12      -  0:00 /bin/ksh
     iidev20 56629820        1   0   Jan 12      -  0:00 /bin/ksh
     idev20 56761056 57088598   0 20:10:12      -  0:00 [ksh]
     iidev20 57088598        1   0   Jan 12      -  0:00 /bin/ksh
     iidev20 27794224        1   0   Jan 12      -  0:00 /bin/ksh
     iidev20 37231548        1   0   Jan 12      -  0:00 /bin/ksh
     iidev20 38607672        1   0   Jan 12      -  0:00 /bin/ksh
     iidev20 39459788        1   0   Jan 12      -  0:00 /bin/ksh
     iidev20 39590792        1   0   Jan 12      -  0:00 /bin/ksh
     iidev20 40442654        1   0   Jan 12      -  0:00 /bin/ksh
     iidev20 40704830        1   0   Jan 12      -  0:00 /bin/ksh
     iidev20 41098026        1   0   Jan 12      -  0:00 /bin/ksh
     iidev20 41425770        1   0   Jan 12      -  0:00 /bin/ksh
     iidev20 41622506        1   0   Jan 12      -  0:00 /bin/ksh
     iidev20 41819118        1   0   Jan 12      -  0:00 /bin/ksh
     iidev20 43129802        1   0   Jan 12      -  0:00 /bin/ksh
     iidev20 43326448        1   0   Jan 12      -  0:00 /bin/ksh
     iidev20 43457532        1   0   Jan 12      -  0:00 /bin/ksh
     iidev20 43719666 48044666   0   Jan 12 pts/11  0:00 /bin/ksh
     iidev20 45423402        1   0   Jan 12      -  0:00 /bin/ksh
     iidev20 45685562        1   0   Jan 12      -  0:00 /bin/ksh
     iidev20 11738936 15801888   0   Jan 21  pts/1  0:00 -ksh
     iidev20 65216648 43129802   0 20:10:12      -  0:00 [ksh]
     iidev20 10232638 41425770   0 20:10:12      -  0:00 [ksh]

   The I found one `solution on stackoverflow <http://stackoverflow.com/questions/8363519/how-do-i-terminate-all-the-subshell-processes>`_ . It works amazingly well:

   ::

      $ trap "kill 0" SIGINT
      $ ps -ef | grep $USER | grep -i  ksh
      iidev20 64100700 51911282   0 20:23:07 pts/14  0:00 grep -i ksh
      iidev20 51911282 42670878   0 20:01:22 pts/14  0:00 -ksh
      iidev20 43719666 48044666   0   Jan 12 pts/11  0:00 /bin/ksh
      iidev20 11738936 15801888   0   Jan 21  pts/1  0:00 -ksh
        
   So, what exactly ``trap "kill 0" SIGINT`` does?

   - ``SIGINT`` is a `Unix signal <https://en.wikipedia.org/wiki/Unix_signal>`_, which by default causes the process to
     terminate.
   - trap [ action, condition ...] (here, action is `kill 0`` and condition is ``SIGINT``) let shell read and execute the
     action when one of the corresponding conditions arises. In this case, ``kill 0`` will be executed when ``SIGINT``
     arises. To know about trap, run ``man trap``
   - ``kill 0`` kills all the members of the process group of the caller. In our case, caller is ``ksh`` and it will kill
     all the process belongs to the same group as ``ksh``, which are subshells. `This answer <http://unix.stackexchange.com/questions/67532/what-does-kill-0-do-actually>`_ gives detail explanation about ``kill 0``. Also, don't confuse with `kill -0 <http://unix.stackexchange.com/questions/169898/what-does-kill-0-do?rq=1>`_
   
- output text to both screen and file inside a shell script::

    command | tee -a "$log_file"

.. note::

    ``tee`` saves input to a file (use ``-a`` to append rather than overwrite), and copies the input to standard output as well.


- A simple implementation to ``watch`` command in Linux::

    # $1 is the number of iterations you'd like to run
    # $2 is the amount of time to sleep between iterations (in seconds)
    # $3 is the command you'd like to run

    i=0

    while test "$i" -lt $1
    do
      clear
      $3
      i=`echo $i + 1 | bc`
      sleep $2
    done

.. note::

    This is particularly useful when working with AIX, which has 
    ``watch`` command that works completely different than the one on 
    Linux.

- ``shift``::

    shift [n]
    The  positional parameters from n+1 ... are renamed to $1 .... 
    If n is not given, it is assumed to be 1.

.. topic:: Example

    Example script::

        #!/bin/bash
        echo "Input: $@"
        shift 3
        echo "After shift: $@"

    run script and shows::

        $ myscript.sh one two three four five six

        Input: one two three four five six
        After shift: four five six

- ``cd`` (without any words after it) will allow you switch back to ``$HOME`` directory immediately

- To create a new screen with name "foo", use ``screen -S foo``

