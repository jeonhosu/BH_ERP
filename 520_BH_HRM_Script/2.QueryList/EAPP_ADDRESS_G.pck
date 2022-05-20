CREATE OR REPLACE PACKAGE EAPP_ADDRESS_G
AS


-- ADDRESS_LOV_SELECT.
  PROCEDURE LU_SELECT_ADDRESS
            ( P_CURSOR3                     OUT TYPES.TCURSOR3
            , W_ADDRESS_TYPE                IN  VARCHAR2
            , W_ADDRESS                     IN  VARCHAR2
            , W_ENABLED_FLAG                IN  VARCHAR2);
            
-- ADDRESS_SELECT.
  PROCEDURE DATA_SELECT
            ( P_CURSOR                      OUT TYPES.TCURSOR
            , W_ADDRESS1                    IN  VARCHAR2
            , W_ADDRESS2                    IN  VARCHAR2
            , W_ADDRESS3                    IN  VARCHAR2);
            
-- ADDRESS_LOV_SELECT.
  PROCEDURE LU_SELECT3
            ( P_CURSOR3                     OUT TYPES.TCURSOR3
            , W_ADDRESS                     IN  VARCHAR2);



END EAPP_ADDRESS_G; 
 
/
CREATE OR REPLACE PACKAGE BODY EAPP_ADDRESS_G
AS

-- ADDRESS_LOV_SELECT.
  PROCEDURE LU_SELECT_ADDRESS
            ( P_CURSOR3                     OUT TYPES.TCURSOR3
            , W_ADDRESS_TYPE                IN  VARCHAR2
            , W_ADDRESS                     IN  VARCHAR2
            , W_ENABLED_FLAG                IN  VARCHAR2)
  AS
  BEGIN
    OPEN P_CURSOR3 FOR
      SELECT DISTINCT 
             EA.ZIP_CODE
           , EA.ADDRESS
           , NULL AS STRUCTURE_NUM
           , NULL AS STRUCTURE_NAME
        FROM EAPP_ADDRESS EA
      WHERE EA.ADDRESS_TYPE           = W_ADDRESS_TYPE
        AND (EA.ADDRESS3              LIKE W_ADDRESS || '%'
        OR   EA.ADDRESS4              LIKE W_ADDRESS || '%')
      ORDER BY EA.ZIP_CODE
      ;
  END LU_SELECT_ADDRESS;
  
  
-- ADDRESS_SELECT.
  PROCEDURE DATA_SELECT
            ( P_CURSOR                      OUT TYPES.TCURSOR
            , W_ADDRESS1                    IN  VARCHAR2
            , W_ADDRESS2                    IN  VARCHAR2
            , W_ADDRESS3                    IN  VARCHAR2)
  AS
  BEGIN
      OPEN P_CURSOR FOR
          SELECT EA.ADDRESS_ID
              , EA.ADDRESS1
              , EA.ADDRESS2
              , EA.ADDRESS3
              , EA.ADDRESS4
              , EA.ISLAND_NAME
              , EA.STRUCTURE_NAME
              , EA.ZIP_CODE
              , EA.ADDRESS
          FROM EAPP_ADDRESS EA
          WHERE EA.ADDRESS_TYPE             = 'LAND'  -- 瘤锅林家.
            AND EA.ADDRESS1                 LIKE W_ADDRESS1 || '%'
            AND EA.ADDRESS2                 LIKE W_ADDRESS2 || '%'
            AND (EA.ADDRESS3                LIKE W_ADDRESS3 || '%'
                OR EA.ADDRESS4              LIKE W_ADDRESS3 || '%')
          ORDER BY EA.ADDRESS_ID
          ;

  END DATA_SELECT;

-- ADDRESS_LOV_SELECT.
  PROCEDURE LU_SELECT3
            ( P_CURSOR3                     OUT TYPES.TCURSOR3
            , W_ADDRESS                     IN  VARCHAR2)
  AS
  BEGIN

        OPEN P_CURSOR3 FOR
            SELECT EA.ADDRESS
                , EA.ZIP_CODE
            FROM EAPP_ADDRESS EA
            WHERE EA.ADDRESS_TYPE           = 'LAND'  -- 瘤锅林家.
              AND (EA.ADDRESS3              LIKE W_ADDRESS || '%'
              OR EA.ADDRESS4                LIKE W_ADDRESS || '%')
            ORDER BY EA.ADDRESS_ID
            ;
  END LU_SELECT3;

END EAPP_ADDRESS_G; 
/
