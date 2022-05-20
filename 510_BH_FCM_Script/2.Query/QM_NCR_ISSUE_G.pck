CREATE OR REPLACE PACKAGE QM_NCR_ISSUE_G
AS

/******************************************************************************/
/* Project      : QLMF ERP
/* Module       :
/* Program Name : QM_NCR_ISSUE_G
/* Description  : 품질 부적합 관리
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 10-APRIL-2014  J.LAKE            Initialize
/******************************************************************************/

----------------------------------------------------------------------------------------
-- 품질부적합 발생 리스트 조회                                                        --
----------------------------------------------------------------------------------------
  PROCEDURE SELECT_NCR_ISSUE_LIST
            ( P_CURSOR                        OUT TYPES.TCURSOR
            , W_SOB_ID                        IN  QM_NCR_ISSUE.SOB_ID%TYPE
            , W_ORG_ID                        IN  QM_NCR_ISSUE.ORG_ID%TYPE
            , W_CONNECT_USER_ID               IN  QM_NCR_ISSUE.CREATED_BY%TYPE
            , W_ISSUE_DATE_FR                 IN  QM_NCR_ISSUE.ISSUE_DATE%TYPE
            , W_ISSUE_DATE_TO                 IN  QM_NCR_ISSUE.ISSUE_DATE%TYPE
            , W_WORKCENTER_ID                 IN  QM_NCR_ISSUE.WORKCENTER_ID%TYPE 
            , W_CAUSE_WORKCENTER_ID           IN  QM_NCR_ISSUE.CAUSE_WORKCENTER_ID%TYPE 
            , W_INVENTORY_ITEM_ID             IN  QM_NCR_ISSUE.INVENTORY_ITEM_ID%TYPE
            , W_JOB_NO                        IN  VARCHAR2
            , W_REJECT_TYPE_ID                IN  QM_NCR_ISSUE.REJECT_TYPE_ID%TYPE
            , W_NCR_STATUS                    IN  QM_NCR_ISSUE.NCR_STATUS%TYPE
            );

----------------------------------------------------------------------------------------
-- 품질부적합 발생 JOB 리스트 조회                                                    --
----------------------------------------------------------------------------------------
  PROCEDURE SELECT_NCR_ISSUE_JOB_LIST
            ( P_CURSOR1                       OUT TYPES.TCURSOR1
            , W_SOB_ID                        IN  QM_NCR_ISSUE.SOB_ID%TYPE
            , W_ORG_ID                        IN  QM_NCR_ISSUE.ORG_ID%TYPE
            , W_NCR_ISSUE_ID                  IN  QM_NCR_ISSUE.NCR_ISSUE_ID%TYPE 
            );

----------------------------------------------------------------------------------------
-- 품질부적합 발생 상세 조회                                                          --
----------------------------------------------------------------------------------------
  PROCEDURE SELECT_NCR_ISSUE_DETAIL	 
            ( P_CURSOR                        OUT TYPES.TCURSOR
            , W_SOB_ID                        IN  QM_NCR_ISSUE.SOB_ID%TYPE
            , W_ORG_ID                        IN  QM_NCR_ISSUE.ORG_ID%TYPE
            , W_CONNECT_USER_ID               IN  QM_NCR_ISSUE.CREATED_BY%TYPE
            , W_NCR_ISSUE_ID                  IN  QM_NCR_ISSUE.NCR_ISSUE_ID%TYPE 
            );

----------------------------------------------------------------------------------------
-- 품질부적합 발생 상세 INSERT                                                        --
----------------------------------------------------------------------------------------                                 
  PROCEDURE INSERT_NCR_ISSUE
            ( P_NCR_ISSUE_ID         OUT QM_NCR_ISSUE.NCR_ISSUE_ID%TYPE
            , P_SOB_ID               IN  QM_NCR_ISSUE.SOB_ID%TYPE
            , P_ORG_ID               IN  QM_NCR_ISSUE.ORG_ID%TYPE
            , P_NCR_ISSUE_NO         OUT QM_NCR_ISSUE.NCR_ISSUE_NO%TYPE
            , P_WORKCENTER_ID        IN  QM_NCR_ISSUE.WORKCENTER_ID%TYPE
            , P_OPERATION_ID         IN  QM_NCR_ISSUE.OPERATION_ID%TYPE
            , P_INVENTORY_ITEM_ID    IN  QM_NCR_ISSUE.INVENTORY_ITEM_ID%TYPE
            , P_BOM_ITEM_ID          IN  QM_NCR_ISSUE.BOM_ITEM_ID%TYPE
            , P_ISSUE_DATE           IN  QM_NCR_ISSUE.ISSUE_DATE%TYPE
            , P_CAUSE_WORKCENTER_ID  IN  QM_NCR_ISSUE.CAUSE_WORKCENTER_ID%TYPE
            , P_CAUSE_OPERATION_ID   IN  QM_NCR_ISSUE.CAUSE_OPERATION_ID%TYPE
            , P_PROBLEM_CLASS        IN  QM_NCR_ISSUE.PROBLEM_CLASS%TYPE
            , P_REJECT_DIVISION_CODE IN  QM_NCR_ISSUE.REJECT_DIVISION_CODE%TYPE
            , P_REJECT_TYPE_ID       IN  QM_NCR_ISSUE.REJECT_TYPE_ID%TYPE
            , P_PROBLEM_LEVEL_CODE   IN  QM_NCR_ISSUE.PROBLEM_LEVEL_CODE%TYPE
            , P_ISSUE_COMMENT        IN  QM_NCR_ISSUE.ISSUE_COMMENT%TYPE
            , P_ISSUE_DESCRIPTION    IN  QM_NCR_ISSUE.ISSUE_DESCRIPTION%TYPE
            , P_USER_ID              IN  QM_NCR_ISSUE.CREATED_BY%TYPE
            );
            
----------------------------------------------------------------------------------------
-- 품질부적합 발생 상세 UPDATE                                                        --
----------------------------------------------------------------------------------------          
  PROCEDURE UPDATE_NCR_ISSUE
            ( W_NCR_ISSUE_ID         IN  QM_NCR_ISSUE.NCR_ISSUE_ID%TYPE
            , P_SOB_ID               IN  QM_NCR_ISSUE.SOB_ID%TYPE
            , P_ORG_ID               IN  QM_NCR_ISSUE.ORG_ID%TYPE
            , P_NCR_ISSUE_NO         IN  QM_NCR_ISSUE.NCR_ISSUE_NO%TYPE
            , P_WORKCENTER_ID        IN  QM_NCR_ISSUE.WORKCENTER_ID%TYPE
            , P_OPERATION_ID         IN  QM_NCR_ISSUE.OP_TYPE_ID%TYPE
            , P_INVENTORY_ITEM_ID    IN  QM_NCR_ISSUE.INVENTORY_ITEM_ID%TYPE
            , P_BOM_ITEM_ID          IN  QM_NCR_ISSUE.BOM_ITEM_ID%TYPE
            , P_ISSUE_DATE           IN  QM_NCR_ISSUE.ISSUE_DATE%TYPE
            , P_CAUSE_WORKCENTER_ID  IN  QM_NCR_ISSUE.CAUSE_WORKCENTER_ID%TYPE
            , P_CAUSE_OPERATION_ID   IN  QM_NCR_ISSUE.CAUSE_OPERATION_ID%TYPE
            , P_PROBLEM_CLASS        IN  QM_NCR_ISSUE.PROBLEM_CLASS%TYPE
            , P_REJECT_DIVISION_CODE IN  QM_NCR_ISSUE.REJECT_DIVISION_CODE%TYPE
            , P_REJECT_TYPE_ID       IN  QM_NCR_ISSUE.REJECT_TYPE_ID%TYPE
            , P_PROBLEM_LEVEL_CODE   IN  QM_NCR_ISSUE.PROBLEM_LEVEL_CODE%TYPE
            , P_ISSUE_COMMENT        IN  QM_NCR_ISSUE.ISSUE_COMMENT%TYPE
            , P_ISSUE_DESCRIPTION    IN  QM_NCR_ISSUE.ISSUE_DESCRIPTION%TYPE
            , P_USER_ID              IN  QM_NCR_ISSUE.CREATED_BY%TYPE
            );

----------------------------------------------------------------------------------------
-- 품질부적합 발생 상세 DELETE                                                        --
----------------------------------------------------------------------------------------          
  PROCEDURE DELETE_NCR_ISSUE
            ( W_NCR_ISSUE_ID         IN QM_NCR_ISSUE.NCR_ISSUE_ID%TYPE
            , P_SOB_ID               IN QM_NCR_ISSUE.SOB_ID%TYPE
            , P_ORG_ID               IN QM_NCR_ISSUE.ORG_ID%TYPE
            , P_NCR_ISSUE_NO         IN QM_NCR_ISSUE.NCR_ISSUE_NO%TYPE
            , P_USER_ID              IN QM_NCR_ISSUE.CREATED_BY%TYPE
            );
                                               
----------------------------------------------------------------------------------------
-- 품질부적합 발생 JOB 조회 및 등록                                                   --
----------------------------------------------------------------------------------------
  PROCEDURE SELECT_NCR_ISSUE_JOB
            ( P_CURSOR1                       OUT TYPES.TCURSOR1
            , W_SOB_ID                        IN  QM_NCR_ISSUE.SOB_ID%TYPE
            , W_ORG_ID                        IN  QM_NCR_ISSUE.ORG_ID%TYPE
            , W_NCR_ISSUE_ID                  IN  QM_NCR_ISSUE.NCR_ISSUE_ID%TYPE 
            );

----------------------------------------------------------------------------------------
-- 품질부적합 발생 JOB 등록                                                           --
----------------------------------------------------------------------------------------
  PROCEDURE INSERT_NCR_JOB
            ( P_SOB_ID         IN  QM_NCR_JOB.SOB_ID%TYPE
            , P_ORG_ID         IN  QM_NCR_JOB.ORG_ID%TYPE
            , P_NCR_ISSUE_ID   IN  QM_NCR_JOB.NCR_ISSUE_ID%TYPE
            , P_JOB_ID         IN  QM_NCR_JOB.JOB_ID%TYPE
            , P_JOB_NO         IN  QM_NCR_JOB.JOB_NO%TYPE
            , P_WORKING_UOM    IN  QM_NCR_JOB.WORKING_UOM%TYPE
            , P_WORK_UOM_QTY   IN  QM_NCR_JOB.WORK_UOM_QTY%TYPE
            , P_REJECT_UOM_QTY IN  QM_NCR_JOB.REJECT_UOM_QTY%TYPE
            , P_USER_ID        IN  QM_NCR_JOB.CREATED_BY%TYPE 
            );

----------------------------------------------------------------------------------------
-- 품질부적합 발생 JOB 수정 : 수량만 수정                                             --
----------------------------------------------------------------------------------------                       
  PROCEDURE UPDATE_NCR_JOB
            ( W_SOB_ID         IN QM_NCR_JOB.SOB_ID%TYPE
            , W_ORG_ID         IN QM_NCR_JOB.ORG_ID%TYPE
            , W_NCR_ISSUE_ID   IN QM_NCR_JOB.NCR_ISSUE_ID%TYPE
            , W_JOB_ID         IN QM_NCR_JOB.JOB_ID%TYPE
            , W_JOB_NO         IN QM_NCR_JOB.JOB_NO%TYPE
            , P_WORKING_UOM    IN QM_NCR_JOB.WORKING_UOM%TYPE
            , P_WORK_UOM_QTY   IN QM_NCR_JOB.WORK_UOM_QTY%TYPE
            , P_REJECT_UOM_QTY IN QM_NCR_JOB.REJECT_UOM_QTY%TYPE
            , P_USER_ID        IN QM_NCR_JOB.CREATED_BY%TYPE 
            );

----------------------------------------------------------------------------------------
-- 품질부적합 발생 JOB 삭제                                                           --
----------------------------------------------------------------------------------------                       
  PROCEDURE DELETE_NCR_JOB
            ( W_SOB_ID         IN QM_NCR_JOB.SOB_ID%TYPE
            , W_ORG_ID         IN QM_NCR_JOB.ORG_ID%TYPE
            , W_NCR_ISSUE_ID   IN QM_NCR_JOB.NCR_ISSUE_ID%TYPE
            , W_JOB_ID         IN QM_NCR_JOB.JOB_ID%TYPE
            , W_JOB_NO         IN QM_NCR_JOB.JOB_NO%TYPE
            , P_USER_ID        IN QM_NCR_JOB.CREATED_BY%TYPE 
            );
            
            
----------------------------------------------------------------------------------------
-- 품질부적합 발생 리스트 조회 : 부적합 검토                                          --
----------------------------------------------------------------------------------------
  PROCEDURE SELECT_NCR_ISSUE_REVIEW
            ( P_CURSOR                        OUT TYPES.TCURSOR
            , W_SOB_ID                        IN  QM_NCR_ISSUE.SOB_ID%TYPE
            , W_ORG_ID                        IN  QM_NCR_ISSUE.ORG_ID%TYPE
            , W_CONNECT_USER_ID               IN  QM_NCR_ISSUE.CREATED_BY%TYPE
            , W_ISSUE_DATE_FR                 IN  QM_NCR_ISSUE.ISSUE_DATE%TYPE
            , W_ISSUE_DATE_TO                 IN  QM_NCR_ISSUE.ISSUE_DATE%TYPE
            , W_WORKCENTER_ID                 IN  QM_NCR_ISSUE.WORKCENTER_ID%TYPE 
            , W_CAUSE_WORKCENTER_ID           IN  QM_NCR_ISSUE.CAUSE_WORKCENTER_ID%TYPE 
            , W_INVENTORY_ITEM_ID             IN  QM_NCR_ISSUE.INVENTORY_ITEM_ID%TYPE
            , W_NCR_ISSUE_ID                  IN  QM_NCR_ISSUE.NCR_ISSUE_ID%TYPE 
            , W_REJECT_TYPE_ID                IN  QM_NCR_ISSUE.REJECT_TYPE_ID%TYPE
            , W_NCR_STATUS                    IN  QM_NCR_ISSUE.NCR_STATUS%TYPE
            );

----------------------------------------------------------------------------------------
-- 품질이슈 발생 수정                     --
----------------------------------------------------------------------------------------
PROCEDURE UPDATE_TROUBLE_ISSUE_MASTER
          ( W_TROUBLE_ISSUE_ID         IN QM_TROUBLE_ISSUE.TROUBLE_ISSUE_ID%TYPE
          , P_SOB_ID                   IN QM_TROUBLE_ISSUE.SOB_ID%TYPE
          , P_ORG_ID                   IN QM_TROUBLE_ISSUE.ORG_ID%TYPE
          , P_SUBJECT_NAME             IN QM_TROUBLE_ISSUE.SUBJECT_NAME%TYPE
          , P_TROUBLE_DATE             IN QM_TROUBLE_ISSUE.TROUBLE_DATE%TYPE
          , P_WEEKLY                   IN QM_TROUBLE_ISSUE.WEEKLY%TYPE
          , P_MEASURE_REQ_DATE         IN QM_TROUBLE_ISSUE.MEASURE_REQ_DATE%TYPE
          , P_MEASURE_PERSON_USER_ID   IN QM_TROUBLE_ISSUE.MEASURE_PERSON_USER_ID%TYPE
          , P_PROJECT_ID               IN QM_TROUBLE_ISSUE.PROJECT_ID%TYPE
          , P_OPERATION_ID             IN QM_TROUBLE_ISSUE.OPERATION_ID%TYPE
          , P_INVENTORY_ITEM_ID        IN QM_TROUBLE_ISSUE.INVENTORY_ITEM_ID%TYPE
          , P_BOM_ITEM_ID              IN QM_TROUBLE_ISSUE.BOM_ITEM_ID%TYPE
          , P_TROUBLE_CLASS_CODE       IN QM_TROUBLE_ISSUE.TROUBLE_CLASS_CODE%TYPE
          , P_PROBLEM_CLASS            IN QM_TROUBLE_ISSUE.PROBLEM_CLASS%TYPE
          , P_TROUBLE_RATE             IN QM_TROUBLE_ISSUE.TROUBLE_RATE%TYPE
          , P_TROUBLE_QTY              IN QM_TROUBLE_ISSUE.TROUBLE_QTY%TYPE
          , P_WORK_QTY                 IN QM_TROUBLE_ISSUE.WORK_QTY%TYPE
          , P_REJECT_CLASS_CODE        IN QM_TROUBLE_ISSUE.REJECT_CLASS_CODE%TYPE
          , P_REJECT_TYPE_CODE         IN QM_TROUBLE_ISSUE.REJECT_TYPE_CODE%TYPE
          , P_TROUBLE_COMMENT          IN QM_TROUBLE_ISSUE.TROUBLE_COMMENT%TYPE
          , P_FACTORY_LCODE            IN QM_TROUBLE_ISSUE.FACTORY_LCODE%TYPE
          , P_WORKCENTER_ID            IN QM_TROUBLE_ISSUE.WORKCENTER_ID%TYPE
          , P_DESCRIPTION              IN QM_TROUBLE_ISSUE.DESCRIPTION%TYPE
          , P_MEASURE_CHARGE_PRESON_ID IN QM_TROUBLE_ISSUE.MEASURE_CHARGE_PRESON_ID%TYPE
          , P_CUSTOMER_SITE_CODE       IN QM_TROUBLE_ISSUE.CUSTOMER_SITE_CODE%TYPE
          --, P_APPROVER_USER_ID         IN QM_TROUBLE_ISSUE.APPROVER_USER_ID%TYPE
          --, P_STATUS_LCODE             IN QM_TROUBLE_ISSUE.STATUS_LCODE%TYPE
          , P_USER_ID                  IN QM_TROUBLE_ISSUE.CREATED_BY%TYPE
          );

----------------------------------------------------------------------------------------
-- 품질부적합 발생 : 부적합 등록 완료 및 승인 요청 상태 변경                          --
----------------------------------------------------------------------------------------          
  PROCEDURE SET_NCR_ISSUE_REQ_APPR
            ( W_NCR_ISSUE_ID         IN  QM_NCR_ISSUE.NCR_ISSUE_ID%TYPE
            , W_SOB_ID               IN  QM_NCR_ISSUE.SOB_ID%TYPE
            , W_ORG_ID               IN  QM_NCR_ISSUE.ORG_ID%TYPE
            , W_REQ_STATUS           IN  VARCHAR2
            , O_STATUS               OUT VARCHAR2
            , O_MESSAGE              OUT VARCHAR2
            );
            
----------------------------------------------------------------------------------------
-- 품질부적합 발생 : 부적합 LOT 정보 리턴                                             --
----------------------------------------------------------------------------------------          
  PROCEDURE GET_NCR_JOB_P
            ( W_JOB_NO               IN  VARCHAR2 
            , W_SOB_ID               IN  NUMBER
            , W_ORG_ID               IN  NUMBER 
            , O_STATUS               OUT VARCHAR2
            , O_MESSAGE              OUT VARCHAR2 
            , O_JOB_ID               OUT NUMBER
            , O_JOB_NO               OUT VARCHAR2 
            , O_INVENTORY_ITEM_ID    OUT NUMBER 
            , O_BOM_ITEM_ID          OUT NUMBER
            , O_UOM_CODE             OUT VARCHAR2 
            , O_ONHAND_QTY           OUT NUMBER 
            );
            
----------------------------------------------------------------------------------------
-- 품질부적합 발생 : 해당 NCR ISSUE 상태 리턴                                         --
----------------------------------------------------------------------------------------          
  FUNCTION GET_NCR_ISSUE_STATUS_F
            ( W_NCR_ISSUE_ID         IN  QM_NCR_ISSUE.NCR_ISSUE_ID%TYPE
            , P_SOB_ID               IN  QM_NCR_ISSUE.SOB_ID%TYPE
            , P_ORG_ID               IN  QM_NCR_ISSUE.ORG_ID%TYPE
            ) RETURN VARCHAR2;
                      
--------------------------------------------------------------------
-- 품질 부적합 리스트 룩업 : 권한에 대한 NCR만 조회               --
--------------------------------------------------------------------
  PROCEDURE LU_NCR_ISSUE_CAP
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_SOB_ID               IN  NUMBER 
            , W_ORG_ID               IN  NUMBER 
            , W_CONNECT_USER_ID      IN  NUMBER 
            , W_NCR_ISSUE_NO         IN  VARCHAR2 
            );

-----------------------------------------------------
-- 품질 부적합 리스트 룩업 : 전체 조회             --
-----------------------------------------------------
  PROCEDURE LU_NCR_ISSUE_ALL
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_SOB_ID               IN  NUMBER 
            , W_ORG_ID               IN  NUMBER 
            , W_CONNECT_PERSON_ID    IN  NUMBER 
            , W_NCR_ISSUE_NO         IN  VARCHAR2 
            );
                        
-----------------------------------------------------------------------
-- LU_INVENTORY_ITEM : 영업제품(ENABLED_FLAG = 'Y')                  --
-----------------------------------------------------------------------
  PROCEDURE LU_INVENTORY_ITEM 
            ( P_CURSOR              OUT TYPES.TCURSOR
            , W_SOB_ID              IN  NUMBER
            , W_ORG_ID              IN  NUMBER
            , W_CUSTOMER_ID         IN  NUMBER
            , W_ITEM_ALIAS          IN  VARCHAR2
            );

--------------------------------------------
-- BOM_ITEM : 내부모델                    --
--------------------------------------------
  PROCEDURE LU_BOM_ITEM 
            ( P_CURSOR              OUT TYPES.TCURSOR
            , W_SOB_ID              IN  NUMBER
            , W_ORG_ID              IN  NUMBER
            , W_INVENTORY_ITEM_ID   IN  NUMBER 
            );

-----------------------------------------------------
-- OPERATION_TYPE : 작업공정 중분류                --
-----------------------------------------------------
  PROCEDURE LU_OPERATION_TYPE    
            ( P_CURSOR             OUT TYPES.TCURSOR
            , W_SOB_ID             IN  NUMBER
            , W_ORG_ID             IN  NUMBER
            , W_OPERATION_CLASS_ID IN  NUMBER
            );

-----------------------------------------------------
-- OPERATION : 작업공정                            --
-----------------------------------------------------
  PROCEDURE LU_OPERATION    
            ( P_CURSOR             OUT TYPES.TCURSOR
            , W_SOB_ID             IN  NUMBER
            , W_ORG_ID             IN  NUMBER
            , W_WORKCENTER_ID      IN  NUMBER
            , W_OPERATION_CLASS_ID IN  NUMBER
            , W_OP_TYPE_ID         IN  NUMBER 
            );
                        
--------------------------------------------------------------------------------
-- LU_USER_CAP_WORKCENTER : 작업장(공정사용자 관리 정의된 작업장에 대해 표시) --
--------------------------------------------------------------------------------
  PROCEDURE LU_USER_CAP_WORKCENTER
            ( P_CURSOR              OUT TYPES.TCURSOR
            , W_SOB_ID              IN  NUMBER
            , W_ORG_ID              IN  NUMBER
            , W_CONNECT_USER_ID     IN  NUMBER 
            );
            
                        
-------------------------------------------------------------------------------------------------------
-- LU_MEASURE_PERSON : 대책담당자
-------------------------------------------------------------------------------------------------------
--Enabled Data --
PROCEDURE LU_MEASURE_PERSON ( P_CURSOR              OUT TYPES.TCURSOR
                            , W_SOB_ID              IN  NUMBER
                            , W_ORG_ID              IN  NUMBER
                            );
                            
---------------------------------------------
-- 해당 불량 구분에 따른 불량 공정 룩업    --
---------------------------------------------
  PROCEDURE LU_REJECT_CLASS 
            ( P_CURSOR                OUT TYPES.TCURSOR
            , W_SOB_ID                IN  NUMBER
            , W_ORG_ID                IN  NUMBER
            , W_REJECT_DIVISION_CODE  IN  VARCHAR2 
            );                            

---------------------
-- 불량 항 룩업    -- 
---------------------
  PROCEDURE LU_REJECT_TYPE 
            ( P_CURSOR              OUT TYPES.TCURSOR
            , W_SOB_ID              IN  NUMBER
            , W_ORG_ID              IN  NUMBER
            , W_REJECT_CLASS_ID     IN QM_REJECT_TYPE.REJECT_CLASS_ID%TYPE
            );


 PROCEDURE SEND_MAIL_TROUBLE_ISSUE;

END QM_NCR_ISSUE_G;
/
CREATE OR REPLACE PACKAGE BODY QM_NCR_ISSUE_G
AS

/******************************************************************************/
/* Project      : QLMF ERP
/* Module       :
/* Program Name : QM_NCR_ISSUE_G
/* Description  : 품질 부적합 관리 
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 10-APRIL-2014  J.LAKE            Initialize
/******************************************************************************/

----------------------------------------------------------------------------------------
-- 품질부적합 발생 리스트 조회                                                        --
----------------------------------------------------------------------------------------
  PROCEDURE SELECT_NCR_ISSUE_LIST
            ( P_CURSOR                        OUT TYPES.TCURSOR
            , W_SOB_ID                        IN  QM_NCR_ISSUE.SOB_ID%TYPE
            , W_ORG_ID                        IN  QM_NCR_ISSUE.ORG_ID%TYPE
            , W_CONNECT_USER_ID               IN  QM_NCR_ISSUE.CREATED_BY%TYPE
            , W_ISSUE_DATE_FR                 IN  QM_NCR_ISSUE.ISSUE_DATE%TYPE
            , W_ISSUE_DATE_TO                 IN  QM_NCR_ISSUE.ISSUE_DATE%TYPE
            , W_WORKCENTER_ID                 IN  QM_NCR_ISSUE.WORKCENTER_ID%TYPE 
            , W_CAUSE_WORKCENTER_ID           IN  QM_NCR_ISSUE.CAUSE_WORKCENTER_ID%TYPE 
            , W_INVENTORY_ITEM_ID             IN  QM_NCR_ISSUE.INVENTORY_ITEM_ID%TYPE
            , W_JOB_NO                        IN  VARCHAR2
            , W_REJECT_TYPE_ID                IN  QM_NCR_ISSUE.REJECT_TYPE_ID%TYPE
            , W_NCR_STATUS                    IN  QM_NCR_ISSUE.NCR_STATUS%TYPE
            )
  AS
    V_SYSDATE           DATE := TRUNC(GET_LOCAL_DATE(W_SOB_ID));
  BEGIN
      OPEN P_CURSOR FOR
          SELECT NI.NCR_ISSUE_ID
               , NI.NCR_ISSUE_NO
               , NI.WORKCENTER_ID
               , D_SW.WORKCENTER_CODE
               , D_SW.WORKCENTER_DESCRIPTION 
               , NI.INVENTORY_ITEM_ID
               , IM.ITEM_CODE
               , IM.ITEM_DESCRIPTION
               , IM.ITEM_LAYER_LCODE
               , IM.ITEM_TYPE_LCODE
               , NI.ISSUE_DATE
               , NI.CAUSE_WORKCENTER_ID
               , C_SW.WORKCENTER_CODE AS CAUSE_WORKCENTER_CODE
               , C_SW.WORKCENTER_DESCRIPTION AS CAUSE_WORKCENTER_DESC 
               , NI.CAUSE_OPERATION_ID 
               , C_SO.OPERATION_CODE AS CAUSE_OPERATION_CODE
               , C_SO.OPERATION_DESCRIPTION AS CAUSE_OPERATION_DESC 
               , NI.WORKING_UOM 
               , NI.WORK_UOM_QTY 
               , NI.REJECT_UOM_QTY 
               , CASE
                   WHEN NVL(NI.WORK_UOM_QTY, 0) = 0 THEN NULL
                   ELSE ROUND(NVL(NI.REJECT_UOM_QTY, 0) / NVL(NI.WORK_UOM_QTY, 0) * 100) 
                 END REJECT_RATE 
               , NI.PROBLEM_CLASS 
               , (SELECT QPC.DESCRIPTION
                   FROM QM_PROBLEM_CLASS QPC
                  WHERE QPC.PROBLEM_CLASS = NI.PROBLEM_CLASS) AS PROBLEM_CLASS_DESC
               , NI.REJECT_DIVISION_CODE 
               , (SELECT QTC.DESCRIPTION
                   FROM QM_TROUBLE_CLASS QTC
                  WHERE QTC.TROUBLE_CLASS = NI.REJECT_DIVISION_CODE) AS REJECT_DIVISION_DESC 
               , RC.REJECT_CLASS_ID 
               , RC.DESCRIPTION AS REJECT_CLASS_DESC
               , NI.REJECT_TYPE_ID                
               , RT.DESCRIPTION AS REJECT_TYPE_DESC 
               , NI.PROBLEM_LEVEL_CODE 
               , EAPP_COMMON_G.GET_LOOKUP_DESC(NI.SOB_ID, NI.ORG_ID, 'PROBLEM_LEVEL_CODE', NI.PROBLEM_LEVEL_CODE) AS PROBLEM_LEVEL_DESC 
               , NI.ISSUE_COMMENT 
               , NI.NCR_STATUS 
            FROM QM_NCR_ISSUE            NI
               , SDM_STANDARD_WORKCENTER D_SW
               , INV_ITEM_MASTER         IM
               , QM_REJECT_CLASS         RC
               , QM_REJECT_TYPE          RT
               , SDM_STANDARD_WORKCENTER C_SW 
               , SDM_STANDARD_OPERATION  C_SO
           WHERE NI.WORKCENTER_ID           = D_SW.WORKCENTER_ID 
             AND NI.INVENTORY_ITEM_ID       = IM.INVENTORY_ITEM_ID 
             AND NI.REJECT_TYPE_ID          = RT.REJECT_TYPE_ID
             AND RT.REJECT_CLASS_ID         = RC.REJECT_CLASS_ID     
             AND NI.CAUSE_WORKCENTER_ID     = C_SW.WORKCENTER_ID(+)
             AND NI.CAUSE_OPERATION_ID      = C_SO.OPERATION_ID(+) 
             AND TRUNC(NI.ISSUE_DATE)       BETWEEN W_ISSUE_DATE_FR             
                                                AND W_ISSUE_DATE_TO
             AND NI.SOB_ID                  = W_SOB_ID 
             AND NI.ORG_ID                  = W_ORG_ID 
             AND ((W_WORKCENTER_ID          IS NULL AND 1 = 1)
             OR   (W_WORKCENTER_ID          IS NOT NULL AND NI.WORKCENTER_ID = W_WORKCENTER_ID))
             AND ((W_INVENTORY_ITEM_ID      IS NULL AND 1 = 1)
             OR   (W_INVENTORY_ITEM_ID      IS NOT NULL AND NI.INVENTORY_ITEM_ID = W_INVENTORY_ITEM_ID)) 
             AND ((W_NCR_STATUS             IS NULL AND 1 = 1)
             OR   (W_NCR_STATUS             IS NOT NULL AND NI.NCR_STATUS = W_NCR_STATUS)) 
             AND ((W_CAUSE_WORKCENTER_ID    IS NULL AND 1 = 1)
             OR   (W_CAUSE_WORKCENTER_ID    IS NOT NULL AND NI.CAUSE_WORKCENTER_ID = W_CAUSE_WORKCENTER_ID)) 
             AND ((W_REJECT_TYPE_ID         IS NULL AND 1 = 1)
             OR   (W_REJECT_TYPE_ID         IS NOT NULL AND NI.REJECT_TYPE_ID = W_REJECT_TYPE_ID)) 
             AND ((W_JOB_NO                 IS NULL AND 1 = 1)
             OR   (W_JOB_NO                 IS NOT NULL AND EXISTS
                                                              ( SELECT 'X'
                                                                  FROM QM_NCR_JOB NJ
                                                                 WHERE NJ.SOB_ID        = NI.SOB_ID
                                                                   AND NJ.ORG_ID        = NI.ORG_ID
                                                                   AND NJ.NCR_ISSUE_ID  = NI.NCR_ISSUE_ID 
                                                                   AND NJ.JOB_NO        = W_JOB_NO
                                                              )))
             -- 권한 체크 -- 
             AND EXISTS
                   (SELECT 'X'
                      FROM EAPP_USER        EU
                         , WIP_USER_CONTROL UC
                     WHERE EU.USER_ID       = UC.USER_ID(+)  
                       AND EU.USER_ID       = W_CONNECT_USER_ID 
                       AND EU.SOB_ID        = W_SOB_ID 
                       AND EU.ORG_ID        = W_ORG_ID 
                       AND EU.ENABLED_FLAG  = 'Y'
                       AND EU.EFFECTIVE_DATE_FR   <= V_SYSDATE 
                       AND (EU.EFFECTIVE_DATE_TO  >= V_SYSDATE OR EU.EFFECTIVE_DATE_TO IS NULL) 
                       -- 전체 사용 권한자는 모든 작업장 표시 --
                       AND CASE
                             WHEN EU.WIP_TRX_CONTROL = 'UNLIMITED' THEN NI.WORKCENTER_ID 
                             ELSE UC.WORKCENTER_ID
                           END              = NI.WORKCENTER_ID 
                   )
          ; 
END SELECT_NCR_ISSUE_LIST;


----------------------------------------------------------------------------------------
-- 품질부적합 발생 JOB 리스트 조회                                                    --
----------------------------------------------------------------------------------------
  PROCEDURE SELECT_NCR_ISSUE_JOB_LIST
            ( P_CURSOR1                       OUT TYPES.TCURSOR1
            , W_SOB_ID                        IN  QM_NCR_ISSUE.SOB_ID%TYPE
            , W_ORG_ID                        IN  QM_NCR_ISSUE.ORG_ID%TYPE
            , W_NCR_ISSUE_ID                  IN  QM_NCR_ISSUE.NCR_ISSUE_ID%TYPE 
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT NJ.NCR_ISSUE_ID
           , NJ.JOB_ID
           , NJ.JOB_NO
           , NJ.WORK_UOM_QTY
           , NJ.REJECT_UOM_QTY
           , CASE
               WHEN NVL(NJ.WORK_UOM_QTY, 0) = 0 THEN 0
               ELSE ROUND(NVL(NJ.REJECT_UOM_QTY, 0) / NVL(NJ.WORK_UOM_QTY, 0)  * 100, 2)
             END AS REJECT_RATE 
        FROM QM_NCR_JOB NJ
       WHERE NJ.NCR_ISSUE_ID      = W_NCR_ISSUE_ID
       ORDER BY NJ.JOB_NO
      ;
  END SELECT_NCR_ISSUE_JOB_LIST;
  
----------------------------------------------------------------------------------------
-- 품질부적합 발생 상세 조회                                                        --
----------------------------------------------------------------------------------------
  PROCEDURE SELECT_NCR_ISSUE_DETAIL	 
            ( P_CURSOR                        OUT TYPES.TCURSOR
            , W_SOB_ID                        IN  QM_NCR_ISSUE.SOB_ID%TYPE
            , W_ORG_ID                        IN  QM_NCR_ISSUE.ORG_ID%TYPE
            , W_CONNECT_USER_ID               IN  QM_NCR_ISSUE.CREATED_BY%TYPE
            , W_NCR_ISSUE_ID                  IN  QM_NCR_ISSUE.NCR_ISSUE_ID%TYPE 
            )
  AS
    V_SYSDATE           DATE := TRUNC(GET_LOCAL_DATE(W_SOB_ID));
  BEGIN
      OPEN P_CURSOR FOR
          SELECT NI.NCR_ISSUE_ID
               , NI.NCR_ISSUE_NO
               , NI.ISSUE_DATE
               , NI.WORKCENTER_ID
               , D_SW.WORKCENTER_CODE
               , D_SW.WORKCENTER_DESCRIPTION AS WORKCENTER_DESC  
               , NI.OPERATION_ID 
               , D_SO.OPERATION_CODE
               , D_SO.OPERATION_DESCRIPTION AS OPERATION_DESC 
               , NI.INVENTORY_ITEM_ID
               , IM.ITEM_CODE
               , IM.ITEM_DESCRIPTION AS ITEM_DESC
               , NI.BOM_ITEM_ID
               , IR.BOM_ITEM_CODE
               , IR.BOM_ITEM_DESCRIPTION AS BOM_ITEM_DESC                
               , NI.CAUSE_WORKCENTER_ID
               , C_SW.WORKCENTER_CODE AS CAUSE_WORKCENTER_CODE
               , C_SW.WORKCENTER_DESCRIPTION AS CAUSE_WORKCENTER_DESC 
               , NI.CAUSE_OPERATION_ID   
               , C_SO.OPERATION_CODE AS CAUSE_OPERATION_CODE
               , C_SO.OPERATION_DESCRIPTION AS CAUSE_OPERATION_DESC 
               , NI.WORKING_UOM 
               , NI.WORK_UOM_QTY 
               , NI.REJECT_UOM_QTY 
               , CASE
                   WHEN NVL(NI.WORK_UOM_QTY, 0) = 0 THEN NULL
                   ELSE ROUND(NVL(NI.REJECT_UOM_QTY, 0) / NVL(NI.WORK_UOM_QTY, 0) * 100) 
                 END REJECT_RATE 
               , NI.PROBLEM_CLASS 
               , (SELECT QPC.DESCRIPTION
                   FROM QM_PROBLEM_CLASS QPC
                  WHERE QPC.PROBLEM_CLASS = NI.PROBLEM_CLASS) AS PROBLEM_CLASS_DESC
               , NI.REJECT_DIVISION_CODE 
               , (SELECT QTC.DESCRIPTION
                   FROM QM_TROUBLE_CLASS QTC
                  WHERE QTC.TROUBLE_CLASS = NI.REJECT_DIVISION_CODE) AS REJECT_DIVISION_DESC 
               , RC.REJECT_CLASS_CODE 
               , RC.DESCRIPTION AS REJECT_CLASS_DESC
               , NI.REJECT_TYPE_ID                
               , RT.REJECT_TYPE_CODE
               , RT.DESCRIPTION AS REJECT_TYPE_DESC 
               , NI.PROBLEM_LEVEL_CODE
               , EAPP_COMMON_G.GET_LOOKUP_DESC(NI.SOB_ID, NI.ORG_ID, 'PROBLEM_LEVEL_CODE', NI.PROBLEM_LEVEL_CODE) AS PROBLEM_LEVEL_DESC 
               , NI.ISSUE_COMMENT 
               , NI.ISSUE_DESCRIPTION 
               , NI.NCR_STATUS 
            FROM QM_NCR_ISSUE            NI
               , SDM_STANDARD_WORKCENTER D_SW
               , SDM_STANDARD_OPERATION  D_SO
               , INV_ITEM_MASTER         IM
               , SDM_ITEM_REVISION       IR
               , QM_REJECT_CLASS         RC
               , QM_REJECT_TYPE          RT
               , SDM_STANDARD_WORKCENTER C_SW 
               , SDM_STANDARD_OPERATION  C_SO 
           WHERE NI.WORKCENTER_ID           = D_SW.WORKCENTER_ID 
             AND NI.OPERATION_ID            = D_SO.OPERATION_ID(+) 
             AND NI.INVENTORY_ITEM_ID       = IM.INVENTORY_ITEM_ID 
             AND NI.BOM_ITEM_ID             = IR.BOM_ITEM_ID(+) 
             AND NI.REJECT_TYPE_ID          = RT.REJECT_TYPE_ID
             AND RT.REJECT_CLASS_ID         = RC.REJECT_CLASS_ID     
             AND NI.CAUSE_WORKCENTER_ID     = C_SW.WORKCENTER_ID(+)
             AND NI.CAUSE_OPERATION_ID      = C_SO.OPERATION_ID(+)  
             AND NI.NCR_ISSUE_ID            = W_NCR_ISSUE_ID
             AND NI.SOB_ID                  = W_SOB_ID
             AND NI.ORG_ID                  = W_ORG_ID 
          ; 
    
  END SELECT_NCR_ISSUE_DETAIL;

----------------------------------------------------------------------------------------
-- 품질부적합 발생 상세 INSERT                                                        --
----------------------------------------------------------------------------------------                                 
  PROCEDURE INSERT_NCR_ISSUE
            ( P_NCR_ISSUE_ID         OUT QM_NCR_ISSUE.NCR_ISSUE_ID%TYPE
            , P_SOB_ID               IN  QM_NCR_ISSUE.SOB_ID%TYPE
            , P_ORG_ID               IN  QM_NCR_ISSUE.ORG_ID%TYPE
            , P_NCR_ISSUE_NO         OUT QM_NCR_ISSUE.NCR_ISSUE_NO%TYPE
            , P_WORKCENTER_ID        IN  QM_NCR_ISSUE.WORKCENTER_ID%TYPE
            , P_OPERATION_ID         IN  QM_NCR_ISSUE.OPERATION_ID%TYPE
            , P_INVENTORY_ITEM_ID    IN  QM_NCR_ISSUE.INVENTORY_ITEM_ID%TYPE
            , P_BOM_ITEM_ID          IN  QM_NCR_ISSUE.BOM_ITEM_ID%TYPE
            , P_ISSUE_DATE           IN  QM_NCR_ISSUE.ISSUE_DATE%TYPE
            , P_CAUSE_WORKCENTER_ID  IN  QM_NCR_ISSUE.CAUSE_WORKCENTER_ID%TYPE
            , P_CAUSE_OPERATION_ID   IN  QM_NCR_ISSUE.CAUSE_OPERATION_ID%TYPE
            , P_PROBLEM_CLASS        IN  QM_NCR_ISSUE.PROBLEM_CLASS%TYPE
            , P_REJECT_DIVISION_CODE IN  QM_NCR_ISSUE.REJECT_DIVISION_CODE%TYPE
            , P_REJECT_TYPE_ID       IN  QM_NCR_ISSUE.REJECT_TYPE_ID%TYPE
            , P_PROBLEM_LEVEL_CODE   IN  QM_NCR_ISSUE.PROBLEM_LEVEL_CODE%TYPE
            , P_ISSUE_COMMENT        IN  QM_NCR_ISSUE.ISSUE_COMMENT%TYPE
            , P_ISSUE_DESCRIPTION    IN  QM_NCR_ISSUE.ISSUE_DESCRIPTION%TYPE
            , P_USER_ID              IN  QM_NCR_ISSUE.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
    -- NCR_ISSUE_NO 채번 -- 
    P_NCR_ISSUE_NO := EAPP_COMMON_G.GET_MASTER_NO( P_SOB_ID => P_SOB_ID      
                                                 , P_ORG_ID => P_ORG_ID
                                                 , P_MODULE_CODE => 'QM'
                                                 , P_MASTER_TYPE => 'QM_NCR_ISSUE_NO'
                                                 , P_DATE => V_SYSDATE); 
    IF P_NCR_ISSUE_NO IS NULL OR P_NCR_ISSUE_NO = 'ERROR' THEN
      RAISE_APPLICATION_ERROR(-20001, 'Insert Error : ' || EAPP_MESSAGE_G.RETURN_MSG_F('QM_10052'));
      RETURN;
    END IF;
    
    SELECT QM_NCR_ISSUE_S1.NEXTVAL
      INTO P_NCR_ISSUE_ID
      FROM DUAL;
    
    BEGIN
      INSERT INTO QM_NCR_ISSUE
      ( NCR_ISSUE_ID
      , SOB_ID 
      , ORG_ID 
      , NCR_ISSUE_NO 
      , WORKCENTER_ID 
      , OPERATION_ID  
      , INVENTORY_ITEM_ID 
      , BOM_ITEM_ID 
      , ISSUE_DATE 
      , CAUSE_WORKCENTER_ID 
      , CAUSE_OPERATION_ID 
      , PROBLEM_CLASS 
      , REJECT_DIVISION_CODE 
      , REJECT_TYPE_ID 
      , PROBLEM_LEVEL_CODE 
      , ISSUE_COMMENT 
      , ISSUE_DESCRIPTION 
      , CREATION_DATE 
      , CREATED_BY 
      , LAST_UPDATE_DATE 
      , LAST_UPDATED_BY  
      , FIX_CAUSE_WORKCENTER_ID  -- 확정 원인 작업장 ID 
      , FIX_CAUSE_OPERATION_ID   -- 확정 원인 공정 ID 
      ) VALUES
      ( P_NCR_ISSUE_ID
      , P_SOB_ID
      , P_ORG_ID
      , P_NCR_ISSUE_NO
      , P_WORKCENTER_ID
      , P_OPERATION_ID
      , P_INVENTORY_ITEM_ID
      , P_BOM_ITEM_ID
      , P_ISSUE_DATE
      , P_CAUSE_WORKCENTER_ID
      , P_CAUSE_OPERATION_ID
      , P_PROBLEM_CLASS
      , P_REJECT_DIVISION_CODE
      , P_REJECT_TYPE_ID
      , P_PROBLEM_LEVEL_CODE
      , P_ISSUE_COMMENT
      , P_ISSUE_DESCRIPTION
      , V_SYSDATE
      , P_USER_ID
      , V_SYSDATE
      , P_USER_ID
      , P_CAUSE_WORKCENTER_ID  -- 확정 원인 작업장 ID 
      , P_CAUSE_OPERATION_ID   -- 확정 원인 공정 ID  
      );
    EXCEPTION
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Insert Error : ' || SQLERRM);
        RETURN;
    END;
  END INSERT_NCR_ISSUE;

----------------------------------------------------------------------------------------
-- 품질부적합 발생 상세 UPDATE                                                        --
----------------------------------------------------------------------------------------          
  PROCEDURE UPDATE_NCR_ISSUE
            ( W_NCR_ISSUE_ID         IN  QM_NCR_ISSUE.NCR_ISSUE_ID%TYPE
            , P_SOB_ID               IN  QM_NCR_ISSUE.SOB_ID%TYPE
            , P_ORG_ID               IN  QM_NCR_ISSUE.ORG_ID%TYPE
            , P_NCR_ISSUE_NO         IN  QM_NCR_ISSUE.NCR_ISSUE_NO%TYPE
            , P_WORKCENTER_ID        IN  QM_NCR_ISSUE.WORKCENTER_ID%TYPE
            , P_OPERATION_ID         IN  QM_NCR_ISSUE.OP_TYPE_ID%TYPE
            , P_INVENTORY_ITEM_ID    IN  QM_NCR_ISSUE.INVENTORY_ITEM_ID%TYPE
            , P_BOM_ITEM_ID          IN  QM_NCR_ISSUE.BOM_ITEM_ID%TYPE
            , P_ISSUE_DATE           IN  QM_NCR_ISSUE.ISSUE_DATE%TYPE
            , P_CAUSE_WORKCENTER_ID  IN  QM_NCR_ISSUE.CAUSE_WORKCENTER_ID%TYPE
            , P_CAUSE_OPERATION_ID   IN  QM_NCR_ISSUE.CAUSE_OPERATION_ID%TYPE
            , P_PROBLEM_CLASS        IN  QM_NCR_ISSUE.PROBLEM_CLASS%TYPE
            , P_REJECT_DIVISION_CODE IN  QM_NCR_ISSUE.REJECT_DIVISION_CODE%TYPE
            , P_REJECT_TYPE_ID       IN  QM_NCR_ISSUE.REJECT_TYPE_ID%TYPE
            , P_PROBLEM_LEVEL_CODE   IN  QM_NCR_ISSUE.PROBLEM_LEVEL_CODE%TYPE
            , P_ISSUE_COMMENT        IN  QM_NCR_ISSUE.ISSUE_COMMENT%TYPE
            , P_ISSUE_DESCRIPTION    IN  QM_NCR_ISSUE.ISSUE_DESCRIPTION%TYPE
            , P_USER_ID              IN  QM_NCR_ISSUE.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE           DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_NCR_STATUS        VARCHAR2(50);
  BEGIN
    -- 부적합 상태 체크 : 승인미요청, 미승인 단계에서만 수정 -- 
    -- 그외에 상태에서는 수정 불가 -- 
    V_NCR_STATUS := GET_NCR_ISSUE_STATUS_F
                      ( W_NCR_ISSUE_ID => W_NCR_ISSUE_ID
                      , P_SOB_ID       => P_SOB_ID 
                      , P_ORG_ID       => P_ORG_ID 
                      );
    IF V_NCR_STATUS NOT IN('ENTER', 'RTN_REVIEW') THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10115'));
      RETURN;
    END IF;
      
    BEGIN
      UPDATE QM_NCR_ISSUE
        SET WORKCENTER_ID        = P_WORKCENTER_ID
          , OPERATION_ID         = P_OPERATION_ID
          , INVENTORY_ITEM_ID    = P_INVENTORY_ITEM_ID
          , BOM_ITEM_ID          = P_BOM_ITEM_ID
          , ISSUE_DATE           = P_ISSUE_DATE
          , CAUSE_WORKCENTER_ID  = P_CAUSE_WORKCENTER_ID
          , CAUSE_OPERATION_ID   = P_CAUSE_OPERATION_ID
          , PROBLEM_CLASS        = P_PROBLEM_CLASS
          , REJECT_DIVISION_CODE = P_REJECT_DIVISION_CODE
          , REJECT_TYPE_ID       = P_REJECT_TYPE_ID
          , PROBLEM_LEVEL_CODE   = P_PROBLEM_LEVEL_CODE
          , ISSUE_COMMENT        = P_ISSUE_COMMENT
          , ISSUE_DESCRIPTION    = P_ISSUE_DESCRIPTION
          , LAST_UPDATE_DATE     = V_SYSDATE
          , LAST_UPDATED_BY      = P_USER_ID
          
          , FIX_CAUSE_WORKCENTER_ID  = P_CAUSE_WORKCENTER_ID
          , FIX_CAUSE_OPERATION_ID   = P_CAUSE_OPERATION_ID
      WHERE NCR_ISSUE_ID         = W_NCR_ISSUE_ID;
    EXCEPTION 
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Update Error : ' || SQLERRM);
        RETURN;
    END;    
  END UPDATE_NCR_ISSUE;


----------------------------------------------------------------------------------------
-- 품질부적합 발생 상세 DELETE                                                        --
----------------------------------------------------------------------------------------          
  PROCEDURE DELETE_NCR_ISSUE
            ( W_NCR_ISSUE_ID         IN QM_NCR_ISSUE.NCR_ISSUE_ID%TYPE
            , P_SOB_ID               IN QM_NCR_ISSUE.SOB_ID%TYPE
            , P_ORG_ID               IN QM_NCR_ISSUE.ORG_ID%TYPE
            , P_NCR_ISSUE_NO         IN QM_NCR_ISSUE.NCR_ISSUE_NO%TYPE
            , P_USER_ID              IN QM_NCR_ISSUE.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE           DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_NCR_STATUS        VARCHAR2(50);
  BEGIN
    -- 부적합 상태 체크 : 승인미요청, 미승인 단계에서만 삭제 -- 
    -- 그외에 상태에서는 삭제 불가 -- 
    V_NCR_STATUS := GET_NCR_ISSUE_STATUS_F
                      ( W_NCR_ISSUE_ID => W_NCR_ISSUE_ID
                      , P_SOB_ID       => P_SOB_ID 
                      , P_ORG_ID       => P_ORG_ID 
                      );
    IF V_NCR_STATUS NOT IN('ENTER', 'RTN_REVIEW') THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_MSG_F('OE_10016'));
      RETURN;
    END IF;
    
    BEGIN
      DELETE FROM QM_NCR_ISSUE
      WHERE NCR_ISSUE_ID         = W_NCR_ISSUE_ID;
    EXCEPTION 
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Delete Error : ' || SQLERRM);
        RETURN;
    END;    
  END DELETE_NCR_ISSUE;
  
        
----------------------------------------------------------------------------------------
-- 품질부적합 발생 JOB 조회 및 등록                                                   --
----------------------------------------------------------------------------------------
  PROCEDURE SELECT_NCR_ISSUE_JOB
            ( P_CURSOR1                       OUT TYPES.TCURSOR1
            , W_SOB_ID                        IN  QM_NCR_ISSUE.SOB_ID%TYPE
            , W_ORG_ID                        IN  QM_NCR_ISSUE.ORG_ID%TYPE
            , W_NCR_ISSUE_ID                  IN  QM_NCR_ISSUE.NCR_ISSUE_ID%TYPE 
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT NJ.NCR_ISSUE_ID
           , NJ.JOB_ID
           , NJ.JOB_NO
           , NJ.WORKING_UOM
           , NJ.WORK_UOM_QTY
           , NJ.REJECT_UOM_QTY
           , CASE
               WHEN NVL(NJ.WORK_UOM_QTY, 0) = 0 THEN 0
               ELSE ROUND(NVL(NJ.REJECT_UOM_QTY, 0) / NVL(NJ.WORK_UOM_QTY, 0) * 100, 2) 
             END AS REJECT_RATE            
        FROM QM_NCR_JOB NJ
       WHERE NJ.NCR_ISSUE_ID      = W_NCR_ISSUE_ID
       ORDER BY NJ.JOB_NO
      ;
  END SELECT_NCR_ISSUE_JOB;

----------------------------------------------------------------------------------------
-- 품질부적합 발생 JOB 등록                                                           --
----------------------------------------------------------------------------------------
  PROCEDURE INSERT_NCR_JOB
            ( P_SOB_ID         IN  QM_NCR_JOB.SOB_ID%TYPE
            , P_ORG_ID         IN  QM_NCR_JOB.ORG_ID%TYPE
            , P_NCR_ISSUE_ID   IN  QM_NCR_JOB.NCR_ISSUE_ID%TYPE
            , P_JOB_ID         IN  QM_NCR_JOB.JOB_ID%TYPE
            , P_JOB_NO         IN  QM_NCR_JOB.JOB_NO%TYPE
            , P_WORKING_UOM    IN  QM_NCR_JOB.WORKING_UOM%TYPE
            , P_WORK_UOM_QTY   IN  QM_NCR_JOB.WORK_UOM_QTY%TYPE
            , P_REJECT_UOM_QTY IN  QM_NCR_JOB.REJECT_UOM_QTY%TYPE
            , P_USER_ID        IN  QM_NCR_JOB.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE           DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_NCR_STATUS        VARCHAR2(50);
  BEGIN
    -- 부적합 상태 체크 : 승인미요청, 미승인 단계에서만 수정 -- 
    -- 그외에 상태에서는 수정 불가 -- 
    V_NCR_STATUS := GET_NCR_ISSUE_STATUS_F
                      ( W_NCR_ISSUE_ID => P_NCR_ISSUE_ID
                      , P_SOB_ID       => P_SOB_ID 
                      , P_ORG_ID       => P_ORG_ID 
                      );
    IF V_NCR_STATUS NOT IN('ENTER', 'ENTERED', 'RETURN') THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_MSG_F('OE_10016'));
      RETURN;
    END IF;
    
    BEGIN
      INSERT INTO QM_NCR_JOB
      ( SOB_ID
      , ORG_ID 
      , NCR_ISSUE_ID 
      , JOB_ID 
      , JOB_NO 
      , WORKING_UOM 
      , WORK_UOM_QTY 
      , REJECT_UOM_QTY 
      , CREATION_DATE 
      , CREATED_BY 
      , LAST_UPDATE_DATE 
      , LAST_UPDATED_BY 
      ) VALUES
      ( P_SOB_ID
      , P_ORG_ID
      , P_NCR_ISSUE_ID
      , P_JOB_ID
      , P_JOB_NO
      , NVL(P_WORKING_UOM, 'PCS')
      , NVL(P_WORK_UOM_QTY, 0)
      , NVL(P_REJECT_UOM_QTY, 0)
      , V_SYSDATE
      , P_USER_ID
      , V_SYSDATE
      , P_USER_ID );
      
      -- 부적합 발행 JOB 수량 SUMMARY UPDATE -- 
      UPDATE QM_NCR_ISSUE NI
         SET ( NI.WORK_UOM_QTY    
             , NI.REJECT_UOM_QTY 
             ) = ( SELECT SUM(NJ.WORK_UOM_QTY) AS WORK_UOM_QTY 
                        , SUM(NJ.REJECT_UOM_QTY) AS REJECT_UOM_QTY 
                     FROM QM_NCR_JOB NJ
                    WHERE NJ.SOB_ID         = P_SOB_ID
                      AND NJ.ORG_ID         = P_ORG_ID
                      AND NJ.NCR_ISSUE_ID   = P_NCR_ISSUE_ID 
                 ) 
       WHERE NI.NCR_ISSUE_ID      = P_NCR_ISSUE_ID
       ;
    EXCEPTION 
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'NCR Job Insert Error : ' || SQLERRM);
        RETURN;
    END;
  END INSERT_NCR_JOB;
  
----------------------------------------------------------------------------------------
-- 품질부적합 발생 JOB 수정 : 수량만 수정                                             --
----------------------------------------------------------------------------------------                       
  PROCEDURE UPDATE_NCR_JOB
            ( W_SOB_ID         IN QM_NCR_JOB.SOB_ID%TYPE
            , W_ORG_ID         IN QM_NCR_JOB.ORG_ID%TYPE
            , W_NCR_ISSUE_ID   IN QM_NCR_JOB.NCR_ISSUE_ID%TYPE
            , W_JOB_ID         IN QM_NCR_JOB.JOB_ID%TYPE
            , W_JOB_NO         IN QM_NCR_JOB.JOB_NO%TYPE
            , P_WORKING_UOM    IN QM_NCR_JOB.WORKING_UOM%TYPE
            , P_WORK_UOM_QTY   IN QM_NCR_JOB.WORK_UOM_QTY%TYPE
            , P_REJECT_UOM_QTY IN QM_NCR_JOB.REJECT_UOM_QTY%TYPE
            , P_USER_ID        IN QM_NCR_JOB.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE           DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_NCR_STATUS        VARCHAR2(50);
  BEGIN
    -- 부적합 상태 체크 : 승인미요청, 미승인 단계에서만 수정 -- 
    -- 그외에 상태에서는 수정 불가 -- 
    V_NCR_STATUS := GET_NCR_ISSUE_STATUS_F
                      ( W_NCR_ISSUE_ID => W_NCR_ISSUE_ID
                      , P_SOB_ID       => W_SOB_ID 
                      , P_ORG_ID       => W_ORG_ID 
                      );
    IF V_NCR_STATUS NOT IN('ENTER', 'ENTERED', 'RETURN') THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_MSG_F('OE_10016'));
      RETURN;
    END IF;
    
    BEGIN
      UPDATE QM_NCR_JOB
        SET WORKING_UOM      = NVL(P_WORKING_UOM, 'PCS') 
          , WORK_UOM_QTY     = NVL(P_WORK_UOM_QTY, 0)
          , REJECT_UOM_QTY   = NVL(P_REJECT_UOM_QTY, 0)
          , LAST_UPDATE_DATE = V_SYSDATE
          , LAST_UPDATED_BY  = P_USER_ID
      WHERE SOB_ID           = W_SOB_ID
        AND ORG_ID           = W_ORG_ID
        AND NCR_ISSUE_ID     = W_NCR_ISSUE_ID
        AND JOB_ID           = W_JOB_ID
      ;
      
      -- 부적합 발행 JOB 수량 SUMMARY UPDATE -- 
      UPDATE QM_NCR_ISSUE NI
         SET ( NI.WORK_UOM_QTY    
             , NI.REJECT_UOM_QTY 
             ) = ( SELECT SUM(NJ.WORK_UOM_QTY) AS WORK_UOM_QTY 
                        , SUM(NJ.REJECT_UOM_QTY) AS REJECT_UOM_QTY 
                     FROM QM_NCR_JOB NJ
                    WHERE NJ.SOB_ID         = W_SOB_ID
                      AND NJ.ORG_ID         = W_ORG_ID
                      AND NJ.NCR_ISSUE_ID   = W_NCR_ISSUE_ID 
                 ) 
       WHERE NI.NCR_ISSUE_ID      = W_NCR_ISSUE_ID
       ;
    EXCEPTION 
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'NCR Job Update Error : ' || SQLERRM);
        RETURN;
    END;
  END UPDATE_NCR_JOB;
  
----------------------------------------------------------------------------------------
-- 품질부적합 발생 JOB 삭제                                                           --
----------------------------------------------------------------------------------------                       
  PROCEDURE DELETE_NCR_JOB
            ( W_SOB_ID         IN QM_NCR_JOB.SOB_ID%TYPE
            , W_ORG_ID         IN QM_NCR_JOB.ORG_ID%TYPE
            , W_NCR_ISSUE_ID   IN QM_NCR_JOB.NCR_ISSUE_ID%TYPE
            , W_JOB_ID         IN QM_NCR_JOB.JOB_ID%TYPE
            , W_JOB_NO         IN QM_NCR_JOB.JOB_NO%TYPE
            , P_USER_ID        IN QM_NCR_JOB.CREATED_BY%TYPE 
            )
  AS
    V_NCR_STATUS        VARCHAR2(50);
  BEGIN
    -- 부적합 상태 체크 : 승인미요청, 미승인 단계에서만 수정 -- 
    -- 그외에 상태에서는 수정 불가 -- 
    V_NCR_STATUS := GET_NCR_ISSUE_STATUS_F
                      ( W_NCR_ISSUE_ID => W_NCR_ISSUE_ID
                      , P_SOB_ID       => W_SOB_ID 
                      , P_ORG_ID       => W_ORG_ID 
                      );
    IF V_NCR_STATUS NOT IN('ENTER', 'ENTERED', 'RETURN') THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_MSG_F('OE_10016'));
      RETURN;
    END IF;
    
    BEGIN
      DELETE FROM QM_NCR_JOB
      WHERE SOB_ID           = W_SOB_ID
        AND ORG_ID           = W_ORG_ID
        AND NCR_ISSUE_ID     = W_NCR_ISSUE_ID
        AND JOB_ID           = W_JOB_ID
      ;      
    EXCEPTION 
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'NCR Job Delete Error : ' || SQLERRM);
        RETURN;
    END;
    
    BEGIN
      -- 부적합 발행 JOB 수량 SUMMARY UPDATE -- 
      UPDATE QM_NCR_ISSUE NI
         SET ( NI.WORK_UOM_QTY    
             , NI.REJECT_UOM_QTY 
             ) = ( SELECT SUM(NJ.WORK_UOM_QTY) AS WORK_UOM_QTY 
                        , SUM(NJ.REJECT_UOM_QTY) AS REJECT_UOM_QTY 
                     FROM QM_NCR_JOB NJ
                    WHERE NJ.SOB_ID         = W_SOB_ID
                      AND NJ.ORG_ID         = W_ORG_ID
                      AND NJ.NCR_ISSUE_ID   = W_NCR_ISSUE_ID 
                 ) 
       WHERE NI.NCR_ISSUE_ID      = W_NCR_ISSUE_ID
       ;
    EXCEPTION 
      WHEN OTHERS THEN
        -- 부적합 발행 JOB 수량 SUMMARY UPDATE -- 
        UPDATE QM_NCR_ISSUE NI
           SET NI.WORK_UOM_QTY      = 0
             , NI.REJECT_UOM_QTY    = 0
         WHERE NI.NCR_ISSUE_ID      = W_NCR_ISSUE_ID
         ;
    END;
  END DELETE_NCR_JOB;
  
  
----------------------------------------------------------------------------------------
-- 품질부적합 발생 리스트 조회 : 부적합 검토                                          --
----------------------------------------------------------------------------------------
  PROCEDURE SELECT_NCR_ISSUE_REVIEW
            ( P_CURSOR                        OUT TYPES.TCURSOR
            , W_SOB_ID                        IN  QM_NCR_ISSUE.SOB_ID%TYPE
            , W_ORG_ID                        IN  QM_NCR_ISSUE.ORG_ID%TYPE
            , W_CONNECT_USER_ID               IN  QM_NCR_ISSUE.CREATED_BY%TYPE
            , W_ISSUE_DATE_FR                 IN  QM_NCR_ISSUE.ISSUE_DATE%TYPE
            , W_ISSUE_DATE_TO                 IN  QM_NCR_ISSUE.ISSUE_DATE%TYPE
            , W_WORKCENTER_ID                 IN  QM_NCR_ISSUE.WORKCENTER_ID%TYPE 
            , W_CAUSE_WORKCENTER_ID           IN  QM_NCR_ISSUE.CAUSE_WORKCENTER_ID%TYPE 
            , W_INVENTORY_ITEM_ID             IN  QM_NCR_ISSUE.INVENTORY_ITEM_ID%TYPE
            , W_NCR_ISSUE_ID                  IN  QM_NCR_ISSUE.NCR_ISSUE_ID%TYPE 
            , W_REJECT_TYPE_ID                IN  QM_NCR_ISSUE.REJECT_TYPE_ID%TYPE
            , W_NCR_STATUS                    IN  QM_NCR_ISSUE.NCR_STATUS%TYPE
            ) 
  AS
    V_SYSDATE             DATE := GET_LOCAL_DATE(W_SOB_ID);
  BEGIN
    OPEN P_CURSOR FOR
        SELECT NI.NCR_ISSUE_ID
             , NI.NCR_ISSUE_NO
             , NI.ISSUE_DATE
             , NI.WORKCENTER_ID
             , D_SW.WORKCENTER_CODE
             , D_SW.WORKCENTER_DESCRIPTION AS WORKCENTER_DESC  
             , NI.OPERATION_ID 
             , D_SO.OPERATION_CODE
             , D_SO.OPERATION_DESCRIPTION AS OPERATION_DESC 
             , NI.INVENTORY_ITEM_ID
             , IM.ITEM_CODE
             , IM.ITEM_DESCRIPTION AS ITEM_DESC
             , NI.BOM_ITEM_ID
             , IR.BOM_ITEM_CODE
             , IR.BOM_ITEM_DESCRIPTION AS BOM_ITEM_DESC                
             , NI.CAUSE_WORKCENTER_ID
             , C_SW.WORKCENTER_CODE AS CAUSE_WORKCENTER_CODE
             , C_SW.WORKCENTER_DESCRIPTION AS CAUSE_WORKCENTER_DESC 
             , NI.CAUSE_OPERATION_ID   
             , C_SO.OPERATION_CODE AS CAUSE_OPERATION_CODE
             , C_SO.OPERATION_DESCRIPTION AS CAUSE_OPERATION_DESC 
             , NI.WORKING_UOM 
             , NI.WORK_UOM_QTY 
             , NI.REJECT_UOM_QTY 
             , CASE
                 WHEN NVL(NI.WORK_UOM_QTY, 0) = 0 THEN NULL
                 ELSE ROUND(NVL(NI.REJECT_UOM_QTY, 0) / NVL(NI.WORK_UOM_QTY, 0) * 100) 
               END REJECT_RATE 
             , NI.PROBLEM_CLASS 
             , (SELECT QPC.DESCRIPTION
                 FROM QM_PROBLEM_CLASS QPC
                WHERE QPC.PROBLEM_CLASS = NI.PROBLEM_CLASS) AS PROBLEM_CLASS_DESC
             , NI.REJECT_DIVISION_CODE 
             , (SELECT QTC.DESCRIPTION
                 FROM QM_TROUBLE_CLASS QTC
                WHERE QTC.TROUBLE_CLASS = NI.REJECT_DIVISION_CODE) AS REJECT_DIVISION_DESC 
             , RC.REJECT_CLASS_CODE 
             , RC.DESCRIPTION AS REJECT_CLASS_DESC
             , NI.REJECT_TYPE_ID                
             , RT.REJECT_TYPE_CODE
             , RT.DESCRIPTION AS REJECT_TYPE_DESC 
             , NI.PROBLEM_LEVEL_CODE
             , EAPP_COMMON_G.GET_LOOKUP_DESC(NI.SOB_ID, NI.ORG_ID, 'PROBLEM_LEVEL_CODE', NI.PROBLEM_LEVEL_CODE) AS PROBLEM_LEVEL_DESC 
             , NI.ISSUE_COMMENT 
             , NI.ISSUE_DESCRIPTION 
             , NI.NCR_STATUS 
             , NI.REVIEW_FLAG
             , NI.REVIEW_DATE
             , NI.REVIEW_USER_ID
             , EAPP_USER_G.USER_NAME_F(NI.REVIEW_USER_ID) AS REVIEW_USER_NAME
             , NI.REVIEW_COMMENT
             , NI.FIX_CAUSE_WORKCENTER_ID
             , F_SW.WORKCENTER_CODE AS FIX_CAUSE_WORKCENTER_CODE 
             , F_SW.WORKCENTER_DESCRIPTION AS FIX_CAUSE_WORKCENTER_DESC 
             , NI.FIX_CAUSE_OPERATION_ID
             , F_SO.OPERATION_CODE AS FIX_CAUSE_OPERATION_CODE 
             , F_SO.OPERATION_DESCRIPTION AS FIX_CAUSE_OPERATION_DESC 
             , NI.MEASURE_CHARGE_ID 
             , EAPP_USER_G.USER_NAME_F(NI.MEASURE_CHARGE_ID) AS MEASURE_CHARGE_NAME
             , NI.MEASURE_REPLY_DATE  
          FROM QM_NCR_ISSUE            NI
             , SDM_STANDARD_WORKCENTER D_SW
             , SDM_STANDARD_OPERATION  D_SO
             , INV_ITEM_MASTER         IM
             , SDM_ITEM_REVISION       IR
             , QM_REJECT_CLASS         RC
             , QM_REJECT_TYPE          RT
             , SDM_STANDARD_WORKCENTER C_SW 
             , SDM_STANDARD_OPERATION  C_SO 
             , SDM_STANDARD_WORKCENTER F_SW 
             , SDM_STANDARD_OPERATION  F_SO              
         WHERE NI.WORKCENTER_ID           = D_SW.WORKCENTER_ID 
           AND NI.OPERATION_ID            = D_SO.OPERATION_ID(+) 
           AND NI.INVENTORY_ITEM_ID       = IM.INVENTORY_ITEM_ID 
           AND NI.BOM_ITEM_ID             = IR.BOM_ITEM_ID(+) 
           AND NI.REJECT_TYPE_ID          = RT.REJECT_TYPE_ID
           AND RT.REJECT_CLASS_ID         = RC.REJECT_CLASS_ID     
           AND NI.CAUSE_WORKCENTER_ID     = C_SW.WORKCENTER_ID(+)
           AND NI.CAUSE_OPERATION_ID      = C_SO.OPERATION_ID(+)  
           AND NI.FIX_CAUSE_WORKCENTER_ID = F_SW.WORKCENTER_ID(+)
           AND NI.FIX_CAUSE_OPERATION_ID  = F_SO.OPERATION_ID(+)  
           AND TRUNC(NI.ISSUE_DATE)       BETWEEN W_ISSUE_DATE_FR             
                                              AND W_ISSUE_DATE_TO
           AND NI.SOB_ID                  = W_SOB_ID 
           AND NI.ORG_ID                  = W_ORG_ID 
           AND ((W_NCR_STATUS             = 'ALL' AND 1 = 1)
           OR   (W_NCR_STATUS             != 'ALL' AND NI.NCR_STATUS = W_NCR_STATUS)) 
           AND ((W_WORKCENTER_ID          IS NULL AND 1 = 1)
           OR   (W_WORKCENTER_ID          IS NOT NULL AND NI.WORKCENTER_ID = W_WORKCENTER_ID))
           AND ((W_INVENTORY_ITEM_ID      IS NULL AND 1 = 1)
           OR   (W_INVENTORY_ITEM_ID      IS NOT NULL AND NI.INVENTORY_ITEM_ID = W_INVENTORY_ITEM_ID)) 
           AND ((W_NCR_STATUS             IS NULL AND 1 = 1)
           OR   (W_NCR_STATUS             IS NOT NULL AND NI.NCR_STATUS = W_NCR_STATUS)) 
           AND ((W_CAUSE_WORKCENTER_ID    IS NULL AND 1 = 1)
           OR   (W_CAUSE_WORKCENTER_ID    IS NOT NULL AND NI.CAUSE_WORKCENTER_ID = W_CAUSE_WORKCENTER_ID)) 
           AND ((W_REJECT_TYPE_ID         IS NULL AND 1 = 1)
           OR   (W_REJECT_TYPE_ID         IS NOT NULL AND NI.REJECT_TYPE_ID = W_REJECT_TYPE_ID)) 
           AND ((W_NCR_ISSUE_ID           IS NULL AND 1 = 1)
           OR   (W_NCR_ISSUE_ID           IS NOT NULL AND NI.NCR_ISSUE_ID = W_NCR_ISSUE_ID)) 
           -- 권한 체크 -- 
           AND EXISTS
                 (SELECT 'X'
                    FROM EAPP_USER        EU
                       , WIP_USER_CONTROL UC
                   WHERE EU.USER_ID       = UC.USER_ID(+)  
                     AND EU.USER_ID       = W_CONNECT_USER_ID 
                     AND EU.SOB_ID        = W_SOB_ID 
                     AND EU.ORG_ID        = W_ORG_ID 
                     AND EU.ENABLED_FLAG  = 'Y'
                     AND EU.EFFECTIVE_DATE_FR   <= V_SYSDATE 
                     AND (EU.EFFECTIVE_DATE_TO  >= V_SYSDATE OR EU.EFFECTIVE_DATE_TO IS NULL) 
                     -- 전체 사용 권한자는 모든 작업장 표시 --
                     AND CASE
                           WHEN EU.WIP_TRX_CONTROL = 'UNLIMITED' THEN NI.WORKCENTER_ID 
                           ELSE UC.WORKCENTER_ID
                         END              = NI.WORKCENTER_ID 
                 )
        ; 
  END SELECT_NCR_ISSUE_REVIEW;

-------------------------------------------------------------------------------------------------------
-- 품질이슈 발생 수정
-------------------------------------------------------------------------------------------------------
PROCEDURE UPDATE_TROUBLE_ISSUE_MASTER
          ( W_TROUBLE_ISSUE_ID         IN QM_TROUBLE_ISSUE.TROUBLE_ISSUE_ID%TYPE
          , P_SOB_ID                   IN QM_TROUBLE_ISSUE.SOB_ID%TYPE
          , P_ORG_ID                   IN QM_TROUBLE_ISSUE.ORG_ID%TYPE
          , P_SUBJECT_NAME             IN QM_TROUBLE_ISSUE.SUBJECT_NAME%TYPE
          , P_TROUBLE_DATE             IN QM_TROUBLE_ISSUE.TROUBLE_DATE%TYPE
          , P_WEEKLY                   IN QM_TROUBLE_ISSUE.WEEKLY%TYPE
          , P_MEASURE_REQ_DATE         IN QM_TROUBLE_ISSUE.MEASURE_REQ_DATE%TYPE
          , P_MEASURE_PERSON_USER_ID   IN QM_TROUBLE_ISSUE.MEASURE_PERSON_USER_ID%TYPE
          , P_PROJECT_ID               IN QM_TROUBLE_ISSUE.PROJECT_ID%TYPE
          , P_OPERATION_ID             IN QM_TROUBLE_ISSUE.OPERATION_ID%TYPE
          , P_INVENTORY_ITEM_ID        IN QM_TROUBLE_ISSUE.INVENTORY_ITEM_ID%TYPE
          , P_BOM_ITEM_ID              IN QM_TROUBLE_ISSUE.BOM_ITEM_ID%TYPE
          , P_TROUBLE_CLASS_CODE       IN QM_TROUBLE_ISSUE.TROUBLE_CLASS_CODE%TYPE
          , P_PROBLEM_CLASS            IN QM_TROUBLE_ISSUE.PROBLEM_CLASS%TYPE
          , P_TROUBLE_RATE             IN QM_TROUBLE_ISSUE.TROUBLE_RATE%TYPE
          , P_TROUBLE_QTY              IN QM_TROUBLE_ISSUE.TROUBLE_QTY%TYPE
          , P_WORK_QTY                 IN QM_TROUBLE_ISSUE.WORK_QTY%TYPE
          , P_REJECT_CLASS_CODE        IN QM_TROUBLE_ISSUE.REJECT_CLASS_CODE%TYPE
          , P_REJECT_TYPE_CODE         IN QM_TROUBLE_ISSUE.REJECT_TYPE_CODE%TYPE
          , P_TROUBLE_COMMENT          IN QM_TROUBLE_ISSUE.TROUBLE_COMMENT%TYPE
         -- , P_CAUSE_COMMENT            IN QM_TROUBLE_ISSUE.CAUSE_COMMENT%TYPE
          , P_FACTORY_LCODE            IN QM_TROUBLE_ISSUE.FACTORY_LCODE%TYPE
          , P_WORKCENTER_ID            IN QM_TROUBLE_ISSUE.WORKCENTER_ID%TYPE
          , P_DESCRIPTION              IN QM_TROUBLE_ISSUE.DESCRIPTION%TYPE
          , P_MEASURE_CHARGE_PRESON_ID IN QM_TROUBLE_ISSUE.MEASURE_CHARGE_PRESON_ID%TYPE
          , P_CUSTOMER_SITE_CODE       IN QM_TROUBLE_ISSUE.CUSTOMER_SITE_CODE%TYPE
          --, P_APPROVER_USER_ID         IN QM_TROUBLE_ISSUE.APPROVER_USER_ID%TYPE
          --, P_STATUS_LCODE             IN QM_TROUBLE_ISSUE.STATUS_LCODE%TYPE
          , P_USER_ID                  IN QM_TROUBLE_ISSUE.CREATED_BY%TYPE

          )
  AS
    V_SYSDATE                          DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_CREATION_DATE                    QM_TROUBLE_ISSUE.CREATION_DATE%TYPE;
    V_STATUS_CODE                      QM_TROUBLE_ISSUE.STATUS_LCODE%TYPE;
    V_INPUT_PERSON_USER_ID             QM_TROUBLE_ISSUE.INPUT_PERSON_USER_ID%TYPE;
    V_QM_MANAGER_USER_ID               QM_TROUBLE_ISSUE.INPUT_PERSON_USER_ID%TYPE;

    V_SEND_PERSON_ID              NUMBER;         -- 발송자 ID.
    --V_SENDER_NAME                 VARCHAR2(100);  -- 발송자 성명.
    V_SENDER_EMAIL                VARCHAR2(200);  -- 발송자 이메일주소.

    V_RCPT_NAME                   VARCHAR2(10000);  -- 수신자 성명.
    V_RCPT_EMAIL                  VARCHAR2(10000);  -- 수신자 이메일주소.
    V_COUNT_EMAIL                 NUMBER;

    V_STATUS                      VARCHAR2(100);  -- 메일 구분( 요청/취소).
    V_ONE                         VARCHAR2(100);
    V_TWO                         VARCHAR2(100);
    V_THERE                       VARCHAR2(100);
    V_FOUR                        VARCHAR2(100);
    V_FIVE                        VARCHAR2(100);

    V_SUBJECT                     VARCHAR2(300);  -- 제목.

    V_CONTENT                     VARCHAR2(30000); -- 내용.

    V_TEXT1                       VARCHAR2(300);   -- 셰부내용1.
    V_TEXT2                       VARCHAR2(300);   -- 셰부내용2.
    V_TEXT3                       VARCHAR2(300);   -- 셰부내용3.
    V_TEXT4                       VARCHAR2(300);   -- 셰부내용4.
    V_TEXT5                       VARCHAR2(300);   -- 셰부내용5.
    V_TEXT6                       VARCHAR2(300);   -- 셰부내용6.
    V_TEXT7                       VARCHAR2(300);   -- 셰부내용7.
    V_TEXT8                       VARCHAR2(300);   -- 셰부내용8.
    V_TEXT9                       VARCHAR2(300);   -- 셰부내용9.
    V_TEXT10                       VARCHAR2(300);   -- 셰부내용10.
    V_TEXT11                       VARCHAR2(300);   -- 셰부내용11.
    V_TEXT12                       VARCHAR2(300);   -- 셰부내용12.
    V_TEXT13                       VARCHAR2(300);   -- 셰부내용13.
    V_TEXT14                       VARCHAR2(300);   -- 셰부내용14.
    V_TEXT15                       VARCHAR2(300);   -- 셰부내용15.
    V_TEXT16                       VARCHAR2(300);   -- 셰부내용16.
    V_TEXT17                       VARCHAR2(300);   -- 셰부내용17.
    V_TEXT18                       VARCHAR2(300);   -- 셰부내용18.
    V_TEXT19                       VARCHAR2(300);   -- 셰부내용19.
    V_TEXT20                       VARCHAR2(300);   -- 셰부내용20.
    V_TEXT21                       VARCHAR2(300);   -- 셰부내용21.
    V_TEXT22                       VARCHAR2(300);   -- 셰부내용22.
    V_TEXT23                       VARCHAR2(4000);   -- 셰부내용23.
    V_TEXT24                       VARCHAR2(4000);   -- 셰부내용24.
    V_TEXT25                       VARCHAR2(300);   -- 셰부내용25.
    V_TEXT26                       VARCHAR2(300);   -- 셰부내용26.

    V_TROUBLE_ISSUE_NO            QM_TROUBLE_ISSUE.TROUBLE_ISSUE_NO%TYPE;                -- 발생번호.
    V_SUBJECT_NAME                QM_TROUBLE_ISSUE.SUBJECT_NAME%TYPE;                    -- 제목.

    V_INPUT_PERSON_NAME           VARCHAR2(100);                                         -- 등록자.
    V_INPUT_DATE                  QM_TROUBLE_ISSUE.INPUT_DATE%TYPE;                      -- 등록일자.
    V_TROUBLE_DATE                QM_TROUBLE_ISSUE.TROUBLE_DATE%TYPE;                     -- 불량발생일.
    V_WEEKLY                      QM_TROUBLE_ISSUE.WEEKLY%TYPE;                           -- 주차.
    V_MEASURE_REQ_DATE            QM_TROUBLE_ISSUE.MEASURE_REQ_DATE%TYPE;                 -- 대책요구일.
    V_MEASURE_CHARGE_PRESON_NAME  VARCHAR2(100);         -- 대책담당자.
    V_TROUBLE_CLASS_CODE          QM_TROUBLE_ISSUE.TROUBLE_CLASS_CODE%TYPE;               -- 불량구분코드.
    V_TROUBLE_CLASS_NAME          VARCHAR2(200);                                          -- 불량구분.

    V_PROJECT_NAME                VARCHAR2(1000);                                         -- 프로젝트명.
    V_INVENTORY_CODE              VARCHAR2(100);                                          -- 제품코드
    V_INVENTORY_ITEM              VARCHAR2(200);                                          -- 제품명.
    V_OPERATION_CODE              VARCHAR2(100);                                          -- 공정코드.
    V_OPERATION_NAME              VARCHAR2(200);                                          -- 공정명.
    V_BOM_ITEM_CODE               VARCHAR2(100);                                          -- 모델코드.
    V_BOM_ITEM_NAME               VARCHAR2(200);                                          -- 모델명.
    V_FACTORY_LCODE               QM_TROUBLE_ISSUE.FACTORY_LCODE%TYPE;                    -- 공장구분.
    V_FACTORY_NAME                VARCHAR2(200);                                          -- 공장이름.
    V_WORKCENTER_NAME             VARCHAR2(200);                                          -- 작업장 이름.

    V_PROBLEM_CLASS_CODE          QM_TROUBLE_ISSUE.PROBLEM_CLASS%TYPE;                    -- 문제구분CODE명.
    V_PROBLEM_CLASS_NAME          VARCHAR2(1000);                                         -- 문제구분명.
    V_TROUBLE_RATE                QM_TROUBLE_ISSUE.TROUBLE_RATE%TYPE;                     -- 불량율.
    V_TROUBLE_QTY                 QM_TROUBLE_ISSUE.TROUBLE_QTY%TYPE;                      -- 불량수.
    V_WORK_QTY                    QM_TROUBLE_ISSUE.WORK_QTY%TYPE;                         -- 작업량.
    V_DESCRIPTION                 QM_TROUBLE_ISSUE.DESCRIPTION%TYPE;                      -- 비고.

    V_REJECT_CLASS_CODE           QM_TROUBLE_ISSUE.REJECT_CLASS_CODE%TYPE;                -- 불량공정 CODE.
    V_REJECT_CLASS_NAME           VARCHAR2(1000);                                         -- 불량공정.
    V_REJECT_TYPE_CODE            QM_TROUBLE_ISSUE.REJECT_TYPE_CODE%TYPE;                 -- 불량유형 CODE.
    V_REJECT_TYPE_NAME            VARCHAR2(1000);                                         -- 불량유형.

    V_TROUBLE_COMMENT             QM_TROUBLE_ISSUE.TROUBLE_COMMENT%TYPE;                  -- 불량현상내용.
  --  V_CAUSE_COMMENT               QM_TROUBLE_ISSUE.CAUSE_COMMENT%TYPE;
    V_MEASURE_CHARGE_PRESON       VARCHAR2(100);
    V_MEASURE_CHARGE_PRESON_MAIL  VARCHAR2(100);

    BEGIN
        SELECT QTI.CREATION_DATE
             , QTI.STATUS_LCODE
             , QTI.INPUT_PERSON_USER_ID
          INTO V_CREATION_DATE
             , V_STATUS_CODE
             , V_INPUT_PERSON_USER_ID
          FROM QM_TROUBLE_ISSUE QTI
        WHERE QTI.TROUBLE_ISSUE_ID  = W_TROUBLE_ISSUE_ID;

    BEGIN

     /*승인상태가 대책입력상태 이상이면 수정 불가능 */
     IF V_STATUS_CODE NOT IN('ENTERED') THEN
        RAISE_APPLICATION_ERROR( -20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'QM_10024' ) );
         RETURN;
     END IF;

      /*불량발생일 일자체크 - 현재보다 이후 불가능*/
     IF TRUNC(P_TROUBLE_DATE) > TRUNC(V_CREATION_DATE) THEN
         RAISE_APPLICATION_ERROR( -20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'QM_10022' ) );
         RETURN;
     END IF;

     /*대책요구일 일자체크 - 현재보다 이전 불가능 */
     /*IF TRUNC(P_MEASURE_REQ_DATE) < TRUNC(V_CREATION_DATE) THEN
         RAISE_APPLICATION_ERROR( -20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'QM_10023' ) );
         RETURN;
     END IF;*/

    ------------------
    -- 품질 메니져에 속하는지 확인. --
    -----------------
     BEGIN
       SELECT EU.USER_ID
         INTO V_QM_MANAGER_USER_ID
         FROM EAPP_PERSON_INCHARGE_TYPE EPT
            , EAPP_PERSON_INCHARGE_ENTRY EPE
            , EAPP_USER EU
        WHERE EPT.INCHARGE_TYPE_ID        = EPE.INCHARGE_TYPE_ID
          AND EPE.INCHARGE_PERSON_ID      = EU.PERSON_ID
          AND EPT.INCHARGE_TYPE           = 'QM_ISSUE_MANAGER'
          AND EPT.SOB_ID                  = P_SOB_ID
          AND EPT.ORG_ID                  = P_ORG_ID
          AND EPE.ENABLED_FLAG            = 'Y'
          AND EPE.EFFECTIVE_DATE_FR       <= TRUNC(SYSDATE)
          AND (EPE.EFFECTIVE_DATE_TO      >= TRUNC(SYSDATE) OR EPE.EFFECTIVE_DATE_TO IS NULL)
          AND EU.USER_ID                  = P_USER_ID ;

     EXCEPTION WHEN OTHERS THEN
          V_QM_MANAGER_USER_ID := '0';
      END;
   --   RAISE_APPLICATION_ERROR( -20001, 'ACCESS' || P_USER_ID || 'INPUT' || V_INPUT_PERSON_USER_ID|| 'MANAGER' || V_QM_MANAGER_USER_ID);
     IF P_USER_ID != V_INPUT_PERSON_USER_ID AND P_USER_ID != V_QM_MANAGER_USER_ID THEN
        RAISE_APPLICATION_ERROR( -20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'QM_10050' ));
        RETURN;
     END IF;
    /*불량 원인 1과 2가 같으면 에러 */
    /* IF P_REJECT_TYPE_CODE1 = P_REJECT_TYPE_CODE2 THEN
          RAISE_APPLICATION_ERROR( -20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'QM_10025' ) );
         RETURN;
     END IF;*/
     ------------------
      -- 발송자 정보. --
      ------------------
      BEGIN
           SELECT EAPP_COMMON_G.GET_PERSON_ID_BY_USER(P_USER_ID)
             INTO V_SEND_PERSON_ID
             FROM DUAL
             ;
      EXCEPTION WHEN OTHERS THEN
          V_SEND_PERSON_ID := NULL;
      END;

      BEGIN
        SELECT PM.EMAIL
          INTO  V_SENDER_EMAIL
          FROM HRM_PERSON_MASTER PM
        WHERE PM.PERSON_ID          = V_SEND_PERSON_ID
        ;
      END;


      BEGIN
          UPDATE QM_TROUBLE_ISSUE QTI
             SET QTI.SUBJECT_NAME                = P_SUBJECT_NAME
               , QTI.TROUBLE_DATE                 = P_TROUBLE_DATE
               , QTI.MEASURE_REQ_DATE            = P_MEASURE_REQ_DATE
               , QTI.MEASURE_PERSON_USER_ID      = P_MEASURE_PERSON_USER_ID
               , QTI.PROJECT_ID                  = P_PROJECT_ID
               , QTI.OPERATION_ID                = P_OPERATION_ID
               , QTI.INVENTORY_ITEM_ID           = P_INVENTORY_ITEM_ID
               , QTI.BOM_ITEM_ID                 = P_BOM_ITEM_ID
               , QTI.TROUBLE_CLASS_CODE          = P_TROUBLE_CLASS_CODE
               , QTI.WEEKLY                      = P_WEEKLY
               , QTI.PROBLEM_CLASS               = P_PROBLEM_CLASS
               , QTI.CUSTOMER_SITE_CODE          = P_CUSTOMER_SITE_CODE
               , QTI.TROUBLE_RATE                = P_TROUBLE_RATE
               , QTI.TROUBLE_QTY                 = P_TROUBLE_QTY
               , QTI.WORK_QTY                    = P_WORK_QTY
               , QTI.REJECT_CLASS_CODE           = P_REJECT_CLASS_CODE
               , QTI.REJECT_TYPE_CODE            = P_REJECT_TYPE_CODE
               , QTI.TROUBLE_COMMENT             = P_TROUBLE_COMMENT
              -- , QTI.CAUSE_COMMENT               = P_CAUSE_COMMENT
               , QTI.FACTORY_LCODE               = P_FACTORY_LCODE
               , QTI.WORKCENTER_ID               = P_WORKCENTER_ID
               , QTI.DESCRIPTION                 = P_DESCRIPTION
               , QTI.LAST_UPDATE_DATE            = V_SYSDATE
               , QTI.LAST_UPDATED_BY             = P_USER_ID
               , QTI.MEASURE_CHARGE_PRESON_ID    = P_MEASURE_CHARGE_PRESON_ID
            WHERE TROUBLE_ISSUE_ID               = W_TROUBLE_ISSUE_ID
              AND QTI.ORG_ID                     = P_ORG_ID
              AND QTI.SOB_ID                     = P_SOB_ID
          ;
     END;

     -------------------------
    -- 메일 내용 생성      --
    -------------------------
    BEGIN
         SELECT QTI.TROUBLE_ISSUE_NO
              , QTI.SUBJECT_NAME
              , EAPP_USER_G.USER_NAME_F(QTI.INPUT_PERSON_USER_ID) AS INPUT_PERSON_NAME
              , QTI.INPUT_DATE
              , QTI.TROUBLE_CLASS_CODE
              , (SELECT QTC.DESCRIPTION
                   FROM QM_TROUBLE_CLASS QTC
                  WHERE QTC.TROUBLE_CLASS = QTI.TROUBLE_CLASS_CODE) AS TROUBLE_CLASS_NAME
              , QTI.TROUBLE_DATE
              , QTI.WEEKLY
              , QTI.MEASURE_REQ_DATE
              , HRM_PERSON_MASTER_G.NAME_F(QTI.MEASURE_CHARGE_PRESON_ID) AS MEASURE_CHARGE_PRESON_NAME
              , (SELECT PPM.PROJECT_NAME
                   FROM PLM_PROJECT_MASTER PPM
                  WHERE PPM.PROJECT_ID = QTI.PROJECT_ID)
                  PROJECT_NAME
              , (SELECT IIM.ITEM_CODE
                   FROM INV_ITEM_MASTER_TLV     IIM
                  WHERE IIM.INVENTORY_ITEM_ID = QTI.INVENTORY_ITEM_ID) AS INVENTORY_ITEM_CODE
              , (SELECT IIM.ITEM_DESCRIPTION
                   FROM INV_ITEM_MASTER_TLV     IIM
                  WHERE IIM.INVENTORY_ITEM_ID = QTI.INVENTORY_ITEM_ID) AS INVENTORY_ITEM_DESC
              , (SELECT SSO.OPERATION_CODE
                   FROM SDM_STANDARD_OPERATION_TLV   SSO
                  WHERE SSO.OPERATION_ID      = QTI.OPERATION_ID) AS OPERATION_CODE
              , (SELECT SSO.OPERATION_DESCRIPTION
                   FROM SDM_STANDARD_OPERATION_TLV   SSO
                  WHERE SSO.OPERATION_ID      = QTI.OPERATION_ID) AS OPERATION_DESC
              , (SELECT SIR.BOM_ITEM_CODE
                   FROM SDM_ITEM_REVISION       SIR
                  WHERE SIR.BOM_ITEM_ID = QTI.BOM_ITEM_ID) AS BOM_ITEM_CODE
              , (SELECT SIR.BOM_ITEM_DESCRIPTION
                   FROM SDM_ITEM_REVISION       SIR
                  WHERE SIR.BOM_ITEM_ID = QTI.BOM_ITEM_ID) AS BOM_ITEM_DESC
              , QTI.PROBLEM_CLASS
              , (SELECT QPC.DESCRIPTION
                   FROM QM_PROBLEM_CLASS QPC
                  WHERE QPC.PROBLEM_CLASS = QTI.PROBLEM_CLASS) AS PROBLEM_CLASS_NAME
              , QTI.TROUBLE_RATE AS TROUBLE_RATE
              , QTI.TROUBLE_QTY
              , QTI.WORK_QTY
              , QTI.DESCRIPTION
              , QTI.REJECT_CLASS_CODE
              , (SELECT QRC.DESCRIPTION
                   FROM QM_REJECT_CLASS QRC
                  WHERE QRC.REJECT_CLASS_CODE = QTI.REJECT_CLASS_CODE)AS REJECT_CLASS_NAME

              , QTI.REJECT_TYPE_CODE
              , (SELECT QRT.DESCRIPTION
                   FROM QM_REJECT_TYPE QRT
                  WHERE QRT.REJECT_TYPE_CODE = QTI.REJECT_TYPE_CODE)AS REJECT_TYPE_NAME
              , QTI.FACTORY_LCODE
              , EAPP_COMMON_G.GET_LOOKUP_DESC(QTI.SOB_ID, QTI.ORG_ID, 'WORKCENTER_FACTORY_TYPE', QTI.FACTORY_LCODE) AS FACTORY_NAME
              , (SELECT SSW.WORKCENTER_DESCRIPTION
                   FROM SDM_STANDARD_WORKCENTER SSW
                  WHERE SSW.WORKCENTER_ID = QTI.WORKCENTER_ID) AS WORKCENTER_NAME
              , QTI.TROUBLE_COMMENT
             -- , QTI.CAUSE_COMMENT
               , HPM.NAME
               , HPM.EMAIL
           INTO V_TROUBLE_ISSUE_NO
              , V_SUBJECT_NAME
              , V_INPUT_PERSON_NAME
              , V_INPUT_DATE
              , V_TROUBLE_CLASS_CODE
              , V_TROUBLE_CLASS_NAME
              , V_TROUBLE_DATE
              , V_WEEKLY
              , V_MEASURE_REQ_DATE
              , V_MEASURE_CHARGE_PRESON_NAME
              , V_PROJECT_NAME
              , V_INVENTORY_CODE
              , V_INVENTORY_ITEM
              , V_OPERATION_CODE
              , V_OPERATION_NAME
              , V_BOM_ITEM_CODE
              , V_BOM_ITEM_NAME
              , V_PROBLEM_CLASS_CODE
              , V_PROBLEM_CLASS_NAME
              , V_TROUBLE_RATE
              , V_TROUBLE_QTY
              , V_WORK_QTY
              , V_DESCRIPTION
              , V_REJECT_CLASS_CODE
              , V_REJECT_CLASS_NAME
              , V_REJECT_TYPE_CODE
              , V_REJECT_TYPE_NAME
              , V_FACTORY_LCODE
              , V_FACTORY_NAME
              , V_WORKCENTER_NAME
              , V_TROUBLE_COMMENT
              , V_MEASURE_CHARGE_PRESON
              , V_MEASURE_CHARGE_PRESON_MAIL

              --, V_STATUS_LCODE
              --, V_STATUS_NAME
           FROM QM_TROUBLE_ISSUE      QTI
              , HRM_PERSON_MASTER     HPM
          WHERE QTI.TROUBLE_ISSUE_ID        = NVL(W_TROUBLE_ISSUE_ID, QTI.TROUBLE_ISSUE_ID)
            AND QTI.MEASURE_CHARGE_PRESON_ID = HPM.PERSON_ID
            AND QTI.SOB_ID                  = P_SOB_ID
            AND QTI.ORG_ID                  = P_ORG_ID
            ;

      EXCEPTION WHEN OTHERS THEN
         V_TROUBLE_ISSUE_NO          := NULL;
         V_SUBJECT_NAME              := NULL;
         V_INPUT_PERSON_NAME         := NULL;
         V_INPUT_DATE                := NULL;
         V_TROUBLE_CLASS_CODE        := NULL;
         V_TROUBLE_CLASS_NAME        := NULL;
         V_TROUBLE_DATE              := NULL;
         V_WEEKLY                    := NULL;
         V_MEASURE_REQ_DATE          := NULL;
         V_MEASURE_CHARGE_PRESON_NAME  := NULL;
         V_PROJECT_NAME              := NULL;
         V_INVENTORY_CODE            := NULL;
         V_INVENTORY_ITEM            := NULL;
         V_OPERATION_CODE            := NULL;
         V_OPERATION_NAME            := NULL;
         V_BOM_ITEM_CODE             := NULL;
         V_BOM_ITEM_NAME             := NULL;
         V_PROBLEM_CLASS_CODE        := NULL;
         V_PROBLEM_CLASS_NAME        := NULL;
         V_TROUBLE_RATE              := NULL;
         V_TROUBLE_QTY               := NULL;
         V_WORK_QTY                  := NULL;
         V_DESCRIPTION               := NULL;
         V_REJECT_CLASS_CODE         := NULL;
         V_REJECT_CLASS_NAME         := NULL;
         V_REJECT_TYPE_CODE          := NULL;
         V_REJECT_TYPE_NAME          := NULL;
         V_FACTORY_LCODE             := NULL;
         V_FACTORY_NAME              := NULL;
         V_WORKCENTER_NAME           := NULL;
         V_TROUBLE_COMMENT           := NULL;
        -- V_CAUSE_COMMENT             := NULL;
         --V_STATUS_LCODE        := NULL;
         --V_STATUS_NAME         := NULL;
      END;
        -------------------------
        -- 메일 내용 작성      --
        -------------------------

        V_STATUS := '이슈변경 ';


        V_SUBJECT := '[품질이슈] ' || V_SUBJECT_NAME ||'(' ||V_TROUBLE_ISSUE_NO||')에 대한 이슈변경 (대책 담당자: ' ||V_MEASURE_CHARGE_PRESON_NAME||')' ;

        V_TEXT1  :=  V_STATUS || '메일이 접수되었습니다.';

        V_TEXT2  := '---------------------- < 아 래 > -------------------------';

        V_TEXT3  := '발 생 번 호 : ' || V_TROUBLE_ISSUE_NO;
        V_TEXT4  := '제 목 : ' || V_SUBJECT_NAME;

        V_TEXT5  := '등 록 자 : ' || V_INPUT_PERSON_NAME ;
        V_TEXT6  := '등 록 일 : ' || V_INPUT_DATE;
        V_TEXT7  := '불 량 구 분 : ' || V_TROUBLE_CLASS_NAME||' ('|| V_TROUBLE_CLASS_CODE||')';
        V_TEXT8  := '불 량 발 생 일 : ' || V_TROUBLE_DATE;
        --V_TEXT9  := '주 차 : ' || V_WEEKLY;
        V_TEXT10  := '대 책 요 구 일 / 대 책 담 당 자 : ' || V_MEASURE_REQ_DATE ||' / '|| V_MEASURE_CHARGE_PRESON_NAME;

       -- V_TEXT11  := '프 로 젝 트 명 : ' || V_PROJECT_NAME;
        V_TEXT12 := '제 품 명 : ' || V_INVENTORY_ITEM ||' ('|| V_INVENTORY_CODE||')';
        V_TEXT13 := '공 정 명 : ' || V_OPERATION_NAME ||' ('|| V_OPERATION_CODE||')';
        --V_TEXT14 := '모 델 명: ' || V_BOM_ITEM_NAME ||' ('|| V_BOM_ITEM_CODE||')';
        /*V_TEXT15 := '공 장 구 분 : ' || V_FACTORY_NAME ||' ('|| V_FACTORY_LCODE||')';*/
        /*V_TEXT16 := '작 업 장 : ' || V_WORKCENTER_NAME;*/

        V_TEXT17 := '문 제 구 분 : ' || V_PROBLEM_CLASS_NAME ||' ('|| V_PROBLEM_CLASS_CODE||')';
        /*V_TEXT18 := '불 량 율 : ' || V_TROUBLE_RATE ||'%';*/
        /*V_TEXT19 := '불 량 수 / 작 업 량 : ' || V_TROUBLE_QTY ||' / '|| V_WORK_QTY;*/
        /*V_TEXT20 := '비 고 : ' || V_DESCRIPTION ;*/

        V_TEXT21 := '불 량 공 정 : ' || V_REJECT_CLASS_NAME ||' ('|| V_REJECT_CLASS_CODE||')';
        V_TEXT22 := '불 량 유 형 : ' || V_REJECT_TYPE_NAME ||' ('|| V_REJECT_TYPE_CODE||')';

        V_TEXT23 := '불 량 현 상 내 용 : ' || V_TROUBLE_COMMENT ;
        --V_TEXT24 := '불 량 현 상 원 인 : ' || V_CAUSE_COMMENT ;

        V_TEXT25 := '----------------------------------------------------------';

        V_TEXT26 := '대책담당자로 지정되신 ' || V_MEASURE_CHARGE_PRESON_NAME|| '님 께서는' || V_MEASURE_REQ_DATE || '까지 대책입력 바랍니다.';

        V_CONTENT := '<HTML><BODY><BR>' ||
                     '<b>'||
                     '<FONT color=BLACK size=2><ins>' || V_TEXT1  || '</font><br><br>'||
                     '<FONT color=BLACK size=2>' || V_TEXT2  || '</font><br><br>'||
                     '<FONT color=BLACK size=2>' || V_TEXT3  || '</font><br>'||
                     '<FONT color=BLACK size=2>' || V_TEXT4  || '</font><br><br>'||
                     '<FONT color=BLACK size=2>' || V_TEXT5  || '</font><br>'||
                     '<FONT color=BLACK size=2>' || V_TEXT6  || '</font><br>'||

                     '<FONT color=BLACK size=2>' || V_TEXT8  || '</font><br>'||
                     --'<FONT color=BLACK size=2>' || V_TEXT9  || '</font><br>'||
                     '<FONT color=BLACK size=2>' || V_TEXT10 || '</font><br>'||
                     --'<FONT color=BLACK size=2>' || V_TEXT11 || '</font><br><br>'||
                     '<FONT color=BLACK size=2>' || V_TEXT12 || '</font><br>'||
                     --'<FONT color=BLACK size=2>' || V_TEXT13 || '</font><br>'||
                     --'<FONT color=BLACK size=2>' || V_TEXT14 || '</font><br>'||
                     /*'<FONT color=BLACK size=2>' || V_TEXT15 || '</font><br>'||*/
                     /*'<FONT color=BLACK size=2>' || V_TEXT16 || '</font><br><br>'||*/
                     '<FONT color=BLACK size=2>' || V_TEXT17 || '</font><br>'||
                     /*'<FONT color=BLACK size=2>' || V_TEXT18 || '</font><br>'||
                     '<FONT color=BLACK size=2>' || V_TEXT19 || '</font><br>'||
                     '<FONT color=BLACK size=2>' || V_TEXT20 || '</font><br><br>'||*/
                     '<FONT color=BLACK size=2>' || V_TEXT7  || '</font><br>'||
                     '<FONT color=BLACK size=2>' || V_TEXT21 || '</font><br>'||
                     '<FONT color=BLACK size=2>' || V_TEXT22 || '</font><br><br>'||
                     '<FONT color=BLACK size=2>' || V_TEXT23 || '</font><br>'||
                     '<FONT color=BLACK size=2>' || V_TEXT24 || '</font><br><br>'||
                     '<FONT color=BLACK size=2>' || V_TEXT25 || '</font><br><br>'||
                     '<FONT color=BLACK size=2>' || V_TEXT26 || '</font><br><br>'
                     ;

        V_CONTENT := V_CONTENT ||
                     '</b>' ||
                     '</html></body>';
                --2. 이메일 본문 작성 및 수신자별 이메일 보내기.
        V_RCPT_EMAIL := NULL;

        V_RCPT_NAME := V_MEASURE_CHARGE_PRESON || '<' ||V_MEASURE_CHARGE_PRESON_MAIL || '>';
        V_RCPT_EMAIL  :=  V_RCPT_EMAIL || V_MEASURE_CHARGE_PRESON_MAIL || '; ';

        -- EMAIL 발송.
          IF EAPP_MAIL_SEND.MAIL_SEND( P_PERSON_NAME_FR => 'Trouble'
                                     , P_EMAIL_FR       => V_SENDER_EMAIL
                                     , P_PERSON_NAME_TO => V_RCPT_NAME
                                     , P_EMAIL_TO       => V_RCPT_EMAIL
                                     , P_SUBJECT        => V_SUBJECT
                                     , P_CONTENT        => V_CONTENT
                                     ) = FALSE THEN
           -- X_RESULT_MSG := 'E-MAIL Send Error : ' || SUBSTR(SQLERRM, 1, 150);
            RETURN;
          END IF;

  END;
END UPDATE_TROUBLE_ISSUE_MASTER;


----------------------------------------------------------------------------------------
-- 품질부적합 발생 : 부적합 등록 완료 및 승인 요청 상태 변경                          --
----------------------------------------------------------------------------------------          
  PROCEDURE SET_NCR_ISSUE_REQ_APPR
            ( W_NCR_ISSUE_ID         IN  QM_NCR_ISSUE.NCR_ISSUE_ID%TYPE
            , W_SOB_ID               IN  QM_NCR_ISSUE.SOB_ID%TYPE
            , W_ORG_ID               IN  QM_NCR_ISSUE.ORG_ID%TYPE
            , W_REQ_STATUS           IN  VARCHAR2
            , O_STATUS               OUT VARCHAR2
            , O_MESSAGE              OUT VARCHAR2
            )
  AS
    V_NCR_STATUS          VARCHAR2(50);
  BEGIN
    O_STATUS := 'F';
    -- 현재 부적합 발행 상태 -- 
    V_NCR_STATUS := GET_NCR_ISSUE_STATUS_F
                      ( W_NCR_ISSUE_ID => W_NCR_ISSUE_ID
                      , P_SOB_ID       => W_SOB_ID 
                      , P_ORG_ID       => W_ORG_ID 
                      );
    
    IF W_REQ_STATUS = 'REQ_APPR_OK' THEN
      -- 승인 요청 -- 
      IF V_NCR_STATUS NOT IN('ENTER') THEN
        O_STATUS := 'F';
        O_MESSAGE := EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10277');
        RETURN;
      END IF;
      
      V_NCR_STATUS := 'ENTERED';
    ELSIF W_REQ_STATUS = 'REQ_APPR_CANCEL' THEN
      -- 승인요청 취소 -- 
      IF V_NCR_STATUS NOT IN('ENTERED') THEN
        O_STATUS := 'F';
        O_MESSAGE := EAPP_MESSAGE_G.RETURN_MSG_F('EAPP_10111');
        RETURN;
      END IF;
      V_NCR_STATUS := 'ENTER';
    ELSE
      O_STATUS := 'F';
      O_MESSAGE := EAPP_MESSAGE_G.RETURN_MSG_F('EAPP_10110');
      RETURN;
    END IF;
    
    -- NCR ISSUE 상태 UPDATE -- 
    BEGIN
      UPDATE QM_NCR_ISSUE NI
         SET NI.NCR_STATUS        = V_NCR_STATUS
       WHERE NI.NCR_ISSUE_ID      = W_NCR_ISSUE_ID
       ;
    EXCEPTION
      WHEN OTHERS THEN
        O_STATUS := 'F';
        O_MESSAGE := 'NCR Issue Update Error : ' || SQLERRM;
        RETURN;
    END;
    O_STATUS := 'S';
  END SET_NCR_ISSUE_REQ_APPR;
  
              
----------------------------------------------------------------------------------------
-- 품질부적합 발생 : 부적합 LOT 정보 리턴                                             --
----------------------------------------------------------------------------------------          
  PROCEDURE GET_NCR_JOB_P
            ( W_JOB_NO               IN  VARCHAR2 
            , W_SOB_ID               IN  NUMBER
            , W_ORG_ID               IN  NUMBER 
            , O_STATUS               OUT VARCHAR2
            , O_MESSAGE              OUT VARCHAR2 
            , O_JOB_ID               OUT NUMBER
            , O_JOB_NO               OUT VARCHAR2 
            , O_INVENTORY_ITEM_ID    OUT NUMBER 
            , O_BOM_ITEM_ID          OUT NUMBER
            , O_UOM_CODE             OUT VARCHAR2 
            , O_ONHAND_QTY           OUT NUMBER 
            ) 
  AS
  BEGIN
    O_STATUS := 'F';
    BEGIN
      SELECT JE.JOB_ID
           , JE.JOB_NO
           , JE.INVENTORY_ITEM_ID
           , JE.BOM_ITEM_ID
           , JE.UOM_CODE 
           , JE.ONHAND_QTY 
        INTO O_JOB_ID
           , O_JOB_NO
           , O_INVENTORY_ITEM_ID
           , O_BOM_ITEM_ID
           , O_UOM_CODE
           , O_ONHAND_QTY
        FROM WIP_JOB_ENTITIES JE
       WHERE JE.JOB_NO            = W_JOB_NO 
         AND JE.SOB_ID            = W_SOB_ID
         AND JE.ORG_ID            = W_ORG_ID 
         AND JE.JOB_RELEASE_FLAG  = 'Y'
         AND JE.JOB_STATUS_CODE   IN('RELEASE', 'ONHOLD')  -- 활성화, 대기 상태인 JOB만 적용 
       ;
    EXCEPTION
      WHEN OTHERS THEN
        O_MESSAGE              := 'Job find error. Please, Check Job No';
        O_JOB_ID               := -1;
        O_JOB_NO               := 'ERROR'; 
        O_INVENTORY_ITEM_ID    := -1;
        O_BOM_ITEM_ID          := -1;
        O_UOM_CODE             := '';
        O_ONHAND_QTY           := -1;
        RETURN;
    END;
    O_STATUS := 'S';
  END GET_NCR_JOB_P;
  
----------------------------------------------------------------------------------------
-- 품질부적합 발생 : 해당 NCR ISSUE 상태 리턴                                         --
----------------------------------------------------------------------------------------          
  FUNCTION GET_NCR_ISSUE_STATUS_F
            ( W_NCR_ISSUE_ID         IN  QM_NCR_ISSUE.NCR_ISSUE_ID%TYPE
            , P_SOB_ID               IN  QM_NCR_ISSUE.SOB_ID%TYPE
            , P_ORG_ID               IN  QM_NCR_ISSUE.ORG_ID%TYPE
            ) RETURN VARCHAR2
  AS
    V_NCR_ISSUE_STATUS        VARCHAR2(50);
  BEGIN
    BEGIN
      SELECT NI.NCR_STATUS 
        INTO V_NCR_ISSUE_STATUS 
        FROM QM_NCR_ISSUE NI
       WHERE NI.NCR_ISSUE_ID            = W_NCR_ISSUE_ID
         AND NI.SOB_ID                  = P_SOB_ID
         AND NI.ORG_ID                  = P_ORG_ID 
      ; 
    EXCEPTION
      WHEN OTHERS THEN
        V_NCR_ISSUE_STATUS := 'ERROR';
    END;
    RETURN V_NCR_ISSUE_STATUS;
  END GET_NCR_ISSUE_STATUS_F;
  
  
--------------------------------------------------------------------
-- 품질 부적합 리스트 룩업 : 권한에 대한 NCR만 조회               --
--------------------------------------------------------------------
  PROCEDURE LU_NCR_ISSUE_CAP
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_SOB_ID               IN  NUMBER 
            , W_ORG_ID               IN  NUMBER 
            , W_CONNECT_USER_ID      IN  NUMBER 
            , W_NCR_ISSUE_NO         IN  VARCHAR2 
            )
  AS
    V_SYSDATE           DATE := TRUNC(GET_LOCAL_DATE(W_SOB_ID));
  BEGIN
      OPEN P_CURSOR FOR
          SELECT NI.NCR_ISSUE_ID
               , NI.NCR_ISSUE_NO
               , NI.ISSUE_DATE
               , D_SW.WORKCENTER_CODE
               , D_SW.WORKCENTER_DESCRIPTION 
               , IM.ITEM_CODE
               , IM.ITEM_DESCRIPTION
               , IM.ITEM_LAYER_LCODE
               , IM.ITEM_TYPE_LCODE
               , C_SW.WORKCENTER_CODE AS CAUSE_WORKCENTER_CODE
               , C_SW.WORKCENTER_DESCRIPTION AS CAUSE_WORKCENTER_DESC 
               , C_SO.OPERATION_CODE AS CAUSE_OPERATION_CODE
               , C_SO.OPERATION_DESCRIPTION AS CAUSE_OPERATION_DESC                
               , NI.NCR_STATUS 
            FROM QM_NCR_ISSUE            NI
               , SDM_STANDARD_WORKCENTER D_SW
               , INV_ITEM_MASTER         IM
               , SDM_STANDARD_WORKCENTER C_SW 
               , SDM_STANDARD_OPERATION  C_SO
           WHERE NI.WORKCENTER_ID           = D_SW.WORKCENTER_ID 
             AND NI.INVENTORY_ITEM_ID       = IM.INVENTORY_ITEM_ID 
             AND NI.CAUSE_WORKCENTER_ID     = C_SW.WORKCENTER_ID(+)
             AND NI.CAUSE_OPERATION_ID      = C_SO.OPERATION_ID(+) 
             AND NI.SOB_ID                  = W_SOB_ID 
             AND NI.ORG_ID                  = W_ORG_ID 
             AND NI.NCR_ISSUE_NO            LIKE W_NCR_ISSUE_NO || '%'
             -- 권한 체크 -- 
             AND EXISTS
                   (SELECT 'X'
                      FROM EAPP_USER        EU
                         , WIP_USER_CONTROL UC
                     WHERE EU.USER_ID       = UC.USER_ID(+)  
                       AND EU.USER_ID       = W_CONNECT_USER_ID 
                       AND EU.SOB_ID        = W_SOB_ID 
                       AND EU.ORG_ID        = W_ORG_ID 
                       AND EU.ENABLED_FLAG  = 'Y'
                       AND EU.EFFECTIVE_DATE_FR   <= V_SYSDATE 
                       AND (EU.EFFECTIVE_DATE_TO  >= V_SYSDATE OR EU.EFFECTIVE_DATE_TO IS NULL) 
                       -- 전체 사용 권한자는 모든 작업장 표시 --
                       AND CASE
                             WHEN EU.WIP_TRX_CONTROL = 'UNLIMITED' THEN NI.WORKCENTER_ID 
                             ELSE UC.WORKCENTER_ID
                           END              = NI.WORKCENTER_ID 
                   )
          ; 
  END LU_NCR_ISSUE_CAP;

-----------------------------------------------------
-- 품질 부적합 리스트 룩업 : 전체 조회             --
-----------------------------------------------------
  PROCEDURE LU_NCR_ISSUE_ALL
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_SOB_ID               IN  NUMBER 
            , W_ORG_ID               IN  NUMBER 
            , W_CONNECT_PERSON_ID    IN  NUMBER 
            , W_NCR_ISSUE_NO         IN  VARCHAR2 
            )
  AS
  BEGIN
      OPEN P_CURSOR FOR
          SELECT NI.NCR_ISSUE_ID
               , NI.NCR_ISSUE_NO
               , NI.ISSUE_DATE
               , D_SW.WORKCENTER_CODE
               , D_SW.WORKCENTER_DESCRIPTION 
               , IM.ITEM_CODE
               , IM.ITEM_DESCRIPTION
               , IM.ITEM_LAYER_LCODE
               , IM.ITEM_TYPE_LCODE
               , C_SW.WORKCENTER_CODE AS CAUSE_WORKCENTER_CODE
               , C_SW.WORKCENTER_DESCRIPTION AS CAUSE_WORKCENTER_DESC 
               , C_SO.OPERATION_CODE AS CAUSE_OPERATION_CODE
               , C_SO.OPERATION_DESCRIPTION AS CAUSE_OPERATION_DESC                
               , NI.NCR_STATUS 
            FROM QM_NCR_ISSUE            NI
               , SDM_STANDARD_WORKCENTER D_SW
               , INV_ITEM_MASTER         IM
               , SDM_STANDARD_WORKCENTER C_SW 
               , SDM_STANDARD_OPERATION  C_SO
           WHERE NI.WORKCENTER_ID           = D_SW.WORKCENTER_ID 
             AND NI.INVENTORY_ITEM_ID       = IM.INVENTORY_ITEM_ID 
             AND NI.CAUSE_WORKCENTER_ID     = C_SW.WORKCENTER_ID(+)
             AND NI.CAUSE_OPERATION_ID      = C_SO.OPERATION_ID(+) 
             AND NI.SOB_ID                  = W_SOB_ID 
             AND NI.ORG_ID                  = W_ORG_ID 
             AND NI.NCR_ISSUE_NO            LIKE W_NCR_ISSUE_NO || '%'
          ; 
  END LU_NCR_ISSUE_ALL;

-----------------------------------------------------------------------
-- LU_INVENTORY_ITEM : 영업제품(ENABLED_FLAG = 'Y')                  --
-----------------------------------------------------------------------
  PROCEDURE LU_INVENTORY_ITEM 
            ( P_CURSOR              OUT TYPES.TCURSOR
            , W_SOB_ID              IN  NUMBER
            , W_ORG_ID              IN  NUMBER
            , W_CUSTOMER_ID         IN  NUMBER
            , W_ITEM_ALIAS          IN  VARCHAR2
            )

AS
   V_LOCAL_DATE  DATE := TRUNC(GET_LOCAL_DATE(W_SOB_ID));
BEGIN
         OPEN P_CURSOR FOR
          SELECT IIM.INVENTORY_ITEM_ID
               , IIM.ITEM_CODE
               , IIM.ITEM_DESCRIPTION
               , IIM.ITEM_LAYER_LCODE
               , IIM.ITEM_TYPE_LCODE 
               , IIM.ITEM_SECTION_CODE
               , IIS.DESCRIPTION           ITEM_SECTION_DESC
               , IIM.PRIMARY_UOM_CODE
               , ACS.CUST_SITE_SHORT_NAME
               , IIM.CUSTOMER_SITE_ID
               , IIM.CUSTOMER_ITEM_CODE
               , IIM.ITEM_BRANCH_LCODE
               , EAPP_COMMON_G.GET_LOOKUP_DESC(IIM.SOB_ID, IIM.ORG_ID, 'ITEM_BRANCH', IIM.ITEM_BRANCH_LCODE) AS ITEM_BRANCH_DESC
            FROM INV_ITEM_MASTER_TLV       IIM
               , INV_ITEM_CATEGORY_TLV     IIC
               , INV_ITEM_SECTION_TLV      IIS
               , AR_CUSTOMER_SITE          ACS
           WHERE IIM.ITEM_DIVISION_CODE    = 'GOODS'
             AND IIM.ITEM_CATEGORY_CODE    = 'FG'
             AND IIM.SOB_ID                = W_SOB_ID
             AND IIM.ORG_ID                = W_ORG_ID
             AND IIM.CUSTOMER_SITE_ID      = NVL(W_CUSTOMER_ID, IIM.CUSTOMER_SITE_ID)
             AND IIC.SOB_ID                = IIM.SOB_ID
             AND IIC.ORG_ID                = IIM.ORG_ID
             AND IIC.ITEM_CATEGORY_CODE    = IIM.ITEM_CATEGORY_CODE
             AND IIS.SOB_ID                = IIM.SOB_ID
             AND IIS.ORG_ID                = IIM.ORG_ID
             AND IIS.ITEM_SECTION_CODE     = IIM.ITEM_SECTION_CODE
             AND ACS.CUST_SITE_ID          = IIM.CUSTOMER_SITE_ID
             AND IIM.ENABLED_FLAG          = 'Y'
             AND V_LOCAL_DATE              BETWEEN IIM.EFFECTIVE_DATE_FR
                                               AND NVL(IIM.EFFECTIVE_DATE_TO, V_LOCAL_DATE)
             AND (  (IIM.ITEM_CODE         LIKE '%' || W_ITEM_ALIAS || '%')
                 OR (IIM.ITEM_DESCRIPTION  LIKE '%' || W_ITEM_ALIAS || '%'))
           ORDER BY ITEM_CODE;
  END LU_INVENTORY_ITEM;


--------------------------------------------
-- BOM_ITEM : 내부모델                    --
--------------------------------------------
  PROCEDURE LU_BOM_ITEM 
            ( P_CURSOR              OUT TYPES.TCURSOR
            , W_SOB_ID              IN  NUMBER
            , W_ORG_ID              IN  NUMBER
            , W_INVENTORY_ITEM_ID   IN  NUMBER 
            )
  AS
     V_LOCAL_DATE  DATE := TRUNC(GET_LOCAL_DATE(W_SOB_ID));
  BEGIN
      OPEN P_CURSOR FOR
          SELECT SIR.BOM_ITEM_ID
               , SIR.BOM_ITEM_CODE
               , SIR.BOM_ITEM_DESCRIPTION
               , IIM.ITEM_LAYER_LCODE
               , IIM.ITEM_TYPE_LCODE
               , IIM.ITEM_CATEGORY_CODE
               , IIC.DESCRIPTION           ITEM_CATEGORY_DESC
               , IIM.ITEM_SECTION_CODE
               , IIS.DESCRIPTION           ITEM_SECTION_DESC
               , SIR.INVENTORY_ITEM_ID
               , IIM.ITEM_CODE             INVENTORY_ITEM_CODE
               , IIM.ITEM_DESCRIPTION      INVENTORY_ITEM_DESCRIPTION
            FROM SDM_ITEM_REVISION          SIR
               , SDM_ITEM_SPEC              SIS
               , INV_ITEM_MASTER_TLV        IIM
               , INV_ITEM_CATEGORY_TLV      IIC
               , INV_ITEM_SECTION_TLV       IIS
           WHERE IIM.ITEM_DIVISION_CODE    = 'GOODS'
             AND SIR.SOB_ID                = W_SOB_ID
             AND SIR.ORG_ID                = W_ORG_ID
             AND SIS.BOM_ITEM_ID(+)        = SIR.BOM_ITEM_ID
             AND IIM.INVENTORY_ITEM_ID     = SIR.INVENTORY_ITEM_ID
             AND IIC.SOB_ID                = IIM.SOB_ID
             AND IIC.ORG_ID                = IIM.ORG_ID
             AND IIC.ITEM_CATEGORY_CODE    = IIM.ITEM_CATEGORY_CODE
             AND IIS.SOB_ID                = IIM.SOB_ID
             AND IIS.ORG_ID                = IIM.ORG_ID
             AND IIS.ITEM_SECTION_CODE     = IIM.ITEM_SECTION_CODE
             AND V_LOCAL_DATE              BETWEEN SIR.EFFECTIVE_DATE_FR
                                               AND NVL(SIR.EFFECTIVE_DATE_TO, V_LOCAL_DATE)
             AND NVL(SIR.ENABLED_FLAG,'N') = 'Y'
             AND ((W_INVENTORY_ITEM_ID     IS NULL AND 1 = 1)
             OR   (W_INVENTORY_ITEM_ID     IS NOT NULL AND SIR.INVENTORY_ITEM_ID = W_INVENTORY_ITEM_ID)) 
           ORDER BY SIR.BOM_ITEM_CODE
           ;
  END LU_BOM_ITEM;  


-----------------------------------------------------
-- OPERATION_TYPE : 작업공정 중분류                --
-----------------------------------------------------
  PROCEDURE LU_OPERATION_TYPE    
            ( P_CURSOR             OUT TYPES.TCURSOR
            , W_SOB_ID             IN  NUMBER
            , W_ORG_ID             IN  NUMBER
            , W_OPERATION_CLASS_ID IN  NUMBER
            )
  AS
    V_LOCAL_DATE  DATE := TRUNC(GET_LOCAL_DATE(W_SOB_ID));
  BEGIN
           OPEN P_CURSOR FOR
            SELECT SOT.OP_TYPE_CODE
                 , SOT.OP_TYPE_DESCRIPTION
                 , SOT.OP_TYPE_ID
              FROM SDM_OPERATION_TYPE         SOT
             WHERE SOT.SOB_ID                 = W_SOB_ID
               AND SOT.ORG_ID                 = W_ORG_ID
               AND ((W_OPERATION_CLASS_ID     IS NULL AND 1 = 1)
               OR   (W_OPERATION_CLASS_ID     IS NOT NULL AND SOT.OPERATION_CLASS_ID = W_OPERATION_CLASS_ID)) 
               AND V_LOCAL_DATE               BETWEEN NVL(SOT.EFFECTIVE_DATE_FR,V_LOCAL_DATE)
                                                  AND NVL(SOT.EFFECTIVE_DATE_TO,V_LOCAL_DATE)
               AND NVL(SOT.ENABLED_FLAG,'N')  = 'Y'
             ORDER BY SOT.OP_TYPE_CODE;
  END LU_OPERATION_TYPE; 

-----------------------------------------------------
-- OPERATION : 작업공정                            --
-----------------------------------------------------
  PROCEDURE LU_OPERATION    
            ( P_CURSOR             OUT TYPES.TCURSOR
            , W_SOB_ID             IN  NUMBER
            , W_ORG_ID             IN  NUMBER
            , W_WORKCENTER_ID      IN  NUMBER
            , W_OPERATION_CLASS_ID IN  NUMBER
            , W_OP_TYPE_ID         IN  NUMBER 
            )
  AS
    V_LOCAL_DATE  DATE := TRUNC(GET_LOCAL_DATE(W_SOB_ID));
  BEGIN
    OPEN P_CURSOR FOR
      SELECT SO.OPERATION_CODE
           , SO.OPERATION_DESCRIPTION
           , SO.OPERATION_ID 
           , SO.WORKING_UOM 
           , SO.WORKING_TYPE_LCODE 
        FROM SDM_STANDARD_OPERATION SO
       WHERE SO.SOB_ID                = W_SOB_ID
         AND SO.ORG_ID                = W_ORG_ID
         AND ((W_OPERATION_CLASS_ID   IS NULL AND 1 = 1)
         OR   (W_OPERATION_CLASS_ID   IS NOT NULL AND SO.OPERATION_CLASS_ID = W_OPERATION_CLASS_ID)) 
         AND ((W_OP_TYPE_ID           IS NULL AND 1 = 1)
         OR   (W_OP_TYPE_ID           IS NOT NULL AND SO.OPERATION_TYPE_ID = W_OP_TYPE_ID)) 
         AND V_LOCAL_DATE             BETWEEN NVL(SO.EFFECTIVE_DATE_FR, V_LOCAL_DATE)
                                          AND NVL(SO.EFFECTIVE_DATE_TO, V_LOCAL_DATE)
         AND NVL(SO.ENABLED_FLAG,'N') = 'Y'
       ORDER BY SO.OPERATION_CODE
       ;
  END LU_OPERATION; 
  
--------------------------------------------------------------------------------
-- LU_USER_CAP_WORKCENTER : 작업장(공정사용자 관리 정의된 작업장에 대해 표시) --
--------------------------------------------------------------------------------
  PROCEDURE LU_USER_CAP_WORKCENTER
            ( P_CURSOR              OUT TYPES.TCURSOR
            , W_SOB_ID              IN  NUMBER
            , W_ORG_ID              IN  NUMBER
            , W_CONNECT_USER_ID     IN  NUMBER 
            )
  AS
    V_SYSDATE           DATE := TRUNC(GET_LOCAL_DATE(W_SOB_ID));
  BEGIN
    OPEN P_CURSOR FOR
      SELECT SW.WORKCENTER_ID
           , SW.WORKCENTER_CODE
           , SW.WORKCENTER_DESCRIPTION
        FROM SDM_STANDARD_WORKCENTER SW
       WHERE SW.SOB_ID                  = W_SOB_ID 
         AND SW.ORG_ID                  = W_ORG_ID 
         AND SW.ENABLED_FLAG            = 'Y'
           
         -- 권한 체크 -- 
         AND EXISTS
               (SELECT 'X'
                  FROM EAPP_USER        EU
                     , WIP_USER_CONTROL UC
                 WHERE EU.USER_ID       = UC.USER_ID(+)  
                   AND EU.USER_ID       = W_CONNECT_USER_ID 
                   AND EU.SOB_ID        = W_SOB_ID 
                   AND EU.ORG_ID        = W_ORG_ID 
                   AND EU.ENABLED_FLAG  = 'Y'
                   AND EU.EFFECTIVE_DATE_FR   <= V_SYSDATE 
                   AND (EU.EFFECTIVE_DATE_TO  >= V_SYSDATE OR EU.EFFECTIVE_DATE_TO IS NULL) 
                   -- 전체 사용 권한자는 모든 작업장 표시 --
                   AND CASE
                         WHEN EU.WIP_TRX_CONTROL = 'UNLIMITED' THEN SW.WORKCENTER_ID 
                         ELSE UC.WORKCENTER_ID
                       END              = SW.WORKCENTER_ID 
               );
                 
  END LU_USER_CAP_WORKCENTER;           

-------------------------------------------------------------------------------------------------------
-- LU_MEASURE_PERSON : 대책담당자
-------------------------------------------------------------------------------------------------------
  PROCEDURE LU_MEASURE_PERSON ( P_CURSOR              OUT TYPES.TCURSOR
                              , W_SOB_ID              IN  NUMBER
                              , W_ORG_ID              IN  NUMBER
                              )
  AS
  BEGIN
        OPEN P_CURSOR FOR
         SELECT PM.NAME
              , PM.PERSON_NUM
              , HRM_DEPT_MASTER_G.DEPT_NAME_F(PM.DEPT_ID) AS DEPT_NAME
              , DECODE(PM.POST_ID, NULL, NULL, ' ') || HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS POST_NAME
              , PM.PERSON_ID
           FROM EAPP_EMAIL_PERSON_TYPE EPT
              , EAPP_EMAIL_PERSON_ENTRY EPE
              , HRM_PERSON_MASTER PM
          WHERE EPT.EMAIL_TYPE_ID           = EPE.EMAIL_TYPE_ID
            AND EPE.EMAIL_PERSON_ID         = PM.PERSON_ID
            AND EPT.EMAIL_TYPE              = 'QM_TROUBLE_MEASURE'
            AND PM.EMAIL                    IS NOT NULL
            AND EPT.SOB_ID                  = W_SOB_ID
            AND EPT.ORG_ID                  = W_ORG_ID
            AND EPE.ENABLED_FLAG            = 'Y'
            AND EPE.EFFECTIVE_DATE_FR       <= TRUNC(SYSDATE)
            AND (EPE.EFFECTIVE_DATE_TO      >= TRUNC(SYSDATE) OR EPE.EFFECTIVE_DATE_TO IS NULL)
       ORDER BY PM.PERSON_NUM;

  END LU_MEASURE_PERSON;



---------------------------------------------
-- 해당 불량 구분에 따른 불량 공정 룩업    --
---------------------------------------------
  PROCEDURE LU_REJECT_CLASS 
            ( P_CURSOR                OUT TYPES.TCURSOR
            , W_SOB_ID                IN  NUMBER
            , W_ORG_ID                IN  NUMBER
            , W_REJECT_DIVISION_CODE  IN  VARCHAR2 
            )
  AS
  BEGIN
        OPEN P_CURSOR FOR
           SELECT QRC.REJECT_CLASS_CODE   
                , QRC.DESCRIPTION
                , QRC.REJECT_CLASS_ID
             FROM QM_REJECT_CLASS QRC
            WHERE QRC.SOB_ID      = W_SOB_ID
              AND QRC.ORG_ID      = W_ORG_ID
              AND ((W_REJECT_DIVISION_CODE = 'WIP' AND QRC.WIP_USABLE_FLAG = 'Y')
              OR   (W_REJECT_DIVISION_CODE = 'MAT' AND QRC.MAT_USABLE_FLAG = 'Y')
              OR   (W_REJECT_DIVISION_CODE = 'FPCB' AND QRC.FPCB_FLAG = 'Y')
              OR   (W_REJECT_DIVISION_CODE = 'SMD' AND QRC.SMD_FLAG = 'Y')
              OR   (W_REJECT_DIVISION_CODE = 'ASSY' AND QRC.ASSY_FLAG = 'Y')
              OR   (W_REJECT_DIVISION_CODE = 'ALL' AND QRC.COMMON_FLAG = 'Y'))
            ORDER BY QRC.REJECT_CLASS_CODE;
  END LU_REJECT_CLASS;

---------------------
-- 불량 항 룩업    -- 
---------------------
  PROCEDURE LU_REJECT_TYPE 
            ( P_CURSOR              OUT TYPES.TCURSOR
            , W_SOB_ID              IN  NUMBER
            , W_ORG_ID              IN  NUMBER
            , W_REJECT_CLASS_ID     IN QM_REJECT_TYPE.REJECT_CLASS_ID%TYPE
            )
  AS
  BEGIN
      OPEN P_CURSOR FOR
          SELECT QRT.REJECT_TYPE_ID
               , QRT.REJECT_TYPE_CODE  
               , QRT.DESCRIPTION
               , QRT.PROBLEM_LEVEL_CODE
               , EAPP_COMMON_G.GET_LOOKUP_DESC(QRT.SOB_ID, QRT.ORG_ID, 'PROBLEM_LEVEL_CODE', QRT.PROBLEM_LEVEL_CODE) AS PROBLEM_LEVEL_DESC
           FROM QM_REJECT_TYPE QRT
          WHERE QRT.SOB_ID            = W_SOB_ID
            AND QRT.ORG_ID            = W_ORG_ID
            AND ((W_REJECT_CLASS_ID   IS NULL AND 1 = 1)
            OR   (W_REJECT_CLASS_ID   IS NOT NULL AND QRT.REJECT_CLASS_ID = W_REJECT_CLASS_ID)) 
            AND QRT.ENABLED_FLAG = 'Y'
          ORDER BY QRT.REJECT_TYPE_CODE
          ;
  END LU_REJECT_TYPE;

  ---------------------
 -- 이메일 전송 : CSR HW 미접수 사항 이메일 전송  --
 ---------------------
PROCEDURE SEND_MAIL_TROUBLE_ISSUE
IS

  P_CONNECT_PERSON_ID           NUMBER := NULL;
  P_SOB_ID                      NUMBER := 20;
  P_ORG_ID                      NUMBER := 201;

  V_SYSDATE                     DATE := GET_LOCAL_DATE(P_SOB_ID);
  V_RECORD_COUNT                NUMBER := 0;

  V_SENDER_NAME                 VARCHAR2(100);    -- 발송자 성명.
  V_SENDER_EMAIL                VARCHAR2(200);    -- 발송자 이메일주소.

  V_RCPT_NAME                   VARCHAR2(1000);   -- 수신자 성명.
  V_RCPT_EMAIL                  VARCHAR2(1000);   -- 수신자 이메일주소.

  V_SUBJECT                     VARCHAR2(300);    -- 제목.
  V_CONTENT_TOP                 VARCHAR2(10000);  -- 본문 (상).
  V_CONTENT_TABLE               VARCHAR2(30000);  -- 내용(표).
  V_CONTENT_LOW                 VARCHAR2(10000);  -- 본문 (끝).
BEGIN
   -- 보내는 사람 정보 --
  BEGIN
    SELECT PM.EMAIL
         , PM.EMAIL
      INTO V_SENDER_NAME
         , V_SENDER_EMAIL
      FROM HRM_PERSON_MASTER PM
     WHERE PM.PERSON_ID         = P_CONNECT_PERSON_ID
    ;
  EXCEPTION WHEN OTHERS THEN
    V_SENDER_NAME := 'no-reply@flexcom.co.kr';
    V_SENDER_EMAIL := NULL;
  END;

  -- 해당 기준일자에 대한 제품재고 리스트 존재 여부 체크 => 없으면 SKIP, 있으면 EMAIL SEND --
  BEGIN
    SELECT COUNT(DISTINCT QTI.TROUBLE_ISSUE_ID) AS RECORD_COUNT
      INTO V_RECORD_COUNT
      FROM QM_TROUBLE_ISSUE QTI
     WHERE QTI.SOB_ID                                                                                      = P_SOB_ID
       AND QTI.ORG_ID                                                                                      = P_ORG_ID
       AND (to_date(to_char(V_SYSDATE, 'yyyymmddhh24mi'),'yyyymmddhh24mi') - (1/24/60*10))                > QTI.MEASURE_REQ_DATE
       AND QTI.STATUS_LCODE                                                                                = 'ENTERED'
       ;
  EXCEPTION WHEN OTHERS THEN
    V_RECORD_COUNT := 0;
  END;
  IF V_RECORD_COUNT = 0 THEN
    RETURN;
  END IF;

-----------------------------------------------------------------------------------------------------------------------
    -- 이메일 내용 작성.
    V_SUBJECT := '품질 이슈 미접수 리스트';

    V_CONTENT_TOP := '<HTML><BODY><BR>' ||
                    '<b>' ||
                    '<FONT color=BLACK size=2>안녕하세요. </font><br>'||
                    --'<FONT color=BLACK size=2>' || V_SENDER_NAME || '님으로 부터 </font><br> ' ||
                    '<FONT color=BLACK size=2>품질 이슈 미접수 리스트 입니다. </font><br><br>';

    V_CONTENT_TABLE := '<table Border="1" cellspacing="0">' ||
                        '<font>' ||
                        '<tr>' ||
                        '  <td Align = center> ; ISSUE NO   ;</td>' ||
                        '  <td Align = center> ; 제목       ;</td>' ||
                        '  <td Align = center> ; 요청자     ;</td>' ||
                        '  <td Align = center> ; 이슈발생일 ;</td>' ||
                        '  <td Align = center> ; 요청납기일 ;</td>' ||
                        '  <td Align = center> ; 대책담당자 ;</td>' ||
                        '</tr>';


    FOR C1 IN ( SELECT DISTINCT
                       QTI.TROUBLE_ISSUE_NO
                     , QTI.SUBJECT_NAME
                     , EAPP_COMMON_G.GET_PERSON_SNAME_BY_USER(QTI.INPUT_PERSON_USER_ID) AS INPUT_PERSON_NAME
                     , QTI.INPUT_DATE
                     , QTI.MEASURE_REQ_DATE
                     , EAPP_COMMON_G.GET_PERSON_NAME(QTI.MEASURE_CHARGE_PRESON_ID) AS MEASURE_CHARGE_PERSON_NAME
                 FROM QM_TROUBLE_ISSUE QTI
                  WHERE QTI.SOB_ID                                                                                      = P_SOB_ID
                    AND QTI.ORG_ID                                                                                      = P_ORG_ID
                    AND (to_date(to_char(V_SYSDATE, 'yyyymmddhh24mi'),'yyyymmddhh24mi') - (1/24/60*10))                > QTI.MEASURE_REQ_DATE
                    AND QTI.STATUS_LCODE                                                                                = 'ENTERED'
              ORDER BY QTI.TROUBLE_ISSUE_ID
                )
    LOOP
      V_CONTENT_TABLE := V_CONTENT_TABLE ||
                        '<tr>' ||
                        '  <td> ;' || C1.TROUBLE_ISSUE_NO || ' ;</td>' ||
                        '  <td> ;' || C1.SUBJECT_NAME || ' ;</td>' ||
                        '  <td> ;' || C1.INPUT_PERSON_NAME || ' ;</td>' ||
                        '  <td> ;' || C1.INPUT_DATE || ' ;</td>' ||
                        '  <td> ;' || C1.MEASURE_REQ_DATE ||  ';</td>' ||
                        '  <td> ;' || C1.MEASURE_CHARGE_PERSON_NAME ||  ';</td>' ||
                        '</tr>';


    END LOOP C1;
    V_CONTENT_TABLE := V_CONTENT_TABLE ||
                      '</font>' ||
                      '</table>';

    V_CONTENT_LOW := /* -- 바로가기 설정 정보.
                     '<FONT color=BLUE size=2>' || '<a href=''http://lgisdev02.lgis.com:8007/dev60cgi/f60cgi''>' ||'ERP SYSTEM 바로가기(CLICK)'||'</a>'||
                     */
                     '<br><br>' ||
                     '<b>' ||
                     --'<FONT color=BLUE size=2>문의사항은 [' || V_SENDER_NAME || ']에게 문의하시기 바랍니다.</font><br>' ||
                     '<FONT color=BLACK size=2>빠른 접수 부탁드립니다.</font><br>'||
                     --'</pre>' ||
                     '</b>' ||
                     '</html></body>'
                     ;

    --2. 이메일 본문 작성 및 수신자별 이메일 보내기.
    V_RCPT_NAME := NULL;
    V_RCPT_EMAIL := NULL;

    FOR C1 IN ( SELECT DISTINCT
                       PM.DISPLAY_NAME
                     , PM.NAME
                     , PM.EMAIL
                  FROM QM_TROUBLE_ISSUE QTI
                     , HRM_PERSON_MASTER PM
                 WHERE QTI.MEASURE_CHARGE_PRESON_ID                                                         = PM.PERSON_ID
                   AND QTI.SOB_ID                                                                           = P_SOB_ID
                   AND QTI.ORG_ID                                                                           = P_ORG_ID
                   AND (to_date(to_char(V_SYSDATE, 'yyyymmddhh24mi'),'yyyymmddhh24mi') - (1/24/60*10))     > QTI.MEASURE_REQ_DATE
                   AND QTI.STATUS_LCODE                                                                      = 'ENTERED'

                  )
        LOOP
          /*-- 보내는 사람 이름이 깨지는 현상 때문에 이메일주소로 적용 함 --
         V_RCPT_NAME   := V_RCPT_NAME || C1.NAME || '<' || C1.EMAIL || '>;';*/
         V_RCPT_NAME   := V_RCPT_NAME || C1.EMAIL || '<' || C1.EMAIL || '>;';
         V_RCPT_EMAIL  := V_RCPT_EMAIL || C1.EMAIL || ';';

        END LOOP C1;

        IF EAPP_MAIL_SEND.MAIL_SEND( P_PERSON_NAME_FR => 'Trouble'
                               , P_EMAIL_FR => V_SENDER_EMAIL
                               , P_PERSON_NAME_TO => V_RCPT_NAME
                               , P_EMAIL_TO => V_RCPT_EMAIL
                               , P_SUBJECT => V_SUBJECT
                               , P_CONTENT => V_CONTENT_TOP || V_CONTENT_TABLE || V_CONTENT_LOW
                               ) = FALSE THEN
      RAISE_APPLICATION_ERROR(-20001, 'E-MAIL Send Error : ' || SUBSTR(SQLERRM, 1, 150));
      RETURN;
    END IF;
END SEND_MAIL_TROUBLE_ISSUE;


END QM_NCR_ISSUE_G;
/
