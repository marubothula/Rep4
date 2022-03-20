public class W2_INDV_CUST_INSERT_sh{
/*
cd /siebel/FGB_R0/bin
. ./ssh_params.sh
echo "********************************************** Individual Customer Insert *********************************************"
echo "***********************************************************************************************************************"
echo "<"`date`">:Starting..." 
/siebel/FGB_R0/bin/EIM_LOAD.sh NOSETUP NOSETUP NOPROC NOINPUT W2_INDV_CUST_INSERT W2_INDV_CUST_INSERT_PKG.W2_INDV_CUST_INSERT_STG_PROC NOIFB NOVAL NOVAL
Batch_count=`sqlplus -s $sbl_connectstring <<EOF
set feedback off;
set heading off;
SELECT COUNT(1) FROM SIEBEL.EIM_CONTACT WHERE IF_ROW_BATCH_NUM LIKE '2001%'; 
EXIT;
EOF`
Batch_count=`expr $Batch_count`
if [[ "$Batch_count" -eq 0 ]]
then
    echo "There are NO records for EIM Process"
else
    /siebel/FGB_R0/bin/EIM_LOAD.sh NOSETUP NOSETUP NOPROC NOINPUT W2_INDV_CUST_INSERT NOPROC W2_INDV_CUST_INSERT_TEST NOVAL NOVAL
fi
echo "<"`date`">:Ended..."
echo "============================ Individual Customer Insert End =========================="
touch -am /siebel/FGB_R0/logs/W2_CUST_INSERT_SUCCESS.txt
exit 0
*/
}