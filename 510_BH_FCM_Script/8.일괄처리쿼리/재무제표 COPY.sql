/*
SELECT FI_COMMON_G.ID_NAME_F(FM.FS_SET_ID) AS FS_SET_DESC
     , FI_COMMON_G.ID_NAME_F(FM.FORM_TYPE_ID) AS FORM_TYPE_DESC
     , FM.FORM_ITEM_TYPE_CD
     , FM.* 
  FROM FI_FORM_MST FM
 WHERE FM.FS_SET_ID     = 1674
   AND FM.FORM_TYPE_ID  = 746
ORDER BY FM.SORT_SEQ
; -- 2472	3	2012년 적용양식 --
*/
-- 재무제표 양식 복사.
--  FI_FORM_MST, FI_FORM_DET : FS_SET_ID, FORM_TYPE_ID 값만 변경하여 INSERT 처리함.
  DECLARE
    V_SYSDATE           DATE := GET_LOCAL_DATE(&W_SOB_ID);
  BEGIN
    -- DELETE --
    DELETE FROM FI_FORM_MST FM
     WHERE FM.FS_SET_ID         = &W_NEW_FS_SET_ID 
       AND FM.FORM_TYPE_ID      = &W_NEW_FORM_TYPE_ID 
       AND FM.SOB_ID            = &W_SOB_ID
       AND FM.ORG_ID            = &W_ORG_ID
    ;
    DELETE FROM FI_FORM_DET FD
     WHERE FD.FS_SET_ID         = &W_NEW_FS_SET_ID 
       AND FD.FORM_TYPE_ID      = &W_NEW_FORM_TYPE_ID 
       AND FD.SOB_ID            = &W_SOB_ID
       AND FD.ORG_ID            = &W_ORG_ID
    ;
    
    -- INSERT --
    FOR C1 IN ( SELECT FFM.SOB_ID 
                     , FFM.ORG_ID 
                     , FFM.FS_SET_ID
                     , FFM.FORM_TYPE_ID
                     , &W_NEW_FS_SET_ID AS NEW_FS_SET_ID 
                     , &W_NEW_FORM_TYPE_ID AS NEW_FORM_TYPE_ID 
                     , FFM.ITEM_CODE 
                     , FFM.ITEM_NAME 
                     , FFM.ACCOUNT_DR_CR 
                     , FFM.MNS_ACCOUNT_FLAG 
                     , FFM.RELATE_ITEM_CODE 
                     , FFM.SORT_SEQ 
                     , FFM.ITEM_LEVEL 
                     , FFM.ENABLED_FLAG 
                     , FFM.REF_FORM_TYPE_ID 
                     , FFM.REF_ITEM_CODE 
                     , FFM.SUMMARY_YN 
                     , FFM.FORM_ITEM_TYPE_CD
                     , FFM.FORM_FRAME_YN 
                     , FFM.REMARKS 
                     , V_SYSDATE AS CREATION_DATE 
                     , &P_USER_ID AS CREATED_BY 
                     , V_SYSDATE AS LAST_UPDATE_DATE 
                     , &P_USER_ID AS LAST_UPDATED_BY 
                  FROM FI_FORM_MST FFM
                 WHERE FFM.FS_SET_ID      = &W_FS_SET_ID
                   AND FFM.FORM_TYPE_ID   = &W_FORM_TYPE_ID
                   AND FFM.SOB_ID         = &W_SOB_ID
                   AND FFM.ORG_ID         = &W_ORG_ID
                ORDER BY FFM.SORT_SEQ
               )
    LOOP
      FOR D1 IN ( SELECT FD.SOB_ID 
                       , FD.ORG_ID 
                       , FD.FS_SET_ID 
                       , FD.FORM_TYPE_ID 
                       , FD.ITEM_CODE 
                       , FD.FORM_SEQ 
                       , FD.DET_ITEM_CODE 
                       , FD.ACCOUNT_CONTROL_ID 
                       , FD.ITEM_SIGN_SHOW 
                       , FD.ENABLED_FLAG 
                       , FD.REMARKS 
                       , V_SYSDATE AS CREATION_DATE 
                       , &P_USER_ID AS CREATED_BY 
                       , V_SYSDATE AS LAST_UPDATE_DATE 
                       , &P_USER_ID AS LAST_UPDATED_BY  
                    FROM FI_FORM_DET FD
                   WHERE FD.FS_SET_ID     = C1.FS_SET_ID
                     AND FD.FORM_TYPE_ID  = C1.FORM_TYPE_ID
                     AND FD.SOB_ID        = C1.SOB_ID
                     AND FD.ORG_ID        = C1.ORG_ID
                  ORDER BY FD.FORM_SEQ
                 )
      LOOP
        INSERT INTO FI_FORM_DET
        ( SOB_ID 
        , ORG_ID 
        , FS_SET_ID 
        , FORM_TYPE_ID 
        , ITEM_CODE 
        , FORM_SEQ 
        , DET_ITEM_CODE 
        , ACCOUNT_CONTROL_ID 
        , ITEM_SIGN_SHOW 
        , ENABLED_FLAG 
        , REMARKS 
        , CREATION_DATE 
        , CREATED_BY 
        , LAST_UPDATE_DATE 
        , LAST_UPDATED_BY 
        ) VALUES
        ( C1.SOB_ID 
        , C1.ORG_ID 
        , C1.NEW_FS_SET_ID 
        , C1.NEW_FORM_TYPE_ID 
        , DI.ITEM_CODE 
        , DI.FORM_SEQ 
        , DI.DET_ITEM_CODE 
        , DI.ACCOUNT_CONTROL_ID 
        , DI.ITEM_SIGN_SHOW 
        , DI.ENABLED_FLAG 
        , DI.REMARKS 
        , C1.CREATION_DATE 
        , C1.CREATED_BY 
        , C1.LAST_UPDATE_DATE 
        , C1.LAST_UPDATED_BY 
        );
      END LOOP D1;
      INSERT INTO FI_FORM_MST
      ( SOB_ID 
      , ORG_ID 
      , FS_SET_ID 
      , FORM_TYPE_ID 
      , ITEM_CODE 
      , ITEM_NAME 
      , ACCOUNT_DR_CR 
      , MNS_ACCOUNT_FLAG 
      , RELATE_ITEM_CODE 
      , SORT_SEQ 
      , ITEM_LEVEL 
      , ENABLED_FLAG 
      , REF_FORM_TYPE_ID 
      , REF_ITEM_CODE 
      , SUMMARY_YN 
      , FORM_ITEM_TYPE_CD 
      , FORM_FRAME_YN 
      , REMARKS 
      , CREATION_DATE 
      , CREATED_BY 
      , LAST_UPDATE_DATE 
      , LAST_UPDATED_BY 
      ) VALUES
      ( C1.SOB_ID 
      , C1.ORG_ID 
      , C1.NEW_FS_SET_ID 
      , C1.NEW_FORM_TYPE_ID 
      , C1.ITEM_CODE 
      , C1.ITEM_NAME 
      , C1.ACCOUNT_DR_CR 
      , C1.MNS_ACCOUNT_FLAG 
      , C1.RELATE_ITEM_CODE 
      , C1.SORT_SEQ 
      , C1.ITEM_LEVEL 
      , C1.ENABLED_FLAG 
      , C1.REF_FORM_TYPE_ID 
      , C1.REF_ITEM_CODE 
      , C1.SUMMARY_YN 
      , C1.FORM_ITEM_TYPE_CD 
      , C1.FORM_FRAME_YN 
      , C1.REMARKS 
      , C1.CREATION_DATE 
      , C1.CREATED_BY 
      , C1.LAST_UPDATE_DATE 
      , C1.LAST_UPDATED_BY 
      );
    END LOOP C1;
    
  END;
