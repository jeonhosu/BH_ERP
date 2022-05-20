CREATE OR REPLACE PACKAGE FI_BUDGET_PLAN_G
AS

-- (��)����å�� ��ȸ.
  PROCEDURE SELECT_BUDGET_PLAN_YEAR
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_BUDGET_YEAR          IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE            
            , W_DEPT_CODE_FR         IN VARCHAR2
            , W_DEPT_CODE_TO         IN VARCHAR2
            , W_ACCOUNT_CODE_FR      IN FI_BUDGET_ACCOUNT.ACCOUNT_CODE%TYPE
            , W_ACCOUNT_CODE_TO      IN FI_BUDGET_ACCOUNT.ACCOUNT_CODE%TYPE
            , W_APPROVE_STATUS       IN FI_BUDGET_PLAN_YEAR.APPROVE_STATUS%TYPE
            , W_ALL_RECORD_FLAG      IN VARCHAR2
            , P_CONNECT_PERSON_ID    IN NUMBER
            , P_SOB_ID               IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            );

-- (��)����å�� ����.
  PROCEDURE INSERT_BUDGET_PLAN_YEAR
            ( P_BUDGET_YEAR        IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , P_DEPT_ID            IN FI_BUDGET_PLAN_YEAR.DEPT_ID%TYPE
            , P_ACCOUNT_CONTROL_ID IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID%TYPE
            , P_ACCOUNT_CODE       IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CODE%TYPE
            , P_SOB_ID             IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            , P_ORG_ID             IN FI_BUDGET_PLAN_YEAR.ORG_ID%TYPE
            , P_YEAR_AMOUNT        IN FI_BUDGET_PLAN_YEAR.YEAR_AMOUNT%TYPE
            , P_DESCRIPTION        IN FI_BUDGET_PLAN_YEAR.DESCRIPTION%TYPE
            , P_USER_ID            IN FI_BUDGET_PLAN_YEAR.CREATED_BY%TYPE 
            , O_SAVE_SEQ           OUT FI_BUDGET_PLAN_YEAR.SAVE_SEQ%TYPE
            , O_APPROVE_STATUS     OUT FI_BUDGET_PLAN_YEAR.APPROVE_STATUS%TYPE
            , O_APPROVE_STATUS_NAME  OUT VARCHAR2
            );

-- (��)����å�� ����.
  PROCEDURE UPDATE_BUDGET_PLAN_YEAR
            ( W_BUDGET_YEAR        IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_ID            IN FI_BUDGET_PLAN_YEAR.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID             IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            , P_ORG_ID             IN FI_BUDGET_PLAN_YEAR.ORG_ID%TYPE
            , P_YEAR_AMOUNT        IN FI_BUDGET_PLAN_YEAR.YEAR_AMOUNT%TYPE
            , P_DESCRIPTION        IN FI_BUDGET_PLAN_YEAR.DESCRIPTION%TYPE
            , P_USER_ID            IN FI_BUDGET_PLAN_YEAR.CREATED_BY%TYPE 
            );

-- (��)������ ����.
  PROCEDURE DELETE_BUDGET_PLAN
            ( W_BUDGET_YEAR        IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_ID            IN FI_BUDGET_PLAN_YEAR.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID             IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            , P_ORG_ID             IN FI_BUDGET_PLAN_YEAR.ORG_ID%TYPE 
            );

-----------------------------------------------------------------------------------------
-- (��)����å�� --> ��� ��ȸ(���� ��������).
  PROCEDURE SELECT_MONTH_HEADER
            ( P_CURSOR2              OUT TYPES.TCURSOR2
            , W_BUDGET_YEAR          IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE            
            , W_SOB_ID               IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            );
            
-- (��)����å�� --> ���� ���� �ݾ� ��ȸ.
  PROCEDURE SELECT_BUDGET_PLAN_MONTH
            ( P_CURSOR1              OUT TYPES.TCURSOR1
            , W_BUDGET_YEAR          IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_CODE_FR         IN VARCHAR2
            , W_DEPT_CODE_TO         IN VARCHAR2
            , W_ACCOUNT_CODE_FR      IN FI_BUDGET_ACCOUNT.ACCOUNT_CODE%TYPE
            , W_ACCOUNT_CODE_TO      IN FI_BUDGET_ACCOUNT.ACCOUNT_CODE%TYPE
            , W_APPROVE_STATUS       IN FI_BUDGET_PLAN_YEAR.APPROVE_STATUS%TYPE
            , W_ALL_RECORD_FLAG      IN VARCHAR2
            , P_CONNECT_PERSON_ID    IN NUMBER
            , P_SOB_ID               IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            );
            
-- (��) ���� �� --> (��) ���� ����.
  PROCEDURE INSERT_BUDGET_PLAN_MONTH
            ( P_BUDGET_YEAR        IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , P_DEPT_ID            IN FI_BUDGET_PLAN_MONTH.DEPT_ID%TYPE
            , P_ACCOUNT_CONTROL_ID IN FI_BUDGET_PLAN_MONTH.ACCOUNT_CONTROL_ID%TYPE
            , P_SOB_ID             IN FI_BUDGET_PLAN_MONTH.SOB_ID%TYPE
            , P_MONTH_1            IN NUMBER
            , P_MONTH_2            IN NUMBER
            , P_MONTH_3            IN NUMBER
            , P_MONTH_4            IN NUMBER
            , P_MONTH_5            IN NUMBER
            , P_MONTH_6            IN NUMBER
            , P_MONTH_7            IN NUMBER
            , P_MONTH_8            IN NUMBER
            , P_MONTH_9            IN NUMBER
            , P_MONTH_10           IN NUMBER
            , P_MONTH_11           IN NUMBER
            , P_MONTH_12           IN NUMBER
            , P_USER_ID            IN NUMBER
            , O_SAVE_SEQ           OUT NUMBER
            );
            
-- (��) ���� �� --> (��) ���� ����.
  PROCEDURE UPDATE_BUDGET_PLAN_MONTH
            ( W_BUDGET_YEAR        IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_ID            IN FI_BUDGET_PLAN_YEAR.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID             IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            , P_MONTH_1            IN NUMBER
            , P_MONTH_2            IN NUMBER
            , P_MONTH_3            IN NUMBER
            , P_MONTH_4            IN NUMBER
            , P_MONTH_5            IN NUMBER
            , P_MONTH_6            IN NUMBER
            , P_MONTH_7            IN NUMBER
            , P_MONTH_8            IN NUMBER
            , P_MONTH_9            IN NUMBER
            , P_MONTH_10           IN NUMBER
            , P_MONTH_11           IN NUMBER
            , P_MONTH_12           IN NUMBER
            , P_USER_ID            IN NUMBER
            );

-- (��) ���� ����.
  PROCEDURE DELETE_BUDGET_PLAN_MONTH
            ( W_BUDGET_YEAR        IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_ID            IN FI_BUDGET_PLAN_YEAR.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID             IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            , P_ORG_ID             IN FI_BUDGET_PLAN_YEAR.ORG_ID%TYPE 
            );

-----------------------------------------------------------------------------------------  
-- (��)����å�� ���ΰ��� ��ȸ.
  PROCEDURE SELECT_PLAN_YEAR_APPROVE
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_BUDGET_YEAR          IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE            
            , W_DEPT_CODE_FR         IN VARCHAR2
            , W_DEPT_CODE_TO         IN VARCHAR2
            , W_ACCOUNT_CODE_FR      IN FI_BUDGET_ACCOUNT.ACCOUNT_CODE%TYPE
            , W_ACCOUNT_CODE_TO      IN FI_BUDGET_ACCOUNT.ACCOUNT_CODE%TYPE
            , W_APPROVE_STATUS       IN FI_BUDGET_PLAN_YEAR.APPROVE_STATUS%TYPE
            , W_ALL_RECORD_FLAG      IN VARCHAR2
            , P_CONNECT_PERSON_ID    IN NUMBER
            , P_SOB_ID               IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            );

-- (��)����å�� --> ���� ���� �ݾ� ��ȸ.
  PROCEDURE SELECT_PLAN_MONTH_APPROVE
            ( P_CURSOR1              OUT TYPES.TCURSOR1
            , W_BUDGET_YEAR          IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_CODE_FR         IN VARCHAR2
            , W_DEPT_CODE_TO         IN VARCHAR2
            , W_ACCOUNT_CODE_FR      IN FI_BUDGET_ACCOUNT.ACCOUNT_CODE%TYPE
            , W_ACCOUNT_CODE_TO      IN FI_BUDGET_ACCOUNT.ACCOUNT_CODE%TYPE
            , W_APPROVE_STATUS       IN FI_BUDGET_PLAN_YEAR.APPROVE_STATUS%TYPE
            , W_ALL_RECORD_FLAG      IN VARCHAR2
            , P_CONNECT_PERSON_ID    IN NUMBER
            , P_SOB_ID               IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            );

-- ������ ������ ������ VERSION ���� - ����.
  PROCEDURE INSERT_PLAN_MONTH_APPROVE
            ( W_BUDGET_YEAR        IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_ID            IN FI_BUDGET_PLAN_YEAR.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID             IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            , P_USER_ID            IN FI_BUDGET_PLAN_YEAR.CREATED_BY%TYPE
            , O_SAVE_SEQ           OUT FI_BUDGET_PLAN_YEAR.SAVE_SEQ%TYPE
            );
            
-- (��) ���� �� --> (��) ���� ������ ����.
  PROCEDURE UPDATE_PLAN_MONTH_APPROVE
            ( W_BUDGET_YEAR        IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_ID            IN FI_BUDGET_PLAN_YEAR.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID             IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            , W_SAVE_SEQ           IN NUMBER
            , P_MONTH_1            IN NUMBER
            , P_MONTH_2            IN NUMBER
            , P_MONTH_3            IN NUMBER
            , P_MONTH_4            IN NUMBER
            , P_MONTH_5            IN NUMBER
            , P_MONTH_6            IN NUMBER
            , P_MONTH_7            IN NUMBER
            , P_MONTH_8            IN NUMBER
            , P_MONTH_9            IN NUMBER
            , P_MONTH_10           IN NUMBER
            , P_MONTH_11           IN NUMBER
            , P_MONTH_12           IN NUMBER
            , P_CONNECT_PERSON_ID  IN NUMBER
            , P_USER_ID            IN NUMBER
            );
            
-----------------------------------------------------------------------------------------
-- ������ ���� - ���� ���� ����.
  PROCEDURE UPDATE_STATUS_APPROVE
            ( W_BUDGET_YEAR         IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_ID             IN FI_BUDGET_PLAN_YEAR.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID  IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID              IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            , P_CONNECT_PERSON_ID   IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , P_APPROVE_STATUS      IN FI_BUDGET_PLAN_YEAR.APPROVE_STATUS%TYPE
            , P_APPROVE_FLAG        IN VARCHAR2
            , P_CHECK_YN            IN VARCHAR2
            , P_USER_ID             IN FI_BUDGET_PLAN_YEAR.CREATED_BY%TYPE
            );
            
--�����û ���ο�û ó��.
  PROCEDURE UPDATE_STATUS_REQUEST
            ( W_BUDGET_YEAR         IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_CODE_FR        IN VARCHAR2
            , W_DEPT_CODE_TO        IN VARCHAR2
            , W_ACCOUNT_CODE_FR     IN VARCHAR2
            , W_ACCOUNT_CODE_TO     IN VARCHAR2
            , W_SOB_ID              IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            , P_CONNECT_PERSON_ID   IN NUMBER
            , P_USER_ID             IN FI_BUDGET_PLAN_YEAR.CREATED_BY%TYPE
            , O_MESSAGE              OUT VARCHAR2
            );
            
-----------------------------------------------------------------------------------------                        
-- (��)����å�� -> ���� ������� ó��.
  PROCEDURE EXE_BUDGET_PERIOD
            ( W_BUDGET_YEAR          IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_CODE_FR         IN VARCHAR2
            , W_DEPT_CODE_TO         IN VARCHAR2
            , W_ACCOUNT_CODE_FR      IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CODE%TYPE
            , W_ACCOUNT_CODE_TO      IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CODE%TYPE
            , W_SOB_ID               IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            , P_USER_ID              IN FI_BUDGET_PLAN_YEAR.CREATED_BY%TYPE
            , O_MESSAGE              OUT VARCHAR2
            );

-- (��)����å�� Ȯ�� ó��.
  PROCEDURE EXE_BUDGET_PLAN_YEAR_CONFIRM
            ( W_BUDGET_YEAR         IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_ID             IN FI_BUDGET_PLAN_YEAR.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID  IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID              IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            , P_APPROVE_FLAG        IN VARCHAR2
            , P_CONNECT_PERSON_ID   IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , P_USER_ID             IN FI_BUDGET_PLAN_YEAR.CREATED_BY%TYPE
            , O_MESSAGE             OUT VARCHAR2
            );
            
-- (��)����å�� ���� ó��.
  PROCEDURE EXE_BUDGET_PLAN_YEAR_CLOSE
            ( W_BUDGET_YEAR          IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_ID              IN FI_BUDGET_PLAN_YEAR.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID   IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID               IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            , P_APPROVE_FLAG         IN VARCHAR2
            , P_CONNECT_PERSON_ID    IN FI_BUDGET_PLAN_YEAR.CLOSED_PERSON_ID%TYPE
            , P_USER_ID              IN FI_BUDGET_PLAN_YEAR.CREATED_BY%TYPE
            , O_MESSAGE              OUT VARCHAR2
            );

-- (��) ���������� �ϰ� (��)������� ����.
  PROCEDURE SAVE_BUDGET_PLAN_MONTH
            ( P_BUDGET_PERIOD      IN FI_BUDGET_PLAN_MONTH.BUDGET_PERIOD%TYPE
            , P_DEPT_ID            IN FI_BUDGET_PLAN_MONTH.DEPT_ID%TYPE
            , P_ACCOUNT_CONTROL_ID IN FI_BUDGET_PLAN_MONTH.ACCOUNT_CONTROL_ID%TYPE
            , P_ACCOUNT_CODE       IN FI_BUDGET_PLAN_MONTH.ACCOUNT_CODE%TYPE
            , P_SOB_ID             IN FI_BUDGET_PLAN_MONTH.SOB_ID%TYPE
            , P_ORG_ID             IN FI_BUDGET_PLAN_MONTH.ORG_ID%TYPE
            , P_CREATE_SEQ         IN FI_BUDGET_PLAN_MONTH.CREATE_SEQ%TYPE
            , P_BUDGET_PERIOD_FR   IN FI_BUDGET_PLAN_MONTH.BUDGET_PERIOD%TYPE
            , P_BUDGET_PERIOD_TO   IN FI_BUDGET_PLAN_MONTH.BUDGET_PERIOD%TYPE
            , P_BASE_AMOUNT        IN FI_BUDGET_PLAN_MONTH.BASE_AMOUNT%TYPE
            , P_BASE_MONTH_YN      IN FI_BUDGET_PLAN_MONTH.BASE_MONTH_YN%TYPE
            , P_ENABLED_YN         IN FI_BUDGET_PLAN_MONTH.ENABLED_YN%TYPE            
            , P_DESCRIPTION        IN FI_BUDGET_PLAN_MONTH.DESCRIPTION%TYPE
            , P_USER_ID            IN FI_BUDGET_PLAN_MONTH.CREATED_BY%TYPE 
            );

-- (��)������ ����/����.
  PROCEDURE SAVE_BUDGET_PLAN_YEAR
            ( P_BUDGET_YEAR        IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , P_DEPT_ID            IN FI_BUDGET_PLAN_YEAR.DEPT_ID%TYPE
            , P_ACCOUNT_CONTROL_ID IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID%TYPE
            , P_SAVE_SEQ           IN FI_BUDGET_PLAN_YEAR.SAVE_SEQ%TYPE
            , P_SOB_ID             IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            , P_USER_ID            IN FI_BUDGET_PLAN_YEAR.CREATED_BY%TYPE 
            );
            
-- (��)���� å�� Ȯ�� ���� üũ.
  FUNCTION BUDGET_CONFIRM_F
            ( W_BUDGET_YEAR          IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_ID              IN FI_BUDGET_PLAN_YEAR.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID   IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID               IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            ) RETURN VARCHAR2;
                        
-- (��)���� å�� �̸��� ���� üũ.
  FUNCTION BUDGET_CLOSED_F
            ( W_BUDGET_YEAR          IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_ID              IN FI_BUDGET_PLAN_YEAR.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID   IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID               IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            ) RETURN VARCHAR2;

-- (��)���� �� : ������ ���� �Ϸù�ȣ ����.
  FUNCTION BUDGET_SAVE_SEQ_F
            ( W_BUDGET_YEAR          IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_ID              IN FI_BUDGET_PLAN_YEAR.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID   IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID               IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            ) RETURN NUMBER;
            
END FI_BUDGET_PLAN_G;
/
CREATE OR REPLACE PACKAGE BODY FI_BUDGET_PLAN_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FI
/* Program Name : FI_BUDGET_PLAN_G
/* Description  : �� ���� å�� �� �� ������� ����.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- ����å�� ��ȸ.
  PROCEDURE SELECT_BUDGET_PLAN_YEAR
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_BUDGET_YEAR          IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE            
            , W_DEPT_CODE_FR         IN VARCHAR2
            , W_DEPT_CODE_TO         IN VARCHAR2
            , W_ACCOUNT_CODE_FR      IN FI_BUDGET_ACCOUNT.ACCOUNT_CODE%TYPE
            , W_ACCOUNT_CODE_TO      IN FI_BUDGET_ACCOUNT.ACCOUNT_CODE%TYPE
            , W_APPROVE_STATUS       IN FI_BUDGET_PLAN_YEAR.APPROVE_STATUS%TYPE
            , W_ALL_RECORD_FLAG      IN VARCHAR2
            , P_CONNECT_PERSON_ID    IN NUMBER
            , P_SOB_ID               IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            )
  AS
    V_CAP_LEVEL                      VARCHAR2(2) := 'N';     --     
  BEGIN
    IF FI_BUDGET_CONTROL_G.BUDGET_MANAGER_CAP_F(P_CONNECT_PERSON_ID, P_SOB_ID) = 'Y' THEN
      V_CAP_LEVEL := 'Y';
    END IF;
    OPEN P_CURSOR FOR
      SELECT BPY.BUDGET_YEAR
           , DM.DEPT_NAME AS DEPT_NAME
           , DM.DEPT_CODE
           , BPY.DEPT_ID
           , BPY.ACCOUNT_CONTROL_ID
           , FI_ACCOUNT_CONTROL_G.ACCOUNT_DESC_F(BPY.ACCOUNT_CONTROL_ID, BPY.SOB_ID) AS ACCOUNT_DESC
           , BPY.ACCOUNT_CODE
           , BPY.SAVE_SEQ
           , BPY.YEAR_AMOUNT
           , BPY.DESCRIPTION
           , BPY.APPROVE_STATUS
           , FI_COMMON_G.CODE_NAME_F('BUDGET_CAPACITY', BPY.APPROVE_STATUS, BPY.SOB_ID) AS APPROVE_STATUS_NAME
           , BPY.CONFIRMED_YN
           , BPY.CLOSED_YN
        FROM FI_BUDGET_PLAN_YEAR BPY
          , FI_DEPT_MASTER DM
       WHERE BPY.DEPT_ID            = DM.DEPT_ID
         AND BPY.SOB_ID             = DM.SOB_ID
         AND BPY.BUDGET_YEAR        = W_BUDGET_YEAR
         AND DM.DEPT_CODE           BETWEEN NVL(W_DEPT_CODE_FR, DM.DEPT_CODE) AND NVL(W_DEPT_CODE_TO, DM.DEPT_CODE)
         AND BPY.ACCOUNT_CODE       BETWEEN NVL(W_ACCOUNT_CODE_FR, BPY.ACCOUNT_CODE) AND NVL(W_ACCOUNT_CODE_TO, BPY.ACCOUNT_CODE)
         AND BPY.SOB_ID             = P_SOB_ID
         AND BPY.APPROVE_STATUS     = NVL(W_APPROVE_STATUS, BPY.APPROVE_STATUS)
         AND BPY.LAST_YN            = DECODE(W_ALL_RECORD_FLAG, 'Y', BPY.LAST_YN, 'Y')
         AND EXISTS 
              ( SELECT 'X'
                  FROM FI_BUDGET_CONTROL BC
                WHERE BC.DEPT_ID        = BPY.DEPT_ID
                  AND BC.SOB_ID         = BPY.SOB_ID
                  AND BC.PERSON_ID      = DECODE(V_CAP_LEVEL, 'Y', BC.PERSON_ID, P_CONNECT_PERSON_ID)
                  AND BC.EFFECTIVE_DATE_FR  <= LAST_DAY(TRUNC(TO_DATE(W_BUDGET_YEAR || '-01', 'YYYY-MM')))
                  AND (BC.EFFECTIVE_DATE_TO IS NULL OR BC.EFFECTIVE_DATE_TO >= TRUNC(TO_DATE(W_BUDGET_YEAR || '-12', 'YYYY-MM')))
              )
       ORDER BY DM.DEPT_CODE, BPY.ACCOUNT_CODE, BPY.SAVE_SEQ
       ;
  END SELECT_BUDGET_PLAN_YEAR;

-- ����å�� ����.
  PROCEDURE INSERT_BUDGET_PLAN_YEAR
            ( P_BUDGET_YEAR        IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , P_DEPT_ID            IN FI_BUDGET_PLAN_YEAR.DEPT_ID%TYPE
            , P_ACCOUNT_CONTROL_ID IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID%TYPE
            , P_ACCOUNT_CODE       IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CODE%TYPE
            , P_SOB_ID             IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            , P_ORG_ID             IN FI_BUDGET_PLAN_YEAR.ORG_ID%TYPE
            , P_YEAR_AMOUNT        IN FI_BUDGET_PLAN_YEAR.YEAR_AMOUNT%TYPE
            , P_DESCRIPTION        IN FI_BUDGET_PLAN_YEAR.DESCRIPTION%TYPE
            , P_USER_ID            IN FI_BUDGET_PLAN_YEAR.CREATED_BY%TYPE 
            , O_SAVE_SEQ           OUT FI_BUDGET_PLAN_YEAR.SAVE_SEQ%TYPE
            , O_APPROVE_STATUS     OUT FI_BUDGET_PLAN_YEAR.APPROVE_STATUS%TYPE
            , O_APPROVE_STATUS_NAME  OUT VARCHAR2
            )
  AS
    V_SYSDATE       DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_RECORD_COUNT  NUMBER := 0;
  BEGIN
    -- ������ ���� å������ ���� üũ.
    O_SAVE_SEQ := 1;
    BEGIN
      SELECT COUNT(BPY.ACCOUNT_CONTROL_ID) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_BUDGET_PLAN_YEAR BPY
       WHERE BPY.BUDGET_YEAR        = P_BUDGET_YEAR
         AND BPY.DEPT_ID            = P_DEPT_ID
         AND BPY.ACCOUNT_CONTROL_ID = P_ACCOUNT_CONTROL_ID
         AND BPY.SOB_ID             = P_SOB_ID
         AND BPY.SAVE_SEQ           = O_SAVE_SEQ
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT <> 0 THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Data_Code, ERRNUMS.Exist_Data_Desc);
    END IF;

    INSERT INTO FI_BUDGET_PLAN_YEAR
    ( BUDGET_YEAR
    , DEPT_ID 
    , ACCOUNT_CONTROL_ID 
    , ACCOUNT_CODE 
    , SOB_ID 
    , ORG_ID 
    , SAVE_SEQ
    , YEAR_AMOUNT 
    , DESCRIPTION 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_BUDGET_YEAR
    , P_DEPT_ID
    , P_ACCOUNT_CONTROL_ID
    , P_ACCOUNT_CODE
    , P_SOB_ID
    , P_ORG_ID
    , O_SAVE_SEQ
    , P_YEAR_AMOUNT
    , P_DESCRIPTION
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );
    
    O_APPROVE_STATUS := 'N';
    BEGIN
      SELECT BPY.APPROVE_STATUS
          , FI_COMMON_G.CODE_NAME_F('BUDGET_CAPACITY', BPY.APPROVE_STATUS, BPY.SOB_ID) AS APPROVE_STATUS_NAME 
        INTO O_APPROVE_STATUS
          , O_APPROVE_STATUS_NAME
        FROM FI_BUDGET_PLAN_YEAR BPY
      WHERE BPY.BUDGET_YEAR         = P_BUDGET_YEAR
        AND BPY.DEPT_ID             = P_DEPT_ID
        AND BPY.ACCOUNT_CONTROL_ID  = P_ACCOUNT_CONTROL_ID
        AND BPY.SOB_ID              = P_SOB_ID
        AND BPY.LAST_YN             = 'Y'
      ;   
    EXCEPTION WHEN OTHERS THEN
      O_APPROVE_STATUS_NAME := FI_COMMON_G.CODE_NAME_F('BUDGET_CAPACITY', O_APPROVE_STATUS, P_SOB_ID);
    END;
  END INSERT_BUDGET_PLAN_YEAR;

-- ����å�� ����.
  PROCEDURE UPDATE_BUDGET_PLAN_YEAR
            ( W_BUDGET_YEAR        IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_ID            IN FI_BUDGET_PLAN_YEAR.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID             IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            , P_ORG_ID             IN FI_BUDGET_PLAN_YEAR.ORG_ID%TYPE
            , P_YEAR_AMOUNT        IN FI_BUDGET_PLAN_YEAR.YEAR_AMOUNT%TYPE
            , P_DESCRIPTION        IN FI_BUDGET_PLAN_YEAR.DESCRIPTION%TYPE
            , P_USER_ID            IN FI_BUDGET_PLAN_YEAR.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE           DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_SAVE_SEQ          NUMBER := 0;
  BEGIN
    IF BUDGET_CONFIRM_F
         ( W_BUDGET_YEAR
          , W_DEPT_ID
          , W_ACCOUNT_CONTROL_ID
          , W_SOB_ID
         ) = 'Y' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10115', NULL));
      RETURN;
    END IF;
    
    -- SAVE SEQ üũ.
    V_SAVE_SEQ := BUDGET_SAVE_SEQ_F(W_BUDGET_YEAR, W_DEPT_ID, W_ACCOUNT_CONTROL_ID, W_SOB_ID);    
    IF V_SAVE_SEQ <> 1 THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10115', NULL));
    END IF;
    
    UPDATE FI_BUDGET_PLAN_YEAR BPY
      SET YEAR_AMOUNT        = P_YEAR_AMOUNT
        , DESCRIPTION        = P_DESCRIPTION
        , LAST_UPDATE_DATE   = V_SYSDATE
        , LAST_UPDATED_BY    = P_USER_ID
    WHERE BPY.BUDGET_YEAR        = W_BUDGET_YEAR
      AND BPY.DEPT_ID            = W_DEPT_ID
      AND BPY.ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID
      AND BPY.SOB_ID             = W_SOB_ID
      AND BPY.LAST_YN            = 'Y'
    ;
  END UPDATE_BUDGET_PLAN_YEAR;

-- (��)������ ����.
  PROCEDURE DELETE_BUDGET_PLAN
            ( W_BUDGET_YEAR        IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_ID            IN FI_BUDGET_PLAN_YEAR.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID             IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            , P_ORG_ID             IN FI_BUDGET_PLAN_YEAR.ORG_ID%TYPE 
            )
  AS
    V_PERIOD_FR                      DATE;
    V_PERIOD_TO                      DATE;
    V_SAVE_SEQ                       NUMBER := 0;
  BEGIN
    IF BUDGET_CONFIRM_F
         ( W_BUDGET_YEAR
          , W_DEPT_ID
          , W_ACCOUNT_CONTROL_ID
          , W_SOB_ID
         ) = 'Y' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10115', NULL));
      RETURN;
    END IF;
    
    -- SAVE SEQ üũ.
    V_SAVE_SEQ := BUDGET_SAVE_SEQ_F(W_BUDGET_YEAR, W_DEPT_ID, W_ACCOUNT_CONTROL_ID, W_SOB_ID);    
    IF V_SAVE_SEQ <> 1 THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10115', NULL));
    END IF;
    
    BEGIN
      -- (��)���� ����.
      DELETE FROM FI_BUDGET_PLAN_YEAR BPY
      WHERE BPY.BUDGET_YEAR        = W_BUDGET_YEAR
        AND BPY.DEPT_ID            = W_DEPT_ID
        AND BPY.ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID
        AND BPY.SOB_ID             = W_SOB_ID
      ;
      
      DELETE_BUDGET_PLAN_MONTH
        ( W_BUDGET_YEAR
        , W_DEPT_ID
        , W_ACCOUNT_CONTROL_ID
        , W_SOB_ID
        , P_ORG_ID 
        );
    EXCEPTION WHEN OTHERS THEN
      ROLLBACK;
      RAISE_APPLICATION_ERROR(-20001, SUBSTR(SQLERRM, 1, 150));
    END;
  END DELETE_BUDGET_PLAN;
            
-----------------------------------------------------------------------------------------
-- (��)����å�� --> ��� ��ȸ(���� ��������).
  PROCEDURE SELECT_MONTH_HEADER
            ( P_CURSOR2              OUT TYPES.TCURSOR2
            , W_BUDGET_YEAR          IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE            
            , W_SOB_ID               IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            )
  AS
    V_PERIOD_FR                      DATE;
    V_PERIOD_TO                      DATE;
  BEGIN
    GL_FISCAL_YEAR_G.FISCAL_YEAR_DATE_P(W_BUDGET_YEAR, W_SOB_ID, V_PERIOD_FR, V_PERIOD_TO);
    
    OPEN P_CURSOR2 FOR
      SELECT MAX(DECODE(ROWNUM, 1, CY.YYYYMM, NULL)) AS MONTH_1
           , MAX(DECODE(ROWNUM, 2, CY.YYYYMM, NULL)) AS MONTH_2
           , MAX(DECODE(ROWNUM, 3, CY.YYYYMM, NULL)) AS MONTH_3
           , MAX(DECODE(ROWNUM, 4, CY.YYYYMM, NULL)) AS MONTH_4
           , MAX(DECODE(ROWNUM, 5, CY.YYYYMM, NULL)) AS MONTH_5
           , MAX(DECODE(ROWNUM, 6, CY.YYYYMM, NULL)) AS MONTH_6
           , MAX(DECODE(ROWNUM, 7, CY.YYYYMM, NULL)) AS MONTH_7
           , MAX(DECODE(ROWNUM, 8, CY.YYYYMM, NULL)) AS MONTH_8
           , MAX(DECODE(ROWNUM, 9, CY.YYYYMM, NULL)) AS MONTH_9
           , MAX(DECODE(ROWNUM, 10, CY.YYYYMM, NULL)) AS MONTH_10
           , MAX(DECODE(ROWNUM, 11, CY.YYYYMM, NULL)) AS MONTH_11
           , MAX(DECODE(ROWNUM, 12, CY.YYYYMM, NULL)) AS MONTH_12
           , EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10045', NULL) AS YEAR_TOTAL
        FROM EAPP_CALENDAR_YYYYMM_V CY
      WHERE CY.YYYYMM               BETWEEN TO_CHAR(V_PERIOD_FR, 'YYYY-MM') AND TO_CHAR(V_PERIOD_TO, 'YYYY-MM')
      ORDER BY CY.YYYYMM
      ;
  END SELECT_MONTH_HEADER;
  
-- (��)����å�� --> ���� ���� �ݾ� ��ȸ.
  PROCEDURE SELECT_BUDGET_PLAN_MONTH
            ( P_CURSOR1              OUT TYPES.TCURSOR1
            , W_BUDGET_YEAR          IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_CODE_FR         IN VARCHAR2
            , W_DEPT_CODE_TO         IN VARCHAR2
            , W_ACCOUNT_CODE_FR      IN FI_BUDGET_ACCOUNT.ACCOUNT_CODE%TYPE
            , W_ACCOUNT_CODE_TO      IN FI_BUDGET_ACCOUNT.ACCOUNT_CODE%TYPE
            , W_APPROVE_STATUS       IN FI_BUDGET_PLAN_YEAR.APPROVE_STATUS%TYPE
            , W_ALL_RECORD_FLAG      IN VARCHAR2
            , P_CONNECT_PERSON_ID    IN NUMBER
            , P_SOB_ID               IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            )
  AS
    V_PERIOD_FR                      DATE;
    V_PERIOD_TO                      DATE;
    V_CAP_LEVEL                      VARCHAR2(2) := 'N';
  BEGIN
    IF FI_BUDGET_CONTROL_G.BUDGET_MANAGER_CAP_F(P_CONNECT_PERSON_ID, P_SOB_ID) = 'Y' THEN
      V_CAP_LEVEL := 'Y';
    END IF;
    
    GL_FISCAL_YEAR_G.FISCAL_YEAR_DATE_P(W_BUDGET_YEAR, P_SOB_ID, V_PERIOD_FR, V_PERIOD_TO);
    OPEN P_CURSOR1 FOR
      SELECT DM.DEPT_NAME
           , DM.DEPT_CODE
           , DM.DEPT_ID
           , BPM.ACCOUNT_CONTROL_ID
           , FI_ACCOUNT_CONTROL_G.ACCOUNT_DESC_F(BPM.ACCOUNT_CONTROL_ID, BPM.SOB_ID) AS ACCOUNT_DESC
           , BPM.ACCOUNT_CODE
           , BPM.SAVE_SEQ AS SAVE_SEQ
           , MAX(DECODE(BPM.CREATE_SEQ, 1, BPM.BASE_AMOUNT, 0)) AS MONTH_1
           , MAX(DECODE(BPM.CREATE_SEQ, 2, BPM.BASE_AMOUNT, 0)) AS MONTH_2
           , MAX(DECODE(BPM.CREATE_SEQ, 3, BPM.BASE_AMOUNT, 0)) AS MONTH_3
           , MAX(DECODE(BPM.CREATE_SEQ, 4, BPM.BASE_AMOUNT, 0)) AS MONTH_4
           , MAX(DECODE(BPM.CREATE_SEQ, 5, BPM.BASE_AMOUNT, 0)) AS MONTH_5
           , MAX(DECODE(BPM.CREATE_SEQ, 6, BPM.BASE_AMOUNT, 0)) AS MONTH_6
           , MAX(DECODE(BPM.CREATE_SEQ, 7, BPM.BASE_AMOUNT, 0)) AS MONTH_7
           , MAX(DECODE(BPM.CREATE_SEQ, 8, BPM.BASE_AMOUNT, 0)) AS MONTH_8
           , MAX(DECODE(BPM.CREATE_SEQ, 9, BPM.BASE_AMOUNT, 0)) AS MONTH_9
           , MAX(DECODE(BPM.CREATE_SEQ, 10, BPM.BASE_AMOUNT, 0)) AS MONTH_10
           , MAX(DECODE(BPM.CREATE_SEQ, 11, BPM.BASE_AMOUNT, 0)) AS MONTH_11
           , MAX(DECODE(BPM.CREATE_SEQ, 12, BPM.BASE_AMOUNT, 0)) AS MONTH_12
           , SUM(BPM.BASE_AMOUNT) AS YEAR_TOTAL
           , MAX(DECODE(BPM.CREATE_SEQ, 1, BPM.BASE_MONTH_YN, 'N')) AS MONTH_1_YN     
           , MAX(DECODE(BPM.CREATE_SEQ, 2, BPM.BASE_MONTH_YN, 'N')) AS MONTH_2_YN
           , MAX(DECODE(BPM.CREATE_SEQ, 3, BPM.BASE_MONTH_YN, 'N')) AS MONTH_3_YN
           , MAX(DECODE(BPM.CREATE_SEQ, 4, BPM.BASE_MONTH_YN, 'N')) AS MONTH_4_YN
           , MAX(DECODE(BPM.CREATE_SEQ, 5, BPM.BASE_MONTH_YN, 'N')) AS MONTH_5_YN
           , MAX(DECODE(BPM.CREATE_SEQ, 6, BPM.BASE_MONTH_YN, 'N')) AS MONTH_6_YN
           , MAX(DECODE(BPM.CREATE_SEQ, 7, BPM.BASE_MONTH_YN, 'N')) AS MONTH_7_YN
           , MAX(DECODE(BPM.CREATE_SEQ, 8, BPM.BASE_MONTH_YN, 'N')) AS MONTH_8_YN
           , MAX(DECODE(BPM.CREATE_SEQ, 9, BPM.BASE_MONTH_YN, 'N')) AS MONTH_9_YN
           , MAX(DECODE(BPM.CREATE_SEQ, 10, BPM.BASE_MONTH_YN, 'N')) AS MONTH_10_YN
           , MAX(DECODE(BPM.CREATE_SEQ, 11, BPM.BASE_MONTH_YN, 'N')) AS MONTH_11_YN
           , MAX(DECODE(BPM.CREATE_SEQ, 12, BPM.BASE_MONTH_YN, 'N')) AS MONTH_12_YN
           , 'N' AS YEAR_TOTAL_YN
           , BPM.APPROVE_STATUS
        FROM FI_BUDGET_PLAN_MONTH BPM
          , FI_DEPT_MASTER DM
      WHERE BPM.DEPT_ID                 = DM.DEPT_ID
        AND BPM.BUDGET_PERIOD           BETWEEN TO_CHAR(V_PERIOD_FR, 'YYYY-MM') AND TO_CHAR(V_PERIOD_TO, 'YYYY-MM')
        AND BPM.ACCOUNT_CODE            BETWEEN NVL(W_ACCOUNT_CODE_FR, BPM.ACCOUNT_CODE) AND NVL(W_ACCOUNT_CODE_TO, BPM.ACCOUNT_CODE)
        AND BPM.SOB_ID                  = P_SOB_ID 
        AND DM.DEPT_CODE                BETWEEN NVL(W_DEPT_CODE_FR, DM.DEPT_CODE) AND NVL(W_DEPT_CODE_TO, DM.DEPT_CODE)
        AND BPM.APPROVE_STATUS          = NVL(W_APPROVE_STATUS, BPM.APPROVE_STATUS)
        AND BPM.LAST_YN                 = DECODE(W_ALL_RECORD_FLAG, 'Y', BPM.LAST_YN, 'Y')
        AND EXISTS 
              ( SELECT 'X'
                  FROM FI_BUDGET_CONTROL BC
                WHERE BC.DEPT_ID        = BPM.DEPT_ID
                  AND BC.SOB_ID         = BPM.SOB_ID
                  AND BC.PERSON_ID      = DECODE(V_CAP_LEVEL, 'Y', BC.PERSON_ID, P_CONNECT_PERSON_ID)
                  AND BC.EFFECTIVE_DATE_FR  <= LAST_DAY(TRUNC(TO_DATE(W_BUDGET_YEAR || '-01', 'YYYY-MM')))
                  AND (BC.EFFECTIVE_DATE_TO IS NULL OR BC.EFFECTIVE_DATE_TO >= TRUNC(TO_DATE(W_BUDGET_YEAR || '-12', 'YYYY-MM')))
              )
      GROUP BY DM.DEPT_NAME
           , DM.DEPT_CODE
           , DM.DEPT_ID
           , BPM.ACCOUNT_CONTROL_ID
           , FI_ACCOUNT_CONTROL_G.ACCOUNT_DESC_F(BPM.ACCOUNT_CONTROL_ID, BPM.SOB_ID)
           , BPM.ACCOUNT_CODE
           , BPM.SAVE_SEQ
           , BPM.APPROVE_STATUS
      ORDER BY DM.DEPT_CODE, BPM.ACCOUNT_CODE, BPM.SAVE_SEQ
      ;
  END SELECT_BUDGET_PLAN_MONTH;

-- (��) ���� �� --> (��) ���� ����.
  PROCEDURE INSERT_BUDGET_PLAN_MONTH
            ( P_BUDGET_YEAR        IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , P_DEPT_ID            IN FI_BUDGET_PLAN_MONTH.DEPT_ID%TYPE
            , P_ACCOUNT_CONTROL_ID IN FI_BUDGET_PLAN_MONTH.ACCOUNT_CONTROL_ID%TYPE
            , P_SOB_ID             IN FI_BUDGET_PLAN_MONTH.SOB_ID%TYPE
            , P_MONTH_1            IN NUMBER
            , P_MONTH_2            IN NUMBER
            , P_MONTH_3            IN NUMBER
            , P_MONTH_4            IN NUMBER
            , P_MONTH_5            IN NUMBER
            , P_MONTH_6            IN NUMBER
            , P_MONTH_7            IN NUMBER
            , P_MONTH_8            IN NUMBER
            , P_MONTH_9            IN NUMBER
            , P_MONTH_10           IN NUMBER
            , P_MONTH_11           IN NUMBER
            , P_MONTH_12           IN NUMBER
            , P_USER_ID            IN NUMBER
            , O_SAVE_SEQ           OUT NUMBER
            )
  AS
    V_SYSDATE       DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_RECORD_COUNT  NUMBER := 0;
    V_ACCOUNT_CODE  VARCHAR2(20);
    V_ORG_ID        NUMBER;
        
    V_START_DATE              DATE;
    V_END_DATE                DATE;
    
    V_BUDGET_PERIOD           VARCHAR2(7) := NULL;    -- ������.
    V_BUDGET_PERIOD_FR        VARCHAR2(7) := NULL;    -- ���� ���� ���� ���.
    V_BUDGET_PERIOD_TO        VARCHAR2(7) := NULL;    -- ���� ���� ���� ���.
    V_BASE_MONTH_YN           VARCHAR2(2) := 'N';
    V_AMOUNT                  NUMBER := 0;
    V_MONTH_SEQ               NUMBER := 0;            -- ��������.
  BEGIN
    -- ������ ���� å������ ���� üũ.
    O_SAVE_SEQ := 1;
    BEGIN
      SELECT COUNT(BPY.ACCOUNT_CONTROL_ID) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_BUDGET_PLAN_YEAR BPY
       WHERE BPY.BUDGET_YEAR        = P_BUDGET_YEAR
         AND BPY.DEPT_ID            = P_DEPT_ID
         AND BPY.ACCOUNT_CONTROL_ID = P_ACCOUNT_CONTROL_ID
         AND BPY.SOB_ID             = P_SOB_ID
         AND BPY.SAVE_SEQ           = O_SAVE_SEQ
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT <> 0 THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Data_Code, ERRNUMS.Exist_Data_Desc);
    END IF;
    
    BEGIN
      SELECT AC.ACCOUNT_CODE
          , AC.ORG_ID
        INTO V_ACCOUNT_CODE
          , V_ORG_ID
        FROM FI_ACCOUNT_CONTROL AC
      WHERE AC.ACCOUNT_CONTROL_ID = P_ACCOUNT_CONTROL_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Not_Found_Code, ERRNUMS.Data_Not_Found_Desc);
    END;
    
    GL_FISCAL_YEAR_G.FISCAL_YEAR_DATE_P(P_BUDGET_YEAR, P_SOB_ID, V_START_DATE, V_END_DATE);
    FOR R1 IN 1 .. 12
    LOOP
      V_AMOUNT := 0;
      V_BUDGET_PERIOD := TO_CHAR(ADD_MONTHS(V_START_DATE, (R1 - 1)), 'YYYY-MM');
      FI_BUDGET_ACCOUNT_G.BUDGET_PERIOD_FR_TO(V_BUDGET_PERIOD, P_ACCOUNT_CONTROL_ID, P_SOB_ID, V_BUDGET_PERIOD_FR, V_BUDGET_PERIOD_TO, V_MONTH_SEQ);
      
      -- ����ݾ� ����.
      SELECT CASE R1
               WHEN 1 THEN P_MONTH_1
               WHEN 2 THEN P_MONTH_2
               WHEN 3 THEN P_MONTH_3
               WHEN 4 THEN P_MONTH_4
               WHEN 5 THEN P_MONTH_5
               WHEN 6 THEN P_MONTH_6
               WHEN 7 THEN P_MONTH_7
               WHEN 8 THEN P_MONTH_8
               WHEN 9 THEN P_MONTH_9
               WHEN 10 THEN P_MONTH_10
               WHEN 11 THEN P_MONTH_11
               WHEN 12 THEN P_MONTH_12
               ELSE 0
             END AS MONTH_AMOUNT
        INTO V_AMOUNT
        FROM DUAL;
      
      IF V_BUDGET_PERIOD = V_BUDGET_PERIOD_FR THEN
        V_BASE_MONTH_YN := 'Y';
      ELSE
        V_BASE_MONTH_YN := 'N';      
      END IF;
      
      -- �ݿ�.
      FI_BUDGET_PLAN_G.SAVE_BUDGET_PLAN_MONTH
        ( V_BUDGET_PERIOD
        , P_DEPT_ID
        , P_ACCOUNT_CONTROL_ID
        , V_ACCOUNT_CODE
        , P_SOB_ID
        , V_ORG_ID
        , R1
        , V_BUDGET_PERIOD_FR
        , V_BUDGET_PERIOD_TO
        , V_AMOUNT
        , V_BASE_MONTH_YN
        , 'Y'            
        , NULL          
        , P_USER_ID 
        );
    END LOOP R1;
    
    -- (��) ���� ����.
    SAVE_BUDGET_PLAN_YEAR
      ( P_BUDGET_YEAR        => P_BUDGET_YEAR
      , P_DEPT_ID            => P_DEPT_ID
      , P_ACCOUNT_CONTROL_ID => P_ACCOUNT_CONTROL_ID
      , P_SAVE_SEQ           => O_SAVE_SEQ
      , P_SOB_ID             => P_SOB_ID
      , P_USER_ID            => P_USER_ID
      ); 
  END INSERT_BUDGET_PLAN_MONTH;
    
-- (��) ���� �� --> (��) ���� ����.
  PROCEDURE UPDATE_BUDGET_PLAN_MONTH
            ( W_BUDGET_YEAR        IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_ID            IN FI_BUDGET_PLAN_YEAR.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID             IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            , P_MONTH_1            IN NUMBER
            , P_MONTH_2            IN NUMBER
            , P_MONTH_3            IN NUMBER
            , P_MONTH_4            IN NUMBER
            , P_MONTH_5            IN NUMBER
            , P_MONTH_6            IN NUMBER
            , P_MONTH_7            IN NUMBER
            , P_MONTH_8            IN NUMBER
            , P_MONTH_9            IN NUMBER
            , P_MONTH_10           IN NUMBER
            , P_MONTH_11           IN NUMBER
            , P_MONTH_12           IN NUMBER
            , P_USER_ID            IN NUMBER
            )
  AS
    V_SYSDATE                      DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_START_DATE                   DATE;
    V_END_DATE                     DATE;
    
    V_BUDGET_PERIOD                VARCHAR2(7) := NULL;    -- ������.
    V_SAVE_SEQ                     NUMBER := 0;
  BEGIN
    IF BUDGET_CONFIRM_F
         ( W_BUDGET_YEAR
          , W_DEPT_ID
          , W_ACCOUNT_CONTROL_ID
          , W_SOB_ID
         ) = 'Y' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10115', NULL));
      RETURN;
    END IF;
    
    GL_FISCAL_YEAR_G.FISCAL_YEAR_DATE_P(W_BUDGET_YEAR, W_SOB_ID, V_START_DATE, V_END_DATE);
    
    -- SAVE SEQ üũ.
    V_SAVE_SEQ := BUDGET_SAVE_SEQ_F(W_BUDGET_YEAR, W_DEPT_ID, W_ACCOUNT_CONTROL_ID, W_SOB_ID);    
    IF V_SAVE_SEQ <> 1 THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10115', NULL));
    END IF;
    
    BEGIN
      -- 1�� ����.
      V_BUDGET_PERIOD := TO_CHAR(V_START_DATE, 'YYYY-MM');
      UPDATE FI_BUDGET_PLAN_MONTH BPM
        SET BPM.BASE_AMOUNT         = NVL(P_MONTH_1, 0)
          , BPM.LAST_UPDATE_DATE    = V_SYSDATE
          , BPM.LAST_UPDATED_BY     = P_USER_ID
      WHERE BPM.BUDGET_PERIOD       = V_BUDGET_PERIOD
        AND BPM.DEPT_ID             = W_DEPT_ID
        AND BPM.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BPM.SOB_ID              = W_SOB_ID
        AND BPM.LAST_YN             = 'Y'
        AND BPM.CREATE_SEQ          = 1
      ;
      -- 2�� ����.
      V_BUDGET_PERIOD := TO_CHAR(ADD_MONTHS(V_START_DATE, 1), 'YYYY-MM');
      UPDATE FI_BUDGET_PLAN_MONTH BPM
        SET BPM.BASE_AMOUNT         = NVL(P_MONTH_2, 0)
          , BPM.LAST_UPDATE_DATE    = V_SYSDATE
          , BPM.LAST_UPDATED_BY     = P_USER_ID
      WHERE BPM.BUDGET_PERIOD       = V_BUDGET_PERIOD
        AND BPM.DEPT_ID             = W_DEPT_ID
        AND BPM.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BPM.SOB_ID              = W_SOB_ID
        AND BPM.LAST_YN             = 'Y'
        AND BPM.CREATE_SEQ          = 2
      ;
      -- 3�� ����.
      V_BUDGET_PERIOD := TO_CHAR(ADD_MONTHS(V_START_DATE, 2), 'YYYY-MM');
      UPDATE FI_BUDGET_PLAN_MONTH BPM
        SET BPM.BASE_AMOUNT         = NVL(P_MONTH_3, 0)
          , BPM.LAST_UPDATE_DATE    = V_SYSDATE
          , BPM.LAST_UPDATED_BY     = P_USER_ID
      WHERE BPM.BUDGET_PERIOD       = V_BUDGET_PERIOD
        AND BPM.DEPT_ID             = W_DEPT_ID
        AND BPM.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BPM.SOB_ID              = W_SOB_ID
        AND BPM.LAST_YN             = 'Y'
        AND BPM.CREATE_SEQ          = 3
      ;
      -- 4�� ����.
      V_BUDGET_PERIOD := TO_CHAR(ADD_MONTHS(V_START_DATE, 3), 'YYYY-MM');
      UPDATE FI_BUDGET_PLAN_MONTH BPM
        SET BPM.BASE_AMOUNT         = NVL(P_MONTH_4, 0)
          , BPM.LAST_UPDATE_DATE    = V_SYSDATE
          , BPM.LAST_UPDATED_BY     = P_USER_ID
      WHERE BPM.BUDGET_PERIOD       = V_BUDGET_PERIOD
        AND BPM.DEPT_ID             = W_DEPT_ID
        AND BPM.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BPM.SOB_ID              = W_SOB_ID
        AND BPM.LAST_YN             = 'Y'
        AND BPM.CREATE_SEQ          = 4
      ;
      -- 5�� ����.
      V_BUDGET_PERIOD := TO_CHAR(ADD_MONTHS(V_START_DATE, 4), 'YYYY-MM');
      UPDATE FI_BUDGET_PLAN_MONTH BPM
        SET BPM.BASE_AMOUNT         = NVL(P_MONTH_5, 0)
          , BPM.LAST_UPDATE_DATE    = V_SYSDATE
          , BPM.LAST_UPDATED_BY     = P_USER_ID
      WHERE BPM.BUDGET_PERIOD       = V_BUDGET_PERIOD
        AND BPM.DEPT_ID             = W_DEPT_ID
        AND BPM.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BPM.SOB_ID              = W_SOB_ID
        AND BPM.LAST_YN             = 'Y'
        AND BPM.CREATE_SEQ          = 5
      ;
      -- 6�� ����.
      V_BUDGET_PERIOD := TO_CHAR(ADD_MONTHS(V_START_DATE, 5), 'YYYY-MM');
      UPDATE FI_BUDGET_PLAN_MONTH BPM
        SET BPM.BASE_AMOUNT         = NVL(P_MONTH_6, 0)
          , BPM.LAST_UPDATE_DATE    = V_SYSDATE
          , BPM.LAST_UPDATED_BY     = P_USER_ID
      WHERE BPM.BUDGET_PERIOD       = V_BUDGET_PERIOD
        AND BPM.DEPT_ID             = W_DEPT_ID
        AND BPM.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BPM.SOB_ID              = W_SOB_ID
        AND BPM.LAST_YN             = 'Y'
        AND BPM.CREATE_SEQ          = 6
      ;
      -- 7�� ����.
      V_BUDGET_PERIOD := TO_CHAR(ADD_MONTHS(V_START_DATE, 6), 'YYYY-MM');
      UPDATE FI_BUDGET_PLAN_MONTH BPM
        SET BPM.BASE_AMOUNT         = NVL(P_MONTH_7, 0)
          , BPM.LAST_UPDATE_DATE    = V_SYSDATE
          , BPM.LAST_UPDATED_BY     = P_USER_ID
      WHERE BPM.BUDGET_PERIOD       = V_BUDGET_PERIOD
        AND BPM.DEPT_ID             = W_DEPT_ID
        AND BPM.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BPM.SOB_ID              = W_SOB_ID
        AND BPM.LAST_YN             = 'Y'
        AND BPM.CREATE_SEQ          = 7
      ;
      -- 8�� ����.
      V_BUDGET_PERIOD := TO_CHAR(ADD_MONTHS(V_START_DATE, 7), 'YYYY-MM');
      UPDATE FI_BUDGET_PLAN_MONTH BPM
        SET BPM.BASE_AMOUNT         = NVL(P_MONTH_8, 0) 
          , BPM.LAST_UPDATE_DATE    = V_SYSDATE
          , BPM.LAST_UPDATED_BY     = P_USER_ID
      WHERE BPM.BUDGET_PERIOD       = V_BUDGET_PERIOD
        AND BPM.DEPT_ID             = W_DEPT_ID
        AND BPM.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BPM.SOB_ID              = W_SOB_ID
        AND BPM.LAST_YN             = 'Y'
        AND BPM.CREATE_SEQ          = 8
      ;
      -- 9�� ����.
      V_BUDGET_PERIOD := TO_CHAR(ADD_MONTHS(V_START_DATE, 8), 'YYYY-MM');
      UPDATE FI_BUDGET_PLAN_MONTH BPM
        SET BPM.BASE_AMOUNT         = NVL(P_MONTH_9, 0)
          , BPM.LAST_UPDATE_DATE    = V_SYSDATE
          , BPM.LAST_UPDATED_BY     = P_USER_ID
      WHERE BPM.BUDGET_PERIOD       = V_BUDGET_PERIOD
        AND BPM.DEPT_ID             = W_DEPT_ID
        AND BPM.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BPM.SOB_ID              = W_SOB_ID
        AND BPM.LAST_YN             = 'Y'
        AND BPM.CREATE_SEQ          = 9
      ;
      -- 10�� ����.
      V_BUDGET_PERIOD := TO_CHAR(ADD_MONTHS(V_START_DATE, 9), 'YYYY-MM');
      UPDATE FI_BUDGET_PLAN_MONTH BPM
        SET BPM.BASE_AMOUNT         = NVL(P_MONTH_10, 0)
          , BPM.LAST_UPDATE_DATE    = V_SYSDATE
          , BPM.LAST_UPDATED_BY     = P_USER_ID
      WHERE BPM.BUDGET_PERIOD       = V_BUDGET_PERIOD
        AND BPM.DEPT_ID             = W_DEPT_ID
        AND BPM.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BPM.SOB_ID              = W_SOB_ID
        AND BPM.LAST_YN             = 'Y'
        AND BPM.CREATE_SEQ          = 10
      ;
      -- 11�� ����.
      V_BUDGET_PERIOD := TO_CHAR(ADD_MONTHS(V_START_DATE, 10), 'YYYY-MM');
      UPDATE FI_BUDGET_PLAN_MONTH BPM
        SET BPM.BASE_AMOUNT         = NVL(P_MONTH_11, 0)
          , BPM.LAST_UPDATE_DATE    = V_SYSDATE
          , BPM.LAST_UPDATED_BY     = P_USER_ID
      WHERE BPM.BUDGET_PERIOD       = V_BUDGET_PERIOD
        AND BPM.DEPT_ID             = W_DEPT_ID
        AND BPM.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BPM.SOB_ID              = W_SOB_ID
        AND BPM.LAST_YN             = 'Y'
        AND BPM.CREATE_SEQ          = 11
      ;
      -- 12�� ����.
      V_BUDGET_PERIOD := TO_CHAR(ADD_MONTHS(V_START_DATE, 11), 'YYYY-MM');
      UPDATE FI_BUDGET_PLAN_MONTH BPM
        SET BPM.BASE_AMOUNT         = NVL(P_MONTH_12, 0)
          , BPM.LAST_UPDATE_DATE    = V_SYSDATE
          , BPM.LAST_UPDATED_BY     = P_USER_ID
      WHERE BPM.BUDGET_PERIOD       = V_BUDGET_PERIOD
        AND BPM.DEPT_ID             = W_DEPT_ID
        AND BPM.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BPM.SOB_ID              = W_SOB_ID
        AND BPM.LAST_YN             = 'Y'
        AND BPM.CREATE_SEQ          = 12
      ;
    EXCEPTION WHEN OTHERS THEN
      ROLLBACK;
      RAISE_APPLICATION_ERROR(-20001, SUBSTR(SQLERRM, 1, 150));
    END;
    
    -- (��) ���� ����.
    SAVE_BUDGET_PLAN_YEAR
      ( P_BUDGET_YEAR        => W_BUDGET_YEAR
      , P_DEPT_ID            => W_DEPT_ID
      , P_ACCOUNT_CONTROL_ID => W_ACCOUNT_CONTROL_ID
      , P_SAVE_SEQ           => V_SAVE_SEQ
      , P_SOB_ID             => W_SOB_ID
      , P_USER_ID            => P_USER_ID
      ); 
  END UPDATE_BUDGET_PLAN_MONTH;

-- (��) ���� ����.
  PROCEDURE DELETE_BUDGET_PLAN_MONTH
            ( W_BUDGET_YEAR        IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_ID            IN FI_BUDGET_PLAN_YEAR.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID             IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            , P_ORG_ID             IN FI_BUDGET_PLAN_YEAR.ORG_ID%TYPE 
            )
  AS
    V_PERIOD_FR                      DATE;
    V_PERIOD_TO                      DATE;
    V_SAVE_SEQ                       NUMBER := 0;
  BEGIN
    IF BUDGET_CONFIRM_F
         ( W_BUDGET_YEAR
          , W_DEPT_ID
          , W_ACCOUNT_CONTROL_ID
          , W_SOB_ID
         ) = 'Y' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10115', NULL));
      RETURN;
    END IF;
    
    -- SAVE SEQ üũ.
    V_SAVE_SEQ := BUDGET_SAVE_SEQ_F(W_BUDGET_YEAR, W_DEPT_ID, W_ACCOUNT_CONTROL_ID, W_SOB_ID);    
    IF V_SAVE_SEQ <> 1 THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10115', NULL));
    END IF;
    
    GL_FISCAL_YEAR_G.FISCAL_YEAR_DATE_P(W_BUDGET_YEAR, W_SOB_ID, V_PERIOD_FR, V_PERIOD_TO);
    BEGIN
      DELETE FROM FI_BUDGET_PLAN_MONTH BPM
      WHERE BPM.BUDGET_PERIOD      BETWEEN TO_CHAR(V_PERIOD_FR, 'YYYY-MM') AND TO_CHAR(V_PERIOD_TO, 'YYYY-MM')
        AND BPM.DEPT_ID            = W_DEPT_ID
        AND BPM.ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID
        AND BPM.SOB_ID             = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      ROLLBACK;
      RAISE_APPLICATION_ERROR(-20001, SUBSTR(SQLERRM, 1, 150));
    END;
  END DELETE_BUDGET_PLAN_MONTH;

-----------------------------------------------------------------------------------------  
-- (��)����å�� ���ΰ��� ��ȸ.
  PROCEDURE SELECT_PLAN_YEAR_APPROVE
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_BUDGET_YEAR          IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE            
            , W_DEPT_CODE_FR         IN VARCHAR2
            , W_DEPT_CODE_TO         IN VARCHAR2
            , W_ACCOUNT_CODE_FR      IN FI_BUDGET_ACCOUNT.ACCOUNT_CODE%TYPE
            , W_ACCOUNT_CODE_TO      IN FI_BUDGET_ACCOUNT.ACCOUNT_CODE%TYPE
            , W_APPROVE_STATUS       IN FI_BUDGET_PLAN_YEAR.APPROVE_STATUS%TYPE
            , W_ALL_RECORD_FLAG      IN VARCHAR2
            , P_CONNECT_PERSON_ID    IN NUMBER
            , P_SOB_ID               IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            )
  AS
    V_CAP_LEVEL                      VARCHAR2(2) := 'N';     --     
  BEGIN
    IF FI_BUDGET_CONTROL_G.BUDGET_MANAGER_CAP_F(P_CONNECT_PERSON_ID, P_SOB_ID) = 'Y' THEN
      V_CAP_LEVEL := 'C';
    END IF;
    OPEN P_CURSOR FOR
      SELECT 'N' AS CHECK_YN
           , BPY.BUDGET_YEAR
           , DM.DEPT_NAME AS DEPT_NAME
           , DM.DEPT_CODE
           , BPY.DEPT_ID
           , BPY.ACCOUNT_CONTROL_ID
           , FI_ACCOUNT_CONTROL_G.ACCOUNT_DESC_F(BPY.ACCOUNT_CONTROL_ID, BPY.SOB_ID) AS ACCOUNT_DESC
           , BPY.ACCOUNT_CODE
           , BPY.SAVE_SEQ
           , BPY.YEAR_AMOUNT
           , BPY.DESCRIPTION
           , BPY.APPROVE_STATUS
           , FI_COMMON_G.CODE_NAME_F('BUDGET_CAPACITY', BPY.APPROVE_STATUS, BPY.SOB_ID) AS APPROVE_STATUS_NAME
           , BPY.CONFIRMED_YN
           , BPY.CLOSED_YN
        FROM FI_BUDGET_PLAN_YEAR BPY
          , FI_DEPT_MASTER DM
       WHERE BPY.DEPT_ID            = DM.DEPT_ID
         AND BPY.SOB_ID             = DM.SOB_ID
         AND BPY.BUDGET_YEAR        = W_BUDGET_YEAR
         AND DM.DEPT_CODE           BETWEEN NVL(W_DEPT_CODE_FR, DM.DEPT_CODE) AND NVL(W_DEPT_CODE_TO, DM.DEPT_CODE)
         AND BPY.ACCOUNT_CODE       BETWEEN NVL(W_ACCOUNT_CODE_FR, BPY.ACCOUNT_CODE) AND NVL(W_ACCOUNT_CODE_TO, BPY.ACCOUNT_CODE)
         AND BPY.SOB_ID             = P_SOB_ID
         AND BPY.APPROVE_STATUS     = NVL(W_APPROVE_STATUS, BPY.APPROVE_STATUS)
         AND BPY.LAST_YN            = DECODE(W_ALL_RECORD_FLAG, 'Y', BPY.LAST_YN, 'Y')
         AND BPY.APPROVE_STATUS     = DECODE(V_CAP_LEVEL, 'C', BPY.APPROVE_STATUS, '-')
       ORDER BY DM.DEPT_CODE, BPY.ACCOUNT_CODE, BPY.SAVE_SEQ
       ;
  END SELECT_PLAN_YEAR_APPROVE;

-- (��)����å�� --> ���� ���� �ݾ� ��ȸ.
  PROCEDURE SELECT_PLAN_MONTH_APPROVE
            ( P_CURSOR1              OUT TYPES.TCURSOR1
            , W_BUDGET_YEAR          IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_CODE_FR         IN VARCHAR2
            , W_DEPT_CODE_TO         IN VARCHAR2
            , W_ACCOUNT_CODE_FR      IN FI_BUDGET_ACCOUNT.ACCOUNT_CODE%TYPE
            , W_ACCOUNT_CODE_TO      IN FI_BUDGET_ACCOUNT.ACCOUNT_CODE%TYPE
            , W_APPROVE_STATUS       IN FI_BUDGET_PLAN_YEAR.APPROVE_STATUS%TYPE
            , W_ALL_RECORD_FLAG      IN VARCHAR2
            , P_CONNECT_PERSON_ID    IN NUMBER
            , P_SOB_ID               IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            )
  AS
    V_PERIOD_FR                      DATE;
    V_PERIOD_TO                      DATE;
    V_CAP_LEVEL                      VARCHAR2(2) := 'N';     --     
  BEGIN
    IF FI_BUDGET_CONTROL_G.BUDGET_MANAGER_CAP_F(P_CONNECT_PERSON_ID, P_SOB_ID) = 'Y' THEN
      V_CAP_LEVEL := 'C';
    END IF;
    
    GL_FISCAL_YEAR_G.FISCAL_YEAR_DATE_P(W_BUDGET_YEAR, P_SOB_ID, V_PERIOD_FR, V_PERIOD_TO);
    OPEN P_CURSOR1 FOR
      SELECT DM.DEPT_NAME
           , DM.DEPT_CODE
           , DM.DEPT_ID
           , BPM.ACCOUNT_CONTROL_ID
           , FI_ACCOUNT_CONTROL_G.ACCOUNT_DESC_F(BPM.ACCOUNT_CONTROL_ID, BPM.SOB_ID) AS ACCOUNT_DESC
           , BPM.ACCOUNT_CODE
           , BPM.SAVE_SEQ AS SAVE_SEQ
           , MAX(DECODE(BPM.CREATE_SEQ, 1, BPM.BASE_AMOUNT, 0)) AS MONTH_1
           , MAX(DECODE(BPM.CREATE_SEQ, 2, BPM.BASE_AMOUNT, 0)) AS MONTH_2
           , MAX(DECODE(BPM.CREATE_SEQ, 3, BPM.BASE_AMOUNT, 0)) AS MONTH_3
           , MAX(DECODE(BPM.CREATE_SEQ, 4, BPM.BASE_AMOUNT, 0)) AS MONTH_4
           , MAX(DECODE(BPM.CREATE_SEQ, 5, BPM.BASE_AMOUNT, 0)) AS MONTH_5
           , MAX(DECODE(BPM.CREATE_SEQ, 6, BPM.BASE_AMOUNT, 0)) AS MONTH_6
           , MAX(DECODE(BPM.CREATE_SEQ, 7, BPM.BASE_AMOUNT, 0)) AS MONTH_7
           , MAX(DECODE(BPM.CREATE_SEQ, 8, BPM.BASE_AMOUNT, 0)) AS MONTH_8
           , MAX(DECODE(BPM.CREATE_SEQ, 9, BPM.BASE_AMOUNT, 0)) AS MONTH_9
           , MAX(DECODE(BPM.CREATE_SEQ, 10, BPM.BASE_AMOUNT, 0)) AS MONTH_10
           , MAX(DECODE(BPM.CREATE_SEQ, 11, BPM.BASE_AMOUNT, 0)) AS MONTH_11
           , MAX(DECODE(BPM.CREATE_SEQ, 12, BPM.BASE_AMOUNT, 0)) AS MONTH_12
           , SUM(BPM.BASE_AMOUNT) AS YEAR_TOTAL
           , MAX(DECODE(BPM.CREATE_SEQ, 1, BPM.BASE_MONTH_YN, 'N')) AS MONTH_1_YN     
           , MAX(DECODE(BPM.CREATE_SEQ, 2, BPM.BASE_MONTH_YN, 'N')) AS MONTH_2_YN
           , MAX(DECODE(BPM.CREATE_SEQ, 3, BPM.BASE_MONTH_YN, 'N')) AS MONTH_3_YN
           , MAX(DECODE(BPM.CREATE_SEQ, 4, BPM.BASE_MONTH_YN, 'N')) AS MONTH_4_YN
           , MAX(DECODE(BPM.CREATE_SEQ, 5, BPM.BASE_MONTH_YN, 'N')) AS MONTH_5_YN
           , MAX(DECODE(BPM.CREATE_SEQ, 6, BPM.BASE_MONTH_YN, 'N')) AS MONTH_6_YN
           , MAX(DECODE(BPM.CREATE_SEQ, 7, BPM.BASE_MONTH_YN, 'N')) AS MONTH_7_YN
           , MAX(DECODE(BPM.CREATE_SEQ, 8, BPM.BASE_MONTH_YN, 'N')) AS MONTH_8_YN
           , MAX(DECODE(BPM.CREATE_SEQ, 9, BPM.BASE_MONTH_YN, 'N')) AS MONTH_9_YN
           , MAX(DECODE(BPM.CREATE_SEQ, 10, BPM.BASE_MONTH_YN, 'N')) AS MONTH_10_YN
           , MAX(DECODE(BPM.CREATE_SEQ, 11, BPM.BASE_MONTH_YN, 'N')) AS MONTH_11_YN
           , MAX(DECODE(BPM.CREATE_SEQ, 12, BPM.BASE_MONTH_YN, 'N')) AS MONTH_12_YN
           , 'N' AS YEAR_TOTAL_YN
           , BPM.APPROVE_STATUS
        FROM FI_BUDGET_PLAN_MONTH BPM
          , FI_DEPT_MASTER DM
      WHERE BPM.DEPT_ID                 = DM.DEPT_ID
        AND BPM.BUDGET_PERIOD           BETWEEN TO_CHAR(V_PERIOD_FR, 'YYYY-MM') AND TO_CHAR(V_PERIOD_TO, 'YYYY-MM')
        AND BPM.ACCOUNT_CODE            BETWEEN NVL(W_ACCOUNT_CODE_FR, BPM.ACCOUNT_CODE) AND NVL(W_ACCOUNT_CODE_TO, BPM.ACCOUNT_CODE)
        AND BPM.SOB_ID                  = P_SOB_ID 
        AND DM.DEPT_CODE                BETWEEN NVL(W_DEPT_CODE_FR, DM.DEPT_CODE) AND NVL(W_DEPT_CODE_TO, DM.DEPT_CODE)
        AND BPM.APPROVE_STATUS          = NVL(W_APPROVE_STATUS, BPM.APPROVE_STATUS)
        AND BPM.LAST_YN                 = DECODE(W_ALL_RECORD_FLAG, 'Y', BPM.LAST_YN, 'Y')
        AND BPM.APPROVE_STATUS          = DECODE(V_CAP_LEVEL, 'C', BPM.APPROVE_STATUS, '-')
      GROUP BY DM.DEPT_NAME
           , DM.DEPT_CODE
           , DM.DEPT_ID
           , BPM.ACCOUNT_CONTROL_ID
           , FI_ACCOUNT_CONTROL_G.ACCOUNT_DESC_F(BPM.ACCOUNT_CONTROL_ID, BPM.SOB_ID)
           , BPM.ACCOUNT_CODE
           , BPM.SAVE_SEQ
           , BPM.APPROVE_STATUS
      ORDER BY DM.DEPT_CODE, BPM.ACCOUNT_CODE, BPM.SAVE_SEQ
      ;
  END SELECT_PLAN_MONTH_APPROVE;

-- ������ ������ ������ VERSION ���� - ����.
  PROCEDURE INSERT_PLAN_MONTH_APPROVE
            ( W_BUDGET_YEAR        IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_ID            IN FI_BUDGET_PLAN_YEAR.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID             IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            , P_USER_ID            IN FI_BUDGET_PLAN_YEAR.CREATED_BY%TYPE
            , O_SAVE_SEQ           OUT FI_BUDGET_PLAN_YEAR.SAVE_SEQ%TYPE
            )
  AS
    V_SYSDATE   DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_PERIOD_FR DATE;
    V_PERIOD_TO DATE;
    V_SAVE_SEQ  NUMBER := 0;
  BEGIN
    BEGIN
      V_SAVE_SEQ := BUDGET_SAVE_SEQ_F
                      ( W_BUDGET_YEAR
                      , W_DEPT_ID
                      , W_ACCOUNT_CONTROL_ID
                      , W_SOB_ID
                      );
    EXCEPTION WHEN OTHERS THEN
      V_SAVE_SEQ := 1;
    END;
    
    -- �Ⱓ ����.
    GL_FISCAL_YEAR_G.FISCAL_YEAR_DATE_P(W_BUDGET_YEAR, W_SOB_ID, V_PERIOD_FR, V_PERIOD_TO);
    
    -- ���� �ڷ� Y/N ���� : (��)����/(��)����.
    BEGIN
      UPDATE FI_BUDGET_PLAN_YEAR BPY
        SET BPY.LAST_YN             = 'N'
          , BPY.LAST_UPDATE_DATE    = V_SYSDATE
          , BPY.LAST_UPDATED_BY     = P_USER_ID
      WHERE BPY.BUDGET_YEAR         = W_BUDGET_YEAR
        AND BPY.DEPT_ID             = W_DEPT_ID
        AND BPY.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BPY.SOB_ID              = W_SOB_ID
        AND BPY.LAST_YN             = 'Y'
      ;
      
      UPDATE FI_BUDGET_PLAN_MONTH BPM
        SET BPM.LAST_YN             = 'N'
          , BPM.LAST_UPDATE_DATE    = V_SYSDATE
          , BPM.LAST_UPDATED_BY     = P_USER_ID
      WHERE BPM.BUDGET_PERIOD       BETWEEN TO_CHAR(V_PERIOD_FR, 'YYYY-MM') AND TO_CHAR(V_PERIOD_TO, 'YYYY-MM')
        AND BPM.DEPT_ID             = W_DEPT_ID
        AND BPM.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BPM.SOB_ID              = W_SOB_ID
        AND BPM.LAST_YN             = 'Y'
      ;
      
      INSERT INTO FI_BUDGET_PLAN_MONTH
      ( BUDGET_PERIOD 
      , DEPT_ID 
      , ACCOUNT_CONTROL_ID 
      , ACCOUNT_CODE 
      , SOB_ID 
      , ORG_ID 
      , CREATE_SEQ
      , BUDGET_PERIOD_FR
      , BUDGET_PERIOD_TO
      , START_DATE
      , END_DATE
      , SAVE_SEQ
      , BASE_AMOUNT
      , BASE_MONTH_YN
      , ENABLED_YN
      , LAST_YN
      , CONFIRMED_YN
      , CONFIRMED_DATE
      , CONFIRMED_PERSON_ID
      , CLOSED_YN
      , CLOSED_DATE
      , CLOSED_PERSON_ID
      , APPROVE_STATUS
      , EMAIL_STATUS
      , DESCRIPTION 
      , CREATION_DATE 
      , CREATED_BY 
      , LAST_UPDATE_DATE 
      , LAST_UPDATED_BY )
      SELECT BPM.BUDGET_PERIOD 
          , BPM.DEPT_ID 
          , BPM.ACCOUNT_CONTROL_ID 
          , BPM.ACCOUNT_CODE 
          , BPM.SOB_ID 
          , BPM.ORG_ID 
          , BPM.CREATE_SEQ
          , BPM.BUDGET_PERIOD_FR
          , BPM.BUDGET_PERIOD_TO
          , BPM.START_DATE
          , BPM.END_DATE
          , NVL(V_SAVE_SEQ, 0) + 1 AS SAVE_SEQ
          , BPM.BASE_AMOUNT
          , BPM.BASE_MONTH_YN 
          , BPM.ENABLED_YN
          , 'Y' AS LAST_YN
          , BPM.CONFIRMED_YN
          , BPM.CONFIRMED_DATE
          , BPM.CONFIRMED_PERSON_ID
          , BPM.CLOSED_YN
          , BPM.CLOSED_DATE
          , BPM.CLOSED_PERSON_ID
          , BPM.APPROVE_STATUS
          , BPM.EMAIL_STATUS
          , BPM.DESCRIPTION 
          , V_SYSDATE
          , P_USER_ID
          , V_SYSDATE
          , P_USER_ID
        FROM FI_BUDGET_PLAN_MONTH BPM
      WHERE BPM.BUDGET_PERIOD       BETWEEN TO_CHAR(V_PERIOD_FR, 'YYYY-MM') AND TO_CHAR(V_PERIOD_TO, 'YYYY-MM')
        AND BPM.DEPT_ID             = W_DEPT_ID
        AND BPM.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BPM.SOB_ID              = W_SOB_ID
        AND BPM.SAVE_SEQ            = V_SAVE_SEQ
      ;
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, SUBSTR(SQLERRM, 1, 150));
    END;
    O_SAVE_SEQ := NVL(V_SAVE_SEQ, 0) + 1;
  END INSERT_PLAN_MONTH_APPROVE;
  
-- (��) ���� �� --> (��) ���� ������ ����.
  PROCEDURE UPDATE_PLAN_MONTH_APPROVE
            ( W_BUDGET_YEAR        IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_ID            IN FI_BUDGET_PLAN_YEAR.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID             IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            , W_SAVE_SEQ           IN NUMBER
            , P_MONTH_1            IN NUMBER
            , P_MONTH_2            IN NUMBER
            , P_MONTH_3            IN NUMBER
            , P_MONTH_4            IN NUMBER
            , P_MONTH_5            IN NUMBER
            , P_MONTH_6            IN NUMBER
            , P_MONTH_7            IN NUMBER
            , P_MONTH_8            IN NUMBER
            , P_MONTH_9            IN NUMBER
            , P_MONTH_10           IN NUMBER
            , P_MONTH_11           IN NUMBER
            , P_MONTH_12           IN NUMBER
            , P_CONNECT_PERSON_ID  IN NUMBER
            , P_USER_ID            IN NUMBER
            )
  AS
    V_SYSDATE                      DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_START_DATE                   DATE;
    V_END_DATE                     DATE;
    
    V_BUDGET_PERIOD                VARCHAR2(7) := NULL;    -- ������.
    V_SAVE_SEQ                     NUMBER := 0;
  BEGIN
    IF FI_BUDGET_CONTROL_G.BUDGET_MANAGER_CAP_F(P_CONNECT_PERSON_ID, W_SOB_ID) = 'N' THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Approval_Nothing_Code, ERRNUMS.Approval_Nothing_Desc);
    END IF;
    
    IF BUDGET_CONFIRM_F
         ( W_BUDGET_YEAR
          , W_DEPT_ID
          , W_ACCOUNT_CONTROL_ID
          , W_SOB_ID
         ) = 'Y' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10115', NULL));
      RETURN;
    END IF;
    
    -- SAVE SEQ üũ.
    V_SAVE_SEQ := BUDGET_SAVE_SEQ_F(W_BUDGET_YEAR, W_DEPT_ID, W_ACCOUNT_CONTROL_ID, W_SOB_ID);    
    IF V_SAVE_SEQ <> W_SAVE_SEQ THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10262', NULL));
    END IF;
    V_SAVE_SEQ := 0;
    
    GL_FISCAL_YEAR_G.FISCAL_YEAR_DATE_P(W_BUDGET_YEAR, W_SOB_ID, V_START_DATE, V_END_DATE);
        
    -- �����ڷ� ���.
    INSERT_PLAN_MONTH_APPROVE
      ( W_BUDGET_YEAR
      , W_DEPT_ID
      , W_ACCOUNT_CONTROL_ID
      , W_SOB_ID
      , P_USER_ID
      , V_SAVE_SEQ
      );
    
    BEGIN
      -- 1�� ����.
      V_BUDGET_PERIOD := TO_CHAR(V_START_DATE, 'YYYY-MM');
      UPDATE FI_BUDGET_PLAN_MONTH BPM
        SET BPM.BASE_AMOUNT         = NVL(P_MONTH_1, 0)
          , BPM.LAST_UPDATE_DATE    = V_SYSDATE
          , BPM.LAST_UPDATED_BY     = P_USER_ID
      WHERE BPM.BUDGET_PERIOD       = V_BUDGET_PERIOD
        AND BPM.DEPT_ID             = W_DEPT_ID
        AND BPM.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BPM.SOB_ID              = W_SOB_ID
        AND BPM.LAST_YN             = 'Y'
        AND BPM.CREATE_SEQ          = 1
      ;
      -- 2�� ����.
      V_BUDGET_PERIOD := TO_CHAR(ADD_MONTHS(V_START_DATE, 1), 'YYYY-MM');
      UPDATE FI_BUDGET_PLAN_MONTH BPM
        SET BPM.BASE_AMOUNT         = NVL(P_MONTH_2, 0)
          , BPM.LAST_UPDATE_DATE    = V_SYSDATE
          , BPM.LAST_UPDATED_BY     = P_USER_ID
      WHERE BPM.BUDGET_PERIOD       = V_BUDGET_PERIOD
        AND BPM.DEPT_ID             = W_DEPT_ID
        AND BPM.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BPM.SOB_ID              = W_SOB_ID
        AND BPM.LAST_YN             = 'Y'
        AND BPM.CREATE_SEQ          = 2
      ;
      -- 3�� ����.
      V_BUDGET_PERIOD := TO_CHAR(ADD_MONTHS(V_START_DATE, 2), 'YYYY-MM');
      UPDATE FI_BUDGET_PLAN_MONTH BPM
        SET BPM.BASE_AMOUNT         = NVL(P_MONTH_3, 0)
          , BPM.LAST_UPDATE_DATE    = V_SYSDATE
          , BPM.LAST_UPDATED_BY     = P_USER_ID
      WHERE BPM.BUDGET_PERIOD       = V_BUDGET_PERIOD
        AND BPM.DEPT_ID             = W_DEPT_ID
        AND BPM.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BPM.SOB_ID              = W_SOB_ID
        AND BPM.LAST_YN             = 'Y'
        AND BPM.CREATE_SEQ          = 3
      ;
      -- 4�� ����.
      V_BUDGET_PERIOD := TO_CHAR(ADD_MONTHS(V_START_DATE, 3), 'YYYY-MM');
      UPDATE FI_BUDGET_PLAN_MONTH BPM
        SET BPM.BASE_AMOUNT         = NVL(P_MONTH_4, 0)
          , BPM.LAST_UPDATE_DATE    = V_SYSDATE
          , BPM.LAST_UPDATED_BY     = P_USER_ID
      WHERE BPM.BUDGET_PERIOD       = V_BUDGET_PERIOD
        AND BPM.DEPT_ID             = W_DEPT_ID
        AND BPM.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BPM.SOB_ID              = W_SOB_ID
        AND BPM.LAST_YN             = 'Y'
        AND BPM.CREATE_SEQ          = 4
      ;
      -- 5�� ����.
      V_BUDGET_PERIOD := TO_CHAR(ADD_MONTHS(V_START_DATE, 4), 'YYYY-MM');
      UPDATE FI_BUDGET_PLAN_MONTH BPM
        SET BPM.BASE_AMOUNT         = NVL(P_MONTH_5, 0)
          , BPM.LAST_UPDATE_DATE    = V_SYSDATE
          , BPM.LAST_UPDATED_BY     = P_USER_ID
      WHERE BPM.BUDGET_PERIOD       = V_BUDGET_PERIOD
        AND BPM.DEPT_ID             = W_DEPT_ID
        AND BPM.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BPM.SOB_ID              = W_SOB_ID
        AND BPM.LAST_YN             = 'Y'
        AND BPM.CREATE_SEQ          = 5
      ;
      -- 6�� ����.
      V_BUDGET_PERIOD := TO_CHAR(ADD_MONTHS(V_START_DATE, 5), 'YYYY-MM');
      UPDATE FI_BUDGET_PLAN_MONTH BPM
        SET BPM.BASE_AMOUNT         = NVL(P_MONTH_6, 0)
          , BPM.LAST_UPDATE_DATE    = V_SYSDATE
          , BPM.LAST_UPDATED_BY     = P_USER_ID
      WHERE BPM.BUDGET_PERIOD       = V_BUDGET_PERIOD
        AND BPM.DEPT_ID             = W_DEPT_ID
        AND BPM.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BPM.SOB_ID              = W_SOB_ID
        AND BPM.LAST_YN             = 'Y'
        AND BPM.CREATE_SEQ          = 6
      ;
      -- 7�� ����.
      V_BUDGET_PERIOD := TO_CHAR(ADD_MONTHS(V_START_DATE, 6), 'YYYY-MM');
      UPDATE FI_BUDGET_PLAN_MONTH BPM
        SET BPM.BASE_AMOUNT         = NVL(P_MONTH_7, 0)
          , BPM.LAST_UPDATE_DATE    = V_SYSDATE
          , BPM.LAST_UPDATED_BY     = P_USER_ID
      WHERE BPM.BUDGET_PERIOD       = V_BUDGET_PERIOD
        AND BPM.DEPT_ID             = W_DEPT_ID
        AND BPM.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BPM.SOB_ID              = W_SOB_ID
        AND BPM.LAST_YN             = 'Y'
        AND BPM.CREATE_SEQ          = 7
      ;
      -- 8�� ����.
      V_BUDGET_PERIOD := TO_CHAR(ADD_MONTHS(V_START_DATE, 7), 'YYYY-MM');
      UPDATE FI_BUDGET_PLAN_MONTH BPM
        SET BPM.BASE_AMOUNT         = NVL(P_MONTH_8, 0) 
          , BPM.LAST_UPDATE_DATE    = V_SYSDATE
          , BPM.LAST_UPDATED_BY     = P_USER_ID
      WHERE BPM.BUDGET_PERIOD       = V_BUDGET_PERIOD
        AND BPM.DEPT_ID             = W_DEPT_ID
        AND BPM.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BPM.SOB_ID              = W_SOB_ID
        AND BPM.LAST_YN             = 'Y'
        AND BPM.CREATE_SEQ          = 8
      ;
      -- 9�� ����.
      V_BUDGET_PERIOD := TO_CHAR(ADD_MONTHS(V_START_DATE, 8), 'YYYY-MM');
      UPDATE FI_BUDGET_PLAN_MONTH BPM
        SET BPM.BASE_AMOUNT         = NVL(P_MONTH_9, 0)
          , BPM.LAST_UPDATE_DATE    = V_SYSDATE
          , BPM.LAST_UPDATED_BY     = P_USER_ID
      WHERE BPM.BUDGET_PERIOD       = V_BUDGET_PERIOD
        AND BPM.DEPT_ID             = W_DEPT_ID
        AND BPM.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BPM.SOB_ID              = W_SOB_ID
        AND BPM.LAST_YN             = 'Y'
        AND BPM.CREATE_SEQ          = 9
      ;
      -- 10�� ����.
      V_BUDGET_PERIOD := TO_CHAR(ADD_MONTHS(V_START_DATE, 9), 'YYYY-MM');
      UPDATE FI_BUDGET_PLAN_MONTH BPM
        SET BPM.BASE_AMOUNT         = NVL(P_MONTH_10, 0)
          , BPM.LAST_UPDATE_DATE    = V_SYSDATE
          , BPM.LAST_UPDATED_BY     = P_USER_ID
      WHERE BPM.BUDGET_PERIOD       = V_BUDGET_PERIOD
        AND BPM.DEPT_ID             = W_DEPT_ID
        AND BPM.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BPM.SOB_ID              = W_SOB_ID
        AND BPM.LAST_YN             = 'Y'
        AND BPM.CREATE_SEQ          = 10
      ;
      -- 11�� ����.
      V_BUDGET_PERIOD := TO_CHAR(ADD_MONTHS(V_START_DATE, 10), 'YYYY-MM');
      UPDATE FI_BUDGET_PLAN_MONTH BPM
        SET BPM.BASE_AMOUNT         = NVL(P_MONTH_11, 0)
          , BPM.LAST_UPDATE_DATE    = V_SYSDATE
          , BPM.LAST_UPDATED_BY     = P_USER_ID
      WHERE BPM.BUDGET_PERIOD       = V_BUDGET_PERIOD
        AND BPM.DEPT_ID             = W_DEPT_ID
        AND BPM.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BPM.SOB_ID              = W_SOB_ID
        AND BPM.LAST_YN             = 'Y'
        AND BPM.CREATE_SEQ          = 11
      ;
      -- 12�� ����.
      V_BUDGET_PERIOD := TO_CHAR(ADD_MONTHS(V_START_DATE, 11), 'YYYY-MM');
      UPDATE FI_BUDGET_PLAN_MONTH BPM
        SET BPM.BASE_AMOUNT         = NVL(P_MONTH_12, 0)
          , BPM.LAST_UPDATE_DATE    = V_SYSDATE
          , BPM.LAST_UPDATED_BY     = P_USER_ID
      WHERE BPM.BUDGET_PERIOD       = V_BUDGET_PERIOD
        AND BPM.DEPT_ID             = W_DEPT_ID
        AND BPM.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BPM.SOB_ID              = W_SOB_ID
        AND BPM.LAST_YN             = 'Y'
        AND BPM.CREATE_SEQ          = 12
      ;
    EXCEPTION WHEN OTHERS THEN
      ROLLBACK;
      RAISE_APPLICATION_ERROR(-20001, SUBSTR(SQLERRM, 1, 150));
    END;
    
    -- (��) ���� ����.
    SAVE_BUDGET_PLAN_YEAR
      ( P_BUDGET_YEAR        => W_BUDGET_YEAR
      , P_DEPT_ID            => W_DEPT_ID
      , P_ACCOUNT_CONTROL_ID => W_ACCOUNT_CONTROL_ID
      , P_SAVE_SEQ           => V_SAVE_SEQ
      , P_SOB_ID             => W_SOB_ID
      , P_USER_ID            => P_USER_ID
      ); 
  END UPDATE_PLAN_MONTH_APPROVE;

-----------------------------------------------------------------------------------------
-- ������ ���� - ���� ���� ����.
  PROCEDURE UPDATE_STATUS_APPROVE
            ( W_BUDGET_YEAR         IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_ID             IN FI_BUDGET_PLAN_YEAR.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID  IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID              IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            , P_CONNECT_PERSON_ID   IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , P_APPROVE_STATUS      IN FI_BUDGET_PLAN_YEAR.APPROVE_STATUS%TYPE
            , P_APPROVE_FLAG        IN VARCHAR2
            , P_CHECK_YN            IN VARCHAR2
            , P_USER_ID             IN FI_BUDGET_PLAN_YEAR.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE                      DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_START_DATE                   DATE;
    V_END_DATE                     DATE;
    V_MESSAGE                      VARCHAR2(200) := NULL;
    V_CAP_C                        VARCHAR2(2) := 'N';
  BEGIN
--    RAISE_APPLICATION_ERROR(-20001, W_DEPT_ID || '/' || P_CONNECT_PERSON_ID);
    IF FI_BUDGET_CONTROL_G.BUDGET_MANAGER_CAP_F(P_CONNECT_PERSON_ID, W_SOB_ID) = 'Y' THEN
      V_CAP_C := 'C';
    END IF;    
    -- CHECK_YN = 'Y' �� ��쿡�� ó��.
    IF P_CHECK_YN <> 'Y' THEN
      RETURN;
    END IF;
    
    GL_FISCAL_YEAR_G.FISCAL_YEAR_DATE_P(W_BUDGET_YEAR, W_SOB_ID, V_START_DATE, V_END_DATE);
    -- // ���� ó�� // --
    IF P_APPROVE_STATUS = 'A' AND P_APPROVE_FLAG = 'OK' THEN
		-- �̽��� --> 1�� ���� : ����.
      IF V_CAP_C <> 'C' THEN
        RAISE_APPLICATION_ERROR(ERRNUMS.Approval_Nothing_Code, ERRNUMS.Approval_Nothing_Desc);
      END IF;
      -- (��)����ݾ� ����.
			UPDATE FI_BUDGET_PLAN_YEAR BPY
				SET BPY.CONFIRMED_YN        = DECODE(P_CHECK_YN, 'Y', 'Y', BPY.CONFIRMED_YN)
					, BPY.CONFIRMED_DATE      = DECODE(P_CHECK_YN, 'Y', V_SYSDATE, BPY.CONFIRMED_DATE)
					, BPY.CONFIRMED_PERSON_ID = DECODE(P_CHECK_YN, 'Y', P_CONNECT_PERSON_ID, BPY.CONFIRMED_PERSON_ID)          
					, BPY.APPROVE_STATUS      = DECODE(P_CHECK_YN, 'Y', 'C', BPY.APPROVE_STATUS)          
          , BPY.EMAIL_STATUS        = 'AR'
					, BPY.LAST_UPDATE_DATE    = V_SYSDATE
					, BPY.LAST_UPDATED_BY     = P_USER_ID
			WHERE BPY.BUDGET_YEAR         = W_BUDGET_YEAR
        AND BPY.DEPT_ID             = W_DEPT_ID
        AND BPY.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BPY.SOB_ID              = W_SOB_ID
        AND BPY.APPROVE_STATUS      = 'A'
        AND BPY.LAST_YN             = 'Y'
		  ;
      
      -- (��)����ݾ� ����.
      UPDATE FI_BUDGET_PLAN_MONTH BPM
				SET BPM.CONFIRMED_YN        = DECODE(P_CHECK_YN, 'Y', 'Y', BPM.CONFIRMED_YN)
					, BPM.CONFIRMED_DATE      = DECODE(P_CHECK_YN, 'Y', V_SYSDATE, BPM.CONFIRMED_DATE)
					, BPM.CONFIRMED_PERSON_ID = DECODE(P_CHECK_YN, 'Y', P_CONNECT_PERSON_ID, BPM.CONFIRMED_PERSON_ID)          
					, BPM.APPROVE_STATUS      = DECODE(P_CHECK_YN, 'Y', 'C', BPM.APPROVE_STATUS)          
          , BPM.EMAIL_STATUS        = 'AR'
					, BPM.LAST_UPDATE_DATE    = V_SYSDATE
					, BPM.LAST_UPDATED_BY     = P_USER_ID
			WHERE BPM.BUDGET_PERIOD       BETWEEN TO_CHAR(V_START_DATE, 'YYYY-MM') AND TO_CHAR(V_END_DATE, 'YYYY-MM')
        AND BPM.DEPT_ID             = W_DEPT_ID
        AND BPM.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BPM.SOB_ID              = W_SOB_ID
        AND BPM.APPROVE_STATUS      = 'A'
        AND BPM.LAST_YN             = 'Y'
		  ;
      
      -- ������� ����(���뿹�� ����).
      EXE_BUDGET_PLAN_YEAR_CONFIRM
            ( W_BUDGET_YEAR
            , W_DEPT_ID
            , W_ACCOUNT_CONTROL_ID
            , W_SOB_ID
            , P_APPROVE_FLAG
            , P_CONNECT_PERSON_ID
            , P_USER_ID
            , V_MESSAGE
            );
		ELSIF P_APPROVE_STATUS = 'C' AND P_APPROVE_FLAG = 'CANCEL' THEN
		-- Ȯ�� ���� --> 1�� ���� : ���� ���.
      IF V_CAP_C <> 'C' THEN
        RAISE_APPLICATION_ERROR(ERRNUMS.Approval_Nothing_Code, ERRNUMS.Approval_Nothing_Desc);
      END IF;
      -- (��)����ݾ� �������.
		  UPDATE FI_BUDGET_PLAN_YEAR BPY
				SET BPY.CONFIRMED_YN        = DECODE(P_CHECK_YN, 'Y', 'N', BPY.CONFIRMED_YN)
					, BPY.CONFIRMED_DATE      = DECODE(P_CHECK_YN, 'Y', NULL, BPY.CONFIRMED_DATE)
					, BPY.CONFIRMED_PERSON_ID = DECODE(P_CHECK_YN, 'Y', NULL, BPY.CONFIRMED_PERSON_ID)          
					, BPY.APPROVE_STATUS      = DECODE(P_CHECK_YN, 'Y', 'A', BPY.APPROVE_STATUS)          
          , BPY.EMAIL_STATUS        = 'CR'
					, BPY.LAST_UPDATE_DATE    = V_SYSDATE
					, BPY.LAST_UPDATED_BY     = P_USER_ID
			WHERE BPY.BUDGET_YEAR         = W_BUDGET_YEAR
        AND BPY.DEPT_ID             = W_DEPT_ID
        AND BPY.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BPY.SOB_ID              = W_SOB_ID
        AND BPY.APPROVE_STATUS      = 'C'
        AND BPY.LAST_YN             = 'Y'
		  ;
      -- (��)����ݾ� �������.
      UPDATE FI_BUDGET_PLAN_MONTH BPM
				SET BPM.CONFIRMED_YN        = DECODE(P_CHECK_YN, 'Y', 'N', BPM.CONFIRMED_YN)
					, BPM.CONFIRMED_DATE      = DECODE(P_CHECK_YN, 'Y', NULL, BPM.CONFIRMED_DATE)
					, BPM.CONFIRMED_PERSON_ID = DECODE(P_CHECK_YN, 'Y', NULL, BPM.CONFIRMED_PERSON_ID)          
					, BPM.APPROVE_STATUS      = DECODE(P_CHECK_YN, 'Y', 'A', BPM.APPROVE_STATUS)          
          , BPM.EMAIL_STATUS        = 'AR'
					, BPM.LAST_UPDATE_DATE    = V_SYSDATE
					, BPM.LAST_UPDATED_BY     = P_USER_ID
			WHERE BPM.BUDGET_PERIOD       BETWEEN TO_CHAR(V_START_DATE, 'YYYY-MM') AND TO_CHAR(V_END_DATE, 'YYYY-MM')
        AND BPM.DEPT_ID             = W_DEPT_ID
        AND BPM.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BPM.SOB_ID              = W_SOB_ID
        AND BPM.APPROVE_STATUS      = 'C'
        AND BPM.LAST_YN             = 'Y'
		  ;
      
      -- ������� ���� ���(���뿹�� ����).
      EXE_BUDGET_PLAN_YEAR_CONFIRM
            ( W_BUDGET_YEAR
            , W_DEPT_ID
            , W_ACCOUNT_CONTROL_ID
            , W_SOB_ID
            , P_APPROVE_FLAG
            , P_CONNECT_PERSON_ID
            , P_USER_ID
            , V_MESSAGE
            );
		ELSE
		-- ���δܰ� ���� ����.
			RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10043', '&&VALUE:=���λ���&&TEXT:=���λ��¸� ������ �ٽ� ó���ϼ���'));
			RETURN;
		END IF;
  END UPDATE_STATUS_APPROVE; 
    
-----------------------------------------------------------------------------------------
--�����û ���ο�û ó��.
  PROCEDURE UPDATE_STATUS_REQUEST
            ( W_BUDGET_YEAR         IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_CODE_FR        IN VARCHAR2
            , W_DEPT_CODE_TO        IN VARCHAR2
            , W_ACCOUNT_CODE_FR     IN VARCHAR2
            , W_ACCOUNT_CODE_TO     IN VARCHAR2
            , W_SOB_ID              IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            , P_CONNECT_PERSON_ID   IN NUMBER
            , P_USER_ID             IN FI_BUDGET_PLAN_YEAR.CREATED_BY%TYPE
            , O_MESSAGE              OUT VARCHAR2
            )
  AS
    V_SYSDATE                       DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_START_DATE                    DATE;
    V_END_DATE                      DATE;
  BEGIN
    GL_FISCAL_YEAR_G.FISCAL_YEAR_DATE_P(W_BUDGET_YEAR, W_SOB_ID, V_START_DATE, V_END_DATE);
    FOR C1 IN ( SELECT BPY.BUDGET_YEAR
                     , BPY.DEPT_ID
                     , BPY.ACCOUNT_CONTROL_ID
                     , BPY.SOB_ID
                     , BPY.APPROVE_STATUS
                  FROM FI_BUDGET_PLAN_YEAR BPY
                    , FI_DEPT_MASTER DM
                WHERE BPY.DEPT_ID             = DM.DEPT_ID
                  AND BPY.SOB_ID              = DM.SOB_ID
                  AND BPY.BUDGET_YEAR         = W_BUDGET_YEAR
                  AND DM.DEPT_CODE            BETWEEN NVL(W_DEPT_CODE_FR, DM.DEPT_CODE) AND NVL(W_DEPT_CODE_TO, DM.DEPT_CODE)
                  AND BPY.ACCOUNT_CODE        BETWEEN NVL(W_ACCOUNT_CODE_FR, BPY.ACCOUNT_CODE) AND NVL(W_ACCOUNT_CODE_TO, BPY.ACCOUNT_CODE)
                  AND BPY.SOB_ID              = W_SOB_ID
                  AND BPY.LAST_YN             = 'Y'
                  AND BPY.APPROVE_STATUS      = 'N'
                  AND EXISTS 
                        ( SELECT 'X'
                            FROM FI_BUDGET_CONTROL BC
                          WHERE BC.DEPT_ID        = BPY.DEPT_ID
                            AND BC.SOB_ID         = BPY.SOB_ID
                            AND BC.PERSON_ID      = P_CONNECT_PERSON_ID
                            AND BC.EFFECTIVE_DATE_FR  <= LAST_DAY(TRUNC(TO_DATE(W_BUDGET_YEAR || '-01', 'YYYY-MM')))
                            AND (BC.EFFECTIVE_DATE_TO IS NULL OR BC.EFFECTIVE_DATE_TO >= TRUNC(TO_DATE(W_BUDGET_YEAR || '-12', 'YYYY-MM')))
                        )
               )
    LOOP
      BEGIN
        UPDATE FI_BUDGET_PLAN_YEAR BPY
          SET BPY.APPROVE_STATUS     = 'A'
            , BPY.EMAIL_STATUS       = 'AR'
            , BPY.LAST_UPDATE_DATE   = V_SYSDATE
            , BPY.LAST_UPDATED_BY    = P_USER_ID
        WHERE BPY.BUDGET_YEAR         = C1.BUDGET_YEAR
          AND BPY.DEPT_ID             = C1.DEPT_ID
          AND BPY.ACCOUNT_CONTROL_ID  = C1.ACCOUNT_CONTROL_ID
          AND BPY.SOB_ID              = C1.SOB_ID
          AND BPY.LAST_YN             = 'Y'
        ;
        
        UPDATE FI_BUDGET_PLAN_MONTH BPM
           SET BPM.APPROVE_STATUS    = 'A'
            , BPM.EMAIL_STATUS       = 'AR'
            , BPM.LAST_UPDATE_DATE   = V_SYSDATE
            , BPM.LAST_UPDATED_BY    = P_USER_ID
        WHERE BPM.BUDGET_PERIOD       BETWEEN TO_CHAR(V_START_DATE, 'YYYY-MM') AND TO_CHAR(V_END_DATE, 'YYYY-MM')
          AND BPM.DEPT_ID             = C1.DEPT_ID
          AND BPM.ACCOUNT_CONTROL_ID  = C1.ACCOUNT_CONTROL_ID
          AND BPM.SOB_ID              = C1.SOB_ID
          AND BPM.LAST_YN             = 'Y'
        ;
      EXCEPTION WHEN OTHERS THEN
        O_MESSAGE := SUBSTR(SQLERRM, 1, 150);
      END;
    END LOOP C1;
    IF O_MESSAGE IS NULL THEN
      O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);
    END IF;
  END UPDATE_STATUS_REQUEST;

-----------------------------------------------------------------------------------------
-- (��)����å�� -> ���� ������� ó��.
  PROCEDURE EXE_BUDGET_PERIOD
            ( W_BUDGET_YEAR          IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_CODE_FR         IN VARCHAR2
            , W_DEPT_CODE_TO         IN VARCHAR2
            , W_ACCOUNT_CODE_FR      IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CODE%TYPE
            , W_ACCOUNT_CODE_TO      IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CODE%TYPE
            , W_SOB_ID               IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            , P_USER_ID              IN FI_BUDGET_PLAN_YEAR.CREATED_BY%TYPE
            , O_MESSAGE              OUT VARCHAR2
            )
  AS
    V_STD_START_DATE          DATE;                   -- ������ ������ ���� ���� ����.
    V_STD_END_DATE            DATE;
    V_BUDGET_PERIOD           VARCHAR2(7) := NULL;    -- ������.
    V_BUDGET_PERIOD_FR        VARCHAR2(7) := NULL;    -- ���� ���� ���� ���.
    V_BUDGET_PERIOD_TO        VARCHAR2(7) := NULL;    -- ���� ���� ���� ���.
    V_START_DATE              DATE := NULL;           -- ���� ���� ���� ����.
    V_END_DATE                DATE := NULL;           -- ���� ���� ���� ����.

    V_BASE_MONTH_YN           VARCHAR2(1) := 'N';     -- �� ���� ��� Y/N.
    V_NEXT_COUNT              NUMBER := 0;            -- �̿� COUNT.
    V_MONTH_AMOUNT            NUMBER := 0;            -- ������ �ݾ�.
    V_REMAIN_AMOUNT           NUMBER := 0;            -- ������ å���� �ܾ�.
    V_AMOUNT                  NUMBER := 0;            -- �ݿ� ����ݾ�.
  BEGIN   
    -- ȸ��Ⱓ.
    GL_FISCAL_YEAR_G.FISCAL_YEAR_DATE_P(W_BUDGET_YEAR, W_SOB_ID, V_STD_START_DATE, V_STD_END_DATE);
    
    FOR C1 IN ( SELECT BPY.BUDGET_YEAR
                     , BPY.DEPT_ID
                     , BPY.ACCOUNT_CONTROL_ID
                     , BPY.ACCOUNT_CODE
                     , BPY.SOB_ID
                     , BPY.ORG_ID
                     , BPY.YEAR_AMOUNT
                     , BPY.DESCRIPTION
                     , NVL(BA.REPEAT_PERIOD_COUNT, 1) AS REPEAT_PERIOD_COUNT
                     , NVL(BA.CONTROL_YN, 'N') AS CONTROL_YN
                     , NVL(BA.ADD_YN, 'N') AS ADD_YN
                     , NVL(BA.MOVE_YN, 'N') AS MOVE_YN
                     , NVL(BA.NEXT_YN, 'N') AS NEXT_YN
                     , NVL(BA.PO_YN, 'N') AS PO_YN
                  FROM FI_BUDGET_PLAN_YEAR BPY
                    , FI_DEPT_MASTER DM
                    , FI_BUDGET_ACCOUNT BA
                WHERE BPY.DEPT_ID             = DM.DEPT_ID
                  AND BPY.ACCOUNT_CONTROL_ID  = BA.ACCOUNT_CONTROL_ID(+)
                  AND BPY.SOB_ID              = BA.SOB_ID(+)
                  AND BPY.BUDGET_YEAR         = W_BUDGET_YEAR
                  AND DM.DEPT_CODE            BETWEEN NVL(W_DEPT_CODE_FR, DM.DEPT_CODE) AND NVL(W_DEPT_CODE_TO, DM.DEPT_CODE)
                  AND BPY.ACCOUNT_CODE        BETWEEN NVL(W_ACCOUNT_CODE_FR, BPY.ACCOUNT_CODE) AND NVL(W_ACCOUNT_CODE_TO, BPY.ACCOUNT_CODE)
                  AND BPY.SOB_ID              = W_SOB_ID
                  AND BPY.APPROVE_STATUS      IN ('N', 'A')
                  AND BPY.YEAR_AMOUNT         <> 0
                  AND BPY.LAST_YN             = 'Y'
                  AND NOT EXISTS
                        ( SELECT 'X'
                            FROM FI_BUDGET_PLAN_MONTH BPM
                          WHERE BPM.DEPT_ID           = BPY.DEPT_ID
                            AND BPM.ACCOUNT_CONTROL_ID  = BPY.ACCOUNT_CONTROL_ID
                            AND BPM.SOB_ID              = BPY.SOB_ID
                            AND BPM.BUDGET_PERIOD     BETWEEN TO_CHAR(V_STD_START_DATE, 'YYYY-MM') AND TO_CHAR(V_STD_END_DATE, 'YYYY-MM')
                        )
              )
    LOOP 
      V_NEXT_COUNT := 1;
      V_BASE_MONTH_YN    := 'N';      
      V_MONTH_AMOUNT     := TRUNC(NVL(C1.YEAR_AMOUNT, 0) / 12);  -- ������.
      V_REMAIN_AMOUNT    := NVL(C1.YEAR_AMOUNT, 0) - (V_MONTH_AMOUNT * 12);
      V_MONTH_AMOUNT     := NVL(V_MONTH_AMOUNT, 0) * C1.REPEAT_PERIOD_COUNT;
      
      FOR R1 IN 1 .. 12
      LOOP
        V_AMOUNT           := 0;
        V_BUDGET_PERIOD := TO_CHAR(ADD_MONTHS(V_STD_START_DATE, (R1 - 1)), 'YYYY-MM');
        -- ����ݾ� ����.
        IF V_NEXT_COUNT = 1 THEN
          V_AMOUNT     := NVL(V_MONTH_AMOUNT, 0);
          V_BUDGET_PERIOD_FR := V_BUDGET_PERIOD;
          IF NVL(C1.REPEAT_PERIOD_COUNT, 1) <= 1 THEN
            V_BUDGET_PERIOD_TO := V_BUDGET_PERIOD_FR;
          ELSE
            V_BUDGET_PERIOD_TO := TO_CHAR(ADD_MONTHS(TO_DATE(V_BUDGET_PERIOD_FR, 'YYYY-MM'), C1.REPEAT_PERIOD_COUNT - 1), 'YYYY-MM');
          END IF;
          
          IF NVL(V_REMAIN_AMOUNT, 0) <> 0 THEN
            V_AMOUNT   := NVL(V_AMOUNT, 0) + NVL(V_REMAIN_AMOUNT, 0);
            V_REMAIN_AMOUNT := 0;
          END IF;
        ELSE
          V_AMOUNT     := 0;
        END IF;
        
        -- �̿� FLAG ����.
        IF V_NEXT_COUNT < C1.REPEAT_PERIOD_COUNT THEN
          V_BASE_MONTH_YN := 'Y';
          V_NEXT_COUNT := V_NEXT_COUNT + 1;
        ELSE
          IF C1.REPEAT_PERIOD_COUNT = 1 THEN
            V_BASE_MONTH_YN := 'Y';
          ELSE
            V_BASE_MONTH_YN := 'N';
          END IF;
          V_NEXT_COUNT := 1;
        END IF;
/*DBMS_OUTPUT.PUT_LINE(R1 - 1 || '/' || C1.DEPT_ID || '/' || C1.ACCOUNT_CODE || '/' || TO_CHAR(V_STD_DATE, 'YYYY-MM-DD') || '/' || 
                     V_BUDGET_PERIOD || '/' || V_NEXT_COUNT || '/' || V_NEXT_YN  || '//' || V_AMOUNT);*/
        FI_BUDGET_PLAN_G.SAVE_BUDGET_PLAN_MONTH
          ( V_BUDGET_PERIOD
          , C1.DEPT_ID
          , C1.ACCOUNT_CONTROL_ID
          , C1.ACCOUNT_CODE
          , C1.SOB_ID
          , C1.ORG_ID
          , R1
          , V_BUDGET_PERIOD_FR
          , V_BUDGET_PERIOD_TO
          , V_AMOUNT
          , V_BASE_MONTH_YN
          , 'Y'            
          , C1.DESCRIPTION          
          , P_USER_ID 
          );
      END LOOP R1;
    END LOOP C1;    
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);
  END EXE_BUDGET_PERIOD;

-- (��)����å�� Ȯ��/Ȯ����� ó��.
  PROCEDURE EXE_BUDGET_PLAN_YEAR_CONFIRM
            ( W_BUDGET_YEAR         IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_ID             IN FI_BUDGET_PLAN_YEAR.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID  IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID              IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            , P_APPROVE_FLAG        IN VARCHAR2
            , P_CONNECT_PERSON_ID   IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , P_USER_ID             IN FI_BUDGET_PLAN_YEAR.CREATED_BY%TYPE
            , O_MESSAGE             OUT VARCHAR2
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_SIGN_FLAG               NUMBER;                 -- Ȯ��/Ȯ����Ҹ� ���� �����ϴ� �ݾ��� ��ȣ ����.
    
    V_STD_START_DATE          DATE;                   -- ������ ������ ���� ���� ����.
    V_STD_END_DATE            DATE;
  BEGIN
    -- ������� INSERT --
    -- ȸ��Ⱓ.
    GL_FISCAL_YEAR_G.FISCAL_YEAR_DATE_P(W_BUDGET_YEAR, W_SOB_ID, V_STD_START_DATE, V_STD_END_DATE);
    /*RAISE_APPLICATION_ERROR(-20001, W_BUDGET_YEAR || '/' || W_DEPT_ID || '/' || W_ACCOUNT_CONTROL_ID || '/' || 
                                    P_APPROVE_FLAG || '/' || P_CONNECT_PERSON_ID || '/' || W_SOB_ID || '/' || 
                                    V_STD_START_DATE || '/' || V_STD_END_DATE);*/
    
    IF P_APPROVE_FLAG = 'CANCEL' THEN
      V_SIGN_FLAG := -1;
    ELSE
      V_SIGN_FLAG := 1;
    END IF;
    -- ���� ���� ����.
    FOR C1 IN ( SELECT BPM.BUDGET_PERIOD
                     , BPM.DEPT_ID
                     , BPM.ACCOUNT_CONTROL_ID
                     , BPM.ACCOUNT_CODE
                     , BPM.SOB_ID
                     , BPM.ORG_ID
                     , BPM.CREATE_SEQ
                     , BPM.BUDGET_PERIOD_FR
                     , BPM.BUDGET_PERIOD_TO
                     , BPM.START_DATE
                     , BPM.END_DATE
                     , BPM.BASE_AMOUNT
                     , BPM.BASE_MONTH_YN
                     , BPM.ENABLED_YN
                     , BPM.DESCRIPTION                     
                     , NVL(BA.CONTROL_YN, 'N') AS CONTROL_YN
                     , NVL(BA.ADD_YN, 'N') AS ADD_YN
                     , NVL(BA.MOVE_YN, 'N') AS MOVE_YN
                     , NVL(BA.NEXT_YN, 'N') AS NEXT_YN
                     , NVL(BA.PO_YN, 'N') AS PO_YN
                  FROM FI_BUDGET_PLAN_MONTH BPM
                    , FI_BUDGET_ACCOUNT BA
                WHERE BPM.ACCOUNT_CONTROL_ID  = BA.ACCOUNT_CONTROL_ID
                  AND BPM.BUDGET_PERIOD       BETWEEN TO_CHAR(V_STD_START_DATE, 'YYYY-MM') AND TO_CHAR(V_STD_END_DATE, 'YYYY-MM')
                  AND BPM.DEPT_ID             = W_DEPT_ID
                  AND BPM.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
                  AND BPM.SOB_ID              = W_SOB_ID
                  AND BPM.LAST_YN             = 'Y'
                  AND BPM.CONFIRMED_YN        = 'Y'
               ORDER BY BPM.BUDGET_PERIOD, BPM.CREATE_SEQ
              )
    LOOP
      UPDATE FI_BUDGET FB
      SET FB.CREATE_SEQ           = C1.CREATE_SEQ
        , FB.BUDGET_PERIOD_FR     = C1.BUDGET_PERIOD_FR
        , FB.BUDGET_PERIOD_TO     = C1.BUDGET_PERIOD_TO
        , FB.START_DATE           = C1.START_DATE
        , FB.END_DATE             = C1.END_DATE
        , FB.BASE_AMOUNT          = NVL(FB.BASE_AMOUNT, 0) + (NVL(C1.BASE_AMOUNT, 0) * V_SIGN_FLAG)
        , FB.BASE_MONTH_YN        = NVL(C1.BASE_MONTH_YN, FB.BASE_MONTH_YN)
        , FB.MOVE_YN              = NVL(C1.MOVE_YN, FB.MOVE_YN)
        , FB.NEXT_YN              = NVL(C1.NEXT_YN, FB.NEXT_YN)
        , FB.ENABLED_YN           = NVL(C1.ENABLED_YN, 'N')
        , FB.DESCRIPTION          = C1.DESCRIPTION        
        , FB.LAST_UPDATE_DATE     = V_SYSDATE
        , FB.LAST_UPDATED_BY      = P_USER_ID
      WHERE FB.BUDGET_PERIOD      = C1.BUDGET_PERIOD
        AND FB.DEPT_ID            = C1.DEPT_ID
        AND FB.ACCOUNT_CONTROL_ID = C1.ACCOUNT_CONTROL_ID
        AND FB.SOB_ID             = C1.SOB_ID
      ;
      IF SQL%ROWCOUNT = 0 THEN
        INSERT INTO FI_BUDGET
        ( BUDGET_PERIOD
        , DEPT_ID
        , ACCOUNT_CONTROL_ID
        , ACCOUNT_CODE
        , SOB_ID
        , ORG_ID
        , CREATE_SEQ
        , BUDGET_PERIOD_FR
        , BUDGET_PERIOD_TO
        , START_DATE
        , END_DATE
        , BASE_AMOUNT
        , BASE_MONTH_YN
        , MOVE_YN
        , NEXT_YN
        , ENABLED_YN
        , DESCRIPTION        
        , CREATION_DATE			
        , CREATED_BY			
        , LAST_UPDATE_DATE			
        , LAST_UPDATED_BY		
        ) VALUES
        ( C1.BUDGET_PERIOD
        , C1.DEPT_ID
        , C1.ACCOUNT_CONTROL_ID
        , C1.ACCOUNT_CODE
        , C1.SOB_ID
        , C1.ORG_ID
        , C1.CREATE_SEQ
        , C1.BUDGET_PERIOD_FR
        , C1.BUDGET_PERIOD_TO
        , C1.START_DATE
        , C1.END_DATE
        , NVL(C1.BASE_AMOUNT, 0) * V_SIGN_FLAG
        , NVL(C1.BASE_MONTH_YN, 'N')
        , NVL(C1.MOVE_YN, 'N')
        , NVL(C1.NEXT_YN, 'N')
        , NVL(C1.ENABLED_YN, 'N')
        , C1.DESCRIPTION        
        , V_SYSDATE
        , P_USER_ID
        , V_SYSDATE
        , P_USER_ID
        );
      END IF;
    END LOOP C1;
    -- ����ó��.
    EXE_BUDGET_PLAN_YEAR_CLOSE
            ( W_BUDGET_YEAR
            , W_DEPT_ID
            , W_ACCOUNT_CONTROL_ID
            , W_SOB_ID
            , P_APPROVE_FLAG
            , P_CONNECT_PERSON_ID
            , P_USER_ID
            , O_MESSAGE
            );
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);
  END EXE_BUDGET_PLAN_YEAR_CONFIRM;
            
-- (��)����å�� ���� ó��.
  PROCEDURE EXE_BUDGET_PLAN_YEAR_CLOSE
            ( W_BUDGET_YEAR          IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_ID              IN FI_BUDGET_PLAN_YEAR.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID   IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID               IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            , P_APPROVE_FLAG         IN VARCHAR2
            , P_CONNECT_PERSON_ID    IN FI_BUDGET_PLAN_YEAR.CLOSED_PERSON_ID%TYPE
            , P_USER_ID              IN FI_BUDGET_PLAN_YEAR.CREATED_BY%TYPE
            , O_MESSAGE              OUT VARCHAR2
            )
  AS
    V_SYSDATE                 DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_STD_START_DATE          DATE;                   -- ������ ������ ���� ���� ����.
    V_STD_END_DATE            DATE;
  BEGIN
    -- ������� INSERT --
    -- ȸ��Ⱓ.
    GL_FISCAL_YEAR_G.FISCAL_YEAR_DATE_P(W_BUDGET_YEAR, W_SOB_ID, V_STD_START_DATE, V_STD_END_DATE);
    /*RAISE_APPLICATION_ERROR(-20001, W_BUDGET_YEAR || '/' || W_DEPT_CODE_FR || '/' || W_DEPT_CODE_TO || '/' || 
                                    W_ACCOUNT_CODE_FR || '/' || W_ACCOUNT_CODE_TO || '/' || W_SOB_ID);*/
    -- (��)���� �� ����.
    UPDATE FI_BUDGET_PLAN_YEAR
      SET CLOSED_YN          = DECODE(P_APPROVE_FLAG, 'OK', 'Y', 'N')
        , CLOSED_DATE        = DECODE(P_APPROVE_FLAG, 'OK', SYSDATE, NULL)
        , CLOSED_PERSON_ID   = DECODE(P_APPROVE_FLAG, 'OK', P_CONNECT_PERSON_ID, NULL)
    WHERE BUDGET_YEAR           = W_BUDGET_YEAR
      AND DEPT_ID               = W_DEPT_ID
      AND ACCOUNT_CONTROL_ID    = W_ACCOUNT_CONTROL_ID
      AND SOB_ID                = W_SOB_ID
      AND LAST_YN               = 'Y'
    ;
    
    -- (��)���� �� ����.
    UPDATE FI_BUDGET_PLAN_MONTH BPM
      SET BPM.CLOSED_YN           = DECODE(P_APPROVE_FLAG, 'OK', 'Y', 'N')
        , BPM.CLOSED_DATE         = DECODE(P_APPROVE_FLAG, 'OK', V_SYSDATE, NULL)
        , BPM.CLOSED_PERSON_ID    = DECODE(P_APPROVE_FLAG, 'OK', P_CONNECT_PERSON_ID, NULL)
    WHERE BPM.BUDGET_PERIOD       BETWEEN TO_CHAR(V_STD_START_DATE, 'YYYY-MM') AND TO_CHAR(V_STD_END_DATE, 'YYYY-MM')
      AND BPM.DEPT_ID             = W_DEPT_ID
      AND BPM.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
      AND BPM.SOB_ID              = W_SOB_ID
      AND BPM.LAST_YN             = 'Y'
    ;
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);
  END EXE_BUDGET_PLAN_YEAR_CLOSE;

-- (��) ����å������ �ϰ� ������� ����.
  PROCEDURE SAVE_BUDGET_PLAN_MONTH
            ( P_BUDGET_PERIOD      IN FI_BUDGET_PLAN_MONTH.BUDGET_PERIOD%TYPE
            , P_DEPT_ID            IN FI_BUDGET_PLAN_MONTH.DEPT_ID%TYPE
            , P_ACCOUNT_CONTROL_ID IN FI_BUDGET_PLAN_MONTH.ACCOUNT_CONTROL_ID%TYPE
            , P_ACCOUNT_CODE       IN FI_BUDGET_PLAN_MONTH.ACCOUNT_CODE%TYPE
            , P_SOB_ID             IN FI_BUDGET_PLAN_MONTH.SOB_ID%TYPE
            , P_ORG_ID             IN FI_BUDGET_PLAN_MONTH.ORG_ID%TYPE
            , P_CREATE_SEQ         IN FI_BUDGET_PLAN_MONTH.CREATE_SEQ%TYPE
            , P_BUDGET_PERIOD_FR   IN FI_BUDGET_PLAN_MONTH.BUDGET_PERIOD%TYPE
            , P_BUDGET_PERIOD_TO   IN FI_BUDGET_PLAN_MONTH.BUDGET_PERIOD%TYPE
            , P_BASE_AMOUNT        IN FI_BUDGET_PLAN_MONTH.BASE_AMOUNT%TYPE
            , P_BASE_MONTH_YN      IN FI_BUDGET_PLAN_MONTH.BASE_MONTH_YN%TYPE
            , P_ENABLED_YN         IN FI_BUDGET_PLAN_MONTH.ENABLED_YN%TYPE            
            , P_DESCRIPTION        IN FI_BUDGET_PLAN_MONTH.DESCRIPTION%TYPE
            , P_USER_ID            IN FI_BUDGET_PLAN_MONTH.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
    UPDATE FI_BUDGET_PLAN_MONTH BPM
    SET BPM.CREATE_SEQ            = P_CREATE_SEQ
      , BPM.BUDGET_PERIOD_FR      = P_BUDGET_PERIOD_FR
      , BPM.BUDGET_PERIOD_TO      = P_BUDGET_PERIOD_TO
      , BPM.START_DATE            = TRUNC(TO_DATE(P_BUDGET_PERIOD_FR, 'YYYY-MM'), 'MONTH')
      , BPM.END_DATE              = LAST_DAY(TO_DATE(P_BUDGET_PERIOD_TO, 'YYYY-MM'))
      , BPM.BASE_AMOUNT           = NVL(P_BASE_AMOUNT, 0)
      , BPM.BASE_MONTH_YN         = NVL(P_BASE_MONTH_YN, 'N')
      , BPM.ENABLED_YN            = NVL(P_ENABLED_YN, 'N')
      , BPM.DESCRIPTION           = P_DESCRIPTION      
      , BPM.LAST_UPDATE_DATE      = V_SYSDATE
      , BPM.LAST_UPDATED_BY       = P_USER_ID
    WHERE BPM.BUDGET_PERIOD       = P_BUDGET_PERIOD
      AND BPM.DEPT_ID             = P_DEPT_ID
      AND BPM.ACCOUNT_CONTROL_ID  = P_ACCOUNT_CONTROL_ID
      AND BPM.SOB_ID              = P_SOB_ID
    ;
    IF SQL%ROWCOUNT = 0 THEN
      INSERT INTO FI_BUDGET_PLAN_MONTH
      ( BUDGET_PERIOD
      , DEPT_ID
      , ACCOUNT_CONTROL_ID
      , ACCOUNT_CODE
      , SOB_ID			
      , ORG_ID
      , CREATE_SEQ
      , BUDGET_PERIOD_FR
      , BUDGET_PERIOD_TO
      , START_DATE
      , END_DATE
      , BASE_AMOUNT
      , BASE_MONTH_YN
      , ENABLED_YN
      , DESCRIPTION      
      , CREATION_DATE			
      , CREATED_BY			
      , LAST_UPDATE_DATE			
      , LAST_UPDATED_BY		
      ) VALUES
      ( P_BUDGET_PERIOD
      , P_DEPT_ID
      , P_ACCOUNT_CONTROL_ID
      , P_ACCOUNT_CODE
      , P_SOB_ID
      , P_ORG_ID
      , P_CREATE_SEQ
      , P_BUDGET_PERIOD_FR
      , P_BUDGET_PERIOD_TO
      , TRUNC(TO_DATE(P_BUDGET_PERIOD_FR, 'YYYY-MM'), 'MONTH')
      , LAST_DAY(TO_DATE(P_BUDGET_PERIOD_TO, 'YYYY-MM'))
      , NVL(P_BASE_AMOUNT, 0)
      , NVL(P_BASE_MONTH_YN, 'N')
      , NVL(P_ENABLED_YN, 'N')
      , P_DESCRIPTION      
      , V_SYSDATE
      , P_USER_ID
      , V_SYSDATE
      , P_USER_ID
      );
    END IF;
  END SAVE_BUDGET_PLAN_MONTH;

-- (��)������ ����/����.
  PROCEDURE SAVE_BUDGET_PLAN_YEAR
            ( P_BUDGET_YEAR        IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , P_DEPT_ID            IN FI_BUDGET_PLAN_YEAR.DEPT_ID%TYPE
            , P_ACCOUNT_CONTROL_ID IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID%TYPE
            , P_SAVE_SEQ           IN FI_BUDGET_PLAN_YEAR.SAVE_SEQ%TYPE            
            , P_SOB_ID             IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            , P_USER_ID            IN FI_BUDGET_PLAN_YEAR.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_START_DATE              DATE;                   -- ������ ������ ���� ���� ����.
    V_END_DATE                DATE;
    
    V_APPROVE_STATUS          VARCHAR2(2) :='N';
    V_EMAIL_STATUS            VARCHAR2(2) := NULL;
    V_ACCOUNT_CODE            VARCHAR2(20);
    V_ORG_ID                  NUMBER;
    V_YEAR_AMOUNT             NUMBER;
  BEGIN    
    -- ȸ��Ⱓ.
    GL_FISCAL_YEAR_G.FISCAL_YEAR_DATE_P(P_BUDGET_YEAR, P_SOB_ID, V_START_DATE, V_END_DATE);    
    BEGIN
      SELECT BPM.ACCOUNT_CODE
           , BPM.ORG_ID
           , SUM(BPM.BASE_AMOUNT) AS YEAR_AMOUNT
           , MAX(BPM.APPROVE_STATUS) AS APPROVE_STATUS
           , MAX(BPM.EMAIL_STATUS) AS EMAIL_STATUS
        INTO V_ACCOUNT_CODE
           , V_ORG_ID
           , V_YEAR_AMOUNT
           , V_APPROVE_STATUS
           , V_EMAIL_STATUS
        FROM FI_BUDGET_PLAN_MONTH BPM
      WHERE BPM.BUDGET_PERIOD       BETWEEN TO_CHAR(V_START_DATE, 'YYYY-MM') AND TO_CHAR(V_END_DATE, 'YYYY-MM')
        AND BPM.DEPT_ID             = P_DEPT_ID
        AND BPM.ACCOUNT_CONTROL_ID  = P_ACCOUNT_CONTROL_ID
        AND BPM.SOB_ID              = P_SOB_ID
        AND BPM.SAVE_SEQ            = P_SAVE_SEQ
      GROUP BY BPM.ACCOUNT_CODE
           , BPM.ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Not_Found_Code, ERRNUMS.Data_Not_Found_Desc);
    END;
    
    UPDATE FI_BUDGET_PLAN_YEAR BPY
      SET YEAR_AMOUNT        = NVL(V_YEAR_AMOUNT, 0)
        , LAST_UPDATE_DATE   = V_SYSDATE
        , LAST_UPDATED_BY    = P_USER_ID
    WHERE BPY.BUDGET_YEAR        = P_BUDGET_YEAR
      AND BPY.DEPT_ID            = P_DEPT_ID
      AND BPY.ACCOUNT_CONTROL_ID = P_ACCOUNT_CONTROL_ID
      AND BPY.SOB_ID             = P_SOB_ID
      AND BPY.SAVE_SEQ           = P_SAVE_SEQ
    ;
    IF SQL%ROWCOUNT = 0 THEN
      INSERT INTO FI_BUDGET_PLAN_YEAR
      ( BUDGET_YEAR
      , DEPT_ID 
      , ACCOUNT_CONTROL_ID 
      , ACCOUNT_CODE 
      , SOB_ID 
      , ORG_ID 
      , SAVE_SEQ
      , YEAR_AMOUNT 
      , APPROVE_STATUS 
      , EMAIL_STATUS 
      , CREATION_DATE 
      , CREATED_BY 
      , LAST_UPDATE_DATE 
      , LAST_UPDATED_BY )
      VALUES
      ( P_BUDGET_YEAR
      , P_DEPT_ID
      , P_ACCOUNT_CONTROL_ID
      , V_ACCOUNT_CODE
      , P_SOB_ID
      , V_ORG_ID
      , P_SAVE_SEQ
      , NVL(V_YEAR_AMOUNT, 0)
      , V_APPROVE_STATUS 
      , V_EMAIL_STATUS 
      , V_SYSDATE
      , P_USER_ID
      , V_SYSDATE
      , P_USER_ID );
    END IF;
  END SAVE_BUDGET_PLAN_YEAR;
  
-- (��)���� å�� Ȯ�� ���� üũ.
  FUNCTION BUDGET_CONFIRM_F
            ( W_BUDGET_YEAR          IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_ID              IN FI_BUDGET_PLAN_YEAR.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID   IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID               IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            ) RETURN VARCHAR2
  AS
    V_CONFIRM_YN        VARCHAR2(2) := 'N';    -- Ȯ�� FLAG.
    V_RECORD_COUNT      NUMBER := 0;
  BEGIN
    BEGIN
      SELECT COUNT(BPY.ACCOUNT_CONTROL_ID) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_BUDGET_PLAN_YEAR BPY
      WHERE BPY.BUDGET_YEAR         = W_BUDGET_YEAR
        AND BPY.DEPT_ID             = NVL(W_DEPT_ID, BPY.DEPT_ID)
        AND BPY.ACCOUNT_CONTROL_ID  = NVL(W_ACCOUNT_CONTROL_ID, BPY.ACCOUNT_CONTROL_ID)
        AND BPY.SOB_ID              = W_SOB_ID
        AND BPY.CONFIRMED_YN        = 'Y'
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT = 0 THEN
      V_CONFIRM_YN := 'N';
    ELSE
      V_CONFIRM_YN := 'Y';
    END IF;
    RETURN V_CONFIRM_YN;
  END BUDGET_CONFIRM_F;
  
-- (��)���� å�� ���� ���� üũ.
  FUNCTION BUDGET_CLOSED_F
            ( W_BUDGET_YEAR          IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_ID              IN FI_BUDGET_PLAN_YEAR.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID   IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID               IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            ) RETURN VARCHAR2
  AS
    V_CLOSED_YN         VARCHAR2(2) := 'N';    -- ��������.
    V_RECORD_COUNT      NUMBER := 0;
  BEGIN
    BEGIN
      SELECT COUNT(BPY.ACCOUNT_CONTROL_ID) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_BUDGET_PLAN_YEAR BPY
      WHERE BPY.BUDGET_YEAR         = W_BUDGET_YEAR
        AND BPY.DEPT_ID             = NVL(W_DEPT_ID, BPY.DEPT_ID)
        AND BPY.ACCOUNT_CONTROL_ID  = NVL(W_ACCOUNT_CONTROL_ID, BPY.ACCOUNT_CONTROL_ID)
        AND BPY.SOB_ID              = W_SOB_ID
        AND BPY.CLOSED_YN           = 'Y'
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT = 0 THEN
      V_CLOSED_YN := 'N';
    ELSE
      V_CLOSED_YN := 'Y';
    END IF;
    RETURN V_CLOSED_YN;
  END BUDGET_CLOSED_F;

-- (��)���� �� : ������ ���� �Ϸù�ȣ ����.
  FUNCTION BUDGET_SAVE_SEQ_F
            ( W_BUDGET_YEAR          IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_ID              IN FI_BUDGET_PLAN_YEAR.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID   IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID               IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            ) RETURN NUMBER
  AS
    V_SAVE_SEQ                       NUMBER := 0;
  BEGIN
    -- SAVE SEQ üũ.
    BEGIN
      SELECT MAX(BPY.SAVE_SEQ) AS SAVE_SEQ
        INTO V_SAVE_SEQ
        FROM FI_BUDGET_PLAN_YEAR BPY
      WHERE BPY.BUDGET_YEAR         = W_BUDGET_YEAR
        AND BPY.DEPT_ID             = W_DEPT_ID
        AND BPY.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BPY.SOB_ID              = W_SOB_ID
        AND BPY.LAST_YN             = 'Y'
      ;
    EXCEPTION WHEN OTHERS THEN
      V_SAVE_SEQ := 0;
    END;
    RETURN V_SAVE_SEQ;
  END BUDGET_SAVE_SEQ_F;
  
END FI_BUDGET_PLAN_G;
/
