CREATE OR REPLACE PACKAGE FI_SURTAX_CARD_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_SURTAX_CARD_G
Description  : �ΰ����Ű��� Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : �ΰ����Ű���
Program History :
    -.�ΰ���ġ�� ���� ��� �ڷ���� ���� �� �۾��Ѵ�. �۾������� ���� �������� �Ѵ�.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-10-05   Leem Dong Ern(�ӵ���)
*****************************************************************************/





--�Ű�������
--�޽��� : �����ڷḦ �����Ͻðڽ��ϱ�? �� ������ �ڷᰡ �ִ� ��� ���� �ڷᰡ �����ǰ� (��)�����˴ϴ�.
--FCM_10365, �ش� �Ű��Ⱓ�� �ڷ�� �����Ǿ� ������ �� �����ϴ�.
PROCEDURE CREATE_SURTAX_CARD(
      W_SOB_ID              IN  FI_SURTAX_CARD.SOB_ID%TYPE              --ȸ����̵�
    , W_ORG_ID              IN  FI_SURTAX_CARD.ORG_ID%TYPE              --����ξ��̵�
    --, W_OPERATING_UNIT_ID   IN  FI_SURTAX_CARD.OPERATING_UNIT_ID%TYPE   --�������̵�(��>110)    
    , W_TAX_CODE            IN  VARCHAR2                            --�������̵�(��>110)         
    , W_VAT_MNG_SERIAL      IN  FI_SURTAX_CARD.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű��Ⱓ���й�ȣ
    , W_SPEC_SERIAL         IN  FI_SURTAX_CARD.SPEC_SERIAL%TYPE         --�Ϸù�ȣ
    
    , W_VAT_LEVIER_GB       IN  FI_SURTAX_CARD.VAT_LEVIER_GB%TYPE       -- �����ڱ��� 
    , W_VAT_MAKE_GB         IN  FI_SURTAX_CARD.VAT_MAKE_GB%TYPE DEFAULT '01'    --�Ű�����(01 : ����Ű�, 01:�����Ű�)
    , W_MODIFY_DESC         IN  FI_SURTAX_CARD.MODIFY_DESC%TYPE                 -- �����Ű� ���� -- 
    
    , W_TITLE_1_1           IN  FI_SURTAX_CARD.TITLE_1_1%TYPE           --�Ű��Ⱓ_����
    , W_TITLE_1_2           IN  FI_SURTAX_CARD.TITLE_1_2%TYPE           --�Ű��Ⱓ_����     
    , W_CREATED_BY          IN  FI_SURTAX_CARD.CREATED_BY%TYPE          --������   
    , O_STATUS              OUT VARCHAR2
    , O_MESSAGE             OUT VARCHAR2
    , O_MODIFY_DEGREE       OUT NUMBER                                  -- �����Ű� ���� --
    , O_MODIFY_DESC         OUT VARCHAR2                                -- �����Ű� ���� --
);





--��ȸ �� ���
PROCEDURE LIST_SURTAX_CARD(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_SURTAX_CARD.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID              IN  FI_SURTAX_CARD.ORG_ID%TYPE  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2                            --�������̵�(��>110)    
    , W_VAT_MNG_SERIAL      IN  FI_SURTAX_CARD.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű��Ⱓ���й�ȣ
    , W_VAT_MAKE_GB         IN  FI_SURTAX_CARD.VAT_MAKE_GB%TYPE DEFAULT '01'    --�Ű�����(01 : ����Ű�)+
    , W_MODIFY_DEGREE       IN  FI_SURTAX_CARD.MODIFY_DEGREE%TYPE               -- �����Ű� ���� -- 
);



--�����Ű� ��½� ���� �Ű��� ��ȸ --
PROCEDURE PRINT_SURTAX_CARD_01
          ( P_CURSOR                  OUT TYPES.TCURSOR
          , W_SOB_ID              IN  FI_SURTAX_CARD.SOB_ID%TYPE  --ȸ����̵�
          , W_ORG_ID              IN  FI_SURTAX_CARD.ORG_ID%TYPE  --����ξ��̵�
          , W_TAX_CODE            IN  VARCHAR2                            --�������̵�(��>110)    
          , W_VAT_MNG_SERIAL      IN  FI_SURTAX_CARD.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű��Ⱓ���й�ȣ 
          );




--UPDATE
PROCEDURE UPDATE_SURTAX_CARD(
      P_SOB_ID              IN  FI_SURTAX_CARD.SOB_ID%TYPE  --ȸ����̵�
    , P_ORG_ID              IN  FI_SURTAX_CARD.ORG_ID%TYPE  --����ξ��̵�
    , P_TAX_CODE            IN  VARCHAR2                            --�������̵�(��>110)    
    , P_VAT_MNG_SERIAL      IN  FI_SURTAX_CARD.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű��Ⱓ���й�ȣ
    , P_SPEC_SERIAL         IN  FI_SURTAX_CARD.SPEC_SERIAL%TYPE         --�Ϸù�ȣ    
    , P_VAT_MAKE_GB	        IN	FI_SURTAX_CARD.VAT_MAKE_GB%TYPE	        --�Ű�����
    
    , P_GUBUN_1	            IN	FI_SURTAX_CARD.GUBUN_1%TYPE	    --�Ű�������_����
    , P_GUBUN_2	            IN	FI_SURTAX_CARD.GUBUN_2%TYPE	    --�Ű�������_Ȯ��
    , P_GUBUN_3	            IN	FI_SURTAX_CARD.GUBUN_3%TYPE	    --�Ű�������_�����İ���ǥ��
    , P_GUBUN_4	            IN	FI_SURTAX_CARD.GUBUN_4%TYPE	    --�Ű�������_������������ȯ��
    , P_TITLE_1_1	          IN	FI_SURTAX_CARD.TITLE_1_1%TYPE	--�Ű��Ⱓ_����
    , P_TITLE_1_2	          IN	FI_SURTAX_CARD.TITLE_1_2%TYPE	--�Ű��Ⱓ_����
    , P_TITLE_2	            IN	FI_SURTAX_CARD.TITLE_2%TYPE	    --��ȣ
    , P_TITLE_3	            IN	FI_SURTAX_CARD.TITLE_3%TYPE	    --����
    , P_TITLE_4	            IN	FI_SURTAX_CARD.TITLE_4%TYPE	    --����ڵ�Ϲ�ȣ
    , P_TITLE_5	            IN	FI_SURTAX_CARD.TITLE_5%TYPE	    --���ε�Ϲ�ȣ
    , P_TITLE_6	            IN	FI_SURTAX_CARD.TITLE_6%TYPE	    --�������ȭ
    , P_TITLE_7	            IN	FI_SURTAX_CARD.TITLE_7%TYPE	    --�ּ�����ȭ
    , P_TITLE_8	            IN	FI_SURTAX_CARD.TITLE_8%TYPE	    --�޴���ȭ
    , P_TITLE_9	            IN	FI_SURTAX_CARD.TITLE_9%TYPE	    --������ּ�
    , P_TITLE_10	          IN	FI_SURTAX_CARD.TITLE_10%TYPE	--���ڿ����ּ�
    , P_TITLE_11	          IN	FI_SURTAX_CARD.TITLE_11%TYPE	--����
    , P_TITLE_12	          IN	FI_SURTAX_CARD.TITLE_12%TYPE	--����
    , P_TITLE_13	          IN	FI_SURTAX_CARD.TITLE_13%TYPE	--�����ڵ�
    , P_TITLE_14	          IN	FI_SURTAX_CARD.TITLE_14%TYPE	--�ۼ�����
    , P_TITLE_15	          IN	FI_SURTAX_CARD.TITLE_15%TYPE	--�Ű���
    , P_TITLE_16	          IN	FI_SURTAX_CARD.TITLE_16%TYPE	--������
    , P_COL1_1	            IN	FI_SURTAX_CARD.COL1_1%TYPE	--����_���ݰ�꼭�߱޺�_�ݾ�
    , P_COL1_2	            IN	FI_SURTAX_CARD.COL1_2%TYPE	--����_���ݰ�꼭�߱޺�_����
    , P_COL2_1	            IN	FI_SURTAX_CARD.COL2_1%TYPE	--����_�����ڹ��༼�ݰ�꼭_�ݾ�
    , P_COL2_2	            IN	FI_SURTAX_CARD.COL2_2%TYPE	--����_�����ڹ��༼�ݰ�꼭_����
    , P_COL3_1	            IN	FI_SURTAX_CARD.COL3_1%TYPE	--����_�ſ�ī��_���ݿ����������_�ݾ�
    , P_COL3_2	            IN	FI_SURTAX_CARD.COL3_2%TYPE	--����_�ſ�ī��_���ݿ����������_����
    , P_COL4_1	            IN	FI_SURTAX_CARD.COL4_1%TYPE	--����_��Ÿ_�ݾ�
    , P_COL4_2	            IN	FI_SURTAX_CARD.COL4_2%TYPE	--����_��Ÿ_����
    , P_COL5_1	            IN	FI_SURTAX_CARD.COL5_1%TYPE	--������_���ݰ�꼭�߱޺�_�ݾ�
    , P_COL6_1	            IN	FI_SURTAX_CARD.COL6_1%TYPE	--������_��Ÿ_�ݾ�
    , P_COL7_1	            IN	FI_SURTAX_CARD.COL7_1%TYPE	--�����Ű�������_�ݾ�
    , P_COL7_2	            IN	FI_SURTAX_CARD.COL7_2%TYPE	--�����Ű�������_����
    , P_COL8_2	            IN	FI_SURTAX_CARD.COL8_2%TYPE	--��ռ��װ���_����
    , P_COL9_1	            IN	FI_SURTAX_CARD.COL9_1%TYPE	--�հ�_�ݾ�
    , P_COL9_2	            IN	FI_SURTAX_CARD.COL9_2%TYPE	--�հ�_����
    , P_COL10_1	            IN	FI_SURTAX_CARD.COL10_1%TYPE	--����_�Ϲݸ���_�ݾ�
    , P_COL10_2	            IN	FI_SURTAX_CARD.COL10_2%TYPE	--����_�Ϲݸ���_����
    , P_COL11_1	            IN	FI_SURTAX_CARD.COL11_1%TYPE	--����_�����ڻ����_�ݾ�
    , P_COL11_2	            IN	FI_SURTAX_CARD.COL11_2%TYPE	--����_�����ڻ����_����
    , P_COL12_1	            IN	FI_SURTAX_CARD.COL12_1%TYPE	--����_�����Ű�������_�ݾ�
    , P_COL12_2	            IN	FI_SURTAX_CARD.COL12_2%TYPE	--����_�����Ű�������_����
    , P_COL13_1	            IN	FI_SURTAX_CARD.COL13_1%TYPE	--����_�����ڹ��༼�ݰ�꼭_�ݾ�
    , P_COL13_2	            IN	FI_SURTAX_CARD.COL13_2%TYPE	--����_�����ڹ��༼�ݰ�꼭_����
    , P_COL14_1	            IN	FI_SURTAX_CARD.COL14_1%TYPE	--����_��Ÿ�������Լ���_�ݾ�
    , P_COL14_2	            IN	FI_SURTAX_CARD.COL14_2%TYPE	--����_��Ÿ�������Լ���_����
    , P_COL15_1	            IN	FI_SURTAX_CARD.COL15_1%TYPE	--����_�հ�_�ݾ�
    , P_COL15_2	            IN	FI_SURTAX_CARD.COL15_2%TYPE	--����_�հ�_����
    , P_COL16_1	            IN	FI_SURTAX_CARD.COL16_1%TYPE	--����_�����������Ҹ��Լ���_�ݾ�
    , P_COL16_2	            IN	FI_SURTAX_CARD.COL16_2%TYPE	--����_�����������Ҹ��Լ���_����
    , P_COL17_1	            IN	FI_SURTAX_CARD.COL17_1%TYPE	--����_������_�ݾ�
    , P_COL17_2	            IN	FI_SURTAX_CARD.COL17_2%TYPE	--����_������_����
    , P_COL_DA	            IN	FI_SURTAX_CARD.COL_DA%TYPE	--���μ���
    , P_COL18_2	            IN	FI_SURTAX_CARD.COL18_2%TYPE	--��Ÿ�氨��������
    , P_COL19_2	            IN	FI_SURTAX_CARD.COL19_2%TYPE	--�ſ�ī�������ǥ����������
    , P_COL20_2	            IN	FI_SURTAX_CARD.COL20_2%TYPE	--�氨����_�հ�
    , P_COL21_2	            IN	FI_SURTAX_CARD.COL21_2%TYPE	--�����Ű���ȯ�޼���
    , P_COL22_2	            IN	FI_SURTAX_CARD.COL22_2%TYPE	--������������
    , P_COL23_2	            IN	FI_SURTAX_CARD.COL23_2%TYPE	--������_������_����Ư��_�ⳳ�μ���
    , P_COL24_2	            IN	FI_SURTAX_CARD.COL24_2%TYPE	--���꼼�װ�
    , P_COL25	              IN	FI_SURTAX_CARD.COL25%TYPE	--�������Ͽ������Ҽ���
    , P_DEAL_BANK	          IN	FI_SURTAX_CARD.DEAL_BANK%TYPE	    --�ŷ�����
    , P_DEAL_BANK_CD	      IN	FI_SURTAX_CARD.DEAL_BANK_CD%TYPE	--�ŷ������ڵ�
    , P_DEAL_BRANCH	        IN	FI_SURTAX_CARD.DEAL_BRANCH%TYPE	    --�ŷ�����
    , P_DEAL_BRANCH_ID	    IN	FI_SURTAX_CARD.DEAL_BRANCH_ID%TYPE	--�ŷ������ڵ�
    , P_ACC_NO	            IN	FI_SURTAX_CARD.ACC_NO%TYPE	        --���¹�ȣ
    , P_CLOSURE_DATE	      IN	FI_SURTAX_CARD.CLOSURE_DATE%TYPE	--�����
    , P_CLOSURE_REASON	    IN	FI_SURTAX_CARD.CLOSURE_REASON%TYPE	--�������
    , P_COL26_1	            IN	FI_SURTAX_CARD.COL26_1%TYPE	--����ǥ��_����1
    , P_COL26_2	            IN	FI_SURTAX_CARD.COL26_2%TYPE	--����ǥ��_����1
    , P_COL26_3	            IN	FI_SURTAX_CARD.COL26_3%TYPE	--����ǥ��_�ݾ�1
    , P_COL27_1	            IN	FI_SURTAX_CARD.COL27_1%TYPE	--����ǥ��_����2
    , P_COL27_2	            IN	FI_SURTAX_CARD.COL27_2%TYPE	--����ǥ��_����2
    , P_COL27_3	            IN	FI_SURTAX_CARD.COL27_3%TYPE	--����ǥ��_�ݾ�2
    , P_COL28_1	            IN	FI_SURTAX_CARD.COL28_1%TYPE	--����ǥ��_����3
    , P_COL28_2	            IN	FI_SURTAX_CARD.COL28_2%TYPE	--����ǥ��_����3
    , P_COL28_3	            IN	FI_SURTAX_CARD.COL28_3%TYPE	--����ǥ��_�ݾ�3
    , P_COL29_1	            IN	FI_SURTAX_CARD.COL29_1%TYPE	--����ǥ��_����4
    , P_COL29_2	            IN	FI_SURTAX_CARD.COL29_2%TYPE	--����ǥ��_����4
    , P_COL29_3	            IN	FI_SURTAX_CARD.COL29_3%TYPE	--����ǥ��_�ݾ�4
    , P_COL30	              IN	FI_SURTAX_CARD.COL30%TYPE	--����ǥ��_�հ�
    , P_COL31_1	            IN	FI_SURTAX_CARD.COL31_1%TYPE	--�����Ű�_����_����_���ݰ�꼭_�ݾ�
    , P_COL31_2	            IN	FI_SURTAX_CARD.COL31_2%TYPE	--�����Ű�_����_����_���ݰ�꼭_����
    , P_COL32_1	            IN	FI_SURTAX_CARD.COL32_1%TYPE	--�����Ű�_����_����_��Ÿ_�ݾ�
    , P_COL32_2	            IN	FI_SURTAX_CARD.COL32_2%TYPE	--�����Ű�_����_����_��Ÿ_����
    , P_COL33_1	            IN	FI_SURTAX_CARD.COL33_1%TYPE	--�����Ű�_����_������_���ݰ�꼭
    , P_COL34_1	            IN	FI_SURTAX_CARD.COL34_1%TYPE	--�����Ű�_����_������_��Ÿ
    , P_COL35_1	            IN	FI_SURTAX_CARD.COL35_1%TYPE	--�����Ű�_����_�հ�_�ݾ�
    , P_COL35_2	            IN	FI_SURTAX_CARD.COL35_2%TYPE	--�����Ű�_����_�հ�_����
    , P_COL36_1	            IN	FI_SURTAX_CARD.COL36_1%TYPE	--�����Ű�_����_���ݰ�꼭_�ݾ�
    , P_COL36_2	            IN	FI_SURTAX_CARD.COL36_2%TYPE	--�����Ű�_����_���ݰ�꼭_����
    , P_COL37_1	            IN	FI_SURTAX_CARD.COL37_1%TYPE	--�����Ű�_����_��Ÿ�������Լ���_�ݾ�
    , P_COL37_2	            IN	FI_SURTAX_CARD.COL37_2%TYPE	--�����Ű�_����_��Ÿ�������Լ���_����
    , P_COL38_1	            IN	FI_SURTAX_CARD.COL38_1%TYPE	--�����Ű�_����_�հ�_�ݾ�
    , P_COL38_2	            IN	FI_SURTAX_CARD.COL38_2%TYPE	--�����Ű�_����_�հ�_����
    , P_COL39_1	            IN	FI_SURTAX_CARD.COL39_1%TYPE	--��Ÿ����_�ſ�ī��_�Ϲݸ���_�ݾ�
    , P_COL39_2	            IN	FI_SURTAX_CARD.COL39_2%TYPE	--��Ÿ����_�ſ�ī��_�Ϲݸ���_����
    , P_COL40_1	            IN	FI_SURTAX_CARD.COL40_1%TYPE	--��Ÿ����_�ſ�ī��_�����ڻ����_�ݾ�
    , P_COL40_2	            IN	FI_SURTAX_CARD.COL40_2%TYPE	--��Ÿ����_�ſ�ī��_�����ڻ����_����
    , P_COL41_1	            IN	FI_SURTAX_CARD.COL41_1%TYPE	--��Ÿ����_�������Լ���_�ݾ�
    , P_COL41_2	            IN	FI_SURTAX_CARD.COL41_2%TYPE	--��Ÿ����_�������Լ���_����
    , P_COL42_1	            IN	FI_SURTAX_CARD.COL42_1%TYPE	--��Ÿ����_��Ȱ�����ڿ�����Լ���_�ݾ�
    , P_COL42_2	            IN	FI_SURTAX_CARD.COL42_2%TYPE	--��Ÿ����_��Ȱ�����ڿ�����Լ���_����
    , P_COL43_1	            IN	FI_SURTAX_CARD.COL43_1%TYPE	--��Ÿ����_�����������Լ���_�ݾ�
    , P_COL43_2	            IN	FI_SURTAX_CARD.COL43_2%TYPE	--��Ÿ����_�����������Լ���_����
    , P_COL44_2	            IN	FI_SURTAX_CARD.COL44_2%TYPE	--��Ÿ����_���������ȯ���Լ���_����
    , P_COL45_2	            IN	FI_SURTAX_CARD.COL45_2%TYPE	--��Ÿ����_������Լ���_����
    , P_COL46_2	            IN	FI_SURTAX_CARD.COL46_2%TYPE	--��Ÿ����_������ռ���_����
    , P_COL47_1	            IN	FI_SURTAX_CARD.COL47_1%TYPE	--��Ÿ����_�հ�_�ݾ�
    , P_COL47_2	            IN	FI_SURTAX_CARD.COL47_2%TYPE	--��Ÿ����_���_����
    , P_COL48_1	            IN	FI_SURTAX_CARD.COL48_1%TYPE	--�����������Ҹ��Լ���_������������_�ݾ�
    , P_COL48_2	            IN	FI_SURTAX_CARD.COL48_2%TYPE	--�����������Ҹ��Լ���_������������_����
    , P_COL49_1	            IN	FI_SURTAX_CARD.COL49_1%TYPE	--�����������Ҹ��Լ���_������Լ��׸鼼_�ݾ�
    , P_COL49_2	            IN	FI_SURTAX_CARD.COL49_2%TYPE	--�����������Ҹ��Լ���_������Լ��׸鼼_����
    , P_COL50_1	            IN	FI_SURTAX_CARD.COL50_1%TYPE	--�����������Ҹ��Լ���_���ó�й�������_�ݾ�
    , P_COL50_2	            IN	FI_SURTAX_CARD.COL50_2%TYPE	--�����������Ҹ��Լ���_���ó�й�������_����
    , P_COL51_1	            IN	FI_SURTAX_CARD.COL51_1%TYPE	--�����������Ҹ��Լ���_�հ�_�ݾ�
    , P_COL51_2	            IN	FI_SURTAX_CARD.COL51_2%TYPE	--�����������Ҹ��Լ���_�հ�_����
    , P_COL52_2	            IN	FI_SURTAX_CARD.COL52_2%TYPE	--��Ź�氨��������_���ڽŰ����װ���_����
    , P_COL53_2	            IN	FI_SURTAX_CARD.COL53_2%TYPE	--��Ÿ�氨��������_���ڼ��ݰ�꼭�߱޼��װ���_����
    , P_COL54_2	            IN	FI_SURTAX_CARD.COL54_2%TYPE	--��Ÿ�氨��������_�ýÿ�ۻ���ڰ氨����_����
    , P_COL55_2	            IN	FI_SURTAX_CARD.COL55_2%TYPE	--��Ÿ�氨��������_���ݿ���������ڼ��װ���_����
    , P_COL56_2	            IN	FI_SURTAX_CARD.COL56_2%TYPE	--��Ÿ�氨��������_��Ÿ_����
    , P_COL57_2	            IN	FI_SURTAX_CARD.COL57_2%TYPE	--��Ÿ�氨��������_�հ�_����
    , P_COL58_1	            IN	FI_SURTAX_CARD.COL58_1%TYPE	--���꼼����_����ڹ̵�ϵ�_�ݾ�
    , P_COL58_2	            IN	FI_SURTAX_CARD.COL58_2%TYPE	--���꼼����_����ڹ̵�ϵ�_����
    , P_COL59_1 	          IN	FI_SURTAX_CARD.COL59_1%TYPE	--���꼼����_�����߱޵�_�ݾ�
    , P_COL59_2	            IN	FI_SURTAX_CARD.COL59_2%TYPE	--���꼼����_�����߱޵�_����
    , P_COL60_1	            IN	FI_SURTAX_CARD.COL60_1%TYPE	--���꼼����_�̹߱޵�_�ݾ�
    , P_COL60_2	            IN	FI_SURTAX_CARD.COL60_2%TYPE	--���꼼����_�̹߱޵�_����
    , P_COL61_1	            IN	FI_SURTAX_CARD.COL61_1%TYPE	--���꼼����_������15������_�ݾ�
    , P_COL61_2	            IN	FI_SURTAX_CARD.COL61_2%TYPE	--���꼼����_������15������_����
    , P_COL62_1	            IN	FI_SURTAX_CARD.COL62_1%TYPE	--���꼼����_�����Ⱓ������15������_�ݾ�
    , P_COL62_2	            IN	FI_SURTAX_CARD.COL62_2%TYPE	--���꼼����_�����Ⱓ������15������_����
    , P_COL63_1	            IN	FI_SURTAX_CARD.COL63_1%TYPE	--���꼼����_���ݰ�꼭�հ�ǥ����Ҽ���_�ݾ�
    , P_COL63_2	            IN	FI_SURTAX_CARD.COL63_2%TYPE	--���꼼����_���ݰ�꼭�հ�ǥ����Ҽ���_����
    , P_COL64_1	            IN	FI_SURTAX_CARD.COL64_1%TYPE	--���꼼����_�Ű��Ҽ���_�ݾ�
    , P_COL64_2	            IN	FI_SURTAX_CARD.COL64_2%TYPE	--���꼼����_�Ű��Ҽ���_����
    , P_COL65_1	            IN	FI_SURTAX_CARD.COL65_1%TYPE	--���꼼����_���κҼ���_�ݾ�
    , P_COL65_2	            IN	FI_SURTAX_CARD.COL65_2%TYPE	--���꼼����_���κҼ���_����
    , P_COL66_1	            IN	FI_SURTAX_CARD.COL66_1%TYPE	--���꼼����_����������ǥ�ؽŰ��Ҽ���_�ݾ�
    , P_COL66_2	            IN	FI_SURTAX_CARD.COL66_2%TYPE	--���꼼����_����������ǥ�ؽŰ��Ҽ���_����
    , P_COL67_1	            IN	FI_SURTAX_CARD.COL67_1%TYPE	--���꼼����_���ݸ���������������_�ݾ�
    , P_COL67_2	            IN	FI_SURTAX_CARD.COL67_2%TYPE	--���꼼����_���ݸ���������������_����
    , P_COL68_2	            IN	FI_SURTAX_CARD.COL68_2%TYPE	--���꼼����_�հ�_����
    , P_COL69_1	            IN	FI_SURTAX_CARD.COL69_1%TYPE	--�鼼������Աݾ�_����1
    , P_COL69_2	            IN	FI_SURTAX_CARD.COL69_2%TYPE	--�鼼������Աݾ�_����1
    , P_COL69_3	            IN	FI_SURTAX_CARD.COL69_3%TYPE	--�鼼������Աݾ�_�ݾ�1
    , P_COL70_1	            IN	FI_SURTAX_CARD.COL70_1%TYPE	--�鼼������Աݾ�_����2
    , P_COL70_2	            IN	FI_SURTAX_CARD.COL70_2%TYPE	--�鼼������Աݾ�_����2
    , P_COL70_3	            IN	FI_SURTAX_CARD.COL70_3%TYPE	--�鼼������Աݾ�_�ݾ�2
    , P_COL71_1	            IN	FI_SURTAX_CARD.COL71_1%TYPE	--�鼼������Աݾ�_����3
    , P_COL71_2	            IN	FI_SURTAX_CARD.COL71_2%TYPE	--�鼼������Աݾ�_����3
    , P_COL71_3	            IN	FI_SURTAX_CARD.COL71_3%TYPE	--�鼼������Աݾ�_�ݾ�3
    , P_COL72	              IN	FI_SURTAX_CARD.COL72%TYPE	--�鼼������Աݾ�_�հ�
    , P_COL73	              IN	FI_SURTAX_CARD.COL73%TYPE	--��꼭�߱ޱݾ�
    , P_COL74	              IN	FI_SURTAX_CARD.COL74%TYPE	--��꼭����ݾ�
    
    , P_R_ORIGIN_PLACE_VAT      IN  FI_SURTAX_CARD.R_ORIGIN_PLACE_VAT%TYPE  -- ������Ȯ�μ� �߱ް�������.
    , P_A_TAX_RECEIVE_DELAY_AMT IN FI_SURTAX_CARD.A_TAX_RECEIVE_DELAY_AMT%TYPE  -- ���ݰ�꼭��������ݾ�.
    , P_A_TAX_RECEIVE_DELAY_VAT IN FI_SURTAX_CARD.A_TAX_RECEIVE_DELAY_VAT%TYPE  -- ���ݰ�꼭�������뼼��.
    
    , P_LAST_UPDATED_BY     IN  FI_SURTAX_CARD.LAST_UPDATED_BY%TYPE     --������
    -- 2013�� 1�� ���� �߰� -- 
    , P_A_TAX_INV_SUM_BAD_AMT_1   IN FI_SURTAX_CARD.A_TAX_INV_SUM_BAD_AMT_1%TYPE
    , P_A_TAX_INV_SUM_BAD_VAT_1   IN FI_SURTAX_CARD.A_TAX_INV_SUM_BAD_VAT_1%TYPE
    , P_A_REPORT_BAD_AMT_1        IN FI_SURTAX_CARD.A_REPORT_BAD_AMT_1%TYPE
    , P_A_REPORT_BAD_VAT_1        IN FI_SURTAX_CARD.A_REPORT_BAD_VAT_1%TYPE
    , P_A_REPORT_BAD_AMT_2        IN FI_SURTAX_CARD.A_REPORT_BAD_AMT_2%TYPE
    , P_A_REPORT_BAD_VAT_2        IN FI_SURTAX_CARD.A_REPORT_BAD_VAT_2%TYPE
    , P_A_REPORT_BAD_AMT_3        IN FI_SURTAX_CARD.A_REPORT_BAD_AMT_3%TYPE
    , P_A_REPORT_BAD_VAT_3        IN FI_SURTAX_CARD.A_REPORT_BAD_VAT_3%TYPE
    , P_A_REPORT_BAD_AMT_4        IN FI_SURTAX_CARD.A_REPORT_BAD_AMT_4%TYPE
    , P_A_REPORT_BAD_VAT_4        IN FI_SURTAX_CARD.A_REPORT_BAD_VAT_4%TYPE
    , P_A_REALTY_LEASE_UNREPORT_AMT  IN FI_SURTAX_CARD.A_REALTY_LEASE_UNREPORT_AMT%TYPE
    , P_A_REALTY_LEASE_UNREPORT_VAT  IN FI_SURTAX_CARD.A_REALTY_LEASE_UNREPORT_VAT%TYPE
    -- 2014.1�� ���� �߰� 
    , P_COL26_4                    IN FI_SURTAX_CARD.COL26_4%TYPE  
    , P_COL27_4                    IN FI_SURTAX_CARD.COL27_4%TYPE
    , P_COL28_4                    IN FI_SURTAX_CARD.COL28_4%TYPE
    , P_COL29_4                    IN FI_SURTAX_CARD.COL29_4%TYPE                 
    , P_PROXY_PAY_TAX_VAT          IN FI_SURTAX_CARD.PROXY_PAY_TAX_VAT %TYPE
    , P_SPECIAL_PAY_TAX_VAT        IN FI_SURTAX_CARD.SPECIAL_PAY_TAX_VAT %TYPE
    , P_E_FORE_TOUR_REFUND_VAT     IN FI_SURTAX_CARD.E_FORE_TOUR_REFUND_VAT %TYPE
    , P_A_MISS_DEAL_ACCOUNT_AMT    IN FI_SURTAX_CARD.A_MISS_DEAL_ACCOUNT_AMT %TYPE
    , P_A_MISS_DEAL_ACCOUNT_VAT    IN FI_SURTAX_CARD.A_MISS_DEAL_ACCOUNT_VAT %TYPE
    , P_A_DELAY_PAYMENT_AMT        IN FI_SURTAX_CARD.A_DELAY_PAYMENT_AMT %TYPE
    , P_A_DELAY_PAYMENT_VAT        IN FI_SURTAX_CARD.A_DELAY_PAYMENT_VAT %TYPE
);







--�ŷ����� POPUP
PROCEDURE POPUP_BANK(
      P_CURSOR  OUT TYPES.TCURSOR
    , W_SOB_ID  IN  FI_BANK.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID  IN  FI_BANK.ORG_ID%TYPE  --����ξ��̵�
);






--�ŷ��������� POPUP
PROCEDURE POPUP_BANK_BRANCH(
      P_CURSOR      OUT TYPES.TCURSOR
    , W_SOB_ID      IN  FI_BANK.SOB_ID%TYPE     --ȸ����̵�
    , W_ORG_ID      IN  FI_BANK.ORG_ID%TYPE     --����ξ��̵�
    , W_BANK_CODE   IN  FI_BANK.BANK_CODE%TYPE  --��������ڵ�
);




--���¹�ȣ POPUP
PROCEDURE POPUP_ACCOUNT_NO(
      P_CURSOR      OUT TYPES.TCURSOR
    , W_SOB_ID      IN  FI_BANK.SOB_ID%TYPE       --ȸ����̵�
    , W_ORG_ID      IN  FI_BANK.ORG_ID%TYPE       --����ξ��̵�
    , W_BANK_CODE   IN  FI_BANK.BANK_CODE%TYPE    --��������ڵ�
    , W_BANK_ID     IN  FI_BANK.BANK_ID%TYPE      --����������̵�
);





   PROCEDURE ROUND_TAX
           ( O_NUMBER  OUT  NUMBER
           , P_NUMBER  IN   NUMBER
           );


-- ���� �Ű� ���� -- 
PROCEDURE LU_SELECT_MODIFY_DEGREE
          ( P_CURSOR1             OUT TYPES.TCURSOR1
          , W_SOB_ID              IN  FI_SURTAX_CARD.SOB_ID%TYPE  --ȸ����̵�
          , W_ORG_ID              IN  FI_SURTAX_CARD.ORG_ID%TYPE  --����ξ��̵�
          , W_TAX_CODE            IN  VARCHAR2                            --�������̵�(��>110)    
          , W_VAT_MNG_SERIAL      IN  FI_SURTAX_CARD.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű��Ⱓ���й�ȣ
          , W_VAT_MAKE_GB         IN  FI_SURTAX_CARD.VAT_MAKE_GB%TYPE DEFAULT '01'    --�Ű�����(01 : ����Ű�)
          );

END FI_SURTAX_CARD_G;
/
CREATE OR REPLACE PACKAGE BODY FI_SURTAX_CARD_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_SURTAX_CARD_G
Description  : �ΰ����Ű��� Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : �ΰ����Ű���
Program History :
    -.�ΰ���ġ�� ���� ��� �ڷ���� ���� �� �۾��Ѵ�. �۾������� ���� �������� �Ѵ�.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-10-05   Leem Dong Ern(�ӵ���)
*****************************************************************************/

 




--�Ű�������
--�޽��� : �����ڷḦ �����Ͻðڽ��ϱ�? �� ������ �ڷᰡ �ִ� ��� ���� �ڷᰡ �����ǰ� (��)�����˴ϴ�.
--FCM_10365, �ش� �Ű��Ⱓ�� �ڷ�� �����Ǿ� ������ �� �����ϴ�.
PROCEDURE CREATE_SURTAX_CARD(
      W_SOB_ID              IN  FI_SURTAX_CARD.SOB_ID%TYPE              --ȸ����̵�
    , W_ORG_ID              IN  FI_SURTAX_CARD.ORG_ID%TYPE              --����ξ��̵�
    --, W_OPERATING_UNIT_ID   IN  FI_SURTAX_CARD.OPERATING_UNIT_ID%TYPE   --�������̵�(��>110)    
    , W_TAX_CODE            IN  VARCHAR2                            --�������̵�(��>110)    
    , W_VAT_MNG_SERIAL      IN  FI_SURTAX_CARD.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű��Ⱓ���й�ȣ
    , W_SPEC_SERIAL         IN  FI_SURTAX_CARD.SPEC_SERIAL%TYPE         --�Ϸù�ȣ; �����Ѵ�. ���α׷��� �̹� �������¶� �������� �ʾ��� ���̴�.
    
    , W_VAT_LEVIER_GB       IN  FI_SURTAX_CARD.VAT_LEVIER_GB%TYPE       -- �����ڱ��� 
    , W_VAT_MAKE_GB         IN  FI_SURTAX_CARD.VAT_MAKE_GB%TYPE DEFAULT '01'    --�Ű�����(01 : ����Ű�, 01:�����Ű�)
    , W_MODIFY_DESC         IN  FI_SURTAX_CARD.MODIFY_DESC%TYPE                 -- �����Ű� ���� --    
    
    , W_TITLE_1_1           IN  FI_SURTAX_CARD.TITLE_1_1%TYPE           --�Ű��Ⱓ_����
    , W_TITLE_1_2           IN  FI_SURTAX_CARD.TITLE_1_2%TYPE           --�Ű��Ⱓ_����     
    , W_CREATED_BY          IN  FI_SURTAX_CARD.CREATED_BY%TYPE          --������     
    , O_STATUS              OUT VARCHAR2
    , O_MESSAGE             OUT VARCHAR2
    , O_MODIFY_DEGREE       OUT NUMBER                                  -- �����Ű� ���� --
    , O_MODIFY_DESC         OUT VARCHAR2                                -- �����Ű� ���� --
)

AS

t_CLOSING_YN    FI_VAT_REPORT_MNG.CLOSING_YN%TYPE;  --��������
t_SPEC_SERIAL   FI_SURTAX_CARD.SPEC_SERIAL%TYPE;    --�Ϸù�ȣ

V_SYSDATE       DATE := GET_LOCAL_DATE(W_SOB_ID);

t_RECORD_COUNT  NUMBER;                             -- ī��Ʈ  

t_COL1_1    FI_SURTAX_CARD.COL1_1%TYPE;     --����_���ݰ�꼭�߱޺�_�ݾ�
t_COL1_2    FI_SURTAX_CARD.COL1_2%TYPE;     --����_���ݰ�꼭�߱޺�_����
t_COL4_1    FI_SURTAX_CARD.COL4_1%TYPE;     --����_��Ÿ_�ݾ�
t_COL4_2    FI_SURTAX_CARD.COL4_2%TYPE;     --����_��Ÿ_����
t_COL5_1    FI_SURTAX_CARD.COL5_1%TYPE;     --������_���ݰ�꼭�߱޺�_�ݾ�
t_COL6_1    FI_SURTAX_CARD.COL6_1%TYPE;     --������_��Ÿ_�ݾ�
t_COL10_1   FI_SURTAX_CARD.COL10_1%TYPE;    --����_�Ϲݸ���_�ݾ�
t_COL10_2   FI_SURTAX_CARD.COL10_2%TYPE;    --����_�Ϲݸ���_����
t_COL11_1   FI_SURTAX_CARD.COL11_1%TYPE;    --����_�����ڻ����_�ݾ�
t_COL11_2   FI_SURTAX_CARD.COL11_2%TYPE;    --����_�����ڻ����_����

t_COL14_1   FI_SURTAX_CARD.COL14_1%TYPE;    --����_��Ÿ�������Լ���_�ݾ�
t_COL14_2   FI_SURTAX_CARD.COL14_2%TYPE;    --����_��Ÿ�������Լ���_����
t_COL39_1   FI_SURTAX_CARD.COL39_1%TYPE;    --��Ÿ����_�ſ�ī��_�Ϲݸ���_�ݾ�
t_COL39_2   FI_SURTAX_CARD.COL39_2%TYPE;    --��Ÿ����_�ſ�ī��_�Ϲݸ���_����

t_COL40_1   FI_SURTAX_CARD.COL40_1%TYPE;    --��Ÿ����_�ſ�ī��_�����ڻ����_�ݾ�
t_COL40_2   FI_SURTAX_CARD.COL40_2%TYPE;    --��Ÿ����_�ſ�ī��_�����ڻ����_����

t_COL42_1   FI_SURTAX_CARD.COL42_1%TYPE;    --��Ÿ����_��Ȱ��_�ݾ�
t_COL42_2   FI_SURTAX_CARD.COL42_2%TYPE;    --��Ÿ����_�ſ�ī��_�����ڻ����_����
             
t_COL47_1   FI_SURTAX_CARD.COL47_1%TYPE;    --��Ÿ����_�հ�_�ݾ�
t_COL47_2   FI_SURTAX_CARD.COL47_2%TYPE;    --��Ÿ����_���_����

t_COL15_1   FI_SURTAX_CARD.COL15_1%TYPE;    --����_�հ�_�ݾ�
t_COL15_2   FI_SURTAX_CARD.COL15_2%TYPE;    --����_�հ�_����

t_COL16_1   FI_SURTAX_CARD.COL16_1%TYPE;    --����_�����������Ҹ��Լ���_�ݾ�
t_COL16_2   FI_SURTAX_CARD.COL16_2%TYPE;    --����_�����������Ҹ��Լ���_����
t_COL48_1   FI_SURTAX_CARD.COL48_1%TYPE;    --�����������Ҹ��Լ���_������������_�ݾ�
t_COL48_2   FI_SURTAX_CARD.COL48_2%TYPE;    --�����������Ҹ��Լ���_������������_����
t_COL49_1   FI_SURTAX_CARD.COL49_1%TYPE;    --�����������Ҹ��Լ���_������������_������Լ��� �鼼����� �ݾ�
t_COL49_2   FI_SURTAX_CARD.COL49_2%TYPE;    --�����������Ҹ��Լ���_������������_������Լ��� �鼼����� ����
t_COL51_1   FI_SURTAX_CARD.COL51_1%TYPE;    --�����������Ҹ��Լ���_�հ�_�ݾ�
t_COL51_2   FI_SURTAX_CARD.COL51_2%TYPE;    --�����������Ҹ��Լ���_�հ�_����

t_COL17_1   FI_SURTAX_CARD.COL17_1%TYPE;    --����_������_�ݾ�
t_COL17_2   FI_SURTAX_CARD.COL17_2%TYPE;    --����_������_����

t_COL18_2   FI_SURTAX_CARD.COL18_2%type;    -- 18.�氨��������-��Ÿ�氨/��������;
t_COL20_2   FI_SURTAX_CARD.COL20_2%TYPE;    -- 20. �氨����_�հ� 
t_COL53_2   FI_SURTAX_CARD.COL53_2%TYPE;    -- 53. ��Ÿ�氨��������_���ڼ��ݰ�꼭�߱޼��װ���_���� 
t_COL57_2   FI_SURTAX_CARD.COL57_2%TYPE;    -- 57. ��Ÿ�氨��������_�հ�_���� 

t_COL29_3   FI_SURTAX_CARD.COL29_3%TYPE;    --����ǥ��_�ݾ�4

t_COL73     FI_SURTAX_CARD.COL73%TYPE;    --��꼭�߱ޱݾ�
t_COL74     FI_SURTAX_CARD.COL74%TYPE;    --��꼭����ݾ�

BEGIN

    O_STATUS := 'F';
            
    --�ش� �Ű��Ⱓ�� �������θ� �ľ��Ѵ�.
    BEGIN
      SELECT CLOSING_YN
      INTO t_CLOSING_YN
      FROM FI_VAT_REPORT_MNG
      WHERE   SOB_ID  = W_SOB_ID  --ȸ����̵�
          AND ORG_ID  = W_ORG_ID  --����ξ��̵�
          AND TAX_CODE = W_TAX_CODE                   --�������̵�
          AND VAT_MNG_SERIAL    = W_VAT_MNG_SERIAL    --�ΰ����Ű��Ⱓ���й�ȣ
      ; 
    EXCEPTION WHEN OTHERS THEN
      t_CLOSING_YN := 'Y';   
    END;
    --FCM_10365, �ش� �Ű��Ⱓ�� �ڷ�� �����Ǿ� ������ �� �����ϴ�.
    IF t_CLOSING_YN = 'Y' THEN
        O_STATUS := 'F';
        O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10365', NULL);
        RETURN;
    END IF;
    
    
    -- �Ű��� ���� -- 
    IF W_VAT_MAKE_GB = '01' THEN
      -- ����Ű� --
      O_MODIFY_DEGREE := NULL;
      O_MODIFY_DESC := NULL;
      
      --������ �����ϴ� �ڷᰡ ���� ��� ��� �����Ѵ�.
      DELETE FI_SURTAX_CARD
      WHERE   SOB_ID  = W_SOB_ID  --ȸ����̵�
          AND ORG_ID  = W_ORG_ID  --����ξ��̵�
          AND TAX_CODE   = W_TAX_CODE   --�������̵�
          AND VAT_MNG_SERIAL   = W_VAT_MNG_SERIAL      --�ΰ����Ű��Ⱓ���й�ȣ
          --AND SPEC_SERIAL         = W_SPEC_SERIAL         --�Ϸù�ȣ
          AND VAT_MAKE_GB  = W_VAT_MAKE_GB --�Ű�����(01 : ����Ű�)
      ;
    ELSE
      -- �����Ű� -- 
      BEGIN
        SELECT NVL(MAX(SC.MODIFY_DEGREE), 0) + 1 AS NEXT_MODIFY_DEGREE
          INTO O_MODIFY_DEGREE
          FROM FI_SURTAX_CARD SC
         WHERE SOB_ID  = W_SOB_ID  --ȸ����̵�
           AND ORG_ID  = W_ORG_ID  --����ξ��̵�
           AND TAX_CODE   = W_TAX_CODE   --�������̵�
           AND VAT_MNG_SERIAL   = W_VAT_MNG_SERIAL      --�ΰ����Ű��Ⱓ���й�ȣ
           AND VAT_MAKE_GB  = W_VAT_MAKE_GB --�Ű�����(01 : ����Ű�, 02:�����Ű�)
           AND CLOSED_FLAG  = 'Y'           -- ����ó���� ������ ���� -- 
        ;
      EXCEPTION WHEN OTHERS THEN
        O_MODIFY_DEGREE := 1;
      END;
      O_MODIFY_DESC := W_MODIFY_DESC;
      
      --������ �����ϴ� �ڷᰡ ���� ��� ��� �����Ѵ�.
      DELETE FI_SURTAX_CARD
      WHERE   SOB_ID  = W_SOB_ID  --ȸ����̵�
          AND ORG_ID  = W_ORG_ID  --����ξ��̵�
          AND TAX_CODE   = W_TAX_CODE   --�������̵�
          AND VAT_MNG_SERIAL   = W_VAT_MNG_SERIAL      --�ΰ����Ű��Ⱓ���й�ȣ
          --AND SPEC_SERIAL         = W_SPEC_SERIAL         --�Ϸù�ȣ
          AND VAT_MAKE_GB  = W_VAT_MAKE_GB --�Ű�����(01 : ����Ű�)
          AND MODIFY_DEGREE = O_MODIFY_DEGREE
      ;
    END IF;
       
    
    IF W_VAT_LEVIER_GB = '2' THEN
    -- �Ѱ����λ����(��)�� ��� 1���� �����͸� �����ؾ� ��
    -- ���� ������ ����� ERROR 
      t_RECORD_COUNT := 0;
      
      BEGIN
        SELECT COUNT(SC.TAX_CODE) AS RECORD_COUNT
          INTO t_RECORD_COUNT
          FROM FI_SURTAX_CARD    SC
             , FI_VAT_REPORT_MNG VRM
         WHERE  SC.TAX_CODE             = VRM.TAX_CODE
            AND SC.VAT_MNG_SERIAL       = VRM.VAT_MNG_SERIAL
            AND SC.SOB_ID               = VRM.SOB_ID
            AND SC.ORG_ID               = VRM.ORG_ID
            AND SC.SOB_ID               = W_SOB_ID  --ȸ����̵�
            AND SC.ORG_ID               = W_ORG_ID  --����ξ��̵�    
            AND SC.VAT_MAKE_GB          = W_VAT_MAKE_GB --�Ű�����(01 : ����Ű�)
            AND SC.VAT_LEVIER_GB        = '2'          -- �Ѱ����λ����(��)����� 
            AND SC.LAST_FLAG            = 'Y'
            AND EXISTS
                  (SELECT 'X'
                     FROM FI_VAT_REPORT_MNG RM
                    WHERE RM.SOB_ID            = VRM.SOB_ID
                      AND RM.ORG_ID            = VRM.ORG_ID
                      AND RM.FY                = VRM.FY
                      AND RM.VAT_REPORT_TURN   = VRM.VAT_REPORT_TURN
                      AND RM.VAT_REPORT_GB     = VRM.VAT_REPORT_GB
                      AND RM.TAX_CODE          = W_TAX_CODE
                      AND RM.VAT_MNG_SERIAL    = W_VAT_MNG_SERIAL
                  )
        ;  
      EXCEPTION WHEN OTHERS THEN
        t_RECORD_COUNT := 0;
      END;
      IF t_RECORD_COUNT > 0 THEN
        O_STATUS := 'F';
        O_MESSAGE := '�̹� [�Ѱ����λ������ �������]�� �����Ͱ� �����մϴ�. �ߺ� ������ �� �����ϴ�.';
        RETURN;
      END IF;
    END IF;
        
    
    -- �ش� �Ű��Ⱓ�� ���� ���� �Ű��� �������� UPDATE -- 
    BEGIN
      UPDATE FI_SURTAX_CARD SC
         SET SC.LAST_FLAG       = 'N'
      WHERE   SOB_ID  = W_SOB_ID  --ȸ����̵�
          AND ORG_ID  = W_ORG_ID  --����ξ��̵�
          AND TAX_CODE   = W_TAX_CODE   --�������̵�
          AND VAT_MNG_SERIAL   = W_VAT_MNG_SERIAL      --�ΰ����Ű��Ⱓ���й�ȣ
          --AND SPEC_SERIAL         = W_SPEC_SERIAL         --�Ϸù�ȣ
          AND VAT_MAKE_GB  = W_VAT_MAKE_GB --�Ű�����(01 : ����Ű�)
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
    
    -- �Ű� �Ϸù�ȣ -- 
    BEGIN
      SELECT NVL(MAX(SPEC_SERIAL), 0) + 1 INTO t_SPEC_SERIAL FROM FI_SURTAX_CARD;
    EXCEPTION WHEN OTHERS THEN
      t_SPEC_SERIAL := 1;
    END;

    --�ϴ�, �����ڷḦ ���� �� �� �ϴܿ��� ���� ������ Į���鿡 ���� UPDATE�Ѵ�.
    INSERT INTO FI_SURTAX_CARD(
          SOB_ID	        --ȸ����̵�
        , ORG_ID	        --����ξ��̵�        
        , TAX_CODE	      --�������̵�
        , VAT_MNG_SERIAL	--�ΰ����Ű��Ⱓ���й�ȣ
        , SPEC_SERIAL	    --�Ϸù�ȣ
        
        , VAT_MAKE_GB   --�Ű�����(01 : ����Ű�)
        , MODIFY_DEGREE -- �����Ű� ���� 
        , MODIFY_DESC   -- �����Ű� ����  
        
        , TITLE_1_1   --�Ű��Ⱓ_����
        , TITLE_1_2   --�Ű��Ⱓ_����
        , TITLE_2       --��ȣ(���θ�)
        , TITLE_3       --����(��ǥ��)
        , TITLE_4       --����ڵ�Ϲ�ȣ
        , TITLE_5       --�ֹ�(����)��Ϲ�ȣ
        , TITLE_6       --�������ȭ
        , TITLE_7       --�ּ�����ȭ
        , TITLE_9       --������ּ�
        , TITLE_11      --����
        , TITLE_12      --����
        , TITLE_13      --�����ڵ�    
        , TITLE_14      --�ۼ�����
        , TITLE_15      --�Ű���      
        , TITLE_16      --������

        , COL26_1 --����ǥ��_����1
        , COL26_2 --����ǥ��_����1        
        , COL69_1 --�鼼������Աݾ�_����1
        , COL69_2 --�鼼������Աݾ�_����1
        , COL71_1 --�鼼������Աݾ�_����3
        , COL71_2 --�鼼������Աݾ�_����3
        , COL29_1 --����ǥ��_����4
        , COL29_2 --����ǥ��_����4
        
        , VAT_LEVIER_GB     -- ������ ���� 
        
        , CREATION_DATE     --������
        , CREATED_BY	    --������
        , LAST_UPDATE_DATE  --������
        , LAST_UPDATED_BY	--������          
        , LAST_FLAG       -- ��������   
    )
    SELECT
          W_SOB_ID  --ȸ����̵�
        , W_ORG_ID  --����ξ��̵�
        , W_TAX_CODE                --�������̵�
        , W_VAT_MNG_SERIAL          --�ΰ����Ű��Ⱓ���й�ȣ
        , t_SPEC_SERIAL             --�Ϸù�ȣ 
                
        , W_VAT_MAKE_GB     --�Ű�����(01 : ����Ű�, 02:�����Ű�)
        , O_MODIFY_DEGREE   -- �����Ű� ���� --
        , O_MODIFY_DESC     -- �����Ű� ���� -- 
        
        , W_TITLE_1_1       --�Ű��Ⱓ_����
        , W_TITLE_1_2       --�Ű��Ⱓ_����
        , A.CORP_NAME       --��ȣ(���θ�)
        , A.PRESIDENT_NAME  --����(��ǥ��)
        , B.VAT_NUMBER      --����ڵ�Ϲ�ȣ
        , A.LEGAL_NUMBER    --�ֹ�(����)��Ϲ�ȣ
        , A.TEL_NUMBER      --�������ȭ
        , A.TEL_NUMBER      --�ּ�����ȭ
        , B.ADDR1 || ' ' || B.ADDR2 AS LOCATION --������ּ�
        , B.BUSINESS_ITEM   --����
        , B.BUSINESS_TYPE   --����
        , B.ATTRIBUTE1      --�����ڵ�    
        , SYSDATE           --�ۼ�����
        , A.CORP_NAME       --�Ű���      
        , B.TAX_OFFICE_NAME --������

        , B.BUSINESS_ITEM AS COL26_1 --����ǥ��_����1
        , B.BUSINESS_TYPE AS COL26_2 --����ǥ��_����1        
        , B.BUSINESS_ITEM AS COL69_1 --�鼼������Աݾ�_����1
        , B.BUSINESS_TYPE AS COL69_2 --�鼼������Աݾ�_����1 
        , '���Աݾ�����'             --�鼼������Աݾ�_����3
        , B.BUSINESS_TYPE AS COL71_2 --�鼼������Աݾ�_����3 
        , '���Աݾ�����'  --����ǥ��_����4
        , '����ȯ�޿�'    --����ǥ��_����4
        
        , W_VAT_LEVIER_GB            -- ������ ���� 
        
        , V_SYSDATE     --������
        , W_CREATED_BY  --������
        , V_SYSDATE     --������
        , W_CREATED_BY  --������        
        , 'Y'           -- ��������   
    FROM HRM_CORP_MASTER A
       , HRM_OPERATING_UNIT B
       , ( SELECT FC.CODE AS TAX_CODE
                , FC.CODE_NAME AS TAX_DESC
                , REPLACE(FC.VALUE1, '-', '') AS VAT_NUMBER
             FROM FI_COMMON FC
            WHERE FC.GROUP_CODE     = 'TAX_CODE'
              AND FC.SOB_ID         = W_SOB_ID
              AND FC.ORG_ID         = W_ORG_ID
              AND FC.CODE           = W_TAX_CODE
          ) SX1
    WHERE A.CORP_ID = B.CORP_ID
        AND REPLACE(B.VAT_NUMBER, '-', '')    = SX1.VAT_NUMBER
        AND A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID
        AND A.ENABLED_FLAG          = 'Y'
        AND B.USABLE                = 'Y'
        AND (B.DEFAULT_FLAG         = 'Y'
        OR   ROWNUM                 <= 1);
        
--[����ǥ�ع׸��⼼��]������ �� ���� ���Ѵ�.
--�ϱ��� QUERY�� ��ǻ� ��� ������, ���������� �޶��� ���̴�.
--���μ��� �� ������ ������ QUERY�� �ݺ��ȴ�.


    --(1)����_���ݰ�꼭�߱޺�_�ݾ�, ����_���ݰ�꼭�߱޺�_����
    BEGIN
      SELECT
            SUM(TO_NUMBER(REPLACE(TRIM(NVL(REFER2, 0)), ',', ''))) AS GL_AMOUNT     --���ް���
          , SUM(TO_NUMBER(REPLACE(TRIM(NVL(REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --����              
      INTO t_COL1_1, t_COL1_2
      FROM FI_SLIP_LINE
      WHERE SOB_ID = W_SOB_ID
          AND ORG_ID = W_ORG_ID
          AND REFER11 = W_TAX_CODE
          AND MANAGEMENT2 = '1'   --��������(��������)    
          
          --AND A.ACCOUNT_CODE = '2100700'  --�ŷ�����(����/����)
          AND ACCOUNT_CODE IN 
              (
                  SELECT ACCOUNT_CODE
                  FROM FI_ACCOUNT_CONTROL
                  WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                      AND ACCOUNT_CLASS_ID = '1972'   --����Ÿ�� : �ΰ���������
              )  --�ŷ�����(����/����)             
          
          AND TO_DATE(REFER1) BETWEEN W_TITLE_1_1 AND W_TITLE_1_2   --�Ű���������
          --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --�Ű���������  
      ;
    EXCEPTION WHEN OTHERS THEN
      t_COL1_1 := 0;
      t_COL1_2 := 0;
    END;
        

    --(4)����_���ݰ�꼭�߱޺�_�ݾ�, ����_���ݰ�꼭�߱޺�_����
    BEGIN
      SELECT 
            NVL(SUM(DEEMED_RENT), 0)
          , NVL(ROUND(SUM(DEEMED_RENT) * 0.1), 0)
      INTO t_COL4_1, t_COL4_2
      FROM FI_BLD_AMT_SPEC
      WHERE SOB_ID = W_SOB_ID
          AND ORG_ID = W_ORG_ID
          AND TAX_CODE = W_TAX_CODE
          AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL   ;    
    EXCEPTION WHEN OTHERS THEN
      t_COL4_1 := 0;
      t_COL4_2 := 0;
    END;
    
  

    --(5)������_���ݰ�꼭�߱޺�_�ݾ�
    BEGIN
      SELECT
            SUM(TO_NUMBER(REPLACE(TRIM(NVL(REFER2, 0)), ',', ''))) AS GL_AMOUNT     --���ް���            
      INTO t_COL5_1
      FROM FI_SLIP_LINE
      WHERE SOB_ID = W_SOB_ID
          AND ORG_ID = W_ORG_ID
          AND REFER11 = W_TAX_CODE
          AND MANAGEMENT2 = '2'   --��������(��������) 
          
          --AND A.ACCOUNT_CODE = '2100700'  --�ŷ�����(����/����)
          AND ACCOUNT_CODE IN 
              (
                  SELECT ACCOUNT_CODE
                  FROM FI_ACCOUNT_CONTROL
                  WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                      AND ACCOUNT_CLASS_ID = '1972'   --����Ÿ�� : �ΰ���������
              )  --�ŷ�����(����/����)             
          
          AND TO_DATE(REFER1) BETWEEN W_TITLE_1_1 AND W_TITLE_1_2   --�Ű���������
          --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --�Ű���������  
      ; 
    EXCEPTION WHEN OTHERS THEN
      t_COL5_1 := 0;
    END;

    --(6)������_��Ÿ_�ݾ�
    BEGIN
      SELECT
            SUM(TO_NUMBER(REPLACE(TRIM(NVL(REFER2, 0)), ',', ''))) AS GL_AMOUNT     --���ް���            
      INTO t_COL6_1
      FROM FI_SLIP_LINE
      WHERE SOB_ID = W_SOB_ID
          AND ORG_ID = W_ORG_ID
          AND REFER11 = W_TAX_CODE
          AND MANAGEMENT2 = '3'   --��������(����) 
          
          --AND A.ACCOUNT_CODE = '2100700'  --�ŷ�����(����/����)
          AND ACCOUNT_CODE IN 
              (
                  SELECT ACCOUNT_CODE
                  FROM FI_ACCOUNT_CONTROL
                  WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                      AND ACCOUNT_CLASS_ID = '1972'   --����Ÿ�� : �ΰ���������
              )  --�ŷ�����(����/����)             
          
          AND TO_DATE(REFER1) BETWEEN W_TITLE_1_1 AND W_TITLE_1_2   --�Ű���������
          --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --�Ű���������  
      ;
    EXCEPTION WHEN OTHERS THEN
      t_COL6_1 := 0;
    END;
    
    

--[���Լ���]������ �� ���� ���Ѵ�.
--�ϱ��� QUERY�� ��ǻ� ��� ������, ���������� �޶��� ���̴�.
--���μ��� �� ������ ������ QUERY�� �ݺ��ȴ�.

    --(10), (11) ; ����_�Ϲݸ���_�ݾ�, ����_�Ϲݸ���_����, ����_�����ڻ����_�ݾ�, ����_�����ڻ����_����
    BEGIN
      SELECT                
          --���ް��� - �����ڻ��ǥ
            SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) - 
            NVL(SUM(TO_NUMBER(REPLACE(TRIM(A.REFER10), ',', ''))), 0) AS COL10_1  --����_�Ϲݸ���_�ݾ�
          --���� - �����ڻ꼼��
          , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) - 
            NVL(SUM(TO_NUMBER(REPLACE(TRIM(A.REFER11), ',', ''))), 0) AS COL10_2  --����_�Ϲݸ���_����
          , NVL(SUM(TO_NUMBER(REPLACE(TRIM(A.REFER10), ',', ''))), 0) AS COL11_1   --����_�����ڻ����_�ݾ�
          , NVL(SUM(TO_NUMBER(REPLACE(TRIM(A.REFER11), ',', ''))), 0) AS COL11_2    --����_�����ڻ����_����
      INTO t_COL10_1, t_COL10_2, t_COL11_1, t_COL11_2 
      FROM FI_SLIP_LINE A
      WHERE A.SOB_ID = W_SOB_ID
          AND A.ORG_ID = W_ORG_ID
          AND A.MANAGEMENT2 = W_TAX_CODE
          AND REFER1 IN ('1', '2', '3', '5', '8')    --��������(��������,��������,���Լ��׺Ұ���,����,�������Լ���)
          
          --AND A.ACCOUNT_CODE = '1111700'  --�ŷ�����(����/����)
          AND A.ACCOUNT_CODE IN 
              (
                  SELECT ACCOUNT_CODE
                  FROM FI_ACCOUNT_CONTROL
                  WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                      AND ACCOUNT_CLASS_ID = '1832'   --����Ÿ�� : �ΰ�����ޱ�                        
              )  --�ŷ�����(����/����)              
          
          --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --�Ű��������� 
          AND TO_DATE(A.REFER2) BETWEEN W_TITLE_1_1 AND W_TITLE_1_2   --�Ű���������
      ;   
    EXCEPTION WHEN OTHERS THEN
      t_COL10_1 := 0;
      t_COL10_2 := 0;
      t_COL11_1 := 0;
      t_COL11_2 := 0;
    END;
    
    
    --(14) : ����_��Ÿ�������Լ���_�ݾ�, ����_��Ÿ�������Լ���_����
    --(39) : ��Ÿ����_�ſ�ī��_�Ϲݸ���_�ݾ�, ��Ÿ����_�ſ�ī��_�Ϲݸ���_����
    --(47) : ��Ÿ����_�հ�_�ݾ�, ��Ÿ����_���_����
    BEGIN
      SELECT                
            SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --���ް���
          , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --����
          , SUM(TO_NUMBER(REPLACE(TRIM(A.REFER10), ',', ''))) AS ASSET_BASE   --�����ڻ��ǥ
          , SUM(TO_NUMBER(REPLACE(TRIM(A.REFER11), ',', ''))) AS ASSET_TAX    --�����ڻ꼼��        
      INTO t_COL14_1, t_COL14_2, t_COL40_1, t_COL40_2
      FROM FI_SLIP_LINE A
      WHERE A.SOB_ID = W_SOB_ID
          AND A.ORG_ID = W_ORG_ID
          AND A.MANAGEMENT2 = W_TAX_CODE
          AND REFER1 IN ('6', '7')    --��������(ī�����,���ݿ���������)
          
          --AND A.ACCOUNT_CODE = '1111700'  --�ŷ�����(����/����)
          AND A.ACCOUNT_CODE IN 
              (
                  SELECT ACCOUNT_CODE
                  FROM FI_ACCOUNT_CONTROL
                  WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                      AND ACCOUNT_CLASS_ID = '1832'   --����Ÿ�� : �ΰ�����ޱ�                        
              )  --�ŷ�����(����/����)              
          
          --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --�Ű��������� 
          AND TO_DATE(A.REFER2) BETWEEN W_TITLE_1_1 AND W_TITLE_1_2   --�Ű���������
      ; 
    EXCEPTION WHEN OTHERS THEN
      t_COL14_1 := 0;
      t_COL14_2 := 0;
      t_COL40_1 := 0;
      t_COL40_2 := 0;
    END;
    
    -- (14).4 ��Ÿ���� : ��Ȱ�����ڿ��� ���Լ��� �ݾ׵� 
    BEGIN
      SELECT SUM(RED.ITEM_AMOUNT) AS ITEM_AMOUNT
           , SUM(RED.DEEMED_VAT_AMOUNT) AS DEEMED_VAT_AMOUNT
        INTO t_COL42_1
           , t_COL42_2
        FROM FI_VAT_RECYCLING_ETC_DETAIL RED
       WHERE RED.TAX_CODE           = W_TAX_CODE
         AND RED.SOB_ID             = W_SOB_ID
         AND RED.ORG_ID             = W_ORG_ID
         AND RED.VAT_MNG_SERIAL     = W_VAT_MNG_SERIAL
         AND RED.VAT_RECEIPT_TYPE   IN('10', '20')  -- ������, ��꼭 ����и� ���� 
      ;
    EXCEPTION
      WHEN OTHERS THEN
        t_COL42_1 := 0;
        t_COL42_2 := 0;
    END;
    
    t_COL15_1 := NVL(t_COL10_1, 0) + NVL(t_COL11_1, 0) + NVL(t_COL14_1, 0); --����_�հ�_�ݾ�
    t_COL15_2 := NVL(t_COL10_2, 0) + NVL(t_COL11_2, 0) + NVL(t_COL14_2, 0); --����_�հ�_����
    
    
    --(16) : ����_�����������Ҹ��Լ���_�ݾ�, ����_�����������Ҹ��Լ���_����
    --(48) : �����������Ҹ��Լ���_������������_�ݾ�, �����������Ҹ��Լ���_������������_����
    --(49) : ������Լ��� �鼼����� 
    --(51) : �����������Ҹ��Լ���_�հ�_�ݾ�, �����������Ҹ��Լ���_�հ�_����
    BEGIN
      -- ��ȣ�� �߰� : ������������ ���Լ��� ���� --
      SELECT                
            SUM(NVL(A.GL_AMOUNT, 0)) AS GL_AMOUNT     --���ް���
          , SUM(NVL(A.VAT_AMOUNT, 0)) AS VAT_AMOUNT    --����   
      INTO t_COL16_1, t_COL16_2
      FROM FI_NO_DEDUCTION_SPEC A
      WHERE A.SOB_ID = W_SOB_ID
          AND A.ORG_ID = W_ORG_ID
          AND A.TAX_CODE = W_TAX_CODE
          AND A.VAT_DATE_FR = W_TITLE_1_1 
          AND A.VAT_DATE_TO = W_TITLE_1_2   --�Ű���������
          AND A.NO_DED_CODE = '990'
      ;
      /*-- ��ȣ�� �ּ� : ������������ ���Լ��� ���� --
      SELECT                
            SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --���ް���
          , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --����   
      INTO t_COL16_1, t_COL16_2
      FROM FI_SLIP_LINE A
      WHERE A.SOB_ID = W_SOB_ID
          AND A.ORG_ID = W_ORG_ID
          AND A.MANAGEMENT2 = W_TAX_CODE
          AND REFER1 = '3'    --��������(���Լ��׺Ұ���)
          
          --AND A.ACCOUNT_CODE = '1111700'  --�ŷ�����(����/����)
          AND A.ACCOUNT_CODE IN 
              (
                  SELECT ACCOUNT_CODE
                  FROM FI_ACCOUNT_CONTROL
                  WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                      AND ACCOUNT_CLASS_ID = '1832'   --����Ÿ�� : �ΰ�����ޱ�                        
              )  --�ŷ�����(����/����)              
          
          --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --�Ű��������� 
          AND TO_DATE(A.REFER2) BETWEEN W_TITLE_1_1 AND W_TITLE_1_2   --�Ű���������
      ;*/
    EXCEPTION WHEN OTHERS THEN
      t_COL16_1 := 0;
      t_COL16_2 := 0;
    END;
    
    BEGIN
      -- ��ȣ�� �߰� : ������Լ��� �鼼����� --
      SELECT                
            SUM(NVL(A.GL_AMOUNT, 0)) AS GL_AMOUNT     --���ް���
          , SUM(NVL(A.VAT_AMOUNT, 0)) AS VAT_AMOUNT    --����   
      INTO t_COL48_1, t_COL48_2      
      FROM FI_NO_DEDUCTION_SPEC A
      WHERE A.SOB_ID = W_SOB_ID
          AND A.ORG_ID = W_ORG_ID
          AND A.TAX_CODE = W_TAX_CODE
          AND A.VAT_DATE_FR = W_TITLE_1_1 
          AND A.VAT_DATE_TO = W_TITLE_1_2   --�Ű���������
          AND (A.NO_DED_TYPE = '10'
          AND  A.NO_DED_CODE = '99')
      ;
      /*-- ��ȣ�� �ּ� : ������������ ���Լ��� ���� --
      SELECT                
            SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --���ް���
          , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --����   
      INTO t_COL16_1, t_COL16_2
      FROM FI_SLIP_LINE A
      WHERE A.SOB_ID = W_SOB_ID
          AND A.ORG_ID = W_ORG_ID
          AND A.MANAGEMENT2 = W_TAX_CODE
          AND REFER1 = '3'    --��������(���Լ��׺Ұ���)
          
          --AND A.ACCOUNT_CODE = '1111700'  --�ŷ�����(����/����)
          AND A.ACCOUNT_CODE IN 
              (
                  SELECT ACCOUNT_CODE
                  FROM FI_ACCOUNT_CONTROL
                  WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                      AND ACCOUNT_CLASS_ID = '1832'   --����Ÿ�� : �ΰ�����ޱ�                        
              )  --�ŷ�����(����/����)              
          
          --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --�Ű��������� 
          AND TO_DATE(A.REFER2) BETWEEN W_TITLE_1_1 AND W_TITLE_1_2   --�Ű���������
      ;*/
    EXCEPTION WHEN OTHERS THEN
      t_COL48_1 := 0;
      t_COL48_2 := 0;
    END;    
    BEGIN
      -- ��ȣ�� �߰� : ������Լ��� �鼼����� --
      SELECT                
            SUM(NVL(A.GL_AMOUNT, 0)) AS GL_AMOUNT     --���ް���
          , SUM(NVL(A.VAT_AMOUNT, 0)) AS VAT_AMOUNT    --����   
      INTO t_COL49_1, t_COL49_2      
      FROM FI_NO_DEDUCTION_SPEC A
      WHERE A.SOB_ID = W_SOB_ID
          AND A.ORG_ID = W_ORG_ID
          AND A.TAX_CODE = W_TAX_CODE
          AND A.VAT_DATE_FR = W_TITLE_1_1 
          AND A.VAT_DATE_TO = W_TITLE_1_2   --�Ű���������
          AND (A.NO_DED_TYPE = '20'
          AND  A.NO_DED_CODE != '990')
      ;
      /*-- ��ȣ�� �ּ� : ������������ ���Լ��� ���� --
      SELECT                
            SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --���ް���
          , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --����   
      INTO t_COL16_1, t_COL16_2
      FROM FI_SLIP_LINE A
      WHERE A.SOB_ID = W_SOB_ID
          AND A.ORG_ID = W_ORG_ID
          AND A.MANAGEMENT2 = W_TAX_CODE
          AND REFER1 = '3'    --��������(���Լ��׺Ұ���)
          
          --AND A.ACCOUNT_CODE = '1111700'  --�ŷ�����(����/����)
          AND A.ACCOUNT_CODE IN 
              (
                  SELECT ACCOUNT_CODE
                  FROM FI_ACCOUNT_CONTROL
                  WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                      AND ACCOUNT_CLASS_ID = '1832'   --����Ÿ�� : �ΰ�����ޱ�                        
              )  --�ŷ�����(����/����)              
          
          --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --�Ű��������� 
          AND TO_DATE(A.REFER2) BETWEEN W_TITLE_1_1 AND W_TITLE_1_2   --�Ű���������
      ;*/
    EXCEPTION WHEN OTHERS THEN
      t_COL49_1 := 0;
      t_COL49_2 := 0;
    END;  
    
    -- �����������Ҹ��Լ��׸����� �հ� --
    t_COL51_1 := NVL(t_COL48_1, 0) + NVL(t_COL49_1, 0);
    t_COL51_2 := NVL(t_COL48_2, 0) + NVL(t_COL49_2, 0);
    
    t_COL17_1 := NVL(t_COL15_1, 0) - NVL(t_COL51_1, 0); --����_������_�ݾ�
    t_COL17_2 := NVL(t_COL15_2, 0) - NVL(t_COL51_2, 0); --����_������_����
    
    /*-- ��ȣ�� �ּ� : ������������ ���Լ��� ���� --
    t_COL17_1 := NVL(t_COL15_1, 0) - NVL(t_COL16_1, 0); --����_������_�ݾ�
    t_COL17_2 := NVL(t_COL15_2, 0) - NVL(t_COL16_2, 0); --����_������_����
    */
/*
    -- 18-53 ��Ÿ �氨/���� ���׸���  
    t_COL18_2 := 0;  -- �氨�������� - ��Ÿ �氨/��������;
    t_COL20_2 := 0;  -- �氨�������� �հ� ;
    t_COL53_2 := 0;  -- (18)��Ÿ�氨/�������׸��� - ���ڼ��ݰ�꼭 �߱޼��װ���;
    t_COL57_2 := 0;  -- (18)�հ�;
    BEGIN
      SELECT SUM(NVL(TP.DEDUCT_TAX, 0)) AS DEDUCT_TAX
        INTO t_COL53_2
        FROM FI_ELEC_TAX_PUB TP
       WHERE TP.SOB_ID        = W_SOB_ID
         AND TP.ORG_ID        = W_ORG_ID
         AND TP.TAX_CODE      = W_TAX_CODE
         AND TP.VAT_MNG_SERIAL = W_VAT_MNG_SERIAL
      ;
    EXCEPTION WHEN OTHERS THEN
      t_COL53_2 := 0;
    END;
    t_COL18_2 := t_COL53_2;  -- �氨�������� - ��Ÿ �氨/��������;
    t_COL20_2 := t_COL53_2;  -- �氨�������� �հ� ;
    t_COL57_2 := t_COL53_2;  -- (18)�հ�;
    */
    
    --(73) : ��꼭�߱ޱݾ�
    BEGIN
      SELECT                
            SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT     --���ް��� 
      INTO t_COL73
      FROM FI_SLIP_LINE A
      WHERE A.SOB_ID = W_SOB_ID
          AND A.ORG_ID = W_ORG_ID
          AND A.REFER11 = W_TAX_CODE
          AND A.MANAGEMENT2 = '4'    --��������(�鼼����)
          
          --AND A.ACCOUNT_CODE = '1111700'  --�ŷ�����(����/����)
          AND A.ACCOUNT_CODE IN 
              (
                  SELECT ACCOUNT_CODE
                  FROM FI_ACCOUNT_CONTROL
                  WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                      AND ACCOUNT_CLASS_ID = 1972   --����Ÿ�� : �ΰ���������                       
              )  --�ŷ�����(����/����)              
          
          --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --�Ű��������� 
          AND TO_DATE(A.REFER1) BETWEEN W_TITLE_1_1 AND W_TITLE_1_2   --�Ű���������
      ;               
    EXCEPTION WHEN OTHERS THEN
      t_COL73 := 0;
    END;
    
    
    --(74) : ��꼭����ݾ�
    BEGIN
      SELECT                
            SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --���ް��� 
      INTO t_COL74
      FROM FI_SLIP_LINE A
      WHERE A.SOB_ID = W_SOB_ID
          AND A.ORG_ID = W_ORG_ID
          AND A.MANAGEMENT2 = W_TAX_CODE
          AND A.REFER1 = '4'    --��������(�鼼����)
          
          --AND A.ACCOUNT_CODE = '1111700'  --�ŷ�����(����/����)
          AND A.ACCOUNT_CODE IN 
              (
                  SELECT ACCOUNT_CODE
                  FROM FI_ACCOUNT_CONTROL
                  WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                      AND ACCOUNT_CLASS_ID = 1832   --����Ÿ�� : �ΰ�����ޱ�                        
              )  --�ŷ�����(����/����)              
          
          --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --�Ű��������� 
          AND TO_DATE(A.REFER2) BETWEEN W_TITLE_1_1 AND W_TITLE_1_2   --�Ű���������
      ;
    EXCEPTION WHEN OTHERS THEN
      t_COL74 := 0;
    END;



    --(29)����ǥ�ظ����� ����ȯ�޿� : ����ȯ�޵�������� �ݾ� + �ε����Ӵ���ް��׸������� �����Ӵ��_����������
    BEGIN
      SELECT
          NVL((        
                SELECT NVL(SUM(SUPPLY_AMT), 0)
                FROM FI_TARIFF_SPEC
                WHERE SOB_ID = W_SOB_ID
                    AND ORG_ID = W_ORG_ID
                    AND TAX_CODE = W_TAX_CODE
                    AND VAT_MNG_SERIAL = 2
               ), 0) +
          NVL((
                SELECT NVL(SUM(DEEMED_RENT), 0)
                FROM FI_BLD_AMT_SPEC
                WHERE SOB_ID = W_SOB_ID
                    AND ORG_ID = W_ORG_ID
                    AND TAX_CODE = W_TAX_CODE
                    AND VAT_MNG_SERIAL = 2
               ), 0)
      INTO t_COL29_3
      FROM DUAL;
    EXCEPTION WHEN OTHERS THEN
      t_COL29_3 := 0;
    END;



    UPDATE FI_SURTAX_CARD
    SET   COL1_1 = t_COL1_1   --����_���ݰ�꼭�߱޺�_�ݾ�
        , COL1_2 = t_COL1_2   --����_���ݰ�꼭�߱޺�_����    
        , COL4_1 = t_COL4_1   --����_��Ÿ_�ݾ�
        , COL4_2 = t_COL4_2   --����_��Ÿ_����
        , COL5_1 = t_COL5_1   --������_���ݰ�꼭�߱޺�_�ݾ�
        , COL6_1 = t_COL6_1   --������_��Ÿ_�ݾ�
        
        , COL9_1 = NVL(t_COL1_1, 0) + NVL(t_COL4_1, 0) + NVL(t_COL5_1, 0) + NVL(t_COL6_1, 0)    --�հ�_�ݾ�
        , COL30 = NVL(t_COL1_1, 0) + NVL(t_COL4_1, 0) + NVL(t_COL5_1, 0) + NVL(t_COL6_1, 0)     --����ǥ��_�հ�
        , COL9_2 = NVL(t_COL1_2, 0) + NVL(t_COL4_2, 0)  --�հ�_����
        
        , COL10_1 = t_COL10_1   --����_�Ϲݸ���_�ݾ�
        , COL10_2 = t_COL10_2   --����_�Ϲݸ���_����
        , COL11_1 = t_COL11_1   --����_�����ڻ����_�ݾ�
        , COL11_2 = t_COL11_2   --����_�����ڻ����_���� 
        
        , COL14_1 = t_COL14_1   --����_��Ÿ�������Լ���_�ݾ�
        , COL14_2 = t_COL14_2   --����_��Ÿ�������Լ���_����
        
        , COL39_1 = NVL(t_COL14_1, 0) - NVL(t_COL40_1, 0)   --��Ÿ����_�ſ�ī��_�Ϲݸ���_�ݾ�
        , COL39_2 = NVL(t_COL14_2, 0) - NVL(t_COL40_2, 0)  --��Ÿ����_�ſ�ī��_�Ϲݸ���_����
        , COL40_1 = t_COL40_1   --��Ÿ����_�ſ�ī��_�����ڻ����_�ݾ�
        , COL40_2 = t_COL40_2   --��Ÿ����_�ſ�ī��_�����ڻ����_����                              
        
        , COL42_1 = t_COL42_1   -- ��Ÿ���� - ��Ȱ�����ڿ� �ݾ� 
        , COL42_2 = t_COL42_2   -- ��Ÿ���� - ��Ȱ�����ڿ� ���� 
        
        , COL47_1 = NVL(t_COL14_1, 0) + NVL(t_COL42_1, 0)    --��Ÿ����_�հ�_�ݾ�
        , COL47_2 = NVL(t_COL14_2, 0) + NVL(t_COL42_2, 0)    --��Ÿ����_���_���� 
        
        , COL15_1 = t_COL15_1   --����_�հ�_�ݾ�
        , COL15_2 = t_COL15_2   --����_�հ�_����        
        
        , COL16_1 = t_COL16_1   --����_�����������Ҹ��Լ���_�ݾ�
        , COL16_2 = t_COL16_2   --����_�����������Ҹ��Լ���_����
        , COL48_1 = t_COL48_1   --�����������Ҹ��Լ���_������������_�ݾ�
        , COL48_2 = t_COL48_2   --�����������Ҹ��Լ���_������������_����
        , COL49_1 = t_COL49_1   --�����������Ҹ��Լ���_������������_�ݾ�
        , COL49_2 = t_COL49_2   --�����������Ҹ��Լ���_������������_����
        , COL51_1 = t_COL51_1   --�����������Ҹ��Լ���_�հ�_�ݾ�
        , COL51_2 = t_COL51_2   --�����������Ҹ��Լ���_�հ�_����
        
        , COL17_1 = t_COL17_1   --����_������_�ݾ�
        , COL17_2 = t_COL17_2   --����_������_����
        
        , COL_DA = (NVL(t_COL1_2, 0) + NVL(t_COL4_2, 0)) - (NVL(t_COL15_2, 0) - NVL(t_COL16_2, 0))   --���μ���
        , COL25 = (NVL(t_COL1_2, 0) + NVL(t_COL4_2, 0)) - (NVL(t_COL15_2, 0) - NVL(t_COL16_2, 0))   --�������Ͽ������Ҽ���
        
        , COL29_3 = t_COL29_3 --����ǥ��_�ݾ�4
        
        --COL30 = t_COL1_1 + t_COL4_1 + t_COL5_1 + t_COL6_1     --����ǥ��_�հ�
        , COL26_3 = (NVL(t_COL1_1, 0) + NVL(t_COL4_1, 0) + NVL(t_COL5_1, 0) + NVL(t_COL6_1, 0)) - NVL(t_COL29_3, 0)
        
        , COL73 = t_COL73   -- ��꼭�߱ޱݾ� 
        , COL74 = t_COL74   --��꼭����ݾ�
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND TAX_CODE = W_TAX_CODE
        AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL
        AND SPEC_SERIAL = t_SPEC_SERIAL
    ;

    O_STATUS := 'S';
END CREATE_SURTAX_CARD;





--��ȸ �� ���
PROCEDURE LIST_SURTAX_CARD(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_SURTAX_CARD.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID              IN  FI_SURTAX_CARD.ORG_ID%TYPE  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2                            --�������̵�(��>110)        
    , W_VAT_MNG_SERIAL      IN  FI_SURTAX_CARD.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű��Ⱓ���й�ȣ
    , W_VAT_MAKE_GB         IN  FI_SURTAX_CARD.VAT_MAKE_GB%TYPE DEFAULT '01'    --�Ű�����(01 : ����Ű�)
    , W_MODIFY_DEGREE       IN  FI_SURTAX_CARD.MODIFY_DEGREE%TYPE               -- �����Ű� ���� -- 
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          SOB_ID	        --ȸ����̵�
        , ORG_ID	        --����ξ��̵�
        , TAX_CODE	--�������̵�
        , VAT_MNG_SERIAL	--�ΰ����Ű��Ⱓ���й�ȣ
        , SPEC_SERIAL	    --�Ϸù�ȣ
        
        --����>�����Ű��� ó���� �� �ֵ��� Ʋ�� ����� ���� �۾��� �������� �ʾҴ�.
        , VAT_MAKE_GB	    --�Ű�����(01 : ����Ű�, 02 : �����Ű�)
        
        , GUBUN_1	--�Ű�������_����
        , GUBUN_2	--�Ű�������_Ȯ��
        , GUBUN_3	--�Ű�������_�����İ���ǥ��
        , GUBUN_4	--�Ű�������_������������ȯ��
        
        , TITLE_1_1	--�Ű��Ⱓ_����
        , TITLE_1_2	--�Ű��Ⱓ_����
        , TO_CHAR(TITLE_1_2, 'YYYY') || '  ��   ' ||  
          CASE
            WHEN TO_NUMBER(TO_CHAR(TITLE_1_2, 'MM')) <= 6 THEN '1  ��   ( '
            ELSE '2  ��   ( '
          END
          || TO_CHAR(TITLE_1_1, 'MM') || ' �� ' || TO_CHAR(TITLE_1_1, 'DD')  || ' �� ~ '
          || TO_CHAR(TITLE_1_2, 'MM') || ' �� ' || TO_CHAR(TITLE_1_2, 'DD') || ' �� )'
          AS FISCAL_YEAR   --�Ű��Ⱓ_��¿�    
            
        , TITLE_2	--��ȣ
        , TITLE_3	--����
        
        , TITLE_4	--����ڵ�Ϲ�ȣ
        --��¿� ����ڵ�Ϲ�ȣ
        , SUBSTR(TITLE_4, 1, 1) AS TITLE_4_01
        , SUBSTR(TITLE_4, 2, 1) AS TITLE_4_02
        , SUBSTR(TITLE_4, 3, 1) AS TITLE_4_03
        , SUBSTR(TITLE_4, 5, 1) AS TITLE_4_04
        , SUBSTR(TITLE_4, 6, 1) AS TITLE_4_05
        , SUBSTR(TITLE_4, 8, 1) AS TITLE_4_06
        , SUBSTR(TITLE_4, 9, 1) AS TITLE_4_07
        , SUBSTR(TITLE_4, 10, 1) AS TITLE_4_08
        , SUBSTR(TITLE_4, 11, 1) AS TITLE_4_09
        , SUBSTR(TITLE_4, 12, 1) AS TITLE_4_10
        
        , TITLE_5	--���ε�Ϲ�ȣ
        , TITLE_6	--�������ȭ
        , TITLE_7	--�ּ�����ȭ
        , TITLE_8	--�޴���ȭ
        , TITLE_9	--������ּ�
        , TITLE_10	--���ڿ����ּ�
        , TITLE_11	--����
        , TITLE_12	--����
        
        , TITLE_13	--�����ڵ�
        --��¿� �����ڵ�
        , SUBSTR(TITLE_13, 1, 1) AS TITLE_13_1
        , SUBSTR(TITLE_13, 2, 1) AS TITLE_13_2
        , SUBSTR(TITLE_13, 3, 1) AS TITLE_13_3
        , SUBSTR(TITLE_13, 4, 1) AS TITLE_13_4
        , SUBSTR(TITLE_13, 5, 1) AS TITLE_13_5
        , SUBSTR(TITLE_13, 6, 1) AS TITLE_13_6
        
        , TITLE_14	--�ۼ�����
        , TO_CHAR(TITLE_14, 'YYYY') || ' ��   '
          || TO_NUMBER(TO_CHAR(TITLE_14, 'MM')) || ' ��   ' 
          || TO_NUMBER(TO_CHAR(TITLE_14, 'DD'))  || ' ��'
          AS TITLE_14_PRINT	--��¿� �ۼ�����    
        
        , TITLE_15	--�Ű���
        , TITLE_16	--������
        
        , COL1_1	--����_���ݰ�꼭�߱޺�_�ݾ�
        , COL1_2	--����_���ݰ�꼭�߱޺�_����
        , COL2_1	--����_�����ڹ��༼�ݰ�꼭_�ݾ�
        , COL2_2	--����_�����ڹ��༼�ݰ�꼭_����
        , COL3_1	--����_�ſ�ī��_���ݿ����������_�ݾ�
        , COL3_2	--����_�ſ�ī��_���ݿ����������_����
        , COL4_1	--����_��Ÿ_�ݾ�
        , COL4_2	--����_��Ÿ_����
        , COL5_1	--������_���ݰ�꼭�߱޺�_�ݾ�
        , COL6_1	--������_��Ÿ_�ݾ�
        , COL7_1	--�����Ű�������_�ݾ�
        , COL7_2	--�����Ű�������_����
        , COL8_2	--��ռ��װ���_����
        , COL9_1	--�հ�_�ݾ�
        , COL9_2	--�հ�_����
        , COL10_1	--����_�Ϲݸ���_�ݾ�
        , COL10_2	--����_�Ϲݸ���_����
        , COL11_1	--����_�����ڻ����_�ݾ�
        , COL11_2	--����_�����ڻ����_����
        , COL12_1	--����_�����Ű�������_�ݾ�
        , COL12_2	--����_�����Ű�������_����
        , COL13_1	--����_�����ڹ��༼�ݰ�꼭_�ݾ�
        , COL13_2	--����_�����ڹ��༼�ݰ�꼭_����
        , COL14_1	--����_��Ÿ�������Լ���_�ݾ�
        , COL14_2	--����_��Ÿ�������Լ���_����
        , COL15_1	--����_�հ�_�ݾ�
        , COL15_2	--����_�հ�_����
        , COL16_1	--����_�����������Ҹ��Լ���_�ݾ�
        , COL16_2	--����_�����������Ҹ��Լ���_����
        , COL17_1	--����_������_�ݾ�
        , COL17_2	--����_������_����
        , COL_DA	--���μ���
        , COL18_2	--��Ÿ�氨��������
        , COL19_2	--�ſ�ī�������ǥ����������
        , COL20_2	--�氨����_�հ�
        , COL21_2	--�����Ű���ȯ�޼���
        , COL22_2	--������������
        , COL23_2	--������_������_����Ư��_�ⳳ�μ���
        , COL24_2	--���꼼�װ�
        , COL25	    --�������Ͽ������Ҽ���
        
        , DEAL_BANK	        --�ŷ�����
        , DEAL_BANK_CD	    --�ŷ������ڵ�
        , DEAL_BRANCH	    --�ŷ�����
        , DEAL_BRANCH_ID	--�ŷ������ڵ�
        , ACC_NO	        --���¹�ȣ
        , CLOSURE_DATE	    --�����
        , DECODE(CLOSURE_DATE, NULL, NULL, '', NULL, 
              TO_CHAR(CLOSURE_DATE, 'YYYY') || '�� '
              || TO_NUMBER(TO_CHAR(CLOSURE_DATE, 'MM')) || '��   ' 
              || TO_NUMBER(TO_CHAR(CLOSURE_DATE, 'DD'))  || '��'    
          ) AS CLOSURE_DATE_PRINT	--��¿� �����       
        
        , CLOSURE_REASON	--�������
        
        , COL26_1	--����ǥ��_����1
        , COL26_2	--����ǥ��_����1
        , COL26_3	--����ǥ��_�ݾ�1
        , COL27_1	--����ǥ��_����2
        , COL27_2	--����ǥ��_����2
        , COL27_3	--����ǥ��_�ݾ�2
        , COL28_1	--����ǥ��_����3
        , COL28_2	--����ǥ��_����3
        , COL28_3	--����ǥ��_�ݾ�3
        , COL29_1	--����ǥ��_����4
        , COL29_2	--����ǥ��_����4
        , COL29_3	--����ǥ��_�ݾ�4
        , COL30	    --����ǥ��_�հ�
        
        , COL31_1	--�����Ű�_����_����_���ݰ�꼭_�ݾ�
        , COL31_2	--�����Ű�_����_����_���ݰ�꼭_����
        , COL32_1	--�����Ű�_����_����_��Ÿ_�ݾ�
        , COL32_2	--�����Ű�_����_����_��Ÿ_����
        , COL33_1	--�����Ű�_����_������_���ݰ�꼭
        , COL34_1	--�����Ű�_����_������_��Ÿ
        , COL35_1	--�����Ű�_����_�հ�_�ݾ�
        , COL35_2	--�����Ű�_����_�հ�_����
        , COL36_1	--�����Ű�_����_���ݰ�꼭_�ݾ�
        , COL36_2	--�����Ű�_����_���ݰ�꼭_����
        , COL37_1	--�����Ű�_����_��Ÿ�������Լ���_�ݾ�
        , COL37_2	--�����Ű�_����_��Ÿ�������Լ���_����
        , COL38_1	--�����Ű�_����_�հ�_�ݾ�
        , COL38_2	--�����Ű�_����_�հ�_����
        
        , COL39_1	--��Ÿ����_�ſ�ī��_�Ϲݸ���_�ݾ�
        , COL39_2	--��Ÿ����_�ſ�ī��_�Ϲݸ���_����
        , COL40_1	--��Ÿ����_�ſ�ī��_�����ڻ����_�ݾ�
        , COL40_2	--��Ÿ����_�ſ�ī��_�����ڻ����_����
        , COL41_1	--��Ÿ����_�������Լ���_�ݾ�
        , COL41_2	--��Ÿ����_�������Լ���_����
        , COL42_1	--��Ÿ����_��Ȱ�����ڿ�����Լ���_�ݾ�
        , COL42_2	--��Ÿ����_��Ȱ�����ڿ�����Լ���_����
        , COL43_1	--��Ÿ����_�����������Լ���_�ݾ�
        , COL43_2	--��Ÿ����_�����������Լ���_����
        , COL44_2	--��Ÿ����_���������ȯ���Լ���_����
        , COL45_2	--��Ÿ����_������Լ���_����
        , COL46_2	--��Ÿ����_������ռ���_����
        , COL47_1	--��Ÿ����_�հ�_�ݾ�
        , COL47_2	--��Ÿ����_���_����
        
        , COL48_1	--�����������Ҹ��Լ���_������������_�ݾ�
        , COL48_2	--�����������Ҹ��Լ���_������������_����
        , COL49_1	--�����������Ҹ��Լ���_������Լ��׸鼼_�ݾ�
        , COL49_2	--�����������Ҹ��Լ���_������Լ��׸鼼_����
        , COL50_1	--�����������Ҹ��Լ���_���ó�й�������_�ݾ�
        , COL50_2	--�����������Ҹ��Լ���_���ó�й�������_����
        , COL51_1	--�����������Ҹ��Լ���_�հ�_�ݾ�
        , COL51_2	--�����������Ҹ��Լ���_�հ�_����
        
        , COL52_2	--��Ź�氨��������_���ڽŰ����װ���_����
        , COL53_2	--��Ÿ�氨��������_���ڼ��ݰ�꼭�߱޼��װ���_����
        , COL54_2	--��Ÿ�氨��������_�ýÿ�ۻ���ڰ氨����_����
        , COL55_2	--��Ÿ�氨��������_���ݿ���������ڼ��װ���_����
        , COL56_2	--��Ÿ�氨��������_��Ÿ_����
        , COL57_2	--��Ÿ�氨��������_�հ�_����
        
        , COL58_1	--���꼼����_����ڹ̵�ϵ�_�ݾ�
        , COL58_2	--���꼼����_����ڹ̵�ϵ�_����
        , COL59_1	--���꼼����_�����߱޵�_�ݾ�
        , COL59_2	--���꼼����_�����߱޵�_����
        , COL60_1	--���꼼����_�̹߱޵�_�ݾ�
        , COL60_2	--���꼼����_�̹߱޵�_����
        , COL61_1	--���꼼����_������15������_�ݾ�
        , COL61_2	--���꼼����_������15������_����
        , COL62_1	--���꼼����_�����Ⱓ������15������_�ݾ�
        , COL62_2	--���꼼����_�����Ⱓ������15������_����
        , COL63_1	--���꼼����_���ݰ�꼭�հ�ǥ����Ҽ���_�ݾ�
        , COL63_2	--���꼼����_���ݰ�꼭�հ�ǥ����Ҽ���_����
        , COL64_1	--���꼼����_�Ű��Ҽ���_�ݾ�
        , COL64_2	--���꼼����_�Ű��Ҽ���_����
        , COL65_1	--���꼼����_���κҼ���_�ݾ�
        , COL65_2	--���꼼����_���κҼ���_����
        , COL66_1	--���꼼����_����������ǥ�ؽŰ��Ҽ���_�ݾ�
        , COL66_2	--���꼼����_����������ǥ�ؽŰ��Ҽ���_����
        , COL67_1	--���꼼����_���ݸ���������������_�ݾ�
        , COL67_2	--���꼼����_���ݸ���������������_����
        , COL68_2	--���꼼����_�հ�_����
        
        , COL69_1	--�鼼������Աݾ�_����1
        , COL69_2	--�鼼������Աݾ�_����1
        , COL69_3	--�鼼������Աݾ�_�ݾ�1
        , COL70_1	--�鼼������Աݾ�_����2
        , COL70_2	--�鼼������Աݾ�_����2
        , COL70_3	--�鼼������Աݾ�_�ݾ�2
        , COL71_1	--�鼼������Աݾ�_����3
        , COL71_2	--�鼼������Աݾ�_����3
        , COL71_3	--�鼼������Աݾ�_�ݾ�3
        , COL72	    --�鼼������Աݾ�_�հ�
        
        , COL73	--��꼭�߱ޱݾ�
        , COL74	--��꼭����ݾ�
        
        , R_ORIGIN_PLACE_VAT  -- �氨�������� - ������Ȯ�μ� �߱ް�������
        , A_TAX_RECEIVE_DELAY_AMT  -- ���꼼���� - ���ݰ�꼭 ��������ݾ�
        , A_TAX_RECEIVE_DELAY_VAT  -- ���꼼���� - ���ݰ�꼭 �������뼼��
        -- 2013�߰� --
        , A_TAX_INV_SUM_BAD_AMT_1  -- ���꼼���� - ���ݰ�꼭 �հ�ǥ ��������(AMT-�ݾ�) 
        , A_TAX_INV_SUM_BAD_VAT_1  -- ���꼼���� - ���ݰ�꼭 �հ�ǥ ��������(VAT-����)
        , A_REPORT_BAD_AMT_1       -- ���꼼���� - �Ű��Ҽ���(AMT-�ݾ�)-���Ű�(�Ϲ�) 
        , A_REPORT_BAD_VAT_1       -- ���꼼���� - �Ű��Ҽ���(VAT-����)-���Ű�(�Ϲ�) 
        , A_REPORT_BAD_AMT_2       -- ���꼼���� - �Ű��Ҽ���(AMT-�ݾ�)-���Ű�(�δ�) 
        , A_REPORT_BAD_VAT_2       -- ���꼼���� - �Ű��Ҽ���(VAT-����)-���Ű�(�δ�)
        , A_REPORT_BAD_AMT_3       -- ���꼼���� - �Ű��Ҽ���(AMT-�ݾ�)-����/�ʰ� ȯ�޽Ű�(�Ϲ�) 
        , A_REPORT_BAD_VAT_3       -- ���꼼���� - �Ű��Ҽ���(VAT-����)-����/�ʰ� ȯ�޽Ű�(�Ϲ�) 
        , A_REPORT_BAD_AMT_4       -- ���꼼���� - �Ű��Ҽ���(AMT-�ݾ�)-����/�ʰ� ȯ�޽Ű�(�δ�)
        , A_REPORT_BAD_VAT_4       -- ���꼼���� - �Ű��Ҽ���(VAT-����)-����/�ʰ� ȯ�޽Ű�(�δ�) 
        , A_REALTY_LEASE_UNREPORT_AMT  -- ���꼼���� - �ε����Ӵ���ް��׸����� �Ҽ���(AMT-�ݾ�) 
        , A_REALTY_LEASE_UNREPORT_VAT  -- ���꼼���� - �ε����Ӵ���ް��׸����� �Ҽ���(VAT-����) 
        
        , NVL(( SELECT SUM(FSC.COL25) AS COL25
                  FROM FI_SURTAX_CARD    FSC
                     , FI_VAT_REPORT_MNG VRM
                 WHERE FSC.TAX_CODE             = VRM.TAX_CODE
                   AND FSC.VAT_MNG_SERIAL       = VRM.VAT_MNG_SERIAL
                   AND FSC.SOB_ID               = VRM.SOB_ID
                   AND FSC.ORG_ID               = VRM.ORG_ID
                   AND FSC.SOB_ID               = SC.SOB_ID
                   AND FSC.ORG_ID               = SC.ORG_ID
                   AND FSC.LAST_FLAG            = 'Y'
                   AND FSC.VAT_LEVIER_GB        IN('2', '3')       -- �Ѱ�����(��),(��) �����  
                   AND 1                        = DECODE(SC.VAT_LEVIER_GB, '2', 1, 2) 
                   AND FSC.VAT_MAKE_GB          = SC.VAT_MAKE_GB 
                   AND EXISTS
                         ( SELECT 'X'
                             FROM FI_VAT_REPORT_MNG RM
                            WHERE RM.SOB_ID            = VRM.SOB_ID
                              AND RM.ORG_ID            = VRM.ORG_ID
                              AND RM.FY                = VRM.FY
                              AND RM.VAT_REPORT_TURN   = VRM.VAT_REPORT_TURN
                              AND RM.VAT_REPORT_GB     = VRM.VAT_REPORT_GB
                              AND RM.TAX_CODE          = SC.TAX_CODE
                              AND RM.VAT_MNG_SERIAL    = SC.VAT_MNG_SERIAL
                         )), 0) AS TOT_REAL_VAT_AMOUNT    -- �Ѱ����λ���� ����(ȯ��)�� ����
        , VAT_LEVIER_GB	    --�Ϲݰ����ڱ���
        , FI_COMMON_G.CODE_NAME_F('VAT_LEVIER_GB', VAT_LEVIER_GB, SOB_ID, ORG_ID) AS VAT_LEVIER_NM          --�Ϲݰ����ڱ���_��                  
        -- 2014.1�� ���� �߰� 
        , COL26_4  -- ����ǥ��1 ������
        , COL27_4  -- ����ǥ��2 ������ 
        , COL28_4  -- ����ǥ��3 ������ 
        , COL29_4  -- ����ǥ��4 ������ 
        , PROXY_PAY_TAX_VAT         -- ���������� �븮���� �ⳳ�μ��� 
        , SPECIAL_PAY_TAX_VAT       -- ������ ����Ư�� �ⳳ�μ��� 
        , E_FORE_TOUR_REFUND_VAT    -- �ܱ��� �������� ���� ȯ�޼��� 
        , A_MISS_DEAL_ACCOUNT_AMT   -- ������ ����Ư�� �ŷ����� �̻�� AMT 
        , A_MISS_DEAL_ACCOUNT_VAT   -- ������ ����Ư�� �ŷ����� �̻�� VAT
        , A_DELAY_PAYMENT_AMT       -- ������ ����Ư�� �ŷ����� �����Ա� AMT 
        , A_DELAY_PAYMENT_VAT       -- ������ ����Ư�� �ŷ����� �����Ա� VAT 
    FROM FI_SURTAX_CARD SC
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND TAX_CODE = W_TAX_CODE
        AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL
        AND VAT_MAKE_GB = W_VAT_MAKE_GB --�Ű�����(01 : ����Ű�, 02:�����Ű�)
    ;


END LIST_SURTAX_CARD;


--�����Ű� ��½� ���� �Ű��� ��ȸ --
PROCEDURE PRINT_SURTAX_CARD_01
          ( P_CURSOR                  OUT TYPES.TCURSOR
          , W_SOB_ID              IN  FI_SURTAX_CARD.SOB_ID%TYPE  --ȸ����̵�
          , W_ORG_ID              IN  FI_SURTAX_CARD.ORG_ID%TYPE  --����ξ��̵�
          , W_TAX_CODE            IN  VARCHAR2                            --�������̵�(��>110)    
          , W_VAT_MNG_SERIAL      IN  FI_SURTAX_CARD.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű��Ⱓ���й�ȣ 
          )
AS
BEGIN
  OPEN P_CURSOR FOR
    SELECT  SOB_ID	        --ȸ����̵�
          , ORG_ID	        --����ξ��̵�
          , TAX_CODE	--�������̵�
          , VAT_MNG_SERIAL	--�ΰ����Ű��Ⱓ���й�ȣ
          , SPEC_SERIAL	    --�Ϸù�ȣ
          
          --����>�����Ű��� ó���� �� �ֵ��� Ʋ�� ����� ���� �۾��� �������� �ʾҴ�.
          , VAT_MAKE_GB	    --�Ű�����(01 : ����Ű�, 02 : �����Ű�)
          
          , GUBUN_1	--�Ű�������_����
          , GUBUN_2	--�Ű�������_Ȯ��
          , GUBUN_3	--�Ű�������_�����İ���ǥ��
          , GUBUN_4	--�Ű�������_������������ȯ��
          
          , TITLE_1_1	--�Ű��Ⱓ_����
          , TITLE_1_2	--�Ű��Ⱓ_����
          , TO_CHAR(TITLE_1_2, 'YYYY') || '  ��   ' ||  
            CASE
              WHEN TO_NUMBER(TO_CHAR(TITLE_1_2, 'MM')) <= 6 THEN '1  ��   ( '
              ELSE '2  ��   ( '
            END
            || TO_CHAR(TITLE_1_1, 'MM') || ' �� ' || TO_CHAR(TITLE_1_1, 'DD')  || ' �� ~ '
            || TO_CHAR(TITLE_1_2, 'MM') || ' �� ' || TO_CHAR(TITLE_1_2, 'DD') || ' �� )'
            AS FISCAL_YEAR   --�Ű��Ⱓ_��¿�    
              
          , TITLE_2	--��ȣ
          , TITLE_3	--����
          
          , TITLE_4	--����ڵ�Ϲ�ȣ
          --��¿� ����ڵ�Ϲ�ȣ
          , SUBSTR(TITLE_4, 1, 1) AS TITLE_4_01
          , SUBSTR(TITLE_4, 2, 1) AS TITLE_4_02
          , SUBSTR(TITLE_4, 3, 1) AS TITLE_4_03
          , SUBSTR(TITLE_4, 5, 1) AS TITLE_4_04
          , SUBSTR(TITLE_4, 6, 1) AS TITLE_4_05
          , SUBSTR(TITLE_4, 8, 1) AS TITLE_4_06
          , SUBSTR(TITLE_4, 9, 1) AS TITLE_4_07
          , SUBSTR(TITLE_4, 10, 1) AS TITLE_4_08
          , SUBSTR(TITLE_4, 11, 1) AS TITLE_4_09
          , SUBSTR(TITLE_4, 12, 1) AS TITLE_4_10
          
          , TITLE_5	--���ε�Ϲ�ȣ
          , TITLE_6	--�������ȭ
          , TITLE_7	--�ּ�����ȭ
          , TITLE_8	--�޴���ȭ
          , TITLE_9	--������ּ�
          , TITLE_10	--���ڿ����ּ�
          , TITLE_11	--����
          , TITLE_12	--����
          
          , TITLE_13	--�����ڵ�
          --��¿� �����ڵ�
          , SUBSTR(TITLE_13, 1, 1) AS TITLE_13_1
          , SUBSTR(TITLE_13, 2, 1) AS TITLE_13_2
          , SUBSTR(TITLE_13, 3, 1) AS TITLE_13_3
          , SUBSTR(TITLE_13, 4, 1) AS TITLE_13_4
          , SUBSTR(TITLE_13, 5, 1) AS TITLE_13_5
          , SUBSTR(TITLE_13, 6, 1) AS TITLE_13_6
          
          , TITLE_14	--�ۼ�����
          , TO_CHAR(TITLE_14, 'YYYY') || ' ��   '
            || TO_NUMBER(TO_CHAR(TITLE_14, 'MM')) || ' ��   ' 
            || TO_NUMBER(TO_CHAR(TITLE_14, 'DD'))  || ' ��'
            AS TITLE_14_PRINT	--��¿� �ۼ�����    
          
          , TITLE_15	--�Ű���
          , TITLE_16	--������
          
          , COL1_1	--����_���ݰ�꼭�߱޺�_�ݾ�
          , COL1_2	--����_���ݰ�꼭�߱޺�_����
          , COL2_1	--����_�����ڹ��༼�ݰ�꼭_�ݾ�
          , COL2_2	--����_�����ڹ��༼�ݰ�꼭_����
          , COL3_1	--����_�ſ�ī��_���ݿ����������_�ݾ�
          , COL3_2	--����_�ſ�ī��_���ݿ����������_����
          , COL4_1	--����_��Ÿ_�ݾ�
          , COL4_2	--����_��Ÿ_����
          , COL5_1	--������_���ݰ�꼭�߱޺�_�ݾ�
          , COL6_1	--������_��Ÿ_�ݾ�
          , COL7_1	--�����Ű�������_�ݾ�
          , COL7_2	--�����Ű�������_����
          , COL8_2	--��ռ��װ���_����
          , COL9_1	--�հ�_�ݾ�
          , COL9_2	--�հ�_����
          , COL10_1	--����_�Ϲݸ���_�ݾ�
          , COL10_2	--����_�Ϲݸ���_����
          , COL11_1	--����_�����ڻ����_�ݾ�
          , COL11_2	--����_�����ڻ����_����
          , COL12_1	--����_�����Ű�������_�ݾ�
          , COL12_2	--����_�����Ű�������_����
          , COL13_1	--����_�����ڹ��༼�ݰ�꼭_�ݾ�
          , COL13_2	--����_�����ڹ��༼�ݰ�꼭_����
          , COL14_1	--����_��Ÿ�������Լ���_�ݾ�
          , COL14_2	--����_��Ÿ�������Լ���_����
          , COL15_1	--����_�հ�_�ݾ�
          , COL15_2	--����_�հ�_����
          , COL16_1	--����_�����������Ҹ��Լ���_�ݾ�
          , COL16_2	--����_�����������Ҹ��Լ���_����
          , COL17_1	--����_������_�ݾ�
          , COL17_2	--����_������_����
          , COL_DA	--���μ���
          , COL18_2	--��Ÿ�氨��������
          , COL19_2	--�ſ�ī�������ǥ����������
          , COL20_2	--�氨����_�հ�
          , COL21_2	--�����Ű���ȯ�޼���
          , COL22_2	--������������
          , COL23_2	--������_������_����Ư��_�ⳳ�μ���
          , COL24_2	--���꼼�װ�
          , COL25	    --�������Ͽ������Ҽ���
          
          , DEAL_BANK	        --�ŷ�����
          , DEAL_BANK_CD	    --�ŷ������ڵ�
          , DEAL_BRANCH	    --�ŷ�����
          , DEAL_BRANCH_ID	--�ŷ������ڵ�
          , ACC_NO	        --���¹�ȣ
          , CLOSURE_DATE	    --�����
          , DECODE(CLOSURE_DATE, NULL, NULL, '', NULL, 
                TO_CHAR(CLOSURE_DATE, 'YYYY') || '�� '
                || TO_NUMBER(TO_CHAR(CLOSURE_DATE, 'MM')) || '��   ' 
                || TO_NUMBER(TO_CHAR(CLOSURE_DATE, 'DD'))  || '��'    
            ) AS CLOSURE_DATE_PRINT	--��¿� �����       
          
          , CLOSURE_REASON	--�������
          
          , COL26_1	--����ǥ��_����1
          , COL26_2	--����ǥ��_����1
          , COL26_3	--����ǥ��_�ݾ�1
          , COL27_1	--����ǥ��_����2
          , COL27_2	--����ǥ��_����2
          , COL27_3	--����ǥ��_�ݾ�2
          , COL28_1	--����ǥ��_����3
          , COL28_2	--����ǥ��_����3
          , COL28_3	--����ǥ��_�ݾ�3
          , COL29_1	--����ǥ��_����4
          , COL29_2	--����ǥ��_����4
          , COL29_3	--����ǥ��_�ݾ�4
          , COL30	    --����ǥ��_�հ�
          
          , COL31_1	--�����Ű�_����_����_���ݰ�꼭_�ݾ�
          , COL31_2	--�����Ű�_����_����_���ݰ�꼭_����
          , COL32_1	--�����Ű�_����_����_��Ÿ_�ݾ�
          , COL32_2	--�����Ű�_����_����_��Ÿ_����
          , COL33_1	--�����Ű�_����_������_���ݰ�꼭
          , COL34_1	--�����Ű�_����_������_��Ÿ
          , COL35_1	--�����Ű�_����_�հ�_�ݾ�
          , COL35_2	--�����Ű�_����_�հ�_����
          , COL36_1	--�����Ű�_����_���ݰ�꼭_�ݾ�
          , COL36_2	--�����Ű�_����_���ݰ�꼭_����
          , COL37_1	--�����Ű�_����_��Ÿ�������Լ���_�ݾ�
          , COL37_2	--�����Ű�_����_��Ÿ�������Լ���_����
          , COL38_1	--�����Ű�_����_�հ�_�ݾ�
          , COL38_2	--�����Ű�_����_�հ�_����
          
          , COL39_1	--��Ÿ����_�ſ�ī��_�Ϲݸ���_�ݾ�
          , COL39_2	--��Ÿ����_�ſ�ī��_�Ϲݸ���_����
          , COL40_1	--��Ÿ����_�ſ�ī��_�����ڻ����_�ݾ�
          , COL40_2	--��Ÿ����_�ſ�ī��_�����ڻ����_����
          , COL41_1	--��Ÿ����_�������Լ���_�ݾ�
          , COL41_2	--��Ÿ����_�������Լ���_����
          , COL42_1	--��Ÿ����_��Ȱ�����ڿ�����Լ���_�ݾ�
          , COL42_2	--��Ÿ����_��Ȱ�����ڿ�����Լ���_����
          , COL43_1	--��Ÿ����_�����������Լ���_�ݾ�
          , COL43_2	--��Ÿ����_�����������Լ���_����
          , COL44_2	--��Ÿ����_���������ȯ���Լ���_����
          , COL45_2	--��Ÿ����_������Լ���_����
          , COL46_2	--��Ÿ����_������ռ���_����
          , COL47_1	--��Ÿ����_�հ�_�ݾ�
          , COL47_2	--��Ÿ����_���_����
          
          , COL48_1	--�����������Ҹ��Լ���_������������_�ݾ�
          , COL48_2	--�����������Ҹ��Լ���_������������_����
          , COL49_1	--�����������Ҹ��Լ���_������Լ��׸鼼_�ݾ�
          , COL49_2	--�����������Ҹ��Լ���_������Լ��׸鼼_����
          , COL50_1	--�����������Ҹ��Լ���_���ó�й�������_�ݾ�
          , COL50_2	--�����������Ҹ��Լ���_���ó�й�������_����
          , COL51_1	--�����������Ҹ��Լ���_�հ�_�ݾ�
          , COL51_2	--�����������Ҹ��Լ���_�հ�_����
          
          , COL52_2	--��Ź�氨��������_���ڽŰ����װ���_����
          , COL53_2	--��Ÿ�氨��������_���ڼ��ݰ�꼭�߱޼��װ���_����
          , COL54_2	--��Ÿ�氨��������_�ýÿ�ۻ���ڰ氨����_����
          , COL55_2	--��Ÿ�氨��������_���ݿ���������ڼ��װ���_����
          , COL56_2	--��Ÿ�氨��������_��Ÿ_����
          , COL57_2	--��Ÿ�氨��������_�հ�_����
          
          , COL58_1	--���꼼����_����ڹ̵�ϵ�_�ݾ�
          , COL58_2	--���꼼����_����ڹ̵�ϵ�_����
          , COL59_1	--���꼼����_�����߱޵�_�ݾ�
          , COL59_2	--���꼼����_�����߱޵�_����
          , COL60_1	--���꼼����_�̹߱޵�_�ݾ�
          , COL60_2	--���꼼����_�̹߱޵�_����
          , COL61_1	--���꼼����_������15������_�ݾ�
          , COL61_2	--���꼼����_������15������_����
          , COL62_1	--���꼼����_�����Ⱓ������15������_�ݾ�
          , COL62_2	--���꼼����_�����Ⱓ������15������_����
          , COL63_1	--���꼼����_���ݰ�꼭�հ�ǥ����Ҽ���_�ݾ�
          , COL63_2	--���꼼����_���ݰ�꼭�հ�ǥ����Ҽ���_����
          , COL64_1	--���꼼����_�Ű��Ҽ���_�ݾ�
          , COL64_2	--���꼼����_�Ű��Ҽ���_����
          , COL65_1	--���꼼����_���κҼ���_�ݾ�
          , COL65_2	--���꼼����_���κҼ���_����
          , COL66_1	--���꼼����_����������ǥ�ؽŰ��Ҽ���_�ݾ�
          , COL66_2	--���꼼����_����������ǥ�ؽŰ��Ҽ���_����
          , COL67_1	--���꼼����_���ݸ���������������_�ݾ�
          , COL67_2	--���꼼����_���ݸ���������������_����
          , COL68_2	--���꼼����_�հ�_����
          
          , COL69_1	--�鼼������Աݾ�_����1
          , COL69_2	--�鼼������Աݾ�_����1
          , COL69_3	--�鼼������Աݾ�_�ݾ�1
          , COL70_1	--�鼼������Աݾ�_����2
          , COL70_2	--�鼼������Աݾ�_����2
          , COL70_3	--�鼼������Աݾ�_�ݾ�2
          , COL71_1	--�鼼������Աݾ�_����3
          , COL71_2	--�鼼������Աݾ�_����3
          , COL71_3	--�鼼������Աݾ�_�ݾ�3
          , COL72	    --�鼼������Աݾ�_�հ�
          
          , COL73	--��꼭�߱ޱݾ�
          , COL74	--��꼭����ݾ�
          
          , R_ORIGIN_PLACE_VAT  -- �氨�������� - ������Ȯ�μ� �߱ް�������
          , A_TAX_RECEIVE_DELAY_AMT  -- ���꼼���� - ���ݰ�꼭 ��������ݾ�
          , A_TAX_RECEIVE_DELAY_VAT  -- ���꼼���� - ���ݰ�꼭 �������뼼��
          -- 2013�߰� --
          , A_TAX_INV_SUM_BAD_AMT_1  -- ���꼼���� - ���ݰ�꼭 �հ�ǥ ��������(AMT-�ݾ�) 
          , A_TAX_INV_SUM_BAD_VAT_1  -- ���꼼���� - ���ݰ�꼭 �հ�ǥ ��������(VAT-����)
          , A_REPORT_BAD_AMT_1       -- ���꼼���� - �Ű��Ҽ���(AMT-�ݾ�)-���Ű�(�Ϲ�) 
          , A_REPORT_BAD_VAT_1       -- ���꼼���� - �Ű��Ҽ���(VAT-����)-���Ű�(�Ϲ�) 
          , A_REPORT_BAD_AMT_2       -- ���꼼���� - �Ű��Ҽ���(AMT-�ݾ�)-���Ű�(�δ�) 
          , A_REPORT_BAD_VAT_2       -- ���꼼���� - �Ű��Ҽ���(VAT-����)-���Ű�(�δ�)
          , A_REPORT_BAD_AMT_3       -- ���꼼���� - �Ű��Ҽ���(AMT-�ݾ�)-����/�ʰ� ȯ�޽Ű�(�Ϲ�) 
          , A_REPORT_BAD_VAT_3       -- ���꼼���� - �Ű��Ҽ���(VAT-����)-����/�ʰ� ȯ�޽Ű�(�Ϲ�) 
          , A_REPORT_BAD_AMT_4       -- ���꼼���� - �Ű��Ҽ���(AMT-�ݾ�)-����/�ʰ� ȯ�޽Ű�(�δ�)
          , A_REPORT_BAD_VAT_4       -- ���꼼���� - �Ű��Ҽ���(VAT-����)-����/�ʰ� ȯ�޽Ű�(�δ�) 
          , A_REALTY_LEASE_UNREPORT_AMT  -- ���꼼���� - �ε����Ӵ���ް��׸����� �Ҽ���(AMT-�ݾ�) 
          , A_REALTY_LEASE_UNREPORT_VAT  -- ���꼼���� - �ε����Ӵ���ް��׸����� �Ҽ���(VAT-����) 
          
          , NVL(( SELECT SUM(FSC.COL25) AS COL25
                  FROM FI_SURTAX_CARD    FSC
                     , FI_VAT_REPORT_MNG VRM
                 WHERE FSC.TAX_CODE             = VRM.TAX_CODE
                   AND FSC.VAT_MNG_SERIAL       = VRM.VAT_MNG_SERIAL
                   AND FSC.SOB_ID               = VRM.SOB_ID
                   AND FSC.ORG_ID               = VRM.ORG_ID
                   AND FSC.SOB_ID               = SC.SOB_ID
                   AND FSC.ORG_ID               = SC.ORG_ID
                   AND FSC.LAST_FLAG            = 'Y'
                   AND FSC.VAT_LEVIER_GB        IN('2', '3')       -- �Ѱ�����(��),(��) �����  
                   AND 1                        = DECODE(SC.VAT_LEVIER_GB, '2', 1, 2) 
                   AND FSC.VAT_MAKE_GB          = SC.VAT_MAKE_GB  
                   AND EXISTS
                         ( SELECT 'X'
                             FROM FI_VAT_REPORT_MNG RM
                            WHERE RM.SOB_ID            = VRM.SOB_ID
                              AND RM.ORG_ID            = VRM.ORG_ID
                              AND RM.FY                = VRM.FY
                              AND RM.VAT_REPORT_TURN   = VRM.VAT_REPORT_TURN
                              AND RM.VAT_REPORT_GB     = VRM.VAT_REPORT_GB
                              AND RM.TAX_CODE          = SC.TAX_CODE
                              AND RM.VAT_MNG_SERIAL    = SC.VAT_MNG_SERIAL
                         )), 0) AS TOT_REAL_VAT_AMOUNT    -- �Ѱ����λ���� ����(ȯ��)�� ����
          , VAT_LEVIER_GB	    --�Ϲݰ����ڱ���
          , FI_COMMON_G.CODE_NAME_F('VAT_LEVIER_GB', VAT_LEVIER_GB, SOB_ID, ORG_ID) AS VAT_LEVIER_NM          --�Ϲݰ����ڱ���_��
          
          -- 2014.1�� ���� �߰� 
          , COL26_4  -- ����ǥ��1 ������
          , COL27_4  -- ����ǥ��2 ������ 
          , COL28_4  -- ����ǥ��3 ������ 
          , COL29_4  -- ����ǥ��4 ������ 
          , PROXY_PAY_TAX_VAT         -- ���������� �븮���� �ⳳ�μ��� 
          , SPECIAL_PAY_TAX_VAT       -- ������ ����Ư�� �ⳳ�μ��� 
          , E_FORE_TOUR_REFUND_VAT    -- �ܱ��� �������� ���� ȯ�޼��� 
          , A_MISS_DEAL_ACCOUNT_AMT   -- ������ ����Ư�� �ŷ����� �̻�� AMT 
          , A_MISS_DEAL_ACCOUNT_VAT   -- ������ ����Ư�� �ŷ����� �̻�� VAT
          , A_DELAY_PAYMENT_AMT       -- ������ ����Ư�� �ŷ����� �����Ա� AMT 
          , A_DELAY_PAYMENT_VAT       -- ������ ����Ư�� �ŷ����� �����Ա� VAT 
    FROM FI_SURTAX_CARD SC
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND TAX_CODE = W_TAX_CODE
        AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL
        AND VAT_MAKE_GB = '01' --�Ű�����(01 : ����Ű�, 02:�����ð�)
    ;
END PRINT_SURTAX_CARD_01;




--UPDATE
PROCEDURE UPDATE_SURTAX_CARD(
      P_SOB_ID              IN  FI_SURTAX_CARD.SOB_ID%TYPE  --ȸ����̵�
    , P_ORG_ID              IN  FI_SURTAX_CARD.ORG_ID%TYPE  --����ξ��̵�
    , P_TAX_CODE            IN  VARCHAR2                            --�������̵�(��>110)    
    , P_VAT_MNG_SERIAL      IN  FI_SURTAX_CARD.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű��Ⱓ���й�ȣ
    , P_SPEC_SERIAL         IN  FI_SURTAX_CARD.SPEC_SERIAL%TYPE         --�Ϸù�ȣ    
    , P_VAT_MAKE_GB	        IN	FI_SURTAX_CARD.VAT_MAKE_GB%TYPE	        --�Ű�����
    
    , P_GUBUN_1	            IN	FI_SURTAX_CARD.GUBUN_1%TYPE	    --�Ű�������_����
    , P_GUBUN_2	            IN	FI_SURTAX_CARD.GUBUN_2%TYPE	    --�Ű�������_Ȯ��
    , P_GUBUN_3	            IN	FI_SURTAX_CARD.GUBUN_3%TYPE	    --�Ű�������_�����İ���ǥ��
    , P_GUBUN_4	            IN	FI_SURTAX_CARD.GUBUN_4%TYPE	    --�Ű�������_������������ȯ��
    , P_TITLE_1_1	          IN	FI_SURTAX_CARD.TITLE_1_1%TYPE	--�Ű��Ⱓ_����
    , P_TITLE_1_2	          IN	FI_SURTAX_CARD.TITLE_1_2%TYPE	--�Ű��Ⱓ_����
    , P_TITLE_2	            IN	FI_SURTAX_CARD.TITLE_2%TYPE	    --��ȣ
    , P_TITLE_3	            IN	FI_SURTAX_CARD.TITLE_3%TYPE	    --����
    , P_TITLE_4	            IN	FI_SURTAX_CARD.TITLE_4%TYPE	    --����ڵ�Ϲ�ȣ
    , P_TITLE_5	            IN	FI_SURTAX_CARD.TITLE_5%TYPE	    --���ε�Ϲ�ȣ
    , P_TITLE_6	            IN	FI_SURTAX_CARD.TITLE_6%TYPE	    --�������ȭ
    , P_TITLE_7	            IN	FI_SURTAX_CARD.TITLE_7%TYPE	    --�ּ�����ȭ
    , P_TITLE_8	            IN	FI_SURTAX_CARD.TITLE_8%TYPE	    --�޴���ȭ
    , P_TITLE_9	            IN	FI_SURTAX_CARD.TITLE_9%TYPE	    --������ּ�
    , P_TITLE_10	          IN	FI_SURTAX_CARD.TITLE_10%TYPE	--���ڿ����ּ�
    , P_TITLE_11	          IN	FI_SURTAX_CARD.TITLE_11%TYPE	--����
    , P_TITLE_12	          IN	FI_SURTAX_CARD.TITLE_12%TYPE	--����
    , P_TITLE_13	          IN	FI_SURTAX_CARD.TITLE_13%TYPE	--�����ڵ�
    , P_TITLE_14	          IN	FI_SURTAX_CARD.TITLE_14%TYPE	--�ۼ�����
    , P_TITLE_15	          IN	FI_SURTAX_CARD.TITLE_15%TYPE	--�Ű���
    , P_TITLE_16	          IN	FI_SURTAX_CARD.TITLE_16%TYPE	--������
    , P_COL1_1	            IN	FI_SURTAX_CARD.COL1_1%TYPE	--����_���ݰ�꼭�߱޺�_�ݾ�
    , P_COL1_2	            IN	FI_SURTAX_CARD.COL1_2%TYPE	--����_���ݰ�꼭�߱޺�_����
    , P_COL2_1	            IN	FI_SURTAX_CARD.COL2_1%TYPE	--����_�����ڹ��༼�ݰ�꼭_�ݾ�
    , P_COL2_2	            IN	FI_SURTAX_CARD.COL2_2%TYPE	--����_�����ڹ��༼�ݰ�꼭_����
    , P_COL3_1	            IN	FI_SURTAX_CARD.COL3_1%TYPE	--����_�ſ�ī��_���ݿ����������_�ݾ�
    , P_COL3_2	            IN	FI_SURTAX_CARD.COL3_2%TYPE	--����_�ſ�ī��_���ݿ����������_����
    , P_COL4_1	            IN	FI_SURTAX_CARD.COL4_1%TYPE	--����_��Ÿ_�ݾ�
    , P_COL4_2	            IN	FI_SURTAX_CARD.COL4_2%TYPE	--����_��Ÿ_����
    , P_COL5_1	            IN	FI_SURTAX_CARD.COL5_1%TYPE	--������_���ݰ�꼭�߱޺�_�ݾ�
    , P_COL6_1	            IN	FI_SURTAX_CARD.COL6_1%TYPE	--������_��Ÿ_�ݾ�
    , P_COL7_1	            IN	FI_SURTAX_CARD.COL7_1%TYPE	--�����Ű�������_�ݾ�
    , P_COL7_2	            IN	FI_SURTAX_CARD.COL7_2%TYPE	--�����Ű�������_����
    , P_COL8_2	            IN	FI_SURTAX_CARD.COL8_2%TYPE	--��ռ��װ���_����
    , P_COL9_1	            IN	FI_SURTAX_CARD.COL9_1%TYPE	--�հ�_�ݾ�
    , P_COL9_2	            IN	FI_SURTAX_CARD.COL9_2%TYPE	--�հ�_����
    , P_COL10_1	            IN	FI_SURTAX_CARD.COL10_1%TYPE	--����_�Ϲݸ���_�ݾ�
    , P_COL10_2	            IN	FI_SURTAX_CARD.COL10_2%TYPE	--����_�Ϲݸ���_����
    , P_COL11_1	            IN	FI_SURTAX_CARD.COL11_1%TYPE	--����_�����ڻ����_�ݾ�
    , P_COL11_2	            IN	FI_SURTAX_CARD.COL11_2%TYPE	--����_�����ڻ����_����
    , P_COL12_1	            IN	FI_SURTAX_CARD.COL12_1%TYPE	--����_�����Ű�������_�ݾ�
    , P_COL12_2	            IN	FI_SURTAX_CARD.COL12_2%TYPE	--����_�����Ű�������_����
    , P_COL13_1	            IN	FI_SURTAX_CARD.COL13_1%TYPE	--����_�����ڹ��༼�ݰ�꼭_�ݾ�
    , P_COL13_2	            IN	FI_SURTAX_CARD.COL13_2%TYPE	--����_�����ڹ��༼�ݰ�꼭_����
    , P_COL14_1	            IN	FI_SURTAX_CARD.COL14_1%TYPE	--����_��Ÿ�������Լ���_�ݾ�
    , P_COL14_2	            IN	FI_SURTAX_CARD.COL14_2%TYPE	--����_��Ÿ�������Լ���_����
    , P_COL15_1	            IN	FI_SURTAX_CARD.COL15_1%TYPE	--����_�հ�_�ݾ�
    , P_COL15_2	            IN	FI_SURTAX_CARD.COL15_2%TYPE	--����_�հ�_����
    , P_COL16_1	            IN	FI_SURTAX_CARD.COL16_1%TYPE	--����_�����������Ҹ��Լ���_�ݾ�
    , P_COL16_2	            IN	FI_SURTAX_CARD.COL16_2%TYPE	--����_�����������Ҹ��Լ���_����
    , P_COL17_1	            IN	FI_SURTAX_CARD.COL17_1%TYPE	--����_������_�ݾ�
    , P_COL17_2	            IN	FI_SURTAX_CARD.COL17_2%TYPE	--����_������_����
    , P_COL_DA	            IN	FI_SURTAX_CARD.COL_DA%TYPE	--���μ���
    , P_COL18_2	            IN	FI_SURTAX_CARD.COL18_2%TYPE	--��Ÿ�氨��������
    , P_COL19_2	            IN	FI_SURTAX_CARD.COL19_2%TYPE	--�ſ�ī�������ǥ����������
    , P_COL20_2	            IN	FI_SURTAX_CARD.COL20_2%TYPE	--�氨����_�հ�
    , P_COL21_2	            IN	FI_SURTAX_CARD.COL21_2%TYPE	--�����Ű���ȯ�޼���
    , P_COL22_2	            IN	FI_SURTAX_CARD.COL22_2%TYPE	--������������
    , P_COL23_2	            IN	FI_SURTAX_CARD.COL23_2%TYPE	--������_������_����Ư��_�ⳳ�μ���
    , P_COL24_2	            IN	FI_SURTAX_CARD.COL24_2%TYPE	--���꼼�װ�
    , P_COL25	              IN	FI_SURTAX_CARD.COL25%TYPE	--�������Ͽ������Ҽ���
    , P_DEAL_BANK	          IN	FI_SURTAX_CARD.DEAL_BANK%TYPE	    --�ŷ�����
    , P_DEAL_BANK_CD	      IN	FI_SURTAX_CARD.DEAL_BANK_CD%TYPE	--�ŷ������ڵ�
    , P_DEAL_BRANCH	        IN	FI_SURTAX_CARD.DEAL_BRANCH%TYPE	    --�ŷ�����
    , P_DEAL_BRANCH_ID	    IN	FI_SURTAX_CARD.DEAL_BRANCH_ID%TYPE	--�ŷ������ڵ�
    , P_ACC_NO	            IN	FI_SURTAX_CARD.ACC_NO%TYPE	        --���¹�ȣ
    , P_CLOSURE_DATE	      IN	FI_SURTAX_CARD.CLOSURE_DATE%TYPE	--�����
    , P_CLOSURE_REASON	    IN	FI_SURTAX_CARD.CLOSURE_REASON%TYPE	--�������
    , P_COL26_1	            IN	FI_SURTAX_CARD.COL26_1%TYPE	--����ǥ��_����1
    , P_COL26_2	            IN	FI_SURTAX_CARD.COL26_2%TYPE	--����ǥ��_����1
    , P_COL26_3	            IN	FI_SURTAX_CARD.COL26_3%TYPE	--����ǥ��_�ݾ�1
    , P_COL27_1	            IN	FI_SURTAX_CARD.COL27_1%TYPE	--����ǥ��_����2
    , P_COL27_2	            IN	FI_SURTAX_CARD.COL27_2%TYPE	--����ǥ��_����2
    , P_COL27_3	            IN	FI_SURTAX_CARD.COL27_3%TYPE	--����ǥ��_�ݾ�2
    , P_COL28_1	            IN	FI_SURTAX_CARD.COL28_1%TYPE	--����ǥ��_����3
    , P_COL28_2	            IN	FI_SURTAX_CARD.COL28_2%TYPE	--����ǥ��_����3
    , P_COL28_3	            IN	FI_SURTAX_CARD.COL28_3%TYPE	--����ǥ��_�ݾ�3
    , P_COL29_1	            IN	FI_SURTAX_CARD.COL29_1%TYPE	--����ǥ��_����4
    , P_COL29_2	            IN	FI_SURTAX_CARD.COL29_2%TYPE	--����ǥ��_����4
    , P_COL29_3	            IN	FI_SURTAX_CARD.COL29_3%TYPE	--����ǥ��_�ݾ�4
    , P_COL30	              IN	FI_SURTAX_CARD.COL30%TYPE	--����ǥ��_�հ�
    , P_COL31_1	            IN	FI_SURTAX_CARD.COL31_1%TYPE	--�����Ű�_����_����_���ݰ�꼭_�ݾ�
    , P_COL31_2	            IN	FI_SURTAX_CARD.COL31_2%TYPE	--�����Ű�_����_����_���ݰ�꼭_����
    , P_COL32_1	            IN	FI_SURTAX_CARD.COL32_1%TYPE	--�����Ű�_����_����_��Ÿ_�ݾ�
    , P_COL32_2	            IN	FI_SURTAX_CARD.COL32_2%TYPE	--�����Ű�_����_����_��Ÿ_����
    , P_COL33_1	            IN	FI_SURTAX_CARD.COL33_1%TYPE	--�����Ű�_����_������_���ݰ�꼭
    , P_COL34_1	            IN	FI_SURTAX_CARD.COL34_1%TYPE	--�����Ű�_����_������_��Ÿ
    , P_COL35_1	            IN	FI_SURTAX_CARD.COL35_1%TYPE	--�����Ű�_����_�հ�_�ݾ�
    , P_COL35_2	            IN	FI_SURTAX_CARD.COL35_2%TYPE	--�����Ű�_����_�հ�_����
    , P_COL36_1	            IN	FI_SURTAX_CARD.COL36_1%TYPE	--�����Ű�_����_���ݰ�꼭_�ݾ�
    , P_COL36_2	            IN	FI_SURTAX_CARD.COL36_2%TYPE	--�����Ű�_����_���ݰ�꼭_����
    , P_COL37_1	            IN	FI_SURTAX_CARD.COL37_1%TYPE	--�����Ű�_����_��Ÿ�������Լ���_�ݾ�
    , P_COL37_2	            IN	FI_SURTAX_CARD.COL37_2%TYPE	--�����Ű�_����_��Ÿ�������Լ���_����
    , P_COL38_1	            IN	FI_SURTAX_CARD.COL38_1%TYPE	--�����Ű�_����_�հ�_�ݾ�
    , P_COL38_2	            IN	FI_SURTAX_CARD.COL38_2%TYPE	--�����Ű�_����_�հ�_����
    , P_COL39_1	            IN	FI_SURTAX_CARD.COL39_1%TYPE	--��Ÿ����_�ſ�ī��_�Ϲݸ���_�ݾ�
    , P_COL39_2	            IN	FI_SURTAX_CARD.COL39_2%TYPE	--��Ÿ����_�ſ�ī��_�Ϲݸ���_����
    , P_COL40_1	            IN	FI_SURTAX_CARD.COL40_1%TYPE	--��Ÿ����_�ſ�ī��_�����ڻ����_�ݾ�
    , P_COL40_2	            IN	FI_SURTAX_CARD.COL40_2%TYPE	--��Ÿ����_�ſ�ī��_�����ڻ����_����
    , P_COL41_1	            IN	FI_SURTAX_CARD.COL41_1%TYPE	--��Ÿ����_�������Լ���_�ݾ�
    , P_COL41_2	            IN	FI_SURTAX_CARD.COL41_2%TYPE	--��Ÿ����_�������Լ���_����
    , P_COL42_1	            IN	FI_SURTAX_CARD.COL42_1%TYPE	--��Ÿ����_��Ȱ�����ڿ�����Լ���_�ݾ�
    , P_COL42_2	            IN	FI_SURTAX_CARD.COL42_2%TYPE	--��Ÿ����_��Ȱ�����ڿ�����Լ���_����
    , P_COL43_1	            IN	FI_SURTAX_CARD.COL43_1%TYPE	--��Ÿ����_�����������Լ���_�ݾ�
    , P_COL43_2	            IN	FI_SURTAX_CARD.COL43_2%TYPE	--��Ÿ����_�����������Լ���_����
    , P_COL44_2	            IN	FI_SURTAX_CARD.COL44_2%TYPE	--��Ÿ����_���������ȯ���Լ���_����
    , P_COL45_2	            IN	FI_SURTAX_CARD.COL45_2%TYPE	--��Ÿ����_������Լ���_����
    , P_COL46_2	            IN	FI_SURTAX_CARD.COL46_2%TYPE	--��Ÿ����_������ռ���_����
    , P_COL47_1	            IN	FI_SURTAX_CARD.COL47_1%TYPE	--��Ÿ����_�հ�_�ݾ�
    , P_COL47_2	            IN	FI_SURTAX_CARD.COL47_2%TYPE	--��Ÿ����_���_����
    , P_COL48_1	            IN	FI_SURTAX_CARD.COL48_1%TYPE	--�����������Ҹ��Լ���_������������_�ݾ�
    , P_COL48_2	            IN	FI_SURTAX_CARD.COL48_2%TYPE	--�����������Ҹ��Լ���_������������_����
    , P_COL49_1	            IN	FI_SURTAX_CARD.COL49_1%TYPE	--�����������Ҹ��Լ���_������Լ��׸鼼_�ݾ�
    , P_COL49_2	            IN	FI_SURTAX_CARD.COL49_2%TYPE	--�����������Ҹ��Լ���_������Լ��׸鼼_����
    , P_COL50_1	            IN	FI_SURTAX_CARD.COL50_1%TYPE	--�����������Ҹ��Լ���_���ó�й�������_�ݾ�
    , P_COL50_2	            IN	FI_SURTAX_CARD.COL50_2%TYPE	--�����������Ҹ��Լ���_���ó�й�������_����
    , P_COL51_1	            IN	FI_SURTAX_CARD.COL51_1%TYPE	--�����������Ҹ��Լ���_�հ�_�ݾ�
    , P_COL51_2	            IN	FI_SURTAX_CARD.COL51_2%TYPE	--�����������Ҹ��Լ���_�հ�_����
    , P_COL52_2	            IN	FI_SURTAX_CARD.COL52_2%TYPE	--��Ź�氨��������_���ڽŰ����װ���_����
    , P_COL53_2	            IN	FI_SURTAX_CARD.COL53_2%TYPE	--��Ÿ�氨��������_���ڼ��ݰ�꼭�߱޼��װ���_����
    , P_COL54_2	            IN	FI_SURTAX_CARD.COL54_2%TYPE	--��Ÿ�氨��������_�ýÿ�ۻ���ڰ氨����_����
    , P_COL55_2	            IN	FI_SURTAX_CARD.COL55_2%TYPE	--��Ÿ�氨��������_���ݿ���������ڼ��װ���_����
    , P_COL56_2	            IN	FI_SURTAX_CARD.COL56_2%TYPE	--��Ÿ�氨��������_��Ÿ_����
    , P_COL57_2	            IN	FI_SURTAX_CARD.COL57_2%TYPE	--��Ÿ�氨��������_�հ�_����
    , P_COL58_1	            IN	FI_SURTAX_CARD.COL58_1%TYPE	--���꼼����_����ڹ̵�ϵ�_�ݾ�
    , P_COL58_2	            IN	FI_SURTAX_CARD.COL58_2%TYPE	--���꼼����_����ڹ̵�ϵ�_����
    , P_COL59_1 	          IN	FI_SURTAX_CARD.COL59_1%TYPE	--���꼼����_�����߱޵�_�ݾ�
    , P_COL59_2	            IN	FI_SURTAX_CARD.COL59_2%TYPE	--���꼼����_�����߱޵�_����
    , P_COL60_1	            IN	FI_SURTAX_CARD.COL60_1%TYPE	--���꼼����_�̹߱޵�_�ݾ�
    , P_COL60_2	            IN	FI_SURTAX_CARD.COL60_2%TYPE	--���꼼����_�̹߱޵�_����
    , P_COL61_1	            IN	FI_SURTAX_CARD.COL61_1%TYPE	--���꼼����_������15������_�ݾ�
    , P_COL61_2	            IN	FI_SURTAX_CARD.COL61_2%TYPE	--���꼼����_������15������_����
    , P_COL62_1	            IN	FI_SURTAX_CARD.COL62_1%TYPE	--���꼼����_�����Ⱓ������15������_�ݾ�
    , P_COL62_2	            IN	FI_SURTAX_CARD.COL62_2%TYPE	--���꼼����_�����Ⱓ������15������_����
    , P_COL63_1	            IN	FI_SURTAX_CARD.COL63_1%TYPE	--���꼼����_���ݰ�꼭�հ�ǥ����Ҽ���_�ݾ�
    , P_COL63_2	            IN	FI_SURTAX_CARD.COL63_2%TYPE	--���꼼����_���ݰ�꼭�հ�ǥ����Ҽ���_����
    , P_COL64_1	            IN	FI_SURTAX_CARD.COL64_1%TYPE	--���꼼����_�Ű��Ҽ���_�ݾ�
    , P_COL64_2	            IN	FI_SURTAX_CARD.COL64_2%TYPE	--���꼼����_�Ű��Ҽ���_����
    , P_COL65_1	            IN	FI_SURTAX_CARD.COL65_1%TYPE	--���꼼����_���κҼ���_�ݾ�
    , P_COL65_2	            IN	FI_SURTAX_CARD.COL65_2%TYPE	--���꼼����_���κҼ���_����
    , P_COL66_1	            IN	FI_SURTAX_CARD.COL66_1%TYPE	--���꼼����_����������ǥ�ؽŰ��Ҽ���_�ݾ�
    , P_COL66_2	            IN	FI_SURTAX_CARD.COL66_2%TYPE	--���꼼����_����������ǥ�ؽŰ��Ҽ���_����
    , P_COL67_1	            IN	FI_SURTAX_CARD.COL67_1%TYPE	--���꼼����_���ݸ���������������_�ݾ�
    , P_COL67_2	            IN	FI_SURTAX_CARD.COL67_2%TYPE	--���꼼����_���ݸ���������������_����
    , P_COL68_2	            IN	FI_SURTAX_CARD.COL68_2%TYPE	--���꼼����_�հ�_����
    , P_COL69_1	            IN	FI_SURTAX_CARD.COL69_1%TYPE	--�鼼������Աݾ�_����1
    , P_COL69_2	            IN	FI_SURTAX_CARD.COL69_2%TYPE	--�鼼������Աݾ�_����1
    , P_COL69_3	            IN	FI_SURTAX_CARD.COL69_3%TYPE	--�鼼������Աݾ�_�ݾ�1
    , P_COL70_1	            IN	FI_SURTAX_CARD.COL70_1%TYPE	--�鼼������Աݾ�_����2
    , P_COL70_2	            IN	FI_SURTAX_CARD.COL70_2%TYPE	--�鼼������Աݾ�_����2
    , P_COL70_3	            IN	FI_SURTAX_CARD.COL70_3%TYPE	--�鼼������Աݾ�_�ݾ�2
    , P_COL71_1	            IN	FI_SURTAX_CARD.COL71_1%TYPE	--�鼼������Աݾ�_����3
    , P_COL71_2	            IN	FI_SURTAX_CARD.COL71_2%TYPE	--�鼼������Աݾ�_����3
    , P_COL71_3	            IN	FI_SURTAX_CARD.COL71_3%TYPE	--�鼼������Աݾ�_�ݾ�3
    , P_COL72	              IN	FI_SURTAX_CARD.COL72%TYPE	--�鼼������Աݾ�_�հ�
    , P_COL73	              IN	FI_SURTAX_CARD.COL73%TYPE	--��꼭�߱ޱݾ�
    , P_COL74	              IN	FI_SURTAX_CARD.COL74%TYPE	--��꼭����ݾ�
    
    , P_R_ORIGIN_PLACE_VAT      IN  FI_SURTAX_CARD.R_ORIGIN_PLACE_VAT%TYPE  -- ������Ȯ�μ� �߱ް�������.
    , P_A_TAX_RECEIVE_DELAY_AMT IN FI_SURTAX_CARD.A_TAX_RECEIVE_DELAY_AMT%TYPE  -- ���ݰ�꼭��������ݾ�.
    , P_A_TAX_RECEIVE_DELAY_VAT IN FI_SURTAX_CARD.A_TAX_RECEIVE_DELAY_VAT%TYPE  -- ���ݰ�꼭�������뼼��.
    
    , P_LAST_UPDATED_BY         IN  FI_SURTAX_CARD.LAST_UPDATED_BY%TYPE     --������
    -- 2013�� 1�� ���� �߰� -- 
    , P_A_TAX_INV_SUM_BAD_AMT_1   IN FI_SURTAX_CARD.A_TAX_INV_SUM_BAD_AMT_1%TYPE
    , P_A_TAX_INV_SUM_BAD_VAT_1   IN FI_SURTAX_CARD.A_TAX_INV_SUM_BAD_VAT_1%TYPE
    , P_A_REPORT_BAD_AMT_1        IN FI_SURTAX_CARD.A_REPORT_BAD_AMT_1%TYPE
    , P_A_REPORT_BAD_VAT_1        IN FI_SURTAX_CARD.A_REPORT_BAD_VAT_1%TYPE
    , P_A_REPORT_BAD_AMT_2        IN FI_SURTAX_CARD.A_REPORT_BAD_AMT_2%TYPE
    , P_A_REPORT_BAD_VAT_2        IN FI_SURTAX_CARD.A_REPORT_BAD_VAT_2%TYPE
    , P_A_REPORT_BAD_AMT_3        IN FI_SURTAX_CARD.A_REPORT_BAD_AMT_3%TYPE
    , P_A_REPORT_BAD_VAT_3        IN FI_SURTAX_CARD.A_REPORT_BAD_VAT_3%TYPE
    , P_A_REPORT_BAD_AMT_4        IN FI_SURTAX_CARD.A_REPORT_BAD_AMT_4%TYPE
    , P_A_REPORT_BAD_VAT_4        IN FI_SURTAX_CARD.A_REPORT_BAD_VAT_4%TYPE
    , P_A_REALTY_LEASE_UNREPORT_AMT  IN FI_SURTAX_CARD.A_REALTY_LEASE_UNREPORT_AMT%TYPE
    , P_A_REALTY_LEASE_UNREPORT_VAT  IN FI_SURTAX_CARD.A_REALTY_LEASE_UNREPORT_VAT%TYPE
    -- 2014.1�� ���� �߰�                 
    , P_COL26_4                    IN FI_SURTAX_CARD.COL26_4%TYPE  
    , P_COL27_4                    IN FI_SURTAX_CARD.COL27_4%TYPE
    , P_COL28_4                    IN FI_SURTAX_CARD.COL28_4%TYPE
    , P_COL29_4                    IN FI_SURTAX_CARD.COL29_4%TYPE
    , P_PROXY_PAY_TAX_VAT          IN FI_SURTAX_CARD.PROXY_PAY_TAX_VAT %TYPE
    , P_SPECIAL_PAY_TAX_VAT        IN FI_SURTAX_CARD.SPECIAL_PAY_TAX_VAT %TYPE
    , P_E_FORE_TOUR_REFUND_VAT     IN FI_SURTAX_CARD.E_FORE_TOUR_REFUND_VAT %TYPE
    , P_A_MISS_DEAL_ACCOUNT_AMT    IN FI_SURTAX_CARD.A_MISS_DEAL_ACCOUNT_AMT %TYPE
    , P_A_MISS_DEAL_ACCOUNT_VAT    IN FI_SURTAX_CARD.A_MISS_DEAL_ACCOUNT_VAT %TYPE
    , P_A_DELAY_PAYMENT_AMT        IN FI_SURTAX_CARD.A_DELAY_PAYMENT_AMT %TYPE
    , P_A_DELAY_PAYMENT_VAT        IN FI_SURTAX_CARD.A_DELAY_PAYMENT_VAT %TYPE
)

AS

V_SYSDATE                   DATE := GET_LOCAL_DATE(P_SOB_ID);
BEGIN
    UPDATE FI_SURTAX_CARD
    SET
          GUBUN_1	= P_GUBUN_1	    --�Ű�������_����
        , GUBUN_2	= P_GUBUN_2	    --�Ű�������_Ȯ��
        , GUBUN_3	= P_GUBUN_3	    --�Ű�������_�����İ���ǥ��
        , GUBUN_4	= P_GUBUN_4	    --�Ű�������_������������ȯ��
        , TITLE_1_1	= P_TITLE_1_1	--�Ű��Ⱓ_����
        , TITLE_1_2	= P_TITLE_1_2	--�Ű��Ⱓ_����
        , TITLE_2	= P_TITLE_2	    --��ȣ
        , TITLE_3	= P_TITLE_3	    --����
        , TITLE_4	= P_TITLE_4	    --����ڵ�Ϲ�ȣ
        , TITLE_5	= P_TITLE_5	    --���ε�Ϲ�ȣ
        , TITLE_6	= P_TITLE_6	    --�������ȭ
        , TITLE_7	= P_TITLE_7	    --�ּ�����ȭ
        , TITLE_8	= P_TITLE_8	    --�޴���ȭ
        , TITLE_9	= P_TITLE_9	    --������ּ�
        , TITLE_10	= P_TITLE_10	--���ڿ����ּ�
        , TITLE_11	= P_TITLE_11	--����
        , TITLE_12	= P_TITLE_12	--����
        , TITLE_13	= P_TITLE_13	--�����ڵ�
        , TITLE_14	= P_TITLE_14	--�ۼ�����
        , TITLE_15	= P_TITLE_15	--�Ű���
        , TITLE_16	= P_TITLE_16	--������
        , COL1_1	= P_COL1_1	--����_���ݰ�꼭�߱޺�_�ݾ�
        , COL1_2	= P_COL1_2	--����_���ݰ�꼭�߱޺�_����
        , COL2_1	= P_COL2_1	--����_�����ڹ��༼�ݰ�꼭_�ݾ�
        , COL2_2	= P_COL2_2	--����_�����ڹ��༼�ݰ�꼭_����
        , COL3_1	= P_COL3_1	--����_�ſ�ī��_���ݿ����������_�ݾ�
        , COL3_2	= P_COL3_2	--����_�ſ�ī��_���ݿ����������_����
        , COL4_1	= P_COL4_1	--����_��Ÿ_�ݾ�
        , COL4_2	= P_COL4_2	--����_��Ÿ_����
        , COL5_1	= P_COL5_1	--������_���ݰ�꼭�߱޺�_�ݾ�
        , COL6_1	= P_COL6_1	--������_��Ÿ_�ݾ�
        , COL7_1	= P_COL7_1	--�����Ű�������_�ݾ�
        , COL7_2	= P_COL7_2	--�����Ű�������_����
        , COL8_2	= P_COL8_2	--��ռ��װ���_����
        , COL9_1	= P_COL9_1	--�հ�_�ݾ�
        , COL9_2	= P_COL9_2	--�հ�_����
        , COL10_1	= P_COL10_1	--����_�Ϲݸ���_�ݾ�
        , COL10_2	= P_COL10_2	--����_�Ϲݸ���_����
        , COL11_1	= P_COL11_1	--����_�����ڻ����_�ݾ�
        , COL11_2	= P_COL11_2	--����_�����ڻ����_����
        , COL12_1	= P_COL12_1	--����_�����Ű�������_�ݾ�
        , COL12_2	= P_COL12_2	--����_�����Ű�������_����
        , COL13_1	= P_COL13_1	--����_�����ڹ��༼�ݰ�꼭_�ݾ�
        , COL13_2	= P_COL13_2	--����_�����ڹ��༼�ݰ�꼭_����
        , COL14_1	= P_COL14_1	--����_��Ÿ�������Լ���_�ݾ�
        , COL14_2	= P_COL14_2	--����_��Ÿ�������Լ���_����
        , COL15_1	= P_COL15_1	--����_�հ�_�ݾ�
        , COL15_2	= P_COL15_2	--����_�հ�_����
        , COL16_1	= P_COL16_1	--����_�����������Ҹ��Լ���_�ݾ�
        , COL16_2	= P_COL16_2	--����_�����������Ҹ��Լ���_����
        , COL17_1	= P_COL17_1	--����_������_�ݾ�
        , COL17_2	= P_COL17_2	--����_������_����
        , COL_DA	= P_COL_DA	--���μ���
        , COL18_2	= P_COL18_2	--��Ÿ�氨��������
        , COL19_2	= P_COL19_2	--�ſ�ī�������ǥ����������
        , COL20_2	= P_COL20_2	--�氨����_�հ�
        , COL21_2	= P_COL21_2	--�����Ű���ȯ�޼���
        , COL22_2	= P_COL22_2	--������������
        , COL23_2	= P_COL23_2	--������_������_����Ư��_�ⳳ�μ���
        , COL24_2	= P_COL24_2	--���꼼�װ�
        , COL25	    = P_COL25	--�������Ͽ������Ҽ���
        , DEAL_BANK	        = P_DEAL_BANK	    --�ŷ�����
        , DEAL_BANK_CD	    = P_DEAL_BANK_CD	--�ŷ������ڵ�
        , DEAL_BRANCH	    = P_DEAL_BRANCH	    --�ŷ�����
        , DEAL_BRANCH_ID	= P_DEAL_BRANCH_ID	--�ŷ������ڵ�
        , ACC_NO	        = P_ACC_NO	        --���¹�ȣ
        , CLOSURE_DATE	    = P_CLOSURE_DATE	--�����
        , CLOSURE_REASON	= P_CLOSURE_REASON	--�������
        
        , COL26_1	= P_COL26_1	--����ǥ��_����1
        , COL26_2	= P_COL26_2	--����ǥ��_����1
        , COL26_3	= P_COL26_3	--����ǥ��_�ݾ�1
        , COL27_1	= P_COL27_1	--����ǥ��_����2
        , COL27_2	= P_COL27_2	--����ǥ��_����2
        , COL27_3	= P_COL27_3	--����ǥ��_�ݾ�2
        , COL28_1	= P_COL28_1	--����ǥ��_����3
        , COL28_2	= P_COL28_2	--����ǥ��_����3
        , COL28_3	= P_COL28_3	--����ǥ��_�ݾ�3
        , COL29_1	= P_COL29_1	--����ǥ��_����4
        , COL29_2	= P_COL29_2	--����ǥ��_����4
        , COL29_3	= P_COL29_3	--����ǥ��_�ݾ�4
        , COL30	    = P_COL30	--����ǥ��_�հ�
        , COL31_1	= P_COL31_1	--�����Ű�_����_����_���ݰ�꼭_�ݾ�
        , COL31_2	= P_COL31_2	--�����Ű�_����_����_���ݰ�꼭_����
        , COL32_1	= P_COL32_1	--�����Ű�_����_����_��Ÿ_�ݾ�
        , COL32_2	= P_COL32_2	--�����Ű�_����_����_��Ÿ_����
        , COL33_1	= P_COL33_1	--�����Ű�_����_������_���ݰ�꼭
        , COL34_1	= P_COL34_1	--�����Ű�_����_������_��Ÿ
        , COL35_1	= P_COL35_1	--�����Ű�_����_�հ�_�ݾ�
        , COL35_2	= P_COL35_2	--�����Ű�_����_�հ�_����
        , COL36_1	= P_COL36_1	--�����Ű�_����_���ݰ�꼭_�ݾ�
        , COL36_2	= P_COL36_2	--�����Ű�_����_���ݰ�꼭_����
        , COL37_1	= P_COL37_1	--�����Ű�_����_��Ÿ�������Լ���_�ݾ�
        , COL37_2	= P_COL37_2	--�����Ű�_����_��Ÿ�������Լ���_����
        , COL38_1	= P_COL38_1	--�����Ű�_����_�հ�_�ݾ�
        , COL38_2	= P_COL38_2	--�����Ű�_����_�հ�_����
        , COL39_1	= P_COL39_1	--��Ÿ����_�ſ�ī��_�Ϲݸ���_�ݾ�
        , COL39_2	= P_COL39_2	--��Ÿ����_�ſ�ī��_�Ϲݸ���_����
        , COL40_1	= P_COL40_1	--��Ÿ����_�ſ�ī��_�����ڻ����_�ݾ�
        , COL40_2	= P_COL40_2	--��Ÿ����_�ſ�ī��_�����ڻ����_����
        , COL41_1	= P_COL41_1	--��Ÿ����_�������Լ���_�ݾ�
        , COL41_2	= P_COL41_2	--��Ÿ����_�������Լ���_����
        , COL42_1	= P_COL42_1	--��Ÿ����_��Ȱ�����ڿ�����Լ���_�ݾ�
        , COL42_2	= P_COL42_2	--��Ÿ����_��Ȱ�����ڿ�����Լ���_����
        , COL43_1	= P_COL43_1	--��Ÿ����_�����������Լ���_�ݾ�
        , COL43_2	= P_COL43_2	--��Ÿ����_�����������Լ���_����
        , COL44_2	= P_COL44_2	--��Ÿ����_���������ȯ���Լ���_����
        , COL45_2	= P_COL45_2	--��Ÿ����_������Լ���_����
        , COL46_2	= P_COL46_2	--��Ÿ����_������ռ���_����
        , COL47_1	= P_COL47_1	--��Ÿ����_�հ�_�ݾ�
        , COL47_2	= P_COL47_2	--��Ÿ����_���_����
        , COL48_1	= P_COL48_1	--�����������Ҹ��Լ���_������������_�ݾ�
        , COL48_2	= P_COL48_2	--�����������Ҹ��Լ���_������������_����
        , COL49_1	= P_COL49_1	--�����������Ҹ��Լ���_������Լ��׸鼼_�ݾ�
        , COL49_2	= P_COL49_2	--�����������Ҹ��Լ���_������Լ��׸鼼_����
        , COL50_1	= P_COL50_1	--�����������Ҹ��Լ���_���ó�й�������_�ݾ�
        , COL50_2	= P_COL50_2	--�����������Ҹ��Լ���_���ó�й�������_����
        , COL51_1	= P_COL51_1	--�����������Ҹ��Լ���_�հ�_�ݾ�
        , COL51_2	= P_COL51_2	--�����������Ҹ��Լ���_�հ�_����
        , COL52_2	= P_COL52_2	--��Ź�氨��������_���ڽŰ����װ���_����
        , COL53_2	= P_COL53_2	--��Ÿ�氨��������_���ڼ��ݰ�꼭�߱޼��װ���_����
        , COL54_2	= P_COL54_2	--��Ÿ�氨��������_�ýÿ�ۻ���ڰ氨����_����
        , COL55_2	= P_COL55_2	--��Ÿ�氨��������_���ݿ���������ڼ��װ���_����
        , COL56_2	= P_COL56_2	--��Ÿ�氨��������_��Ÿ_����
        , COL57_2	= P_COL57_2	--��Ÿ�氨��������_�հ�_����
        , COL58_1	= P_COL58_1	--���꼼����_����ڹ̵�ϵ�_�ݾ�
        , COL58_2	= P_COL58_2	--���꼼����_����ڹ̵�ϵ�_����
        , COL59_1	= P_COL59_1	--���꼼����_�����߱޵�_�ݾ�
        , COL59_2	= P_COL59_2	--���꼼����_�����߱޵�_����
        , COL60_1	= P_COL60_1	--���꼼����_�̹߱޵�_�ݾ�
        , COL60_2	= P_COL60_2	--���꼼����_�̹߱޵�_����
        , COL61_1	= P_COL61_1	--���꼼����_������15������_�ݾ�
        , COL61_2	= P_COL61_2	--���꼼����_������15������_����
        , COL62_1	= P_COL62_1	--���꼼����_�����Ⱓ������15������_�ݾ�
        , COL62_2	= P_COL62_2	--���꼼����_�����Ⱓ������15������_����
        , COL63_1	= P_COL63_1	--���꼼����_���ݰ�꼭�հ�ǥ����Ҽ���_�ݾ�
        , COL63_2	= P_COL63_2	--���꼼����_���ݰ�꼭�հ�ǥ����Ҽ���_����
        , COL64_1	= (NVL(P_A_REPORT_BAD_AMT_1, 0) + NVL(P_A_REPORT_BAD_AMT_2, 0) + 
                     NVL(P_A_REPORT_BAD_AMT_3, 0) + NVL(P_A_REPORT_BAD_AMT_4, 0)) -- P_COL64_1	--���꼼����_�Ű��Ҽ���_�ݾ� �հ�
        , COL64_2	= (NVL(P_A_REPORT_BAD_VAT_1, 0) + NVL(P_A_REPORT_BAD_VAT_2, 0) + 
                     NVL(P_A_REPORT_BAD_VAT_3, 0) + NVL(P_A_REPORT_BAD_VAT_4, 0))  -- P_COL64_2	--���꼼����_�Ű��Ҽ���_���� �հ� 
        , COL65_1	= P_COL65_1	--���꼼����_���κҼ���_�ݾ�
        , COL65_2	= P_COL65_2	--���꼼����_���κҼ���_����
        , COL66_1	= P_COL66_1	--���꼼����_����������ǥ�ؽŰ��Ҽ���_�ݾ�
        , COL66_2	= P_COL66_2	--���꼼����_����������ǥ�ؽŰ��Ҽ���_����
        , COL67_1	= P_COL67_1	--���꼼����_���ݸ���������������_�ݾ�
        , COL67_2	= P_COL67_2	--���꼼����_���ݸ���������������_����
        , COL68_2	= P_COL68_2	--���꼼����_�հ�_����
        , COL69_1	= P_COL69_1	--�鼼������Աݾ�_����1
        , COL69_2	= P_COL69_2	--�鼼������Աݾ�_����1
        , COL69_3	= P_COL69_3	--�鼼������Աݾ�_�ݾ�1
        , COL70_1	= P_COL70_1	--�鼼������Աݾ�_����2
        , COL70_2	= P_COL70_2	--�鼼������Աݾ�_����2
        , COL70_3	= P_COL70_3	--�鼼������Աݾ�_�ݾ�2
        , COL71_1	= P_COL71_1	--�鼼������Աݾ�_����3
        , COL71_2	= P_COL71_2	--�鼼������Աݾ�_����3
        , COL71_3	= P_COL71_3	--�鼼������Աݾ�_�ݾ�3
        , COL72	    = P_COL72	--�鼼������Աݾ�_�հ�
        , COL73	    = P_COL73	--��꼭�߱ޱݾ�
        , COL74	    = P_COL74	--��꼭����ݾ�
        
        , R_ORIGIN_PLACE_VAT       = P_R_ORIGIN_PLACE_VAT  -- ������Ȯ�μ� �߱ް�������.
        , A_TAX_RECEIVE_DELAY_AMT  = P_A_TAX_RECEIVE_DELAY_AMT  -- ���ݰ�꼭��������ݾ�.
        , A_TAX_RECEIVE_DELAY_VAT  = P_A_TAX_RECEIVE_DELAY_VAT  -- ���ݰ�꼭�������뼼��.
        
        , LAST_UPDATE_DATE           = V_SYSDATE         --������
        , LAST_UPDATED_BY            = P_LAST_UPDATED_BY --������
        
        -- 2013�� 1�� ���� �߰� -- 
        , A_TAX_INV_SUM_BAD_AMT_1	    = NVL(P_A_TAX_INV_SUM_BAD_AMT_1, 0)	   
        , A_TAX_INV_SUM_BAD_VAT_1	    = NVL(P_A_TAX_INV_SUM_BAD_VAT_1, 0)	   
        , A_REPORT_BAD_AMT_1	        = NVL(P_A_REPORT_BAD_AMT_1, 0)	       
        , A_REPORT_BAD_VAT_1	        = NVL(P_A_REPORT_BAD_VAT_1, 0)	       
        , A_REPORT_BAD_AMT_2	        = NVL(P_A_REPORT_BAD_AMT_2, 0)	       
        , A_REPORT_BAD_VAT_2	        = NVL(P_A_REPORT_BAD_VAT_2, 0)	       
        , A_REPORT_BAD_AMT_3	        = NVL(P_A_REPORT_BAD_AMT_3, 0)	       
        , A_REPORT_BAD_VAT_3	        = NVL(P_A_REPORT_BAD_VAT_3, 0)	
        , A_REPORT_BAD_AMT_4	        = NVL(P_A_REPORT_BAD_AMT_4, 0)	       
        , A_REPORT_BAD_VAT_4	        = NVL(P_A_REPORT_BAD_VAT_4, 0)       
        , A_REALTY_LEASE_UNREPORT_AMT = NVL(P_A_REALTY_LEASE_UNREPORT_AMT, 0)
        , A_REALTY_LEASE_UNREPORT_VAT = NVL(P_A_REALTY_LEASE_UNREPORT_VAT, 0)	
        -- 2014.1�� ���� �߰� 
        , COL26_4                     = P_COL26_4  
        , COL27_4                     = P_COL27_4
        , COL28_4                     = P_COL28_4
        , COL29_4                     = P_COL29_4
        , PROXY_PAY_TAX_VAT           = NVL(P_PROXY_PAY_TAX_VAT, 0) 
        , SPECIAL_PAY_TAX_VAT         = NVL(P_SPECIAL_PAY_TAX_VAT, 0) 
        , E_FORE_TOUR_REFUND_VAT      = NVL(P_E_FORE_TOUR_REFUND_VAT, 0) 
        , A_MISS_DEAL_ACCOUNT_AMT     = NVL(P_A_MISS_DEAL_ACCOUNT_AMT, 0) 
        , A_MISS_DEAL_ACCOUNT_VAT     = NVL(P_A_MISS_DEAL_ACCOUNT_VAT, 0) 
        , A_DELAY_PAYMENT_AMT         = NVL(P_A_DELAY_PAYMENT_AMT, 0) 
        , A_DELAY_PAYMENT_VAT         = NVL(P_A_DELAY_PAYMENT_VAT, 0) 
    WHERE   SOB_ID                  = P_SOB_ID                  --ȸ����̵�
        AND ORG_ID                  = P_ORG_ID                  --����ξ��̵�
        AND TAX_CODE                = P_TAX_CODE       --�������̵�        
        AND VAT_MNG_SERIAL          = P_VAT_MNG_SERIAL          --�ΰ����Ű��Ⱓ���й�ȣ               
        AND SPEC_SERIAL             = P_SPEC_SERIAL             --�Ϸù�ȣ 
    ;

END UPDATE_SURTAX_CARD;









--�ŷ����� POPUP
PROCEDURE POPUP_BANK(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_BANK.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID              IN  FI_BANK.ORG_ID%TYPE  --����ξ��̵�
)

AS

BEGIN

    OPEN P_CURSOR FOR    
    
    SELECT 
          BANK_GROUP    --����/���������� �� �����
        , BANK_CODE     --�����ڵ�
        , BANK_NAME     --�����
    FROM FI_BANK
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND ENABLED_FLAG = 'Y'
        AND BANK_GROUP = '-'    ;   

END POPUP_BANK;







--�ŷ��������� POPUP
PROCEDURE POPUP_BANK_BRANCH(
      P_CURSOR      OUT TYPES.TCURSOR
    , W_SOB_ID      IN  FI_BANK.SOB_ID%TYPE     --ȸ����̵�
    , W_ORG_ID      IN  FI_BANK.ORG_ID%TYPE     --����ξ��̵�
    , W_BANK_CODE   IN  FI_BANK.BANK_CODE%TYPE  --��������ڵ�
)

AS

BEGIN

    OPEN P_CURSOR FOR    
    
    SELECT 
          BANK_ID   --���̵�
        , BANK_CODE --�ڵ�
        , ( --������ �����
            SELECT BANK_NAME 
            FROM FI_BANK
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND BANK_GROUP = '-'
                AND BANK_CODE = W_BANK_CODE    
          ) AS BANK_NAME    --�����
        , BANK_NAME AS BANK_BRANCH  --������
    FROM FI_BANK
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND ENABLED_FLAG = 'Y'
        AND BANK_GROUP = W_BANK_CODE  ;   

END POPUP_BANK_BRANCH;







--���¹�ȣ POPUP
PROCEDURE POPUP_ACCOUNT_NO(
      P_CURSOR      OUT TYPES.TCURSOR
    , W_SOB_ID      IN  FI_BANK.SOB_ID%TYPE       --ȸ����̵�
    , W_ORG_ID      IN  FI_BANK.ORG_ID%TYPE       --����ξ��̵�
    , W_BANK_CODE   IN  FI_BANK.BANK_CODE%TYPE    --��������ڵ�
    , W_BANK_ID     IN  FI_BANK.BANK_ID%TYPE      --����������̵�
)

AS

BEGIN

    OPEN P_CURSOR FOR    
        
    SELECT
         ( --������ �����
            SELECT BANK_NAME 
            FROM FI_BANK
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND BANK_GROUP = '-'
                AND BANK_CODE = W_BANK_CODE
          ) AS BANK_NAME    --�����
        , BANK_ACCOUNT_NAME --���¸�
        , BANK_ACCOUNT_NUM  --���¹�ȣ
        , ACCOUNT_TYPE  --���±����ڵ�
        , FI_COMMON_G.CODE_NAME_F('ACCOUNT_TYPE', ACCOUNT_TYPE, SOB_ID, ORG_ID) AS VAT_REASON_NAME    --���±���
    FROM FI_BANK_ACCOUNT
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND ENABLED_FLAG = 'Y'
        AND BANK_ID = W_BANK_ID    ;  

END POPUP_ACCOUNT_NO;




   PROCEDURE ROUND_TAX
           ( O_NUMBER  OUT  NUMBER
           , P_NUMBER  IN   NUMBER
           )

   AS

   BEGIN

         O_NUMBER := ROUND(P_NUMBER);

   EXCEPTION WHEN OTHERS THEN
             O_NUMBER := 0;

   END ROUND_TAX;


-- ���� �Ű� ���� -- 
PROCEDURE LU_SELECT_MODIFY_DEGREE
          ( P_CURSOR1             OUT TYPES.TCURSOR1
          , W_SOB_ID              IN  FI_SURTAX_CARD.SOB_ID%TYPE  --ȸ����̵�
          , W_ORG_ID              IN  FI_SURTAX_CARD.ORG_ID%TYPE  --����ξ��̵�
          , W_TAX_CODE            IN  VARCHAR2                            --�������̵�(��>110)    
          , W_VAT_MNG_SERIAL      IN  FI_SURTAX_CARD.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű��Ⱓ���й�ȣ
          , W_VAT_MAKE_GB         IN  FI_SURTAX_CARD.VAT_MAKE_GB%TYPE DEFAULT '01'    --�Ű�����(01 : ����Ű�)
          )
AS
BEGIN
  OPEN P_CURSOR1 FOR
    SELECT SC.MODIFY_DESC
         , SC.MODIFY_DEGREE
      FROM FI_SURTAX_CARD SC
    WHERE SC.SOB_ID             = W_SOB_ID
        AND SC.ORG_ID           = W_ORG_ID
        AND SC.TAX_CODE         = W_TAX_CODE
        AND SC.VAT_MNG_SERIAL   = W_VAT_MNG_SERIAL
        AND SC.VAT_MAKE_GB      = W_VAT_MAKE_GB
        AND SC.VAT_MAKE_GB      != '01' --�Ű�����(01 : ����Ű�) ���� -- 
    ORDER BY SC.MODIFY_DEGREE
    ;
END LU_SELECT_MODIFY_DEGREE;


END FI_SURTAX_CARD_G;
/