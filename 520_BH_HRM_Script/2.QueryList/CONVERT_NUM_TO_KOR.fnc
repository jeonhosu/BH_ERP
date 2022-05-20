CREATE OR REPLACE FUNCTION CONVERT_NUM_TO_KOR
                          ( P_NUMBER             IN NUMBER
                          ) RETURN VARCHAR2
  AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : CONVERT_NUM_TO_KOR
/* Description  : 숫자를 변환해서 한글로 표시함
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
    V_STRING                       VARCHAR2(500);
  BEGIN
    BEGIN
      SELECT
            REPLACE(
            REGEXP_REPLACE(
            REGEXP_REPLACE(
            REGEXP_REPLACE(
            REGEXP_REPLACE(
            TRANSLATE(LPAD(P_NUMBER, 20, '0'), '1234567890', '일이삼사오육칠팔구영')
            , '(.)' , '\1 ' )
            , '([^ ]) ([^ ]) ([^ ]) ([^ ])', '\1천\2백\3십\4')
            , '(.*) (.*) (.*) (.*) (.*)'
            , '\1조 \2억 \3만 \4 ')
            , '(영.)', '')
            , ' ', '') AS KOR
        INTO V_STRING
        FROM  DUAL ;
    EXCEPTION WHEN OTHERS THEN
      V_STRING := NULL;
    END;

    RETURN V_STRING;

  END CONVERT_NUM_TO_KOR;
/
