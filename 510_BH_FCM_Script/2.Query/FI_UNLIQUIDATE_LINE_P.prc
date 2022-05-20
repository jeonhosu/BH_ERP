CREATE OR REPLACE PROCEDURE FI_UNLIQUIDATE_LINE_P
(
    P_GB               		 	 IN VARCHAR2                 ,
    P_MANAGE           		 	 IN VARCHAR2                 ,
    
    P_SLIP_LINE_ID      		       IN FI_SLIP_LINE.SLIP_LINE_ID%TYPE       ,
    P_SOB_ID            		       IN FI_SLIP_LINE.SOB_ID%TYPE             ,
    P_ORG_ID                	     IN FI_SLIP_LINE.ORG_ID%TYPE             ,
    P_PERIOD_NAME                  IN FI_SLIP_LINE.PERIOD_NAME%TYPE        ,
    P_GL_DATE           		       IN FI_SLIP_LINE.GL_DATE%TYPE            ,
    P_GL_NUM           			       IN FI_SLIP_LINE.GL_NUM%TYPE             ,
    P_UNLIQUIDATE_SLIP_LINE_ID     IN FI_SLIP_LINE.UNLIQUIDATE_SLIP_LINE_ID%TYPE,
    P_ACCOUNT_BOOK_ID              IN FI_SLIP_LINE.ACCOUNT_BOOK_ID%TYPE    ,
    P_SLIP_TYPE            		     IN FI_SLIP_LINE.SLIP_TYPE%TYPE          ,
    P_ACCOUNT_CONTROL_ID           IN FI_SLIP_LINE.ACCOUNT_CONTROL_ID%TYPE ,
    P_ACCOUNT_CODE                 IN FI_SLIP_LINE.ACCOUNT_CODE%TYPE       ,
    P_ACCOUNT_DR_CR                IN FI_SLIP_LINE.ACCOUNT_DR_CR%TYPE      ,
    P_CUSTOMER_ID                  IN FI_SLIP_LINE.CUSTOMER_ID%TYPE        ,
    P_GL_AMOUNT                    IN FI_SLIP_LINE.CURRENCY_CODE%TYPE      ,
    P_CURRENCY_CODE                IN FI_SLIP_LINE.CURRENCY_CODE%TYPE        ,
    P_EXCHANGE_RATE                IN FI_SLIP_LINE.EXCHANGE_RATE%TYPE      ,
    P_GL_CURRENCY_AMOUNT           IN FI_SLIP_LINE.GL_CURRENCY_AMOUNT%TYPE ,
    P_MANAGEMENT1                  IN FI_SLIP_LINE.MANAGEMENT1%TYPE		     ,
    P_MANAGEMENT2                  IN FI_SLIP_LINE.MANAGEMENT2%TYPE		     ,
    P_REFER1                       IN  FI_SLIP_LINE.REFER1%TYPE,
    P_REFER2                       IN  FI_SLIP_LINE.REFER2%TYPE,
    P_REFER3                       IN  FI_SLIP_LINE.REFER3%TYPE,
    P_REFER4                       IN  FI_SLIP_LINE.REFER4%TYPE,
    P_REFER5                       IN  FI_SLIP_LINE.REFER5%TYPE,
    P_REFER6                       IN  FI_SLIP_LINE.REFER6%TYPE,
    P_REFER7                       IN  FI_SLIP_LINE.REFER7%TYPE,
    P_REFER8                       IN  FI_SLIP_LINE.REFER8%TYPE,
    P_REFER9                       IN  FI_SLIP_LINE.REFER9%TYPE,
    P_REFER_DATE1                  IN FI_SLIP_LINE.REFER_DATE1%TYPE        ,
    P_REFER_DATE2                  IN FI_SLIP_LINE.REFER_DATE2%TYPE        ,
    P_REMARK		                   IN FI_SLIP_LINE.REMARK%TYPE             ,
    P_CREATION_DATE                IN FI_SLIP_LINE.CREATION_DATE%TYPE      ,
    P_CREATED_BY                   IN FI_SLIP_LINE.CREATED_BY%TYPE         ,
    P_LAST_UPDATE_DATE             IN FI_SLIP_LINE.LAST_UPDATE_DATE%TYPE   ,
    P_LAST_UPDATED_BY              IN FI_SLIP_LINE.LAST_UPDATED_BY%TYPE
 
) AS

    V_SLIP_LINE_ID      FI_UNLIQUIDATE_LINE.SLIP_LINE_ID%TYPE;        -- 기발생된 전표ID
    V_GL_DATE           FI_UNLIQUIDATE_LINE.GL_DATE%TYPE;             -- 기발생된 회계일자    
        
    V_REM_AMOUNT        FI_UNLIQUIDATE_LINE.GL_AMOUNT%TYPE;           -- 반제될잔액(원화)
    V_REM_CURR_AMT      FI_UNLIQUIDATE_LINE.GL_CURRENCY_AMOUNT%TYPE;  -- 반제될잔액(외화)
--    V_MANAGEMENT1       FI_UNLIQUIDATE_LINE.MANAGEMENT1%TYPE;         -- 관리항목1
--    V_MANAGEMENT2       FI_UNLIQUIDATE_LINE.MANAGEMENT2%TYPE;         -- 관리항목2
    V_TMP_AMT           FI_UNLIQUIDATE_LINE.GL_AMOUNT%TYPE;           -- 반제금액(원화)
    V_TMP_CURR_AMT      FI_UNLIQUIDATE_LINE.GL_CURRENCY_AMOUNT%TYPE;  -- 반제금액(외화)
    
    V_VAN_AMT           FI_UNLIQUIDATE_LINE.GL_AMOUNT%TYPE;           -- 반제시킬금액(원화)
    V_VAN_CURR_AMT      FI_UNLIQUIDATE_LINE.GL_CURRENCY_AMOUNT%TYPE;  -- 반제시킬금액(외화)
    V_SLIP_STATUS       FI_UNLIQUIDATE_HEADER.SLIP_STATUS%TYPE;         -- 미청산STATUS  N 미반제, P-부분, V-미반영 반제, C-완료 
    V_DEL_CNT           NUMBER(2);                      -- 삭제건수
    
    V_ERRTEXT           VARCHAR2(100);

    E_SELECT_ERR1       EXCEPTION;
    E_SELECT_ERR2       EXCEPTION;
    E_SELECT_ERR3       EXCEPTION;
    E_SELECT_ERR4       EXCEPTION;
    
    E_INSERT_ERR1       EXCEPTION;
    E_UPDATE_ERR1       EXCEPTION;
    E_DELETE_ERR1       EXCEPTION;

    E_SELECT_ERR_INSDT1 EXCEPTION;
    E_SELECT_ERR_INSDT2 EXCEPTION;
    E_INSERT_ERR_INSDT1 EXCEPTION;
    E_UPDATE_ERR_INSDT1 EXCEPTION;

--  미청산(반제:대변발생) 계정인경우  개별반제 TABLE(FI_UNLIQUIDATE_LINE)에 INSERT.
--  미청산 TABLE(FI_UNLIQUIDATE_HEADER)에 UPDATE

BEGIN

    IF P_GB = 'I' THEN
    
        -- 미청산전표번호가 있을경우
        IF TRIM(P_UNLIQUIDATE_SLIP_LINE_ID) IS NOT NULL THEN
				
                BEGIN
                    SELECT  GL_REMAIN_AMOUNT,   GL_REMAIN_CURRENCY_AMOUNT
                      INTO  V_REM_AMOUNT,       V_REM_CURR_AMT
                      FROM  FI_UNLIQUIDATE_HEADER
                     WHERE  SLIP_LINE_ID = P_UNLIQUIDATE_SLIP_LINE_ID
                       AND  SOB_ID       = P_SOB_ID ;
                
                EXCEPTION WHEN NO_DATA_FOUND THEN
                    RAISE E_SELECT_ERR1;
                END;
                
                BEGIN
                    INSERT INTO FI_UNLIQUIDATE_LINE
                      ( SLIP_LINE_ID,					SOB_ID,
                        ORG_ID,						    LIQUIDATE_SLIP_LINE_ID,
                        PERIOD_NAME,
                        GL_DATE,						  GL_NUM,
                        ACCOUNT_BOOK_ID,			SLIP_TYPE,
                        ACCOUNT_CONTROL_ID,		ACCOUNT_CODE,
                        ACCOUNT_DR_CR,				CUSTOMER_ID,
                        GL_AMOUNT,					  GL_CURRENCY_AMOUNT,
                        CURRENCY_CODE,				EXCHANGE_RATE,					
                        MANAGEMENT1,					MANAGEMENT2,
                        REFER_DATE1,					REFER_DATE2,
                        REMARK,						    CREATION_DATE,
                        CREATED_BY,					  LAST_UPDATE_DATE,
                        LAST_UPDATED_BY   )
  
                    VALUES
                      (	P_UNLIQUIDATE_SLIP_LINE_ID,				P_SOB_ID,
                      	P_ORG_ID, 								        P_SLIP_LINE_ID,
                        P_PERIOD_NAME,
                      	P_GL_DATE,								        P_GL_NUM,
                      	P_ACCOUNT_BOOK_ID,						    P_SLIP_TYPE,
                      	P_ACCOUNT_CONTROL_ID,					    P_ACCOUNT_CODE,
                      	P_ACCOUNT_DR_CR,						      P_CUSTOMER_ID,
                      	P_GL_AMOUNT,							        P_GL_CURRENCY_AMOUNT,
                      	P_CURRENCY_CODE,               		P_EXCHANGE_RATE,
                      	P_MANAGEMENT1,							      P_MANAGEMENT2,
                      	P_REFER_DATE1,							      P_REFER_DATE2,
                      	P_REMARK,								          P_CREATION_DATE,
                      	P_CREATED_BY,							        P_LAST_UPDATE_DATE,
                      	P_LAST_UPDATED_BY   );

                EXCEPTION WHEN DUP_VAL_ON_INDEX THEN
                    V_ERRTEXT := SQLCODE || ' : ' || SQLERRM;
                    RAISE E_INSERT_ERR1;
                END;
                
                BEGIN
                    IF (V_REM_AMOUNT = P_GL_AMOUNT  AND V_REM_CURR_AMT = P_GL_CURRENCY_AMOUNT) THEN
                       V_SLIP_STATUS := 'C';
                    ELSE
                       V_SLIP_STATUS := 'P';
                    END IF;
                      
                
                    UPDATE FI_UNLIQUIDATE_HEADER
                       SET GL_REMAIN_AMOUNT          = GL_REMAIN_AMOUNT           - P_GL_AMOUNT,
                           GL_REMAIN_CURRENCY_AMOUNT = GL_REMAIN_CURRENCY_AMOUNT  - P_GL_CURRENCY_AMOUNT,
                           SLIP_STATUS               = V_SLIP_STATUS
                     WHERE SLIP_LINE_ID = P_UNLIQUIDATE_SLIP_LINE_ID
                       AND SOB_ID       = P_SOB_ID ;

                EXCEPTION WHEN OTHERS THEN
                    V_ERRTEXT := SQLCODE || ' : ' || SQLERRM;
                    RAISE E_UPDATE_ERR1;
                END;

        ELSE
        
        -- 미청산전표번호가 없을경우 --> 선입선출 반제처리
            V_DEL_CNT      := 0;
            V_TMP_AMT      := P_GL_AMOUNT;
            V_TMP_CURR_AMT := P_GL_CURRENCY_AMOUNT;
            V_VAN_AMT      := 0;
            V_VAN_CURR_AMT := 0;

		  -- DBMS_OUTPUT.PUT_LINE ( 'P_SOB_ID'||P_SOB_ID||'A' );
		  -- DBMS_OUTPUT.PUT_LINE ( 'P_ACCOUNT_CONTROL_ID'||P_ACCOUNT_CONTROL_ID||'A' );
		  -- DBMS_OUTPUT.PUT_LINE ( 'P_CUSTOMER_ID'||P_CUSTOMER_ID||'A' );
		  -- DBMS_OUTPUT.PUT_LINE ( 'P_MANAGEMENT1'||P_MANAGEMENT1||'A' );
		  -- DBMS_OUTPUT.PUT_LINE ( 'P_MANAGEMENT2'||P_MANAGEMENT2||'A' );
	
	          DECLARE CURSOR DT_CURS IS
	              SELECT  SLIP_LINE_ID, GL_DATE,  GL_REMAIN_AMOUNT, GL_REMAIN_CURRENCY_AMOUNT
	                FROM  FI_UNLIQUIDATE_HEADER
	               WHERE  SOB_ID               = P_SOB_ID
	                 AND  ACCOUNT_CONTROL_ID   = P_ACCOUNT_CONTROL_ID
	                 AND  CUSTOMER_ID          = P_CUSTOMER_ID
	                 AND  NVL(MANAGEMENT1,'-') = NVL(P_MANAGEMENT1,'-')
	                 AND  NVL(MANAGEMENT2,'-') = NVL(P_MANAGEMENT2,'-')
                   AND  NVL(REFER1,'-')      = NVL(P_REFER1,'-')
                   AND  NVL(REFER2,'-')      = NVL(P_REFER2,'-')
                   AND  NVL(REFER3,'-')      = NVL(P_REFER3,'-')
                   AND  NVL(REFER4,'-')      = NVL(P_REFER4,'-')
                   AND  NVL(REFER5,'-')      = NVL(P_REFER5,'-')
/*                   AND  NVL(REFER6,'-')      = NVL(P_REFER6,'-')
                   AND  NVL(REFER7,'-')      = NVL(P_REFER7,'-')
                   AND  NVL(REFER8,'-')      = NVL(P_REFER8,'-')
                   AND  NVL(REFER9,'-')      = NVL(P_REFER9,'-')*/
	                 AND (GL_REMAIN_AMOUNT  > 0  OR GL_REMAIN_CURRENCY_AMOUNT > 0 )
					  ORDER BY SLIP_LINE_ID, GL_DATE;
	
	          BEGIN
	
	          OPEN  DT_CURS;
	
	          LOOP
	
					    IF V_TMP_AMT = 0 AND V_TMP_CURR_AMT = 0 THEN
	               EXIT;
	            END IF;
	
			            FETCH DT_CURS INTO V_SLIP_LINE_ID, V_GL_DATE, V_REM_AMOUNT, V_REM_CURR_AMT;
			
			            EXIT WHEN  DT_CURS%NOTFOUND;
			
-- 					DBMS_OUTPUT.PUT_LINE ( 'V_SLIP_LINE_ID'||TO_CHAR(V_SLIP_LINE_ID));
-- 					DBMS_OUTPUT.PUT_LINE ( 'V_TMP_AMT'||TO_CHAR(V_TMP_AMT));
-- 					DBMS_OUTPUT.PUT_LINE ( 'V_REM_AMOUNT'||TO_CHAR(V_REM_AMOUNT));
-- 					DBMS_OUTPUT.PUT_LINE ( 'V_TMP_CURR_AMT'||TO_CHAR(V_TMP_CURR_AMT));
-- 					DBMS_OUTPUT.PUT_LINE ( 'V_REM_CURR_AMT'||TO_CHAR(V_REM_CURR_AMT));
								
			            IF   V_TMP_AMT > V_REM_AMOUNT OR V_TMP_CURR_AMT > V_REM_CURR_AMT THEN
			                   
			                 V_TMP_AMT      := V_TMP_AMT      - V_REM_AMOUNT;
			                 V_TMP_CURR_AMT := V_TMP_CURR_AMT - V_REM_CURR_AMT;
			                 V_VAN_AMT      := V_REM_AMOUNT;
			                 V_VAN_CURR_AMT := V_REM_CURR_AMT;
                       V_SLIP_STATUS  := 'C';
									
					    -- DBMS_OUTPUT.PUT_LINE ( '11');
			            ELSE
			                 V_VAN_AMT      := V_TMP_AMT;
			                 V_VAN_CURR_AMT := V_TMP_CURR_AMT;
			                 V_TMP_AMT      :=  0;
			                 V_TMP_CURR_AMT :=  0;
                       V_SLIP_STATUS  := 'P';
									
					    -- DBMS_OUTPUT.PUT_LINE ( '22');
			            END IF;
	
		                    BEGIN
	                    	
	                        INSERT INTO FI_UNLIQUIDATE_LINE
                            ( SLIP_LINE_ID,					  SOB_ID,
                						  ORG_ID,						      LIQUIDATE_SLIP_LINE_ID,
                              PERIOD_NAME,
                						  GL_DATE,						    GL_NUM,
                						  ACCOUNT_BOOK_ID,				SLIP_TYPE,
                						  ACCOUNT_CONTROL_ID,			ACCOUNT_CODE,
                						  ACCOUNT_DR_CR,				  CUSTOMER_ID,
                						  GL_AMOUNT,					    GL_CURRENCY_AMOUNT,                						  
                						  CURRENCY_CODE,				  EXCHANGE_RATE,					
                						  MANAGEMENT1,					  MANAGEMENT2,
                						  REFER_DATE1,					  REFER_DATE2,
                						  REMARK,						      CREATION_DATE,
                						  CREATED_BY,					    LAST_UPDATE_DATE,
                						  LAST_UPDATED_BY   )
	                        VALUES
	                        (   V_SLIP_LINE_ID,			    P_SOB_ID,
	                            P_ORG_ID,				        P_SLIP_LINE_ID,
                              P_PERIOD_NAME,
	                            P_GL_DATE,              P_GL_NUM,
	                            P_ACCOUNT_BOOK_ID,      P_SLIP_TYPE,                              
                              P_ACCOUNT_CONTROL_ID,   P_ACCOUNT_CODE,
                              P_ACCOUNT_DR_CR,        P_CUSTOMER_ID,
	                            V_VAN_AMT,				      V_VAN_CURR_AMT,	                            
	                            P_CURRENCY_CODE,		    P_EXCHANGE_RATE,
	                            P_MANAGEMENT1,			    P_MANAGEMENT2,
	                            P_REFER_DATE1,			    P_REFER_DATE2,
	                            P_REMARK,				        P_CREATION_DATE,
	                            P_CREATED_BY,			      P_LAST_UPDATE_DATE,
								              P_LAST_UPDATED_BY   );
	
	                    EXCEPTION WHEN DUP_VAL_ON_INDEX THEN
	                        V_ERRTEXT := SQLCODE || ' : ' || SQLERRM;
	                        CLOSE DT_CURS;
	                        RAISE E_INSERT_ERR1;
	                    END;
	
	
	                    BEGIN
	                        UPDATE FI_UNLIQUIDATE_HEADER
	                           SET GL_REMAIN_AMOUNT          = GL_REMAIN_AMOUNT          - V_VAN_AMT,
	                               GL_REMAIN_CURRENCY_AMOUNT = GL_REMAIN_CURRENCY_AMOUNT - V_VAN_CURR_AMT,
                                 SLIP_STATUS               = V_SLIP_STATUS
	                         WHERE SLIP_LINE_ID     = V_SLIP_LINE_ID
                             AND SOB_ID           = P_SOB_ID ;
	
	                    EXCEPTION WHEN OTHERS THEN
	                        V_ERRTEXT := SQLCODE || ' : ' || SQLERRM;
	                        CLOSE DT_CURS;
	                        RAISE E_UPDATE_ERR1;
	                   END;
	
	                    V_DEL_CNT := V_DEL_CNT + 1;
	
	           END LOOP;
	
	           CLOSE DT_CURS;
	
	           END;
				
			  -- DBMS_OUTPUT.PUT_LINE ( 'V_DEL_CNT'||TO_CHAR(V_DEL_CNT));
				-- 삭제건수가 없으면 ERROR!!
            IF  V_DEL_CNT = 0 THEN
                RAISE  E_SELECT_ERR2;
            END IF;
				
			  --DBMS_OUTPUT.PUT_LINE ( 'END V_TMP_AMT'||TO_CHAR(V_TMP_AMT));
			  --DBMS_OUTPUT.PUT_LINE ( 'END V_TMP_CURR_AMT'||TO_CHAR(V_TMP_CURR_AMT));
	      -- 금액이 남으면 ERROR!!
            IF V_TMP_AMT > 0 OR V_TMP_CURR_AMT > 0 THEN
                RAISE  E_SELECT_ERR3;
            END IF;

        END IF;

    ELSE
    
    -- 삭제 --
        V_DEL_CNT      := 0;
        V_VAN_AMT      := 0;
        V_VAN_CURR_AMT := 0;

	  --DBMS_OUTPUT.PUT_LINE ( 'P_SACODE'||P_SACODE );
	  --DBMS_OUTPUT.PUT_LINE ( 'P_DATE'||P_DATE ); 
	  --DBMS_OUTPUT.PUT_LINE ( 'P_NO'||TO_CHAR(P_NO) );
	  --DBMS_OUTPUT.PUT_LINE ( 'P_SEQ'||TO_CHAR(P_SEQ) );

        DECLARE CURSOR DT_CURS IS
            SELECT SLIP_LINE_ID,		GL_AMOUNT,		GL_CURRENCY_AMOUNT
              FROM FI_UNLIQUIDATE_LINE
             WHERE LIQUIDATE_SLIP_LINE_ID  = P_SLIP_LINE_ID
             ORDER BY SLIP_LINE_ID ;
             
        BEGIN

        OPEN DT_CURS;

        LOOP

                FETCH DT_CURS INTO V_SLIP_LINE_ID,	V_VAN_AMT,  V_VAN_CURR_AMT;

                EXIT WHEN DT_CURS%NOTFOUND;

                 BEGIN
                     DELETE FROM FI_UNLIQUIDATE_LINE
                      WHERE LIQUIDATE_SLIP_LINE_ID  = P_SLIP_LINE_ID
                        AND SOB_ID                  = P_SOB_ID ;
 
                 EXCEPTION WHEN NO_DATA_FOUND THEN
                     V_ERRTEXT := SQLCODE || ' : ' || SQLERRM;
                     CLOSE DT_CURS;
                     RAISE E_DELETE_ERR1;
                 END;
 
                BEGIN
                    UPDATE FI_UNLIQUIDATE_HEADER
                       SET GL_REMAIN_AMOUNT          = GL_REMAIN_AMOUNT          + V_VAN_AMT,
                           GL_REMAIN_CURRENCY_AMOUNT = GL_REMAIN_CURRENCY_AMOUNT + V_VAN_CURR_AMT,
                           SLIP_STATUS               = 'P'
                     WHERE SLIP_LINE_ID  = V_SLIP_LINE_ID
                       AND SOB_ID        = P_SOB_ID ;

                EXCEPTION WHEN OTHERS THEN
                    V_ERRTEXT := SQLCODE || ' : ' || SQLERRM;
                    CLOSE DT_CURS;
                    RAISE E_UPDATE_ERR1;
                END;

                V_DEL_CNT := V_DEL_CNT + 1;

       END LOOP;

       CLOSE DT_CURS;

       END;

       IF V_DEL_CNT = 0 THEN
           RAISE E_SELECT_ERR4;
       END IF;

    END IF;

EXCEPTION
    WHEN E_SELECT_ERR1 THEN
         RAISE_APPLICATION_ERROR(-20001, '미청산 발생전표가 없읍니다. 확인하십시요!!~~~ '||SQLERRM||' '||V_ERRTEXT );
    WHEN E_SELECT_ERR2 THEN
        RAISE_APPLICATION_ERROR(-20001, '등록할 DATA가 없읍니다! 거래선코드를 확인하십시요 '||TO_CHAR(P_CUSTOMER_ID)||' '||SQLERRM||' '||V_ERRTEXT );
    WHEN E_SELECT_ERR3 THEN
        RAISE_APPLICATION_ERROR(-20001, '입력된금액이 반제할 금액보다 더 큽니다! 금액을 확인하십시요!! '||SQLERRM||' '||V_ERRTEXT );
    WHEN E_SELECT_ERR4 THEN
        RAISE_APPLICATION_ERROR(-20001, '삭제할 DATA가 없읍니다! 전표번호를 확인하십시요! '||SQLERRM||' '||V_ERRTEXT );
    WHEN E_INSERT_ERR1 THEN
        RAISE_APPLICATION_ERROR(-20001, '미청산 전표등록 ERROR!! 발생전표가 없읍니다! 전표번호를 확인하십시요! '||SQLERRM||' '||V_ERRTEXT );
    WHEN E_UPDATE_ERR1 THEN
        RAISE_APPLICATION_ERROR(-20001, '미청산 전표수정 ERROR!! 발생전표가 없읍니다! 전표번호를 확인하십시요! '||SQLERRM||' '||V_ERRTEXT );
    WHEN E_DELETE_ERR1 THEN
        RAISE_APPLICATION_ERROR(-20001, '미청산 전표삭제 ERROR!! 발생전표가 없읍니다! 전표번호를 확인하십시요! '||SQLERRM||' '||V_ERRTEXT );
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'FI_UNLIQUIDATE_LINE : 기타Error~~ '||SQLERRM||' '||V_ERRTEXT );
        
END FI_UNLIQUIDATE_LINE_P;
/
