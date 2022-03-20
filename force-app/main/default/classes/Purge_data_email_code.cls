public class Purge_data_email_code
{

/*
echo "Purging startdate  : $(date)" > /siebel/FGB_R0/logs/purgeshell.txt
cd /siebel/FGB_R0/bin
#go to path containing sql scripts
. ./ssh_params.sh
echo "********************************************* PURGE_DATA_BDU_CUTOMER_PROC *********************************************"
echo "***********************************************************************************************************************"
echo "<"`date`">:Starting..." 
/siebel/FGB_R0/bin/EIM_LOAD.sh NOSETUP NOSETUP NOPROC NOINPUT PURGE_DATA PURGE_DATA_PKG.PURGE_DATA_BDU_CUTOMER_PROC NOIFB NOVAL NOVAL
Batch_count=`sqlplus -s $sbl_connectstring <<EOF
set feedback off;
set heading off;
SELECT COUNT(1) FROM SIEBEL.EIM_CAMP_CON WHERE IF_ROW_BATCH_NUM LIKE '5001%'; 
EXIT;
EOF`
CampignProcessedRecords=`sqlplus -s $sbl_connectstring <<EOF
set feedback off;
set heading off;
SELECT COUNT(1) FROM SIEBEL.EIM_CAMP_CON WHERE IF_ROW_BATCH_NUM LIKE '5001%' AND IF_ROW_STAT = 'FOR_DELETE'; 
EXIT;
EOF`
Batch_count=`expr $Batch_count`
if [[ "$Batch_count" -eq 0 ]]
then
    echo "There are NO records for EIM Processing"
else
    /siebel/FGB_R0/bin/EIM_LOAD.sh NOSETUP NOSETUP NOPROC NOINPUT PURGE_DATA NOPROC PURGE_DATA_BDU_CUTOMER NOVAL NOVAL
fi
CampignProcessedSucessRecords=`sqlplus -s $sbl_connectstring <<EOF
set feedback off;
set heading off;
SELECT COUNT(1) FROM SIEBEL.EIM_CAMP_CON WHERE IF_ROW_BATCH_NUM LIKE '5001%' AND IF_ROW_STAT = 'DELETED';
EXIT;
EOF`
CampignProcessedFailedRecords=`sqlplus -s $sbl_connectstring <<EOF
set feedback off;
set heading off;
SELECT COUNT(1) FROM SIEBEL.EIM_CAMP_CON WHERE IF_ROW_BATCH_NUM LIKE '5001%' AND IF_ROW_STAT NOT IN ('DELETED','NO_SUCH_RECORD');
EXIT;
EOF`

echo "************* BDU_CUTOMER Email Notification ************************"
Emailids=`sqlplus -s $sbl_connectstring <<EOF
set feedback off;
set heading off;
select desc_text from siebel.s_lst_of_val where type='FAB_CRM_PURGE_EMAILS';
EXIT;
EOF`
ExecutionDate=$(date +%c)
ExecutionDate=$ExecutionDate
mailx -s "PURGE_DATA_BDU_CAMPAIGN_MEMBERS" $Emailids <<EOF

Dear Employee,

-------------START of BDU Campign Member Archival Post-Execution Report-------------

Execution Date: $ExecutionDate 

Total Number of Records loaded for processing :$CampignProcessedRecords
Total Number of Records successfully Archived and Purged :$CampignProcessedSucessRecords
Total Number of Records Failed While Purging : $CampignProcessedFailedRecords

------------------------------------------------------------------------------------------- 

--------------END of BDU Campign Member Archival Post-Execution Report-----------


Note: This report is generated automatically. Please do not reply back.

Regards,
FAB CRM
EOF
echo "********************************************* Email Notification **********************"

echo "<"`date`">:Ended..."
echo "=========================== PURGE_DATA_BDU_CUTOMER_Deletion END =========================="


#######################################################################################

cd /siebel/FGB_R0/bin
. ./ssh_params.sh
echo "********************************************* PURGE_DATA_List_Management *********************************************"
echo "***********************************************************************************************************************"
echo "<"`date`">:Starting..."
/siebel/FGB_R0/bin/EIM_LOAD.sh NOSETUP NOSETUP NOPROC NOINPUT PURGE_DATA PURGE_DATA_PKG.PURGE_DATA_List_Management NOIFB NOVAL NOVAL
Batch_count=`sqlplus -s $sbl_connectstring <<EOF
set feedback off;
set heading off;
SELECT COUNT(1) FROM SIEBEL.EIM_CALL_LST WHERE IF_ROW_BATCH_NUM LIKE '6001%'; 
EXIT;
EOF`
ListManagementProcessedRecords=`sqlplus -s $sbl_connectstring <<EOF
set feedback off;
set heading off;
SELECT COUNT(1) FROM SIEBEL.EIM_CALL_LST WHERE IF_ROW_BATCH_NUM LIKE '6001%' AND IF_ROW_STAT = 'FOR_DELETE'; 
EXIT;
EOF`
Batch_count=`expr $Batch_count`
if [[ "$Batch_count" -eq 0 ]]
then
    echo "There are NO records for EIM Processing"
else
    /siebel/FGB_R0/bin/EIM_LOAD.sh NOSETUP NOSETUP NOPROC NOINPUT PURGE_DATA NOPROC PURGE_DATA_List_Management NOVAL NOVAL
fi
ListManagementProcessedSucessRecords=`sqlplus -s $sbl_connectstring <<EOF
set feedback off;
set heading off;
SELECT COUNT(1) FROM SIEBEL.EIM_CALL_LST WHERE IF_ROW_BATCH_NUM LIKE '6001%' AND IF_ROW_STAT = 'DELETED';
EXIT;
EOF`
ListManagementProcessedFailedRecords=`sqlplus -s $sbl_connectstring <<EOF
set feedback off;
set heading off;
SELECT COUNT(1) FROM SIEBEL.EIM_CALL_LST WHERE IF_ROW_BATCH_NUM LIKE '6001%' AND IF_ROW_STAT NOT IN ('DELETED','NO_SUCH_RECORD');
EXIT;
EOF`

echo "************* List_Management Email Notification ************************"
Emailids=`sqlplus -s $sbl_connectstring <<EOF
set feedback off;
set heading off;
select desc_text from siebel.s_lst_of_val where type='FAB_CRM_PURGE_EMAILS';
EXIT;
EOF`
ExecutionDate=$(date +%c)
ExecutionDate=$ExecutionDate
mailx -s "PURGE_DATA_List_Management" $Emailids <<EOF

Dear Employee,

-------------START of List Management Archival Post-Execution Report-------------

Execution Date: $ExecutionDate

Total Number of Records loaded for processing :$ListManagementProcessedRecords
Total Number of Records successfully Archived and Purged :$ListManagementProcessedSucessRecords
Total Number of Records Failed While Purging : $ListManagementProcessedFailedRecords

------------------------------------------------------------------------------------------- 

--------------END of List Management Archival Post-Execution Report-----------


Note: This report is generated automatically. Please do not reply back.

Regards,
FAB CRM
EOF
echo "********************************************* Email Notification END **********************"
echo "<"`date`">:Ended..."
echo "=========================== PURGE_DATA_List_Management_deletion END =========================="
touch -am /siebel/FGB_R0/logs/PURGE_DATA_List_Management_SUCCESS.txt

#######################################################################################
cd /siebel/FGB_R0/bin
. ./ssh_params.sh
echo "********************************************* PURGE_DATA_CROSS_SELL_LEADS *********************************************"
echo "***********************************************************************************************************************"
echo "<"`date`">:Starting..." 
/siebel/FGB_R0/bin/EIM_LOAD.sh NOSETUP NOSETUP NOPROC NOINPUT PURGE_DATA PURGE_DATA_PKG.PURGE_DATA_CROSS_SELL_LEADS NOIFB NOVAL NOVAL
Batch_count=`sqlplus -s $sbl_connectstring <<EOF
set feedback off;
set heading off;
SELECT COUNT(1) FROM SIEBEL.EIM_LEAD WHERE IF_ROW_BATCH_NUM BETWEEN 299 AND 799; 
EXIT;
EOF`
CrosssellProcessedRecords=`sqlplus -s $sbl_connectstring <<EOF
set feedback off;
set heading off;
SELECT COUNT(1) FROM SIEBEL.EIM_LEAD WHERE IF_ROW_BATCH_NUM BETWEEN 299 AND 799 AND IF_ROW_STAT = 'FOR_DELETE'; 
EXIT;
EOF`
Batch_count=`expr $Batch_count`
if [[ "$Batch_count" -eq 0 ]]
then
    echo "There are NO records for EIM Processing"
else
    /siebel/FGB_R0/bin/EIM_LOAD.sh NOSETUP NOSETUP NOPROC NOINPUT PURGE_DATA NOPROC PURGE_DATA_CROSS_SELL NOVAL NOVAL
fi
CrosssellProcessedSucessRecords=`sqlplus -s $sbl_connectstring <<EOF
set feedback off;
set heading off;
SELECT COUNT(1) FROM SIEBEL.EIM_LEAD WHERE IF_ROW_BATCH_NUM BETWEEN 299 AND 799 AND IF_ROW_STAT = 'DELETED';
EXIT;
EOF`
CrosssellProcessedFailedRecords=`sqlplus -s $sbl_connectstring <<EOF
set feedback off;
set heading off;
SELECT COUNT(1) FROM SIEBEL.EIM_LEAD WHERE IF_ROW_BATCH_NUM BETWEEN 299 AND 799 AND IF_ROW_STAT NOT IN ('DELETED','NO_SUCH_RECORD');
EXIT;
EOF`

echo "************* Cross sell Leads Email Notification ************************"
Emailids=`sqlplus -s $sbl_connectstring <<EOF
set feedback off;
set heading off;
select desc_text from siebel.s_lst_of_val where type='FAB_CRM_PURGE_EMAILS';
EXIT;
EOF`
ExecutionDate=$(date +%c)
ExecutionDate=$ExecutionDate
mailx -s "PURGE_DATA_CrossSell_Leads" $Emailids <<EOF

Dear Employee,

-------------START of Cross Sell Leads Archival Post-Execution Report-------------


Execution Date: $ExecutionDate

Total Number of Records loaded for processing :$CrosssellProcessedRecords
Total Number of Records successfully Archived and Purged :$CrosssellProcessedSucessRecords
Total Number of Records Failed While Purging : $CrosssellProcessedFailedRecords

------------------------------------------------------------------------------------------- 

--------------END of Cross Sell Leads Archival Post-Execution Report-----------


Note: This report is generated automatically. Please do not reply back.

Regards,
FAB CRM
EOF
echo "********************************************* Email Notification END **********************"
echo "<"`date`">:Ended..."
echo "=========================== PURGE_DATA_CROSS_SELL_LEADS_Deletion END =========================="

#######################################################################################

cd /siebel/FGB_R0/bin
. ./ssh_params.sh
echo "********************************************* PURGE_DATA_NBAD_BDU_LEADS *********************************************"
echo "***********************************************************************************************************************"
echo "<"`date`">:Starting..." 
/siebel/FGB_R0/bin/EIM_LOAD.sh NOSETUP NOSETUP NOPROC NOINPUT PURGE_DATA PURGE_DATA_PKG.PURGE_DATA_NBAD_BDU_LEADS NOIFB NOVAL NOVAL
Batch_count=`sqlplus -s $sbl_connectstring <<EOF
set feedback off;
set heading off;
SELECT COUNT(1) FROM SIEBEL.EIM_LEAD WHERE IF_ROW_BATCH_NUM BETWEEN 20010000 AND 20010500; 
EXIT;
EOF`
NbadBDULeadsProcessedRecords=`sqlplus -s $sbl_connectstring <<EOF
set feedback off;
set heading off;
SELECT COUNT(1) FROM SIEBEL.EIM_LEAD WHERE IF_ROW_BATCH_NUM BETWEEN 20010000 AND 20010500 AND IF_ROW_STAT = 'FOR_DELETE'; 
EXIT;
EOF`
Batch_count=`expr $Batch_count`
if [[ "$Batch_count" -eq 0 ]]
then
    echo "There are NO records for EIM Processing"
else
    /siebel/FGB_R0/bin/EIM_LOAD.sh NOSETUP NOSETUP NOPROC NOINPUT PURGE_DATA NOPROC PURGE_DATA_NBAD_BDU_LEADS NOVAL NOVAL
fi
NbadBDULeadsProcessedSucessRecords=`sqlplus -s $sbl_connectstring <<EOF
set feedback off;
set heading off;
SELECT COUNT(1) FROM SIEBEL.EIM_LEAD WHERE IF_ROW_BATCH_NUM BETWEEN 20010000 AND 20010500 AND IF_ROW_STAT = 'DELETED';
EXIT;
EOF`
NbadBDULeadsProcessedFailedRecords=`sqlplus -s $sbl_connectstring <<EOF
set feedback off;
set heading off;
SELECT COUNT(1) FROM SIEBEL.EIM_LEAD WHERE IF_ROW_BATCH_NUM BETWEEN 20010000 AND 20010500 AND IF_ROW_STAT NOT IN ('DELETED','NO_SUCH_RECORD');
EXIT;
EOF`

echo "************* NBAD_BDU_LEADS Email Notification ************************"
Emailids=`sqlplus -s $sbl_connectstring <<EOF
set feedback off;
set heading off;
select desc_text from siebel.s_lst_of_val where type='FAB_CRM_PURGE_EMAILS';
EXIT;
EOF`
ExecutionDate=$(date +%c)
ExecutionDate=$ExecutionDate
mailx -s "PURGE_DATA_NBAD_BDU_LEADS" $Emailids <<EOF

Dear Employee,

-------------START of NBAD BDU Leads Archival Post-Execution Report-------------


Execution Date: $ExecutionDate

Total Number of Records loaded for processing :$NbadBDULeadsProcessedRecords
Total Number of Records successfully Archived and Purged :$NbadBDULeadsProcessedSucessRecords
Total Number of Records Failed While Purging : $NbadBDULeadsProcessedFailedRecords
*/

}