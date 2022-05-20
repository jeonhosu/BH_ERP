SELECT DI.WORK_DATE
     , DI.PERSON_ID
                  , HRM_COMMON_G.ID_NAME_F(DI.DUTY_ID) AS DUTY_NAME
                  , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DI.HOLY_TYPE, DI.SOB_ID, DI.ORG_ID) AS HOLY_TYPE_NAME
                  , SUBSTR(TO_CHAR(DI.WORK_DATE, 'DAY', 'NLS_DATE_LANGUAGE=KOREAN'), 1, 1)    AS W
                  , DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) AS OPEN_TIME
                  , CASE
                         -- ���� ��ٱ�� �о����(��, ���������� ������ �������� �ݿ�).
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
                             AND DC.DUTY_CODE = '53' -- ���ϱٹ�(1187)
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
                         WHEN S_WC.HOLY_TYPE = '3' -- �߰�
                            AND(DC.DUTY_CODE      = '19' -- �����ް�(1174)
                             OR DC.DUTY_CODE      = '12' -- ����(1170)
                             OR DC.DUTY_CODE      = '20' -- ����(1175)
                             OR DC.DUTY_CODE      = '54' -- �����ް�(1189)
                             OR DC.DUTY_CODE      = '52' -- ��������(1182)
                             OR DC.DUTY_CODE      = '17' -- �İ�(1172)
                             OR DC.DUTY_CODE      = '55' -- �����ް�(1190)
                             OR DC.DUTY_CODE      = '18' -- ����(1173)
                             OR DC.DUTY_CODE      = '13' -- �Ʒ�(1171)
                             OR DC.DUTY_CODE      = '51' -- ����(1188)
                               ) THEN NULL
                         WHEN DI.MODIFY_FLAG = 'N' AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) IS NULL
                                                   AND DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, DI.CLOSE_TIME) IS NOT NULL
                                                   AND DC.DUTY_CODE  = '51' -- ����(1188)
                                                   AND S_WC.ALL_NIGHT_YN =  'Y' THEN NULL
                         WHEN DI.MODIFY_FLAG = 'N' AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) IS NULL
                                                   AND DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, DI.CLOSE_TIME) IS NOT NULL
                                                   AND DC.DUTY_CODE IN ( '18' -- ����(1173)
                                                                       , '19' -- �����ް�(1174)
                                                                       , '20' -- ����(1175)
                                                                       , '22' -- �����ް�(1177)
                                                                       , '23' -- �����ް�(1178)
                                                                       , '24' -- ��ü�޹�(1179)
                                                                       , '52' -- ��������(1182)
                                                                       , '53' -- ���ϱٹ�(1187)
                                                                       , '51' -- ����(1188)
                                                                       , '54' -- �����ް�(1189)
                                                                       , '55' -- �����ް�(1190)
                                                                       , '79' -- ����(1194)
                                                                       , '99' -- ö��(3784)
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
                                                           ) = '53' -- ���ϱٹ�(1187)
                                                        AND (S_WC.ALL_NIGHT_YN = 'Y'  -- ö��
                                                          OR S_WC.DANGJIK_YN = 'Y'    -- ����.
                                                            )
                                                       ) THEN NULL
                         WHEN DC.DUTY_CODE        = '00' -- ���(1168)
                              AND (SELECT S_DI.NEXT_DAY_YN
                                     FROM HRD_DAY_INTERFACE_V   S_DI
                                    WHERE S_DI.SOB_ID       = DI.SOB_ID
                                      AND S_DI.ORG_ID       = DI.ORG_ID
                                      AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                      AND S_DI.PERSON_ID    = DI.PERSON_ID
                                      AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                  ) = 'Y' -- �������
                                  THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, (SELECT S_DI.CLOSE_TIME1
                                                                                          FROM HRD_DAY_INTERFACE_V S_DI
                                                                                         WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                                           AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                                           AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                                           AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                                           AND S_DI.WORK_DATE     =  DI.WORK_DATE
                                                                                       ))
                         WHEN DC.DUTY_CODE        = '00' -- ���(1168)
                              AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) IS NULL
                              AND (SELECT S_DI.ALL_NIGHT_YN
                                     FROM HRD_DAY_INTERFACE   S_DI
                                    WHERE S_DI.SOB_ID       = DI.SOB_ID
                                      AND S_DI.ORG_ID       = DI.ORG_ID
                                      AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                      AND S_DI.PERSON_ID    = DI.PERSON_ID
                                      AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                  ) = 'Y' -- ���� ö��
                                  THEN NULL
                         WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME
                         ELSE DI.CLOSE_TIME
                    END AS CLOSE_TIME
                  , HRM_COMMON_G.ID_NAME_F(NVL(I_DM.MODIFY_ID, O_DM.MODIFY_ID)) AS MODIFY_DESC
                  , CASE WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                   AND DI.CLOSE_TIME IS NOT NULL
                                                   AND DC.DUTY_CODE  =  '53' THEN '' -- ���ϱٹ�(1187)
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                   AND DI.CLOSE_TIME IS NOT NULL
                                                   AND DC.DUTY_CODE  =  '00' -- ���(1168)
                                                   AND DI.HOLY_TYPE  = '2' THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                   AND DI.CLOSE_TIME IS NULL
                                                   AND DC.DUTY_CODE  =  '11' -- ���(1169)
                                                   AND DI.HOLY_TYPE  = '2' THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                   AND DI.CLOSE_TIME IS NULL
                                                   AND(DC.DUTY_CODE      = '19' -- �����ް�(1174)
                                                     OR DC.DUTY_CODE      = '12' -- ����(1170)
                                                     OR DC.DUTY_CODE      = '20' -- ����(1175)                                                     
                                                     OR DC.DUTY_CODE      = '24' -- ��ü�޹�(1179)
                                                     OR DC.DUTY_CODE      = '54' -- �����ް�(1189)
                                                     OR DC.DUTY_CODE      = '52' -- ��������(1182)                                                     
                                                     OR DC.DUTY_CODE      = '22' -- �����ް�(1177)
                                                     OR DC.DUTY_CODE      = '23' -- �����ް�(1178)
                                                     OR DC.DUTY_CODE      = '55' -- �����ް�(1190)                                                     
                                                     OR DC.DUTY_CODE      = '17' -- �İ�(1172)
                                                     OR DC.DUTY_CODE      = '18' -- ����(1173)
                                                     OR DC.DUTY_CODE      = '13' -- �Ʒ�(1171)
                                                     OR DC.DUTY_CODE      = '51' -- ����(1188)
                                                    ) THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                   AND(SELECT S_DI.HOLY_TYPE
                                                         FROM HRD_DAY_INTERFACE_V   S_DI
                                                        WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                          AND S_DI.ORG_ID       = DI.ORG_ID
                                                          AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                          AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                          AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                      ) = '3' -- �߰�
                                                   AND(DC.DUTY_CODE      = '19' -- �����ް�(1174)
                                                     OR DC.DUTY_CODE      = '12' -- ����(1170)
                                                     OR DC.DUTY_CODE      = '20' -- ����(1175)                                                     
                                                     OR DC.DUTY_CODE      = '24' -- ��ü�޹�(1179)
                                                     OR DC.DUTY_CODE      = '54' -- �����ް�(1189)
                                                     OR DC.DUTY_CODE      = '52' -- ��������(1182)                                                     
                                                     OR DC.DUTY_CODE      = '22' -- �����ް�(1177)
                                                     OR DC.DUTY_CODE      = '23' -- �����ް�(1178)
                                                     OR DC.DUTY_CODE      = '55' -- �����ް�(1190)                                                     
                                                     OR DC.DUTY_CODE      = '17' -- �İ�(1172)
                                                     OR DC.DUTY_CODE      = '18' -- ����(1173)
                                                     OR DC.DUTY_CODE      = '13' -- �Ʒ�(1171)
                                                     OR DC.DUTY_CODE      = '51' -- ����(1188)
                                                      ) THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                   AND DI.CLOSE_TIME IS NOT NULL
                                                   AND DC.DUTY_CODE  =  '00' -- ���(1168)
                                                   AND DI.HOLY_TYPE  = '3'  -- �߰�
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
                                                   AND DC.DUTY_CODE  =  '00' -- ���(1168)
                                                   AND DI.HOLY_TYPE  = '3'   -- �߰�
                                                   AND (SELECT S_DI.CLOSE_TIME
                                                          FROM HRD_DAY_INTERFACE_V     S_DI
                                                         WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                           AND S_DI.ORG_ID        =  DI.ORG_ID
                                                           AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                           AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                           AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                       ) IS NOT NULL THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                   AND DC.DUTY_CODE  =  '11' -- ���(1169)
                                                   AND DI.HOLY_TYPE  = '3'   -- �߰�
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
                                                   AND DC.DUTY_CODE    =  '53' -- ���ϱٹ�(1187)
                                                   AND DI.ALL_NIGHT_YN = 'Y'  -- ö��
                                                   AND DI.HOLY_TYPE    = '1'  -- ����
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
                                                   AND DC.DUTY_CODE  = '51' -- ����(1188)
                                                   AND (SELECT S_DI.ALL_NIGHT_YN -- ö��
                                                          FROM HRD_DAY_INTERFACE_V   S_DI
                                                         WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                           AND S_DI.ORG_ID        =  DI.ORG_ID
                                                           AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                           AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                           AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                       ) = 'Y' THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                   AND DI.CLOSE_TIME IS NOT NULL
                                                   AND DC.DUTY_CODE  = '22' -- �����ް�(1177)
                                                   AND (SELECT DI.HOLY_TYPE
                                                          FROM HRD_DAY_INTERFACE_V     S_DI
                                                         WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                           AND S_DI.ORG_ID        =  DI.ORG_ID
                                                           AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                           AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                           AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                       ) = '3' THEN '' -- �߰�
                         WHEN DI.HOLY_TYPE IN ('0', '1') AND DC.DUTY_CODE    =  '53' -- ���ϱٹ�(1187)
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
                                                   AND(SELECT HDC.DUTY_CODE -- ���ϱٹ�
                                                         FROM HRD_DAY_INTERFACE_V     S_DI
                                                           , HRM_DUTY_CODE_V          HDC
                                                        WHERE S_DI.DUTY_ID       = HDC.DUTY_ID
                                                          AND S_DI.SOB_ID        =  DI.SOB_ID
                                                          AND S_DI.ORG_ID        =  DI.ORG_ID
                                                          AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                          AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                          AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                      ) = '53' -- ���ϱٹ�(1187)
                                                   AND(DC.DUTY_CODE      = '19' -- �����ް�(1174)
                                                     OR DC.DUTY_CODE      = '12' -- ����(1170)
                                                     OR DC.DUTY_CODE      = '20' -- ����(1175)                                                     
                                                     OR DC.DUTY_CODE      = '24' -- ��ü�޹�(1179)
                                                     OR DC.DUTY_CODE      = '54' -- �����ް�(1189)
                                                     OR DC.DUTY_CODE      = '52' -- ��������(1182)                                                     
                                                     OR DC.DUTY_CODE      = '22' -- �����ް�(1177)
                                                     OR DC.DUTY_CODE      = '23' -- �����ް�(1178)
                                                     OR DC.DUTY_CODE      = '55' -- �����ް�(1190)                                                     
                                                     OR DC.DUTY_CODE      = '17' -- �İ�(1172)
                                                     OR DC.DUTY_CODE      = '18' -- ����(1173)
                                                     OR DC.DUTY_CODE      = '13' -- �Ʒ�(1171)
                                                     OR DC.DUTY_CODE      = '51' -- ����(1188)
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
                                                   AND(DC.DUTY_CODE      = '19' -- �����ް�(1174)
                                                     OR DC.DUTY_CODE      = '12' -- ����(1170)
                                                     OR DC.DUTY_CODE      = '20' -- ����(1175)                                                     
                                                     OR DC.DUTY_CODE      = '24' -- ��ü�޹�(1179)
                                                     OR DC.DUTY_CODE      = '54' -- �����ް�(1189)
                                                     OR DC.DUTY_CODE      = '52' -- ��������(1182)                                                     
                                                     OR DC.DUTY_CODE      = '22' -- �����ް�(1177)
                                                     OR DC.DUTY_CODE      = '23' -- �����ް�(1178)
                                                     OR DC.DUTY_CODE      = '55' -- �����ް�(1190)                                                     
                                                     OR DC.DUTY_CODE      = '17' -- �İ�(1172)
                                                     OR DC.DUTY_CODE      = '18' -- ����(1173)
                                                     OR DC.DUTY_CODE      = '13' -- �Ʒ�(1171)
                                                     OR DC.DUTY_CODE      = '51' -- ����(1188)
                                                      ) THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DC.DUTY_CODE    =  '53' -- ���ϱٹ�(1187)
                                                   AND DI.ALL_NIGHT_YN = 'Y'  -- ö��
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
                                                   AND(SELECT HDC.DUTY_CODE -- ���ϱٹ�
                                                         FROM HRD_DAY_INTERFACE_V     S_DI
                                                           , HRM_DUTY_CODE_V        HDC
                                                        WHERE S_DI.DUTY_ID       =  HDC.DUTY_ID
                                                          AND S_DI.SOB_ID        =  DI.SOB_ID
                                                          AND S_DI.ORG_ID        =  DI.ORG_ID
                                                          AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                          AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                          AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                      ) = '53' -- ���ϱٹ�(1187)
                                                   AND(SELECT S_DI.ALL_NIGHT_YN -- ö��
                                                         FROM HRD_DAY_INTERFACE_V   S_DI
                                                        WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                          AND S_DI.ORG_ID        =  DI.ORG_ID
                                                          AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                          AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                          AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                      ) = 'Y' THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                   AND DI.CLOSE_TIME IS NOT NULL
                                                   AND((SELECT S_DI.HOLY_TYPE    -- �߰�
                                                          FROM HRD_DAY_INTERFACE   S_DI
                                                         WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                           AND S_DI.ORG_ID       = DI.ORG_ID
                                                           AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                           AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                           AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                       ) = '3'
                                                    OR (SELECT S_DI.ALL_NIGHT_YN -- ö��
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
                  , DI.WORK_DATE
                  , DI.DESCRIPTION
                  , DI.CORP_ID
                  , DI.WORK_CORP_ID
                  , DI.PERSON_ID
               FROM HRD_DAY_INTERFACE_V DI
                  , HRM_DUTY_CODE_V     DC
                  , HRM_PERSON_MASTER   PM
                  , HRD_DAY_MODIFY I_DM
                  , HRD_DAY_MODIFY O_DM
                  , (-- ���� �ٹ� ���� ��ȸ.
                     SELECT WC.WORK_DATE + 1 AS WORK_DATE
                          , WC.PERSON_ID
                          , WC.CORP_ID
                          , WC.SOB_ID
                          , WC.ORG_ID
                          , WC.HOLY_TYPE
                          , WC.DANGJIK_YN
                          , WC.ALL_NIGHT_YN
                       FROM HRD_WORK_CALENDAR   WC
                      WHERE WC.SOB_ID         = &W_SOB_ID
                        AND WC.ORG_ID         = &W_ORG_ID
                        AND WC.WORK_CORP_ID   = &W_WORK_CORP_ID
                        AND WC.WORK_DATE      BETWEEN &W_WORK_DATE_FR - 1 AND &W_WORK_DATE_TO
                        AND WC.PERSON_ID      = NVL(&W_PERSON_ID, WC.PERSON_ID)
                    ) S_WC
                    , (-- ���� �ٹ� ���� ��ȸ.
                       SELECT DIT.WORK_DATE - 1 AS WORK_DATE
                            , DIT.PERSON_ID
                            , DIT.CORP_ID
                            , DIT.SOB_ID
                            , DIT.ORG_ID
                            , DIT.OPEN_TIME
                            , DIT.CLOSE_TIME
                            , DIT.OPEN_TIME1
                            , DIT.CLOSE_TIME1
                         FROM HRD_DAY_INTERFACE   DIT
                        WHERE DIT.SOB_ID        = &W_SOB_ID
                          AND DIT.ORG_ID        = &W_ORG_ID
                          AND DIT.WORK_CORP_ID  = &W_WORK_CORP_ID
                          AND DIT.WORK_DATE     BETWEEN &W_WORK_DATE_FR AND &W_WORK_DATE_TO + 1
                          AND DIT.PERSON_ID     = NVL(&W_PERSON_ID, DIT.PERSON_ID)
                      ) N_DI
              WHERE DI.DUTY_ID                                 = DC.DUTY_ID
                AND DI.PERSON_ID                               = PM.PERSON_ID
                AND DI.PERSON_ID                               = I_DM.PERSON_ID(+)
                AND DI.WORK_DATE                               = I_DM.WORK_DATE(+)
                AND '1'                                        = I_DM.IO_FLAG(+)
                AND DI.PERSON_ID                               = O_DM.PERSON_ID(+)
                AND DI.WORK_DATE                               = O_DM.WORK_DATE(+)
                AND '2'                                        = O_DM.IO_FLAG(+)
                AND DI.WORK_DATE                               = S_WC.WORK_DATE(+)
                AND DI.PERSON_ID                               = S_WC.PERSON_ID(+)
                AND DI.SOB_ID                                  = S_WC.SOB_ID(+)
                AND DI.ORG_ID                                  = S_WC.ORG_ID(+)
                AND DI.WORK_DATE                               = N_DI.WORK_DATE(+)
                AND DI.PERSON_ID                               = N_DI.PERSON_ID(+)
                AND DI.SOB_ID                                  = N_DI.SOB_ID(+)
                AND DI.ORG_ID                                  = N_DI.ORG_ID(+)
                AND DI.WORK_DATE                               BETWEEN &W_WORK_DATE_FR AND &W_WORK_DATE_TO
                AND DI.PERSON_ID                               = NVL(&W_PERSON_ID, DI.PERSON_ID)
                AND DI.WORK_CORP_ID                            = &W_WORK_CORP_ID
                AND DI.SOB_ID                                  = &W_SOB_ID
                AND DI.ORG_ID                                  = &W_ORG_ID
                AND PM.JOIN_DATE                              <= &W_WORK_DATE_TO
                AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= &W_WORK_DATE_FR)                
                  ;
