CREATE OR REPLACE PACKAGE HRD_OT_MANAGER_G
AS

-- 包府流 儡诀 脚没 郴开 炼雀 -- 
  PROCEDURE SELECT_OT_LIST
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_WORK_CORP_ID         IN  NUMBER
            , W_WORK_DATE_FR         IN  DATE
            , W_WORK_DATE_TO         IN  DATE             
            , W_CORP_ID              IN  NUMBER
            , W_STATUS_FLAG          IN  VARCHAR2
            , W_DEPT_ID              IN  NUMBER
            , W_FLOOR_ID             IN  NUMBER
            , W_PERSON_ID            IN  NUMBER
            , W_ERROR_YN             IN  VARCHAR2
            , W_SORT_STATUS          IN  VARCHAR2
            , W_CONNECT_PERSON_ID    IN  NUMBER
            , W_SOB_ID               IN  NUMBER
						, W_ORG_ID               IN  NUMBER
						);

-- 包府流 儡诀 脚没 郴开 铰牢 贸府 --
  PROCEDURE UPDATE_OT_LIST_APPROVAL
            ( W_WORK_DATE             IN  DATE
            , W_PERSON_ID             IN  NUMBER
            , W_OT_TYPE_ID            IN  NUMBER
            , P_SELECT_YN             IN  VARCHAR2
            , P_STATUS_FLAG           IN  VARCHAR2
            , P_EVENT_STATUS          IN  VARCHAR2
            , P_REJECT_DESC           IN  VARCHAR2
            , P_USER_ID               IN  NUMBER
            , W_CONNECT_PERSON_ID     IN  NUMBER
            , W_SOB_ID                IN  NUMBER
            , W_ORG_ID                IN  NUMBER
            , O_STATUS                OUT VARCHAR2
            , O_MESSAGE               OUT VARCHAR2
            );

-- 包府流 儡诀/漂辟 历厘(TRIGGER) 
  PROCEDURE INTERFACE_OT_MANAGER
            ( P_PERSON_ID                       IN  HRD_OT_MANAGER.PERSON_ID%TYPE 
            , P_SOB_ID                          IN  HRD_OT_MANAGER.SOB_ID%TYPE 
            , P_ORG_ID                          IN  HRD_OT_MANAGER.ORG_ID%TYPE 
            , P_OT_TYPE_ID                      IN  HRD_OT_MANAGER.OT_TYPE_ID%TYPE 
            , P_OT_DATE_FR                      IN  HRD_OT_MANAGER.OT_DATE_FR%TYPE
            , P_OT_DATE_TO                      IN  HRD_OT_MANAGER.OT_DATE_TO%TYPE
            , P_DESCRIPTION                     IN  HRD_OT_MANAGER.DESCRIPTION%TYPE 
            , P_STATUS_FLAG                     IN  HRD_OT_MANAGER.STATUS_FLAG%TYPE 
            , P_APPROVAL_YN                     IN  HRD_OT_MANAGER.APPROVAL_YN%TYPE 
            , P_APPROVAL_DATE                   IN  HRD_OT_MANAGER.APPROVAL_DATE%TYPE 
            , P_APPROVAL_PERSON_ID              IN  HRD_OT_MANAGER.APPROVAL_PERSON_ID%TYPE 
            , P_USER_ID                         IN  HRD_OT_MANAGER.CREATED_BY%TYPE 
            , O_STATUS                          OUT VARCHAR2
            , O_MESSAGE                         OUT VARCHAR2
            );

-- 包府流 儡诀 脚没 郴开 : 坷幅 郴开 炼雀 -- 
  PROCEDURE SELECT_OT_LIST_ERROR
            ( P_CURSOR1              OUT TYPES.TCURSOR1
            , W_WORK_CORP_ID         IN  NUMBER
            , W_WORK_DATE_FR         IN  DATE
            , W_WORK_DATE_TO         IN  DATE             
            , W_CORP_ID              IN  NUMBER
            , W_STATUS_FLAG          IN  VARCHAR2
            , W_DEPT_ID              IN  NUMBER
            , W_FLOOR_ID             IN  NUMBER
            , W_PERSON_ID            IN  NUMBER
            , W_ERROR_YN             IN  VARCHAR2
            , W_SORT_STATUS          IN  VARCHAR2
            , W_CONNECT_PERSON_ID    IN  NUMBER
            , W_SOB_ID               IN  NUMBER
						, W_ORG_ID               IN  NUMBER
						);

-- 包府流 儡诀 包府 荐扁 火涝 --
  PROCEDURE INSERT_OT_LIST
            ( P_WORK_DATE           IN  HRD_OT_MANAGER.WORK_DATE%TYPE
            , P_PERSON_ID           IN  HRD_OT_MANAGER.PERSON_ID%TYPE
            , P_SOB_ID              IN  HRD_OT_MANAGER.SOB_ID%TYPE
            , P_ORG_ID              IN  HRD_OT_MANAGER.ORG_ID%TYPE
            , P_OT_TYPE_ID          IN  HRD_OT_MANAGER.OT_TYPE_ID%TYPE
            , P_OT_DATE_FR          IN  HRD_OT_MANAGER.OT_DATE_FR%TYPE
            , P_OT_DATE_TO          IN  HRD_OT_MANAGER.OT_DATE_TO%TYPE
            , P_DESCRIPTION         IN  HRD_OT_MANAGER.DESCRIPTION%TYPE
            , P_USER_ID             IN  NUMBER
            , P_CONNECT_PERSON_ID   IN  NUMBER
            );            
-- 包府流 儡诀 包府 荐扁 荐沥 --
  PROCEDURE UPDATE_OT_LIST
            ( W_WORK_DATE           IN  HRD_OT_MANAGER.WORK_DATE%TYPE
            , W_PERSON_ID           IN  HRD_OT_MANAGER.PERSON_ID%TYPE
            , W_SOB_ID              IN  HRD_OT_MANAGER.SOB_ID%TYPE
            , W_ORG_ID              IN  HRD_OT_MANAGER.ORG_ID%TYPE
            , P_OT_TYPE_ID          IN  HRD_OT_MANAGER.OT_TYPE_ID%TYPE
            , P_OT_DATE_FR          IN  HRD_OT_MANAGER.OT_DATE_FR%TYPE
            , P_OT_DATE_TO          IN  HRD_OT_MANAGER.OT_DATE_TO%TYPE
            , P_DESCRIPTION         IN  HRD_OT_MANAGER.DESCRIPTION%TYPE
            , P_USER_ID             IN  NUMBER
            , P_CONNECT_PERSON_ID   IN  NUMBER
            );
            
-- 包府流 儡诀 包府 荐扁 昏力 --
  PROCEDURE DELETE_OT_LIST
            ( W_WORK_DATE           IN  HRD_OT_MANAGER.WORK_DATE%TYPE
            , W_PERSON_ID           IN  HRD_OT_MANAGER.PERSON_ID%TYPE
            , W_SOB_ID              IN  HRD_OT_MANAGER.SOB_ID%TYPE
            , W_ORG_ID              IN  HRD_OT_MANAGER.ORG_ID%TYPE
            , P_USER_ID             IN  NUMBER
            , P_CONNECT_PERSON_ID   IN  NUMBER
            );            

-- 包府流 儡诀 扁埃俊 蝶弗 笼拌 棺 鞭咯 馆康 --
  PROCEDURE SELECT_OT_LIST_SUM
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_WORK_CORP_ID         IN  NUMBER
            , W_WORK_DATE_FR         IN  DATE
						, W_WORK_DATE_TO         IN  DATE             
						, W_CORP_ID              IN  NUMBER
            , W_TRANSFER_FLAG        IN  VARCHAR2  -- 鞭惑咯 傈价咯何 --
            , W_DEPT_ID              IN  NUMBER
            , W_FLOOR_ID             IN  NUMBER
						, W_PERSON_ID            IN  NUMBER
						, W_CONNECT_PERSON_ID    IN  NUMBER
						, W_SOB_ID               IN  NUMBER
						, W_ORG_ID               IN  NUMBER
            );
  
-- 包府流 儡诀 脚没 郴开 : 角力 免硼辟矫埃 馆康 棺 儡诀矫埃 拌魂  -- 
  PROCEDURE SET_REAL_OT_TIME
            ( W_WORK_CORP_ID         IN  NUMBER
            , W_WORK_DATE_FR         IN  DATE
            , W_WORK_DATE_TO         IN  DATE             
            , W_CORP_ID              IN  NUMBER
            , W_DEPT_ID              IN  NUMBER
            , W_FLOOR_ID             IN  NUMBER
            , W_PERSON_ID            IN  NUMBER
            , W_CONNECT_PERSON_ID    IN  NUMBER
            , W_SOB_ID               IN  NUMBER
						, W_ORG_ID               IN  NUMBER
            , O_STATUS               OUT VARCHAR2
            , O_MESSAGE              OUT VARCHAR2
						);

  
-- 包府流 儡诀 扁埃俊 蝶弗 笼拌 棺 鞭咯 馆康 --
  PROCEDURE CREATE_OT_AMOUNT
            ( W_WORK_CORP_ID         IN  NUMBER
            , W_WORK_DATE_FR         IN  DATE
						, W_WORK_DATE_TO         IN  DATE             
						, W_CORP_ID              IN  NUMBER
            , W_DEPT_ID              IN  NUMBER
            , W_FLOOR_ID             IN  NUMBER
						, W_PERSON_ID            IN  NUMBER
						, W_CONNECT_PERSON_ID    IN  NUMBER
						, W_SOB_ID               IN  NUMBER
						, W_ORG_ID               IN  NUMBER
            , O_STATUS               OUT VARCHAR2
            , O_MESSAGE              OUT VARCHAR2
            );
                        
-- 包府流 儡诀 扁埃俊 蝶弗 笼拌 棺 鞭咯 馆康 --
  PROCEDURE TRANSFER_SALARY_OT_AMOUNT
            ( W_WORK_DATE_FR          IN  DATE
						, W_WORK_DATE_TO          IN  DATE             
						, W_PERSON_ID             IN  NUMBER
            , P_SELECT_YN             IN  VARCHAR2
            , P_STATUS_FLAG           IN  VARCHAR2
            , P_EVENT_STATUS          IN  VARCHAR2
						, W_PAY_YYYYMM            IN  VARCHAR2
            , W_WAGE_TYPE             IN  VARCHAR2
            , W_USER_ID               IN  NUMBER
            , W_CONNECT_PERSON_ID     IN  NUMBER
						, W_SOB_ID                IN  NUMBER
						, W_ORG_ID                IN  NUMBER
            , O_STATUS                OUT VARCHAR2
            , O_MESSAGE               OUT VARCHAR2
            );

-- 包府流 儡诀 : 陛咀 固魂免 单捞磐 眉农 --
  PROCEDURE NO_CREATE_OT_AMOUNT_P
            ( W_WORK_CORP_ID         IN  NUMBER
            , W_WORK_DATE_FR         IN  DATE
						, W_WORK_DATE_TO         IN  DATE             
						, W_CORP_ID              IN  NUMBER
            , W_DEPT_ID              IN  NUMBER
            , W_FLOOR_ID             IN  NUMBER
						, W_PERSON_ID            IN  NUMBER
						, W_SOB_ID               IN  NUMBER
						, W_ORG_ID               IN  NUMBER
            , O_STATUS               OUT VARCHAR2
            , O_MESSAGE              OUT VARCHAR2
            );
                        
                          
-- 包府流 儡诀 脚没 荤盔 炼雀  -- 
  PROCEDURE LU_SELECT_PERSON
            ( P_CURSOR3              OUT TYPES.TCURSOR3
            , W_WORK_CORP_ID         IN  NUMBER
            , W_WORK_DATE            IN  DATE
            , W_SOB_ID               IN  NUMBER
						, W_ORG_ID               IN  NUMBER
						);
            
-- 包府流 儡诀 脚没 荤盔狼 角力 儡诀矫埃 拌魂 府畔  -- 
  FUNCTION REAL_OT_TIME_F
            ( W_WORK_DATE            IN  DATE
            , W_DUTY_CODE            IN  VARCHAR2
            , W_HOLY_TYPE            IN  VARCHAR2
            , W_JOB_CATE_CODE        IN  VARCHAR2
            , W_OPEN_TIME            IN  DATE
            , W_CLOSE_TIME           IN  DATE
            , W_SOB_ID               IN  NUMBER
						, W_ORG_ID               IN  NUMBER
						) RETURN NUMBER;
                

-- 包府流 儡诀 脚没 荤盔狼 角力 儡诀矫埃 拌魂 府畔  -- 
  PROCEDURE REAL_OT_TIME_P
            ( W_WORK_DATE            IN  DATE
            , W_DUTY_CODE            IN  VARCHAR2
            , W_HOLY_TYPE            IN  VARCHAR2
            , W_JOB_CATE_CODE        IN  VARCHAR2
            , W_OPEN_TIME            IN  DATE
            , W_CLOSE_TIME           IN  DATE
            , W_SOB_ID               IN  NUMBER
						, W_ORG_ID               IN  NUMBER
            , O_REAL_OT_TIME         OUT NUMBER
						);
                        

-- 包府流 儡诀 脚没 儡诀备盒  -- 
  PROCEDURE LU_SELECT_OT_TYPE
            ( P_CURSOR3              OUT TYPES.TCURSOR3
            , W_WORK_DATE            IN  DATE
            , W_DUTY_ID              IN  NUMBER
            , W_HOLY_TYPE            IN  VARCHAR2
            , W_SOB_ID               IN  NUMBER
						, W_ORG_ID               IN  NUMBER
            , W_ENABLED_FLAG         IN  VARCHAR2
						);
                        
END HRD_OT_MANAGER_G;
/
CREATE OR REPLACE PACKAGE BODY HRD_OT_MANAGER_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRD_OT_MANAGER_G
/* DESCRIPTION  : 包府流 儡诀/漂辟 包府
/* REFERENCE BY :
/* PROGRAM HISTORY : 脚痹 积己
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-- 包府流 儡诀 脚没 郴开 炼雀 -- 
  PROCEDURE SELECT_OT_LIST
	          ( P_CURSOR               OUT TYPES.TCURSOR
            , W_WORK_CORP_ID         IN  NUMBER
            , W_WORK_DATE_FR         IN  DATE
						, W_WORK_DATE_TO         IN  DATE             
						, W_CORP_ID              IN  NUMBER
            , W_STATUS_FLAG          IN  VARCHAR2
            , W_DEPT_ID              IN  NUMBER
            , W_FLOOR_ID             IN  NUMBER
						, W_PERSON_ID            IN  NUMBER
            , W_ERROR_YN             IN  VARCHAR2
            , W_SORT_STATUS          IN  VARCHAR2
						, W_CONNECT_PERSON_ID    IN  NUMBER
						, W_SOB_ID               IN  NUMBER
						, W_ORG_ID               IN  NUMBER
						)
  AS
	  V_CONNECT_PERSON_ID  HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;
    V_STATUS             VARCHAR2(4);
    V_MESSAGE            VARCHAR2(300);
  BEGIN
	  -- 辟怕鼻茄 汲沥.
		IF HRM_MANAGER_G.USER_CAP_F( W_CORP_ID => W_CORP_ID
		                           , W_START_DATE => W_WORK_DATE_FR
															 , W_END_DATE => W_WORK_DATE_TO
															 , W_MODULE_CODE => '20'
															 , W_PERSON_ID => W_CONNECT_PERSON_ID
															 , W_SOB_ID => W_SOB_ID
															 , W_ORG_ID => W_ORG_ID) = 'C' THEN
		  V_CONNECT_PERSON_ID := NULL;
		ELSE
		  V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
		END IF;
		IF W_STATUS_FLAG IN('A', 'N') THEN
      V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
    END IF;
    
    -- 包府流 儡诀 脚没 郴开 : 角力 免硼辟矫埃 馆康 棺 儡诀矫埃 拌魂  -- 
    SET_REAL_OT_TIME
      ( W_WORK_CORP_ID         => W_WORK_CORP_ID
      , W_WORK_DATE_FR         => W_WORK_DATE_FR
      , W_WORK_DATE_TO         => W_WORK_DATE_TO    
      , W_CORP_ID              => W_CORP_ID
      , W_DEPT_ID              => W_DEPT_ID
      , W_FLOOR_ID             => W_FLOOR_ID
      , W_PERSON_ID            => W_PERSON_ID
      , W_CONNECT_PERSON_ID    => W_CONNECT_PERSON_ID
      , W_SOB_ID               => W_SOB_ID
      , W_ORG_ID               => W_ORG_ID
      , O_STATUS               => V_STATUS
      , O_MESSAGE              => V_MESSAGE
      );
    IF V_STATUS = 'F' THEN
      RAISE_APPLICATION_ERROR(-20001, V_MESSAGE);
      RETURN;  
    END IF;
                
    OPEN P_CURSOR FOR
      SELECT 'N' AS SELECT_YN
           , OM.WORK_DATE
           , OM.PERSON_ID
           , PM.PERSON_NUM
           , PM.NAME
           , T1.DEPT_NAME
           , T2.FLOOR_NAME
           , T1.POST_NAME
           , HRM_COMMON_G.ID_NAME_F(OM.DUTY_ID) AS DUTY_NAME
           , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', OM.HOLY_TYPE, OM.SOB_ID, OM.ORG_ID) AS HOLY_TYPE_NAME
           , ( SELECT DC.DUTY_NAME
                 FROM HRD_DUTY_PERIOD DP
                    , HRM_DUTY_CODE_V DC
                WHERE DP.DUTY_ID          = DC.DUTY_ID
                  AND DP.PERSON_ID        = OM.PERSON_ID
                  AND DP.SOB_ID           = OM.SOB_ID
                  AND DP.ORG_ID           = OM.ORG_ID
                  AND DP.WORK_START_DATE  <= OM.WORK_DATE
                  AND DP.WORK_END_DATE    >= OM.WORK_DATE
                  AND ROWNUM              <= 1
             ) DUTY_PERIOD_DESC
           , OM.OPEN_TIME
           , OM.CLOSE_TIME
           , OM.REAL_OT_TIME AS REAL_OT_TIME
           , OM.OT_TYPE_ID
           , HRM_COMMON_G.ID_NAME_F(OM.OT_TYPE_ID) AS OT_TYPE_DESC
           , NVL(OM.OT_DATE_FR, NULL) AS OT_DATE_FR
           , NVL(OM.OT_DATE_TO, NULL) AS OT_DATE_TO
           , OTG.STD_OT_TIME
           , OM.DESCRIPTION 
           , OM.REJECT_YN
           , OM.REJECT_DESC
           , OM.STATUS_FLAG
           , HRM_COMMON_G.CODE_NAME_F('OT_TYPE_STATUS', OM.STATUS_FLAG, OM.SOB_ID, OM.ORG_ID) AS OT_TYPE_STATUS_DESC
           , ( SELECT PM.NAME
                 FROM HRM_PERSON_MASTER PM
                WHERE PM.PERSON_ID    = OM.APPROVAL_PERSON_ID
             ) AS APPROVAL_PERSON_NAME
           , ( SELECT PM.NAME
                 FROM HRM_PERSON_MASTER PM
                WHERE PM.PERSON_ID    = OM.CONFIRMED_PERSON_ID                
             ) AS CONFIRM_PERSON_NAME
           , NVL(( SELECT COUNT(HOM.OT_TYPE_ID) AS OT_MANGER_COUNT
                     FROM HRD_OT_MANAGER HOM
                    WHERE HOM.WORK_DATE     = OM.WORK_DATE
                      AND HOM.PERSON_ID     = OM.PERSON_ID
                      AND HOM.SOB_ID        = OM.SOB_ID
                      AND HOM.ORG_ID        = OM.ORG_ID                
                 ), 0) AS OT_MANAGER_COUNT
        FROM HRD_OT_MANAGER    OM
           , HRM_OT_TYPE_GW_V  OTG
           , HRM_PERSON_MASTER PM
           , (-- 矫痢 牢荤郴开.
             SELECT HL.PERSON_ID
                  , HL.DEPT_ID
                  , DM.DEPT_CODE
                  , DM.DEPT_NAME
                  , DM.DEPT_SORT_NUM
                  , PC.POST_CODE                  
                  , PC.POST_NAME AS POST_NAME
                  , PC.SORT_NUM AS POST_SORT_NUM
                  , JC.JOB_CATEGORY_CODE
                  , JC.JOB_CATEGORY_NAME
                  , JC.SORT_NUM AS JOB_CATEGORY_SORT_NUM
               FROM HRM_HISTORY_HEADER HH
                  , HRM_HISTORY_LINE   HL
                  , HRM_DEPT_MASTER    DM
                  , HRM_POST_CODE_V    PC
                  , HRM_JOB_CATEGORY_CODE_V JC
             WHERE HH.HISTORY_HEADER_ID = HL.HISTORY_HEADER_ID
               AND HL.DEPT_ID           = DM.DEPT_ID
               AND HL.POST_ID           = PC.POST_ID
               AND HL.JOB_CATEGORY_ID   = JC.JOB_CATEGORY_ID               
               AND HL.HISTORY_LINE_ID  
                     IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                            FROM HRM_HISTORY_LINE S_HL
                          WHERE S_HL.CHARGE_DATE            <= W_WORK_DATE_TO
                            AND S_HL.PERSON_ID              = HL.PERSON_ID
                          GROUP BY S_HL.PERSON_ID
                        )
            ) T1
          , (-- 矫痢 牢荤郴开.
              SELECT PH.PERSON_ID
                   , PH.FLOOR_ID
                   , PH.SOB_ID
                   , PH.ORG_ID
                   , HF.FLOOR_CODE
                   , HF.FLOOR_NAME
                   , HF.SORT_NUM AS FLOOR_SORT_NUM
                FROM HRD_PERSON_HISTORY        PH
                   , HRM_FLOOR_V               HF
              WHERE PH.FLOOR_ID           = HF.FLOOR_ID
                AND PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE_TO
                AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE_TO
            ) T2
         /* , ( SELECT DI.WORK_DATE
                  , DI.PERSON_ID
                  , DI.SOB_ID
                  , DI.ORG_ID
                  , HRM_COMMON_G.ID_NAME_F(DI.DUTY_ID) AS DUTY_NAME
                  , DI.HOLY_TYPE
                  , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DI.HOLY_TYPE, DI.SOB_ID, DI.ORG_ID) AS HOLY_TYPE_NAME
                  , SUBSTR(TO_CHAR(DI.WORK_DATE, 'DAY', 'NLS_DATE_LANGUAGE=KOREAN'), 1, 1)    AS W
                  , DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) AS OPEN_TIME
                  , CASE
                         -- 饶老 硼辟扁废 佬绢坷扁(窜, 荐沥荤亲捞 乐栏搁 荐沥荤亲 馆康).
                         WHEN (DI.NEXT_DAY_YN   = 'Y'
                            OR DI.HOLY_TYPE    IN('N', '3')
                            OR DI.DANGJIK_YN    = 'Y'
                            OR DI.ALL_NIGHT_YN  = 'Y') THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, (SELECT S_DI.CLOSE_TIME
                                                                                                               FROM HRD_DAY_INTERFACE_V S_DI
                                                                                                              WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                                                                AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                                                                AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                                                                AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                                                                AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                                                                            ))
                         WHEN DI.HOLY_TYPE IN ('0', '1') 
                             AND DC.DUTY_CODE = '53' -- 绒老辟公(1187)
                             AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) >
                                   TO_DATE(TO_CHAR(DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME), 'YYYY-MM-DD') || ' ' || '17:30:00', 'YYYY-MM-DD HH24:MI:SS')
                                THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, (SELECT S_DI.CLOSE_TIME
                                                                                        FROM HRD_DAY_INTERFACE_V     S_DI
                                                                                       WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                                         AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                                         AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                                         AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                                         AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                                                     ))
                         WHEN S_WC.HOLY_TYPE = '3' -- 具埃
                            AND(DC.DUTY_CODE      = '19' -- 版炼绒啊(1174)
                             OR DC.DUTY_CODE      = '12' -- 背腊(1170)
                             OR DC.DUTY_CODE      = '20' -- 斥瞒(1175)
                             OR DC.DUTY_CODE      = '54' -- 公鞭绒啊(1189)
                             OR DC.DUTY_CODE      = '52' -- 公鞭绒老(1182)
                             OR DC.DUTY_CODE      = '17' -- 颇斑(1172)
                             OR DC.DUTY_CODE      = '55' -- 蜡鞭绒啊(1190)
                             OR DC.DUTY_CODE      = '18' -- 免厘(1173)
                             OR DC.DUTY_CODE      = '13' -- 绕访(1171)
                             OR DC.DUTY_CODE      = '51' -- 绒老(1188)
                               ) THEN NULL
                         WHEN DI.MODIFY_FLAG = 'N' AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) IS NULL
                                                   AND DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, DI.CLOSE_TIME) IS NOT NULL
                                                   AND DC.DUTY_CODE  = '51' -- 绒老(1188)
                                                   AND S_WC.ALL_NIGHT_YN =  'Y' THEN NULL
                         WHEN DI.MODIFY_FLAG = 'N' AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) IS NULL
                                                   AND DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, DI.CLOSE_TIME) IS NOT NULL
                                                   AND DC.DUTY_CODE IN ( '18' -- 免厘(1173)
                                                                       , '19' -- 版炼绒啊(1174)
                                                                       , '20' -- 斥瞒(1175)
                                                                       , '22' -- 焊扒绒啊(1177)
                                                                       , '23' -- 楷吝绒啊(1178)
                                                                       , '24' -- 措眉绒公(1179)
                                                                       , '52' -- 公鞭绒老(1182)
                                                                       , '53' -- 绒老辟公(1187)
                                                                       , '51' -- 绒老(1188)
                                                                       , '54' -- 公鞭绒啊(1189)
                                                                       , '55' -- 蜡鞭绒啊(1190)
                                                                       , '79' -- 寸流(1194)
                                                                       , '99' -- 枚具(3784)
                                                                       )
                                                   AND ((SELECT HDC.DUTY_CODE
                                                            FROM HRD_DAY_INTERFACE_V     S_DI
                                                              , HRM_DUTY_CODE_V HDC
                                                           WHERE S_DI.DUTY_ID       =  HDC.DUTY_ID
                                                             AND S_DI.SOB_ID        =  DI.SOB_ID
                                                             AND S_DI.ORG_ID        =  DI.ORG_ID
                                                             AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                             AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                             AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                           ) = '53' -- 绒老辟公(1187)
                                                        AND (S_WC.ALL_NIGHT_YN = 'Y'  -- 枚具
                                                          OR S_WC.DANGJIK_YN = 'Y'    -- 寸流.
                                                            )
                                                       ) THEN NULL
                         WHEN DC.DUTY_CODE        = '00' -- 免辟(1168)
                              AND (SELECT S_DI.NEXT_DAY_YN
                                     FROM HRD_DAY_INTERFACE_V   S_DI
                                    WHERE S_DI.SOB_ID       = DI.SOB_ID
                                      AND S_DI.ORG_ID       = DI.ORG_ID
                                      AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                      AND S_DI.PERSON_ID    = DI.PERSON_ID
                                      AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                  ) = 'Y' -- 饶老硼辟
                                  THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, (SELECT S_DI.CLOSE_TIME1
                                                                                          FROM HRD_DAY_INTERFACE_V S_DI
                                                                                         WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                                           AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                                           AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                                           AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                                           AND S_DI.WORK_DATE     =  DI.WORK_DATE
                                                                                       ))
                         WHEN DC.DUTY_CODE        = '00' -- 免辟(1168)
                              AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) IS NULL
                              AND (SELECT S_DI.ALL_NIGHT_YN
                                     FROM HRD_DAY_INTERFACE   S_DI
                                    WHERE S_DI.SOB_ID       = DI.SOB_ID
                                      AND S_DI.ORG_ID       = DI.ORG_ID
                                      AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                      AND S_DI.PERSON_ID    = DI.PERSON_ID
                                      AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                  ) = 'Y' -- 傈老 枚具
                                  THEN NULL
                         WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME
                         ELSE DI.CLOSE_TIME
                    END AS CLOSE_TIME
                  , HRM_COMMON_G.ID_NAME_F(NVL(I_DM.MODIFY_ID, O_DM.MODIFY_ID)) AS MODIFY_DESC
                  , CASE WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                   AND DI.CLOSE_TIME IS NOT NULL
                                                   AND DC.DUTY_CODE  =  '53' THEN '' -- 绒老辟公(1187)
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                   AND DI.CLOSE_TIME IS NOT NULL
                                                   AND DC.DUTY_CODE  =  '00' -- 免辟(1168)
                                                   AND DI.HOLY_TYPE  = '2' THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                   AND DI.CLOSE_TIME IS NULL
                                                   AND DC.DUTY_CODE  =  '11' -- 搬辟(1169)
                                                   AND DI.HOLY_TYPE  = '2' THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                   AND DI.CLOSE_TIME IS NULL
                                                   AND(DC.DUTY_CODE      = '19' -- 版炼绒啊(1174)
                                                     OR DC.DUTY_CODE      = '12' -- 背腊(1170)
                                                     OR DC.DUTY_CODE      = '20' -- 斥瞒(1175)                                                     
                                                     OR DC.DUTY_CODE      = '24' -- 措眉绒公(1179)
                                                     OR DC.DUTY_CODE      = '54' -- 公鞭绒啊(1189)
                                                     OR DC.DUTY_CODE      = '52' -- 公鞭绒老(1182)                                                     
                                                     OR DC.DUTY_CODE      = '22' -- 焊扒绒啊(1177)
                                                     OR DC.DUTY_CODE      = '23' -- 楷吝绒啊(1178)
                                                     OR DC.DUTY_CODE      = '55' -- 蜡鞭绒啊(1190)                                                     
                                                     OR DC.DUTY_CODE      = '17' -- 颇斑(1172)
                                                     OR DC.DUTY_CODE      = '18' -- 免厘(1173)
                                                     OR DC.DUTY_CODE      = '13' -- 绕访(1171)
                                                     OR DC.DUTY_CODE      = '51' -- 绒老(1188)
                                                    ) THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                   AND(SELECT S_DI.HOLY_TYPE
                                                         FROM HRD_DAY_INTERFACE_V   S_DI
                                                        WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                          AND S_DI.ORG_ID       = DI.ORG_ID
                                                          AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                          AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                          AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                      ) = '3' -- 具埃
                                                   AND(DC.DUTY_CODE      = '19' -- 版炼绒啊(1174)
                                                     OR DC.DUTY_CODE      = '12' -- 背腊(1170)
                                                     OR DC.DUTY_CODE      = '20' -- 斥瞒(1175)                                                     
                                                     OR DC.DUTY_CODE      = '24' -- 措眉绒公(1179)
                                                     OR DC.DUTY_CODE      = '54' -- 公鞭绒啊(1189)
                                                     OR DC.DUTY_CODE      = '52' -- 公鞭绒老(1182)                                                     
                                                     OR DC.DUTY_CODE      = '22' -- 焊扒绒啊(1177)
                                                     OR DC.DUTY_CODE      = '23' -- 楷吝绒啊(1178)
                                                     OR DC.DUTY_CODE      = '55' -- 蜡鞭绒啊(1190)                                                     
                                                     OR DC.DUTY_CODE      = '17' -- 颇斑(1172)
                                                     OR DC.DUTY_CODE      = '18' -- 免厘(1173)
                                                     OR DC.DUTY_CODE      = '13' -- 绕访(1171)
                                                     OR DC.DUTY_CODE      = '51' -- 绒老(1188)
                                                      ) THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                   AND DI.CLOSE_TIME IS NOT NULL
                                                   AND DC.DUTY_CODE  =  '00' -- 免辟(1168)
                                                   AND DI.HOLY_TYPE  = '3'  -- 具埃
                                                   AND (SELECT S_DI.CLOSE_TIME
                                                          FROM HRD_DAY_INTERFACE_V     S_DI
                                                         WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                           AND S_DI.ORG_ID        =  DI.ORG_ID
                                                           AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                           AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                           AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                       ) IS NOT NULL THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                   AND DI.CLOSE_TIME IS NULL
                                                   AND DC.DUTY_CODE  =  '00' -- 免辟(1168)
                                                   AND DI.HOLY_TYPE  = '3'   -- 具埃
                                                   AND (SELECT S_DI.CLOSE_TIME
                                                          FROM HRD_DAY_INTERFACE_V     S_DI
                                                         WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                           AND S_DI.ORG_ID        =  DI.ORG_ID
                                                           AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                           AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                           AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                       ) IS NOT NULL THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                   AND DC.DUTY_CODE  =  '11' -- 搬辟(1169)
                                                   AND DI.HOLY_TYPE  = '3'   -- 具埃
                                                   AND (SELECT S_DI.CLOSE_TIME
                                                          FROM HRD_DAY_INTERFACE_V     S_DI
                                                         WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                           AND S_DI.ORG_ID        =  DI.ORG_ID
                                                           AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                           AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                           AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                        ) IS NULL THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME    IS NOT NULL
                                                   AND DI.CLOSE_TIME   IS NULL
                                                   AND DC.DUTY_CODE    =  '53' -- 绒老辟公(1187)
                                                   AND DI.ALL_NIGHT_YN = 'Y'  -- 枚具
                                                   AND DI.HOLY_TYPE    = '1'  -- 绒老
                                                   AND (SELECT S_DI.CLOSE_TIME
                                                          FROM HRD_DAY_INTERFACE_V     S_DI
                                                         WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                           AND S_DI.ORG_ID        =  DI.ORG_ID
                                                           AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                           AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                           AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                       ) IS NOT NULL THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                   AND DI.CLOSE_TIME IS NOT NULL
                                                   AND DC.DUTY_CODE  = '51' -- 绒老(1188)
                                                   AND (SELECT S_DI.ALL_NIGHT_YN -- 枚具
                                                          FROM HRD_DAY_INTERFACE_V   S_DI
                                                         WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                           AND S_DI.ORG_ID        =  DI.ORG_ID
                                                           AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                           AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                           AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                       ) = 'Y' THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                   AND DI.CLOSE_TIME IS NOT NULL
                                                   AND DC.DUTY_CODE  = '22' -- 焊扒绒啊(1177)
                                                   AND (SELECT DI.HOLY_TYPE
                                                          FROM HRD_DAY_INTERFACE_V     S_DI
                                                         WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                           AND S_DI.ORG_ID        =  DI.ORG_ID
                                                           AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                           AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                           AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                       ) = '3' THEN '' -- 具埃
                         WHEN DI.HOLY_TYPE IN ('0', '1') AND DC.DUTY_CODE    =  '53' -- 绒老辟公(1187)
                                                         AND DI.OPEN_TIME > TO_DATE(TO_CHAR(DI.OPEN_TIME, 'YYYY-MM-DD') || ' ' || '17:30:00', 'YYYY-MM-DD HH24:MI:SS')
                                                         AND (SELECT S_DI.CLOSE_TIME
                                                                FROM HRD_DAY_INTERFACE_V     S_DI
                                                               WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                 AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                 AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                 AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                 AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                             ) IS NOT NULL THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.CLOSE_TIME IS NOT NULL
                                                   AND(SELECT HDC.DUTY_CODE -- 绒老辟公
                                                         FROM HRD_DAY_INTERFACE_V     S_DI
                                                           , HRM_DUTY_CODE_V          HDC
                                                        WHERE S_DI.DUTY_ID       = HDC.DUTY_ID
                                                          AND S_DI.SOB_ID        =  DI.SOB_ID
                                                          AND S_DI.ORG_ID        =  DI.ORG_ID
                                                          AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                          AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                          AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                      ) = '53' -- 绒老辟公(1187)
                                                   AND(DC.DUTY_CODE      = '19' -- 版炼绒啊(1174)
                                                     OR DC.DUTY_CODE      = '12' -- 背腊(1170)
                                                     OR DC.DUTY_CODE      = '20' -- 斥瞒(1175)                                                     
                                                     OR DC.DUTY_CODE      = '24' -- 措眉绒公(1179)
                                                     OR DC.DUTY_CODE      = '54' -- 公鞭绒啊(1189)
                                                     OR DC.DUTY_CODE      = '52' -- 公鞭绒老(1182)                                                     
                                                     OR DC.DUTY_CODE      = '22' -- 焊扒绒啊(1177)
                                                     OR DC.DUTY_CODE      = '23' -- 楷吝绒啊(1178)
                                                     OR DC.DUTY_CODE      = '55' -- 蜡鞭绒啊(1190)                                                     
                                                     OR DC.DUTY_CODE      = '17' -- 颇斑(1172)
                                                     OR DC.DUTY_CODE      = '18' -- 免厘(1173)
                                                     OR DC.DUTY_CODE      = '13' -- 绕访(1171)
                                                     OR DC.DUTY_CODE      = '51' -- 绒老(1188)
                                                      ) THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                   AND DI.CLOSE_TIME IS NOT NULL
                                                   AND(SELECT S_DI.CLOSE_TIME
                                                         FROM HRD_DAY_INTERFACE_V     S_DI
                                                        WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                          AND S_DI.ORG_ID        =  DI.ORG_ID
                                                          AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                          AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                          AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                      ) IS NOT NULL
                                                   AND(DC.DUTY_CODE      = '19' -- 版炼绒啊(1174)
                                                     OR DC.DUTY_CODE      = '12' -- 背腊(1170)
                                                     OR DC.DUTY_CODE      = '20' -- 斥瞒(1175)                                                     
                                                     OR DC.DUTY_CODE      = '24' -- 措眉绒公(1179)
                                                     OR DC.DUTY_CODE      = '54' -- 公鞭绒啊(1189)
                                                     OR DC.DUTY_CODE      = '52' -- 公鞭绒老(1182)                                                     
                                                     OR DC.DUTY_CODE      = '22' -- 焊扒绒啊(1177)
                                                     OR DC.DUTY_CODE      = '23' -- 楷吝绒啊(1178)
                                                     OR DC.DUTY_CODE      = '55' -- 蜡鞭绒啊(1190)                                                     
                                                     OR DC.DUTY_CODE      = '17' -- 颇斑(1172)
                                                     OR DC.DUTY_CODE      = '18' -- 免厘(1173)
                                                     OR DC.DUTY_CODE      = '13' -- 绕访(1171)
                                                     OR DC.DUTY_CODE      = '51' -- 绒老(1188)
                                                      ) THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DC.DUTY_CODE    =  '53' -- 绒老辟公(1187)
                                                   AND DI.ALL_NIGHT_YN = 'Y'  -- 枚具
                                                   AND DI.OPEN_TIME    IS NOT NULL
                                                   AND(SELECT S_DI.CLOSE_TIME
                                                         FROM HRD_DAY_INTERFACE_V     S_DI
                                                        WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                          AND S_DI.ORG_ID        =  DI.ORG_ID
                                                          AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                          AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                          AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                      ) IS NOT NULL THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME    IS NULL
                                                   AND DI.CLOSE_TIME   IS NOT NULL
                                                   AND(SELECT HDC.DUTY_CODE -- 绒老辟公
                                                         FROM HRD_DAY_INTERFACE_V     S_DI
                                                           , HRM_DUTY_CODE_V        HDC
                                                        WHERE S_DI.DUTY_ID       =  HDC.DUTY_ID
                                                          AND S_DI.SOB_ID        =  DI.SOB_ID
                                                          AND S_DI.ORG_ID        =  DI.ORG_ID
                                                          AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                          AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                          AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                      ) = '53' -- 绒老辟公(1187)
                                                   AND(SELECT S_DI.ALL_NIGHT_YN -- 枚具
                                                         FROM HRD_DAY_INTERFACE_V   S_DI
                                                        WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                          AND S_DI.ORG_ID        =  DI.ORG_ID
                                                          AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                          AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                          AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                      ) = 'Y' THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                   AND DI.CLOSE_TIME IS NOT NULL
                                                   AND((SELECT S_DI.HOLY_TYPE    -- 具埃
                                                          FROM HRD_DAY_INTERFACE   S_DI
                                                         WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                           AND S_DI.ORG_ID       = DI.ORG_ID
                                                           AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                           AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                           AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                       ) = '3'
                                                    OR (SELECT S_DI.ALL_NIGHT_YN -- 枚具
                                                          FROM HRD_DAY_INTERFACE_V S_DI
                                                         WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                           AND S_DI.ORG_ID       = DI.ORG_ID
                                                           AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                           AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                           AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                       ) = 'Y') THEN ''
                         ELSE HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', DI.APPROVE_STATUS, DI.SOB_ID, DI.ORG_ID)
                    END  AS APPROVE_STATUS_NAME
                  , DI.REJECT_REMARK
                  , DI.MODIFY_FLAG AS MODIFY_FLAG
                  , DI.TRANS_YN    AS TRANS_YN
                  , DI.NEXT_DAY_YN
                  , DI.DANGJIK_YN
                  , HRM_COMMON_G.ID_NAME_F(DI.LEAVE_ID) AS LEAVE_NAME
                  , HRM_COMMON_G.CODE_NAME_F('LEAVE_OUT_TIME', DI.LEAVE_TIME_CODE, DI.SOB_ID, DI.ORG_ID) AS LEAVE_TIME
                  , DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME1, DI.OPEN_TIME1) AS OPEN_TIME1
                  , NVL(O_DM.MODIFY_TIME1, DI.CLOSE_TIME1)                         AS CLOSE_TIME1                  
               FROM HRD_DAY_INTERFACE_V DI
                  , HRM_DUTY_CODE_V     DC
                  , HRD_DAY_MODIFY      I_DM
                  , HRD_DAY_MODIFY      O_DM
                  , (-- 傈老 辟公 沥焊 炼雀.
                     SELECT WC.WORK_DATE + 1 AS WORK_DATE
                          , WC.PERSON_ID
                          , WC.CORP_ID
                          , WC.SOB_ID
                          , WC.ORG_ID
                          , WC.HOLY_TYPE
                          , WC.DANGJIK_YN
                          , WC.ALL_NIGHT_YN
                       FROM HRD_WORK_CALENDAR   WC
                      WHERE WC.SOB_ID         = W_SOB_ID
                        AND WC.ORG_ID         = W_ORG_ID
                        AND WC.WORK_DATE      BETWEEN W_WORK_DATE_FR - 1 AND W_WORK_DATE_TO
                        AND ((W_PERSON_ID     IS NULL AND 1 = 1)
                          OR (W_PERSON_ID     IS NOT NULL AND WC.PERSON_ID = W_PERSON_ID))
                    ) S_WC
              WHERE DI.DUTY_ID                = DC.DUTY_ID
                AND DI.PERSON_ID              = I_DM.PERSON_ID(+)
                AND DI.WORK_DATE              = I_DM.WORK_DATE(+)
                AND '1'                       = I_DM.IO_FLAG(+)
                AND DI.PERSON_ID              = O_DM.PERSON_ID(+)
                AND DI.WORK_DATE              = O_DM.WORK_DATE(+)
                AND '2'                       = O_DM.IO_FLAG(+)
                AND DI.WORK_DATE              = S_WC.WORK_DATE(+)
                AND DI.PERSON_ID              = S_WC.PERSON_ID(+)
                AND DI.SOB_ID                 = S_WC.SOB_ID(+)
                AND DI.ORG_ID                 = S_WC.ORG_ID(+)
                AND DI.WORK_DATE              BETWEEN W_WORK_DATE_FR AND W_WORK_DATE_TO
                AND ((W_PERSON_ID             IS NULL AND 1 = 1)
                  OR (W_PERSON_ID             IS NOT NULL AND DI.PERSON_ID = W_PERSON_ID))
                AND DI.WORK_CORP_ID           = W_WORK_CORP_ID
                AND DI.SOB_ID                 = W_SOB_ID
                AND DI.ORG_ID                 = W_ORG_ID
            ) T3*/
         , HRD_WORK_CALENDAR  WC
       WHERE OM.OT_TYPE_ID              = OTG.OT_TYPE_ID
         AND OM.PERSON_ID               = PM.PERSON_ID
         AND PM.PERSON_ID               = T1.PERSON_ID
         AND PM.PERSON_ID               = T2.PERSON_ID
         AND OM.WORK_DATE               = WC.WORK_DATE(+)
         AND OM.PERSON_ID               = WC.PERSON_ID(+)
         AND OM.SOB_ID                  = WC.SOB_ID(+)
         AND OM.ORG_ID                  = WC.ORG_ID(+)
/*         AND OM.WORK_DATE               = T3.WORK_DATE(+)
         AND OM.PERSON_ID               = T3.PERSON_ID(+)
         AND OM.SOB_ID                  = T3.SOB_ID(+)
         AND OM.ORG_ID                  = T3.ORG_ID(+)*/
         AND PM.WORK_CORP_ID            = W_WORK_CORP_ID
         AND ((W_CORP_ID                IS NULL AND 1 = 1)
           OR (W_CORP_ID                IS NOT NULL AND PM.CORP_ID = W_CORP_ID))
         AND OM.WORK_DATE               BETWEEN W_WORK_DATE_FR AND W_WORK_DATE_TO
         AND ((W_STATUS_FLAG            = 'A' AND 1 = 1)
           OR (W_STATUS_FLAG            != 'A' AND OM.STATUS_FLAG = W_STATUS_FLAG))
         AND PM.SOB_ID                  = W_SOB_ID
         AND PM.ORG_ID                  = W_ORG_ID
         AND ((W_PERSON_ID              IS NULL AND 1 = 1)
           OR (W_PERSON_ID              IS NOT NULL AND PM.PERSON_ID = W_PERSON_ID))
         AND PM.JOIN_DATE               <= W_WORK_DATE_TO
         AND (PM.RETIRE_DATE            >= W_WORK_DATE_FR OR PM.RETIRE_DATE IS NULL)
         AND ((W_DEPT_ID                IS NULL AND 1 = 1)
           OR (W_DEPT_ID                IS NOT NULL AND T1.DEPT_ID = W_DEPT_ID))         
         AND ((W_FLOOR_ID               IS NULL AND 1 = 1)
           OR (W_FLOOR_ID               IS NOT NULL AND T2.FLOOR_ID = W_FLOOR_ID))
         AND ((W_ERROR_YN               = 'N' AND 1 = 1)
           OR (W_ERROR_YN               != 'N' 
             AND ((NVL(OM.REAL_OT_TIME, 0) < NVL(OTG.STD_OT_TIME, 0))
               OR (OM.HOLY_TYPE IN('2', '3') AND WC.OPEN_TIME < TRUNC(NVL(OM.OPEN_TIME, WC.OPEN_TIME), 'MI'))
               OR (OM.HOLY_TYPE IN('2', '3') AND TRUNC(NVL(OM.CLOSE_TIME, WC.CLOSE_TIME), 'MI') < WC.CLOSE_TIME)
               OR (OM.HOLY_TYPE IN('2', '3') AND OTG.OT_TYPE_CODE IN('210', '220'))
               OR (OM.HOLY_TYPE IN('0', '1') AND OTG.OT_TYPE_CODE IN('110', '120')))))                  
      ORDER BY OM.WORK_DATE
             , CASE  -- 1瞒 沥纺 扁霖(SORT 鉴辑) -- 
                 WHEN W_SORT_STATUS = 'WC' THEN '1' || LPAD(T2.FLOOR_SORT_NUM, 7, '0')
                 WHEN W_SORT_STATUS = 'IT' THEN TO_CHAR(OM.OPEN_TIME, 'YYYY-MM-DD HH24:MI')
                 WHEN W_SORT_STATUS = 'CT' THEN TO_CHAR(OM.CLOSE_TIME, 'YYYY-MM-DD HH24:MI')
                 WHEN W_SORT_STATUS = 'OT' THEN OTG.OT_TYPE_CODE
                 ELSE PM.PERSON_NUM
               END
             , CASE  -- 2瞒 沥纺 扁霖(内靛) -- 
                 WHEN W_SORT_STATUS = 'WC' THEN T2.FLOOR_CODE
                 WHEN W_SORT_STATUS = 'IT' THEN TO_CHAR(OM.OPEN_TIME, 'YYYY-MM-DD HH24:MI')
                 WHEN W_SORT_STATUS = 'CT' THEN TO_CHAR(OM.CLOSE_TIME, 'YYYY-MM-DD HH24:MI')
                 WHEN W_SORT_STATUS = 'OT' THEN OTG.OT_TYPE_CODE
                 ELSE PM.PERSON_NUM
               END
             , T1.DEPT_SORT_NUM
             , T1.JOB_CATEGORY_SORT_NUM
             , T1.POST_SORT_NUM
             , PM.PERSON_NUM   
       ;     

  END SELECT_OT_LIST;

-- 包府流 儡诀 脚没 郴开 铰牢 贸府 --
  PROCEDURE UPDATE_OT_LIST_APPROVAL
            ( W_WORK_DATE             IN  DATE
            , W_PERSON_ID             IN  NUMBER
            , W_OT_TYPE_ID            IN  NUMBER
            , P_SELECT_YN             IN  VARCHAR2
            , P_STATUS_FLAG           IN  VARCHAR2
            , P_EVENT_STATUS          IN  VARCHAR2
            , P_REJECT_DESC           IN  VARCHAR2
            , P_USER_ID               IN  NUMBER
            , W_CONNECT_PERSON_ID     IN  NUMBER
            , W_SOB_ID                IN  NUMBER
            , W_ORG_ID                IN  NUMBER
            , O_STATUS                OUT VARCHAR2
            , O_MESSAGE               OUT VARCHAR2
            )
  AS
    V_SYSDATE           DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_STATUS_FLAG       VARCHAR2(10);
  BEGIN
    O_STATUS := 'F';
    IF P_SELECT_YN != 'Y' THEN
      O_STATUS := 'S';
      O_MESSAGE := P_SELECT_YN || TO_CHAR(W_WORK_DATE, 'YYYY-MM-DD') || TO_CHAR(W_PERSON_ID);
      RETURN;  
    END IF;
    
    IF P_STATUS_FLAG = 'B' AND P_EVENT_STATUS = 'C_OK' THEN
      -- 铰牢 贸府 --
      -- 馆妨惑怕老 版快 铰牢 贸府 给窃 --
      BEGIN
        SELECT OM.STATUS_FLAG
          INTO V_STATUS_FLAG          
          FROM HRD_OT_MANAGER OM
         WHERE OM.WORK_DATE       = W_WORK_DATE
           AND OM.PERSON_ID       = W_PERSON_ID
           AND OM.OT_TYPE_ID      = W_OT_TYPE_ID
           AND OM.SOB_ID          = W_SOB_ID
           AND OM.ORG_ID          = W_ORG_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        O_MESSAGE := 'C_OK OT Manager Find Error : ' || SUBSTR(SQLERRM, 1, 150);
        RETURN;
      END;
      IF V_STATUS_FLAG = 'R' THEN
        O_MESSAGE := '馆妨惑怕老 版快 铰牢贸府甫 且 荐 绝嚼聪促. 馆妨 秒家 饶 铰牢窍技夸';
        RETURN;
      END IF;
      
      UPDATE HRD_OT_MANAGER OM
         SET OM.STATUS_FLAG         = 'C'
           , OM.CONFIRMED_YN        = 'Y'
           , OM.CONFIRMED_DATE      = V_SYSDATE
           , OM.CONFIRMED_PERSON_ID = W_CONNECT_PERSON_ID
       WHERE OM.WORK_DATE           = W_WORK_DATE
         AND OM.PERSON_ID           = W_PERSON_ID
         AND OM.OT_TYPE_ID          = W_OT_TYPE_ID
         AND OM.SOB_ID              = W_SOB_ID
         AND OM.ORG_ID              = W_ORG_ID
      ;
    ELSIF P_STATUS_FLAG = 'C' AND P_EVENT_STATUS = 'C_CANCEL' THEN
      -- 铰牢 秒家 --
      -- 馆妨惑怕老 版快 铰牢 贸府 给窃 --
      BEGIN
        SELECT OM.STATUS_FLAG
          INTO V_STATUS_FLAG          
          FROM HRD_OT_MANAGER OM
         WHERE OM.WORK_DATE       = W_WORK_DATE
           AND OM.PERSON_ID       = W_PERSON_ID
           AND OM.OT_TYPE_ID      = W_OT_TYPE_ID
           AND OM.SOB_ID          = W_SOB_ID
           AND OM.ORG_ID          = W_ORG_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        O_MESSAGE := 'C_CANCEL OT Manager Find Error : ' || SUBSTR(SQLERRM, 1, 150);
        RETURN;
      END;
      IF V_STATUS_FLAG = 'R' THEN
        O_MESSAGE := '馆妨惑怕老 版快 铰牢贸府 秒家甫 且 荐 绝嚼聪促. 馆妨 秒家 饶 铰牢窍技夸';
        RETURN;
      END IF;
      
      UPDATE HRD_OT_MANAGER OM
         SET OM.STATUS_FLAG         = 'B'
           , OM.CONFIRMED_YN        = 'N'
           , OM.CONFIRMED_DATE      = V_SYSDATE
           , OM.CONFIRMED_PERSON_ID = W_CONNECT_PERSON_ID
       WHERE OM.WORK_DATE           = W_WORK_DATE
         AND OM.PERSON_ID           = W_PERSON_ID
         AND OM.OT_TYPE_ID          = W_OT_TYPE_ID
         AND OM.SOB_ID              = W_SOB_ID
         AND OM.ORG_ID              = W_ORG_ID
      ;
    ELSIF P_STATUS_FLAG IN('B', 'C') AND P_EVENT_STATUS = 'R_OK' THEN
      -- 馆妨 贸府 --
      IF P_REJECT_DESC IS NULL THEN
        O_MESSAGE := '馆妨荤蜡绰 鞘荐亲格涝聪促. 馆妨荤蜡甫 涝仿窍技夸';
        RETURN;
      END IF;
      
      UPDATE HRD_OT_MANAGER OM
         SET OM.STATUS_FLAG         = 'R'
           , OM.REJECT_DESC         = P_REJECT_DESC
           , OM.REJECT_YN           = 'Y'
           , OM.REJECT_DATE         = V_SYSDATE
           , OM.REJECT_PERSON_ID    = W_CONNECT_PERSON_ID
       WHERE OM.WORK_DATE           = W_WORK_DATE
         AND OM.PERSON_ID           = W_PERSON_ID
         AND OM.OT_TYPE_ID          = W_OT_TYPE_ID
         AND OM.SOB_ID              = W_SOB_ID
         AND OM.ORG_ID              = W_ORG_ID
      ;  
    ELSIF P_STATUS_FLAG = 'R' AND P_EVENT_STATUS = 'R_CANCEL' THEN
      -- 馆妨 秒家 --
      UPDATE HRD_OT_MANAGER OM
         SET OM.STATUS_FLAG         = CASE
                                        WHEN OM.CONFIRMED_YN = 'Y' THEN 'C'
                                        ELSE 'B'
                                      END
           , OM.REJECT_DESC         = NULL
           , OM.REJECT_YN           = 'N'
           , OM.REJECT_DATE         = V_SYSDATE
           , OM.REJECT_PERSON_ID    = W_CONNECT_PERSON_ID
       WHERE OM.WORK_DATE           = W_WORK_DATE
         AND OM.PERSON_ID           = W_PERSON_ID
         AND OM.OT_TYPE_ID          = W_OT_TYPE_ID
         AND OM.SOB_ID              = W_SOB_ID
         AND OM.ORG_ID              = W_ORG_ID
      ; 
    ELSE
      O_STATUS := 'F';
      O_MESSAGE := 'Not Found Status Flag. Please Select Status Flag'; 
    END IF;    
   O_STATUS := 'S';   
 END UPDATE_OT_LIST_APPROVAL;

-- 包府流 儡诀/漂辟 历厘(TRIGGER) 
  PROCEDURE INTERFACE_OT_MANAGER
            ( P_PERSON_ID                       IN  HRD_OT_MANAGER.PERSON_ID%TYPE 
            , P_SOB_ID                          IN  HRD_OT_MANAGER.SOB_ID%TYPE 
            , P_ORG_ID                          IN  HRD_OT_MANAGER.ORG_ID%TYPE 
            , P_OT_TYPE_ID                      IN  HRD_OT_MANAGER.OT_TYPE_ID%TYPE 
            , P_OT_DATE_FR                      IN  HRD_OT_MANAGER.OT_DATE_FR%TYPE
            , P_OT_DATE_TO                      IN  HRD_OT_MANAGER.OT_DATE_TO%TYPE
            , P_DESCRIPTION                     IN  HRD_OT_MANAGER.DESCRIPTION%TYPE 
            , P_STATUS_FLAG                     IN  HRD_OT_MANAGER.STATUS_FLAG%TYPE 
            , P_APPROVAL_YN                     IN  HRD_OT_MANAGER.APPROVAL_YN%TYPE 
            , P_APPROVAL_DATE                   IN  HRD_OT_MANAGER.APPROVAL_DATE%TYPE 
            , P_APPROVAL_PERSON_ID              IN  HRD_OT_MANAGER.APPROVAL_PERSON_ID%TYPE 
            , P_USER_ID                         IN  HRD_OT_MANAGER.CREATED_BY%TYPE 
            , O_STATUS                          OUT VARCHAR2
            , O_MESSAGE                         OUT VARCHAR2
            )
  AS
    V_SYSDATE           DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_RECORD_COUNT      NUMBER;   
    
    V_WORK_DATE         DATE;
  BEGIN
    O_STATUS := 'F';
    V_WORK_DATE := TRUNC(P_OT_DATE_FR);
    BEGIN
      SELECT COUNT(OM.PERSON_ID) AS CONFIRM_COUNT
        INTO V_RECORD_COUNT
        FROM HRD_OT_MANAGER OM
       WHERE OM.WORK_DATE         = V_WORK_DATE
         AND OM.PERSON_ID         = P_PERSON_ID
         AND OM.SOB_ID            = P_SOB_ID
         AND OM.ORG_ID            = P_ORG_ID
         AND OM.OT_TYPE_ID        = P_OT_TYPE_ID
         AND OM.CONFIRMED_YN      = 'Y'
      ;        
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;  
    END;
    IF V_RECORD_COUNT > 0 THEN
      O_MESSAGE := '1.Confirm Flag : ' || EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10115');
      RETURN;
    END IF;
    
    BEGIN
      SELECT COUNT(OM.PERSON_ID) AS CONFIRM_COUNT
        INTO V_RECORD_COUNT
        FROM HRD_OT_MANAGER OM
       WHERE OM.WORK_DATE         = V_WORK_DATE
         AND OM.PERSON_ID         = P_PERSON_ID
         AND OM.SOB_ID            = P_SOB_ID
         AND OM.ORG_ID            = P_ORG_ID
         AND OM.OT_TYPE_ID        = P_OT_TYPE_ID
         AND OM.TRANSFER_YN       = 'Y'
      ;        
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;  
    END;
    IF V_RECORD_COUNT > 0 THEN
      O_MESSAGE := '2.Transfer Flag : ' || EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10115');
      RETURN;
    END IF;
    
    BEGIN
      MERGE INTO HRD_OT_MANAGER OM
      USING ( SELECT V_WORK_DATE AS WORK_DATE
                   , P_PERSON_ID AS PERSON_ID
                   , P_OT_TYPE_ID AS OT_TYPE_ID 
                   , P_SOB_ID    AS SOB_ID
                   , P_ORG_ID    AS ORG_ID             
                FROM DUAL
            ) SX1
        ON (OM.WORK_DATE          = SX1.WORK_DATE
        AND OM.PERSON_ID          = SX1.PERSON_ID
        AND OM.SOB_ID             = SX1.SOB_ID
        AND OM.ORG_ID             = SX1.ORG_ID
        AND OM.OT_TYPE_ID         = SX1.OT_TYPE_ID
           )
      WHEN MATCHED THEN
        UPDATE
           SET OM.OT_DATE_FR        = P_OT_DATE_FR
             , OM.OT_DATE_TO        = P_OT_DATE_TO
             , OM.DESCRIPTION       = P_DESCRIPTION
             , OM.LAST_UPDATE_DATE  = V_SYSDATE
             , OM.LAST_UPDATED_BY   = P_USER_ID
      WHEN NOT MATCHED THEN
        INSERT
        ( WORK_DATE 
        , PERSON_ID 
        , SOB_ID 
        , ORG_ID 
        , OT_TYPE_ID 
        , OT_DATE_FR
        , OT_DATE_TO
        , DESCRIPTION 
        , STATUS_FLAG 
        , APPROVAL_YN 
        , APPROVAL_DATE 
        , APPROVAL_PERSON_ID 
        , CREATION_DATE 
        , CREATED_BY 
        , LAST_UPDATE_DATE 
        , LAST_UPDATED_BY 
        ) VALUES
        ( V_WORK_DATE 
        , P_PERSON_ID 
        , P_SOB_ID 
        , P_ORG_ID 
        , P_OT_TYPE_ID 
        , TRUNC(P_OT_DATE_FR, 'MI')
        , TRUNC(P_OT_DATE_TO, 'MI') 
        , P_DESCRIPTION 
        , P_STATUS_FLAG 
        , P_APPROVAL_YN 
        , P_APPROVAL_DATE 
        , P_APPROVAL_PERSON_ID 
        , V_SYSDATE  -- CREATION_DATE 
        , P_USER_ID  -- CREATED_BY 
        , V_SYSDATE  -- LAST_UPDATE_DATE 
        , P_USER_ID  -- LAST_UPDATED_BY 
        )
      ;           
    EXCEPTION WHEN OTHERS THEN
      O_MESSAGE := '3.Merge Error : ' || SUBSTR(SQLERRM, 1, 150);
      RETURN;
    END;
    O_STATUS := 'S';
  END INTERFACE_OT_MANAGER;


-- 包府流 儡诀 脚没 郴开 : 坷幅 郴开 炼雀 -- 
  PROCEDURE SELECT_OT_LIST_ERROR
            ( P_CURSOR1              OUT TYPES.TCURSOR1
            , W_WORK_CORP_ID         IN  NUMBER
            , W_WORK_DATE_FR         IN  DATE
            , W_WORK_DATE_TO         IN  DATE             
            , W_CORP_ID              IN  NUMBER
            , W_STATUS_FLAG          IN  VARCHAR2
            , W_DEPT_ID              IN  NUMBER
            , W_FLOOR_ID             IN  NUMBER
            , W_PERSON_ID            IN  NUMBER
            , W_ERROR_YN             IN  VARCHAR2
            , W_SORT_STATUS          IN  VARCHAR2
            , W_CONNECT_PERSON_ID    IN  NUMBER
            , W_SOB_ID               IN  NUMBER
						, W_ORG_ID               IN  NUMBER
						)
  AS
    V_CONNECT_PERSON_ID  HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;
    V_STATUS             VARCHAR2(4);
    V_MESSAGE            VARCHAR2(300);
  BEGIN
	  -- 辟怕鼻茄 汲沥.
		IF HRM_MANAGER_G.USER_CAP_F( W_CORP_ID => W_CORP_ID
		                           , W_START_DATE => W_WORK_DATE_FR
															 , W_END_DATE => W_WORK_DATE_TO
															 , W_MODULE_CODE => '20'
															 , W_PERSON_ID => W_CONNECT_PERSON_ID
															 , W_SOB_ID => W_SOB_ID
															 , W_ORG_ID => W_ORG_ID) = 'C' THEN
		  V_CONNECT_PERSON_ID := NULL;
		ELSE
		  V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
		END IF;
		IF W_STATUS_FLAG IN('A', 'N') THEN
      V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
    END IF;
    
    -- 包府流 儡诀 脚没 郴开 : 角力 免硼辟矫埃 馆康 棺 儡诀矫埃 拌魂  -- 
    SET_REAL_OT_TIME
      ( W_WORK_CORP_ID         => W_WORK_CORP_ID
      , W_WORK_DATE_FR         => W_WORK_DATE_FR
      , W_WORK_DATE_TO         => W_WORK_DATE_TO    
      , W_CORP_ID              => W_CORP_ID
      , W_DEPT_ID              => W_DEPT_ID
      , W_FLOOR_ID             => W_FLOOR_ID
      , W_PERSON_ID            => W_PERSON_ID
      , W_CONNECT_PERSON_ID    => W_CONNECT_PERSON_ID
      , W_SOB_ID               => W_SOB_ID
      , W_ORG_ID               => W_ORG_ID
      , O_STATUS               => V_STATUS
      , O_MESSAGE              => V_MESSAGE
      );
    IF V_STATUS = 'F' THEN
      RAISE_APPLICATION_ERROR(-20001, V_MESSAGE);
      RETURN;  
    END IF;
       
    OPEN P_CURSOR1 FOR
      SELECT OM.WORK_DATE
           , OM.PERSON_ID
           , PM.PERSON_NUM
           , PM.NAME
           , NVL(T1.DEPT_NAME, NULL) AS DEPT_NAME
           , NVL(T2.FLOOR_NAME, NULL) AS FLOOR_NAME
           , NVL(T1.POST_NAME, NULL) AS POST_NAME
           , HRM_COMMON_G.ID_NAME_F(OM.DUTY_ID) AS DUTY_NAME
           , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', OM.HOLY_TYPE, OM.SOB_ID, OM.ORG_ID) AS HOLY_TYPE_NAME
           , ( SELECT DC.DUTY_NAME
                 FROM HRD_DUTY_PERIOD DP
                    , HRM_DUTY_CODE_V DC
                WHERE DP.DUTY_ID          = DC.DUTY_ID
                  AND DP.PERSON_ID        = OM.PERSON_ID
                  AND DP.SOB_ID           = OM.SOB_ID
                  AND DP.ORG_ID           = OM.ORG_ID
                  AND DP.WORK_START_DATE  <= OM.WORK_DATE
                  AND DP.WORK_END_DATE    >= OM.WORK_DATE
                  AND ROWNUM              <= 1
             ) DUTY_PERIOD_DESC
           , OM.OPEN_TIME AS OPEN_TIME
           , OM.CLOSE_TIME AS CLOSE_TIME
           , OM.REAL_OT_TIME AS REAL_OT_TIME           
           , OM.OT_TYPE_ID
           , HRM_COMMON_G.ID_NAME_F(OM.OT_TYPE_ID) AS OT_TYPE_DESC
           , NVL(OM.OT_DATE_FR, NULL) AS OT_DATE_FR
           , NVL(OM.OT_DATE_TO, NULL) AS OT_DATE_TO
           , NVL(OTG.STD_OT_TIME, 0) AS STD_OT_TIME
           , OM.DESCRIPTION AS DESCRIPTION  
           , NVL(OM.REJECT_YN, 'N') AS REJECT_YN
           , NVL(OM.REJECT_DESC, NULL) AS REJECT_DESC
           , NVL(OM.STATUS_FLAG, 'B') AS STATUS_FLAG
           , HRM_COMMON_G.CODE_NAME_F('OT_TYPE_STATUS', OM.STATUS_FLAG, OM.SOB_ID, OM.ORG_ID) AS OT_TYPE_STATUS_DESC
           , NVL(T1.JOB_CATEGORY_CODE, NULL) AS JOB_CATE_CODE 
           , OM.DUTY_ID
           , DC.DUTY_CODE
           , OM.HOLY_TYPE
           , ( SELECT PM.NAME
                 FROM HRM_PERSON_MASTER PM
                WHERE PM.PERSON_ID    = OM.APPROVAL_PERSON_ID
             ) AS APPROVAL_PERSON_NAME
           , ( SELECT PM.NAME
                 FROM HRM_PERSON_MASTER PM
                WHERE PM.PERSON_ID    = OM.CONFIRMED_PERSON_ID                
             ) AS CONFIRM_PERSON_NAME
           , OM.CREATION_DATE  -- 脚没老矫  
        FROM HRD_OT_MANAGER    OM
           , HRM_OT_TYPE_GW_V  OTG
           , HRM_DUTY_CODE_V   DC
           , HRM_PERSON_MASTER PM
           , (-- 矫痢 牢荤郴开.
             SELECT HL.PERSON_ID
                  , HL.DEPT_ID
                  , DM.DEPT_CODE
                  , DM.DEPT_NAME
                  , DM.DEPT_SORT_NUM
                  , PC.POST_CODE                  
                  , PC.POST_NAME AS POST_NAME
                  , PC.SORT_NUM AS POST_SORT_NUM
                  , JC.JOB_CATEGORY_CODE
                  , JC.JOB_CATEGORY_NAME
                  , JC.SORT_NUM AS JOB_CATEGORY_SORT_NUM
               FROM HRM_HISTORY_HEADER HH
                  , HRM_HISTORY_LINE   HL
                  , HRM_DEPT_MASTER    DM
                  , HRM_POST_CODE_V    PC
                  , HRM_JOB_CATEGORY_CODE_V JC
             WHERE HH.HISTORY_HEADER_ID = HL.HISTORY_HEADER_ID
               AND HL.DEPT_ID           = DM.DEPT_ID
               AND HL.POST_ID           = PC.POST_ID
               AND HL.JOB_CATEGORY_ID   = JC.JOB_CATEGORY_ID
               AND HL.HISTORY_LINE_ID  
                     IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                            FROM HRM_HISTORY_LINE S_HL
                          WHERE S_HL.CHARGE_DATE            <= W_WORK_DATE_TO
                            AND S_HL.PERSON_ID              = HL.PERSON_ID
                          GROUP BY S_HL.PERSON_ID
                        )
            ) T1
          , (-- 矫痢 牢荤郴开.
              SELECT PH.PERSON_ID
                   , PH.FLOOR_ID
                   , PH.SOB_ID
                   , PH.ORG_ID
                   , HF.FLOOR_CODE
                   , HF.FLOOR_NAME
                   , HF.SORT_NUM AS FLOOR_SORT_NUM
                FROM HRD_PERSON_HISTORY        PH
                   , HRM_FLOOR_V               HF
              WHERE PH.FLOOR_ID           = HF.FLOOR_ID                
                AND PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE_TO
                AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE_TO
            ) T2
          , HRD_WORK_CALENDAR  WC
       WHERE OM.OT_TYPE_ID              = OTG.OT_TYPE_ID
         AND OM.DUTY_ID                 = DC.DUTY_ID(+)
         AND OM.PERSON_ID               = PM.PERSON_ID
         AND PM.PERSON_ID               = T1.PERSON_ID
         AND PM.PERSON_ID               = T2.PERSON_ID
         AND OM.WORK_DATE               = WC.WORK_DATE(+)
         AND OM.PERSON_ID               = WC.PERSON_ID(+)
         AND OM.SOB_ID                  = WC.SOB_ID(+)
         AND OM.ORG_ID                  = WC.ORG_ID(+)
/*         AND OM.WORK_DATE               = T3.WORK_DATE(+)
         AND OM.PERSON_ID               = T3.PERSON_ID(+)
         AND OM.SOB_ID                  = T3.SOB_ID(+)
         AND OM.ORG_ID                  = T3.ORG_ID(+)*/
         AND PM.WORK_CORP_ID            = W_WORK_CORP_ID
         AND ((W_CORP_ID                IS NULL AND 1 = 1)
           OR (W_CORP_ID                IS NOT NULL AND PM.CORP_ID = W_CORP_ID))
         AND OM.WORK_DATE               BETWEEN W_WORK_DATE_FR AND W_WORK_DATE_TO
         AND ((W_STATUS_FLAG            = 'A' AND 1 = 1)
           OR (W_STATUS_FLAG            != 'A' AND OM.STATUS_FLAG = W_STATUS_FLAG))
         AND PM.SOB_ID                  = W_SOB_ID
         AND PM.ORG_ID                  = W_ORG_ID
         AND ((W_PERSON_ID              IS NULL AND 1 = 1)
           OR (W_PERSON_ID              IS NOT NULL AND PM.PERSON_ID = W_PERSON_ID))
         AND PM.JOIN_DATE               <= W_WORK_DATE_TO
         AND (PM.RETIRE_DATE            >= W_WORK_DATE_FR OR PM.RETIRE_DATE IS NULL)
         AND ((W_DEPT_ID                IS NULL AND 1 = 1)
           OR (W_DEPT_ID                IS NOT NULL AND T1.DEPT_ID = W_DEPT_ID))  
         AND ((W_FLOOR_ID               IS NULL AND 1 = 1)
           OR (W_FLOOR_ID               IS NOT NULL AND T2.FLOOR_ID = W_FLOOR_ID))
         AND ((W_ERROR_YN               = 'N' AND 1 = 1)
           OR (W_ERROR_YN               != 'N' 
             AND ((NVL(OM.REAL_OT_TIME, 0) < NVL(OTG.STD_OT_TIME, 0))
               OR (OM.HOLY_TYPE IN('2', '3') AND WC.OPEN_TIME < TRUNC(NVL(OM.OPEN_TIME, WC.OPEN_TIME), 'MI'))
               OR (OM.HOLY_TYPE IN('2', '3') AND TRUNC(NVL(OM.CLOSE_TIME, WC.CLOSE_TIME), 'MI') < WC.CLOSE_TIME)
               OR (OM.HOLY_TYPE IN('2', '3') AND OTG.OT_TYPE_CODE IN('210', '220'))
               OR (OM.HOLY_TYPE IN('0', '1') AND OTG.OT_TYPE_CODE IN('110', '120')))))          
      ORDER BY OM.WORK_DATE
             , CASE  -- 1瞒 沥纺 扁霖(SORT 鉴辑) -- 
                 WHEN W_SORT_STATUS = 'WC' THEN '1' || LPAD(T2.FLOOR_SORT_NUM, 7, '0')
                 WHEN W_SORT_STATUS = 'IT' THEN TO_CHAR(OM.OPEN_TIME, 'YYYY-MM-DD HH24:MI')
                 WHEN W_SORT_STATUS = 'CT' THEN TO_CHAR(OM.CLOSE_TIME, 'YYYY-MM-DD HH24:MI')
                 WHEN W_SORT_STATUS = 'OT' THEN OTG.OT_TYPE_CODE
                 ELSE PM.PERSON_NUM
               END
             , CASE  -- 2瞒 沥纺 扁霖(内靛) -- 
                 WHEN W_SORT_STATUS = 'WC' THEN T2.FLOOR_CODE
                 WHEN W_SORT_STATUS = 'IT' THEN TO_CHAR(OM.OPEN_TIME, 'YYYY-MM-DD HH24:MI')
                 WHEN W_SORT_STATUS = 'CT' THEN TO_CHAR(OM.CLOSE_TIME, 'YYYY-MM-DD HH24:MI')
                 WHEN W_SORT_STATUS = 'OT' THEN OTG.OT_TYPE_CODE
                 ELSE PM.PERSON_NUM
               END
             , T1.DEPT_SORT_NUM
             , T1.JOB_CATEGORY_SORT_NUM             
             , T1.POST_SORT_NUM
             , PM.PERSON_NUM   
       ;  
  END SELECT_OT_LIST_ERROR;
  

-- 包府流 儡诀 包府 荐扁 火涝 --
  PROCEDURE INSERT_OT_LIST
            ( P_WORK_DATE           IN  HRD_OT_MANAGER.WORK_DATE%TYPE
            , P_PERSON_ID           IN  HRD_OT_MANAGER.PERSON_ID%TYPE
            , P_SOB_ID              IN  HRD_OT_MANAGER.SOB_ID%TYPE
            , P_ORG_ID              IN  HRD_OT_MANAGER.ORG_ID%TYPE
            , P_OT_TYPE_ID          IN  HRD_OT_MANAGER.OT_TYPE_ID%TYPE
            , P_OT_DATE_FR          IN  HRD_OT_MANAGER.OT_DATE_FR%TYPE
            , P_OT_DATE_TO          IN  HRD_OT_MANAGER.OT_DATE_TO%TYPE
            , P_DESCRIPTION         IN  HRD_OT_MANAGER.DESCRIPTION%TYPE
            , P_USER_ID             IN  NUMBER
            , P_CONNECT_PERSON_ID   IN  NUMBER
            )
  AS
    V_SYSDATE           DATE := GET_LOCAL_DATE(P_SOB_ID);
    
    V_RECORD_COUNT      NUMBER;
  BEGIN
    -- DATA VALIDATE --
    IF P_WORK_DATE IS NULL THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10015'));
      RETURN;  
    END IF;
    
    IF P_PERSON_ID IS NULL THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10016'));
      RETURN;  
    END IF;    
    V_RECORD_COUNT := 0;
    IF P_PERSON_ID IS NOT NULL THEN
      BEGIN
        SELECT COUNT(PM.PERSON_ID) AS RECORD_COUNT
          INTO V_RECORD_COUNT
          FROM HRM_PERSON_MASTER PM
         WHERE PM.PERSON_ID       = P_PERSON_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        V_RECORD_COUNT := 0;
      END;
      IF V_RECORD_COUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10028'));
        RETURN;  
      END IF;
    END IF;
    
    IF P_OT_TYPE_ID IS NULL THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10488'));
      RETURN;  
    END IF;    
    V_RECORD_COUNT := 0;
    IF P_OT_TYPE_ID IS NOT NULL THEN
      BEGIN
        SELECT COUNT(OTG.OT_TYPE_ID) AS RECORD_COUNT
          INTO V_RECORD_COUNT
          FROM HRM_OT_TYPE_GW_V OTG
         WHERE OTG.OT_TYPE_ID     = P_OT_TYPE_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        V_RECORD_COUNT := 0;
      END;
      IF V_RECORD_COUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10488'));
        RETURN;  
      END IF;
    END IF;
    
    IF P_OT_DATE_FR IS NULL THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10489'));
      RETURN;  
    END IF;    
    
    IF P_OT_DATE_TO IS NULL THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10489'));
      RETURN;  
    END IF;    
                
    -- 铰牢咯何 眉农  -- 
    V_RECORD_COUNT := 0;
    BEGIN
      SELECT COUNT(OM.PERSON_ID) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM HRD_OT_MANAGER OM
       WHERE OM.WORK_DATE         = P_WORK_DATE
         AND OM.PERSON_ID         = P_PERSON_ID
         AND OM.SOB_ID            = P_SOB_ID
         AND OM.ORG_ID            = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0; 
    END;
    IF V_RECORD_COUNT > 0 THEN
      -- 悼老 单捞磐 粮犁 : 坷幅 --
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10044', '&&VALUE:=秦寸 老磊俊&&TEXT:=犬牢'));
      RETURN;  
    END IF;       
    
    INSERT INTO HRD_OT_MANAGER
    ( WORK_DATE 
    , PERSON_ID 
    , SOB_ID 
    , ORG_ID 
    , OT_TYPE_ID 
    , OT_DATE_FR 
    , OT_DATE_TO 
    , DESCRIPTION 
    , STATUS_FLAG 
    , APPROVAL_YN 
    , APPROVAL_DATE 
    , APPROVAL_PERSON_ID 
    , ATTRIBUTE_A  -- 荐扁 积己 备盒 --
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY 
    ) VALUES
    ( P_WORK_DATE 
    , P_PERSON_ID 
    , P_SOB_ID 
    , P_ORG_ID 
    , P_OT_TYPE_ID 
    , TRUNC(P_OT_DATE_FR, 'MI') 
    , TRUNC(P_OT_DATE_TO, 'MI') 
    , P_DESCRIPTION     
    , 'B'  -- STATUS_FLAG  : 泅诀铰牢 --
    , 'Y'  -- APPROVAL_YN 
    , V_SYSDATE -- APPROVAL_DATE 
    , P_CONNECT_PERSON_ID  -- APPROVAL_PERSON_ID 
    , 'MANUAL'   -- 荐扁 积己 备盒 --
    , V_SYSDATE  -- CREATION_DATE 
    , P_USER_ID  -- CREATED_BY 
    , V_SYSDATE  -- LAST_UPDATE_DATE 
    , P_USER_ID  -- LAST_UPDATED_BY 
    );
  END INSERT_OT_LIST;
  
            
-- 包府流 儡诀 包府 荐扁 荐沥 --
  PROCEDURE UPDATE_OT_LIST
            ( W_WORK_DATE           IN  HRD_OT_MANAGER.WORK_DATE%TYPE
            , W_PERSON_ID           IN  HRD_OT_MANAGER.PERSON_ID%TYPE
            , W_SOB_ID              IN  HRD_OT_MANAGER.SOB_ID%TYPE
            , W_ORG_ID              IN  HRD_OT_MANAGER.ORG_ID%TYPE
            , P_OT_TYPE_ID          IN  HRD_OT_MANAGER.OT_TYPE_ID%TYPE
            , P_OT_DATE_FR          IN  HRD_OT_MANAGER.OT_DATE_FR%TYPE
            , P_OT_DATE_TO          IN  HRD_OT_MANAGER.OT_DATE_TO%TYPE
            , P_DESCRIPTION         IN  HRD_OT_MANAGER.DESCRIPTION%TYPE
            , P_USER_ID             IN  NUMBER
            , P_CONNECT_PERSON_ID   IN  NUMBER
            )
  AS
    V_SYSDATE           DATE := GET_LOCAL_DATE(W_SOB_ID);
    
    V_RECORD_COUNT      NUMBER;
  BEGIN
    -- DATA VALIDATE --
    IF W_WORK_DATE IS NULL THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10015'));
      RETURN;  
    END IF;
    
    IF W_PERSON_ID IS NULL THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10016'));
      RETURN;  
    END IF;    
    V_RECORD_COUNT := 0;
    IF W_PERSON_ID IS NOT NULL THEN
      BEGIN
        SELECT COUNT(PM.PERSON_ID) AS RECORD_COUNT
          INTO V_RECORD_COUNT
          FROM HRM_PERSON_MASTER PM
         WHERE PM.PERSON_ID       = W_PERSON_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        V_RECORD_COUNT := 0;
      END;
      IF V_RECORD_COUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10028'));
        RETURN;  
      END IF;
    END IF;
    
    IF P_OT_TYPE_ID IS NULL THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10488'));
      RETURN;  
    END IF;    
    V_RECORD_COUNT := 0;
    IF P_OT_TYPE_ID IS NOT NULL THEN
      BEGIN
        SELECT COUNT(OTG.OT_TYPE_ID) AS RECORD_COUNT
          INTO V_RECORD_COUNT
          FROM HRM_OT_TYPE_GW_V OTG
         WHERE OTG.OT_TYPE_ID     = P_OT_TYPE_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        V_RECORD_COUNT := 0;
      END;
      IF V_RECORD_COUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10488'));
        RETURN;  
      END IF;
    END IF;
    
    IF P_OT_DATE_FR IS NULL THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10489'));
      RETURN;  
    END IF;    
    
    IF P_OT_DATE_TO IS NULL THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10489'));
      RETURN;  
    END IF;    
                
    -- DUPLICATION VALIDATE -- 
    V_RECORD_COUNT := 0;
    BEGIN
      SELECT COUNT(OM.PERSON_ID) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM HRD_OT_MANAGER OM
       WHERE OM.WORK_DATE         = W_WORK_DATE
         AND OM.PERSON_ID         = W_PERSON_ID
         AND OM.SOB_ID            = W_SOB_ID
         AND OM.ORG_ID            = W_ORG_ID
         AND OM.CONFIRMED_YN      = 'Y'
         
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0; 
    END;
    IF V_RECORD_COUNT > 0 THEN
      -- 铰牢 单捞磐 粮犁 : 坷幅 --
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10115'));
      RETURN;  
    END IF;       
    
    UPDATE HRD_OT_MANAGER OM
       SET OM.OT_TYPE_ID        = P_OT_TYPE_ID
         , OM.OT_DATE_FR        = TRUNC(P_OT_DATE_FR, 'MI') 
         , OM.OT_DATE_TO        = TRUNC(P_OT_DATE_TO, 'MI') 
         , OM.DESCRIPTION       = P_DESCRIPTION
         , OM.ATTRIBUTE_A       = 'MANUAL'        -- 荐扁 荐沥 --
         , OM.LAST_UPDATE_DATE  = V_SYSDATE
         , OM.LAST_UPDATED_BY   = P_USER_ID
     WHERE OM.WORK_DATE         = W_WORK_DATE
       AND OM.PERSON_ID         = W_PERSON_ID
       AND OM.SOB_ID            = W_SOB_ID
       AND OM.ORG_ID            = W_ORG_ID
    ;
  END UPDATE_OT_LIST;
  
-- 包府流 儡诀 包府 荐扁 昏力 --
  PROCEDURE DELETE_OT_LIST
            ( W_WORK_DATE           IN  HRD_OT_MANAGER.WORK_DATE%TYPE
            , W_PERSON_ID           IN  HRD_OT_MANAGER.PERSON_ID%TYPE
            , W_SOB_ID              IN  HRD_OT_MANAGER.SOB_ID%TYPE
            , W_ORG_ID              IN  HRD_OT_MANAGER.ORG_ID%TYPE
            , P_USER_ID             IN  NUMBER
            , P_CONNECT_PERSON_ID   IN  NUMBER
            )
  AS
    V_SYSDATE           DATE := GET_LOCAL_DATE(W_SOB_ID);
    
    V_RECORD_COUNT      NUMBER;
  BEGIN
    -- 2013-10-22 : 炼急固s 夸没 -- 
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_MSG_F('EAPP_10013'));
      RETURN;  
  
  
  
    -- DATA VALIDATE --
    IF W_WORK_DATE IS NULL THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10015'));
      RETURN;  
    END IF;
    
    IF W_PERSON_ID IS NULL THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10016'));
      RETURN;  
    END IF;    
    V_RECORD_COUNT := 0;
    IF W_PERSON_ID IS NOT NULL THEN
      BEGIN
        SELECT COUNT(PM.PERSON_ID) AS RECORD_COUNT
          INTO V_RECORD_COUNT
          FROM HRM_PERSON_MASTER PM
         WHERE PM.PERSON_ID       = W_PERSON_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        V_RECORD_COUNT := 0;
      END;
      IF V_RECORD_COUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10028'));
        RETURN;  
      END IF;
    END IF;      
                
    -- 铰牢咯何 眉农  -- 
    V_RECORD_COUNT := 0;
    BEGIN
      SELECT COUNT(OM.PERSON_ID) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM HRD_OT_MANAGER OM
       WHERE OM.WORK_DATE         = W_WORK_DATE
         AND OM.PERSON_ID         = W_PERSON_ID
         AND OM.SOB_ID            = W_SOB_ID
         AND OM.ORG_ID            = W_ORG_ID
         AND OM.CONFIRMED_YN      = 'Y'
         
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0; 
    END;
    IF V_RECORD_COUNT > 0 THEN
      -- 铰牢 单捞磐 粮犁 : 坷幅 --
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10115'));
      RETURN;  
    END IF;       
    
    DELETE FROM HRD_OT_MANAGER OM
     WHERE OM.WORK_DATE         = W_WORK_DATE
       AND OM.PERSON_ID         = W_PERSON_ID
       AND OM.SOB_ID            = W_SOB_ID
       AND OM.ORG_ID            = W_ORG_ID
    ;
  END DELETE_OT_LIST;
  
  
-- 包府流 儡诀 扁埃俊 蝶弗 笼拌 棺 鞭咯 馆康 --
  PROCEDURE SELECT_OT_LIST_SUM
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_WORK_CORP_ID         IN  NUMBER
            , W_WORK_DATE_FR         IN  DATE
						, W_WORK_DATE_TO         IN  DATE             
						, W_CORP_ID              IN  NUMBER
            , W_TRANSFER_FLAG        IN  VARCHAR2  -- 鞭惑咯 傈价咯何 --
            , W_DEPT_ID              IN  NUMBER
            , W_FLOOR_ID             IN  NUMBER
						, W_PERSON_ID            IN  NUMBER
						, W_CONNECT_PERSON_ID    IN  NUMBER
						, W_SOB_ID               IN  NUMBER
						, W_ORG_ID               IN  NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT 'N' AS SELECT_YN
           , NVL(PM.PERSON_ID, NULL) AS PERSON_ID
           , NVL(PM.PERSON_NUM, NULL) AS PERSON_NUM
           , NVL(PM.NAME, NULL) AS NAME
           , NVL(PM.JOIN_DATE, NULL) AS JOIN_DATE
           , NVL(PM.RETIRE_DATE, NULL) AS RETIRE_DATE
           , NVL(T1.DEPT_NAME, NULL) AS DEPT_NAME
           , NVL(T1.POST_NAME, NULL) AS POST_NAME
           , NVL(T1.JOB_CATEGORY_NAME, NULL) AS JOB_CATEGORY_NAME
           , NVL(T2.FLOOR_NAME, NULL) AS FLOOR_NAME
           , SUM(CASE OTG.OT_TYPE_CODE
                   WHEN '110' THEN 1
                   ELSE 0
                 END) AS OT_TYPE_110
           , SUM(CASE OTG.OT_TYPE_CODE
                   WHEN '120' THEN 1
                   ELSE 0
                 END) AS OT_TYPE_120
           , SUM(CASE OTG.OT_TYPE_CODE
                   WHEN '210' THEN 1
                   ELSE 0
                 END) AS OT_TYPE_210
           , SUM(CASE OTG.OT_TYPE_CODE
                   WHEN '220' THEN 1
                   ELSE 0
                 END) AS OT_TYPE_220    
             
           , SUM(CASE OTG.OT_TYPE_CODE
                   WHEN '110' THEN OM.OT_AMOUNT
                   ELSE 0
                 END) AS OT_AMOUNT_110
           , SUM(CASE OTG.OT_TYPE_CODE
                   WHEN '120' THEN OM.OT_AMOUNT
                   ELSE 0
                 END) AS OT_AMOUNT_120
           , SUM(CASE OTG.OT_TYPE_CODE
                   WHEN '210' THEN OM.OT_AMOUNT
                   ELSE 0
                 END) AS OT_AMOUNT_210
           , SUM(CASE OTG.OT_TYPE_CODE
                   WHEN '220' THEN OM.OT_AMOUNT
                   ELSE 0
                 END) AS OT_AMOUNT_220 
           , SUM(OM.OT_AMOUNT) AS OT_AMOUNT
           , DECODE(MAX(OM.TRANSFER_YN), 'Y', NVL(MAX(OM.PAY_YYYYMM), NULL), NULL) AS PAY_YYYYMM
           , DECODE(MAX(OM.TRANSFER_YN), 'Y', NVL(MAX(HRM_COMMON_G.CODE_NAME_F('WAGE_TYPE', OM.WAGE_TYPE, OM.SOB_ID, OM.ORG_ID)), NULL), NULL) AS WAGE_TYPE_DESC
           , DECODE(MAX(OM.TRANSFER_YN), 'Y', NVL(MAX(OM.TRANSFER_YN), NULL), NULL) AS TRANSFER_YN
           , DECODE(MAX(OM.TRANSFER_YN), 'Y', NVL(MAX(HRM_PERSON_MASTER_G.NAME_F(OM.TRANSFER_PERSON_ID)), NULL), NULL) AS TRANSFER_NAME
        FROM HRM_PERSON_MASTER PM
           , HRD_OT_MANAGER    OM
           , HRM_OT_TYPE_GW_V  OTG
           , (-- 矫痢 牢荤郴开.
             SELECT HL.PERSON_ID
                  , HL.DEPT_ID
                  , DM.DEPT_CODE
                  , DM.DEPT_NAME
                  , DM.DEPT_SORT_NUM
                  , PC.POST_CODE                  
                  , PC.POST_NAME AS POST_NAME
                  , PC.SORT_NUM AS POST_SORT_NUM
                  , JC.JOB_CATEGORY_CODE
                  , JC.JOB_CATEGORY_NAME
                  , JC.SORT_NUM AS JOB_CATEGORY_SORT_NUM
               FROM HRM_HISTORY_HEADER HH
                  , HRM_HISTORY_LINE   HL
                  , HRM_DEPT_MASTER    DM
                  , HRM_POST_CODE_V    PC
                  , HRM_JOB_CATEGORY_CODE_V JC
             WHERE HH.HISTORY_HEADER_ID = HL.HISTORY_HEADER_ID
               AND HL.DEPT_ID           = DM.DEPT_ID
               AND HL.POST_ID           = PC.POST_ID
               AND HL.JOB_CATEGORY_ID   = JC.JOB_CATEGORY_ID
               AND HH.SOB_ID            = W_SOB_ID
               AND HH.ORG_ID            = W_ORG_ID
               AND HL.HISTORY_LINE_ID  
                     IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                            FROM HRM_HISTORY_LINE S_HL
                          WHERE S_HL.CHARGE_DATE            <= W_WORK_DATE_TO
                            AND S_HL.PERSON_ID              = HL.PERSON_ID
                          GROUP BY S_HL.PERSON_ID
                        )
            ) T1
          , (-- 矫痢 牢荤郴开.
              SELECT PH.PERSON_ID
                   , PH.FLOOR_ID
                   , HF.FLOOR_CODE
                   , HF.FLOOR_NAME
                   , HF.SORT_NUM AS FLOOR_SORT_NUM
                FROM HRD_PERSON_HISTORY        PH
                   , HRM_FLOOR_V               HF
              WHERE PH.FLOOR_ID           = HF.FLOOR_ID
                AND PH.SOB_ID             = W_SOB_ID
                AND PH.ORG_ID             = W_ORG_ID
                AND PH.EFFECTIVE_DATE_FR  <= W_WORK_DATE_TO
                AND PH.EFFECTIVE_DATE_TO  >= W_WORK_DATE_TO
            ) T2
       WHERE PM.PERSON_ID               = OM.PERSON_ID
         AND OM.OT_TYPE_ID              = OTG.OT_TYPE_ID
         AND PM.PERSON_ID               = T1.PERSON_ID
         AND PM.PERSON_ID               = T2.PERSON_ID
         AND PM.WORK_CORP_ID            = W_WORK_CORP_ID
         AND ((W_PERSON_ID              IS NULL AND 1 = 1)
           OR (W_PERSON_ID              IS NOT NULL AND PM.PERSON_ID = W_PERSON_ID))
         AND ((W_CORP_ID                IS NULL AND 1 = 1)
           OR (W_CORP_ID                IS NOT NULL AND PM.CORP_ID = W_CORP_ID))
         AND ((W_DEPT_ID                IS NULL AND 1 = 1)
           OR (W_DEPT_ID                IS NOT NULL AND T1.DEPT_ID = W_DEPT_ID))         
         AND ((W_FLOOR_ID               IS NULL AND 1 = 1)
           OR (W_FLOOR_ID               IS NOT NULL AND T2.FLOOR_ID = W_FLOOR_ID))
         AND OM.WORK_DATE               BETWEEN W_WORK_DATE_FR AND W_WORK_DATE_TO   
         AND OM.SOB_ID                  = W_SOB_ID
         AND OM.ORG_ID                  = W_ORG_ID
         AND PM.JOIN_DATE               <= OM.WORK_DATE
         AND (PM.RETIRE_DATE            >= OM.WORK_DATE OR PM.RETIRE_DATE IS NULL)
         AND OM.CONFIRMED_YN            = 'Y'
         AND OM.STATUS_FLAG             = W_TRANSFER_FLAG
      GROUP BY PM.PERSON_ID
             , PM.PERSON_NUM
             , PM.NAME
             , PM.JOIN_DATE
             , PM.RETIRE_DATE
             , T1.DEPT_NAME
             , T1.POST_NAME
             , T1.JOB_CATEGORY_NAME
             , T2.FLOOR_NAME
             , OM.SOB_ID
             , OM.ORG_ID
             , T2.FLOOR_SORT_NUM
             , T1.POST_SORT_NUM
      ORDER BY T2.FLOOR_SORT_NUM
             , T1.POST_SORT_NUM       
      ;  
  END SELECT_OT_LIST_SUM;


-- 包府流 儡诀 脚没 郴开 : 角力 免硼辟矫埃 馆康 棺 儡诀矫埃 拌魂  -- 
  PROCEDURE SET_REAL_OT_TIME
            ( W_WORK_CORP_ID         IN  NUMBER
            , W_WORK_DATE_FR         IN  DATE
            , W_WORK_DATE_TO         IN  DATE             
            , W_CORP_ID              IN  NUMBER
            , W_DEPT_ID              IN  NUMBER
            , W_FLOOR_ID             IN  NUMBER
            , W_PERSON_ID            IN  NUMBER
            , W_CONNECT_PERSON_ID    IN  NUMBER
            , W_SOB_ID               IN  NUMBER
						, W_ORG_ID               IN  NUMBER
            , O_STATUS               OUT VARCHAR2
            , O_MESSAGE              OUT VARCHAR2
						)
  AS
  BEGIN
    O_STATUS := 'F';
    FOR C1 IN ( SELECT OM.WORK_DATE
                     , OM.PERSON_ID
                     , PM.PERSON_NUM
                     , PM.NAME                     
                     , PM.SOB_ID
                     , PM.ORG_ID
                     , T1.JOB_CATEGORY_CODE
                  FROM HRD_OT_MANAGER    OM
                     , HRM_PERSON_MASTER PM
                     , (-- 矫痢 牢荤郴开.
                       SELECT HL.PERSON_ID
                            , HL.DEPT_ID
                            , DM.DEPT_CODE
                            , DM.DEPT_NAME
                            , DM.DEPT_SORT_NUM
                            , PC.POST_CODE                  
                            , PC.POST_NAME AS POST_NAME
                            , PC.SORT_NUM AS POST_SORT_NUM
                            , JC.JOB_CATEGORY_CODE
                            , JC.JOB_CATEGORY_NAME
                            , JC.SORT_NUM AS JOB_CATEGORY_SORT_NUM
                         FROM HRM_HISTORY_HEADER HH
                            , HRM_HISTORY_LINE   HL
                            , HRM_DEPT_MASTER    DM
                            , HRM_POST_CODE_V    PC
                            , HRM_JOB_CATEGORY_CODE_V JC
                       WHERE HH.HISTORY_HEADER_ID = HL.HISTORY_HEADER_ID
                         AND HL.DEPT_ID           = DM.DEPT_ID
                         AND HL.POST_ID           = PC.POST_ID
                         AND HL.JOB_CATEGORY_ID   = JC.JOB_CATEGORY_ID
                         AND HL.HISTORY_LINE_ID  
                               IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                      FROM HRM_HISTORY_LINE S_HL
                                    WHERE S_HL.CHARGE_DATE            <= W_WORK_DATE_TO
                                      AND S_HL.PERSON_ID              = HL.PERSON_ID
                                    GROUP BY S_HL.PERSON_ID
                                  )
                      ) T1
                    , (-- 矫痢 牢荤郴开.
                        SELECT PH.PERSON_ID
                             , PH.FLOOR_ID
                             , PH.SOB_ID
                             , PH.ORG_ID
                             , HF.FLOOR_CODE
                             , HF.FLOOR_NAME
                             , HF.SORT_NUM AS FLOOR_SORT_NUM
                          FROM HRD_PERSON_HISTORY        PH
                             , HRM_FLOOR_V               HF
                        WHERE PH.FLOOR_ID           = HF.FLOOR_ID                          
                          AND PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE_TO
                          AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE_TO
                      ) T2
                 WHERE OM.PERSON_ID               = PM.PERSON_ID
                   AND PM.PERSON_ID               = T1.PERSON_ID
                   AND PM.PERSON_ID               = T2.PERSON_ID
                   AND PM.WORK_CORP_ID            = W_WORK_CORP_ID
                   AND ((W_CORP_ID                IS NULL AND 1 = 1)
                     OR (W_CORP_ID                IS NOT NULL AND PM.CORP_ID = W_CORP_ID))
                   AND OM.WORK_DATE               BETWEEN W_WORK_DATE_FR AND W_WORK_DATE_TO
                   AND OM.STATUS_FLAG             IN('B', 'C', 'R') 
                   AND PM.SOB_ID                  = W_SOB_ID
                   AND PM.ORG_ID                  = W_ORG_ID
                   AND ((W_PERSON_ID              IS NULL AND 1 = 1)
                     OR (W_PERSON_ID              IS NOT NULL AND PM.PERSON_ID = W_PERSON_ID))
                   AND PM.JOIN_DATE               <= W_WORK_DATE_TO
                   AND (PM.RETIRE_DATE            >= W_WORK_DATE_FR OR PM.RETIRE_DATE IS NULL) 
                   AND ((W_DEPT_ID                IS NULL AND 1 = 1)
                     OR (W_DEPT_ID                IS NOT NULL AND T1.DEPT_ID = W_DEPT_ID))         
                   AND ((W_FLOOR_ID               IS NULL AND 1 = 1)
                     OR (W_FLOOR_ID               IS NOT NULL AND T2.FLOOR_ID = W_FLOOR_ID))                        
                ORDER BY OM.WORK_DATE
                       , PM.PERSON_NUM   
              )
    LOOP
      -- 辟怕/辟公 UPDATE --  
      BEGIN
        UPDATE HRD_OT_MANAGER OM
          SET  ( OM.DUTY_ID
               , OM.HOLY_TYPE
               ) =
               ( SELECT DI.DUTY_ID
                      , DI.HOLY_TYPE
                   FROM HRD_DAY_INTERFACE_V DI
                  WHERE DI.WORK_DATE              = C1.WORK_DATE
                    AND DI.PERSON_ID              = C1.PERSON_ID
                    AND DI.SOB_ID                 = C1.SOB_ID
                    AND DI.ORG_ID                 = C1.ORG_ID
                )                
         WHERE OM.WORK_DATE         = C1.WORK_DATE
           AND OM.PERSON_ID         = C1.PERSON_ID
           AND OM.SOB_ID            = C1.SOB_ID
           AND OM.ORG_ID            = C1.ORG_ID
        ;    
      EXCEPTION WHEN OTHERS THEN
        O_MESSAGE := 'Duty/Holy update Error : ' || SUBSTR(SQLERRM, 1, 150);
        RETURN;
      END;   
            
      -- 免硼辟 矫埃 棺 寇免 矫埃 UPDATE -- 
      BEGIN
        UPDATE HRD_OT_MANAGER OM
          SET  ( OM.OPEN_TIME
               , OM.CLOSE_TIME
               , OM.LEAVE_TIME
               ) =
               ( SELECT DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) AS OPEN_TIME
                      , CASE
                           -- 饶老 硼辟扁废 佬绢坷扁(窜, 荐沥荤亲捞 乐栏搁 荐沥荤亲 馆康).
                           WHEN (DI.NEXT_DAY_YN   = 'Y'
                              OR DI.HOLY_TYPE    IN('N', '3')
                              OR DI.DANGJIK_YN    = 'Y'
                              OR DI.ALL_NIGHT_YN  = 'Y') THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, (SELECT S_DI.CLOSE_TIME
                                                                                                                 FROM HRD_DAY_INTERFACE_V S_DI
                                                                                                                WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                                                                  AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                                                                  AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                                                                  AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                                                                  AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                                                                              ))
                           WHEN DI.HOLY_TYPE IN ('0', '1') 
                               AND DC.DUTY_CODE = '53' -- 绒老辟公(1187)
                               AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) >
                                     TO_DATE(TO_CHAR(DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME), 'YYYY-MM-DD') || ' ' || '17:30:00', 'YYYY-MM-DD HH24:MI:SS')
                                  THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, (SELECT S_DI.CLOSE_TIME
                                                                                          FROM HRD_DAY_INTERFACE_V     S_DI
                                                                                         WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                                           AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                                           AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                                           AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                                           AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                                                       ))
                           WHEN S_WC.HOLY_TYPE = '3' -- 具埃
                              AND(DC.DUTY_CODE      = '19' -- 版炼绒啊(1174)
                               OR DC.DUTY_CODE      = '12' -- 背腊(1170)
                               OR DC.DUTY_CODE      = '20' -- 斥瞒(1175)
                               OR DC.DUTY_CODE      = '54' -- 公鞭绒啊(1189)
                               OR DC.DUTY_CODE      = '52' -- 公鞭绒老(1182)
                               OR DC.DUTY_CODE      = '17' -- 颇斑(1172)
                               OR DC.DUTY_CODE      = '55' -- 蜡鞭绒啊(1190)
                               OR DC.DUTY_CODE      = '18' -- 免厘(1173)
                               OR DC.DUTY_CODE      = '13' -- 绕访(1171)
                               OR DC.DUTY_CODE      = '51' -- 绒老(1188)
                                 ) THEN NULL
                           WHEN DI.MODIFY_FLAG = 'N' AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) IS NULL
                                                     AND DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, DI.CLOSE_TIME) IS NOT NULL
                                                     AND DC.DUTY_CODE  = '51' -- 绒老(1188)
                                                     AND S_WC.ALL_NIGHT_YN =  'Y' THEN NULL
                           WHEN DI.MODIFY_FLAG = 'N' AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) IS NULL
                                                     AND DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, DI.CLOSE_TIME) IS NOT NULL
                                                     AND DC.DUTY_CODE IN ( '18' -- 免厘(1173)
                                                                         , '19' -- 版炼绒啊(1174)
                                                                         , '20' -- 斥瞒(1175)
                                                                         , '22' -- 焊扒绒啊(1177)
                                                                         , '23' -- 楷吝绒啊(1178)
                                                                         , '24' -- 措眉绒公(1179)
                                                                         , '52' -- 公鞭绒老(1182)
                                                                         , '53' -- 绒老辟公(1187)
                                                                         , '51' -- 绒老(1188)
                                                                         , '54' -- 公鞭绒啊(1189)
                                                                         , '55' -- 蜡鞭绒啊(1190)
                                                                         , '79' -- 寸流(1194)
                                                                         , '99' -- 枚具(3784)
                                                                         )
                                                     AND ((SELECT HDC.DUTY_CODE
                                                              FROM HRD_DAY_INTERFACE_V     S_DI
                                                                , HRM_DUTY_CODE_V HDC
                                                             WHERE S_DI.DUTY_ID       =  HDC.DUTY_ID
                                                               AND S_DI.SOB_ID        =  DI.SOB_ID
                                                               AND S_DI.ORG_ID        =  DI.ORG_ID
                                                               AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                               AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                               AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                             ) = '53' -- 绒老辟公(1187)
                                                          AND (S_WC.ALL_NIGHT_YN = 'Y'  -- 枚具
                                                            OR S_WC.DANGJIK_YN = 'Y'    -- 寸流.
                                                              )
                                                         ) THEN NULL
                           WHEN DC.DUTY_CODE        = '00' -- 免辟(1168)
                                AND (SELECT S_DI.NEXT_DAY_YN
                                       FROM HRD_DAY_INTERFACE_V   S_DI
                                      WHERE S_DI.SOB_ID       = DI.SOB_ID
                                        AND S_DI.ORG_ID       = DI.ORG_ID
                                        AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                        AND S_DI.PERSON_ID    = DI.PERSON_ID
                                        AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                    ) = 'Y' -- 饶老硼辟
                                    THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, (SELECT S_DI.CLOSE_TIME1
                                                                                            FROM HRD_DAY_INTERFACE_V S_DI
                                                                                           WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                                             AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                                             AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                                             AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                                             AND S_DI.WORK_DATE     =  DI.WORK_DATE
                                                                                         ))
                           WHEN DC.DUTY_CODE        = '00' -- 免辟(1168)
                                AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) IS NULL
                                AND (SELECT S_DI.ALL_NIGHT_YN
                                       FROM HRD_DAY_INTERFACE   S_DI
                                      WHERE S_DI.SOB_ID       = DI.SOB_ID
                                        AND S_DI.ORG_ID       = DI.ORG_ID
                                        AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                        AND S_DI.PERSON_ID    = DI.PERSON_ID
                                        AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                    ) = 'Y' -- 傈老 枚具
                                    THEN NULL
                           WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME
                           ELSE DI.CLOSE_TIME
                        END AS CLOSE_TIME
                      , HRM_COMMON_G.CODE_NAME_F('LEAVE_OUT_TIME', DI.LEAVE_TIME_CODE, DI.SOB_ID, DI.ORG_ID) AS LEAVE_TIME                  
                   FROM HRD_DAY_INTERFACE_V DI
                      , HRM_DUTY_CODE_V     DC
                      , HRD_DAY_MODIFY      I_DM
                      , HRD_DAY_MODIFY      O_DM
                      , (-- 傈老 辟公 沥焊 炼雀.
                         SELECT WC.WORK_DATE + 1 AS WORK_DATE
                              , WC.PERSON_ID
                              , WC.CORP_ID
                              , WC.SOB_ID
                              , WC.ORG_ID
                              , WC.HOLY_TYPE
                              , WC.DANGJIK_YN
                              , WC.ALL_NIGHT_YN
                           FROM HRD_WORK_CALENDAR   WC
                          WHERE WC.SOB_ID         = C1.SOB_ID
                            AND WC.ORG_ID         = C1.ORG_ID
                            AND WC.WORK_DATE      = (C1.WORK_DATE - 1)
                            AND WC.PERSON_ID      = C1.PERSON_ID
                        ) S_WC
                  WHERE DI.DUTY_ID                = DC.DUTY_ID
                    AND DI.PERSON_ID              = I_DM.PERSON_ID(+)
                    AND DI.WORK_DATE              = I_DM.WORK_DATE(+)
                    AND '1'                       = I_DM.IO_FLAG(+)
                    AND DI.PERSON_ID              = O_DM.PERSON_ID(+)
                    AND DI.WORK_DATE              = O_DM.WORK_DATE(+)
                    AND '2'                       = O_DM.IO_FLAG(+)
                    AND DI.WORK_DATE              = S_WC.WORK_DATE(+)
                    AND DI.PERSON_ID              = S_WC.PERSON_ID(+)
                    AND DI.SOB_ID                 = S_WC.SOB_ID(+)
                    AND DI.ORG_ID                 = S_WC.ORG_ID(+)
                    AND DI.WORK_DATE              = C1.WORK_DATE
                    AND DI.PERSON_ID              = C1.PERSON_ID
                    AND DI.SOB_ID                 = C1.SOB_ID
                    AND DI.ORG_ID                 = C1.ORG_ID
                )                
         WHERE OM.WORK_DATE         = C1.WORK_DATE
           AND OM.PERSON_ID         = C1.PERSON_ID
           AND OM.SOB_ID            = C1.SOB_ID
           AND OM.ORG_ID            = C1.ORG_ID
        ;    
      EXCEPTION WHEN OTHERS THEN
        O_MESSAGE := 'In/Out time update Error : ' || SUBSTR(SQLERRM, 1, 150);
        RETURN;
      END;      
            
      -- 儡诀 拌魂 -- 
      BEGIN
        UPDATE HRD_OT_MANAGER OM
          SET  OM.REAL_OT_TIME = REAL_OT_TIME_F
                                  ( OM.WORK_DATE  -- W_WORK_DATE            IN  DATE
                                  , NULL          -- W_DUTY_CODE            IN  VARCHAR2
                                  , OM.HOLY_TYPE  -- W_HOLY_TYPE            IN  VARCHAR2
                                  , C1.JOB_CATEGORY_CODE  -- W_JOB_CATE_CODE        IN  VARCHAR2
                                  , OM.OPEN_TIME  -- W_OPEN_TIME            IN  DATE
                                  , OM.CLOSE_TIME -- W_CLOSE_TIME           IN  DATE
                                  , OM.SOB_ID     -- W_SOB_ID               IN  NUMBER
                                  , OM.ORG_ID     -- W_ORG_ID               IN  NUMBER
                                  )
         WHERE OM.WORK_DATE         = C1.WORK_DATE
           AND OM.PERSON_ID         = C1.PERSON_ID
           AND OM.SOB_ID            = C1.SOB_ID
           AND OM.ORG_ID            = C1.ORG_ID
        ;    
      EXCEPTION WHEN OTHERS THEN
        O_MESSAGE := 'Real O/T time update Error : ' || SUBSTR(SQLERRM, 1, 150);
        RETURN;
      END;        
    END LOOP C1;    
    O_STATUS := 'S';
    
    
    /*
    SELECT OM.WORK_DATE
           , OM.PERSON_ID
           , PM.PERSON_NUM
           , PM.NAME
           , NVL(T1.DEPT_NAME, NULL) AS DEPT_NAME
           , NVL(T2.FLOOR_NAME, NULL) AS FLOOR_NAME
           , NVL(T1.POST_NAME, NULL) AS POST_NAME
           , NVL(T3.DUTY_NAME, NULL) AS DUTY_NAME
           , NVL(T3.HOLY_TYPE_NAME, NULL) AS HOLY_TYPE_NAME
           , T3.OPEN_TIME
           , T3.CLOSE_TIME
           , ( NVL(CASE
                     WHEN T3.CLOSE_TIME IS NULL THEN 0
                     WHEN T3.OPEN_TIME IS NULL THEN 0 
                     WHEN HRD_DAY_LEAVE_G_SET.CLOSE_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.CLOSE_TIME) <=
                           CASE
                             WHEN T3.HOLY_TYPE IN('0', '1') THEN 
                               HRD_DAY_LEAVE_G_SET.OT_START_TIME_F( HRD_DAY_LEAVE_G_SET.OPEN_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.OPEN_TIME)
                                                                  , OM.WORK_DATE + 0.354166666666667  -- 08:30 --
                                                                  , OM.WORK_DATE + 0.354166666666667) -- 08:30 -- 
                             WHEN T3.HOLY_TYPE IN('3') THEN 
                               HRD_DAY_LEAVE_G_SET.OT_START_TIME_F( HRD_DAY_LEAVE_G_SET.OPEN_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.OPEN_TIME)
                                                                  , OM.WORK_DATE + 1.270833333333333  -- +1 06:30 --
                                                                  , OM.WORK_DATE + 1.270833333333333) 
                             WHEN T3.HOLY_TYPE IN('2') THEN 
                               HRD_DAY_LEAVE_G_SET.OT_START_TIME_F( HRD_DAY_LEAVE_G_SET.OPEN_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.OPEN_TIME)
                                                                  , OM.WORK_DATE + 0.75  -- 18:00 --
                                                                  , OM.WORK_DATE + 0.75)
                             ELSE
                               HRD_DAY_LEAVE_G_SET.CLOSE_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.CLOSE_TIME) 
                           END THEN 0
                     ELSE (HRD_DAY_LEAVE_G_SET.CLOSE_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.CLOSE_TIME) - 
                           CASE
                             WHEN T3.HOLY_TYPE IN('0', '1') THEN 
                               HRD_DAY_LEAVE_G_SET.OT_START_TIME_F( HRD_DAY_LEAVE_G_SET.OPEN_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.OPEN_TIME)
                                                                  , OM.WORK_DATE + 0.354166666666667  -- 08:30 --
                                                                  , OM.WORK_DATE + 0.354166666666667) -- 08:30 -- 
                             WHEN T3.HOLY_TYPE IN('3') THEN 
                               HRD_DAY_LEAVE_G_SET.OT_START_TIME_F( HRD_DAY_LEAVE_G_SET.OPEN_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.OPEN_TIME)
                                                                  , OM.WORK_DATE + 1.270833333333333  -- +1 06:30 --
                                                                  , OM.WORK_DATE + 1.270833333333333) 
                             \*WHEN T3.HOLY_TYPE IN('2') THEN *\
                             ELSE
                               HRD_DAY_LEAVE_G_SET.OT_START_TIME_F( HRD_DAY_LEAVE_G_SET.OPEN_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.OPEN_TIME)
                                                                  , OM.WORK_DATE + 0.75  -- 18:00 --
                                                                  , OM.WORK_DATE + 0.75)
                             \*ELSE
                               HRD_DAY_LEAVE_G_SET.CLOSE_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.CLOSE_TIME) *\
                           END) 
                   END, 0) * 24) -
             ( CASE
                 WHEN T3.HOLY_TYPE IN('2', '3') THEN 0
                 ELSE NVL(HRD_DAY_LEAVE_G_SET.FOOD_DED_TIME_F(T3.WORK_DATE
                                                            , '2'
                                                            , HRD_DAY_LEAVE_G_SET.OPEN_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.OPEN_TIME)
                                                            , HRD_DAY_LEAVE_G_SET.CLOSE_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.CLOSE_TIME)
                                                            , T1.JOB_CATEGORY_CODE
                                                            , PM.SOB_ID
                                                            , PM.ORG_ID), 0)
               END +  
               CASE
                 WHEN T3.HOLY_TYPE IN('2') THEN 0
                 ELSE NVL(HRD_DAY_LEAVE_G_SET.FOOD_DED_TIME_F(T3.WORK_DATE
                                                            , '3'
                                                            , HRD_DAY_LEAVE_G_SET.OPEN_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.OPEN_TIME)
                                                            , HRD_DAY_LEAVE_G_SET.CLOSE_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.CLOSE_TIME)
                                                            , T1.JOB_CATEGORY_CODE
                                                            , PM.SOB_ID
                                                            , PM.ORG_ID), 0)
               END +                                      
               CASE
                 WHEN T3.HOLY_TYPE IN('3') THEN 0
                 ELSE NVL(HRD_DAY_LEAVE_G_SET.FOOD_DED_TIME_F(T3.WORK_DATE + 1
                                                            , '4'
                                                            , HRD_DAY_LEAVE_G_SET.OPEN_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.OPEN_TIME)
                                                            , HRD_DAY_LEAVE_G_SET.CLOSE_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.CLOSE_TIME)
                                                            , T1.JOB_CATEGORY_CODE
                                                            , PM.SOB_ID
                                                            , PM.ORG_ID), 0)
               END
             ) AS REAL_OT_TIME
           , OM.OT_TYPE_ID
           , HRM_COMMON_G.ID_NAME_F(OM.OT_TYPE_ID) AS OT_TYPE_DESC
           , OM.OT_DATE_FR
           , OM.OT_DATE_TO
           , OTG.STD_OT_TIME
           , SUBSTR(OM.DESCRIPTION, 1, 250) AS DESCRIPTION  
           , NVL(OM.REJECT_YN, 'N') AS REJECT_YN
           , NVL(OM.REJECT_DESC, NULL) AS REJECT_DESC
           , NVL(OM.STATUS_FLAG, 'B') AS STATUS_FLAG
           , HRM_COMMON_G.CODE_NAME_F('OT_TYPE_STATUS', OM.STATUS_FLAG, OM.SOB_ID, OM.ORG_ID) AS OT_TYPE_STATUS_DESC
           , NVL(T1.JOB_CATEGORY_CODE, NULL) AS JOB_CATE_CODE 
           , T3.DUTY_ID
           , T3.DUTY_CODE
           , T3.HOLY_TYPE
        FROM HRD_OT_MANAGER    OM
           , HRM_OT_TYPE_GW_V  OTG
           , HRM_PERSON_MASTER PM
           , (-- 矫痢 牢荤郴开.
             SELECT HL.PERSON_ID
                  , HL.DEPT_ID
                  , DM.DEPT_CODE
                  , DM.DEPT_NAME
                  , DM.DEPT_SORT_NUM
                  , PC.POST_CODE                  
                  , PC.POST_NAME AS POST_NAME
                  , PC.SORT_NUM AS POST_SORT_NUM
                  , JC.JOB_CATEGORY_CODE
                  , JC.JOB_CATEGORY_NAME
                  , JC.SORT_NUM AS JOB_CATEGORY_SORT_NUM
               FROM HRM_HISTORY_HEADER HH
                  , HRM_HISTORY_LINE   HL
                  , HRM_DEPT_MASTER    DM
                  , HRM_POST_CODE_V    PC
                  , HRM_JOB_CATEGORY_CODE_V JC
             WHERE HH.HISTORY_HEADER_ID = HL.HISTORY_HEADER_ID
               AND HL.DEPT_ID           = DM.DEPT_ID
               AND HL.POST_ID           = PC.POST_ID
               AND HL.JOB_CATEGORY_ID   = JC.JOB_CATEGORY_ID
               AND ((W_DEPT_ID          IS NULL AND 1 = 1)
                 OR (W_DEPT_ID          IS NOT NULL AND HL.DEPT_ID = W_DEPT_ID))         
               AND HL.HISTORY_LINE_ID  
                     IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                            FROM HRM_HISTORY_LINE S_HL
                          WHERE S_HL.CHARGE_DATE            <= W_WORK_DATE_TO
                            AND S_HL.PERSON_ID              = HL.PERSON_ID
                          GROUP BY S_HL.PERSON_ID
                        )
            ) T1
          , (-- 矫痢 牢荤郴开.
              SELECT PH.PERSON_ID
                   , PH.FLOOR_ID
                   , PH.SOB_ID
                   , PH.ORG_ID
                   , HF.FLOOR_CODE
                   , HF.FLOOR_NAME
                   , HF.SORT_NUM AS FLOOR_SORT_NUM
                FROM HRD_PERSON_HISTORY        PH
                   , HRM_FLOOR_V               HF
              WHERE PH.FLOOR_ID           = HF.FLOOR_ID
                AND ((W_FLOOR_ID          IS NULL AND 1 = 1)
                 OR (W_FLOOR_ID           IS NOT NULL AND PH.FLOOR_ID = W_FLOOR_ID))
                AND PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE_TO
                AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE_FR
            ) T2
          , ( SELECT DI.WORK_DATE
                  , DI.PERSON_ID
                  , DI.SOB_ID
                  , DI.ORG_ID
                  , DI.DUTY_ID
                  , DC.DUTY_CODE
                  , HRM_COMMON_G.ID_NAME_F(DI.DUTY_ID) AS DUTY_NAME
                  , DI.HOLY_TYPE
                  , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DI.HOLY_TYPE, DI.SOB_ID, DI.ORG_ID) AS HOLY_TYPE_NAME
                  , SUBSTR(TO_CHAR(DI.WORK_DATE, 'DAY', 'NLS_DATE_LANGUAGE=KOREAN'), 1, 1)    AS W
                  , DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) AS OPEN_TIME
                  , CASE
                         -- 饶老 硼辟扁废 佬绢坷扁(窜, 荐沥荤亲捞 乐栏搁 荐沥荤亲 馆康).
                         WHEN (DI.NEXT_DAY_YN   = 'Y'
                            OR DI.HOLY_TYPE    IN('N', '3')
                            OR DI.DANGJIK_YN    = 'Y'
                            OR DI.ALL_NIGHT_YN  = 'Y') THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, (SELECT S_DI.CLOSE_TIME
                                                                                                               FROM HRD_DAY_INTERFACE_V S_DI
                                                                                                              WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                                                                AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                                                                AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                                                                AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                                                                AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                                                                            ))
                         WHEN DI.HOLY_TYPE IN ('0', '1') 
                             AND DC.DUTY_CODE = '53' -- 绒老辟公(1187)
                             AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) >
                                   TO_DATE(TO_CHAR(DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME), 'YYYY-MM-DD') || ' ' || '17:30:00', 'YYYY-MM-DD HH24:MI:SS')
                                THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, (SELECT S_DI.CLOSE_TIME
                                                                                        FROM HRD_DAY_INTERFACE_V     S_DI
                                                                                       WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                                         AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                                         AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                                         AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                                         AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                                                     ))
                         WHEN S_WC.HOLY_TYPE = '3' -- 具埃
                            AND(DC.DUTY_CODE      = '19' -- 版炼绒啊(1174)
                             OR DC.DUTY_CODE      = '12' -- 背腊(1170)
                             OR DC.DUTY_CODE      = '20' -- 斥瞒(1175)
                             OR DC.DUTY_CODE      = '54' -- 公鞭绒啊(1189)
                             OR DC.DUTY_CODE      = '52' -- 公鞭绒老(1182)
                             OR DC.DUTY_CODE      = '17' -- 颇斑(1172)
                             OR DC.DUTY_CODE      = '55' -- 蜡鞭绒啊(1190)
                             OR DC.DUTY_CODE      = '18' -- 免厘(1173)
                             OR DC.DUTY_CODE      = '13' -- 绕访(1171)
                             OR DC.DUTY_CODE      = '51' -- 绒老(1188)
                               ) THEN NULL
                         WHEN DI.MODIFY_FLAG = 'N' AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) IS NULL
                                                   AND DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, DI.CLOSE_TIME) IS NOT NULL
                                                   AND DC.DUTY_CODE  = '51' -- 绒老(1188)
                                                   AND S_WC.ALL_NIGHT_YN =  'Y' THEN NULL
                         WHEN DI.MODIFY_FLAG = 'N' AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) IS NULL
                                                   AND DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, DI.CLOSE_TIME) IS NOT NULL
                                                   AND DC.DUTY_CODE IN ( '18' -- 免厘(1173)
                                                                       , '19' -- 版炼绒啊(1174)
                                                                       , '20' -- 斥瞒(1175)
                                                                       , '22' -- 焊扒绒啊(1177)
                                                                       , '23' -- 楷吝绒啊(1178)
                                                                       , '24' -- 措眉绒公(1179)
                                                                       , '52' -- 公鞭绒老(1182)
                                                                       , '53' -- 绒老辟公(1187)
                                                                       , '51' -- 绒老(1188)
                                                                       , '54' -- 公鞭绒啊(1189)
                                                                       , '55' -- 蜡鞭绒啊(1190)
                                                                       , '79' -- 寸流(1194)
                                                                       , '99' -- 枚具(3784)
                                                                       )
                                                   AND ((SELECT HDC.DUTY_CODE
                                                            FROM HRD_DAY_INTERFACE_V     S_DI
                                                              , HRM_DUTY_CODE_V HDC
                                                           WHERE S_DI.DUTY_ID       =  HDC.DUTY_ID
                                                             AND S_DI.SOB_ID        =  DI.SOB_ID
                                                             AND S_DI.ORG_ID        =  DI.ORG_ID
                                                             AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                             AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                             AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                           ) = '53' -- 绒老辟公(1187)
                                                        AND (S_WC.ALL_NIGHT_YN = 'Y'  -- 枚具
                                                          OR S_WC.DANGJIK_YN = 'Y'    -- 寸流.
                                                            )
                                                       ) THEN NULL
                         WHEN DC.DUTY_CODE        = '00' -- 免辟(1168)
                              AND (SELECT S_DI.NEXT_DAY_YN
                                     FROM HRD_DAY_INTERFACE_V   S_DI
                                    WHERE S_DI.SOB_ID       = DI.SOB_ID
                                      AND S_DI.ORG_ID       = DI.ORG_ID
                                      AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                      AND S_DI.PERSON_ID    = DI.PERSON_ID
                                      AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                  ) = 'Y' -- 饶老硼辟
                                  THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, (SELECT S_DI.CLOSE_TIME1
                                                                                          FROM HRD_DAY_INTERFACE_V S_DI
                                                                                         WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                                           AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                                           AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                                           AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                                           AND S_DI.WORK_DATE     =  DI.WORK_DATE
                                                                                       ))
                         WHEN DC.DUTY_CODE        = '00' -- 免辟(1168)
                              AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) IS NULL
                              AND (SELECT S_DI.ALL_NIGHT_YN
                                     FROM HRD_DAY_INTERFACE   S_DI
                                    WHERE S_DI.SOB_ID       = DI.SOB_ID
                                      AND S_DI.ORG_ID       = DI.ORG_ID
                                      AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                      AND S_DI.PERSON_ID    = DI.PERSON_ID
                                      AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                  ) = 'Y' -- 傈老 枚具
                                  THEN NULL
                         WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME
                         ELSE DI.CLOSE_TIME
                    END AS CLOSE_TIME
                  , HRM_COMMON_G.ID_NAME_F(NVL(I_DM.MODIFY_ID, O_DM.MODIFY_ID)) AS MODIFY_DESC
                  , CASE WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                   AND DI.CLOSE_TIME IS NOT NULL
                                                   AND DC.DUTY_CODE  =  '53' THEN '' -- 绒老辟公(1187)
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                   AND DI.CLOSE_TIME IS NOT NULL
                                                   AND DC.DUTY_CODE  =  '00' -- 免辟(1168)
                                                   AND DI.HOLY_TYPE  = '2' THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                   AND DI.CLOSE_TIME IS NULL
                                                   AND DC.DUTY_CODE  =  '11' -- 搬辟(1169)
                                                   AND DI.HOLY_TYPE  = '2' THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                   AND DI.CLOSE_TIME IS NULL
                                                   AND(DC.DUTY_CODE      = '19' -- 版炼绒啊(1174)
                                                     OR DC.DUTY_CODE      = '12' -- 背腊(1170)
                                                     OR DC.DUTY_CODE      = '20' -- 斥瞒(1175)                                                     
                                                     OR DC.DUTY_CODE      = '24' -- 措眉绒公(1179)
                                                     OR DC.DUTY_CODE      = '54' -- 公鞭绒啊(1189)
                                                     OR DC.DUTY_CODE      = '52' -- 公鞭绒老(1182)                                                     
                                                     OR DC.DUTY_CODE      = '22' -- 焊扒绒啊(1177)
                                                     OR DC.DUTY_CODE      = '23' -- 楷吝绒啊(1178)
                                                     OR DC.DUTY_CODE      = '55' -- 蜡鞭绒啊(1190)                                                     
                                                     OR DC.DUTY_CODE      = '17' -- 颇斑(1172)
                                                     OR DC.DUTY_CODE      = '18' -- 免厘(1173)
                                                     OR DC.DUTY_CODE      = '13' -- 绕访(1171)
                                                     OR DC.DUTY_CODE      = '51' -- 绒老(1188)
                                                    ) THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                   AND(SELECT S_DI.HOLY_TYPE
                                                         FROM HRD_DAY_INTERFACE_V   S_DI
                                                        WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                          AND S_DI.ORG_ID       = DI.ORG_ID
                                                          AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                          AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                          AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                      ) = '3' -- 具埃
                                                   AND(DC.DUTY_CODE      = '19' -- 版炼绒啊(1174)
                                                     OR DC.DUTY_CODE      = '12' -- 背腊(1170)
                                                     OR DC.DUTY_CODE      = '20' -- 斥瞒(1175)                                                     
                                                     OR DC.DUTY_CODE      = '24' -- 措眉绒公(1179)
                                                     OR DC.DUTY_CODE      = '54' -- 公鞭绒啊(1189)
                                                     OR DC.DUTY_CODE      = '52' -- 公鞭绒老(1182)                                                     
                                                     OR DC.DUTY_CODE      = '22' -- 焊扒绒啊(1177)
                                                     OR DC.DUTY_CODE      = '23' -- 楷吝绒啊(1178)
                                                     OR DC.DUTY_CODE      = '55' -- 蜡鞭绒啊(1190)                                                     
                                                     OR DC.DUTY_CODE      = '17' -- 颇斑(1172)
                                                     OR DC.DUTY_CODE      = '18' -- 免厘(1173)
                                                     OR DC.DUTY_CODE      = '13' -- 绕访(1171)
                                                     OR DC.DUTY_CODE      = '51' -- 绒老(1188)
                                                      ) THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                   AND DI.CLOSE_TIME IS NOT NULL
                                                   AND DC.DUTY_CODE  =  '00' -- 免辟(1168)
                                                   AND DI.HOLY_TYPE  = '3'  -- 具埃
                                                   AND (SELECT S_DI.CLOSE_TIME
                                                          FROM HRD_DAY_INTERFACE_V     S_DI
                                                         WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                           AND S_DI.ORG_ID        =  DI.ORG_ID
                                                           AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                           AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                           AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                       ) IS NOT NULL THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                   AND DI.CLOSE_TIME IS NULL
                                                   AND DC.DUTY_CODE  =  '00' -- 免辟(1168)
                                                   AND DI.HOLY_TYPE  = '3'   -- 具埃
                                                   AND (SELECT S_DI.CLOSE_TIME
                                                          FROM HRD_DAY_INTERFACE_V     S_DI
                                                         WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                           AND S_DI.ORG_ID        =  DI.ORG_ID
                                                           AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                           AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                           AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                       ) IS NOT NULL THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                   AND DC.DUTY_CODE  =  '11' -- 搬辟(1169)
                                                   AND DI.HOLY_TYPE  = '3'   -- 具埃
                                                   AND (SELECT S_DI.CLOSE_TIME
                                                          FROM HRD_DAY_INTERFACE_V     S_DI
                                                         WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                           AND S_DI.ORG_ID        =  DI.ORG_ID
                                                           AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                           AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                           AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                        ) IS NULL THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME    IS NOT NULL
                                                   AND DI.CLOSE_TIME   IS NULL
                                                   AND DC.DUTY_CODE    =  '53' -- 绒老辟公(1187)
                                                   AND DI.ALL_NIGHT_YN = 'Y'  -- 枚具
                                                   AND DI.HOLY_TYPE    = '1'  -- 绒老
                                                   AND (SELECT S_DI.CLOSE_TIME
                                                          FROM HRD_DAY_INTERFACE_V     S_DI
                                                         WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                           AND S_DI.ORG_ID        =  DI.ORG_ID
                                                           AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                           AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                           AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                       ) IS NOT NULL THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                   AND DI.CLOSE_TIME IS NOT NULL
                                                   AND DC.DUTY_CODE  = '51' -- 绒老(1188)
                                                   AND (SELECT S_DI.ALL_NIGHT_YN -- 枚具
                                                          FROM HRD_DAY_INTERFACE_V   S_DI
                                                         WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                           AND S_DI.ORG_ID        =  DI.ORG_ID
                                                           AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                           AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                           AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                       ) = 'Y' THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                   AND DI.CLOSE_TIME IS NOT NULL
                                                   AND DC.DUTY_CODE  = '22' -- 焊扒绒啊(1177)
                                                   AND (SELECT DI.HOLY_TYPE
                                                          FROM HRD_DAY_INTERFACE_V     S_DI
                                                         WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                           AND S_DI.ORG_ID        =  DI.ORG_ID
                                                           AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                           AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                           AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                       ) = '3' THEN '' -- 具埃
                         WHEN DI.HOLY_TYPE IN ('0', '1') AND DC.DUTY_CODE    =  '53' -- 绒老辟公(1187)
                                                         AND DI.OPEN_TIME > TO_DATE(TO_CHAR(DI.OPEN_TIME, 'YYYY-MM-DD') || ' ' || '17:30:00', 'YYYY-MM-DD HH24:MI:SS')
                                                         AND (SELECT S_DI.CLOSE_TIME
                                                                FROM HRD_DAY_INTERFACE_V     S_DI
                                                               WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                 AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                 AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                 AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                 AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                             ) IS NOT NULL THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.CLOSE_TIME IS NOT NULL
                                                   AND(SELECT HDC.DUTY_CODE -- 绒老辟公
                                                         FROM HRD_DAY_INTERFACE_V     S_DI
                                                           , HRM_DUTY_CODE_V          HDC
                                                        WHERE S_DI.DUTY_ID       = HDC.DUTY_ID
                                                          AND S_DI.SOB_ID        =  DI.SOB_ID
                                                          AND S_DI.ORG_ID        =  DI.ORG_ID
                                                          AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                          AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                          AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                      ) = '53' -- 绒老辟公(1187)
                                                   AND(DC.DUTY_CODE      = '19' -- 版炼绒啊(1174)
                                                     OR DC.DUTY_CODE      = '12' -- 背腊(1170)
                                                     OR DC.DUTY_CODE      = '20' -- 斥瞒(1175)                                                     
                                                     OR DC.DUTY_CODE      = '24' -- 措眉绒公(1179)
                                                     OR DC.DUTY_CODE      = '54' -- 公鞭绒啊(1189)
                                                     OR DC.DUTY_CODE      = '52' -- 公鞭绒老(1182)                                                     
                                                     OR DC.DUTY_CODE      = '22' -- 焊扒绒啊(1177)
                                                     OR DC.DUTY_CODE      = '23' -- 楷吝绒啊(1178)
                                                     OR DC.DUTY_CODE      = '55' -- 蜡鞭绒啊(1190)                                                     
                                                     OR DC.DUTY_CODE      = '17' -- 颇斑(1172)
                                                     OR DC.DUTY_CODE      = '18' -- 免厘(1173)
                                                     OR DC.DUTY_CODE      = '13' -- 绕访(1171)
                                                     OR DC.DUTY_CODE      = '51' -- 绒老(1188)
                                                      ) THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                   AND DI.CLOSE_TIME IS NOT NULL
                                                   AND(SELECT S_DI.CLOSE_TIME
                                                         FROM HRD_DAY_INTERFACE_V     S_DI
                                                        WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                          AND S_DI.ORG_ID        =  DI.ORG_ID
                                                          AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                          AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                          AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                      ) IS NOT NULL
                                                   AND(DC.DUTY_CODE      = '19' -- 版炼绒啊(1174)
                                                     OR DC.DUTY_CODE      = '12' -- 背腊(1170)
                                                     OR DC.DUTY_CODE      = '20' -- 斥瞒(1175)                                                     
                                                     OR DC.DUTY_CODE      = '24' -- 措眉绒公(1179)
                                                     OR DC.DUTY_CODE      = '54' -- 公鞭绒啊(1189)
                                                     OR DC.DUTY_CODE      = '52' -- 公鞭绒老(1182)                                                     
                                                     OR DC.DUTY_CODE      = '22' -- 焊扒绒啊(1177)
                                                     OR DC.DUTY_CODE      = '23' -- 楷吝绒啊(1178)
                                                     OR DC.DUTY_CODE      = '55' -- 蜡鞭绒啊(1190)                                                     
                                                     OR DC.DUTY_CODE      = '17' -- 颇斑(1172)
                                                     OR DC.DUTY_CODE      = '18' -- 免厘(1173)
                                                     OR DC.DUTY_CODE      = '13' -- 绕访(1171)
                                                     OR DC.DUTY_CODE      = '51' -- 绒老(1188)
                                                      ) THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DC.DUTY_CODE    =  '53' -- 绒老辟公(1187)
                                                   AND DI.ALL_NIGHT_YN = 'Y'  -- 枚具
                                                   AND DI.OPEN_TIME    IS NOT NULL
                                                   AND(SELECT S_DI.CLOSE_TIME
                                                         FROM HRD_DAY_INTERFACE_V     S_DI
                                                        WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                          AND S_DI.ORG_ID        =  DI.ORG_ID
                                                          AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                          AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                          AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                      ) IS NOT NULL THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME    IS NULL
                                                   AND DI.CLOSE_TIME   IS NOT NULL
                                                   AND(SELECT HDC.DUTY_CODE -- 绒老辟公
                                                         FROM HRD_DAY_INTERFACE_V     S_DI
                                                           , HRM_DUTY_CODE_V        HDC
                                                        WHERE S_DI.DUTY_ID       =  HDC.DUTY_ID
                                                          AND S_DI.SOB_ID        =  DI.SOB_ID
                                                          AND S_DI.ORG_ID        =  DI.ORG_ID
                                                          AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                          AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                          AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                      ) = '53' -- 绒老辟公(1187)
                                                   AND(SELECT S_DI.ALL_NIGHT_YN -- 枚具
                                                         FROM HRD_DAY_INTERFACE_V   S_DI
                                                        WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                          AND S_DI.ORG_ID        =  DI.ORG_ID
                                                          AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                          AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                          AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                      ) = 'Y' THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                   AND DI.CLOSE_TIME IS NOT NULL
                                                   AND((SELECT S_DI.HOLY_TYPE    -- 具埃
                                                          FROM HRD_DAY_INTERFACE   S_DI
                                                         WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                           AND S_DI.ORG_ID       = DI.ORG_ID
                                                           AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                           AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                           AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                       ) = '3'
                                                    OR (SELECT S_DI.ALL_NIGHT_YN -- 枚具
                                                          FROM HRD_DAY_INTERFACE_V S_DI
                                                         WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                           AND S_DI.ORG_ID       = DI.ORG_ID
                                                           AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                           AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                           AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                       ) = 'Y') THEN ''
                         ELSE HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', DI.APPROVE_STATUS, DI.SOB_ID, DI.ORG_ID)
                    END  AS APPROVE_STATUS_NAME
                  , DI.REJECT_REMARK
                  , DI.MODIFY_FLAG AS MODIFY_FLAG
                  , DI.TRANS_YN    AS TRANS_YN
                  , DI.NEXT_DAY_YN
                  , DI.DANGJIK_YN
                  , HRM_COMMON_G.ID_NAME_F(DI.LEAVE_ID) AS LEAVE_NAME
                  , HRM_COMMON_G.CODE_NAME_F('LEAVE_OUT_TIME', DI.LEAVE_TIME_CODE, DI.SOB_ID, DI.ORG_ID) AS LEAVE_TIME
                  , DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME1, DI.OPEN_TIME1) AS OPEN_TIME1
                  , NVL(O_DM.MODIFY_TIME1, DI.CLOSE_TIME1)                         AS CLOSE_TIME1   
                  , DI.PLAN_OPEN_TIME AS PL_OPEN_TIME
                  , DI.PLAN_CLOSE_TIME AS PL_CLOSE_TIME                    
               FROM HRD_DAY_INTERFACE_V DI
                  , HRM_DUTY_CODE_V     DC
                  , HRD_DAY_MODIFY      I_DM
                  , HRD_DAY_MODIFY      O_DM
                  , (-- 傈老 辟公 沥焊 炼雀.
                     SELECT WC.WORK_DATE + 1 AS WORK_DATE
                          , WC.PERSON_ID
                          , WC.CORP_ID
                          , WC.SOB_ID
                          , WC.ORG_ID
                          , WC.HOLY_TYPE
                          , WC.DANGJIK_YN
                          , WC.ALL_NIGHT_YN
                       FROM HRD_WORK_CALENDAR   WC
                      WHERE WC.SOB_ID         = W_SOB_ID
                        AND WC.ORG_ID         = W_ORG_ID
                        AND WC.WORK_DATE      BETWEEN W_WORK_DATE_FR - 1 AND W_WORK_DATE_TO
                        AND ((W_PERSON_ID     IS NULL AND 1 = 1)
                          OR (W_PERSON_ID     IS NOT NULL AND WC.PERSON_ID = W_PERSON_ID))
                    ) S_WC
              WHERE DI.DUTY_ID                = DC.DUTY_ID
                AND DI.PERSON_ID              = I_DM.PERSON_ID(+)
                AND DI.WORK_DATE              = I_DM.WORK_DATE(+)
                AND '1'                       = I_DM.IO_FLAG(+)
                AND DI.PERSON_ID              = O_DM.PERSON_ID(+)
                AND DI.WORK_DATE              = O_DM.WORK_DATE(+)
                AND '2'                       = O_DM.IO_FLAG(+)
                AND DI.WORK_DATE              = S_WC.WORK_DATE(+)
                AND DI.PERSON_ID              = S_WC.PERSON_ID(+)
                AND DI.SOB_ID                 = S_WC.SOB_ID(+)
                AND DI.ORG_ID                 = S_WC.ORG_ID(+)
                AND DI.WORK_DATE              BETWEEN W_WORK_DATE_FR AND W_WORK_DATE_TO
                AND ((W_PERSON_ID             IS NULL AND 1 = 1)
                  OR (W_PERSON_ID             IS NOT NULL AND DI.PERSON_ID = W_PERSON_ID))
                AND DI.WORK_CORP_ID           = W_WORK_CORP_ID
                AND DI.SOB_ID                 = W_SOB_ID
                AND DI.ORG_ID                 = W_ORG_ID
            ) T3
       WHERE OM.OT_TYPE_ID              = OTG.OT_TYPE_ID
         AND OM.PERSON_ID               = PM.PERSON_ID
         AND PM.PERSON_ID               = T1.PERSON_ID
         AND PM.PERSON_ID               = T2.PERSON_ID
         AND OM.WORK_DATE               = T3.WORK_DATE(+)
         AND OM.PERSON_ID               = T3.PERSON_ID(+)
         AND OM.SOB_ID                  = T3.SOB_ID(+)
         AND OM.ORG_ID                  = T3.ORG_ID(+)
         AND PM.WORK_CORP_ID            = W_WORK_CORP_ID
         AND ((W_CORP_ID                IS NULL AND 1 = 1)
           OR (W_CORP_ID                IS NOT NULL AND PM.CORP_ID = W_CORP_ID))
         AND OM.WORK_DATE               BETWEEN W_WORK_DATE_FR AND W_WORK_DATE_TO
         AND ((W_STATUS_FLAG            = 'A' AND 1 = 1)
           OR (W_STATUS_FLAG            != 'A' AND OM.STATUS_FLAG = W_STATUS_FLAG))
         AND PM.SOB_ID                  = W_SOB_ID
         AND PM.ORG_ID                  = W_ORG_ID
         AND ((W_PERSON_ID              IS NULL AND 1 = 1)
           OR (W_PERSON_ID              IS NOT NULL AND PM.PERSON_ID = W_PERSON_ID))
         AND PM.JOIN_DATE               <= W_WORK_DATE_TO
         AND (PM.RETIRE_DATE            >= W_WORK_DATE_FR OR PM.RETIRE_DATE IS NULL)
         AND ((W_ERROR_YN               = 'N' AND 1 = 1)
           OR (W_ERROR_YN               != 'N' 
             AND (((NVL(CASE
                         WHEN T3.CLOSE_TIME IS NULL THEN 0
                         WHEN T3.OPEN_TIME IS NULL THEN 0 
                         ELSE (HRD_DAY_LEAVE_G_SET.CLOSE_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.CLOSE_TIME) - 
                               CASE
                                 WHEN T3.HOLY_TYPE IN('0', '1') THEN 
                                   HRD_DAY_LEAVE_G_SET.OT_START_TIME_F( HRD_DAY_LEAVE_G_SET.OPEN_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.OPEN_TIME)
                                                                      , OM.WORK_DATE + 0.354166666666667  -- 08:30 --
                                                                      , OM.WORK_DATE + 0.354166666666667) -- 08:30 -- 
                                 WHEN T3.HOLY_TYPE IN('3') THEN 
                                   HRD_DAY_LEAVE_G_SET.OT_START_TIME_F( HRD_DAY_LEAVE_G_SET.OPEN_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.OPEN_TIME)
                                                                      , OM.WORK_DATE + 1.270833333333333
                                                                      , OM.WORK_DATE + 1.270833333333333) 
                                 ELSE
                                   HRD_DAY_LEAVE_G_SET.OT_START_TIME_F( HRD_DAY_LEAVE_G_SET.OPEN_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.OPEN_TIME)
                                                                      , OM.WORK_DATE + 0.75
                                                                      , OM.WORK_DATE + 0.75) 
                               END) * 24
                       END, 0) -
                   ( CASE
                       WHEN T3.HOLY_TYPE IN('2', '3') THEN 0
                       ELSE NVL(HRD_DAY_LEAVE_G_SET.FOOD_DED_TIME_F(T3.WORK_DATE
                                                                  , '2'
                                                                  , HRD_DAY_LEAVE_G_SET.OPEN_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.OPEN_TIME)
                                                                  , HRD_DAY_LEAVE_G_SET.CLOSE_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.CLOSE_TIME)
                                                                  , T1.JOB_CATEGORY_CODE
                                                                  , PM.SOB_ID
                                                                  , PM.ORG_ID), 0)
                     END +  
                     CASE
                       WHEN T3.HOLY_TYPE IN('2') THEN 0
                       ELSE NVL(HRD_DAY_LEAVE_G_SET.FOOD_DED_TIME_F(T3.WORK_DATE
                                                                  , '3'
                                                                  , HRD_DAY_LEAVE_G_SET.OPEN_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.OPEN_TIME)
                                                                  , HRD_DAY_LEAVE_G_SET.CLOSE_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.CLOSE_TIME)
                                                                  , T1.JOB_CATEGORY_CODE
                                                                  , PM.SOB_ID
                                                                  , PM.ORG_ID), 0)
                     END +                                      
                     CASE
                       WHEN T3.HOLY_TYPE IN('3') THEN 0
                       ELSE NVL(HRD_DAY_LEAVE_G_SET.FOOD_DED_TIME_F(T3.WORK_DATE + 1
                                                                  , '4'
                                                                  , HRD_DAY_LEAVE_G_SET.OPEN_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.OPEN_TIME)
                                                                  , HRD_DAY_LEAVE_G_SET.CLOSE_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.CLOSE_TIME)
                                                                  , T1.JOB_CATEGORY_CODE
                                                                  , PM.SOB_ID
                                                                  , PM.ORG_ID), 0)
                     END
                   )) < NVL(OTG.STD_OT_TIME, 0))
               OR (T3.HOLY_TYPE IN('2', '3') AND T3.PL_OPEN_TIME < T3.OPEN_TIME))))  
      ORDER BY OM.WORK_DATE
             , T1.JOB_CATEGORY_SORT_NUM
             , T1.DEPT_SORT_NUM
             , T2.FLOOR_SORT_NUM
             , T1.POST_SORT_NUM
             , PM.PERSON_NUM   
       ; */
  END SET_REAL_OT_TIME;
  
    
-- 包府流 儡诀 扁埃俊 蝶弗 笼拌 棺 鞭咯 馆康 --
  PROCEDURE CREATE_OT_AMOUNT
            ( W_WORK_CORP_ID         IN  NUMBER
            , W_WORK_DATE_FR         IN  DATE
						, W_WORK_DATE_TO         IN  DATE             
						, W_CORP_ID              IN  NUMBER
            , W_DEPT_ID              IN  NUMBER
            , W_FLOOR_ID             IN  NUMBER
						, W_PERSON_ID            IN  NUMBER
						, W_CONNECT_PERSON_ID    IN  NUMBER
						, W_SOB_ID               IN  NUMBER
						, W_ORG_ID               IN  NUMBER
            , O_STATUS               OUT VARCHAR2
            , O_MESSAGE              OUT VARCHAR2
            )
  AS
    V_SYSDATE           DATE := GET_LOCAL_DATE(W_SOB_ID);
  BEGIN
    O_STATUS := 'F';
    FOR C1 IN ( SELECT PM.PERSON_ID
                     , PM.PERSON_NUM
                     , PM.NAME
                     , PM.JOIN_DATE
                     , PM.RETIRE_DATE
                     , PM.SOB_ID
                     , PM.ORG_ID 
                     , T1.DEPT_CODE
                     , T1.DEPT_NAME
                     , T1.POST_CODE
                     , T1.POST_NAME
                     , T1.JOB_CATEGORY_NAME
                     , T2.FLOOR_NAME
                     , OM.WORK_DATE
                     , OM.OT_TYPE_ID
                     , OTG.OT_TYPE_CODE                    
                     , CASE T1.POST_CODE
                         WHEN '510' THEN OTG.POST_510
                         WHEN '430' THEN OTG.POST_430
                         WHEN '410' THEN OTG.POST_410
                         WHEN '330' THEN OTG.POST_330
                         WHEN '320' THEN OTG.POST_320
                         WHEN '310' THEN OTG.POST_310     
                       END AS OT_AMOUNT
                  FROM HRM_PERSON_MASTER PM
                     , HRD_OT_MANAGER    OM
                     , HRM_OT_TYPE_GW_V  OTG
                     , (-- 矫痢 牢荤郴开.
                       SELECT HL.PERSON_ID
                            , HL.DEPT_ID
                            , DM.DEPT_CODE
                            , DM.DEPT_NAME
                            , DM.DEPT_SORT_NUM
                            , PC.POST_CODE                  
                            , PC.POST_NAME AS POST_NAME
                            , PC.SORT_NUM AS POST_SORT_NUM
                            , JC.JOB_CATEGORY_CODE
                            , JC.JOB_CATEGORY_NAME
                            , JC.SORT_NUM AS JOB_CATEGORY_SORT_NUM
                         FROM HRM_HISTORY_HEADER HH
                            , HRM_HISTORY_LINE   HL
                            , HRM_DEPT_MASTER    DM
                            , HRM_POST_CODE_V    PC
                            , HRM_JOB_CATEGORY_CODE_V JC
                       WHERE HH.HISTORY_HEADER_ID = HL.HISTORY_HEADER_ID
                         AND HL.DEPT_ID           = DM.DEPT_ID
                         AND HL.POST_ID           = PC.POST_ID
                         AND HL.JOB_CATEGORY_ID   = JC.JOB_CATEGORY_ID
                         AND HH.SOB_ID            = W_SOB_ID
                         AND HH.ORG_ID            = W_ORG_ID                                
                         AND HL.HISTORY_LINE_ID  
                               IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                      FROM HRM_HISTORY_LINE S_HL
                                    WHERE S_HL.CHARGE_DATE            <= W_WORK_DATE_TO
                                      AND S_HL.PERSON_ID              = HL.PERSON_ID
                                    GROUP BY S_HL.PERSON_ID
                                  )
                      ) T1
                    , (-- 矫痢 牢荤郴开.
                        SELECT PH.PERSON_ID
                             , PH.FLOOR_ID
                             , HF.FLOOR_CODE
                             , HF.FLOOR_NAME
                             , HF.SORT_NUM AS FLOOR_SORT_NUM
                          FROM HRD_PERSON_HISTORY        PH
                             , HRM_FLOOR_V               HF
                        WHERE PH.FLOOR_ID           = HF.FLOOR_ID
                          AND PH.SOB_ID             = W_SOB_ID
                          AND PH.ORG_ID             = W_ORG_ID
                          
                          AND PH.EFFECTIVE_DATE_FR  <= W_WORK_DATE_TO
                          AND PH.EFFECTIVE_DATE_TO  >= W_WORK_DATE_TO
                      ) T2
                 WHERE PM.PERSON_ID               = OM.PERSON_ID
                   AND OM.OT_TYPE_ID              = OTG.OT_TYPE_ID
                   AND PM.PERSON_ID               = T1.PERSON_ID
                   AND PM.PERSON_ID               = T2.PERSON_ID
                   AND PM.WORK_CORP_ID            = W_WORK_CORP_ID
                   AND ((W_CORP_ID                IS NULL AND 1 = 1)
                     OR (W_CORP_ID                IS NOT NULL AND PM.CORP_ID = W_CORP_ID))
                   AND OM.WORK_DATE               BETWEEN W_WORK_DATE_FR AND W_WORK_DATE_TO
                   AND OM.SOB_ID                  = W_SOB_ID
                   AND OM.ORG_ID                  = W_ORG_ID
                   AND PM.JOIN_DATE               <= OM.WORK_DATE
                   AND (PM.RETIRE_DATE            >= OM.WORK_DATE OR PM.RETIRE_DATE IS NULL)
                   AND ((W_DEPT_ID                IS NULL AND 1 = 1)
                     OR (W_DEPT_ID                IS NOT NULL AND T1.DEPT_ID = W_DEPT_ID))  
                   AND ((W_FLOOR_ID               IS NULL AND 1 = 1)
                     OR (W_FLOOR_ID               IS NOT NULL AND T2.FLOOR_ID = W_FLOOR_ID))
                   AND OM.CONFIRMED_YN            = 'Y'   -- 犬沥 铰牢磊 -- 
                   AND OM.TRANSFER_YN             != 'Y'  -- 鞭咯 固傈价磊 --
                )
    LOOP
      BEGIN
        UPDATE HRD_OT_MANAGER OM
           SET OM.OT_AMOUNT             = NVL(C1.OT_AMOUNT, 0)
             , OM.AMT_CREATE_DATE       = V_SYSDATE
             , OM.AMT_CREATE_PERSON_ID  = W_CONNECT_PERSON_ID
         WHERE OM.WORK_DATE             = C1.WORK_DATE
           AND OM.PERSON_ID             = C1.PERSON_ID
           AND OM.SOB_ID                = C1.SOB_ID
           AND OM.ORG_ID                = C1.ORG_ID
           AND OM.OT_TYPE_ID            = C1.OT_TYPE_ID
        ;             
      EXCEPTION WHEN OTHERS THEN
        O_STATUS := 'F';
        O_MESSAGE := 'O/T Amount Update Error : ' || SUBSTR(SQLERRM, 1, 150);
        RETURN;
      END;  
    END LOOP C1;    
    O_STATUS := 'S';    
  END CREATE_OT_AMOUNT;
  
-- 包府流 儡诀 扁埃俊 蝶弗 笼拌 棺 鞭咯 馆康 --
  PROCEDURE TRANSFER_SALARY_OT_AMOUNT
            ( W_WORK_DATE_FR          IN  DATE
						, W_WORK_DATE_TO          IN  DATE             
						, W_PERSON_ID             IN  NUMBER
            , P_SELECT_YN             IN  VARCHAR2
            , P_STATUS_FLAG           IN  VARCHAR2
            , P_EVENT_STATUS          IN  VARCHAR2
						, W_PAY_YYYYMM            IN  VARCHAR2
            , W_WAGE_TYPE             IN  VARCHAR2
            , W_USER_ID               IN  NUMBER
            , W_CONNECT_PERSON_ID     IN  NUMBER
						, W_SOB_ID                IN  NUMBER
						, W_ORG_ID                IN  NUMBER
            , O_STATUS                OUT VARCHAR2
            , O_MESSAGE               OUT VARCHAR2
            )
  AS
    V_SYSDATE           DATE := GET_LOCAL_DATE(W_SOB_ID);
    
    V_ALLOWANCE_ID      NUMBER;
    V_ADD_ALLOWANCE_ID  NUMBER;
  BEGIN
    O_STATUS := 'F';
    IF P_SELECT_YN != 'Y' THEN
      O_STATUS := 'S';
      O_MESSAGE := P_SELECT_YN || TO_CHAR(W_WORK_DATE_FR, 'YYYY-MM-DD') || '~' || TO_CHAR(W_WORK_DATE_FR, 'YYYY-MM-DD') || 
                   '-' || TO_CHAR(W_PERSON_ID);
      RETURN;  
    END IF;
                 
    IF P_EVENT_STATUS = 'C_OK' THEN
      -- 鞭咯傈价 --
      IF P_STATUS_FLAG != 'C' THEN
        O_STATUS := 'F';
        O_MESSAGE := '鞭咯傈价 磊丰绰 犬沥铰牢等 磊丰父 啊瓷钦聪促. 犬牢窍技夸';
        RETURN;  
      END IF;      
      
      FOR C1 IN ( SELECT PM.PERSON_ID
                       , PM.PERSON_NUM
                       , PM.NAME
                       , PM.CORP_ID
                       , PM.JOIN_DATE
                       , PM.RETIRE_DATE
                       , PM.SOB_ID
                       , PM.ORG_ID
                       , T1.DEPT_NAME
                       , T1.POST_NAME
                       , T1.JOB_CATEGORY_NAME
                       , T2.FLOOR_NAME
                       , SUM(OM.OT_AMOUNT) AS OT_AMOUNT   
                       , OTG.ALLOWANCE_CODE  
                       , W_PAY_YYYYMM AS PAY_YYYYMM
                       , W_WAGE_TYPE AS WAGE_TYPE                        
                    FROM HRM_PERSON_MASTER PM
                       , HRD_OT_MANAGER    OM
                       , HRM_OT_TYPE_GW_V  OTG
                       , (-- 矫痢 牢荤郴开.
                         SELECT HL.PERSON_ID
                              , HL.DEPT_ID
                              , DM.DEPT_CODE
                              , DM.DEPT_NAME
                              , DM.DEPT_SORT_NUM
                              , PC.POST_CODE                  
                              , PC.POST_NAME AS POST_NAME
                              , PC.SORT_NUM AS POST_SORT_NUM
                              , JC.JOB_CATEGORY_CODE
                              , JC.JOB_CATEGORY_NAME
                              , JC.SORT_NUM AS JOB_CATEGORY_SORT_NUM
                           FROM HRM_HISTORY_HEADER HH
                              , HRM_HISTORY_LINE   HL
                              , HRM_DEPT_MASTER    DM
                              , HRM_POST_CODE_V    PC
                              , HRM_JOB_CATEGORY_CODE_V JC
                         WHERE HH.HISTORY_HEADER_ID = HL.HISTORY_HEADER_ID
                           AND HL.DEPT_ID           = DM.DEPT_ID
                           AND HL.POST_ID           = PC.POST_ID
                           AND HL.JOB_CATEGORY_ID   = JC.JOB_CATEGORY_ID
                           AND HH.SOB_ID            = W_SOB_ID
                           AND HH.ORG_ID            = W_ORG_ID         
                           AND HL.HISTORY_LINE_ID  
                                 IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                        FROM HRM_HISTORY_LINE S_HL
                                      WHERE S_HL.CHARGE_DATE            <= W_WORK_DATE_TO
                                        AND S_HL.PERSON_ID              = HL.PERSON_ID
                                      GROUP BY S_HL.PERSON_ID
                                    )
                        ) T1
                      , (-- 矫痢 牢荤郴开.
                          SELECT PH.PERSON_ID
                               , PH.FLOOR_ID
                               , HF.FLOOR_CODE
                               , HF.FLOOR_NAME
                               , HF.SORT_NUM AS FLOOR_SORT_NUM
                            FROM HRD_PERSON_HISTORY        PH
                               , HRM_FLOOR_V               HF
                          WHERE PH.FLOOR_ID           = HF.FLOOR_ID
                            AND PH.SOB_ID             = W_SOB_ID 
                            AND PH.ORG_ID             = W_ORG_ID         
                            AND PH.EFFECTIVE_DATE_FR  <= W_WORK_DATE_TO
                            AND PH.EFFECTIVE_DATE_TO  >= W_WORK_DATE_TO
                        ) T2
                   WHERE PM.PERSON_ID               = OM.PERSON_ID
                     AND OM.OT_TYPE_ID              = OTG.OT_TYPE_ID
                     AND PM.PERSON_ID               = T1.PERSON_ID
                     AND PM.PERSON_ID               = T2.PERSON_ID
                     AND PM.PERSON_ID               = W_PERSON_ID
                     AND OM.WORK_DATE               BETWEEN W_WORK_DATE_FR AND W_WORK_DATE_TO   
                     AND OM.SOB_ID                  = W_SOB_ID
                     AND OM.ORG_ID                  = W_ORG_ID
                     AND PM.JOIN_DATE               <= OM.WORK_DATE
                     AND (PM.RETIRE_DATE            >= OM.WORK_DATE OR PM.RETIRE_DATE IS NULL)
                     AND OM.CONFIRMED_YN            = 'Y'
                     AND OM.TRANSFER_YN             != 'Y'
                  GROUP BY PM.PERSON_ID
                         , PM.PERSON_NUM
                         , PM.NAME
                         , PM.CORP_ID
                         , PM.JOIN_DATE
                         , PM.RETIRE_DATE
                         , PM.SOB_ID
                         , PM.ORG_ID
                         , T1.DEPT_NAME
                         , T1.POST_NAME
                         , T1.JOB_CATEGORY_NAME
                         , T2.FLOOR_NAME
                         , OTG.ALLOWANCE_CODE    
                         , T2.FLOOR_SORT_NUM
                         , T1.POST_SORT_NUM
                  ORDER BY T2.FLOOR_SORT_NUM
                         , T1.POST_SORT_NUM       
                 )
      LOOP
        -- 鞭惑咯 付皑咯何 眉农 -- 
        O_STATUS := HRM_CLOSING_G.CLOSING_CHECK_W(  W_CORP_ID        => C1.CORP_ID
                                                  , W_CLOSING_YYYYMM => C1.PAY_YYYYMM
                                                  , W_CLOSING_TYPE   => C1.WAGE_TYPE
                                                  , W_SOB_ID         => C1.SOB_ID
                                                  , W_ORG_ID         => C1.ORG_ID
                                                  );
        IF O_STATUS = 'F' THEN
          O_STATUS := 'F';
          O_MESSAGE := EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10078', '&&VALUE:=Salary');
          RETURN;
        ELSIF O_STATUS = 'Y' THEN
          O_STATUS := 'F';
          O_MESSAGE := EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10052');
          RETURN;
        END IF;
        
        -- 瘤鞭亲格 ID 眉农 -- 
        BEGIN
          SELECT HA.ALLOWANCE_ID
            INTO V_ALLOWANCE_ID
            FROM HRM_ALLOWANCE_V HA
           WHERE HA.ALLOWANCE_CODE      = C1.ALLOWANCE_CODE
             AND HA.SOB_ID              = C1.SOB_ID
             AND HA.ORG_ID              = C1.ORG_ID
             AND HA.ENABLED_FLAG        = 'Y'
             AND HA.EFFECTIVE_DATE_FR   <= W_WORK_DATE_TO
             AND (HA.EFFECTIVE_DATE_TO  >= W_WORK_DATE_FR OR HA.EFFECTIVE_DATE_TO IS NULL)
          ;
        EXCEPTION WHEN OTHERS THEN
          O_STATUS := 'F';
          O_MESSAGE := 'Person No : ' || C1.NAME || '(' || C1.PERSON_NUM || ') Allowance ID is not found. Check Allowance Code';
          RETURN; 
        END;
        
        IF NVL(C1.OT_AMOUNT, 0) != 0 THEN
          HRP_PAYMENT_ADD_ALLOWANCE_G.ADD_ALLOWANCE_INSERT
            ( P_ADD_ALLOWANCE_ID => V_ADD_ALLOWANCE_ID
            , P_PERSON_ID        => C1.PERSON_ID
            , P_CORP_ID          => C1.CORP_ID
            , P_PAY_YYYYMM       => W_PAY_YYYYMM
            , P_WAGE_TYPE        => W_WAGE_TYPE
            , P_ALLOWANCE_ID     => V_ALLOWANCE_ID
            , P_ALLOWANCE_AMOUNT => NVL(C1.OT_AMOUNT, 0)
            , P_TAX_YN           => 'Y'
            , P_HIRE_INSUR_YN    => 'Y'
            , P_CREATED_FLAG     => 'I'
            , P_DESCRIPTION      => NULL
            , P_SOB_ID           => C1.SOB_ID
            , P_ORG_ID           => C1.ORG_ID
            , P_USER_ID          => W_USER_ID 
            );
            
          BEGIN
            UPDATE HRD_OT_MANAGER   OM
               SET OM.STATUS_FLAG         = 'I'
                 , OM.TRANSFER_YN         = 'Y'
                 , OM.TRANSFER_DATE       = V_SYSDATE
                 , OM.TRANSFER_PERSON_ID  = W_CONNECT_PERSON_ID           
                 , OM.PAY_YYYYMM          = W_PAY_YYYYMM
                 , OM.WAGE_TYPE           = W_WAGE_TYPE
                 , OM.ADD_ALLOWANCE_ID    = V_ADD_ALLOWANCE_ID    
             WHERE OM.WORK_DATE     BETWEEN W_WORK_DATE_FR AND W_WORK_DATE_TO
               AND OM.PERSON_ID     = C1.PERSON_ID
               AND OM.SOB_ID        = C1.SOB_ID
               AND OM.ORG_ID        = C1.ORG_ID
               AND OM.CONFIRMED_YN  = 'Y'
               AND OM.TRANSFER_YN   != 'Y'
            ;    
          EXCEPTION WHEN OTHERS THEN
            O_STATUS := 'F';
            O_MESSAGE := 'Person No : ' || C1.NAME || '(' || C1.PERSON_NUM || ')transfer flag update error';
            RETURN; 
          END;  
        END IF;  
      END LOOP C1; 
    ELSIF P_EVENT_STATUS = 'I_CANCEL' THEN
      -- 鞭咯傈价 秒家 --
      IF P_STATUS_FLAG != 'I' THEN
        O_STATUS := 'F';
        O_MESSAGE := '鞭咯傈价 磊丰绰 秒家绰 鞭咯傈价等 磊丰父 啊瓷钦聪促. 犬牢窍技夸';
        RETURN;  
      END IF;
            
      FOR C1 IN ( SELECT DISTINCT 
                         PM.PERSON_ID
                       , PM.PERSON_NUM
                       , PM.NAME
                       , PM.CORP_ID
                       , PM.SOB_ID
                       , PM.ORG_ID
                       , OM.ADD_ALLOWANCE_ID
                       , OM.PAY_YYYYMM
                       , OM.WAGE_TYPE                       
                    FROM HRM_PERSON_MASTER PM
                       , HRD_OT_MANAGER    OM
                       , HRM_OT_TYPE_GW_V  OTG
                   WHERE PM.PERSON_ID               = OM.PERSON_ID
                     AND OM.OT_TYPE_ID              = OTG.OT_TYPE_ID
                     AND PM.PERSON_ID               = W_PERSON_ID
                     AND OM.WORK_DATE               BETWEEN W_WORK_DATE_FR AND W_WORK_DATE_TO   
                     AND OM.SOB_ID                  = W_SOB_ID
                     AND OM.ORG_ID                  = W_ORG_ID
                     AND PM.JOIN_DATE               <= OM.WORK_DATE
                     AND (PM.RETIRE_DATE            >= OM.WORK_DATE OR PM.RETIRE_DATE IS NULL)
                     AND OM.TRANSFER_YN             = 'Y'  
                 )
      LOOP
        -- 鞭惑咯 付皑咯何 眉农 -- 
        O_STATUS := HRM_CLOSING_G.CLOSING_CHECK_W(  W_CORP_ID        => C1.CORP_ID
                                                  , W_CLOSING_YYYYMM => C1.PAY_YYYYMM
                                                  , W_CLOSING_TYPE   => C1.WAGE_TYPE
                                                  , W_SOB_ID         => C1.SOB_ID
                                                  , W_ORG_ID         => C1.ORG_ID
                                                  );
        IF O_STATUS = 'F' THEN
          O_STATUS := 'F';
          O_MESSAGE := EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10078', '&&VALUE:=Salary');
          RETURN;
        ELSIF O_STATUS = 'Y' THEN
          O_STATUS := 'F';
          O_MESSAGE := EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10052');
          RETURN;
        END IF;
        
        HRP_PAYMENT_ADD_ALLOWANCE_G.ADD_ALLOWANCE_DELETE
          ( W_ADD_ALLOWANCE_ID => C1.ADD_ALLOWANCE_ID
          );
            
        BEGIN
          UPDATE HRD_OT_MANAGER   OM
             SET OM.STATUS_FLAG         = 'C'
               , OM.TRANSFER_YN         = 'N'
               , OM.TRANSFER_DATE       = V_SYSDATE
               , OM.TRANSFER_PERSON_ID  = W_CONNECT_PERSON_ID           
               , OM.PAY_YYYYMM          = NULL
               , OM.WAGE_TYPE           = NULL
               , OM.ADD_ALLOWANCE_ID    = NULL    
           WHERE OM.WORK_DATE     BETWEEN W_WORK_DATE_FR AND W_WORK_DATE_TO
             AND OM.PERSON_ID     = C1.PERSON_ID
             AND OM.SOB_ID        = C1.SOB_ID
             AND OM.ORG_ID        = C1.ORG_ID
             AND OM.TRANSFER_YN   = 'Y'
          ;    
        EXCEPTION WHEN OTHERS THEN
          O_STATUS := 'F';
          O_MESSAGE := 'Person No : ' || C1.NAME || '(' || C1.PERSON_NUM || ')transfer cancel flag update error';
          RETURN; 
        END;  
      END LOOP C1; 
    ELSE
      O_STATUS := 'F';
      O_MESSAGE := 'Not Found Event Status Flag. Please Select Status Flag'; 
      RETURN; 
    END IF;
    O_STATUS := 'S'; 
  END TRANSFER_SALARY_OT_AMOUNT;
    
-- 包府流 儡诀 : 陛咀 固魂免 单捞磐 眉农 --
  PROCEDURE NO_CREATE_OT_AMOUNT_P
            ( W_WORK_CORP_ID         IN  NUMBER
            , W_WORK_DATE_FR         IN  DATE
						, W_WORK_DATE_TO         IN  DATE             
						, W_CORP_ID              IN  NUMBER
            , W_DEPT_ID              IN  NUMBER
            , W_FLOOR_ID             IN  NUMBER
						, W_PERSON_ID            IN  NUMBER
						, W_SOB_ID               IN  NUMBER
						, W_ORG_ID               IN  NUMBER
            , O_STATUS               OUT VARCHAR2
            , O_MESSAGE              OUT VARCHAR2
            )
  AS
    V_RECORD_COUNT      NUMBER;
  BEGIN
    O_STATUS := 'F';
    V_RECORD_COUNT := 0;
    BEGIN
      SELECT COUNT(OM.PERSON_ID) AS COUNT
        INTO V_RECORD_COUNT
        FROM HRM_PERSON_MASTER PM
           , HRD_OT_MANAGER    OM
           , HRM_OT_TYPE_GW_V  OTG
           , (-- 矫痢 牢荤郴开.
             SELECT HL.PERSON_ID
                  , HL.DEPT_ID
                  , DM.DEPT_CODE
                  , DM.DEPT_NAME
                  , DM.DEPT_SORT_NUM
                  , PC.POST_CODE                  
                  , PC.POST_NAME AS POST_NAME
                  , PC.SORT_NUM AS POST_SORT_NUM
                  , JC.JOB_CATEGORY_CODE
                  , JC.JOB_CATEGORY_NAME
                  , JC.SORT_NUM AS JOB_CATEGORY_SORT_NUM
               FROM HRM_HISTORY_HEADER HH
                  , HRM_HISTORY_LINE   HL
                  , HRM_DEPT_MASTER    DM
                  , HRM_POST_CODE_V    PC
                  , HRM_JOB_CATEGORY_CODE_V JC
             WHERE HH.HISTORY_HEADER_ID = HL.HISTORY_HEADER_ID
               AND HL.DEPT_ID           = DM.DEPT_ID
               AND HL.POST_ID           = PC.POST_ID
               AND HL.JOB_CATEGORY_ID   = JC.JOB_CATEGORY_ID
               AND HH.SOB_ID            = W_SOB_ID
               AND HH.ORG_ID            = W_ORG_ID
               AND HL.HISTORY_LINE_ID  
                     IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                            FROM HRM_HISTORY_LINE S_HL
                          WHERE S_HL.CHARGE_DATE            <= W_WORK_DATE_TO
                            AND S_HL.PERSON_ID              = HL.PERSON_ID
                          GROUP BY S_HL.PERSON_ID
                        )
            ) T1
          , (-- 矫痢 牢荤郴开.
              SELECT PH.PERSON_ID
                   , PH.FLOOR_ID
                   , HF.FLOOR_CODE
                   , HF.FLOOR_NAME
                   , HF.SORT_NUM AS FLOOR_SORT_NUM
                FROM HRD_PERSON_HISTORY        PH
                   , HRM_FLOOR_V               HF
              WHERE PH.FLOOR_ID           = HF.FLOOR_ID
                AND PH.SOB_ID             = W_SOB_ID
                AND PH.ORG_ID             = W_ORG_ID
                AND PH.EFFECTIVE_DATE_FR  <= W_WORK_DATE_TO
                AND PH.EFFECTIVE_DATE_TO  >= W_WORK_DATE_TO
            ) T2
       WHERE PM.PERSON_ID               = OM.PERSON_ID
         AND OM.OT_TYPE_ID              = OTG.OT_TYPE_ID
         AND PM.PERSON_ID               = T1.PERSON_ID
         AND PM.PERSON_ID               = T2.PERSON_ID
         AND PM.WORK_CORP_ID            = W_WORK_CORP_ID
         AND ((W_PERSON_ID              IS NULL AND 1 = 1)
           OR (W_PERSON_ID              IS NOT NULL AND PM.PERSON_ID = W_PERSON_ID))
         AND ((W_CORP_ID                IS NULL AND 1 = 1)
           OR (W_CORP_ID                IS NOT NULL AND PM.CORP_ID = W_CORP_ID))
         AND OM.WORK_DATE               BETWEEN W_WORK_DATE_FR AND W_WORK_DATE_TO   
         AND OM.SOB_ID                  = W_SOB_ID
         AND OM.ORG_ID                  = W_ORG_ID
         AND PM.JOIN_DATE               <= OM.WORK_DATE
         AND (PM.RETIRE_DATE            >= OM.WORK_DATE OR PM.RETIRE_DATE IS NULL)
         AND ((W_DEPT_ID                IS NULL AND 1 = 1)
           OR (W_DEPT_ID                IS NOT NULL AND T1.DEPT_ID = W_DEPT_ID))      
         AND ((W_FLOOR_ID               IS NULL AND 1 = 1)
           OR (W_FLOOR_ID               IS NOT NULL AND T2.FLOOR_ID = W_FLOOR_ID))   
         AND OM.CONFIRMED_YN            = 'Y'  -- 犬沥
         AND (OM.OT_AMOUNT              = 0    -- 陛咀 0 肚绰 NULL => 陛咀 魂免 救窃 --
           OR OM.OT_AMOUNT              IS NULL)   
      ;  
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT < 1 THEN
      O_STATUS := 'S';
    ELSE
      O_STATUS := 'F';
      O_MESSAGE := 'Not create O/T Amount';      
    END IF;    
  END NO_CREATE_OT_AMOUNT_P;
  
    
-- 包府流 儡诀 脚没 荤盔 炼雀  -- 
  PROCEDURE LU_SELECT_PERSON
            ( P_CURSOR3              OUT TYPES.TCURSOR3
            , W_WORK_CORP_ID         IN  NUMBER
            , W_WORK_DATE            IN  DATE
            , W_SOB_ID               IN  NUMBER
						, W_ORG_ID               IN  NUMBER
						)
  AS
  BEGIN
    OPEN P_CURSOR3 FOR
      SELECT PM.PERSON_ID
           , PM.PERSON_NUM
           , PM.NAME
           , T1.DEPT_NAME
           , T2.FLOOR_NAME
           , T1.POST_NAME
           , T3.DUTY_NAME
           , T3.HOLY_TYPE_NAME
           , T3.OPEN_TIME
           , T3.CLOSE_TIME
           , /*
             NVL(CASE
                   WHEN T3.CLOSE_TIME IS NULL THEN 0
                   WHEN T3.OPEN_TIME IS NULL THEN 0 
                   WHEN HRD_DAY_LEAVE_G_SET.CLOSE_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.CLOSE_TIME) <=
                         CASE
                           WHEN T3.HOLY_TYPE IN('0', '1') THEN 
                             HRD_DAY_LEAVE_G_SET.OT_START_TIME_F( HRD_DAY_LEAVE_G_SET.OPEN_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.OPEN_TIME)
                                                                , T3.WORK_DATE + 0.354166666666667  -- 08:30 --
                                                                , T3.WORK_DATE + 0.354166666666667) -- 08:30 -- 
                           WHEN T3.HOLY_TYPE IN('3') THEN 
                             HRD_DAY_LEAVE_G_SET.OT_START_TIME_F( HRD_DAY_LEAVE_G_SET.OPEN_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.OPEN_TIME)
                                                                , T3.WORK_DATE + 1.270833333333333  -- +1 06:30 --
                                                                , T3.WORK_DATE + 1.270833333333333) 
                           WHEN T3.HOLY_TYPE IN('2') THEN 
                             HRD_DAY_LEAVE_G_SET.OT_START_TIME_F( HRD_DAY_LEAVE_G_SET.OPEN_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.OPEN_TIME)
                                                                , T3.WORK_DATE + 0.75  -- 18:00 --
                                                                , T3.WORK_DATE + 0.75)
                           ELSE
                             HRD_DAY_LEAVE_G_SET.CLOSE_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.CLOSE_TIME) 
                         END THEN 0
                   ELSE (HRD_DAY_LEAVE_G_SET.CLOSE_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.CLOSE_TIME) - 
                         CASE
                           WHEN T3.HOLY_TYPE IN('0', '1') THEN 
                             HRD_DAY_LEAVE_G_SET.OT_START_TIME_F( HRD_DAY_LEAVE_G_SET.OPEN_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.OPEN_TIME)
                                                                , T3.WORK_DATE + 0.354166666666667  -- 08:30 --
                                                                , T3.WORK_DATE + 0.354166666666667) -- 08:30 -- 
                           WHEN T3.HOLY_TYPE IN('3') THEN 
                             HRD_DAY_LEAVE_G_SET.OT_START_TIME_F( HRD_DAY_LEAVE_G_SET.OPEN_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.OPEN_TIME)
                                                                , T3.WORK_DATE + 1.270833333333333  -- +1 06:30 --
                                                                , T3.WORK_DATE + 1.270833333333333) 
                           WHEN T3.HOLY_TYPE IN('2') THEN 
                             HRD_DAY_LEAVE_G_SET.OT_START_TIME_F( HRD_DAY_LEAVE_G_SET.OPEN_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.OPEN_TIME)
                                                                , T3.WORK_DATE + 0.75  -- 18:00 --
                                                                , T3.WORK_DATE + 0.75)
                           ELSE
                             HRD_DAY_LEAVE_G_SET.CLOSE_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.CLOSE_TIME) 
                         END) * 24
                 END, 0) - 
             ( CASE
                 WHEN T3.HOLY_TYPE IN('2', '3') THEN 0
                 ELSE NVL(HRD_DAY_LEAVE_G_SET.FOOD_DED_TIME_F(T3.WORK_DATE
                                                            , '2'
                                                            , HRD_DAY_LEAVE_G_SET.OPEN_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.OPEN_TIME)
                                                            , HRD_DAY_LEAVE_G_SET.CLOSE_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.CLOSE_TIME)
                                                            , T1.JOB_CATEGORY_CODE
                                                            , PM.SOB_ID
                                                            , PM.ORG_ID), 0)
               END +  
               CASE
                 WHEN T3.HOLY_TYPE IN('2') THEN 0
                 ELSE NVL(HRD_DAY_LEAVE_G_SET.FOOD_DED_TIME_F(T3.WORK_DATE
                                                            , '3'
                                                            , HRD_DAY_LEAVE_G_SET.OPEN_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.OPEN_TIME)
                                                            , HRD_DAY_LEAVE_G_SET.CLOSE_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.CLOSE_TIME)
                                                            , T1.JOB_CATEGORY_CODE
                                                            , PM.SOB_ID
                                                            , PM.ORG_ID), 0)
               END +                                      
               CASE
                 WHEN T3.HOLY_TYPE IN('3') THEN 0
                 ELSE NVL(HRD_DAY_LEAVE_G_SET.FOOD_DED_TIME_F(T3.WORK_DATE + 1
                                                            , '4'
                                                            , HRD_DAY_LEAVE_G_SET.OPEN_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.OPEN_TIME)
                                                            , HRD_DAY_LEAVE_G_SET.CLOSE_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.CLOSE_TIME)
                                                            , T1.JOB_CATEGORY_CODE
                                                            , PM.SOB_ID
                                                            , PM.ORG_ID), 0)
               END
             )*/ 0 AS REAL_OT_TIME   
           , T1.JOB_CATEGORY_CODE
           , T3.DUTY_ID
           , T3.DUTY_CODE 
           , T3.HOLY_TYPE        
        FROM HRM_PERSON_MASTER PM
           , (-- 矫痢 牢荤郴开.
             SELECT HL.PERSON_ID
                  , HL.DEPT_ID
                  , DM.DEPT_CODE
                  , DM.DEPT_NAME
                  , DM.DEPT_SORT_NUM
                  , PC.POST_CODE                  
                  , PC.POST_NAME AS POST_NAME
                  , PC.SORT_NUM AS POST_SORT_NUM
                  , JC.JOB_CATEGORY_CODE
                  , JC.JOB_CATEGORY_NAME
                  , JC.SORT_NUM AS JOB_CATEGORY_SORT_NUM
               FROM HRM_HISTORY_HEADER HH
                  , HRM_HISTORY_LINE   HL
                  , HRM_DEPT_MASTER    DM
                  , HRM_POST_CODE_V    PC
                  , HRM_JOB_CATEGORY_CODE_V JC
             WHERE HH.HISTORY_HEADER_ID = HL.HISTORY_HEADER_ID
               AND HL.DEPT_ID           = DM.DEPT_ID
               AND HL.POST_ID           = PC.POST_ID
               AND HL.JOB_CATEGORY_ID   = JC.JOB_CATEGORY_ID               
               AND HL.HISTORY_LINE_ID  
                     IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                            FROM HRM_HISTORY_HEADER S_HH
                               , HRM_HISTORY_LINE   S_HL
                          WHERE S_HH.HISTORY_HEADER_ID  = S_HL.HISTORY_HEADER_ID
                            AND S_HH.CHARGE_DATE        <= W_WORK_DATE
                            AND S_HL.PERSON_ID          = HL.PERSON_ID
                          GROUP BY S_HL.PERSON_ID
                        )
            ) T1
          , (-- 矫痢 牢荤郴开.
              SELECT PH.PERSON_ID
                   , PH.FLOOR_ID
                   , PH.SOB_ID
                   , PH.ORG_ID
                   , HF.FLOOR_CODE
                   , HF.FLOOR_NAME
                   , HF.SORT_NUM AS FLOOR_SORT_NUM
                FROM HRD_PERSON_HISTORY        PH
                   , HRM_FLOOR_V               HF
              WHERE PH.FLOOR_ID           = HF.FLOOR_ID
                AND PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE
                AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE
            ) T2
          , (SELECT DI.WORK_DATE
                  , DI.PERSON_ID
                  , DI.SOB_ID
                  , DI.ORG_ID
                  , DI.DUTY_ID
                  , DC.DUTY_CODE
                  , HRM_COMMON_G.ID_NAME_F(DI.DUTY_ID) AS DUTY_NAME
                  , DI.HOLY_TYPE
                  , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DI.HOLY_TYPE, DI.SOB_ID, DI.ORG_ID) AS HOLY_TYPE_NAME
                  , SUBSTR(TO_CHAR(DI.WORK_DATE, 'DAY', 'NLS_DATE_LANGUAGE=KOREAN'), 1, 1)    AS W
                  , DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) AS OPEN_TIME
                  , CASE
                         -- 饶老 硼辟扁废 佬绢坷扁(窜, 荐沥荤亲捞 乐栏搁 荐沥荤亲 馆康).
                         WHEN (DI.NEXT_DAY_YN   = 'Y'
                            OR DI.HOLY_TYPE    IN('N', '3')
                            OR DI.DANGJIK_YN    = 'Y'
                            OR DI.ALL_NIGHT_YN  = 'Y') THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, (SELECT S_DI.CLOSE_TIME
                                                                                                               FROM HRD_DAY_INTERFACE_V S_DI
                                                                                                              WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                                                                AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                                                                AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                                                                AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                                                                AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                                                                            ))
                         WHEN DI.HOLY_TYPE IN ('0', '1') 
                             AND DC.DUTY_CODE = '53' -- 绒老辟公(1187)
                             AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) >
                                   TO_DATE(TO_CHAR(DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME), 'YYYY-MM-DD') || ' ' || '17:30:00', 'YYYY-MM-DD HH24:MI:SS')
                                THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, (SELECT S_DI.CLOSE_TIME
                                                                                        FROM HRD_DAY_INTERFACE_V     S_DI
                                                                                       WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                                         AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                                         AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                                         AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                                         AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                                                     ))
                         WHEN S_WC.HOLY_TYPE = '3' -- 具埃
                            AND(DC.DUTY_CODE      = '19' -- 版炼绒啊(1174)
                             OR DC.DUTY_CODE      = '12' -- 背腊(1170)
                             OR DC.DUTY_CODE      = '20' -- 斥瞒(1175)
                             OR DC.DUTY_CODE      = '54' -- 公鞭绒啊(1189)
                             OR DC.DUTY_CODE      = '52' -- 公鞭绒老(1182)
                             OR DC.DUTY_CODE      = '17' -- 颇斑(1172)
                             OR DC.DUTY_CODE      = '55' -- 蜡鞭绒啊(1190)
                             OR DC.DUTY_CODE      = '18' -- 免厘(1173)
                             OR DC.DUTY_CODE      = '13' -- 绕访(1171)
                             OR DC.DUTY_CODE      = '51' -- 绒老(1188)
                               ) THEN NULL
                         WHEN DI.MODIFY_FLAG = 'N' AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) IS NULL
                                                   AND DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, DI.CLOSE_TIME) IS NOT NULL
                                                   AND DC.DUTY_CODE  = '51' -- 绒老(1188)
                                                   AND S_WC.ALL_NIGHT_YN =  'Y' THEN NULL
                         WHEN DI.MODIFY_FLAG = 'N' AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) IS NULL
                                                   AND DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, DI.CLOSE_TIME) IS NOT NULL
                                                   AND DC.DUTY_CODE IN ( '18' -- 免厘(1173)
                                                                       , '19' -- 版炼绒啊(1174)
                                                                       , '20' -- 斥瞒(1175)
                                                                       , '22' -- 焊扒绒啊(1177)
                                                                       , '23' -- 楷吝绒啊(1178)
                                                                       , '24' -- 措眉绒公(1179)
                                                                       , '52' -- 公鞭绒老(1182)
                                                                       , '53' -- 绒老辟公(1187)
                                                                       , '51' -- 绒老(1188)
                                                                       , '54' -- 公鞭绒啊(1189)
                                                                       , '55' -- 蜡鞭绒啊(1190)
                                                                       , '79' -- 寸流(1194)
                                                                       , '99' -- 枚具(3784)
                                                                       )
                                                   AND ((SELECT HDC.DUTY_CODE
                                                            FROM HRD_DAY_INTERFACE_V     S_DI
                                                              , HRM_DUTY_CODE_V HDC
                                                           WHERE S_DI.DUTY_ID       =  HDC.DUTY_ID
                                                             AND S_DI.SOB_ID        =  DI.SOB_ID
                                                             AND S_DI.ORG_ID        =  DI.ORG_ID
                                                             AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                             AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                             AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                           ) = '53' -- 绒老辟公(1187)
                                                        AND (S_WC.ALL_NIGHT_YN = 'Y'  -- 枚具
                                                          OR S_WC.DANGJIK_YN = 'Y'    -- 寸流.
                                                            )
                                                       ) THEN NULL
                         WHEN DC.DUTY_CODE        = '00' -- 免辟(1168)
                              AND (SELECT S_DI.NEXT_DAY_YN
                                     FROM HRD_DAY_INTERFACE_V   S_DI
                                    WHERE S_DI.SOB_ID       = DI.SOB_ID
                                      AND S_DI.ORG_ID       = DI.ORG_ID
                                      AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                      AND S_DI.PERSON_ID    = DI.PERSON_ID
                                      AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                  ) = 'Y' -- 饶老硼辟
                                  THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, (SELECT S_DI.CLOSE_TIME1
                                                                                          FROM HRD_DAY_INTERFACE_V S_DI
                                                                                         WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                                           AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                                           AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                                           AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                                           AND S_DI.WORK_DATE     =  DI.WORK_DATE
                                                                                       ))
                         WHEN DC.DUTY_CODE        = '00' -- 免辟(1168)
                              AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) IS NULL
                              AND (SELECT S_DI.ALL_NIGHT_YN
                                     FROM HRD_DAY_INTERFACE   S_DI
                                    WHERE S_DI.SOB_ID       = DI.SOB_ID
                                      AND S_DI.ORG_ID       = DI.ORG_ID
                                      AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                      AND S_DI.PERSON_ID    = DI.PERSON_ID
                                      AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                  ) = 'Y' -- 傈老 枚具
                                  THEN NULL
                         WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME
                         ELSE DI.CLOSE_TIME
                    END AS CLOSE_TIME
                  , HRM_COMMON_G.ID_NAME_F(NVL(I_DM.MODIFY_ID, O_DM.MODIFY_ID)) AS MODIFY_DESC
                  , CASE WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                   AND DI.CLOSE_TIME IS NOT NULL
                                                   AND DC.DUTY_CODE  =  '53' THEN '' -- 绒老辟公(1187)
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                   AND DI.CLOSE_TIME IS NOT NULL
                                                   AND DC.DUTY_CODE  =  '00' -- 免辟(1168)
                                                   AND DI.HOLY_TYPE  = '2' THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                   AND DI.CLOSE_TIME IS NULL
                                                   AND DC.DUTY_CODE  =  '11' -- 搬辟(1169)
                                                   AND DI.HOLY_TYPE  = '2' THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                   AND DI.CLOSE_TIME IS NULL
                                                   AND(DC.DUTY_CODE      = '19' -- 版炼绒啊(1174)
                                                     OR DC.DUTY_CODE      = '12' -- 背腊(1170)
                                                     OR DC.DUTY_CODE      = '20' -- 斥瞒(1175)                                                     
                                                     OR DC.DUTY_CODE      = '24' -- 措眉绒公(1179)
                                                     OR DC.DUTY_CODE      = '54' -- 公鞭绒啊(1189)
                                                     OR DC.DUTY_CODE      = '52' -- 公鞭绒老(1182)                                                     
                                                     OR DC.DUTY_CODE      = '22' -- 焊扒绒啊(1177)
                                                     OR DC.DUTY_CODE      = '23' -- 楷吝绒啊(1178)
                                                     OR DC.DUTY_CODE      = '55' -- 蜡鞭绒啊(1190)                                                     
                                                     OR DC.DUTY_CODE      = '17' -- 颇斑(1172)
                                                     OR DC.DUTY_CODE      = '18' -- 免厘(1173)
                                                     OR DC.DUTY_CODE      = '13' -- 绕访(1171)
                                                     OR DC.DUTY_CODE      = '51' -- 绒老(1188)
                                                    ) THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                   AND(SELECT S_DI.HOLY_TYPE
                                                         FROM HRD_DAY_INTERFACE_V   S_DI
                                                        WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                          AND S_DI.ORG_ID       = DI.ORG_ID
                                                          AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                          AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                          AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                      ) = '3' -- 具埃
                                                   AND(DC.DUTY_CODE      = '19' -- 版炼绒啊(1174)
                                                     OR DC.DUTY_CODE      = '12' -- 背腊(1170)
                                                     OR DC.DUTY_CODE      = '20' -- 斥瞒(1175)                                                     
                                                     OR DC.DUTY_CODE      = '24' -- 措眉绒公(1179)
                                                     OR DC.DUTY_CODE      = '54' -- 公鞭绒啊(1189)
                                                     OR DC.DUTY_CODE      = '52' -- 公鞭绒老(1182)                                                     
                                                     OR DC.DUTY_CODE      = '22' -- 焊扒绒啊(1177)
                                                     OR DC.DUTY_CODE      = '23' -- 楷吝绒啊(1178)
                                                     OR DC.DUTY_CODE      = '55' -- 蜡鞭绒啊(1190)                                                     
                                                     OR DC.DUTY_CODE      = '17' -- 颇斑(1172)
                                                     OR DC.DUTY_CODE      = '18' -- 免厘(1173)
                                                     OR DC.DUTY_CODE      = '13' -- 绕访(1171)
                                                     OR DC.DUTY_CODE      = '51' -- 绒老(1188)
                                                      ) THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                   AND DI.CLOSE_TIME IS NOT NULL
                                                   AND DC.DUTY_CODE  =  '00' -- 免辟(1168)
                                                   AND DI.HOLY_TYPE  = '3'  -- 具埃
                                                   AND (SELECT S_DI.CLOSE_TIME
                                                          FROM HRD_DAY_INTERFACE_V     S_DI
                                                         WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                           AND S_DI.ORG_ID        =  DI.ORG_ID
                                                           AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                           AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                           AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                       ) IS NOT NULL THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                   AND DI.CLOSE_TIME IS NULL
                                                   AND DC.DUTY_CODE  =  '00' -- 免辟(1168)
                                                   AND DI.HOLY_TYPE  = '3'   -- 具埃
                                                   AND (SELECT S_DI.CLOSE_TIME
                                                          FROM HRD_DAY_INTERFACE_V     S_DI
                                                         WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                           AND S_DI.ORG_ID        =  DI.ORG_ID
                                                           AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                           AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                           AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                       ) IS NOT NULL THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                   AND DC.DUTY_CODE  =  '11' -- 搬辟(1169)
                                                   AND DI.HOLY_TYPE  = '3'   -- 具埃
                                                   AND (SELECT S_DI.CLOSE_TIME
                                                          FROM HRD_DAY_INTERFACE_V     S_DI
                                                         WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                           AND S_DI.ORG_ID        =  DI.ORG_ID
                                                           AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                           AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                           AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                        ) IS NULL THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME    IS NOT NULL
                                                   AND DI.CLOSE_TIME   IS NULL
                                                   AND DC.DUTY_CODE    =  '53' -- 绒老辟公(1187)
                                                   AND DI.ALL_NIGHT_YN = 'Y'  -- 枚具
                                                   AND DI.HOLY_TYPE    = '1'  -- 绒老
                                                   AND (SELECT S_DI.CLOSE_TIME
                                                          FROM HRD_DAY_INTERFACE_V     S_DI
                                                         WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                           AND S_DI.ORG_ID        =  DI.ORG_ID
                                                           AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                           AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                           AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                       ) IS NOT NULL THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                   AND DI.CLOSE_TIME IS NOT NULL
                                                   AND DC.DUTY_CODE  = '51' -- 绒老(1188)
                                                   AND (SELECT S_DI.ALL_NIGHT_YN -- 枚具
                                                          FROM HRD_DAY_INTERFACE_V   S_DI
                                                         WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                           AND S_DI.ORG_ID        =  DI.ORG_ID
                                                           AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                           AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                           AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                       ) = 'Y' THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                   AND DI.CLOSE_TIME IS NOT NULL
                                                   AND DC.DUTY_CODE  = '22' -- 焊扒绒啊(1177)
                                                   AND (SELECT DI.HOLY_TYPE
                                                          FROM HRD_DAY_INTERFACE_V     S_DI
                                                         WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                           AND S_DI.ORG_ID        =  DI.ORG_ID
                                                           AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                           AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                           AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                       ) = '3' THEN '' -- 具埃
                         WHEN DI.HOLY_TYPE IN ('0', '1') AND DC.DUTY_CODE    =  '53' -- 绒老辟公(1187)
                                                         AND DI.OPEN_TIME > TO_DATE(TO_CHAR(DI.OPEN_TIME, 'YYYY-MM-DD') || ' ' || '17:30:00', 'YYYY-MM-DD HH24:MI:SS')
                                                         AND (SELECT S_DI.CLOSE_TIME
                                                                FROM HRD_DAY_INTERFACE_V     S_DI
                                                               WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                 AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                 AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                 AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                 AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                             ) IS NOT NULL THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.CLOSE_TIME IS NOT NULL
                                                   AND(SELECT HDC.DUTY_CODE -- 绒老辟公
                                                         FROM HRD_DAY_INTERFACE_V     S_DI
                                                           , HRM_DUTY_CODE_V          HDC
                                                        WHERE S_DI.DUTY_ID       = HDC.DUTY_ID
                                                          AND S_DI.SOB_ID        =  DI.SOB_ID
                                                          AND S_DI.ORG_ID        =  DI.ORG_ID
                                                          AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                          AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                          AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                      ) = '53' -- 绒老辟公(1187)
                                                   AND(DC.DUTY_CODE      = '19' -- 版炼绒啊(1174)
                                                     OR DC.DUTY_CODE      = '12' -- 背腊(1170)
                                                     OR DC.DUTY_CODE      = '20' -- 斥瞒(1175)                                                     
                                                     OR DC.DUTY_CODE      = '24' -- 措眉绒公(1179)
                                                     OR DC.DUTY_CODE      = '54' -- 公鞭绒啊(1189)
                                                     OR DC.DUTY_CODE      = '52' -- 公鞭绒老(1182)                                                     
                                                     OR DC.DUTY_CODE      = '22' -- 焊扒绒啊(1177)
                                                     OR DC.DUTY_CODE      = '23' -- 楷吝绒啊(1178)
                                                     OR DC.DUTY_CODE      = '55' -- 蜡鞭绒啊(1190)                                                     
                                                     OR DC.DUTY_CODE      = '17' -- 颇斑(1172)
                                                     OR DC.DUTY_CODE      = '18' -- 免厘(1173)
                                                     OR DC.DUTY_CODE      = '13' -- 绕访(1171)
                                                     OR DC.DUTY_CODE      = '51' -- 绒老(1188)
                                                      ) THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                   AND DI.CLOSE_TIME IS NOT NULL
                                                   AND(SELECT S_DI.CLOSE_TIME
                                                         FROM HRD_DAY_INTERFACE_V     S_DI
                                                        WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                          AND S_DI.ORG_ID        =  DI.ORG_ID
                                                          AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                          AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                          AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                      ) IS NOT NULL
                                                   AND(DC.DUTY_CODE      = '19' -- 版炼绒啊(1174)
                                                     OR DC.DUTY_CODE      = '12' -- 背腊(1170)
                                                     OR DC.DUTY_CODE      = '20' -- 斥瞒(1175)                                                     
                                                     OR DC.DUTY_CODE      = '24' -- 措眉绒公(1179)
                                                     OR DC.DUTY_CODE      = '54' -- 公鞭绒啊(1189)
                                                     OR DC.DUTY_CODE      = '52' -- 公鞭绒老(1182)                                                     
                                                     OR DC.DUTY_CODE      = '22' -- 焊扒绒啊(1177)
                                                     OR DC.DUTY_CODE      = '23' -- 楷吝绒啊(1178)
                                                     OR DC.DUTY_CODE      = '55' -- 蜡鞭绒啊(1190)                                                     
                                                     OR DC.DUTY_CODE      = '17' -- 颇斑(1172)
                                                     OR DC.DUTY_CODE      = '18' -- 免厘(1173)
                                                     OR DC.DUTY_CODE      = '13' -- 绕访(1171)
                                                     OR DC.DUTY_CODE      = '51' -- 绒老(1188)
                                                      ) THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DC.DUTY_CODE    =  '53' -- 绒老辟公(1187)
                                                   AND DI.ALL_NIGHT_YN = 'Y'  -- 枚具
                                                   AND DI.OPEN_TIME    IS NOT NULL
                                                   AND(SELECT S_DI.CLOSE_TIME
                                                         FROM HRD_DAY_INTERFACE_V     S_DI
                                                        WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                          AND S_DI.ORG_ID        =  DI.ORG_ID
                                                          AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                          AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                          AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                      ) IS NOT NULL THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME    IS NULL
                                                   AND DI.CLOSE_TIME   IS NOT NULL
                                                   AND(SELECT HDC.DUTY_CODE -- 绒老辟公
                                                         FROM HRD_DAY_INTERFACE_V     S_DI
                                                           , HRM_DUTY_CODE_V        HDC
                                                        WHERE S_DI.DUTY_ID       =  HDC.DUTY_ID
                                                          AND S_DI.SOB_ID        =  DI.SOB_ID
                                                          AND S_DI.ORG_ID        =  DI.ORG_ID
                                                          AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                          AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                          AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                      ) = '53' -- 绒老辟公(1187)
                                                   AND(SELECT S_DI.ALL_NIGHT_YN -- 枚具
                                                         FROM HRD_DAY_INTERFACE_V   S_DI
                                                        WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                          AND S_DI.ORG_ID        =  DI.ORG_ID
                                                          AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                          AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                          AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                      ) = 'Y' THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                   AND DI.CLOSE_TIME IS NOT NULL
                                                   AND((SELECT S_DI.HOLY_TYPE    -- 具埃
                                                          FROM HRD_DAY_INTERFACE   S_DI
                                                         WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                           AND S_DI.ORG_ID       = DI.ORG_ID
                                                           AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                           AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                           AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                       ) = '3'
                                                    OR (SELECT S_DI.ALL_NIGHT_YN -- 枚具
                                                          FROM HRD_DAY_INTERFACE_V S_DI
                                                         WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                           AND S_DI.ORG_ID       = DI.ORG_ID
                                                           AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                           AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                           AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                       ) = 'Y') THEN ''
                         ELSE HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', DI.APPROVE_STATUS, DI.SOB_ID, DI.ORG_ID)
                    END  AS APPROVE_STATUS_NAME
                  , DI.REJECT_REMARK
                  , DI.MODIFY_FLAG AS MODIFY_FLAG
                  , DI.TRANS_YN    AS TRANS_YN
                  , DI.NEXT_DAY_YN
                  , DI.DANGJIK_YN
                  , HRM_COMMON_G.ID_NAME_F(DI.LEAVE_ID) AS LEAVE_NAME
                  , HRM_COMMON_G.CODE_NAME_F('LEAVE_OUT_TIME', DI.LEAVE_TIME_CODE, DI.SOB_ID, DI.ORG_ID) AS LEAVE_TIME
                  , DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME1, DI.OPEN_TIME1) AS OPEN_TIME1
                  , NVL(O_DM.MODIFY_TIME1, DI.CLOSE_TIME1)                         AS CLOSE_TIME1                  
               FROM HRD_DAY_INTERFACE_V DI
                  , HRM_DUTY_CODE_V     DC
                  , HRD_DAY_MODIFY      I_DM
                  , HRD_DAY_MODIFY      O_DM
                  , (-- 傈老 辟公 沥焊 炼雀.
                     SELECT WC.WORK_DATE + 1 AS WORK_DATE
                          , WC.PERSON_ID
                          , WC.CORP_ID
                          , WC.SOB_ID
                          , WC.ORG_ID
                          , WC.HOLY_TYPE
                          , WC.DANGJIK_YN
                          , WC.ALL_NIGHT_YN
                       FROM HRD_WORK_CALENDAR   WC
                      WHERE WC.SOB_ID         = W_SOB_ID
                        AND WC.ORG_ID         = W_ORG_ID
                        AND WC.WORK_DATE      = W_WORK_DATE - 1 
                    ) S_WC
              WHERE DI.DUTY_ID                = DC.DUTY_ID
                AND DI.PERSON_ID              = I_DM.PERSON_ID(+)
                AND DI.WORK_DATE              = I_DM.WORK_DATE(+)
                AND '1'                       = I_DM.IO_FLAG(+)
                AND DI.PERSON_ID              = O_DM.PERSON_ID(+)
                AND DI.WORK_DATE              = O_DM.WORK_DATE(+)
                AND '2'                       = O_DM.IO_FLAG(+)
                AND DI.WORK_DATE              = S_WC.WORK_DATE(+)
                AND DI.PERSON_ID              = S_WC.PERSON_ID(+)
                AND DI.SOB_ID                 = S_WC.SOB_ID(+)
                AND DI.ORG_ID                 = S_WC.ORG_ID(+)
                AND DI.WORK_DATE              = W_WORK_DATE 
                AND DI.WORK_CORP_ID           = W_WORK_CORP_ID
                AND DI.SOB_ID                 = W_SOB_ID
                AND DI.ORG_ID                 = W_ORG_ID
            ) T3
       WHERE PM.PERSON_ID               = T1.PERSON_ID
         AND PM.PERSON_ID               = T2.PERSON_ID
         AND PM.PERSON_ID               = T3.PERSON_ID(+)
         AND PM.SOB_ID                  = T3.SOB_ID(+)
         AND PM.ORG_ID                  = T3.ORG_ID(+)
         AND PM.WORK_CORP_ID            = W_WORK_CORP_ID
         AND PM.SOB_ID                  = W_SOB_ID
         AND PM.ORG_ID                  = W_ORG_ID
         AND T1.JOB_CATEGORY_CODE       = '10'
         AND PM.JOIN_DATE               <= W_WORK_DATE
         AND (PM.RETIRE_DATE            >= W_WORK_DATE OR PM.RETIRE_DATE IS NULL)
      ORDER BY T3.WORK_DATE
             , T1.JOB_CATEGORY_SORT_NUM
             , T1.DEPT_SORT_NUM
             , T2.FLOOR_SORT_NUM
             , T1.POST_SORT_NUM
             , PM.PERSON_NUM   
       ;  
  END LU_SELECT_PERSON;

-- 包府流 儡诀 脚没 荤盔狼 角力 儡诀矫埃 拌魂 府畔  -- 
  FUNCTION REAL_OT_TIME_F
            ( W_WORK_DATE            IN  DATE
            , W_DUTY_CODE            IN  VARCHAR2
            , W_HOLY_TYPE            IN  VARCHAR2
            , W_JOB_CATE_CODE        IN  VARCHAR2
            , W_OPEN_TIME            IN  DATE
            , W_CLOSE_TIME           IN  DATE
            , W_SOB_ID               IN  NUMBER
						, W_ORG_ID               IN  NUMBER
						) RETURN NUMBER
  AS
    V_REAL_OT_TIME        NUMBER := 0;    
    V_FOOD_DED_TIME       NUMBER := 0;
    
    V_OPEN_TIME           DATE;  -- 30" 窜困 沥府 免辟矫埃 --
    V_CLOSE_TIME          DATE;  -- 30" 窜困 沥府 硼辟矫埃 --
    V_OT_START_TIME       DATE;  -- 儡诀 矫累矫埃 --
    V_OT_END_TIME         DATE;  -- 儡诀 辆丰矫埃 --
  BEGIN
    IF W_CLOSE_TIME IS NULL THEN 
      V_REAL_OT_TIME := 0;
    ELSIF W_OPEN_TIME IS NULL THEN 
      V_REAL_OT_TIME := 0;
    ELSE
      V_OPEN_TIME := HRD_DAY_LEAVE_G_SET.OPEN_TIME_F(W_JOB_CATE_CODE, W_HOLY_TYPE, W_OPEN_TIME);
      V_CLOSE_TIME := HRD_DAY_LEAVE_G_SET.CLOSE_TIME_F(W_JOB_CATE_CODE, W_HOLY_TYPE, W_CLOSE_TIME);
      
      -- 儡诀矫累矫埃 汲沥 --
      IF W_HOLY_TYPE IN('0', '1') THEN
        V_OT_START_TIME := HRD_DAY_LEAVE_G_SET.OT_START_TIME_F( V_OPEN_TIME
                                                              , W_WORK_DATE + 0.354166666666667  -- 08:30 --
                                                              , W_WORK_DATE + 0.354166666666667);
      ELSIF W_HOLY_TYPE IN('3') THEN 
        V_OT_START_TIME := HRD_DAY_LEAVE_G_SET.OT_START_TIME_F( V_OPEN_TIME
                                                              , W_WORK_DATE + 1.270833333333333  -- +1 06:30 --
                                                              , W_WORK_DATE + 1.270833333333333);
      ELSE 
        V_OT_START_TIME := HRD_DAY_LEAVE_G_SET.OT_START_TIME_F( V_OPEN_TIME
                                                              , W_WORK_DATE + 0.75  -- 18:00 --
                                                              , W_WORK_DATE + 0.75);
      END IF;
      V_OT_END_TIME := V_CLOSE_TIME;
     
      -- 儡诀 拌魂 --
      IF V_OT_END_TIME <= V_OT_START_TIME THEN
        V_REAL_OT_TIME := 0;
      ELSE
        V_REAL_OT_TIME := (V_OT_END_TIME - V_OT_START_TIME) * 24;
       
        -- 侥荤矫埃 拌魂 -- 
        V_FOOD_DED_TIME := 0;
        -- 吝侥 --
        IF W_HOLY_TYPE IN('2', '3') THEN 
          NULL;
        ELSE 
          V_FOOD_DED_TIME := NVL(V_FOOD_DED_TIME, 0) + 
                             NVL(HRD_DAY_LEAVE_G_SET.FOOD_DED_TIME_F(W_WORK_DATE
                                                                   , '2'
                                                                   , V_OPEN_TIME
                                                                   , V_CLOSE_TIME
                                                                   , W_JOB_CATE_CODE
                                                                   , W_SOB_ID
                                                                   , W_ORG_ID), 0);
        END IF; 
        -- 籍侥 --                                                          
        IF W_HOLY_TYPE IN('2') THEN 
          NULL;
        ELSE 
          V_FOOD_DED_TIME := NVL(V_FOOD_DED_TIME, 0) + 
                             NVL(HRD_DAY_LEAVE_G_SET.FOOD_DED_TIME_F(W_WORK_DATE
                                                                   , '3'
                                                                   , V_OPEN_TIME
                                                                   , V_CLOSE_TIME
                                                                   , W_JOB_CATE_CODE
                                                                   , W_SOB_ID
                                                                   , W_ORG_ID), 0);
        END IF;   
        -- 具侥 --
        IF W_HOLY_TYPE IN('3') THEN 
          NULL;
        ELSE 
          V_FOOD_DED_TIME := NVL(V_FOOD_DED_TIME, 0) + 
                             NVL(HRD_DAY_LEAVE_G_SET.FOOD_DED_TIME_F((W_WORK_DATE + 1)
                                                                   , '4'
                                                                   , V_OPEN_TIME
                                                                   , V_CLOSE_TIME
                                                                   , W_JOB_CATE_CODE
                                                                   , W_SOB_ID
                                                                   , W_ORG_ID), 0);
        END IF;   
        V_REAL_OT_TIME := NVL(V_REAL_OT_TIME, 0) - NVL(V_FOOD_DED_TIME, 0);
        IF NVL(V_REAL_OT_TIME, 0) < 0 THEN
          V_REAL_OT_TIME := 0;
        END IF;       
      END IF;
    END IF;                                               
    RETURN TRUNC(V_REAL_OT_TIME, 2);                                 
  END REAL_OT_TIME_F;
  
-- 包府流 儡诀 脚没 荤盔狼 角力 儡诀矫埃 拌魂 府畔  -- 
  PROCEDURE REAL_OT_TIME_P
            ( W_WORK_DATE            IN  DATE
            , W_DUTY_CODE            IN  VARCHAR2
            , W_HOLY_TYPE            IN  VARCHAR2
            , W_JOB_CATE_CODE        IN  VARCHAR2
            , W_OPEN_TIME            IN  DATE
            , W_CLOSE_TIME           IN  DATE
            , W_SOB_ID               IN  NUMBER
						, W_ORG_ID               IN  NUMBER
            , O_REAL_OT_TIME         OUT NUMBER
						)
  AS
  BEGIN
    O_REAL_OT_TIME := 0;
    RETURN;
    
    /*BEGIN
      SELECT CASE
               WHEN W_CLOSE_TIME IS NULL THEN 0
               WHEN W_OPEN_TIME IS NULL THEN 0 
               ELSE NVL((HRD_DAY_LEAVE_G_SET.CLOSE_TIME_F(W_JOB_CATE_CODE, W_HOLY_TYPE, W_CLOSE_TIME) - 
                         CASE
                           WHEN W_HOLY_TYPE IN('0', '1') THEN 
                             HRD_DAY_LEAVE_G_SET.OT_START_TIME_F( HRD_DAY_LEAVE_G_SET.OPEN_TIME_F(W_JOB_CATE_CODE, W_HOLY_TYPE, W_OPEN_TIME)
                                                                , W_WORK_DATE + 0.354166666666667  -- 08:30 --
                                                                , W_WORK_DATE + 0.354166666666667) -- 08:30 -- 
                           WHEN W_HOLY_TYPE IN('3') THEN 
                             HRD_DAY_LEAVE_G_SET.OT_START_TIME_F( HRD_DAY_LEAVE_G_SET.OPEN_TIME_F(W_JOB_CATE_CODE, W_HOLY_TYPE, W_OPEN_TIME)
                                                                , W_WORK_DATE + 1.270833333333333
                                                                , W_WORK_DATE + 1.270833333333333) 
                           ELSE
                             HRD_DAY_LEAVE_G_SET.OT_START_TIME_F( HRD_DAY_LEAVE_G_SET.OPEN_TIME_F(W_JOB_CATE_CODE, W_HOLY_TYPE, W_OPEN_TIME)
                                                                , W_WORK_DATE + 0.75
                                                                , W_WORK_DATE + 0.75) 
                         END) * 24, 0) - 
                     ( CASE
                         WHEN W_HOLY_TYPE IN('2', '3') THEN 0
                         ELSE NVL(HRD_DAY_LEAVE_G_SET.FOOD_DED_TIME_F(W_WORK_DATE
                                                                    , '2'
                                                                    , HRD_DAY_LEAVE_G_SET.OPEN_TIME_F(W_JOB_CATE_CODE, W_HOLY_TYPE, W_OPEN_TIME)
                                                                    , HRD_DAY_LEAVE_G_SET.CLOSE_TIME_F(W_JOB_CATE_CODE, W_HOLY_TYPE, W_CLOSE_TIME)
                                                                    , W_JOB_CATE_CODE
                                                                    , W_SOB_ID
                                                                    , W_ORG_ID), 0)
                       END +  
                       CASE
                         WHEN W_HOLY_TYPE IN('2') THEN 0
                         ELSE NVL(HRD_DAY_LEAVE_G_SET.FOOD_DED_TIME_F(W_WORK_DATE
                                                                    , '3'
                                                                    , HRD_DAY_LEAVE_G_SET.OPEN_TIME_F(W_JOB_CATE_CODE, W_HOLY_TYPE, W_OPEN_TIME)
                                                                    , HRD_DAY_LEAVE_G_SET.CLOSE_TIME_F(W_JOB_CATE_CODE, W_HOLY_TYPE, W_CLOSE_TIME)
                                                                    , W_JOB_CATE_CODE
                                                                    , W_SOB_ID
                                                                    , W_ORG_ID), 0)
                       END +                                      
                       CASE
                         WHEN W_HOLY_TYPE IN('3') THEN 0
                         ELSE NVL(HRD_DAY_LEAVE_G_SET.FOOD_DED_TIME_F(W_WORK_DATE + 1
                                                                    , '4'
                                                                    , HRD_DAY_LEAVE_G_SET.OPEN_TIME_F(W_JOB_CATE_CODE, W_HOLY_TYPE, W_OPEN_TIME)
                                                                    , HRD_DAY_LEAVE_G_SET.CLOSE_TIME_F(W_JOB_CATE_CODE, W_HOLY_TYPE, W_CLOSE_TIME)
                                                                    , W_JOB_CATE_CODE
                                                                    , W_SOB_ID
                                                                    , W_ORG_ID), 0)
                       END
                     )
                 END
        INTO O_REAL_OT_TIME
        FROM DUAL;                 
    EXCEPTION WHEN OTHERS THEN
      O_REAL_OT_TIME := 0;
    END;*/
  END REAL_OT_TIME_P;
  
  
-- 包府流 儡诀 脚没 儡诀备盒  -- 
  PROCEDURE LU_SELECT_OT_TYPE
            ( P_CURSOR3              OUT TYPES.TCURSOR3
            , W_WORK_DATE            IN  DATE
            , W_DUTY_ID              IN  NUMBER
            , W_HOLY_TYPE            IN  VARCHAR2
            , W_SOB_ID               IN  NUMBER
						, W_ORG_ID               IN  NUMBER
            , W_ENABLED_FLAG         IN  VARCHAR2
						)
  AS
  BEGIN
    OPEN P_CURSOR3 FOR
      SELECT OT.OT_TYPE_NAME
           , OT.OT_TYPE_CODE 
           , OT.OT_TYPE_ID
           , OT.STD_OT_TIME
           , CASE
               WHEN OT.OT_TYPE_CODE IN('210', '220') THEN W_WORK_DATE +  0.354166666666667  -- 08:30 --
               ELSE W_WORK_DATE + 0.75  -- 18:00 --
             END OPEN_TIME
           , CASE
               WHEN OT.OT_TYPE_CODE IN('210', '220') THEN W_WORK_DATE +  0.354166666666667  -- 08:30 --
               ELSE W_WORK_DATE + 0.75  -- 18:00 --
             END + 
             ((NVL(OT.STD_OT_TIME, 0) +
               CASE 
                 WHEN OT.OT_TYPE_CODE IN('220') THEN 1      -- 痢缴矫埃 1H 利侩 --
                 ELSE 0
               END) / 24) AS CLOSE_TIME
        FROM HRM_OT_TYPE_GW_V OT
       WHERE OT.SOB_ID              = W_SOB_ID
         AND OT.ORG_ID              = W_ORG_ID
         AND OT.ENABLED_FLAG        = DECODE(W_ENABLED_FLAG, 'Y', 'Y', OT.ENABLED_FLAG)
         AND OT.EFFECTIVE_DATE_FR   <= DECODE(W_ENABLED_FLAG, 'Y', W_WORK_DATE, OT.EFFECTIVE_DATE_FR)
         AND (OT.EFFECTIVE_DATE_TO  >= DECODE(W_ENABLED_FLAG, 'Y', W_WORK_DATE, OT.EFFECTIVE_DATE_TO) OR OT.EFFECTIVE_DATE_TO IS NULL)
      ;
  END LU_SELECT_OT_TYPE;
    
END HRD_OT_MANAGER_G;
/
