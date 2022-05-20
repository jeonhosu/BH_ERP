-- SUMMARY ����.
SELECT  HRM_COMMON_G.ID_NAME_F(T1.FLOOR_ID) AS FLOOR_NAME
      , COUNT(PM.PERSON_ID) AS FLOOR_COUNT  -- �۾��� �ο���.
      , SUM(CASE W1.DUTY_CODE
              WHEN '00' THEN 1  -- �������.
              WHEN '25' THEN 1  -- ��ü�ٹ�.
              WHEN '41' THEN 1  -- ����.
              WHEN '42' THEN 1  -- ����.
              WHEN '43' THEN 1  -- ����.
              WHEN '44' THEN 1  -- ����.
              WHEN '53' THEN 1  -- ���ϱٹ�.
              WHEN '79' THEN 1  -- ����.
              WHEN '99' THEN 1  -- ö��.
              WHEN '100' THEN 1  -- �ܱ�.
              WHEN '101' THEN 1  -- ����.
              WHEN '102' THEN 1  -- ����.
              WHEN '103' THEN 1  -- ����.
              WHEN '104' THEN 1  -- ����/����.
              ELSE 0
            END) AS IN_PERSON_COUNT  -- ����ο���. 
      , CASE
          WHEN COUNT(PM.PERSON_ID) = 0 THEN 0
          ELSE ROUND(SUM(CASE W1.DUTY_CODE
                            WHEN '00' THEN 1  -- �������.
                            WHEN '25' THEN 1  -- ��ü�ٹ�.
                            WHEN '41' THEN 1  -- ����.
                            WHEN '42' THEN 1  -- ����.
                            WHEN '43' THEN 1  -- ����.
                            WHEN '44' THEN 1  -- ����.
                            WHEN '53' THEN 1  -- ���ϱٹ�.
                            WHEN '79' THEN 1  -- ����.
                            WHEN '99' THEN 1  -- ö��.
                            WHEN '100' THEN 1  -- �ܱ�.
                            WHEN '101' THEN 1  -- ����.
                            WHEN '102' THEN 1  -- ����.
                            WHEN '103' THEN 1  -- ����.
                            WHEN '104' THEN 1  -- ����/����.
                            ELSE 0
                          END) / COUNT(PM.PERSON_ID), 2) * 100
        END AS IN_RATE
  FROM HRM_PERSON_MASTER  PM
    , HRD_WORK_CALENDAR   WC
    , (-- ���� �λ系��.
      SELECT PH.PERSON_ID
           , PH.FLOOR_ID
           , HF.FLOOR_CODE
           , HF.FLOOR_NAME
           , HF.SORT_NUM AS FLOOR_SORT_NUM
        FROM HRD_PERSON_HISTORY PH
           , HRM_FLOOR_V        HF
      WHERE PH.FLOOR_ID           =   HF.FLOOR_ID
        AND PH.EFFECTIVE_DATE_FR  <=  (&W_WORK_DATE - 1)  -- ������.
        AND PH.EFFECTIVE_DATE_TO  >=  (&W_WORK_DATE - 1)  -- ������.
      ) T1
    , ( SELECT DI.PERSON_ID
             , DI.WORK_DATE
             , DI.DUTY_ID
             , DC.DUTY_CODE
             , DC.DUTY_NAME
          FROM HRD_DAY_INTERFACE_V  DI
             , HRM_DUTY_CODE_V      DC
        WHERE DI.DUTY_ID          = DC.DUTY_ID
          AND DI.WORK_DATE        = (&W_WORK_DATE - 1)  -- ������.
          AND DI.WORK_CORP_ID     = &W_CORP_ID
          AND DI.SOB_ID           = &W_SOB_ID
          AND DI.ORG_ID           = &W_ORG_ID
      ) W1
WHERE PM.PERSON_ID                = WC.PERSON_ID
  AND PM.PERSON_ID                = T1.PERSON_ID
  AND PM.PERSON_ID                = W1.PERSON_ID(+)
  AND PM.WORK_CORP_ID             = &W_CORP_ID
  AND PM.JOIN_DATE                <= (&W_WORK_DATE - 1)  -- ������.
  AND (PM.RETIRE_DATE             >= (&W_WORK_DATE - 1) OR PM.RETIRE_DATE IS NULL)
  AND WC.WORK_DATE                =  (&W_WORK_DATE - 1)
GROUP BY T1.FLOOR_ID, T1.FLOOR_SORT_NUM
ORDER BY T1.FLOOR_SORT_NUM
;

-- �� ����.
SELECT  HRM_COMMON_G.ID_NAME_F(T1.FLOOR_ID) AS FLOOR_NAME
      , PM.PERSON_ID
      , PM.DISPLAY_NAME
      , W1.DUTY_ID
      , W1.DUTY_CODE
      , W1.DUTY_NAME
      , PM.JOIN_DATE
      , PM.RETIRE_DATE
  FROM HRM_PERSON_MASTER  PM
    , HRD_WORK_CALENDAR   WC
    , (-- ���� �λ系��.
      SELECT PH.PERSON_ID
           , PH.FLOOR_ID
           , HF.FLOOR_CODE
           , HF.FLOOR_NAME
           , HF.SORT_NUM AS FLOOR_SORT_NUM
        FROM HRD_PERSON_HISTORY PH
           , HRM_FLOOR_V        HF
      WHERE PH.FLOOR_ID           =   HF.FLOOR_ID
        AND PH.EFFECTIVE_DATE_FR  <=  (&W_WORK_DATE - 1)  -- ������.
        AND PH.EFFECTIVE_DATE_TO  >=  (&W_WORK_DATE - 1)  -- ������.
      ) T1
    , ( SELECT DI.PERSON_ID
             , DI.WORK_DATE
             , DI.DUTY_ID
             , DC.DUTY_CODE
             , DC.DUTY_NAME
          FROM HRD_DAY_INTERFACE_V  DI
             , HRM_DUTY_CODE_V      DC
        WHERE DI.DUTY_ID          = DC.DUTY_ID
          AND DI.WORK_DATE        = (&W_WORK_DATE - 1)  -- ������.
          AND DI.WORK_CORP_ID     = &W_CORP_ID
          AND DI.SOB_ID           = &W_SOB_ID
          AND DI.ORG_ID           = &W_ORG_ID
      ) W1
WHERE PM.PERSON_ID                = WC.PERSON_ID
  AND PM.PERSON_ID                = T1.PERSON_ID
  AND PM.PERSON_ID                = W1.PERSON_ID(+)
  AND PM.WORK_CORP_ID             = &W_CORP_ID
  AND PM.JOIN_DATE                <= (&W_WORK_DATE - 1)  -- ������.
  AND (PM.RETIRE_DATE             >= (&W_WORK_DATE - 1) OR PM.RETIRE_DATE IS NULL)
  AND WC.WORK_DATE                =  (&W_WORK_DATE - 1)
ORDER BY T1.FLOOR_SORT_NUM, T1.FLOOR_CODE, PM.NAME
;
