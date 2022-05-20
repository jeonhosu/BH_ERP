CREATE MATERIALIZED VIEW HRF_FOOD_DAY_COUNT_V TABLESPACE FCM_TS_DATA
USING INDEX TABLESPACE FCM_TS_IDX
--BUILD IMMEDIATE 
REFRESH FORCE
WITH ROWID
AS
SELECT SX1.FOOD_DATE
     , SX1.CORP_ID
		 , SX1.DEVICE_ID
     , NVL(SUM(SX1.FOOD_COUNT), 0) AS FOOD_COUNT
		 , NVL(SUM(SX1.P_FOOD_COUNT), 0) AS P_FOOD_COUNT
     , NVL(SUM(SX1.P_FOOD_1_COUNT), 0) AS P_FOOD_1_COUNT
     , NVL(SUM(SX1.P_FOOD_2_COUNT), 0) AS P_FOOD_2_COUNT
     , NVL(SUM(SX1.P_FOOD_3_COUNT), 0) AS P_FOOD_3_COUNT
     , NVL(SUM(SX1.P_FOOD_4_COUNT), 0) AS P_FOOD_4_COUNT
     , NVL(SUM(SX1.P_SNACK_1_COUNT), 0) AS P_SNACK_1_COUNT
     , NVL(SUM(SX1.P_SNACK_2_COUNT), 0) AS P_SNACK_2_COUNT
     , NVL(SUM(SX1.P_SNACK_3_COUNT), 0) AS P_SNACK_3_COUNT
     , NVL(SUM(SX1.P_SNACK_4_COUNT), 0) AS P_SNACK_4_COUNT
		 , NVL(SUM(SX1.V_FOOD_COUNT), 0) AS V_FOOD_COUNT
     , NVL(SUM(SX1.V_FOOD_1_COUNT), 0) AS V_FOOD_1_COUNT
     , NVL(SUM(SX1.V_FOOD_2_COUNT), 0) AS V_FOOD_2_COUNT
     , NVL(SUM(SX1.V_FOOD_3_COUNT), 0) AS V_FOOD_3_COUNT
     , NVL(SUM(SX1.V_FOOD_4_COUNT), 0) AS V_FOOD_4_COUNT
     , NVL(SUM(SX1.V_SNACK_1_COUNT), 0) AS V_SNACK_1_COUNT
     , NVL(SUM(SX1.V_SNACK_2_COUNT), 0) AS V_SNACK_2_COUNT
     , NVL(SUM(SX1.V_SNACK_3_COUNT), 0) AS V_SNACK_3_COUNT
     , NVL(SUM(SX1.V_SNACK_4_COUNT), 0) AS V_SNACK_4_COUNT
		 , SX1.SOB_ID
		 , SX1.ORG_ID
FROM (SELECT FPT.FOOD_DATE
           , PM.CORP_ID
					 , FPT.DEVICE_ID
           , COUNT(FPT.FOOD_DATETIME) AS FOOD_COUNT
					 , COUNT(FPT.FOOD_DATETIME) AS P_FOOD_COUNT
           , NVL(SUM(DECODE(FPT.FOOD_FLAG, '1', 1, 0)), 0) AS P_FOOD_1_COUNT
           , NVL(SUM(DECODE(FPT.FOOD_FLAG, '2', 1, 0)), 0) AS P_FOOD_2_COUNT
           , NVL(SUM(DECODE(FPT.FOOD_FLAG, '3', 1, 0)), 0) AS P_FOOD_3_COUNT
           , NVL(SUM(DECODE(FPT.FOOD_FLAG, '4', 1, 0)), 0) AS P_FOOD_4_COUNT
           , NVL(SUM(DECODE(FPT.FOOD_FLAG, '5', 1, 0)), 0) AS P_SNACK_1_COUNT
           , NVL(SUM(DECODE(FPT.FOOD_FLAG, '6', 1, 0)), 0) AS P_SNACK_2_COUNT
           , NVL(SUM(DECODE(FPT.FOOD_FLAG, '7', 1, 0)), 0) AS P_SNACK_3_COUNT
           , NVL(SUM(DECODE(FPT.FOOD_FLAG, '8', 1, 0)), 0) AS P_SNACK_4_COUNT
					 , 0 AS V_FOOD_COUNT
           , 0 AS V_FOOD_1_COUNT
           , 0 AS V_FOOD_2_COUNT
           , 0 AS V_FOOD_3_COUNT
           , 0 AS V_FOOD_4_COUNT
           , 0 AS V_SNACK_1_COUNT
           , 0 AS V_SNACK_2_COUNT
           , 0 AS V_SNACK_3_COUNT
           , 0 AS V_SNACK_4_COUNT
					 , PM.SOB_ID
					 , PM.ORG_ID
        FROM HRF_FOOD_PERSON_TIME FPT
           , HRM_PERSON_MASTER PM
       WHERE FPT.PERSON_ID             = PM.PERSON_ID
      GROUP BY FPT.FOOD_DATE
           , PM.CORP_ID
					 , FPT.DEVICE_ID
           , PM.SOB_ID
           , PM.ORG_ID
      -- UNION --
      UNION ALL
      -- UNION : �湮 ��ȸ.
      SELECT FVT.FOOD_DATE
           , VC.CORP_ID
					 , FVT.DEVICE_ID
           , COUNT(FVT.FOOD_DATETIME) AS FOOD_COUNT
					 , 0 AS P_FOOD_COUNT
           , 0 AS P_FOOD_1_COUNT
           , 0 AS P_FOOD_2_COUNT
           , 0 AS P_FOOD_3_COUNT
           , 0 AS P_FOOD_4_COUNT
           , 0 AS P_SNACK_1_COUNT
           , 0 AS P_SNACK_2_COUNT
           , 0 AS P_SNACK_3_COUNT
           , 0 AS P_SNACK_4_COUNT
					 , COUNT(FVT.FOOD_DATETIME) AS V_FOOD_COUNT
           , NVL(SUM(DECODE(FVT.FOOD_FLAG, '1', 1, 0)), 0) AS V_FOOD_1_COUNT
           , NVL(SUM(DECODE(FVT.FOOD_FLAG, '2', 1, 0)), 0) AS V_FOOD_2_COUNT
           , NVL(SUM(DECODE(FVT.FOOD_FLAG, '3', 1, 0)), 0) AS V_FOOD_3_COUNT
           , NVL(SUM(DECODE(FVT.FOOD_FLAG, '4', 1, 0)), 0) AS V_FOOD_4_COUNT
           , NVL(SUM(DECODE(FVT.FOOD_FLAG, '5', 1, 0)), 0) AS V_SNACK_1_COUNT
           , NVL(SUM(DECODE(FVT.FOOD_FLAG, '6', 1, 0)), 0) AS V_SNACK_2_COUNT
           , NVL(SUM(DECODE(FVT.FOOD_FLAG, '7', 1, 0)), 0) AS V_SNACK_3_COUNT
           , NVL(SUM(DECODE(FVT.FOOD_FLAG, '8', 1, 0)), 0) AS V_SNACK_4_COUNT
					 , VC.SOB_ID
           , VC.ORG_ID
        FROM HRF_FOOD_VISITOR_TIME FVT
           , HRM_VISITOR_CARD VC
       WHERE FVT.VISITOR_ID           = VC.VISITOR_CARD_ID
      GROUP BY FVT.FOOD_DATE
           , VC.CORP_ID
					 , FVT.DEVICE_ID
           , VC.SOB_ID
           , VC.ORG_ID
      )SX1
GROUP BY SX1.FOOD_DATE
     , SX1.CORP_ID
		 , SX1.DEVICE_ID		 
		 , SX1.SOB_ID
		 , SX1.ORG_ID
;
