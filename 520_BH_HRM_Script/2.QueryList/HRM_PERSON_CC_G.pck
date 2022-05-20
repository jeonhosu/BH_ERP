CREATE OR REPLACE PACKAGE HRM_PERSON_CC_G
AS

-- 개인별 CC 맵핑 조회.
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

-- 부서마스터 조회.
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
              , HRM_COMMON_G.ID_NAME_F(PC.FLOOR_ID) FLOOR_NAME
              , PC.FLOOR_MAPPING_YN
              , PC.CC_ID CC_ID
              , HRM_COMMON_G.COST_CENTER_DESC_F(PC.CC_ID) AS CC_NAME
              , PC.CC_MAPPING_YN
              , PC.ORI_JOIN_DATE
              , PC.JOIN_DATE
              , PC.RETIRE_DATE
          FROM HRM_PERSON_CC_V PC
          WHERE PC.CORP_ID                                                = W_CORP_ID
            AND PC.PERSON_ID                                              = NVL(W_PERSON_ID, PC.PERSON_ID)
            AND PC.DEPT_ID                                                = NVL(W_DEPT_ID, PC.DEPT_ID)
						AND PC.EMPLOYE_TYPE                                           = NVL(W_EMPLOYE_TYPE, PC.EMPLOYE_TYPE)
            AND NVL(PC.FLOOR_ID, -1)                                      = NVL(W_FLOOR_ID, NVL(PC.FLOOR_ID, -1))
            AND NVL(PC.CC_ID, -1)                                         = NVL(W_CC_ID, NVL(PC.CC_ID, -1))
            AND PC.ORI_JOIN_DATE                                          <= LAST_DAY(W_STD_DATE)
            AND (PC.RETIRE_DATE IS NULL OR PC.RETIRE_DATE                 >= TRUNC(W_STD_DATE, 'MONTH'))
            AND PC.FLOOR_MAPPING_YN                                       = NVL(W_FLOOR_MAPPING_YN, PC.FLOOR_MAPPING_YN)
            AND PC.CC_MAPPING_YN                                          = NVL(W_CC_MAPPING_YN, PC.CC_MAPPING_YN)
						AND PC.SOB_ID                                                 = W_SOB_ID
						AND PC.ORG_ID                                                 = W_ORG_ID
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
    -- 인사마스터 적용.
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
    -- 최종 인사발령사항 적용.
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
