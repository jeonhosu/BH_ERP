CREATE OR REPLACE FUNCTION CONVERT_NUM_TO_KOR
                          ( P_NUMBER             IN NUMBER
                          ) RETURN VARCHAR2
  AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : CONVERT_NUM_TO_KOR
/* Description  : ���ڸ� ��ȯ�ؼ� �ѱ۷� ǥ����
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
            TRANSLATE(LPAD(P_NUMBER, 20, '0'), '1234567890', '���̻�����ĥ�ȱ���')
            , '(.)' , '\1 ' )
            , '([^ ]) ([^ ]) ([^ ]) ([^ ])', '\1õ\2��\3��\4')
            , '(.*) (.*) (.*) (.*) (.*)'
            , '\1�� \2�� \3�� \4 ')
            , '(��.)', '')
            , ' ', '') AS KOR
        INTO V_STRING
        FROM  DUAL ;
    EXCEPTION WHEN OTHERS THEN
      V_STRING := NULL;
    END;

    RETURN V_STRING;

  END CONVERT_NUM_TO_KOR;
/
