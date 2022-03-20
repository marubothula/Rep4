Public Class W2_NBAD_CRM_CUST_RM_UPD{

/*
create or replace PACKAGE BODY                                         W2_NBAD_CRM_CUST_RM_UPD AS
vn_code    NUMBER DEFAULT 0;
VV_MESSAGE VARCHAR2(255) DEFAULT NULL;

PROCEDURE W2_NBAD_CRM_CUST_RM_VAL AS       
  
  
BEGIN

  BEGIN
--UPDATE PROCESS_FLG='N' IF CUSTOMER_ID IS NULL OR RM_LOGIN IS NULL

  UPDATE
  FGB_INT.STG_CUSTOMER_ID_RM
  SET
  PROCESS_FLG = 'N',
  REJ_REASON = 'CUSTOMER_ID IS NULL or RM_LOGIN IS NULL'
  WHERE
  CUSTOMER_ID IS NULL OR RM_LOGIN_ID IS NULL;
  END;

--UPDATE PROCESS_FLG='N' IF GIVEN MDM_ID IS NOT EXISTING IN SIEBEL
BEGIN

    UPDATE  FGB_INT.STG_CUSTOMER_ID_RM STG
    SET PROCESS_FLG = 'N',
    REJ_REASON = 'CUSTOMER_ID DOES NOT EXIST IN SIEBEL'
    WHERE NOT EXISTS (SELECT 1 FROM SIEBEL.S_ORG_EXT ACC
                      WHERE ACC.X_MDM_ID=STG.CUSTOMER_ID
                       );
                                
END;
  
 
--UPDATE PROCESS_FLG='N' IF GIVEN RM LOGIN IS NOT EXISTING IN SIEBEL
BEGIN

    UPDATE  FGB_INT.STG_CUSTOMER_ID_RM STG
    SET PROCESS_FLG = 'N',
    REJ_REASON = 'RM_LOGIN ID DOES NOT EXIST IN SIEBEL'
    WHERE NOT EXISTS (SELECT 1 FROM SIEBEL.S_ORG_EXT ACC
                      WHERE ACC.X_MDM_ID=STG.RM_LOGIN_ID
                       );
                                
END;

 W2_NBAD_CRM_CUST_RM_MAIN();

END W2_NBAD_CRM_CUST_RM_VAL; 


PROCEDURE W2_NBAD_CRM_CUST_RM_MAIN AS


CURSOR C_CUST IS
  SELECT 
            CUSTOMER_ID AS "CUSTOMER_ID",
            RM_LOGIN_ID AS "RM_LOGIN",
            pos.NAME AS "POSTN_NAME", 
            div.NAME AS "POSTN_DIVN", 
            DIV.LOC AS "POSTN_LOC", 
            div.row_id AS "POSTN_BI", 
            BU.NAME AS "POSTN_BU",
            RM.party_uid  AS "RM_PAR_ID"
        FROM 
            SIEBEL.S_POSTN pos, 
            SIEBEL.S_BU bu, 
            SIEBEL.S_ORG_EXT div, 
           siebel.s_party RM, FGB_INT.STG_CUSTOMER_ID_RM stg, siebel.s_user usr
where stg.RM_LOGIN_ID=usr.login 
and usr.row_id=rm.row_id
AND RM.ROW_ID=POS.PR_EMP_ID
AND  POS.OU_ID = DIV.ROW_ID 
AND DIV.BU_ID = BU.ROW_ID ;

  CUST_RM_BATCH NUMBER DEFAULT 93010001; 
  vn_cnt2   NUMBER (12) := 0;

 BEGIN 

        BEGIN 
            comment : Delete's records from EIM Table - EIM_ACCOUNT 
            DELETE FROM SIEBEL.EIM_ACCOUNT WHERE IF_ROW_BATCH_NUM LIKE '9301%';
            COMMIT;
        EXCEPTION
        WHEN OTHERS THEN
            vn_code    := SQLCODE;
            vv_message := SUBSTR(SQLERRM,1,255);
            INSERT
            INTO FGB_INT.W2_ORG_PRSP_CUST_ERROR
            (
                DATA_ENTITY,
                ERR_DATE,
                ERR_MSG,
                BASE_TBL,
                RECORD_RID,
                SQL_ERR_CD,
                SQL_ERR_MSG
            )
            VALUES
            (
                'W2_ORG_CUST_INSERT_EIM_PROC',
                SYSDATE,
                'Error while Deleting Records from SIEBEL.EIM_ACCOUNT', 
                'EIM_ACCOUNT',
                'N/A',
                vn_code,
                vv_message
            );
            COMMIT;
        END;

  FOR i in C_CUST
        LOOP
            BEGIN
                
                INSERT INTO SIEBEL.EIM_ACCNT_CUT
                ( 
                    ROW_ID, 
                    IF_ROW_STAT, 
                    IF_ROW_BATCH_NUM, 
                    PARTY_UID, --Party Details of Customer 
                    PARTY_TYPE_CD, --Party Type of Customer 
                    AC_NAME, --Legal Entity Name 
                    AC_LOC, --Customer Location 
                    AC_BU, --Customer Organization 
                    PP_PARTY_UID, --Account Officer Code 
                    PP_PARTY_TYPE_CD, --Party Type of Account Officer 
                    REL_TYPE_CD, --Relationship Type of Account Officer with Customer 
                    PP_START_DT--, --Required Column in S_PARTY_PER 
                                    ) 
                SELECT
                    ORG.ROW_ID, 
                    'FOR_IMPORT', 
                    CUST_RM_BATCH, 
                    PAR.PARTY_UID,  --Party Details of Customer 
                    PAR.PARTY_TYPE_CD, --Party Type of Customer 
                    ORG.NAME, 
                    ORG.LOC,
                    i.POSTN_DIVN,
                    i.RM_PAR_ID, --Account Officer Code 
                    'Person', --Party Type of Account Officer 
                    'Relationship Manager', --Relationship Type of Account Officer with Customer 
                    SYSDATE --Required Column in S_PARTY_PER 
                FROM FGB_INT.STG_CUSTOMER_ID_RM STG, SIEBEL.S_ORG_EXT ORG, SIEBEL.S_PARTY PAR
                WHERE STG.CUSTOMER_ID=ORG.X_MDM_ID
                AND ORG.PAR_ROW_ID=PAR.ROW_ID
                   AND STG.PROCESS_FLG='Y';
                
                COMMIT;
                EXCEPTION
                WHEN OTHERS THEN
                    vn_code    := SQLCODE;
                    vv_message := SUBSTR(SQLERRM,1,255);
                    INSERT
                    INTO FGB_INT.W2_ORG_PRSP_CUST_ERROR
                    (
                        DATA_ENTITY,
                        ERR_DATE,
                        ERR_MSG,
                        BASE_TBL,
                        RECORD_RID,
                        SQL_ERR_CD,
                        SQL_ERR_MSG
                    )
                    VALUES
                    (
                        'W2_ORG_CUST_INSERT_EIM_PROC',
                        SYSDATE,
                        'Error while Inserting Records into SIEBEL.EIM_ACCOUNT', 
                        'EIM_ACCOUNT',
                        'ORG_NAME: '||I.CUSTOMER_ID,
                        vn_code,
                        vv_message
                    );
                    COMMIT;
                END;      

-------------------------------------------------------------------

BEGIN
                
                 INSERT INTO SIEBEL.EIM_ACCOUNT
                ( 
                    ROW_ID, 
                    IF_ROW_STAT, 
                    IF_ROW_BATCH_NUM, 
                    PARTY_UID, 
                    PARTY_TYPE_CD, 
                    NAME, 
                    LOC, 
                    --ACCNT_BU, 
                    POSTN_BU, 
                    POSTN_DIVN, 
                    POSTN_LOC, 
                    POSTN_NAME, 
                    ACC_PR_POSTN, 
                    VIS_BU
                    
                ) 
                SELECT
                    ORG.ROW_ID,
                    'FOR_IMPORT', 
                    CUST_RM_BATCH, 
                    PAR.PARTY_UID, 
                    PAR.PARTY_TYPE_CD,
                    ORG.NAME, 
                    ORG.LOC,
                    --i.POSTN_DIVN, 
                    i.POSTN_BU, 
                    i.POSTN_DIVN, 
                    i.POSTN_LOC, 
                    i.POSTN_NAME, 
                    'Y', 
                    i.POSTN_DIVN
                   
                FROM FGB_INT.STG_CUSTOMER_ID_RM STG, SIEBEL.S_ORG_EXT ORG, SIEBEL.S_PARTY PAR
                WHERE STG.CUSTOMER_ID=ORG.X_MDM_ID
                AND ORG.PAR_ROW_ID=PAR.ROW_ID
                   AND STG.PROCESS_FLG='Y';
            
              COMMIT;
                
                COMMIT;
                EXCEPTION
                WHEN OTHERS THEN
                    vn_code    := SQLCODE;
                    vv_message := SUBSTR(SQLERRM,1,255);
                    INSERT
                    INTO FGB_INT.W2_ORG_PRSP_CUST_ERROR
                    (
                        DATA_ENTITY,
                        ERR_DATE,
                        ERR_MSG,
                        BASE_TBL,
                        RECORD_RID,
                        SQL_ERR_CD,
                        SQL_ERR_MSG
                    )
                    VALUES
                    (
                        'W2_ORG_CUST_INSERT_EIM_PROC',
                        SYSDATE,
                        'Error while Inserting Records into SIEBEL.EIM_ACCOUNT', 
                        'EIM_ACCOUNT',
                        'ORG_NAME: '||I.CUSTOMER_ID,
                        vn_code,
                        vv_message
                    );
                    COMMIT;
                END; 

------------------------

  vn_cnt2 := vn_cnt2+1;
                
                IF MOD(vn_cnt2, 5000) = 0 THEN 
                    CUST_RM_BATCH := CUST_RM_BATCH+1; 
                    COMMIT;
                END IF;
            END LOOP; 
            COMMIT; 
        NULL;  
END W2_NBAD_CRM_CUST_RM_MAIN;

END W2_NBAD_CRM_CUST_RM_UPD;
*/
}