#Mandatory Reviewer: 
#Zhi Tong

*****************************
*Problem Description and Fix*
*****************************

#fetchFlag value in oracle wrapper is overflowed when DB2_REQUESTS_IO_BLOCK_BUF value is large
#https://w3-01.sso.ibm.com/software/servdb/crm/secure/l3PmrRecord1.do?&pmrno=05271&bno=49R&cno=000&createDate=O15/04/07&method=retrieveCRMWithDate

************
*Root cause*
************

#The maximum allowed value for DB2_REQUESTS_IO_BLOCK_BUF (i.e. SQLQG_REQUESTS_IO_BLOCK_BUF_MAX) is too large for 'fetchFlag' variable with data type sqlint32 in oracle wrapper.

**********
*Solution*
**********

#- Reduce the value of SQLQG_REQUESTS_IO_BLOCK_BUF_MAX from 1024 to 512 (sqlqg_df.h)
#- Add 'SQLQG_REQUESTS_IO_BLOCK_BUF_MAX_OLD 1024' to tolerate users that already have the original MAX value 1024 written to their catalog (sqlqg_df.h) 
#- Change the data type of 'fetchFlag' to Uint32 b/c sqlint32 (-2^31 ~ 2^31-1) while Uint32 (0 ~ 2^32-1)  (sqlqg_net8_operation.C)
#- Add logic in unfencedServer:: initialize_server to update catalog to 512 (sqlqg_unfenced_server.C) 
#- Use SQLQG_REQUESTS_IO_BLOCK_BUF_MAX_OLD to tolerate users that already have the original MAX value 1024 written to their catalog (sqlqg_unfenced_server.C)

************
*Files List*
************

#code branch:  temp_iidev20_db2_v101fp3_hzy

****
*UT*
****

#ad hoc UT using pdTrace (see pmr.clp for ad hoc UT)

*****************
*Additional Info*
*****************

#	Modification is based upon Jing Jing's Defect: wsdbu00797908
#
#	short buffersize = row_width * fetchFlag (roughly)
#	(i.e. row_width is like this, if a table is defined as create table t1(i int, c char(20)), row_width is  
#                  4(int)+20(char) = 24 )
#	when row_width is extremely small, buffersize ~ fetchFlag, which can lead to overflow sqlint32 when     
#            buffersize is large
#   

# SB 34763 with this code fix. However, this SB breaks the functionality of SB 34380. One of the doubts is that SB 34763
# doesn't contain the previous code change in SB 34380. So, I was asked to verify that SB 34763 contains the code change for SB 34380.
# This leads me to build a tool: cmpsb . It will check if the previous SB code change contained in the current SB by comparing code change files.
# Details see `cmpsb` `check_whether_a_SB_contains_previous_SB_fix_code.doc`

*************	
*Future TODO*
*************	

#	
#	Fill up defect wsdbu01303074 - APAR IT10945 

