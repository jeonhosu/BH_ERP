declare 

begin
  
  for c1 in (select FC.GROUP_CODE
                  , FC.CODE
                  , FC.CODE_NAME    
                  , FC.VALUE1
                  , FC.VALUE2
                  , FC.VALUE3
                  , FC.VALUE4
                  , FC.VALUE5
                  , FC.VALUE6
                  , FC.VALUE7
                  , FC.VALUE8
                  , FC.VALUE9
                  , FC.VALUE10
                  , FC.DEFAULT_FLAG
                  , FC.SORT_NUM
                  , FC.DESCRIPTION
                  , FC.ENABLED_FLAG
                  , FC.EFFECTIVE_DATE_FR
                  , FC.EFFECTIVE_DATE_TO
               from FI_COMMON FC
              where FC.sob_id   = 10
                and FC.org_id   = 101
             )
  loop
      UPDATE FI_COMMON FC
      SET FC.CODE_NAME             = C1.CODE_NAME
        , FC.VALUE1                = C1.VALUE1
        , FC.VALUE2                = C1.VALUE2
        , FC.VALUE3                = C1.VALUE3
        , FC.VALUE4                = C1.VALUE4
        , FC.VALUE5                = C1.VALUE5
        , FC.VALUE6                = C1.VALUE6
        , FC.VALUE7                = C1.VALUE7
        , FC.VALUE8                = C1.VALUE8
        , FC.VALUE9                = C1.VALUE9
        , FC.VALUE10               = C1.VALUE10
        , FC.DEFAULT_FLAG          = C1.DEFAULT_FLAG
        , FC.SORT_NUM              = C1.SORT_NUM
        , FC.DESCRIPTION           = C1.DESCRIPTION
        , FC.ENABLED_FLAG          = C1.ENABLED_FLAG
        , FC.EFFECTIVE_DATE_FR     = TRUNC(C1.EFFECTIVE_DATE_FR)
        , FC.EFFECTIVE_DATE_TO     = TRUNC(C1.EFFECTIVE_DATE_TO)
        , FC.LAST_UPDATE_DATE      = GET_LOCAL_DATE(FC.SOB_ID)
        , FC.LAST_UPDATED_BY       = -1
      WHERE GROUP_CODE             = C1.GROUP_CODE
        AND CODE                   = C1.CODE
        AND SOB_ID                 = 20  
        AND ORG_ID                 = 201
      ;
    
   /* IF (SQL%NOTFOUND) THEN
      DBMS_OUTPUT.PUT_LINE('INSERT : ' || C1.GROUP_CODE || ', CODE : ' || C1.CODE);
      
      INSERT INTO FI_COMMON 
      ( COMMON_ID, GROUP_CODE, CODE, CODE_NAME
      , VALUE1, VALUE2, VALUE3, VALUE4, VALUE5, VALUE6, VALUE7, VALUE8, VALUE9, VALUE10
      , DEFAULT_FLAG
      , SORT_NUM, DESCRIPTION, ENABLED_FLAG, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO
      , SOB_ID, ORG_ID
      , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY)
      SELECT FI_COMMON_S1.Nextval
          , FC.GROUP_CODE
          , FC.CODE
          , FC.CODE_NAME    
          , FC.VALUE1
          , FC.VALUE2
          , FC.VALUE3
          , FC.VALUE4
          , FC.VALUE5
          , FC.VALUE6
          , FC.VALUE7
          , FC.VALUE8
          , FC.VALUE9
          , FC.VALUE10
          , FC.DEFAULT_FLAG
          , FC.SORT_NUM
          , FC.DESCRIPTION
          , FC.ENABLED_FLAG
          , FC.EFFECTIVE_DATE_FR
          , FC.EFFECTIVE_DATE_TO
          , 20 AS SOB_ID
          , 201 AS ORG_ID
          , TO_DATE('2010-11-15 15:10:01', 'YYYY-MM-DD HH24:MI:SS')
          , -1
          , TO_DATE('2010-11-15 15:10:01', 'YYYY-MM-DD HH24:MI:SS')
          , -1
      FROM FI_COMMON HC
      WHERE FC.SOB_ID  = 10
        AND FC.ORG_ID  = 101
      ;
    end IF;*/
  
  end loop c1;

end;
/*
select FC.GROUP_CODE
                  , FC.CODE
                  , FC.CODE_NAME    
                  , FC.VALUE1
                  , FC.VALUE2
                  , FC.VALUE3
                  , FC.VALUE4
                  , FC.VALUE5
                  , FC.VALUE6
                  , FC.VALUE7
                  , FC.VALUE8
                  , FC.VALUE9
                  , FC.VALUE10
                  , FC.DEFAULT_FLAG
                  , FC.SORT_NUM
                  , FC.DESCRIPTION
                  , FC.ENABLED_FLAG
                  , FC.EFFECTIVE_DATE_FR
                  , FC.EFFECTIVE_DATE_TO
               from FI_COMMON HC
              where FC.sob_id   = 20
                and FC.org_id   = 201
                and FC.group_code = 'OT_TYPE'*/
                
