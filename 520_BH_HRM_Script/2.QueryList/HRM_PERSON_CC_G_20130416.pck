CREATE OR REPLACE PACKAGE HRM_PERSON_CC_G
AS

-- ���κ� CC ���� ��ȸ.
  PROCEDURE DATA_SELECT(P_CURSOR                                          OUT TYPES.TCURSOR
											, W_STD_DATE                                        IN DATE
											, W_CORP_ID                                         IN NUMBER
											, W_DEPT_ID                                         IN NUMBER
											, W_EMPLOYE_TYPE                                    IN VARCHAR2
											, W_PERSON_ID                                       IN NUMBER
											, W_FLOOR_ID                                        IN NUMBER
											, W_CC_ID                                           IN NUMBER
											, W_FLOOR_MAPPING_YN                                IN VARCHAR2
											, W_CC_MAPPING_YN                                   IN VARCHAR2
											, W_SOB_ID                                          IN NUMBER
											, W_ORG_ID                                          IN NUMBER);

-- UPDATE.
  PROCEDURE DATA_UPDATE(W_PERSON_ID                                       IN NUMBER
											, P_FLOOR_ID                                        IN NUMBER
											, P_CC_ID                                           IN NUMBER
											, P_USER_ID                                         IN NUMBER
											, O_FLOOR_MAPPING_YN                                OUT VARCHAR2
											, O_CC_MAPPING_YN                                   OUT VARCHAR2);

END HRM_PERSON_CC_G;


 
/
CREATE OR REPLACE PACKAGE BODY HRM_PERSON_CC_G
AS

-- �μ������� ��ȸ.
  PROCEDURE DATA_SELECT(P_CURSOR                                          OUT TYPES.TCURSOR
											, W_STD_DATE                                        IN DATE
											, W_CORP_ID                                         IN NUMBER
											, W_DEPT_ID                                         IN NUMBER
											, W_EMPLOYE_TYPE                                    IN VARCHAR2
											, W_PERSON_ID                                       IN NUMBER
											, W_FLOOR_ID                                        IN NUMBER
											, W_CC_ID                                           IN NUMBER
											, W_FLOOR_MAPPING_YN                                IN VARCHAR2
											, W_CC_MAPPING_YN                                   IN VARCHAR2
											, W_SOB_ID                                          IN NUMBER
											, W_ORG_ID                                          IN NUMBER)
                                              
                                              
  AS
  BEGIN
      OPEN P_CURSOR FOR
          SELECT PC.PERSON_ID
              , PC.PERSON_NUM
              , PC.NAME
              , PC.DEPT_NAME
              , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PC.EMPLOYE_TYPE, W_SOB_ID, W_ORG_ID) EMPLOYE_TYPE_NAME
              , PC.FLOOR_ID 
              , T2.FLOOR_NAME AS FLOOR_NAME
              , PC.FLOOR_MAPPING_YN
              , PC.CC_ID CC_ID
              , HRM_COMMON_G.COST_CENTER_DESC_F(PC.CC_ID) AS CC_NAME
              , PC.CC_MAPPING_YN
              , PC.ORI_JOIN_DATE
              , PC.JOIN_DATE
              , PC.RETIRE_DATE
          FROM HRM_PERSON_CC_V PC
            , (-- ���� �λ系��.
               SELECT PH.PERSON_ID
                    , PH.FLOOR_ID
                    , PH.SOB_ID
                    , PH.ORG_ID
                    , HF.FLOOR_CODE
                    , HF.FLOOR_NAME
                    , HF.SORT_NUM   AS FLOOR_SORT_NUM
                 FROM HRD_PERSON_HISTORY    PH
                    , HRM_FLOOR_V           HF
                WHERE PH.FLOOR_ID           = HF.FLOOR_ID
                  AND PH.PERSON_ID          =   NVL(W_PERSON_ID, PH.PERSON_ID)
                  AND PH.EFFECTIVE_DATE_FR  <=  W_STD_DATE
                  AND PH.EFFECTIVE_DATE_TO  >=  W_STD_DATE
              ) T2
          WHERE PC.PERSON_ID                                              = T2.PERSON_ID
            AND PC.CORP_ID                                                = NVL(W_CORP_ID, PC.CORP_ID)
            AND PC.PERSON_ID                                              = NVL(W_PERSON_ID, PC.PERSON_ID)
            AND PC.DEPT_ID                                                = NVL(W_DEPT_ID, PC.DEPT_ID)
						AND PC.EMPLOYE_TYPE                                           = NVL(W_EMPLOYE_TYPE, PC.EMPLOYE_TYPE)
            AND NVL(T2.FLOOR_ID, -1)                                      = NVL(W_FLOOR_ID, NVL(T2.FLOOR_ID, -1))
            AND NVL(PC.CC_ID, -1)                                         = NVL(W_CC_ID, NVL(PC.CC_ID, -1))
            AND PC.JOIN_DATE                                              <= LAST_DAY(W_STD_DATE)
            AND (PC.RETIRE_DATE IS NULL OR PC.RETIRE_DATE                 >= TRUNC(W_STD_DATE, 'MONTH'))
            AND PC.FLOOR_MAPPING_YN                                       = NVL(W_FLOOR_MAPPING_YN, PC.FLOOR_MAPPING_YN)
            AND PC.CC_MAPPING_YN                                          = NVL(W_CC_MAPPING_YN, PC.CC_MAPPING_YN)
						AND PC.SOB_ID                                                 = W_SOB_ID
						AND PC.ORG_ID                                                 = W_ORG_ID
 ORDER BY PC.CORP_TYPE
        , PC.NAME
          ;

  END DATA_SELECT;


-- UPDATE.
  PROCEDURE DATA_UPDATE(W_PERSON_ID                                       IN NUMBER
											, P_FLOOR_ID                                        IN NUMBER
											, P_CC_ID                                           IN NUMBER
											, P_USER_ID                                         IN NUMBER
											, O_FLOOR_MAPPING_YN                                OUT VARCHAR2
											, O_CC_MAPPING_YN                                   OUT VARCHAR2)
  AS
  BEGIN
    -- �λ縶���� ����.
    UPDATE HRM_PERSON_MASTER PM
      SET PM.FLOOR_ID                                               = P_FLOOR_ID
        , PM.COST_CENTER_ID                                         = P_CC_ID
        , PM.LAST_UPDATE_DATE                                       = GET_LOCAL_DATE(PM.SOB_ID)
        , PM.LAST_UPDATED_BY                                        = P_USER_ID
    WHERE PM.PERSON_ID                                              = W_PERSON_ID
    ;
      
    BEGIN
      SELECT DECODE(PM.FLOOR_ID, NULL, 'N', 'Y') FLOOR_MAPPING_YN
           , DECODE(PM.COST_CENTER_ID, NULL, 'N', 'Y') CC_MAPPING_YN
        INTO O_FLOOR_MAPPING_YN, O_CC_MAPPING_YN
      FROM HRM_PERSON_MASTER PM
      WHERE PM.PERSON_ID                                                = W_PERSON_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_FLOOR_MAPPING_YN := 'N';
      O_CC_MAPPING_YN := 'N';
    END;
    -- ���� �λ�߷ɻ��� ����.
 	  BEGIN
      UPDATE HRM_HISTORY_LINE HL
        SET HL.FLOOR_ID       = P_FLOOR_ID
      WHERE HL.PERSON_ID      = W_PERSON_ID
        AND HL.HISTORY_LINE_ID  = ( SELECT MAX(HL1.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                      FROM HRM_HISTORY_LINE HL1
                                    WHERE HL1.PERSON_ID             = HL.PERSON_ID
                                   )
      ;
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10180', NULL));
    END;    
  END DATA_UPDATE;

END HRM_PERSON_CC_G;
/
