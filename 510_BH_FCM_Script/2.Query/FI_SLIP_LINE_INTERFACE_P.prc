CREATE OR REPLACE PROCEDURE FI_SLIP_LINE_INTERFACE_P
                            ( P_LINE_INTERFACE_ID   IN FI_SLIP_LINE_INTERFACE.LINE_INTERFACE_ID%TYPE
                            , P_SLIP_DATE           IN FI_SLIP_LINE_INTERFACE.SLIP_DATE%TYPE
                            , P_SLIP_NUM            IN FI_SLIP_LINE_INTERFACE.SLIP_NUM%TYPE
                            , P_SLIP_LINE_SEQ       IN FI_SLIP_LINE_INTERFACE.SLIP_LINE_SEQ%TYPE
                            , P_HEADER_INTERFACE_ID IN FI_SLIP_LINE_INTERFACE.HEADER_INTERFACE_ID%TYPE
                            , P_SOB_ID              IN FI_SLIP_LINE_INTERFACE.SOB_ID%TYPE
                            , P_ORG_ID              IN FI_SLIP_LINE_INTERFACE.ORG_ID%TYPE
                            , P_DEPT_ID             IN FI_SLIP_LINE_INTERFACE.DEPT_ID%TYPE
                            , P_PERSON_ID           IN FI_SLIP_LINE_INTERFACE.PERSON_ID%TYPE
                            , P_BUDGET_DEPT_ID      IN FI_SLIP_LINE_INTERFACE.BUDGET_DEPT_ID%TYPE
                            , P_ACCOUNT_BOOK_ID     IN FI_SLIP_LINE_INTERFACE.ACCOUNT_BOOK_ID%TYPE
                            , P_SLIP_TYPE           IN FI_SLIP_LINE_INTERFACE.SLIP_TYPE%TYPE
                            , P_JOURNAL_HEADER_ID   IN FI_SLIP_LINE_INTERFACE.JOURNAL_HEADER_ID%TYPE
                            , P_CUSTOMER_ID         IN FI_SLIP_LINE_INTERFACE.CUSTOMER_ID%TYPE
                            , P_ACCOUNT_CONTROL_ID  IN FI_SLIP_LINE_INTERFACE.ACCOUNT_CONTROL_ID%TYPE
                            , P_ACCOUNT_CODE        IN FI_SLIP_LINE_INTERFACE.ACCOUNT_CODE%TYPE
                            , P_COST_CENTER_ID      IN FI_SLIP_LINE_INTERFACE.COST_CENTER_ID%TYPE
                            , P_ACCOUNT_DR_CR       IN FI_SLIP_LINE_INTERFACE.ACCOUNT_DR_CR%TYPE
                            , P_GL_AMOUNT           IN FI_SLIP_LINE_INTERFACE.GL_AMOUNT%TYPE
                            , P_CURRENCY_CODE       IN FI_SLIP_LINE_INTERFACE.CURRENCY_CODE%TYPE
                            , P_EXCHANGE_RATE       IN FI_SLIP_LINE_INTERFACE.EXCHANGE_RATE%TYPE
                            , P_GL_CURRENCY_AMOUNT  IN FI_SLIP_LINE_INTERFACE.GL_CURRENCY_AMOUNT%TYPE
                            , P_BANK_ACCOUNT_ID     IN FI_SLIP_LINE_INTERFACE.BANK_ACCOUNT_ID%TYPE
                            , P_MANAGEMENT1         IN FI_SLIP_LINE_INTERFACE.MANAGEMENT1%TYPE
                            , P_MANAGEMENT2         IN FI_SLIP_LINE_INTERFACE.MANAGEMENT2%TYPE
                            , P_REFER1              IN FI_SLIP_LINE_INTERFACE.REFER1%TYPE
                            , P_REFER2              IN FI_SLIP_LINE_INTERFACE.REFER2%TYPE
                            , P_REFER3              IN FI_SLIP_LINE_INTERFACE.REFER3%TYPE
                            , P_REFER4              IN FI_SLIP_LINE_INTERFACE.REFER4%TYPE
                            , P_REFER5              IN FI_SLIP_LINE_INTERFACE.REFER5%TYPE
                            , P_REFER6              IN FI_SLIP_LINE_INTERFACE.REFER6%TYPE
                            , P_REFER7              IN FI_SLIP_LINE_INTERFACE.REFER7%TYPE
                            , P_REFER8              IN FI_SLIP_LINE_INTERFACE.REFER8%TYPE
                            , P_REFER9              IN FI_SLIP_LINE_INTERFACE.REFER9%TYPE
                            , P_VOUCH_CODE          IN FI_SLIP_LINE_INTERFACE.VOUCH_CODE%TYPE
                            , P_REFER_RATE          IN FI_SLIP_LINE_INTERFACE.REFER_RATE%TYPE
                            , P_REFER_AMOUNT        IN FI_SLIP_LINE_INTERFACE.REFER_AMOUNT%TYPE
                            , P_REFER_DATE1         IN FI_SLIP_LINE_INTERFACE.REFER_DATE1%TYPE
                            , P_REFER_DATE2         IN FI_SLIP_LINE_INTERFACE.REFER_DATE2%TYPE
                            , P_REMARK              IN FI_SLIP_LINE_INTERFACE.REMARK%TYPE
                            , P_FUND_CODE           IN FI_SLIP_LINE_INTERFACE.FUND_CODE%TYPE
                            , P_UNIT_PRICE          IN FI_SLIP_LINE_INTERFACE.UNIT_PRICE%TYPE
                            , P_UOM_CODE            IN FI_SLIP_LINE_INTERFACE.UOM_CODE%TYPE
                            , P_UOM_QUANTITY        IN FI_SLIP_LINE_INTERFACE.UOM_QUANTITY%TYPE
                            , P_UOM_WEIGHT          IN FI_SLIP_LINE_INTERFACE.UOM_WEIGHT%TYPE
                            , P_INVENTORY_ITEM_ID   IN FI_SLIP_LINE_INTERFACE.INVENTORY_ITEM_ID%TYPE
                            , P_TRANSFER_YN         IN FI_SLIP_LINE_INTERFACE.TRANSFER_YN%TYPE
                            , P_TRANSFER_DATE       IN FI_SLIP_LINE_INTERFACE.TRANSFER_DATE%TYPE
                            , P_TRANSFER_PERSON_ID  IN FI_SLIP_LINE_INTERFACE.TRANSFER_PERSON_ID%TYPE
                            , P_CONFIRM_YN          IN FI_SLIP_LINE_INTERFACE.CONFIRM_YN%TYPE
                            , P_CONFIRM_DATE        IN FI_SLIP_LINE_INTERFACE.CONFIRM_DATE%TYPE
                            , P_CONFIRM_PERSON_ID   IN FI_SLIP_LINE_INTERFACE.CONFIRM_PERSON_ID%TYPE
                            , P_SOURCE_TABLE        IN FI_SLIP_LINE_INTERFACE.SOURCE_TABLE%TYPE
                            , P_SOURCE_HEADER_ID    IN FI_SLIP_LINE_INTERFACE.SOURCE_HEADER_ID%TYPE
                            , P_SOURCE_LINE_ID      IN FI_SLIP_LINE_INTERFACE.SOURCE_LINE_ID%TYPE
                            , P_CREATION_DATE       IN FI_SLIP_LINE_INTERFACE.CREATION_DATE%TYPE
                            , P_CREATED_BY          IN FI_SLIP_LINE_INTERFACE.CREATED_BY%TYPE
                            , P_LAST_UPDATE_DATE    IN FI_SLIP_LINE_INTERFACE.LAST_UPDATE_DATE%TYPE
                            , P_LAST_UPDATED_BY     IN FI_SLIP_LINE_INTERFACE.LAST_UPDATED_BY%TYPE
                            )
AS
  V_DRCR                    FI_ACCOUNT_CONTROL.ACCOUNT_DR_CR%TYPE;          -- ���뱸��
  V_MICH_FLAG               FI_ACCOUNT_CONTROL.ACCOUNT_MICH_YN%TYPE;        -- ��û���������
  V_ACCREM_FLAG             FI_ACCOUNT_CONTROL.ACCOUNT_ENABLED_FLAG%TYPE;   -- �����ܾװ�������
  V_ACCOUNT_FLAG            FI_ACCOUNT_CONTROL.BANK_ACCOUNT_FLAG%TYPE;      -- ������� ��������
  V_CURR_FLAG               FI_ACCOUNT_CONTROL.CURRENCY_ENABLED_FLAG%TYPE;  -- ��ȭ��������
  V_VNDR_FLAG               FI_ACCOUNT_CONTROL.CUSTOMER_ENABLED_FLAG%TYPE;  -- �ŷ���������������
  V_VAT_FLAG                FI_ACCOUNT_CONTROL.VAT_ENABLED_FLAG%TYPE;       -- �ΰ�����������
  V_MANA_CODE               FI_ACCOUNT_CONTROL.ACCOUNT_GL_ID%TYPE;          -- ����������� �ڵ��ȣ
  V_ACCOUNT_CLASS           FI_COMMON.VALUE1%TYPE;       -- ����Ÿ�� �ڵ��ȣ ����,���޾�����..
  V_EXIST_YN                FI_SLIP_LINE.CONFIRM_YN%TYPE;                   -- �̿�Data Check Y/N

BEGIN
   BEGIN
    SELECT FAC.ACCOUNT_DR_CR,          FAC.ACCOUNT_MICH_YN,            -- ��/��                ��û��(Y/N)
           FAC.ACCOUNT_ENABLED_FLAG,   FAC.CURRENCY_ENABLED_FLAG,      -- �����ܾװ���(Y/N),   ��ȭ���°���(Y/N)
           FAC.CUSTOMER_ENABLED_FLAG,  FAC.VAT_ENABLED_FLAG,           -- �ŷ�ó����(Y/N),     �ΰ�������(Y/N)
           FAC.BANK_ACCOUNT_FLAG,      FAV.ACCOUNT_CLASS_TYPE,           -- ������°���(Y/N)    ����Class ID
          (SELECT CODE FROM FI_COMMON WHERE COMMON_ID = FAC.ACCOUNT_GL_ID AND SOB_ID = P_SOB_ID )              -- �����ڵ�
      INTO  V_DRCR,                 V_MICH_FLAG,
            V_ACCREM_FLAG,          V_CURR_FLAG,
            V_VNDR_FLAG,            V_VAT_FLAG,
            V_ACCOUNT_FLAG,         V_ACCOUNT_CLASS,
            V_MANA_CODE
      FROM  FI_ACCOUNT_CONTROL  FAC
       ,  FI_ACCOUNT_CLASS_V    FAV
    WHERE FAC.ACCOUNT_CLASS_ID    = FAV.ACCOUNT_CLASS_ID(+)
      AND FAC.SOB_ID              = FAV.SOB_ID(+)
      AND FAC.ACCOUNT_CONTROL_ID  = P_ACCOUNT_CONTROL_ID
      AND FAC.SOB_ID              = P_SOB_ID
    ;
  EXCEPTION WHEN OTHERS THEN
    V_DRCR := '3';
    V_MICH_FLAG := 'N';
    V_ACCREM_FLAG := 'N';
    V_CURR_FLAG := 'N';
    V_VNDR_FLAG := 'N';
    V_VAT_FLAG := 'N';
    V_ACCOUNT_FLAG := 'N';
    V_ACCOUNT_CLASS := 'N';
    V_MANA_CODE := '';
  END;

  -- �ΰ��� ����.
  IF V_VAT_FLAG = 'Y' THEN
    NULL;

  END IF;

END FI_SLIP_LINE_INTERFACE_P;
/
