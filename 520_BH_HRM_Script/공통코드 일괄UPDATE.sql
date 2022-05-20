declare 

begin
  
  for c1 in (select HC.GROUP_CODE
                  , HC.CODE
                  , HC.CODE_NAME    
                  , HC.VALUE1
                  , HC.VALUE2
                  , HC.VALUE3
                  , HC.VALUE4
                  , HC.VALUE5
                  , HC.VALUE6
                  , HC.VALUE7
                  , HC.VALUE8
                  , HC.VALUE9
                  , HC.VALUE10
                  , HC.DEFAULT_FLAG
                  , HC.SORT_NUM
                  , HC.DESCRIPTION
                  , HC.ENABLED_FLAG
                  , HC.EFFECTIVE_DATE_FR
                  , HC.EFFECTIVE_DATE_TO
               from hrm_common HC
              where HC.sob_id   = 10
                and HC.org_id   = 101
             )
  loop
      UPDATE HRM_COMMON HC
      SET HC.CODE_NAME             = C1.CODE_NAME
        , HC.VALUE1                = C1.VALUE1
        , HC.VALUE2                = C1.VALUE2
        , HC.VALUE3                = C1.VALUE3
        , HC.VALUE4                = C1.VALUE4
        , HC.VALUE5                = C1.VALUE5
        , HC.VALUE6                = C1.VALUE6
        , HC.VALUE7                = C1.VALUE7
        , HC.VALUE8                = C1.VALUE8
        , HC.VALUE9                = C1.VALUE9
        , HC.VALUE10               = C1.VALUE10
        , HC.DEFAULT_FLAG          = C1.DEFAULT_FLAG
        , HC.SORT_NUM              = C1.SORT_NUM
        , HC.DESCRIPTION           = C1.DESCRIPTION
        , HC.ENABLED_FLAG          = C1.ENABLED_FLAG
        , HC.EFFECTIVE_DATE_FR     = TRUNC(C1.EFFECTIVE_DATE_FR)
        , HC.EFFECTIVE_DATE_TO     = TRUNC(C1.EFFECTIVE_DATE_TO)
        , HC.LAST_UPDATE_DATE      = GET_LOCAL_DATE(HC.SOB_ID)
        , HC.LAST_UPDATED_BY       = -1
			WHERE GROUP_CODE             = C1.GROUP_CODE
        AND CODE                   = C1.CODE
        AND SOB_ID                 = 20  
        AND ORG_ID                 = 201
      ;
    
   /* IF (SQL%NOTFOUND) THEN
      DBMS_OUTPUT.PUT_LINE('INSERT : ' || C1.GROUP_CODE || ', CODE : ' || C1.CODE);
      
      INSERT INTO HRM_COMMON 
      ( COMMON_ID, GROUP_CODE, CODE, CODE_NAME
      , VALUE1, VALUE2, VALUE3, VALUE4, VALUE5, VALUE6, VALUE7, VALUE8, VALUE9, VALUE10
      , DEFAULT_FLAG
      , SORT_NUM, DESCRIPTION, ENABLED_FLAG, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO
      , SOB_ID, ORG_ID
      , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY)
      SELECT HRM_COMMON_S1.Nextval
          , HC.GROUP_CODE
          , HC.CODE
          , HC.CODE_NAME    
          , HC.VALUE1
          , HC.VALUE2
          , HC.VALUE3
          , HC.VALUE4
          , HC.VALUE5
          , HC.VALUE6
          , HC.VALUE7
          , HC.VALUE8
          , HC.VALUE9
          , HC.VALUE10
          , HC.DEFAULT_FLAG
          , HC.SORT_NUM
          , HC.DESCRIPTION
          , HC.ENABLED_FLAG
          , HC.EFFECTIVE_DATE_FR
          , HC.EFFECTIVE_DATE_TO
          , 20 AS SOB_ID
          , 201 AS ORG_ID
          , TO_DATE('2010-11-15 15:10:01', 'YYYY-MM-DD HH24:MI:SS')
          , -1
          , TO_DATE('2010-11-15 15:10:01', 'YYYY-MM-DD HH24:MI:SS')
          , -1
      FROM HRM_COMMON HC
      WHERE HC.SOB_ID  = 10
        AND HC.ORG_ID  = 101
      ;
    end IF;*/
  
  end loop c1;

end;
/*
select HC.GROUP_CODE
                  , HC.CODE
                  , HC.CODE_NAME    
                  , HC.VALUE1
                  , HC.VALUE2
                  , HC.VALUE3
                  , HC.VALUE4
                  , HC.VALUE5
                  , HC.VALUE6
                  , HC.VALUE7
                  , HC.VALUE8
                  , HC.VALUE9
                  , HC.VALUE10
                  , HC.DEFAULT_FLAG
                  , HC.SORT_NUM
                  , HC.DESCRIPTION
                  , HC.ENABLED_FLAG
                  , HC.EFFECTIVE_DATE_FR
                  , HC.EFFECTIVE_DATE_TO
               from hrm_common HC
              where HC.sob_id   = 20
                and HC.org_id   = 201
                and hc.group_code = 'OT_TYPE'*/
                
