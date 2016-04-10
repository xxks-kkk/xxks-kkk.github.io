.. _git.rst:

###
Git
###

Git trouble shooting guide. All of the listed problems I have encountered before. 
The solutions provided by link should work because I have tested them by myself

- `Unstaged changes left after git reset --hard <http://stackoverflow.com/questions/11383094/unstaged-changes-left-after-git-reset-hard>`_

- `Remove local(untracked) files from my current Git branch <http://stackoverflow.com/questions/61212/how-do-i-remove-local-untracked-files-from-my-current-git-branch>`_

.. topic:: Problem

     | $ ssh -T git@github.com
     | Agent admitted failure to sign using the key.
     | Permission denied (publickey).

- `Error: Agent admitted failure to sign <https://help.github.com/articles/error-agent-admitted-failure-to-sign>`_
- `Removing multiple files from a Git repo that have already been deleted from disk <http://stackoverflow.com/questions/492558/removing-multiple-files-from-a-git-repo-that-have-already-been-deleted-from-disk>`_
- `[TUTORIAL]Custom domain for github pages <http://www.chenhuijing.com/blog/setting-up-custom-domain-github-pages/>`_

.. note::

   1. You need purchase a domain before you can configure for a custom domain (*of course, why I didn't think about this when I tried to take control of hzy.o
      rg owned by some store at the first place?*). I use `namesilo <https://www.namesilo.com>`_ to get my current domain name like the author did in above
      link.
   2. Put ``CNAME`` inside ``username.github.io``, not the source repo of web if you use two separate repo `one for publish <https://github.com/xxks-kkk/xxks-kkk.github.io>`_ and `one for source code of static generated web <https://github.com/xxks-kkk/source2.github.io.xxks-kkk>`_ like I do.

- `Git on Bitbucket: Always asked for password, even after uploading my public SSH key <http://stackoverflow.com/questions/8600652/git-on-bitbucket-always-asked-for-password-even-after-uploading-my-public-ssh>`_

.. topic:: Push an existing repository ...

	  | $ git remote add origin git@github.com:username/new_repo
	  | $ git push -u origin master

- `Discard unstaged changes in Git <http://stackoverflow.com/questions/52704/how-do-you-discard-unstaged-changes-in-git>`_

- `git checkout -- multiple files <http://stackoverflow.com/questions/24916186/how-to-do-git-checkout-theirs-for-multiple-files-or-all-unmerged-files>`_

- `How do I tell Git for Windows where to find my private RSA key? <http://serverfault.com/questions/194567/how-do-i-tell-git-for-windows-where-to-find-my-private-rsa-key?newreg=0943c080d308458eadbcafa23019d7d4>`_

- `Syncing a fork <https://help.github.com/articles/syncing-a-fork/>`_
