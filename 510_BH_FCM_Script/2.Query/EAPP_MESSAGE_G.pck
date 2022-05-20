CREATE OR REPLACE PACKAGE EAPP_MESSAGE_G
AS
-- MESSAGE SEARCH.
  PROCEDURE DATA_SELECT(P_CURSOR                                OUT TYPES.TCURSOR
											, W_LANG_CODE                             IN VARCHAR2
											, W_MESSAGE_CODE                          IN VARCHAR2
											, W_MESSAGE_TEXT                          IN VARCHAR2
											, W_APPLICATION_CODE                      IN VARCHAR2
											, W_SOB_ID                                IN NUMBER
											, W_ORG_ID                                IN NUMBER);

-- DATA INSERT.
  PROCEDURE DATA_INSERT(P_LANG_CODE                             IN VARCHAR2
	                    , P_MESSAGE_CODE                          IN VARCHAR2
											, P_MESSAGE_TEXT                          IN VARCHAR2
											, P_MESSAGE_TYPE                          IN VARCHAR2
											, P_CATEGORY                              IN VARCHAR2
											, P_APPLICATION_CODE                      IN VARCHAR2
											, P_USER_ID                               IN NUMBER
											, O_MESSAGE_CODE                          OUT VARCHAR2);

-- DATA UPDATE.
  PROCEDURE DATA_UPDATE(W_MESSAGE_CODE                          IN VARCHAR2
	                    , W_LANG_CODE                             IN VARCHAR2
											, P_MESSAGE_TEXT                          IN VARCHAR2
											, P_MESSAGE_TYPE                          IN VARCHAR2
											, P_CATEGORY                              IN VARCHAR2
											, P_USER_ID                               IN NUMBER);

-- DATA DELETE.
  PROCEDURE DATA_DELETE(W_LANG_CODE                             IN VARCHAR2
                      , W_MESSAGE_CODE                          IN VARCHAR2);

-- LOOKUP SELECT DATA.
  PROCEDURE LU_MESSAGE_CODE(P_CURSOR3                           OUT TYPES.TCURSOR3
	                        , W_APPLICATION_CODE                  IN VARCHAR2);


-- PROCEDURE MESSAGE RETURN.
  PROCEDURE RETURN_TEXT(W_TERRITORY_CODE                        IN VARCHAR2
											, W_MESSAGE_CODE                          IN VARCHAR2
											, P_PARAMETER                             IN VARCHAR2 DEFAULT NULL
											, P_MESSAGE_TEXT                          OUT VARCHAR2);

-- FUNCTION MESSAGE RETURN.
  FUNCTION RETURN_TEXT_F(W_TERRITORY_CODE                       IN VARCHAR2
											, W_MESSAGE_CODE                          IN VARCHAR2
											, P_PARAMETER                             IN VARCHAR2 DEFAULT NULL) RETURN VARCHAR2;

-- PROCEDURE MESSAGE RETURN.
  PROCEDURE RETURN_MSG( W_MESSAGE_CODE                          IN VARCHAR2
                      , P_PARAMETER                             IN VARCHAR2 DEFAULT NULL
                      , P_MESSAGE_TEXT                          OUT VARCHAR2);

-- FUNCTION MESSAGE RETURN.
  FUNCTION RETURN_MSG_F(W_MESSAGE_CODE                          IN VARCHAR2
											, P_PARAMETER                             IN VARCHAR2 DEFAULT NULL) RETURN VARCHAR2;
                      
-- Deafult Territory Language RETURN.
  FUNCTION TERRITORY_CODE_F(W_TERRITORY_CODE                    IN VARCHAR2) RETURN VARCHAR2;

-- MESSAGE내용을 PARAMETER 값으로 변환하여 RETURN.
  FUNCTION MESSAGE_CHANGE_F(P_MESSAGE                           IN VARCHAR2
	                        , P_PARAMETER                         IN VARCHAR2) RETURN VARCHAR2;

END EAPP_MESSAGE_G; 
 
/
CREATE OR REPLACE PACKAGE BODY EAPP_MESSAGE_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : EAPP
/* Program Name : EAPP_MESSAGE_G
/* Description  : 시스템 메시지 관?/*
/* Reference by :
/* Program History : 신규 생성
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 20-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- MESSAGE SEARCH.
  PROCEDURE DATA_SELECT(P_CURSOR                                OUT TYPES.TCURSOR
											, W_LANG_CODE                             IN VARCHAR2
											, W_MESSAGE_CODE                          IN VARCHAR2
											, W_MESSAGE_TEXT                          IN VARCHAR2
											, W_APPLICATION_CODE                      IN VARCHAR2
											, W_SOB_ID                                IN NUMBER
											, W_ORG_ID                                IN NUMBER)
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT EM.LANG_CODE
          , LE1.LANG_DESCRIPTION
					, EM.APPLICATION_CODE
          , LE2.APPLICATION_DESCRIPTION
					, EM.MESSAGE_CODE
          , EM.MESSAGE_TEXT
          , EM.MESSAGE_TYPE
          , EM.CATEGORY
					, EM.MESSAGE_CODE O_MESSAGE_CODE
      FROM EAPP_MESSAGE EM
        , (SELECT LE.ENTRY_TAG LANG_CODE
              , LE.ENTRY_DESCRIPTION  LANG_DESCRIPTION
          FROM EAPP_LOOKUP_ENTRY LE
          WHERE LE.SOB_ID                                       = W_SOB_ID
            AND LE.ORG_ID                                       = W_ORG_ID
            AND LE.LOOKUP_TYPE                                  = 'SYSTEM_TERRITORY'
            AND LE.LOOKUP_MODULE                                = 'EAPP') LE1
        , (SELECT LE.ENTRY_CODE APPLICATION_CODE
              , LE.ENTRY_DESCRIPTION  APPLICATION_DESCRIPTION
          FROM EAPP_LOOKUP_ENTRY LE
          WHERE LE.SOB_ID                                       = W_SOB_ID
            AND LE.ORG_ID                                       = W_ORG_ID
            AND LE.LOOKUP_TYPE                                  = 'SYSTEM_MODULE'
            AND LE.LOOKUP_MODULE                                = 'EAPP') LE2
      WHERE EM.LANG_CODE                                        = LE1.LANG_CODE
        AND EM.APPLICATION_CODE                                 = LE2.APPLICATION_CODE
        AND EM.LANG_CODE                                        = NVL(W_LANG_CODE, EM.LANG_CODE)
        AND EM.MESSAGE_CODE                                     LIKE '%' || UPPER(W_MESSAGE_CODE) || '%'
        AND EM.MESSAGE_TEXT                                     LIKE '%' || W_MESSAGE_TEXT || '%'
        AND EM.APPLICATION_CODE                                 = NVL(W_APPLICATION_CODE, EM.APPLICATION_CODE)
      ORDER BY EM.MESSAGE_CODE, EM.LANG_CODE
      ;

  END DATA_SELECT;

-- DATA INSERT.
  PROCEDURE DATA_INSERT(P_LANG_CODE                             IN VARCHAR2
	                    , P_MESSAGE_CODE                          IN VARCHAR2
											, P_MESSAGE_TEXT                          IN VARCHAR2
											, P_MESSAGE_TYPE                          IN VARCHAR2
											, P_CATEGORY                              IN VARCHAR2
											, P_APPLICATION_CODE                      IN VARCHAR2
											, P_USER_ID                               IN NUMBER
											, O_MESSAGE_CODE                          OUT VARCHAR2)
  AS
	  N_MESSAGE_COUNT                                             NUMBER := 0;
    N_MESSAGE_NUM                                               NUMBER := 0;
    V_MESSAGE_CODE                                              VARCHAR2(50) := NULL;

  BEGIN
      -- TERITORY_LANGUAGE_CODE 와 MESSAGE_CODE 중복 체크.
	    BEGIN
        SELECT COUNT(EM.MESSAGE_NUM) AS MESSAGE_COUNT
				  INTO N_MESSAGE_COUNT
					FROM EAPP_MESSAGE EM
				 WHERE EM.MESSAGE_CODE                          = P_MESSAGE_CODE
           AND EM.LANG_CODE                             = P_LANG_CODE
				;
		  EXCEPTION WHEN OTHERS THEN
			  N_MESSAGE_COUNT := 0;
			END;
      IF N_MESSAGE_COUNT > 0 THEN
        RAISE ERRNUMS.Exist_Data;
      END IF;
	    -- 기존 TERITORY_LANGUAGE_CODE 와 MESSAGE_CODE를 가지고 기존 값 존재 여부 체크.
	    BEGIN
        SELECT EM.MESSAGE_NUM
				  INTO N_MESSAGE_COUNT
					FROM EAPP_MESSAGE EM
				 WHERE EM.MESSAGE_CODE                          = P_MESSAGE_CODE
           AND ROWNUM                                   <= 1
				;
		  EXCEPTION WHEN OTHERS THEN
			  N_MESSAGE_COUNT := 0;
			END;

			IF N_MESSAGE_COUNT = 0 THEN
				BEGIN
					SELECT NVL(MAX(EM.MESSAGE_NUM), 10000) + 1 AS NEW_MESSAGE_NUM
						INTO N_MESSAGE_NUM
					FROM EAPP_MESSAGE EM
					WHERE EM.APPLICATION_CODE                               = P_APPLICATION_CODE
					  AND EM.MESSAGE_NUM                                    < 90000
					;
				EXCEPTION WHEN OTHERS THEN
					N_MESSAGE_NUM := 10001;
				END;
				-- MESSAGE CODE.
        V_MESSAGE_CODE := P_APPLICATION_CODE || '_' || LPAD(N_MESSAGE_NUM,  5, 0);
			ELSE
			  V_MESSAGE_CODE := P_MESSAGE_CODE;
		  END IF;
-- RAISE_APPLICATION_ERROR(-20001, P_APPLICATION_CODE || '/ V_MESSAGE_CODE ' || V_MESSAGE_CODE);
      INSERT INTO EAPP_MESSAGE
      ( LANG_CODE, MESSAGE_CODE
      , MESSAGE_TEXT, MESSAGE_TYPE, CATEGORY
      , APPLICATION_CODE, MESSAGE_NUM
      , CREATION_DATE, CREATED_BY
      , LAST_UPDATE_DATE, LAST_UPDATED_BY
      ) VALUES
      (P_LANG_CODE, V_MESSAGE_CODE
      , P_MESSAGE_TEXT, P_MESSAGE_TYPE, UPPER(P_CATEGORY)
      , P_APPLICATION_CODE, N_MESSAGE_NUM
      , SYSDATE, P_USER_ID
      , SYSDATE, P_USER_ID
      );
      COMMIT;

      O_MESSAGE_CODE := V_MESSAGE_CODE;

  EXCEPTION
    WHEN ERRNUMS.Exist_Data THEN
    RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Data_Code, ERRNUMS.Exist_Data_Desc);
  END DATA_INSERT;

-- DATA UPDATE.
  PROCEDURE DATA_UPDATE(W_MESSAGE_CODE                          IN VARCHAR2
											, W_LANG_CODE                             IN VARCHAR2
											, P_MESSAGE_TEXT                          IN VARCHAR2
											, P_MESSAGE_TYPE                          IN VARCHAR2
											, P_CATEGORY                              IN VARCHAR2
											, P_USER_ID                               IN NUMBER)
  AS
  BEGIN
      UPDATE EAPP_MESSAGE EM
        SET EM.MESSAGE_TEXT                       = P_MESSAGE_TEXT
              , EM.MESSAGE_TYPE                   = P_MESSAGE_TYPE
              , EM.CATEGORY                       = UPPER(P_CATEGORY)
              , EM.LAST_UPDATE_DATE               = SYSDATE
              , EM.LAST_UPDATED_BY                = P_USER_ID
      WHERE EM.LANG_CODE                          = W_LANG_CODE
        AND EM.MESSAGE_CODE                       = W_MESSAGE_CODE
      ;
      COMMIT;

  END DATA_UPDATE;

-- DATA DELETE.
  PROCEDURE DATA_DELETE(W_LANG_CODE                             IN VARCHAR2
                      , W_MESSAGE_CODE                          IN VARCHAR2)
  AS
  BEGIN
      /*DELETE EAPP_MESSAGE EM
      WHERE EM.LANG_CODE                          = W_LANG_CODE
        AND EM.MESSAGE_CODE                       = W_MESSAGE_CODE
      ;
      COMMIT;*/
      NULL;
  END DATA_DELETE;

-- LOOKUP SELECT DATA.
  PROCEDURE LU_MESSAGE_CODE(P_CURSOR3                           OUT TYPES.TCURSOR3
	                        , W_APPLICATION_CODE                  IN VARCHAR2)
  AS
	BEGIN
	  OPEN P_CURSOR3 FOR
			SELECT EM.MESSAGE_CODE
					 , EM.MESSAGE_TEXT
					 , EM.LANG_CODE
					 , EM.MESSAGE_TYPE
					 , EM.CATEGORY
				FROM EAPP_MESSAGE EM
			 WHERE EM.APPLICATION_CODE             = W_APPLICATION_CODE
			ORDER BY EM.MESSAGE_CODE
	    ;

	END LU_MESSAGE_CODE;


---------------------------------------------------------------------------------------------------
-- PROCEDURE MESSAGE RETURN.
  PROCEDURE RETURN_TEXT(W_TERRITORY_CODE                        IN VARCHAR2
											, W_MESSAGE_CODE                          IN VARCHAR2
											, P_PARAMETER                             IN VARCHAR2 DEFAULT NULL
											, P_MESSAGE_TEXT                          OUT VARCHAR2)
  AS
		V_TERRITORY_CODE                                          VARCHAR2(20) := NULL;
		V_MESSAGE                                                 VARCHAR2(1000) := NULL;

  BEGIN
		-- 언어 코드 설정.
		V_TERRITORY_CODE := EAPP_MESSAGE_G.TERRITORY_CODE_F(W_TERRITORY_CODE => W_TERRITORY_CODE);

		-- MESSAGE 조회.
		BEGIN
			SELECT EM.MESSAGE_TEXT
				INTO V_MESSAGE
			FROM EAPP_MESSAGE EM
			WHERE EM.LANG_CODE                                      = V_TERRITORY_CODE
				AND EM.MESSAGE_CODE                                   = W_MESSAGE_CODE
			;
		EXCEPTION WHEN OTHERS THEN
			V_MESSAGE := NULL;
		END;
		IF V_MESSAGE IS NULL THEN
			V_TERRITORY_CODE := EAPP_MESSAGE_G.TERRITORY_CODE_F(W_TERRITORY_CODE => NULL);
			-- MESSAGE 다시 조회.
			BEGIN
				SELECT EM.MESSAGE_TEXT
					INTO V_MESSAGE
				FROM EAPP_MESSAGE EM
				WHERE EM.LANG_CODE                                      = V_TERRITORY_CODE
					AND EM.MESSAGE_CODE                                   = W_MESSAGE_CODE
				;
			EXCEPTION WHEN OTHERS THEN
				V_MESSAGE := '해당 코드에 대한 참조 유형을 찾을 수 없습니다';
				P_MESSAGE_TEXT := '(' || W_TERRITORY_CODE || ') ' || W_MESSAGE_CODE || '.' || V_MESSAGE;
				RETURN;
			END;
		END IF;

----------------------------------------------------------------------------------------------------------
    IF P_PARAMETER IS NULL THEN
		  NULL;
	  ELSE
		  V_MESSAGE := EAPP_MESSAGE_G.MESSAGE_CHANGE_F(P_MESSAGE => V_MESSAGE, P_PARAMETER => P_PARAMETER);
		END IF;
----------------------------------------------------------------------------------------------------------
    P_MESSAGE_TEXT := V_MESSAGE;

  END RETURN_TEXT;

---------------------------------------------------------------------------------------------------
-- PROCEDURE MESSAGE RETURN.
  FUNCTION RETURN_TEXT_F(W_TERRITORY_CODE                       IN VARCHAR2
											, W_MESSAGE_CODE                          IN VARCHAR2
											, P_PARAMETER                             IN VARCHAR2 DEFAULT NULL) RETURN VARCHAR2
  AS
      V_TERRITORY_CODE                                          VARCHAR2(20) := NULL;
      V_MESSAGE                                                 VARCHAR2(1000) := NULL;

  BEGIN
    -- 언어 코드 설정.
		V_TERRITORY_CODE := EAPP_MESSAGE_G.TERRITORY_CODE_F(W_TERRITORY_CODE => W_TERRITORY_CODE);

		-- MESSAGE 조회.
		BEGIN
			SELECT EM.MESSAGE_TEXT
				INTO V_MESSAGE
			FROM EAPP_MESSAGE EM
			WHERE EM.LANG_CODE                                      = V_TERRITORY_CODE
				AND EM.MESSAGE_CODE                                   = W_MESSAGE_CODE
			;
		EXCEPTION WHEN OTHERS THEN
			V_MESSAGE := NULL;
		END;
		IF V_MESSAGE IS NULL THEN
			V_TERRITORY_CODE := EAPP_MESSAGE_G.TERRITORY_CODE_F(W_TERRITORY_CODE => NULL);
			-- MESSAGE 다시 조회.
			BEGIN
				SELECT EM.MESSAGE_TEXT
					INTO V_MESSAGE
				FROM EAPP_MESSAGE EM
				WHERE EM.LANG_CODE                                      = V_TERRITORY_CODE
					AND EM.MESSAGE_CODE                                   = W_MESSAGE_CODE
				;
			EXCEPTION WHEN OTHERS THEN
				V_MESSAGE := '해당 코드에 대한 참조 유형을 찾을 수 없습니다';
        V_MESSAGE := '(' || V_TERRITORY_CODE || ') ' || W_MESSAGE_CODE || '.' || V_MESSAGE;
        RETURN V_MESSAGE;
			END;
		END IF;

----------------------------------------------------------------------------------------------------------
    IF P_PARAMETER IS NULL THEN
		  NULL;
	  ELSE
		  V_MESSAGE := EAPP_MESSAGE_G.MESSAGE_CHANGE_F(P_MESSAGE => V_MESSAGE, P_PARAMETER => P_PARAMETER);
		END IF;
----------------------------------------------------------------------------------------------------------
      RETURN V_MESSAGE;

  END RETURN_TEXT_F;


-- PROCEDURE MESSAGE RETURN.
  PROCEDURE RETURN_MSG( W_MESSAGE_CODE                          IN VARCHAR2
                      , P_PARAMETER                             IN VARCHAR2 DEFAULT NULL
                      , P_MESSAGE_TEXT                          OUT VARCHAR2)
  AS
  BEGIN
    P_MESSAGE_TEXT := RETURN_MSG_F
                          ( W_MESSAGE_CODE    => W_MESSAGE_CODE
                          , P_PARAMETER       => P_PARAMETER
                          );
  END RETURN_MSG;

-- FUNCTION MESSAGE RETURN.
  FUNCTION RETURN_MSG_F(W_MESSAGE_CODE                          IN VARCHAR2
											, P_PARAMETER                             IN VARCHAR2 DEFAULT NULL) RETURN VARCHAR2
  AS
    V_TERRITORY_CODE    VARCHAR2(20) := USERENV_G.GET_TERRITORY_S_F;
    V_RETURN_MESSAGE    VARCHAR2(10000) := NULL;
  BEGIN
    V_RETURN_MESSAGE := RETURN_TEXT_F
                          ( W_TERRITORY_CODE  => V_TERRITORY_CODE
                          , W_MESSAGE_CODE    => W_MESSAGE_CODE
                          , P_PARAMETER       => P_PARAMETER
                          );
    RETURN V_RETURN_MESSAGE;
  END RETURN_MSG_F;

-- Deafult Territory Language RETURN.
  FUNCTION TERRITORY_CODE_F(W_TERRITORY_CODE                    IN VARCHAR2) RETURN VARCHAR2
	AS
	  V_TERRITORY_CODE                              EAPP_MESSAGE.LANG_CODE%TYPE := NULL;

	BEGIN
	  IF W_TERRITORY_CODE IS NULL THEN
		-- 기본언어 리턴.
		  BEGIN
				SELECT LE.ENTRY_TAG TERRITORY_CODE
					INTO V_TERRITORY_CODE
				FROM EAPP_LOOKUP_ENTRY LE
				WHERE LE.LOOKUP_TYPE                                    = 'APPLICATION_LANGUAGE'
					AND LE.LOOKUP_MODULE                                  = 'EAPP'
					AND LE.Default_Flag                                   = 'Y'
					AND ROWNUM                                            <= 1
				;
			EXCEPTION WHEN OTHERS THEN
				V_TERRITORY_CODE := W_TERRITORY_CODE;
			END;
		ELSE
	  -- 언어 코드 설정.
      BEGIN
        SELECT LE.ENTRY_TAG TERRITORY_CODE
          INTO V_TERRITORY_CODE
        FROM EAPP_LOOKUP_ENTRY LE
        WHERE LE.LOOKUP_TYPE                                    = 'APPLICATION_LANGUAGE'
          AND LE.LOOKUP_MODULE                                  = 'EAPP'
          AND LE.ENTRY_CODE                                     = W_TERRITORY_CODE
          AND ROWNUM                                            <= 1
        ;
      EXCEPTION WHEN OTHERS THEN
        BEGIN
          SELECT LE.ENTRY_TAG
            INTO V_TERRITORY_CODE
            FROM EAPP_LOOKUP_ENTRY LE
           WHERE LE.LOOKUP_TYPE                                 = 'APPLICATION_LANGUAGE'
             AND LE.LOOKUP_MODULE                               = 'EAPP'
             AND LE.ENTRY_TAG                                   = W_TERRITORY_CODE
             AND ROWNUM                                         <= 1
          ;
        EXCEPTION WHEN OTHERS THEN
          BEGIN
            SELECT LE.ENTRY_TAG TERRITORY_CODE
              INTO V_TERRITORY_CODE
            FROM EAPP_LOOKUP_ENTRY LE
            WHERE LE.LOOKUP_TYPE                                = 'APPLICATION_LANGUAGE'
              AND LE.LOOKUP_MODULE                              = 'EAPP'
              AND LE.Default_Flag                               = 'Y'
              AND ROWNUM                                        <= 1
            ;
          EXCEPTION WHEN OTHERS THEN
            V_TERRITORY_CODE := W_TERRITORY_CODE;
          END;
			  END;
      END;
		END IF;

	  RETURN V_TERRITORY_CODE;

	END TERRITORY_CODE_F;

-- MESSAGE내용을 PARAMETER 값으로 변환하여 RETURN.
  FUNCTION MESSAGE_CHANGE_F(P_MESSAGE                           IN VARCHAR2
	                        , P_PARAMETER                         IN VARCHAR2) RETURN VARCHAR2
  AS
	  V_MESSAGE                                                 VARCHAR2(250) := NULL;
		V_PARA                                                    VARCHAR2(100) := NULL;
		V_VALUE                                                   VARCHAR2(100) := NULL;

		N_COL_NUM                                                 NUMBER := 0;
		N_START_NUM                                               NUMBER := 0;
		N_END_NUM                                                 NUMBER := 0;
	BEGIN
		V_MESSAGE := P_MESSAGE;

		-- 총 파라메터 갯수 처리.
		FOR C1 IN 1 .. NVL(LENGTHB(P_PARAMETER), 0)
		LOOP
			-- 초기화.
			V_PARA := NULL;
			V_VALUE := NULL;

			-- 변수명.
			N_COL_NUM := INSTR(P_PARAMETER, '&&', N_START_NUM + 1);
			IF N_COL_NUM > 0 THEN
				N_START_NUM := N_COL_NUM;
				N_END_NUM := INSTR(P_PARAMETER, ':=', N_START_NUM);

				V_PARA := SUBSTR(P_PARAMETER, N_START_NUM, N_END_NUM - N_START_NUM);
--      DBMS_OUTPUT.PUT_LINE('---> V_PARA : ' || V_PARA || ' , V_START_NUM -> ' || V_START_NUM || ', V_END_NUM->' || V_END_NUM );
			END IF;

			-- 치환값.
			N_COL_NUM := INSTR(P_PARAMETER, ':=', N_START_NUM);
			IF N_COL_NUM > 0 THEN
				N_START_NUM := N_COL_NUM + 2;
				N_END_NUM := INSTR(P_PARAMETER, '&&', N_START_NUM);
				IF N_END_NUM = 0 THEN
					N_END_NUM := LENGTHB(P_PARAMETER) + 1;
				END IF;
				V_VALUE := SUBSTR(P_PARAMETER, N_START_NUM, N_END_NUM - N_START_NUM);
--      DBMS_OUTPUT.PUT_LINE('-2--> V_VALUE : ' || V_VALUE || ' , V_START_NUM -> ' || V_START_NUM || ', V_END_NUM->' || V_END_NUM );
			END IF;
--    DBMS_OUTPUT.PUT_LINE('---> V_PARA : ' || V_PARA || ' , V_VALUE -> ' || V_VALUE);

			-- 변환하기.
			IF V_PARA IS NULL OR V_VALUE IS NULL THEN
				NULL;
			ELSE
				V_MESSAGE := REPLACE(V_MESSAGE, V_PARA, V_VALUE);
			END IF;

		END LOOP C1;

		RETURN V_MESSAGE;

	END MESSAGE_CHANGE_F;

END EAPP_MESSAGE_G; 
/
