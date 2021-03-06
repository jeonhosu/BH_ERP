SELECT HRM_DEPT_MASTER_G.DEPT_NAME_F(HL.DEPT_ID) AS DEPT_NAME
           , HRM_COMMON_G.ID_NAME_F(HL.POST_ID) AS POST_NAME
           , HRM_COMMON_G.ID_NAME_F(HL.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
           , PM.NAME
           , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE_TYPE_NAME
           , PM.ORI_JOIN_DATE
           , PM.JOIN_DATE
           , PM.PAY_DATE
           , PM.RETIRE_DATE
           /*, NVL(T1.PAY_GRADE_ID, HL.PAY_GRADE_ID) AS PAY_GRADE_ID
           , HRM_COMMON_G.ID_NAME_F(NVL(T1.PAY_GRADE_ID, HL.PAY_GRADE_ID)) AS PAY_GRADE_NAME           */
           , PM.DISPLAY_NAME
           , PM.PERSON_ID 
           , PM.CORP_ID
        FROM HRM_HISTORY_LINE HL  
          , HRM_PERSON_MASTER PM
          
      WHERE HL.PERSON_ID        = PM.PERSON_ID
/*        AND PM.PERSON_ID        = T1.PERSON_ID(+)*/
        AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                      FROM HRM_HISTORY_LINE S_HL
                                     WHERE S_HL.CHARGE_DATE            <= &W_END_DATE
                                       AND S_HL.PERSON_ID              = HL.PERSON_ID
                                     GROUP BY S_HL.PERSON_ID
                                   )
        AND PM.CORP_ID          = &W_CORP_ID
        AND PM.PERSON_ID        = NVL(&W_PERSON_ID, PM.PERSON_ID)
        AND HL.DEPT_ID          = NVL(&W_DEPT_ID, HL.DEPT_ID)
        AND HL.PAY_GRADE_ID     = NVL(&W_PAY_GRADE_ID, HL.PAY_GRADE_ID)
        AND PM.ORI_JOIN_DATE    <= &W_END_DATE
        AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= &W_START_DATE)
        AND PM.SOB_ID           = &W_SOB_ID
        AND PM.ORG_ID           = &W_ORG_ID
      ORDER BY HL.DEPT_ID, HL.POST_ID, HL.PERSON_ID
;

SELECT NVL(SUM(DECODE(HA.ALLOWANCE_TYPE, 'B', 0, MA.ALLOWANCE_AMOUNT)), 0) AS PAY_AMOUNT
     , NVL(SUM(DECODE(HA.ALLOWANCE_TYPE, 'B', MA.ALLOWANCE_AMOUNT, 0)), 0) AS BONUS_AMOUNT
     , NVL(SUM(MA.ALLOWANCE_AMOUNT), 0) AS TOTAL_SUPPLY_AMOUNT
     , NVL(SUM(MA.ALLOWANCE_AMOUNT), 0) AS REAL_AMOUNT
  FROM HRP_MONTH_ALLOWANCE MA
    , HRM_ALLOWANCE_V HA
 WHERE MA.ALLOWANCE_ID            = HA.ALLOWANCE_ID
   AND MA.MONTH_PAYMENT_ID        = MP.MONTH_PAYMENT_ID
GROUP BY MA.MONTH_PAYMENT_ID
;
SELECT NVL(SUM(DECODE(CT.PAYMENT_TYPE, 'B', 0, MD.DEDUCTION_AMOUNT)), 0) AS DED_PAY_AMOUNT
     , NVL(SUM(DECODE(CT.PAYMENT_TYPE, 'B', MD.DEDUCTION_AMOUNT, 0)), 0) AS DED_BONUS_AMOUNT
     , NVL(SUM(MD.DEDUCTION_AMOUNT), 0) AS TOTAL_DED_AMOUNT
     , NVL(MP.TOT_SUPPLY_AMOUNT, 0) - NVL(SUM(MD.DEDUCTION_AMOUNT), 0) AS REAL_AMOUNT
  FROM HRP_MONTH_DEDUCTION MD
    , HRM_CLOSING_TYPE_V CT
 WHERE MD.WAGE_TYPE               = CT.CLOSING_TYPE
   AND MD.MONTH_PAYMENT_ID        = MP.MONTH_PAYMENT_ID
GROUP BY MD.MONTH_PAYMENT_ID      
