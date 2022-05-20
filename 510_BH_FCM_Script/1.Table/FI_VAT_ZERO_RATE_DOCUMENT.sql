/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_VAT_ZERO_RATE_DOCUMENT
/* Description  : 영세율 매출명세서.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2013  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_VAT_ZERO_RATE_DOCUMENT
( TAX_CODE                        VARCHAR2(10)  NOT NULL,   -- 부가가치세신고기간관리 ID  
  VAT_MNG_SERIAL                  NUMBER        NOT NULL,
  SOB_ID                          NUMBER        NOT NULL,   
  ORG_ID                          NUMBER        NOT NULL,
  V_11_01_01_1                    NUMBER        DEFAULT 0,
  V_11_01_01_2                    NUMBER        DEFAULT 0,
  V_11_01_01_3                    NUMBER        DEFAULT 0,
  V_11_01_01_4                    NUMBER        DEFAULT 0,
  V_11_01_01_5                    NUMBER        DEFAULT 0,
  V_11_01_02_1                    NUMBER        DEFAULT 0,
  V_11_01_03_1                    NUMBER        DEFAULT 0,
  V_11_01_03_2                    NUMBER        DEFAULT 0,
  V_11_01_04_1                    NUMBER        DEFAULT 0,
  V_11_01_04_2                    NUMBER        DEFAULT 0,
  V_11_01_04_3                    NUMBER        DEFAULT 0,
  V_11_01_04_4                    NUMBER        DEFAULT 0,
  V_11_01_04_5                    NUMBER        DEFAULT 0,
  V_11_01_04_6                    NUMBER        DEFAULT 0,
  V_11_01_04_7                    NUMBER        DEFAULT 0,
  V_11_01_04_8                    NUMBER        DEFAULT 0,
  V_SUM_AMT                       NUMBER        DEFAULT 0,
  T_105_01_01_1                   NUMBER        DEFAULT 0,
  T_105_01_03_1                   NUMBER        DEFAULT 0,
  T_105_01_03_2                   NUMBER        DEFAULT 0,
  T_105_01_04_1                   NUMBER        DEFAULT 0,
  T_105_01_05_1                   NUMBER        DEFAULT 0,
  T_107_00_00_0                   NUMBER        DEFAULT 0,
  T_121_13_00_0                   NUMBER        DEFAULT 0,
  T_SUM_AMT                       NUMBER        DEFAULT 0,
  TOTAL_AMT                       NUMBER        DEFAULT 0,    
  ATTRIBUTE_A                     VARCHAR2(150) ,
  ATTRIBUTE_B                     VARCHAR2(150) ,
  ATTRIBUTE_C                     VARCHAR2(150) ,
  ATTRIBUTE_D                     VARCHAR2(150) ,
  ATTRIBUTE_E                     VARCHAR2(150) ,
  ATTRIBUTE_1                     NUMBER        ,
  ATTRIBUTE_2                     NUMBER        ,
  ATTRIBUTE_3                     NUMBER        ,
  ATTRIBUTE_4                     NUMBER        ,
  ATTRIBUTE_5                     NUMBER        ,
  CREATION_DATE                   DATE          NOT NULL,
  CREATED_BY                      NUMBER        NOT NULL,
  LAST_UPDATE_DATE                DATE          NOT NULL,
  LAST_UPDATED_BY                 NUMBER        NOT NULL
)TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_VAT_ZERO_RATE_DOCUMENT IS '영세율 매출명세서';
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.TAX_CODE IS '사업장코드'; 
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.VAT_MNG_SERIAL IS '부가세신고기간구분번호'; 
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.V_11_01_01_1 IS '직접수출(대행수출 포함)';
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.V_11_01_01_2 IS '중계무역/위탁판매/외국인도 또는 위탁가공무역 방식의 수출';
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.V_11_01_01_3 IS '내국신용장/구매확인서에 의하여 공급하는 재화';
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.V_11_01_01_4 IS '한국국제협력단 및 한국국제보건의료재단에 공급하는 해외반출용 재화';
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.V_11_01_01_5 IS '수탁가공무역 수출용으로 공급하는 재화';
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.V_11_01_02_1 IS '국외에서 제공하는 용역';
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.V_11_01_03_1 IS '선박/항공기에 의한 외국항행용역'; 
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.V_11_01_03_2 IS '국제복합운송계약에 의한 외국항행용역'; 
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.V_11_01_04_1 IS '국내에서 비거주자/외국법인에게 공급되는 재화 또는 용역'; 
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.V_11_01_04_2 IS '수출재화임가공용역'; 
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.V_11_01_04_3 IS '외국항행 선박/항공기 등에 공급하는 재화 또는 용역'; 
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.V_11_01_04_4 IS '국내 주재 외교공관/영사기관/국제연합과 이에 준하는 국제기구, 국제연합군 또는 미국군에게 공급하는 재화 또는 용역'; 
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.V_11_01_04_5 IS '관광진흥법에 따른 일반여행업자 또는 외국인전용 관광기념품 판매업자가 외국인관광객에게 공급하는 관광알선 용역 또는 관광기념품'; 
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.V_11_01_04_6 IS '외국인전용판매장 또는 주한외국군인 등의 전용 유흥음식점에서 공급하는 재화 또는 용역'; 
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.V_11_01_04_7 IS '외교관 등에게 공급하는 재화 또는 용역'; 
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.V_11_01_04_8 IS '외국인환자 유치용역'; 
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.V_SUM_AMT    IS '부가가치세법에 따른 영세율 적용 공급실적 합계'; 
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.T_105_01_01_1 IS '방위산업물자 및 군부대 등에 공급하는 석유류'; 
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.T_105_01_03_1 IS '도시철도건설용역'; 
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.T_105_01_03_2 IS '국가/지방자치단체에 공급하는 사회기반시설등'; 
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.T_105_01_04_1 IS '장애인용 보장구 및 장애인용 정보통신기기 등'; 
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.T_105_01_05_1 IS '농/어민 등에게 공급하는 농업용/축산업용/임업용 또는 어업용 기자재'; 
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.T_107_00_00_0 IS '외국인관광객 등에게 공급하는 재화'; 
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.T_121_13_00_0 IS '제주특별자치도 면세품판매장에서 판매하거나 제주특별자치도 면세품판매장에 공급하는 물품'; 
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.T_SUM_AMT    IS '조특법 및 그 밖의 법률에 따른 영세율 적용 공급실적 합계'; 
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.TOTAL_AMT    IS '영세율 적용 공급실적 총 합계'; 

ALTER TABLE FI_VAT_ZERO_RATE_DOCUMENT ADD CONSTRAINT FI_VAT_ZERO_RATE_DOCUMENT_PK PRIMARY KEY (TAX_CODE, VAT_MNG_SERIAL, SOB_ID, ORG_ID);
