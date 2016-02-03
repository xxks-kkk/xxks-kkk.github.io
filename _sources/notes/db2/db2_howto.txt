.. _db2-howto.rst:

#######################
DB2 HowTOs
#######################

.. note::

        I am trying to port those commands, especially the lengthy ones, to
        `db2mun - a tool to avoid reptitive typing db2 cmds <https://github.com/xxks-kkk/Zeyuan-s-tools/blob/master/db2mun>`_ 


**************
System Catalog
**************
- Check the default Federation Server option in system catalog

::

        db2 "select char(option,10) OPTION, char(setting,10) SETTING \
             from syscat.serveroptions \
             where servername='SERVER1'"

        OPTION     SETTING   
        ---------- ----------
        NODE       hive      
        DBNAME     default   
        CODEPAGE   1252      

        3 record(s) selected.

- Check the procedures registered with database

::

        db2 "SELECT char(ROUTINENAME,15) ROUTINENAME, ROUTINESCHEMA FROM SYSCAT.ROUTINES WHERE OWNER='ZEYUAN HU' AND ROUTINETYPE = 'P'"

        ROUTINENAME     ROUTINESCHEMA
        --------------- -------------------------------------------------------------------------------
        BONUS_INCREASE  ZEYUAN HU
        CHECK_COMM      ZEYUAN HU

        2 record(s) selected.

.. note::

        In this case, show a list of the procedures created by the authorization ID ZEYUAN HU

- show a list of the user-defined routines existing in the database

::

       db2 "SELECT char(ROUTINENAME,15) ROUTINENAME, ROUTINESCHEMA FROM SYSCAT.ROUTINES WHERE OWNER='ZEYUAN HU' AND ROUTINETYPE = 'F'" 

***********
Misc
***********

- Show current available database

::

        db2 list active databases

- Show current active schema

::

        db2 values current schema

- List all existing schemas

::

        $ db2 "select char(schemaname,20) from syscat.schemata" 

        1                   
        --------------------
        SYSIBM              
        SYSCAT              
        SYSFUN              
        SYSSTAT             
        SYSPROC             
        SYSIBMADM           
        SYSIBMINTERNAL      
        SYSIBMTS            
        SYSPUBLIC           
        NULLID              
        SQLJ                
        P0                  
        SYSTOOLS            
        IIDEV28             

        14 record(s) selected.


- Retrieve all table names for a given schema

::

        $ db2 list tables for schema p0

        Table/View                      Schema          Type  Creation time             
        ------------------------------- --------------- ----- --------------------------
        TESTTB                          P0              T     2016-01-10-12.22.45.342023

        1 record(s) selected.

- List all tablespaces for current database

::

        $ db2 list tablespaces

        Tablespaces for Current Database

        Tablespace ID                        = 0
        Name                                 = SYSCATSPACE
        Type                                 = Database managed space
        Contents                             = All permanent data. Regular table space.
        State                                = 0x0000
          Detailed explanation:
            Normal

        Tablespace ID                        = 1
        Name                                 = TEMPSPACE1
        Type                                 = System managed space
        Contents                             = System Temporary data
        State                                = 0x0000
          Detailed explanation:
            Normal

        Tablespace ID                        = 2
        Name                                 = USERSPACE1
        Type                                 = Database managed space
        Contents                             = All permanent data. Large table space.
        State                                = 0x0000
          Detailed explanation:
            Normal

        Tablespace ID                        = 3
        Name                                 = SYSTOOLSPACE
        Type                                 = Database managed space
        Contents                             = All permanent data. Large table space.
        State                                = 0x0000
          Detailed explanation:
            Normal

- list all databases in an instance

::

        => db2 list db directory

        System Database Directory

        Number of entries in the directory = 1

        Database 1 entry:

        Database alias                       = FED
        Database name                        = FED
        Local database directory             = /home/iidev20
        Database release level               = d.00
        Comment                              =
        Directory entry type                 = Indirect
        Catalog database partition number    = 0
        Alternate server hostname            =
        Alternate server port number         =



***********
Security
*********** 

**SYSIBMADM.PRIVILEGES** is a catalog view that holds database object privilege information
for authorization IDs (roles, users) defined in the system catalog table. If the database
was created using ``RESTRICTIVE`` clause, select privilege is not automatically granted to PUBLIC.
If that is the case, one of the following privileges/authorities are needed to query this view:

- SELECT privilege on the PRIVILEGES administrative view
- CONTROL privilege on the PRIVILEGES administrative view
- DATAACCESS authority
- DBADM authority
- SQLADM authority

::

        >db2 select distinct(objecttype) from sysibmadm.privileges

        OBJECTTYPE
        ------------------------
        DB2 PACKAGE
        FUNCTION
        GLOBAL VARIABLE
        INDEX
        MODULE
        PROCEDURE
        SCHEMA
        TABLE
        TABLESPACE
        VIEW
        WORKLOAD

        11 record(s) selected.

- What privileges have been granted to this object?

Given a database object (table/view/alias etc) name "$OBJECTNAME" and its schema "$SCHEMA", here is how to 
check current privileges that users hold for this table

::

        SELECT char(authid, 20) AS authid_id, \
                CASE authidtype \
                        WHEN 'U' THEN 'USER' \ 
                        WHEN 'G' THEN 'GROUP' \
                        WHEN 'R' THEN 'ROLE' \
                END authidtype , \
                privilege \
        FROM sysibmadm.privileges \
        WHERE objectname = '$OBJECTNAME' \
        AND objectschema = '$SCHEMA' \
        ORDER BY authid, authidtype, privilege WITH ur;

- Which privileges have been granted to a role "$ROLE"?

::

        SELECT char(objectschema,10) AS SCHEMA, \
                char(objectname,65) NAME, \
                char(privilege, 10) PRIVILEGE, \
                objecttype \
        FROM sysibmadm.privileges \ 
        WHERE authid='$ROLE' \
        AND authidtype='R' ORDER BY 1,2,3 WITH UR;

.. topic:: Example

        ::

                db2 SELECT char(objectschema,10) AS SCHEMA, \
                db2 (cont.) =>     char(objectname,65) NAME, \
                db2 (cont.) =>     char(privilege, 10) PRIVILEGE, \
                db2 (cont.) =>     objecttype \
                db2 (cont.) => FROM sysibmadm.privileges \
                db2 (cont.) => WHERE authid='SALES' \
                db2 (cont.) => AND authidtype='R' ORDER BY 1,2,3 WITH UR

                SCHEMA     NAME                                                              PRIVILEGE  OBJECTTYPE
                ---------- ----------------------------------------------------------------- ---------- ------------------------
                STOREDB    CUSTOMER                                                          INSERT     TABLE
                STOREDB    CUSTOMER                                                          SELECT     TABLE
                STOREDB    CUSTOMER                                                          UPDATE     TABLE

                3 record(s) selected.

- Which privileges have been granted to a user?

list the privileges granted to a user "$USER" which could be an LDAP ID or OS ID

::

        SELECT char(objectschema,10) AS SCHEMA, \
                char(objectname,65) NAME, \
                char(privilege, 10) PRIVILEGE, \
                objecttype \
        FROM sysibmadm.privileges \ 
        WHERE authid='$USER' \
        AND authidtype='U' ORDER BY 1,2,3 WITH UR;

.. todo::

        you can make a script to contain the above SQLs to avoid repetitive typing. Don't forget to
        add script location to your UNIX's $PATH

.. seealso::

        http://db2talk.com/2014/06/09/quick-primer-on-checking-database-object-privileges-in-db2-luw 

:download:`security commands<security_cmds.txt>`
