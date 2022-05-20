using System;
using System.Data;
using System.Drawing;
using System.Windows.Forms;
using System.Collections.Generic;

using Syncfusion.Windows.Forms;
using Syncfusion.Windows.Forms.Tools;
using Syncfusion.Windows.Forms.Grid;
using InfoSummit.Win.ControlAdv;
using ISCommonUtil;

namespace FCMF0292
{
    public partial class FCMF0292 : Office2007Form
    {
        
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        object mAccount_Book_ID;
        object mAccount_Set_ID;
        object mFiscal_Calendar_ID;
        object mDept_Level;
        object mAccount_Book_Name;
        object mCurrency_Code;
        object mBudget_Control_YN;

        #endregion;

        #region ----- Constructor -----

        public FCMF0292()
        {
            InitializeComponent();
        }

        public FCMF0292(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----
        private void GetAccountBook()
        {
            idcACCOUNT_BOOK.ExecuteNonQuery();
            mAccount_Book_ID = idcACCOUNT_BOOK.GetCommandParamValue("O_ACCOUNT_BOOK_ID");
            mAccount_Book_Name = idcACCOUNT_BOOK.GetCommandParamValue("O_ACCOUNT_BOOK_NAME");
            mAccount_Set_ID = idcACCOUNT_BOOK.GetCommandParamValue("O_ACCOUNT_SET_ID");
            mFiscal_Calendar_ID = idcACCOUNT_BOOK.GetCommandParamValue("O_FISCAL_CALENDAR_ID");
            mDept_Level = idcACCOUNT_BOOK.GetCommandParamValue("O_DEPT_LEVEL");
            mCurrency_Code = idcACCOUNT_BOOK.GetCommandParamValue("O_CURRENCY_CODE");
            mBudget_Control_YN = idcACCOUNT_BOOK.GetCommandParamValue("O_BUDGET_CONTROL_YN");
        }

        private void Search_DB()
        {
            if (iString.ISNull(SLIP_DATE_FR_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                SLIP_DATE_FR_0.Focus();
                return;
            }

            if (iString.ISNull(SLIP_DATE_TO_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                SLIP_DATE_TO_0.Focus();
                return;
            }

            if (Convert.ToDateTime(SLIP_DATE_FR_0.EditValue) > Convert.ToDateTime(SLIP_DATE_TO_0.EditValue))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10012"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                SLIP_DATE_FR_0.Focus();
                return;
            }
            idaSLIP_HEADER_LIST.Fill();
            igrSLIP_LIST.Focus();
            SLIP_QUERY_STATUS.EditValue = "NON-QUERY";
        }

        private void Set_Control_Item_Prompt()
        {
            idaCONTROL_ITEM_PROMPT.Fill();
            if (idaCONTROL_ITEM_PROMPT.OraSelectData.Rows.Count > 0)
            {
                MANAGEMENT1_PROMPT.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["MANAGEMENT1_NAME"];
                MANAGEMENT2_PROMPT.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["MANAGEMENT2_NAME"];
                REFER1_PROMPT.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER1_NAME"];
                REFER2_PROMPT.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER2_NAME"];
                REFER3_PROMPT.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER3_NAME"];
                REFER4_PROMPT.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER4_NAME"];
                REFER5_PROMPT.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER5_NAME"];
                REFER6_PROMPT.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER6_NAME"];
                REFER7_PROMPT.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER7_NAME"];
                REFER8_PROMPT.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER8_NAME"];

                MANAGEMENT1_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["MANAGEMENT1_YN"];
                MANAGEMENT2_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["MANAGEMENT2_YN"];
                REFER1_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER1_YN"];
                REFER2_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER2_YN"];
                REFER3_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER3_YN"];
                REFER4_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER4_YN"];
                REFER5_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER5_YN"];
                REFER6_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER6_YN"];
                REFER7_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER7_YN"];
                REFER8_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER8_YN"];

                MANAGEMENT1_LOOKUP_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["MANAGEMENT1_LOOKUP_YN"];
                MANAGEMENT2_LOOKUP_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["MANAGEMENT2_LOOKUP_YN"];
                REFER1_LOOKUP_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER1_LOOKUP_YN"];
                REFER2_LOOKUP_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER2_LOOKUP_YN"];
                REFER3_LOOKUP_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER3_LOOKUP_YN"];
                REFER4_LOOKUP_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER4_LOOKUP_YN"];
                REFER5_LOOKUP_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER5_LOOKUP_YN"];
                REFER6_LOOKUP_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER6_LOOKUP_YN"];
                REFER7_LOOKUP_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER7_LOOKUP_YN"];
                REFER8_LOOKUP_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER8_LOOKUP_YN"];

                MANAGEMENT1_DATA_TYPE.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["MANAGEMENT1_DATA_TYPE"];
                MANAGEMENT2_DATA_TYPE.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["MANAGEMENT2_DATA_TYPE"];
                REFER1_DATA_TYPE.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER1_DATA_TYPE"];
                REFER2_DATA_TYPE.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER2_DATA_TYPE"];
                REFER3_DATA_TYPE.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER3_DATA_TYPE"];
                REFER4_DATA_TYPE.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER4_DATA_TYPE"];
                REFER5_DATA_TYPE.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER5_DATA_TYPE"];
                REFER6_DATA_TYPE.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER6_DATA_TYPE"];
                REFER7_DATA_TYPE.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER7_DATA_TYPE"];
                REFER8_DATA_TYPE.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER8_DATA_TYPE"];
            }
            else
            {
                MANAGEMENT1_PROMPT.EditValue = null;
                MANAGEMENT2_PROMPT.EditValue = null;
                REFER1_PROMPT.EditValue = null;
                REFER2_PROMPT.EditValue = null;
                REFER3_PROMPT.EditValue = null;
                REFER4_PROMPT.EditValue = null;
                REFER5_PROMPT.EditValue = null;
                REFER6_PROMPT.EditValue = null;
                REFER7_PROMPT.EditValue = null;
                REFER8_PROMPT.EditValue = null;

                MANAGEMENT1_YN.EditValue = "F".ToString();
                MANAGEMENT2_YN.EditValue = "F".ToString();
                REFER1_YN.EditValue = "F".ToString();
                REFER2_YN.EditValue = "F".ToString();
                REFER3_YN.EditValue = "F".ToString();
                REFER4_YN.EditValue = "F".ToString();
                REFER5_YN.EditValue = "F".ToString();
                REFER6_YN.EditValue = "F".ToString();
                REFER7_YN.EditValue = "F".ToString();
                REFER8_YN.EditValue = "F".ToString();

                MANAGEMENT1_LOOKUP_YN.EditValue = "N".ToString();
                MANAGEMENT2_LOOKUP_YN.EditValue = "N".ToString();
                REFER1_LOOKUP_YN.EditValue = "N".ToString();
                REFER2_LOOKUP_YN.EditValue = "N".ToString();
                REFER3_LOOKUP_YN.EditValue = "N".ToString();
                REFER4_LOOKUP_YN.EditValue = "N".ToString();
                REFER5_LOOKUP_YN.EditValue = "N".ToString();
                REFER6_LOOKUP_YN.EditValue = "N".ToString();
                REFER7_LOOKUP_YN.EditValue = "N".ToString();
                REFER8_LOOKUP_YN.EditValue = "N".ToString();

                MANAGEMENT1_DATA_TYPE.EditValue = "VARCHAR2".ToString();
                MANAGEMENT2_DATA_TYPE.EditValue = "VARCHAR2".ToString();
                REFER1_DATA_TYPE.EditValue = "VARCHAR2".ToString();
                REFER2_DATA_TYPE.EditValue = "VARCHAR2".ToString();
                REFER3_DATA_TYPE.EditValue = "VARCHAR2".ToString();
                REFER4_DATA_TYPE.EditValue = "VARCHAR2".ToString();
                REFER5_DATA_TYPE.EditValue = "VARCHAR2".ToString();
                REFER6_DATA_TYPE.EditValue = "VARCHAR2".ToString();
                REFER7_DATA_TYPE.EditValue = "VARCHAR2".ToString();
                REFER8_DATA_TYPE.EditValue = "VARCHAR2".ToString();
            }
        }

        private void Set_SlipLIne_ControlItem()
        {
            igrSLIP_LINE.SetCellValue("MANAGEMENT1_NAME", iString.ISNull(MANAGEMENT1_PROMPT.EditValue));
            igrSLIP_LINE.SetCellValue("MANAGEMENT2_NAME", iString.ISNull(MANAGEMENT2_PROMPT.EditValue));
            igrSLIP_LINE.SetCellValue("REFER1_NAME", iString.ISNull(REFER1_PROMPT.EditValue));
            igrSLIP_LINE.SetCellValue("REFER2_NAME", iString.ISNull(REFER2_PROMPT.EditValue));
            igrSLIP_LINE.SetCellValue("REFER3_NAME", iString.ISNull(REFER3_PROMPT.EditValue));
            igrSLIP_LINE.SetCellValue("REFER4_NAME", iString.ISNull(REFER4_PROMPT.EditValue));
            igrSLIP_LINE.SetCellValue("REFER5_NAME", iString.ISNull(REFER5_PROMPT.EditValue));
            igrSLIP_LINE.SetCellValue("REFER6_NAME", iString.ISNull(REFER6_PROMPT.EditValue));
            igrSLIP_LINE.SetCellValue("REFER7_NAME", iString.ISNull(REFER7_PROMPT.EditValue));
            igrSLIP_LINE.SetCellValue("REFER8_NAME", iString.ISNull(REFER8_PROMPT.EditValue));

            igrSLIP_LINE.SetCellValue("MANAGEMENT1_YN", iString.ISNull(MANAGEMENT1_YN.EditValue, "F"));
            igrSLIP_LINE.SetCellValue("MANAGEMENT2_YN", iString.ISNull(MANAGEMENT2_YN.EditValue, "F"));
            igrSLIP_LINE.SetCellValue("REFER1_YN", iString.ISNull(REFER1_YN.EditValue, "F"));
            igrSLIP_LINE.SetCellValue("REFER2_YN", iString.ISNull(REFER2_YN.EditValue, "F"));
            igrSLIP_LINE.SetCellValue("REFER3_YN", iString.ISNull(REFER3_YN.EditValue, "F"));
            igrSLIP_LINE.SetCellValue("REFER4_YN", iString.ISNull(REFER4_YN.EditValue, "F"));
            igrSLIP_LINE.SetCellValue("REFER5_YN", iString.ISNull(REFER5_YN.EditValue, "F"));
            igrSLIP_LINE.SetCellValue("REFER6_YN", iString.ISNull(REFER6_YN.EditValue, "F"));
            igrSLIP_LINE.SetCellValue("REFER7_YN", iString.ISNull(REFER7_YN.EditValue, "F"));
            igrSLIP_LINE.SetCellValue("REFER8_YN", iString.ISNull(REFER8_YN.EditValue, "F"));

            igrSLIP_LINE.SetCellValue("MANAGEMENT1_LOOKUP_YN", iString.ISNull(MANAGEMENT1_LOOKUP_YN.EditValue, "N"));
            igrSLIP_LINE.SetCellValue("MANAGEMENT2_LOOKUP_YN", iString.ISNull(MANAGEMENT2_LOOKUP_YN.EditValue, "N"));
            igrSLIP_LINE.SetCellValue("REFER1_LOOKUP_YN", iString.ISNull(REFER1_LOOKUP_YN.EditValue, "N"));
            igrSLIP_LINE.SetCellValue("REFER2_LOOKUP_YN", iString.ISNull(REFER2_LOOKUP_YN.EditValue, "N"));
            igrSLIP_LINE.SetCellValue("REFER3_LOOKUP_YN", iString.ISNull(REFER3_LOOKUP_YN.EditValue, "N"));
            igrSLIP_LINE.SetCellValue("REFER4_LOOKUP_YN", iString.ISNull(REFER4_LOOKUP_YN.EditValue, "N"));
            igrSLIP_LINE.SetCellValue("REFER5_LOOKUP_YN", iString.ISNull(REFER5_LOOKUP_YN.EditValue, "N"));
            igrSLIP_LINE.SetCellValue("REFER6_LOOKUP_YN", iString.ISNull(REFER6_LOOKUP_YN.EditValue, "N"));
            igrSLIP_LINE.SetCellValue("REFER7_LOOKUP_YN", iString.ISNull(REFER7_LOOKUP_YN.EditValue, "N"));
            igrSLIP_LINE.SetCellValue("REFER8_LOOKUP_YN", iString.ISNull(REFER8_LOOKUP_YN.EditValue, "N"));

            igrSLIP_LINE.SetCellValue("MANAGEMENT1_DATA_TYPE", iString.ISNull(MANAGEMENT1_DATA_TYPE.EditValue, "N"));
            igrSLIP_LINE.SetCellValue("MANAGEMENT2_DATA_TYPE", iString.ISNull(MANAGEMENT2_DATA_TYPE.EditValue, "N"));
            igrSLIP_LINE.SetCellValue("REFER1_DATA_TYPE", iString.ISNull(REFER1_DATA_TYPE.EditValue, "N"));
            igrSLIP_LINE.SetCellValue("REFER2_DATA_TYPE", iString.ISNull(REFER2_DATA_TYPE.EditValue, "N"));
            igrSLIP_LINE.SetCellValue("REFER3_DATA_TYPE", iString.ISNull(REFER3_DATA_TYPE.EditValue, "N"));
            igrSLIP_LINE.SetCellValue("REFER4_DATA_TYPE", iString.ISNull(REFER4_DATA_TYPE.EditValue, "N"));
            igrSLIP_LINE.SetCellValue("REFER5_DATA_TYPE", iString.ISNull(REFER5_DATA_TYPE.EditValue, "N"));
            igrSLIP_LINE.SetCellValue("REFER6_DATA_TYPE", iString.ISNull(REFER6_DATA_TYPE.EditValue, "N"));
            igrSLIP_LINE.SetCellValue("REFER7_DATA_TYPE", iString.ISNull(REFER7_DATA_TYPE.EditValue, "N"));
            igrSLIP_LINE.SetCellValue("REFER8_DATA_TYPE", iString.ISNull(REFER8_DATA_TYPE.EditValue, "N")); 
        }

        private void SetCommonParameter(string pGroup_Code, string pEnabled_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        }

        private void SetCommonParameter_W(string pGroup_Code, string pWhere, string pEnabled_YN)
        {
            ildCOMMON_W.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
            ildCOMMON_W.SetLookupParamValue("W_WHERE", pWhere);
            ildCOMMON_W.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        }

        private void SetManagementParameter(string pManagement_Field, string pEnabled_YN)
        {
            ildMANAGEMENT.SetLookupParamValue("W_MANAGEMENT_FIELD", pManagement_Field);
            ildMANAGEMENT.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        }

        private void GetSlipNum()
        {
            if (iString.ISNull(DOCUMENT_TYPE.EditValue) == string.Empty)
            {
                return;
            }
            idcSLIP_NUM.SetCommandParamValue("W_DOCUMENT_TYPE", DOCUMENT_TYPE.EditValue);
            idcSLIP_NUM.ExecuteNonQuery();
            SLIP_NUM.EditValue = idcSLIP_NUM.GetCommandParamValue("O_DOCUMENT_NUM");
            GL_NUM.EditValue = SLIP_NUM.EditValue;
        }

        private void GetSubForm()
        {
            ibtSUB_FORM.Visible = false;
            ACCOUNT_CLASS_YN.EditValue = null;
            ACCOUNT_CLASS_TYPE.EditValue = null;
            string vBTN_CAPTION = null;

            if (iString.ISNull(ACCOUNT_CONTROL_ID.EditValue) == string.Empty || iString.ISNull(ACCOUNT_DR_CR.EditValue) == string.Empty)   
            {
                return;
            }
            idcGET_SUB_FORM.ExecuteNonQuery();
            ACCOUNT_CLASS_YN.EditValue = idcGET_SUB_FORM.GetCommandParamValue("O_ACCOUNT_CLASS_YN");
            ACCOUNT_CLASS_TYPE.EditValue = idcGET_SUB_FORM.GetCommandParamValue("O_ACCOUNT_CLASS_TYPE");
            vBTN_CAPTION = iString.ISNull(idcGET_SUB_FORM.GetCommandParamValue("O_BTN_CAPTION"));
            if (iString.ISNull(ACCOUNT_CLASS_YN.EditValue, "N") == "N".ToString())
            {
                return;
            }
            ibtSUB_FORM.Left = 804;
            ibtSUB_FORM.Top = 75;
            ibtSUB_FORM.ButtonTextElement[0].Default = vBTN_CAPTION;
            Application.DoEvents();
            ibtSUB_FORM.BringToFront();
            ibtSUB_FORM.Visible = true;
        }

        #endregion;

        #region ----- Initialize Event ----- 

        private void InsertSlipHeader()
        {
            itbSLIP.SelectedIndex = 1;
            itbSLIP.SelectedTab.Focus();
            
            SLIP_DATE.EditValue = DateTime.Today;
            GL_DATE.EditValue = SLIP_DATE.EditValue;

            idcDV_SLIP_TYPE.SetCommandParamValue("W_WHERE", " GROUP_CODE = 'SLIP_TYPE' AND VALUE1 = 'BL' ");
            idcDV_SLIP_TYPE.ExecuteNonQuery();
            SLIP_TYPE.EditValue = idcDV_SLIP_TYPE.GetCommandParamValue("O_CODE");
            SLIP_TYPE_NAME.EditValue = idcDV_SLIP_TYPE.GetCommandParamValue("O_CODE_NAME");
            SLIP_TYPE_CLASS.EditValue = idcDV_SLIP_TYPE.GetCommandParamValue("O_VALUE1");
            DOCUMENT_TYPE.EditValue = idcDV_SLIP_TYPE.GetCommandParamValue("O_VALUE2");

            idcUSER_INFO.ExecuteNonQuery();
            DEPT_NAME.EditValue = idcUSER_INFO.GetCommandParamValue("O_DEPT_NAME");
            DEPT_ID.EditValue = idcUSER_INFO.GetCommandParamValue("O_DEPT_ID");
            PERSON_NAME.EditValue = idcUSER_INFO.GetCommandParamValue("O_PERSON_NAME");
            PERSON_ID.EditValue = isAppInterfaceAdv1.PERSON_ID;
            
            ACCOUNT_CODE.Focus();
        }

        private void InsertSlipLine()
        {
            CURRENCY_CODE.EditValue = mCurrency_Code;
            CURRENCY_DESC.EditValue = mCurrency_Code;
            ACCOUNT_CODE.Focus();
        }

        private void Init_GL_Amount()
        {
            GL_AMOUNT.EditValue = iString.ISDecimaltoZero(GL_CURRENCY_AMOUNT.EditValue) * iString.ISDecimaltoZero(EXCHANGE_RATE.EditValue);
            idcCONVERSION_BASE_AMOUNT.SetCommandParamValue("W_BASE_CURRENCY_CODE", mCurrency_Code);
            idcCONVERSION_BASE_AMOUNT.SetCommandParamValue("W_CONVERSION_AMOUNT", GL_AMOUNT.EditValue);
            idcCONVERSION_BASE_AMOUNT.ExecuteNonQuery();
            GL_AMOUNT.EditValue = idcCONVERSION_BASE_AMOUNT.GetCommandParamValue("O_BASE_AMOUNT");
        }

        private bool Init_Exchange_Profit_Loss(decimal pNew_Exchange_Rate, decimal pOld_Exchange_Rate, decimal pCurrency_Amount, decimal pGL_Amount, int pCurrent_Row_Index)
        {
            bool mExchange_Profit_Loss = false;
            object vAccount_DR_CR;
            object vAccount_DR_CR_Name;
            object vAccount_ID;
            object vAccount_Code;
            object vAccount_Desc;
            decimal vExchange_Profit_Loss_Amount = Convert.ToDecimal(0);
            decimal vNew_GL_Amount = iString.ISDecimaltoZero(pNew_Exchange_Rate) * iString.ISDecimaltoZero(pCurrency_Amount) ;

            vExchange_Profit_Loss_Amount = vNew_GL_Amount - pGL_Amount;
            if (pCurrency_Amount != Convert.ToDecimal(0) && vExchange_Profit_Loss_Amount != Convert.ToDecimal(0))
            {                
                idcEXCHANGE_PROFIT_LOSS.SetCommandParamValue("W_CONVERSION_AMOUNT", vExchange_Profit_Loss_Amount);
                idcEXCHANGE_PROFIT_LOSS.ExecuteNonQuery();
                vAccount_ID = idcEXCHANGE_PROFIT_LOSS.GetCommandParamValue("O_ACCOUNT_ID");
                vAccount_Code = idcEXCHANGE_PROFIT_LOSS.GetCommandParamValue("O_ACCOUNT_CODE");
                vAccount_Desc = idcEXCHANGE_PROFIT_LOSS.GetCommandParamValue("O_ACCOUNT_DESC");
                vAccount_DR_CR = idcEXCHANGE_PROFIT_LOSS.GetCommandParamValue("O_ACCOUNT_DR_CR");
                vAccount_DR_CR_Name = idcEXCHANGE_PROFIT_LOSS.GetCommandParamValue("O_ACCOUNT_DR_CR_NAME");

                // LINE 추가.
                idaSLIP_LINE.AddUnder();
                for (int c = 0; c < igrSLIP_LINE.ColCount; c++)
                {
                    igrSLIP_LINE.SetCellValue(igrSLIP_LINE.RowIndex, c, igrSLIP_LINE.GetCellValue(pCurrent_Row_Index, c));
                }
                // 반제 SLIP_LINE_ID.
                //igrSLIP_LINE.SetCellValue(igrSLIP_LINE.RowIndex, igrSLIP_LINE.GetColumnToIndex("UNLIQUIDATE_SLIP_LINE_ID"), );
                ACCOUNT_DR_CR.EditValue = vAccount_DR_CR;
                ACCOUNT_DR_CR_NAME.EditValue = vAccount_DR_CR_Name;
                ACCOUNT_CONTROL_ID.EditValue = vAccount_ID;
                ACCOUNT_CODE.EditValue = vAccount_Code;
                ACCOUNT_DESC.EditValue = vAccount_Desc;
                EXCHANGE_RATE.EditValue = iString.ISDecimaltoZero(pOld_Exchange_Rate);
                GL_CURRENCY_AMOUNT.EditValue = iString.ISDecimaltoZero(pCurrency_Amount);
                GL_AMOUNT.EditValue = Math.Abs(iString.ISDecimaltoZero(vExchange_Profit_Loss_Amount));

                //참고항목 동기화.                
                Set_Control_Item_Prompt();
                Init_Control_Item_Prompt();

                Init_DR_CR_Amount();
                mExchange_Profit_Loss = true;
            }
            return mExchange_Profit_Loss;
        }

        private void Init_DR_CR_Amount()
        {
            SLIP_QUERY_STATUS.EditValue = "NON-QUERY";
            if (igrSLIP_LINE.RowCount > 0)
            {                
                for (int r = 0; r < igrSLIP_LINE.RowCount; r++)
                {                    
                    if (idaSLIP_LINE.OraSelectData.Rows[r].RowState != DataRowState.Deleted && iString.ISNull(igrSLIP_LINE.GetCellValue(r, igrSLIP_LINE.GetColumnToIndex("ACCOUNT_DR_CR")), "3") == "1".ToString())
                    {
                        igrSLIP_LINE.SetCellValue(r, igrSLIP_LINE.GetColumnToIndex("DR_AMOUNT"), iString.ISDecimaltoZero(igrSLIP_LINE.GetCellValue(r, igrSLIP_LINE.GetColumnToIndex("GL_AMOUNT"))));
                        igrSLIP_LINE.SetCellValue(r, igrSLIP_LINE.GetColumnToIndex("CR_AMOUNT"), Convert.ToDecimal(0));
                    }
                    else if (idaSLIP_LINE.OraSelectData.Rows[r].RowState != DataRowState.Deleted && iString.ISNull(igrSLIP_LINE.GetCellValue(r, igrSLIP_LINE.GetColumnToIndex("ACCOUNT_DR_CR")), "3") == "2".ToString())
                    {
                        igrSLIP_LINE.SetCellValue(r, igrSLIP_LINE.GetColumnToIndex("DR_AMOUNT"), Convert.ToDecimal(0));
                        igrSLIP_LINE.SetCellValue(r, igrSLIP_LINE.GetColumnToIndex("CR_AMOUNT"), iString.ISDecimaltoZero(igrSLIP_LINE.GetCellValue(r, igrSLIP_LINE.GetColumnToIndex("GL_AMOUNT"))));
                    }                
                }              
            }
            Init_Total_GL_Amount();
        }

        private void Init_Total_GL_Amount()
        {
            SLIP_QUERY_STATUS.EditValue = "NON-QUERY";
            decimal vDR_Amount = Convert.ToDecimal(0);
            decimal vCR_Amount = Convert.ToDecimal(0);
            decimal vCurrency_DR_Amount = Convert.ToInt32(0);
            if (igrSLIP_LINE.RowCount > 0)
            {
                for (int r = 0; r < igrSLIP_LINE.RowCount; r++)
                {
                    if (idaSLIP_LINE.SelectRows[r].RowState != DataRowState.Deleted)
                    {
                        if (iString.ISNull(igrSLIP_LINE.GetCellValue(r, igrSLIP_LINE.GetColumnToIndex("ACCOUNT_DR_CR")), "3") == "1".ToString())
                        {
                            vDR_Amount = vDR_Amount + iString.ISDecimaltoZero(igrSLIP_LINE.GetCellValue(r, igrSLIP_LINE.GetColumnToIndex("GL_AMOUNT")));
                            vCurrency_DR_Amount = vCurrency_DR_Amount + iString.ISDecimaltoZero(igrSLIP_LINE.GetCellValue(r, igrSLIP_LINE.GetColumnToIndex("GL_CURRENCY_AMOUNT")));
                        }
                        else if (iString.ISNull(igrSLIP_LINE.GetCellValue(r, igrSLIP_LINE.GetColumnToIndex("ACCOUNT_DR_CR")), "3") == "2".ToString())
                        {
                            vCR_Amount = vCR_Amount + iString.ISDecimaltoZero(igrSLIP_LINE.GetCellValue(r, igrSLIP_LINE.GetColumnToIndex("GL_AMOUNT")));
                        }
                    }
                }
            }     
            TOTAL_DR_AMOUNT.EditValue = iString.ISDecimaltoZero(vDR_Amount);
            TOTAL_CR_AMOUNT.EditValue = iString.ISDecimaltoZero(vCR_Amount);
            MARGIN_AMOUNT.EditValue = -(System.Math.Abs(iString.ISDecimaltoZero(vDR_Amount) - iString.ISDecimaltoZero(vCR_Amount))); ;
        }

        private void Init_Control_Item_Prompt()
        {
            Object preValue;
///////////////////////////////////////////////////////////////////////////////////////////////////
            CURRENCY_DESC.Nullable = true;
            if (iString.ISNull(CURRENCY_ENABLED_FLAG.EditValue, "N") == "Y".ToString())
            {
                CURRENCY_DESC.Nullable = false;
            }            
            Application.DoEvents();
///////////////////////////////////////////////////////////////////////////////////////////////////
            MANAGEMENT1.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
            MANAGEMENT1.NumberDecimalDigits = 0;
            if (iString.ISNull(MANAGEMENT1_YN.EditValue, "F") == "F".ToString())
            {
                MANAGEMENT1.ReadOnly = true;
                MANAGEMENT1.Insertable = false;
                MANAGEMENT1.Updatable = false;
                MANAGEMENT1.TabStop = false;                
            }
            else
            {                
                MANAGEMENT1.Nullable = true;
                MANAGEMENT1.ReadOnly = false;
                MANAGEMENT1.Insertable = true;
                MANAGEMENT1.Updatable = true;
                MANAGEMENT1.TabStop = true;
                preValue = MANAGEMENT1.EditValue;       // 기존 값 보관.
                if (iString.ISNull(MANAGEMENT1_DATA_TYPE.EditValue) == "NUMBER".ToString())
                {
                    MANAGEMENT1.EditValue = null;
                    MANAGEMENT1.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                    MANAGEMENT1.EditValue = iString.ISDecimaltoZero(preValue);

                }
                else if (iString.ISNull(MANAGEMENT1_DATA_TYPE.EditValue) == "RATE".ToString())
                {
                    MANAGEMENT1.EditValue = null;
                    MANAGEMENT1.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                    MANAGEMENT1.NumberDecimalDigits = 4;
                    MANAGEMENT1.EditValue = iString.ISDecimaltoZero(preValue);
                }
                //else if (iString.ISNull(MANAGEMENT1_DATA_TYPE.EditValue)  == "DATE".ToString())
                //{
                //    MANAGEMENT1.EditAdvType = ISUtil.Enum.EditAdvType.DateTimeEdit;
                //    MANAGEMENT1.EditValue = SLIP_DATE.EditValue;
                //}
                else if (iString.ISNull(MANAGEMENT1_YN.EditValue, "N") == "Y".ToString())
                {
                    MANAGEMENT1.Nullable = false;
                }
            }
            MANAGEMENT2.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
            MANAGEMENT2.NumberDecimalDigits = 0;
            if (iString.ISNull(MANAGEMENT2_YN.EditValue, "F") == "F".ToString())
            {
                MANAGEMENT2.ReadOnly = true;
                MANAGEMENT2.Insertable = false;
                MANAGEMENT2.Updatable = false;
                MANAGEMENT2.TabStop = false;                
            }
            else
            {
                MANAGEMENT2.Nullable = true;
                MANAGEMENT2.ReadOnly = false;
                MANAGEMENT2.Insertable = true;
                MANAGEMENT2.Updatable = true;
                MANAGEMENT2.TabStop = true;
                preValue = MANAGEMENT2.EditValue;       // 기존 값 보관.
                if (iString.ISNull(MANAGEMENT2_DATA_TYPE.EditValue) == "NUMBER".ToString())
                {
                    MANAGEMENT2.EditValue = null;
                    MANAGEMENT2.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                    MANAGEMENT2.EditValue = iString.ISDecimaltoZero(preValue);
                }
                else if (iString.ISNull(MANAGEMENT2_DATA_TYPE.EditValue) == "RATE".ToString())
                {
                    MANAGEMENT2.EditValue = null;
                    MANAGEMENT2.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                    MANAGEMENT2.NumberDecimalDigits = 4;
                    MANAGEMENT2.EditValue = iString.ISDecimaltoZero(preValue);
                }
                //else if (iString.ISNull(MANAGEMENT2_DATA_TYPE.EditValue)  == "DATE".ToString())
                //{
                //    MANAGEMENT2.EditAdvType = ISUtil.Enum.EditAdvType.DateTimeEdit;
                //    MANAGEMENT2.EditValue = SLIP_DATE.EditValue;
                //}
                else if (iString.ISNull(MANAGEMENT2_YN.EditValue, "N") == "Y".ToString())
                {
                    MANAGEMENT2.Nullable = false;
                }
            }
            REFER1.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
            REFER1.NumberDecimalDigits = 0;
            if (iString.ISNull(REFER1_YN.EditValue, "F") == "F".ToString())
            {
                REFER1.ReadOnly = true;
                REFER1.Insertable = false;
                REFER1.Updatable = false;
                REFER1.TabStop = false;
            }
            else
            {
                REFER1.Nullable = true;
                REFER1.ReadOnly = false;
                REFER1.Insertable = true;
                REFER1.Updatable = true;
                REFER1.TabStop = true;
                preValue = REFER1.EditValue;       // 기존 값 보관.
                if (iString.ISNull(REFER1_DATA_TYPE.EditValue) == "NUMBER".ToString())
                {
                    REFER1.EditValue = null;
                    REFER1.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                    REFER1.EditValue = iString.ISDecimaltoZero(preValue);
                }
                else if (iString.ISNull(REFER1_DATA_TYPE.EditValue) == "RATE".ToString())
                {
                    REFER1.EditValue = null;
                    REFER1.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                    REFER1.NumberDecimalDigits = 4;
                    REFER1.EditValue = iString.ISDecimaltoZero(preValue);
                }
                //else if (iString.ISNull(REFER1_DATA_TYPE.EditValue) == "DATE".ToString())
                //{
                //    REFER1.EditAdvType = ISUtil.Enum.EditAdvType.DateTimeEdit;
                //    REFER1.EditValue = SLIP_DATE.EditValue;
                //}
                else if (iString.ISNull(REFER1_YN.EditValue, "N") == "Y".ToString())
                {
                    REFER1.Nullable = false;
                }
            }
            REFER2.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
            REFER2.NumberDecimalDigits = 0;
            if (iString.ISNull(REFER2_YN.EditValue, "F") == "F".ToString())
            {
                REFER2.ReadOnly = true;
                REFER2.Insertable = false;
                REFER2.Updatable = false;
                REFER2.TabStop = false;
            }
            else
            {
                REFER2.Nullable = true;
                REFER2.ReadOnly = false;
                REFER2.Insertable = true;
                REFER2.Updatable = true;
                REFER2.TabStop = true;
                preValue = REFER2.EditValue;       // 기존 값 보관.
                if (iString.ISNull(REFER2_DATA_TYPE.EditValue) == "NUMBER".ToString())
                {
                    REFER2.EditValue = null;
                    REFER2.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                    REFER2.EditValue = iString.ISDecimaltoZero(preValue);
                }
                else if (iString.ISNull(REFER2_DATA_TYPE.EditValue) == "RATE".ToString())
                {
                    REFER2.EditValue = null;
                    REFER2.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                    REFER2.NumberDecimalDigits = 4;
                    REFER2.EditValue = iString.ISDecimaltoZero(preValue);
                }
                //else if (iString.ISNull(REFER2_DATA_TYPE.EditValue) == "DATE".ToString())
                //{
                //    REFER2.EditAdvType = ISUtil.Enum.EditAdvType.DateTimeEdit;
                //    REFER2.EditValue = SLIP_DATE.EditValue;
                //}
                else if (iString.ISNull(REFER2_YN.EditValue, "N") == "Y".ToString())
                {
                    REFER2.Nullable = false;
                }
            }
            REFER3.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
            REFER3.NumberDecimalDigits = 0;
            if (iString.ISNull(REFER3_YN.EditValue, "F") == "F".ToString())
            {
                REFER3.ReadOnly = true;
                REFER3.Insertable = false;
                REFER3.Updatable = false;
                REFER3.TabStop = false;
            }
            else
            {
                REFER3.Nullable = true;
                REFER3.ReadOnly = false;
                REFER3.Insertable = true;
                REFER3.Updatable = true;
                REFER3.TabStop = true;
                preValue = REFER3.EditValue;       // 기존 값 보관.
                if (iString.ISNull(REFER3_DATA_TYPE.EditValue) == "NUMBER".ToString())
                {
                    REFER3.EditValue = null;
                    REFER3.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                    REFER3.EditValue = iString.ISDecimaltoZero(preValue);
                }
                else if (iString.ISNull(REFER3_DATA_TYPE.EditValue) == "RATE".ToString())
                {
                    REFER3.EditValue = null;
                    REFER3.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                    REFER3.NumberDecimalDigits = 4;
                    REFER3.EditValue = iString.ISDecimaltoZero(preValue);
                }
                //else if (iString.ISNull(REFER3_DATA_TYPE.EditValue) == "DATE".ToString())
                //{
                //    REFER3.EditAdvType = ISUtil.Enum.EditAdvType.DateTimeEdit;
                //    REFER3.EditValue = SLIP_DATE.EditValue;
                //}
                else if (iString.ISNull(REFER3_YN.EditValue, "N") == "Y".ToString())
                {
                    REFER3.Nullable = false;
                }
            }
            REFER4.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
            REFER4.NumberDecimalDigits = 0;
            if (iString.ISNull(REFER4_YN.EditValue, "F") == "F".ToString())
            {
                REFER4.ReadOnly = true;
                REFER4.Insertable = false;
                REFER4.Updatable = false;
                REFER4.TabStop = false;
            }
            else
            {
                REFER4.Nullable = true;
                REFER4.ReadOnly = false;
                REFER4.Insertable = true;
                REFER4.Updatable = true;
                REFER4.TabStop = true;
                preValue = REFER4.EditValue;       // 기존 값 보관.
                if (iString.ISNull(REFER4_DATA_TYPE.EditValue) == "NUMBER".ToString())
                {
                    REFER4.EditValue = null;
                    REFER4.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                    REFER4.EditValue = iString.ISDecimaltoZero(preValue);
                }
                else if (iString.ISNull(REFER4_DATA_TYPE.EditValue) == "RATE".ToString())
                {
                    REFER4.EditValue = null;
                    REFER4.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                    REFER4.NumberDecimalDigits = 4;
                    REFER4.EditValue = iString.ISDecimaltoZero(preValue);
                }
                //else if (iString.ISNull(REFER4_DATA_TYPE.EditValue) == "DATE".ToString())
                //{
                //    REFER4.EditAdvType = ISUtil.Enum.EditAdvType.DateTimeEdit;
                //    REFER4.EditValue = SLIP_DATE.EditValue;
                //}
                else if (iString.ISNull(REFER4_YN.EditValue, "N") == "Y".ToString())
                {
                    REFER4.Nullable = false;
                }
            }
            REFER5.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
            REFER5.NumberDecimalDigits = 0;
            if (iString.ISNull(REFER5_YN.EditValue, "F") == "F".ToString())
            {
                REFER5.ReadOnly = true;
                REFER5.Insertable = false;
                REFER5.Updatable = false;
                REFER5.TabStop = false;
            }
            else
            {
                REFER5.Nullable = true;
                REFER5.ReadOnly = false;
                REFER5.Insertable = true;
                REFER5.Updatable = true;
                REFER5.TabStop = true;
                preValue = REFER5.EditValue;       // 기존 값 보관.
                if (iString.ISNull(REFER5_DATA_TYPE.EditValue) == "NUMBER".ToString())
                {
                    REFER5.EditValue = null;
                    REFER5.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                    REFER5.EditValue = iString.ISDecimaltoZero(preValue);
                }
                else if (iString.ISNull(REFER5_DATA_TYPE.EditValue) == "RATE".ToString())
                {
                    REFER5.EditValue = null;
                    REFER5.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                    REFER5.NumberDecimalDigits = 4;
                    REFER5.EditValue = iString.ISDecimaltoZero(preValue);
                }
                //else if (iString.ISNull(REFER5_DATA_TYPE.EditValue) == "DATE".ToString())
                //{
                //    REFER5.EditAdvType = ISUtil.Enum.EditAdvType.DateTimeEdit;
                //    REFER5.EditValue = SLIP_DATE.EditValue;
                //}
                else if (iString.ISNull(REFER5_YN.EditValue, "N") == "Y".ToString())
                {
                    REFER5.Nullable = false;
                }
            }
            REFER6.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
            REFER6.NumberDecimalDigits = 0;
            if (iString.ISNull(REFER6_YN.EditValue, "F") == "F".ToString())
            {
                REFER6.ReadOnly = true;
                REFER6.Insertable = false;
                REFER6.Updatable = false;
                REFER6.TabStop = false;
            }
            else
            {
                REFER6.Nullable = true;
                REFER6.ReadOnly = false;
                REFER6.Insertable = true;
                REFER6.Updatable = true;
                REFER6.TabStop = true;
                preValue = REFER6.EditValue;       // 기존 값 보관.
                if (iString.ISNull(REFER6_DATA_TYPE.EditValue) == "NUMBER".ToString())
                {
                    REFER6.EditValue = null;
                    REFER6.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                    REFER6.EditValue = iString.ISDecimaltoZero(preValue);
                }
                else if (iString.ISNull(REFER6_DATA_TYPE.EditValue) == "RATE".ToString())
                {
                    REFER6.EditValue = null;
                    REFER6.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                    REFER6.NumberDecimalDigits = 4;
                    REFER6.EditValue = iString.ISDecimaltoZero(preValue);
                }
                //else if (iString.ISNull(REFER6_DATA_TYPE.EditValue) == "DATE".ToString())
                //{
                //    REFER6.EditAdvType = ISUtil.Enum.EditAdvType.DateTimeEdit;
                //    REFER6.EditValue = SLIP_DATE.EditValue;
                //}
                else if (iString.ISNull(REFER6_YN.EditValue, "N") == "Y".ToString())
                {
                    REFER6.Nullable = false;
                }
            }
            REFER7.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
            REFER7.NumberDecimalDigits = 0;
            if (iString.ISNull(REFER7_YN.EditValue, "F") == "F".ToString())
            {
                REFER7.ReadOnly = true;
                REFER7.Insertable = false;
                REFER7.Updatable = false;
                REFER7.TabStop = false;
            }
            else
            {
                REFER7.Nullable = true;
                REFER7.ReadOnly = false;
                REFER7.Insertable = true;
                REFER7.Updatable = true;
                REFER7.TabStop = true;
                preValue = REFER7.EditValue;       // 기존 값 보관.
                if (iString.ISNull(REFER7_DATA_TYPE.EditValue) == "NUMBER".ToString())
                {
                    REFER7.EditValue = null;
                    REFER7.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                    REFER7.EditValue = iString.ISDecimaltoZero(preValue);
                }
                else if (iString.ISNull(REFER7_DATA_TYPE.EditValue) == "RATE".ToString())
                {
                    REFER7.EditValue = null;
                    REFER7.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                    REFER7.NumberDecimalDigits = 4;
                    REFER7.EditValue = iString.ISDecimaltoZero(preValue);
                }
                //else if (iString.ISNull(REFER7_DATA_TYPE.EditValue) == "DATE".ToString())
                //{
                //    REFER7.EditAdvType = ISUtil.Enum.EditAdvType.DateTimeEdit;
                //    REFER7.EditValue = SLIP_DATE.EditValue;
                //}
                else if (iString.ISNull(REFER7_YN.EditValue, "N") == "Y".ToString())
                {
                    REFER7.Nullable = false;
                }
            }
            REFER8.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
            REFER8.NumberDecimalDigits = 0;
            if (iString.ISNull(REFER8_YN.EditValue, "F") == "F".ToString())
            {
                REFER8.ReadOnly = true;
                REFER8.Insertable = false;
                REFER8.Updatable = false;
                REFER8.TabStop = false;
            }
            else
            {
                REFER8.Nullable = true;
                REFER8.ReadOnly = false;
                REFER8.Insertable = true;
                REFER8.Updatable = true;
                REFER8.TabStop = true;
                preValue = REFER8.EditValue;       // 기존 값 보관.
                if (iString.ISNull(REFER8_DATA_TYPE.EditValue) == "NUMBER".ToString())
                {
                    REFER8.EditValue = null;
                    REFER8.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                    REFER8.EditValue = iString.ISDecimaltoZero(preValue);
                }
                else if (iString.ISNull(REFER8_DATA_TYPE.EditValue) == "RATE".ToString())
                {
                    REFER8.EditValue = null;
                    REFER8.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                    REFER8.NumberDecimalDigits = 4;
                    REFER8.EditValue = iString.ISDecimaltoZero(preValue);
                }
                //else if (iString.ISNull(REFER8_DATA_TYPE.EditValue) == "DATE".ToString())
                //{
                //    REFER8.EditAdvType = ISUtil.Enum.EditAdvType.DateTimeEdit;
                //    REFER8.EditValue = SLIP_DATE.EditValue;
                //}
                else if (iString.ISNull(REFER8_YN.EditValue, "N") == "Y".ToString())
                {
                    REFER8.Nullable = false;
                }
            }
///////////////////////////////////////////////////////////////////////////////////////////////////            
            if (iString.ISNull(MANAGEMENT1_LOOKUP_YN.EditValue, "N") == "Y".ToString())
            {
                MANAGEMENT1.LookupAdapter = ilaMANAGEMENT1;
            }
            else
            {
                MANAGEMENT1.LookupAdapter = null;
            }

            if (iString.ISNull(MANAGEMENT2_LOOKUP_YN.EditValue, "N") == "Y".ToString())
            {
                MANAGEMENT2.LookupAdapter = ilaMANAGEMENT2;
            }
            else
            {
                MANAGEMENT2.LookupAdapter = null;
            }
            if (iString.ISNull(REFER1_LOOKUP_YN.EditValue, "N") == "Y".ToString())
            {
                REFER1.LookupAdapter = ilaREFER1;
            }
            else
            {
                REFER1.LookupAdapter = null;
            }

            if (iString.ISNull(REFER2_LOOKUP_YN.EditValue, "N") == "Y".ToString())
            {
                REFER2.LookupAdapter = ilaREFER2;
            }
            else
            {
                REFER2.LookupAdapter = null;
            }

            if (iString.ISNull(REFER3_LOOKUP_YN.EditValue, "N") == "Y".ToString())
            {
                REFER3.LookupAdapter = ilaREFER3;
            }
            else
            {
                REFER3.LookupAdapter = null;
            }

            if (iString.ISNull(REFER4_LOOKUP_YN.EditValue, "N") == "Y".ToString())
            {
                REFER4.LookupAdapter = ilaREFER4;
            }
            else
            {
                REFER4.LookupAdapter = null;
            }

            if (iString.ISNull(REFER5_LOOKUP_YN.EditValue, "N") == "Y".ToString())
            {
                REFER5.LookupAdapter = ilaREFER5;
            }
            else
            {
                REFER5.LookupAdapter = null;
            }

            if (iString.ISNull(REFER6_LOOKUP_YN.EditValue, "N") == "Y".ToString())
            {
                REFER6.LookupAdapter = ilaREFER6;
            }
            else
            {
                REFER6.LookupAdapter = null;
            }

            if (iString.ISNull(REFER7_LOOKUP_YN.EditValue, "N") == "Y".ToString())
            {
                REFER7.LookupAdapter = ilaREFER7;
            }
            else
            {
                REFER7.LookupAdapter = null;
            }

            if (iString.ISNull(REFER8_LOOKUP_YN.EditValue, "N") == "Y".ToString())
            {
                REFER8.LookupAdapter = ilaREFER8;
            }
            else
            {
                REFER8.LookupAdapter = null;
            }
            Application.DoEvents();
        }

        private void Init_Set_Item_Prompt(DataRow pDataRow)
        {
            if (pDataRow == null)
            {
                return;
            }
            ///////////////////////////////////////////////////////////////////////////////////////////////////
            CURRENCY_DESC.Nullable = true;
            if (iString.ISNull(pDataRow["CURRENCY_ENABLED_FLAG"], "N") == "Y".ToString())
            {
                CURRENCY_DESC.Nullable = false;
            }
            ///////////////////////////////////////////////////////////////////////////////////////////////////
            MANAGEMENT1.NumberDecimalDigits = 0;
            if (iString.ISNull(pDataRow["MANAGEMENT1_YN"], "F") == "F".ToString())
            {
                MANAGEMENT1.Nullable = true;
                MANAGEMENT1.ReadOnly = true;
                MANAGEMENT1.Insertable = false;
                MANAGEMENT1.Updatable = false;
                MANAGEMENT1.TabStop = false;
                MANAGEMENT1.Refresh();
            }
            else
            {
                MANAGEMENT1.Nullable = true;
                MANAGEMENT1.ReadOnly = false;
                MANAGEMENT1.Insertable = true;
                MANAGEMENT1.Updatable = true;
                MANAGEMENT1.TabStop = true;
                if (iString.ISNull(pDataRow["MANAGEMENT1_DATA_TYPE"]) == "NUMBER".ToString())
                {
                    MANAGEMENT1.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                }
                else if (iString.ISNull(pDataRow["MANAGEMENT1_DATA_TYPE"]) == "RATE".ToString())
                {
                    MANAGEMENT1.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                    MANAGEMENT1.NumberDecimalDigits = 4;
                }
                else
                {
                    MANAGEMENT1.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
                }
                if (iString.ISNull(pDataRow["MANAGEMENT1_YN"], "N") == "Y".ToString())
                {
                    MANAGEMENT1.Nullable = false;
                    MANAGEMENT1.ReadOnly = false;
                }
                MANAGEMENT1.Refresh();
            }
            MANAGEMENT2.NumberDecimalDigits = 0;
            if (iString.ISNull(pDataRow["MANAGEMENT2_YN"], "F") == "F".ToString())
            {
                MANAGEMENT2.Nullable = true;
                MANAGEMENT2.ReadOnly = true;
                MANAGEMENT2.Insertable = false;
                MANAGEMENT2.Updatable = false;
                MANAGEMENT2.TabStop = false;
                MANAGEMENT2.Refresh();
            }
            else
            {
                MANAGEMENT2.Nullable = true;
                MANAGEMENT2.ReadOnly = false;
                MANAGEMENT2.Insertable = true;
                MANAGEMENT2.Updatable = true;
                MANAGEMENT2.TabStop = true;
                if (iString.ISNull(pDataRow["MANAGEMENT2_DATA_TYPE"]) == "NUMBER".ToString())
                {
                    MANAGEMENT2.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                }
                else if (iString.ISNull(pDataRow["MANAGEMENT2_DATA_TYPE"]) == "RATE".ToString())
                {
                    MANAGEMENT2.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                    MANAGEMENT2.NumberDecimalDigits = 4;
                }
                else
                {
                    MANAGEMENT2.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
                }
                MANAGEMENT2.Refresh();
                if (iString.ISNull(pDataRow["MANAGEMENT2_YN"], "N") == "Y".ToString())
                {
                    MANAGEMENT2.Nullable = false;
                    MANAGEMENT2.ReadOnly = false;
                }
            }
            REFER1.NumberDecimalDigits = 0;
            if (iString.ISNull(pDataRow["REFER1_YN"], "F") == "F".ToString())
            {
                REFER1.Nullable = true;
                REFER1.ReadOnly = true;
                REFER1.Insertable = false;
                REFER1.Updatable = false;
                REFER1.TabStop = false;
                REFER1.Refresh();
            }
            else
            {
                REFER1.Nullable = true;
                REFER1.ReadOnly = false;
                REFER1.Insertable = true;
                REFER1.Updatable = true;
                REFER1.TabStop = true;
                if (iString.ISNull(pDataRow["REFER1_DATA_TYPE"]) == "NUMBER".ToString())
                {
                    REFER1.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                }
                else if (iString.ISNull(pDataRow["REFER1_DATA_TYPE"]) == "RATE".ToString())
                {
                    REFER1.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                    REFER1.NumberDecimalDigits = 4;
                }
                else
                {
                    REFER1.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
                }
                REFER1.Refresh();
                if (iString.ISNull(pDataRow["REFER1_YN"], "N") == "Y".ToString())
                {
                    REFER1.Nullable = false;
                    REFER1.ReadOnly = false;
                }
            }
            REFER2.NumberDecimalDigits = 0;
            if (iString.ISNull(pDataRow["REFER2_YN"], "F") == "F".ToString())
            {
                REFER2.Nullable = true;
                REFER2.ReadOnly = true;
                REFER2.Insertable = false;
                REFER2.Updatable = false;
                REFER2.TabStop = false;
                REFER2.Refresh();
            }
            else
            {
                REFER2.Nullable = true;
                REFER2.ReadOnly = false;
                REFER2.Insertable = true;
                REFER2.Updatable = true;
                REFER2.TabStop = true;
                if (iString.ISNull(pDataRow["REFER2_DATA_TYPE"]) == "NUMBER".ToString())
                {
                    REFER2.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                }
                else if (iString.ISNull(pDataRow["REFER2_DATA_TYPE"]) == "RATE".ToString())
                {
                    REFER2.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                    REFER2.NumberDecimalDigits = 4;
                }
                else
                {
                    REFER2.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
                }
                REFER2.Refresh();
                if (iString.ISNull(pDataRow["REFER2_YN"], "N") == "Y".ToString())
                {
                    REFER2.Nullable = false;
                    REFER2.ReadOnly = false;
                }
            }
            REFER3.NumberDecimalDigits = 0;
            if (iString.ISNull(pDataRow["REFER3_YN"], "F") == "F".ToString())
            {
                REFER3.Nullable = true;
                REFER3.ReadOnly = true;
                REFER3.Insertable = false;
                REFER3.Updatable = false;
                REFER3.TabStop = false;
                REFER3.Refresh();
            }
            else
            {
                REFER3.Nullable = true;
                REFER3.ReadOnly = false;
                REFER3.Insertable = true;
                REFER3.Updatable = true;
                REFER3.TabStop = true;
                if (iString.ISNull(pDataRow["REFER3_DATA_TYPE"]) == "NUMBER".ToString())
                {
                    REFER3.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                }
                else if (iString.ISNull(pDataRow["REFER3_DATA_TYPE"]) == "RATE".ToString())
                {
                    REFER3.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                    REFER3.NumberDecimalDigits = 4;
                }
                else
                {
                    REFER3.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
                }
                REFER3.Refresh();
                if (iString.ISNull(pDataRow["REFER3_YN"], "N") == "Y".ToString())
                {
                    REFER3.Nullable = false;
                    REFER3.ReadOnly = false;
                }
            }
            REFER4.NumberDecimalDigits = 0;
            if (iString.ISNull(pDataRow["REFER4_YN"], "F") == "F".ToString())
            {
                REFER4.Nullable = true;
                REFER4.ReadOnly = true;
                REFER4.Insertable = false;
                REFER4.Updatable = false;
                REFER4.TabStop = false;
                REFER4.Refresh();
            }
            else
            {
                REFER4.Nullable = true;
                REFER4.ReadOnly = false;
                REFER4.Insertable = true;
                REFER4.Updatable = true;
                REFER4.TabStop = true;
                if (iString.ISNull(pDataRow["REFER4_DATA_TYPE"]) == "NUMBER".ToString())
                {
                    REFER4.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                }
                else if (iString.ISNull(pDataRow["REFER4_DATA_TYPE"]) == "RATE".ToString())
                {
                    REFER4.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                    REFER4.NumberDecimalDigits = 4;
                }
                else
                {
                    REFER4.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
                }
                REFER4.Refresh();
                if (iString.ISNull(pDataRow["REFER4_YN"], "N") == "Y".ToString())
                {
                    REFER4.Nullable = false;
                    REFER4.ReadOnly = false;
                }
            }
            REFER5.NumberDecimalDigits = 0;
            if (iString.ISNull(pDataRow["REFER5_YN"], "F") == "F".ToString())
            {
                REFER5.Nullable = true;
                REFER5.ReadOnly = true;
                REFER5.Insertable = false;
                REFER5.Updatable = false;
                REFER5.TabStop = false;
                REFER5.Refresh();
            }
            else
            {
                REFER5.Nullable = true;
                REFER5.ReadOnly = false;
                REFER5.Insertable = true;
                REFER5.Updatable = true;
                REFER5.TabStop = true;
                if (iString.ISNull(pDataRow["REFER5_DATA_TYPE"]) == "NUMBER".ToString())
                {
                    REFER5.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                }
                else if (iString.ISNull(pDataRow["REFER5_DATA_TYPE"]) == "RATE".ToString())
                {
                    REFER5.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                    REFER5.NumberDecimalDigits = 4;
                }
                else
                {
                    REFER5.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
                }
                REFER5.Refresh();
                if (iString.ISNull(pDataRow["REFER5_YN"], "N") == "Y".ToString())
                {
                    REFER5.Nullable = false;
                    REFER5.ReadOnly = false;
                }
            }
            REFER6.NumberDecimalDigits = 0;
            if (iString.ISNull(pDataRow["REFER6_YN"], "F") == "F".ToString())
            {
                REFER6.Nullable = true;
                REFER6.ReadOnly = true;
                REFER6.Insertable = false;
                REFER6.Updatable = false;
                REFER6.TabStop = false;
                REFER6.Refresh();
            }
            else
            {
                REFER6.Nullable = true;
                REFER6.ReadOnly = false;
                REFER6.Insertable = true;
                REFER6.Updatable = true;
                REFER6.TabStop = true;
                if (iString.ISNull(pDataRow["REFER6_DATA_TYPE"]) == "NUMBER".ToString())
                {
                    REFER6.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                }
                else if (iString.ISNull(pDataRow["REFER6_DATA_TYPE"]) == "RATE".ToString())
                {
                    REFER6.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                    REFER6.NumberDecimalDigits = 4;
                }
                else
                {
                    REFER6.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
                }
                REFER6.Refresh();
                if (iString.ISNull(pDataRow["REFER6_YN"], "N") == "Y".ToString())
                {
                    REFER6.Nullable = false;
                    REFER6.ReadOnly = false;
                }
            }
            REFER7.NumberDecimalDigits = 0;
            if (iString.ISNull(pDataRow["REFER7_YN"], "F") == "F".ToString())
            {
                REFER7.Nullable = true;
                REFER7.ReadOnly = true;
                REFER7.Insertable = false;
                REFER7.Updatable = false;
                REFER7.TabStop = false;
                REFER7.Refresh();
            }
            else
            {
                REFER7.Nullable = true;
                REFER7.ReadOnly = false;
                REFER7.Insertable = true;
                REFER7.Updatable = true;
                REFER7.TabStop = true;
                if (iString.ISNull(pDataRow["REFER7_DATA_TYPE"]) == "NUMBER".ToString())
                {
                    REFER7.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                }
                else if (iString.ISNull(pDataRow["REFER7_DATA_TYPE"]) == "RATE".ToString())
                {
                    REFER7.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                    REFER7.NumberDecimalDigits = 4;
                }
                else
                {
                    REFER7.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
                }
                REFER7.Refresh();
                if (iString.ISNull(pDataRow["REFER7_YN"], "N") == "Y".ToString())
                {
                    REFER7.Nullable = false;
                    REFER7.ReadOnly = false;
                }
            }
            REFER8.NumberDecimalDigits = 0;
            if (iString.ISNull(pDataRow["REFER8_YN"], "F") == "F".ToString())
            {
                REFER8.Nullable = true;
                REFER8.ReadOnly = true;
                REFER8.Insertable = false;
                REFER8.Updatable = false;
                REFER8.TabStop = false;
                REFER8.Refresh();
            }
            else
            {
                REFER8.Nullable = true;
                REFER8.ReadOnly = false;
                REFER8.Insertable = true;
                REFER8.Updatable = true;
                REFER8.TabStop = true;
                if (iString.ISNull(pDataRow["REFER8_DATA_TYPE"]) == "NUMBER".ToString())
                {
                    REFER8.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                }
                else if (iString.ISNull(pDataRow["REFER8_DATA_TYPE"]) == "RATE".ToString())
                {
                    REFER8.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                    REFER8.NumberDecimalDigits = 4;
                }
                else
                {
                    REFER8.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
                }
                REFER8.Refresh();
                if (iString.ISNull(pDataRow["REFER8_YN"], "N") == "Y".ToString())
                {
                    REFER8.Nullable = false;
                    REFER8.ReadOnly = false;
                }
            }
            ///////////////////////////////////////////////////////////////////////////////////////////////////            
            if (iString.ISNull(pDataRow["MANAGEMENT1_LOOKUP_YN"], "N") == "Y".ToString())
            {
                MANAGEMENT1.LookupAdapter = ilaMANAGEMENT1;
            }
            else
            {
                MANAGEMENT1.LookupAdapter = null;
            }

            if (iString.ISNull(pDataRow["MANAGEMENT2_LOOKUP_YN"], "N") == "Y".ToString())
            {
                MANAGEMENT2.LookupAdapter = ilaMANAGEMENT2;
            }
            else
            {
                MANAGEMENT2.LookupAdapter = null;
            }
            if (iString.ISNull(pDataRow["REFER1_LOOKUP_YN"], "N") == "Y".ToString())
            {
                REFER1.LookupAdapter = ilaREFER1;
            }
            else
            {
                REFER1.LookupAdapter = null;
            }

            if (iString.ISNull(pDataRow["REFER2_LOOKUP_YN"], "N") == "Y".ToString())
            {
                REFER2.LookupAdapter = ilaREFER2;
            }
            else
            {
                REFER2.LookupAdapter = null;
            }

            if (iString.ISNull(pDataRow["REFER3_LOOKUP_YN"], "N") == "Y".ToString())
            {
                REFER3.LookupAdapter = ilaREFER3;
            }
            else
            {
                REFER3.LookupAdapter = null;
            }

            if (iString.ISNull(pDataRow["REFER4_LOOKUP_YN"], "N") == "Y".ToString())
            {
                REFER4.LookupAdapter = ilaREFER4;
            }
            else
            {
                REFER4.LookupAdapter = null;
            }

            if (iString.ISNull(pDataRow["REFER5_LOOKUP_YN"], "N") == "Y".ToString())
            {
                REFER5.LookupAdapter = ilaREFER5;
            }
            else
            {
                REFER5.LookupAdapter = null;
            }

            if (iString.ISNull(pDataRow["REFER6_LOOKUP_YN"], "N") == "Y".ToString())
            {
                REFER6.LookupAdapter = ilaREFER6;
            }
            else
            {
                REFER6.LookupAdapter = null;
            }

            if (iString.ISNull(pDataRow["REFER7_LOOKUP_YN"], "N") == "Y".ToString())
            {
                REFER7.LookupAdapter = ilaREFER7;
            }
            else
            {
                REFER7.LookupAdapter = null;
            }

            if (iString.ISNull(pDataRow["REFER8_LOOKUP_YN"], "N") == "Y".ToString())
            {
                REFER8.LookupAdapter = ilaREFER8;
            }
            else
            {
                REFER8.LookupAdapter = null;
            }
        }

        private void Init_Control_Management_Value()
        {
            igrSLIP_LINE.SetCellValue("MANAGEMENT1", null);
            igrSLIP_LINE.SetCellValue("MANAGEMENT1_DESC", null);
            igrSLIP_LINE.SetCellValue("MANAGEMENT2", null);
            igrSLIP_LINE.SetCellValue("MANAGEMENT2_DESC", null);
            igrSLIP_LINE.SetCellValue("REFER1", null);
            igrSLIP_LINE.SetCellValue("REFER1_DESC", null);
            igrSLIP_LINE.SetCellValue("REFER2", null);
            igrSLIP_LINE.SetCellValue("REFER2_DESC", null);
            igrSLIP_LINE.SetCellValue("REFER3", null);
            igrSLIP_LINE.SetCellValue("REFER3_DESC", null);
            igrSLIP_LINE.SetCellValue("REFER4", null);
            igrSLIP_LINE.SetCellValue("REFER4_DESC", null);
            igrSLIP_LINE.SetCellValue("REFER5", null);
            igrSLIP_LINE.SetCellValue("REFER5_DESC", null);
            igrSLIP_LINE.SetCellValue("REFER6", null);
            igrSLIP_LINE.SetCellValue("REFER6_DESC", null);
            igrSLIP_LINE.SetCellValue("REFER7", null);
            igrSLIP_LINE.SetCellValue("REFER7_DESC", null);
            igrSLIP_LINE.SetCellValue("REFER8", null);
            igrSLIP_LINE.SetCellValue("REFER8_DESC", null);
        }

        private void Init_Default_Value()
        {
            int mPreviousRowPosition = idaSLIP_LINE.CurrentRowPosition() - 1;
            object mPrevious_Code;
            object mPrevious_Name;
            if (iString.ISNull(MANAGEMENT1_DATA_TYPE.EditValue) == "NUMBER".ToString())
            {
            }
            else if (iString.ISNull(MANAGEMENT1_DATA_TYPE.EditValue) == "RATE".ToString())
            {
            }
            else if (iString.ISNull(MANAGEMENT1_DATA_TYPE.EditValue) == "DATE".ToString())
            {
                if (iString.ISNull(MANAGEMENT1.EditValue) == string.Empty && iString.ISNull(SLIP_DATE.EditValue) != string.Empty)
                {
                    MANAGEMENT1.EditValue = Convert.ToDateTime(SLIP_DATE.EditValue).ToShortDateString();
                }
            }
            if (mPreviousRowPosition > -1
                && iString.ISNull(MANAGEMENT1_LOOKUP_TYPE.EditValue) != string.Empty
                && iString.ISNull(MANAGEMENT1_LOOKUP_TYPE.EditValue) == iString.ISNull(idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["MANAGEMENT1_LOOKUP_TYPE"]))
            {//MANAGEMENT1_LOOKUP_TYPE
                mPrevious_Code = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["MANAGEMENT1"];
                mPrevious_Name = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["MANAGEMENT1_DESC"];

                MANAGEMENT1.EditValue = mPrevious_Code;
                MANAGEMENT1_DESC.EditValue = mPrevious_Name;
            }

            if (iString.ISNull(MANAGEMENT2_DATA_TYPE.EditValue) == "NUMBER".ToString())
            {
            }
            else if (iString.ISNull(MANAGEMENT2_DATA_TYPE.EditValue) == "RATE".ToString())
            {
            }
            else if (iString.ISNull(MANAGEMENT2_DATA_TYPE.EditValue) == "DATE".ToString())
            {
                if (iString.ISNull(MANAGEMENT2.EditValue) == string.Empty && iString.ISNull(SLIP_DATE.EditValue) != string.Empty)
                {
                    MANAGEMENT2.EditValue = Convert.ToDateTime(SLIP_DATE.EditValue).ToShortDateString();
                }
            }
            if (mPreviousRowPosition > -1
                && iString.ISNull(MANAGEMENT2_LOOKUP_TYPE.EditValue) != string.Empty
                && iString.ISNull(MANAGEMENT2_LOOKUP_TYPE.EditValue) == iString.ISNull(idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["MANAGEMENT2_LOOKUP_TYPE"]))
            {//MANAGEMENT2_LOOKUP_TYPE
                mPrevious_Code = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["MANAGEMENT2"];
                mPrevious_Name = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["MANAGEMENT2_DESC"];

                MANAGEMENT2.EditValue = mPrevious_Code;
                MANAGEMENT2_DESC.EditValue = mPrevious_Name;
            }

            if (iString.ISNull(REFER1_DATA_TYPE.EditValue) == "NUMBER".ToString())
            {
            }
            else if (iString.ISNull(REFER1_DATA_TYPE.EditValue) == "RATE".ToString())
            {
            }
            else if (iString.ISNull(REFER1_DATA_TYPE.EditValue) == "DATE".ToString())
            {
                if (iString.ISNull(REFER1.EditValue) == string.Empty && iString.ISNull(SLIP_DATE.EditValue) != string.Empty)
                {
                    REFER1.EditValue = Convert.ToDateTime(SLIP_DATE.EditValue).ToShortDateString();
                }
            }
            if (mPreviousRowPosition > -1
                && iString.ISNull(REFER1_LOOKUP_TYPE.EditValue) != string.Empty
                && iString.ISNull(REFER1_LOOKUP_TYPE.EditValue) == iString.ISNull(idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER1_LOOKUP_TYPE"]))
            {//REFER1_LOOKUP_TYPE
                mPrevious_Code = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER1"];
                mPrevious_Name = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER1_DESC"];

                REFER1.EditValue = mPrevious_Code;
                REFER1_DESC.EditValue = mPrevious_Name;
            }

            if (iString.ISNull(REFER2_DATA_TYPE.EditValue) == "NUMBER".ToString())
            {
            }
            else if (iString.ISNull(REFER2_DATA_TYPE.EditValue) == "RATE".ToString())
            {
            }
            else if (iString.ISNull(REFER2_DATA_TYPE.EditValue) == "DATE".ToString())
            {
                if (iString.ISNull(REFER2.EditValue) == string.Empty && iString.ISNull(SLIP_DATE.EditValue) != string.Empty)
                {
                    REFER2.EditValue = Convert.ToDateTime(SLIP_DATE.EditValue).ToShortDateString();
                }
            }
            if (mPreviousRowPosition > -1
                && iString.ISNull(REFER2_LOOKUP_TYPE.EditValue) != string.Empty
                && iString.ISNull(REFER2_LOOKUP_TYPE.EditValue) == iString.ISNull(idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER2_LOOKUP_TYPE"]))
            {//REFER2_LOOKUP_TYPE
                mPrevious_Code = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER2"];
                mPrevious_Name = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER2_DESC"];

                REFER2.EditValue = mPrevious_Code;
                REFER2_DESC.EditValue = mPrevious_Name;
            }

            if (iString.ISNull(REFER3_DATA_TYPE.EditValue) == "NUMBER".ToString())
            {
            }
            else if (iString.ISNull(REFER3_DATA_TYPE.EditValue) == "RATE".ToString())
            {
            }
            else if (iString.ISNull(REFER3_DATA_TYPE.EditValue) == "DATE".ToString())
            {
                if (iString.ISNull(REFER3.EditValue) == string.Empty && iString.ISNull(SLIP_DATE.EditValue) != string.Empty)
                {
                    REFER3.EditValue = Convert.ToDateTime(SLIP_DATE.EditValue).ToShortDateString();
                }
            }
            if (mPreviousRowPosition > -1
                && iString.ISNull(REFER3_LOOKUP_TYPE.EditValue) != string.Empty
                && iString.ISNull(REFER3_LOOKUP_TYPE.EditValue) == iString.ISNull(idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER3_LOOKUP_TYPE"]))
            {//REFER3_LOOKUP_TYPE
                mPrevious_Code = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER3"];
                mPrevious_Name = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER3_DESC"];

                REFER3.EditValue = mPrevious_Code;
                REFER3_DESC.EditValue = mPrevious_Name;
            }

            if (iString.ISNull(REFER4_DATA_TYPE.EditValue) == "NUMBER".ToString())
            {
            }
            else if (iString.ISNull(REFER4_DATA_TYPE.EditValue) == "RATE".ToString())
            {
            }
            else if (iString.ISNull(REFER4_DATA_TYPE.EditValue) == "DATE".ToString())
            {
                if (iString.ISNull(REFER4.EditValue) == string.Empty && iString.ISNull(SLIP_DATE.EditValue) != string.Empty)
                {
                    REFER4.EditValue = Convert.ToDateTime(SLIP_DATE.EditValue).ToShortDateString();
                }
            }
            if (mPreviousRowPosition > -1
                && iString.ISNull(REFER4_LOOKUP_TYPE.EditValue) != string.Empty
                && iString.ISNull(REFER4_LOOKUP_TYPE.EditValue) == iString.ISNull(idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER4_LOOKUP_TYPE"]))
            {//REFER4_LOOKUP_TYPE
                mPrevious_Code = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER4"];
                mPrevious_Name = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER4_DESC"];

                REFER4.EditValue = mPrevious_Code;
                REFER4_DESC.EditValue = mPrevious_Name;
            }

            if (iString.ISNull(REFER5_DATA_TYPE.EditValue) == "NUMBER".ToString())
            {
            }
            else if (iString.ISNull(REFER5_DATA_TYPE.EditValue) == "RATE".ToString())
            {
            }
            else if (iString.ISNull(REFER5_DATA_TYPE.EditValue) == "DATE".ToString())
            {
                if (iString.ISNull(REFER5.EditValue) == string.Empty && iString.ISNull(SLIP_DATE.EditValue) != string.Empty)
                {
                    REFER5.EditValue = Convert.ToDateTime(SLIP_DATE.EditValue).ToShortDateString();
                }
            }
            if (mPreviousRowPosition > -1
                && iString.ISNull(REFER5_LOOKUP_TYPE.EditValue) != string.Empty
                && iString.ISNull(REFER5_LOOKUP_TYPE.EditValue) == iString.ISNull(idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER5_LOOKUP_TYPE"]))
            {//REFER5_LOOKUP_TYPE
                mPrevious_Code = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER5"];
                mPrevious_Name = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER5_DESC"];

                REFER5.EditValue = mPrevious_Code;
                REFER5_DESC.EditValue = mPrevious_Name;
            }

            if (iString.ISNull(REFER6_DATA_TYPE.EditValue) == "NUMBER".ToString())
            {
            }
            else if (iString.ISNull(REFER6_DATA_TYPE.EditValue) == "RATE".ToString())
            {
            }
            else if (iString.ISNull(REFER6_DATA_TYPE.EditValue) == "DATE".ToString())
            {
                if (iString.ISNull(REFER6.EditValue) == string.Empty && iString.ISNull(SLIP_DATE.EditValue) != string.Empty)
                {
                    REFER6.EditValue = Convert.ToDateTime(SLIP_DATE.EditValue).ToShortDateString();
                }
            }
            if (mPreviousRowPosition > -1
                && iString.ISNull(REFER6_LOOKUP_TYPE.EditValue) != string.Empty
                && iString.ISNull(REFER6_LOOKUP_TYPE.EditValue) == iString.ISNull(idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER6_LOOKUP_TYPE"]))
            {//REFER6_LOOKUP_TYPE
                mPrevious_Code = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER6"];
                mPrevious_Name = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER6_DESC"];

                REFER6.EditValue = mPrevious_Code;
                REFER6_DESC.EditValue = mPrevious_Name;
            }

            if (iString.ISNull(REFER7_DATA_TYPE.EditValue) == "NUMBER".ToString())
            {
            }
            else if (iString.ISNull(REFER7_DATA_TYPE.EditValue) == "RATE".ToString())
            {
            }
            else if (iString.ISNull(REFER7_DATA_TYPE.EditValue) == "DATE".ToString())
            {
                if (iString.ISNull(REFER7.EditValue) == string.Empty && iString.ISNull(SLIP_DATE.EditValue) != string.Empty)
                {
                    REFER7.EditValue = Convert.ToDateTime(SLIP_DATE.EditValue).ToShortDateString();
                }
            }
            if (mPreviousRowPosition > -1
                && iString.ISNull(REFER7_LOOKUP_TYPE.EditValue) != string.Empty
                && iString.ISNull(REFER7_LOOKUP_TYPE.EditValue) == iString.ISNull(idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER7_LOOKUP_TYPE"]))
            {//REFER7_LOOKUP_TYPE
                mPrevious_Code = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER7"];
                mPrevious_Name = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER7_DESC"];

                REFER7.EditValue = mPrevious_Code;
                REFER7_DESC.EditValue = mPrevious_Name;
            }

            if (iString.ISNull(REFER8_DATA_TYPE.EditValue) == "NUMBER".ToString())
            {
            }
            else if (iString.ISNull(REFER8_DATA_TYPE.EditValue) == "RATE".ToString())
            {
            }
            else if (iString.ISNull(REFER8_DATA_TYPE.EditValue) == "DATE".ToString())
            {
                if (iString.ISNull(REFER8.EditValue) == string.Empty && iString.ISNull(SLIP_DATE.EditValue) != string.Empty)
                {
                    REFER8.EditValue = Convert.ToDateTime(SLIP_DATE.EditValue).ToShortDateString();
                }
            }
            if (mPreviousRowPosition > -1
                && iString.ISNull(REFER8_LOOKUP_TYPE.EditValue) != string.Empty
                && iString.ISNull(REFER8_LOOKUP_TYPE.EditValue) == iString.ISNull(idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER8_LOOKUP_TYPE"]))
            {//REFER8_LOOKUP_TYPE
                mPrevious_Code = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER8"];
                mPrevious_Name = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER8_DESC"];

                REFER8.EditValue = mPrevious_Code;
                REFER8_DESC.EditValue = mPrevious_Name;
            }
        }

        private void Init_Currency_Code()
        {
            if (iString.ISNull(CURRENCY_ENABLED_FLAG.EditValue, "N") == "Y")
            {
                CURRENCY_DESC.ReadOnly = false;
                CURRENCY_DESC.Insertable = true;
                CURRENCY_DESC.Updatable = true;
                CURRENCY_DESC.TabStop = true;
            }
            else
            {
                CURRENCY_DESC.ReadOnly = true;
                CURRENCY_DESC.Insertable = false;
                CURRENCY_DESC.Updatable = false;
                CURRENCY_DESC.TabStop = false;
            }
        }

        private void Init_Currency_Amount()
        {
            if (iString.ISNull(CURRENCY_CODE.EditValue) == string.Empty || CURRENCY_CODE.EditValue.ToString() == mCurrency_Code.ToString())
            {
                EXCHANGE_RATE.EditValue = DBNull.Value;

                if (iString.ISDecimaltoZero(GL_CURRENCY_AMOUNT.EditValue) != Convert.ToDecimal(0))
                {
                    GL_CURRENCY_AMOUNT.EditValue = 0;
                }
                EXCHANGE_RATE.ReadOnly = true;
                EXCHANGE_RATE.Insertable = false;
                EXCHANGE_RATE.Updatable = false;

                GL_CURRENCY_AMOUNT.ReadOnly = true;
                GL_CURRENCY_AMOUNT.Insertable = false;
                GL_CURRENCY_AMOUNT.Updatable = false;

                EXCHANGE_RATE.TabStop = false;
                GL_CURRENCY_AMOUNT.TabStop = false;
            }
            else
            {
                EXCHANGE_RATE.ReadOnly = false;
                EXCHANGE_RATE.Insertable = true;
                EXCHANGE_RATE.Updatable = true;

                GL_CURRENCY_AMOUNT.ReadOnly = false;
                GL_CURRENCY_AMOUNT.Insertable = true;
                GL_CURRENCY_AMOUNT.Updatable = true;

                EXCHANGE_RATE.TabStop = true;
                GL_CURRENCY_AMOUNT.TabStop = true;
            }
        }

        private bool Validate_Date(object pValue)
        {
            bool mValidate = false;

            if (iString.ISNull(pValue).Length != 10)
            {
                return mValidate;
            }
            try
            {
                DateTime mDate = Convert.ToDateTime(pValue);
            }
            catch (Exception ex)
            {
                return mValidate;
            }

            mValidate = true;
            return mValidate;
        }

        #endregion

        #region ----- Events -----

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    Search_DB();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    if (idaSLIP_LINE.IsFocused)
                    {
                        idaSLIP_LINE.AddOver();
                        InsertSlipLine();
                    }
                    else
                    {
                        idaSLIP_HEADER.AddOver();
                        idaSLIP_LINE.AddOver();
                        InsertSlipLine();
                        InsertSlipHeader();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaSLIP_LINE.IsFocused)
                    {
                        idaSLIP_LINE.AddUnder();
                        InsertSlipLine();
                    }
                    else
                    {
                        idaSLIP_HEADER.AddUnder();
                        idaSLIP_LINE.AddUnder();
                        InsertSlipLine();
                        InsertSlipHeader();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    Init_DR_CR_Amount();
                    // 전표번호 채번//
                    GetSlipNum();
                    idaSLIP_HEADER.Update();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaSLIP_HEADER.IsFocused)
                    {
                        idaBILL_MASTER.Cancel();
                        idaSLIP_LINE.Cancel();
                        idaSLIP_HEADER.Cancel();
                    }
                    else if (idaSLIP_LINE.IsFocused)
                    {
                        idaBILL_MASTER.Cancel();
                        idaSLIP_LINE.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaSLIP_HEADER.IsFocused)
                    {
                        for (int r = 0; r < igrSLIP_LINE.RowCount; r++)
                        {
                            idaSLIP_LINE.Delete();
                        }
                        idaSLIP_HEADER.Delete();
                    }
                    else if (idaSLIP_LINE.IsFocused)
                    {
                        idaBILL_MASTER.Delete();
                        idaSLIP_LINE.Delete();
                    }
                }
            }
        }

        #endregion;

        #region ----- Form Event ----- 
        
        private void FCMF0206_Load(object sender, EventArgs e)
        {
            idaSLIP_HEADER.FillSchema();
            SLIP_QUERY_STATUS.EditValue = "NON-QUERY";
            SLIP_DATE_FR_0.EditValue = iDate.ISMonth_1st(DateTime.Today);
            SLIP_DATE_TO_0.EditValue = iDate.ISGetDate();

            // 회계장부 정보 설정.
            GetAccountBook();

            // 콤퍼넌트 동기화.
            // 콤퍼넌트 동기화.
            Init_Currency_Code();
            ibtSUB_FORM.Visible = false;

            itbSLIP.SelectedIndex = 1;
            itbSLIP.SelectedTab.Focus();
        }

        private void GL_CURRENCY_AMOUNT_CurrentEditValidating(object pSender, ISEditAdvValidatingEventArgs e)
        {
            Init_GL_Amount();
        }

        private void GL_AMOUNT_CurrentEditValidated(object pSender, ISEditAdvValidatedEventArgs e)
        {
            Init_DR_CR_Amount();
        }

        private void igrSLIP_LIST_CellDoubleClick(object pSender)
        {
            if (igrSLIP_LIST.RowCount > 0)
            {
                if (iString.ISNull(igrSLIP_LIST.GetCellValue("SLIP_HEADER_ID")) != string.Empty)
                {
                    SLIP_QUERY_STATUS.EditValue = "QUERY";
                    itbSLIP.SelectedIndex = 1;
                    itbSLIP.SelectedTab.Focus();
                    idaSLIP_HEADER.SetSelectParamValue("W_SLIP_HEADER_ID", igrSLIP_LIST.GetCellValue("SLIP_HEADER_ID"));
                    idaSLIP_HEADER.Fill();
                    SLIP_TYPE_NAME.Focus();
                }
            }
        }

        private void CURRENCY_DESC_CurrentEditValidating(object pSender, ISEditAdvValidatingEventArgs e)
        {
            Init_GL_Amount();
        }

        private void EXCHANGE_RATE_CurrentEditValidating(object pSender, ISEditAdvValidatingEventArgs e)
        {
            Init_GL_Amount();
        }

        private void ibtSUB_FORM_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (iString.ISNull(igrSLIP_LINE.GetCellValue("ACCOUNT_DR_CR")) == string.Empty)
            {// 차대구분
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10122"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                ACCOUNT_DR_CR.Focus();
                return;
            }
            if (iString.ISNull(igrSLIP_LINE.GetCellValue("ACCOUNT_CONTROL_ID")) == string.Empty)
            {// 계정과목.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10123"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                ACCOUNT_CODE.Focus();
                return;
            }
            if (iString.ISNull(igrSLIP_LINE.GetCellValue("CURRENCY_CODE")) == string.Empty)
            {// 통화
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10124"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CURRENCY_DESC.Focus();
                return;
            }
            if (iString.ISNull(igrSLIP_LINE.GetCellValue("CURRENCY_ENABLED_FLAG")) == "Y".ToString())
            {// 외화 계좌.
                if (mCurrency_Code.ToString() != igrSLIP_LINE.GetCellValue("CURRENCY_CODE").ToString() 
                      && iString.ISDecimaltoZero(igrSLIP_LINE.GetCellValue("EXCHANGE_RATE")) == Convert.ToInt32(0))
                {// 입력통화와 기본 통화가 다를경우 환율입력 체크.
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10125"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    EXCHANGE_RATE.Focus();
                    return;
                }
                if (mCurrency_Code.ToString() != igrSLIP_LINE.GetCellValue("CURRENCY_CODE").ToString() 
                      && iString.ISDecimaltoZero(igrSLIP_LINE.GetCellValue("GL_CURRENCY_AMOUNT")) == Convert.ToInt32(0))
                {// 입력통화와 기본 통화가 다를경우 외화금액 체크.
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10127"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    GL_CURRENCY_AMOUNT.Focus();
                    return;
                }
            }
            if (iString.ISNull(ACCOUNT_CLASS_TYPE.EditValue) != "LIQUIDATE".ToString())
            {
                if (iString.ISDecimaltoZero(igrSLIP_LINE.GetCellValue("GL_AMOUNT")) == Convert.ToInt32(0))
                {// 금액
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10126"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    GL_AMOUNT.Focus();
                    return;
                }
            }

            System.Windows.Forms.DialogResult dlgResultValue;
            //if (iString.ISNull(ACCOUNT_CLASS_TYPE.EditValue) == "RECEIVABLE_NOTE".ToString())
            //{                                
            //    if (iString.ISNumtoZero(igrBILL_MASTER.RowCount) == Convert.ToInt32(0))
            //    {
            //        idaBILL_MASTER.AddUnder();
            //        // 기본 설정값 설정.
            //        //igrBILL_MASTER.SetCellValue("CUSTOMER_ID", CUSTOMER_ID.EditValue);
            //        igrBILL_MASTER.SetCellValue("CUSTOMER_NAME", MANAGEMENT1_DESC.EditValue);
            //        igrBILL_MASTER.SetCellValue("TAX_REG_NO", MANAGEMENT1.EditValue);
            //        igrBILL_MASTER.SetCellValue("ISSUE_DATE", GL_DATE.EditValue);
            //        igrBILL_MASTER.SetCellValue("DUE_DATE", GL_DATE.EditValue);
            //        igrBILL_MASTER.SetCellValue("BILL_AMOUNT", GL_AMOUNT.EditValue);
            //        igrBILL_MASTER.SetCellValue("RECEIPT_DEPT_ID", DEPT_ID.EditValue);
            //        igrBILL_MASTER.SetCellValue("RECEIPT_DEPT_NAME", DEPT_NAME.EditValue);
            //        igrBILL_MASTER.SetCellValue("KEEP_DEPT_ID", DEPT_ID.EditValue);
            //        igrBILL_MASTER.SetCellValue("KEEP_DEPT_NAME", DEPT_NAME.EditValue);
            //        igrBILL_MASTER.SetCellValue("RECEIPT_DATE", GL_DATE.EditValue);
            //    }

            //    Form vFCMF0206_BILL_MASTER = new FCMF0292_BILL_MASTER(isAppInterfaceAdv1.AppInterface, igrBILL_MASTER);
            //    Application.UseWaitCursor = true;
            //    dlgResultValue = vFCMF0206_BILL_MASTER.ShowDialog();
            //    if (dlgResultValue == DialogResult.OK)
            //    {
            //        //어음번호.
            //        MANAGEMENT1.EditValue = igrBILL_MASTER.GetCellValue("BILL_NUM");
            //        // 발행일자.
            //        //REFER_DATE1.EditValue = igrBILL_MASTER.GetCellValue("ISSUE_DATE");
            //        //// 만기일자.
            //        //REFER_DATE2.EditValue = igrBILL_MASTER.GetCellValue("DUE_DATE");
            //    }
            //    else
            //    {
            //        idaBILL_MASTER.Cancel();
            //    }
            //    vFCMF0206_BILL_MASTER.Dispose();                
            //}
            //else 
            if (iString.ISNull(ACCOUNT_CLASS_TYPE.EditValue) == "LIQUIDATE".ToString())
            {
                int vCURRENT_ROW_INDEX = igrSLIP_LINE.RowIndex;
                if (vCURRENT_ROW_INDEX < 0)
                {
                    return;
                }

                object mBasic_Currency_Code = mCurrency_Code;
                decimal mExchange_Rate = iString.ISDecimaltoZero(EXCHANGE_RATE.EditValue);
                Form vFCMF0292_UNLIQUIDATE_LIST = new FCMF0292_UNLIQUIDATE_LIST(isAppInterfaceAdv1.AppInterface, idaUNLIQUIDATE_LIST
                    , ACCOUNT_CODE.EditValue, ACCOUNT_DESC.EditValue, ACCOUNT_CONTROL_ID.EditValue
                    , MANAGEMENT1_DESC.EditValue, MANAGEMENT1.EditValue, mBasic_Currency_Code, CURRENCY_CODE.EditValue, mExchange_Rate);
                dlgResultValue = vFCMF0292_UNLIQUIDATE_LIST.ShowDialog();
                if (dlgResultValue == DialogResult.OK)
                {
                    this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
                    string mOld_Account_Dr_Cr = iString.ISNull(igrSLIP_LINE.GetCellValue(vCURRENT_ROW_INDEX, igrSLIP_LINE.GetColumnToIndex("ACCOUNT_DR_CR")), "-");
                    int mOld_Account_Control_ID = iString.ISNumtoZero(igrSLIP_LINE.GetCellValue(vCURRENT_ROW_INDEX, igrSLIP_LINE.GetColumnToIndex("ACCOUNT_CONTROL_ID")), -1);
                    string mOld_Currency_Code = iString.ISNull(igrSLIP_LINE.GetCellValue(vCURRENT_ROW_INDEX, igrSLIP_LINE.GetColumnToIndex("CURRENCY_CODE")), "-");
                    string mOld_Mangement1 = iString.ISNull(igrSLIP_LINE.GetCellValue(vCURRENT_ROW_INDEX, igrSLIP_LINE.GetColumnToIndex("MANAGEMENT1")), "-");
                    
                    // 신규값.
                    string mNew_Account_Dr_Cr;
                    int mNew_Account_Control_ID;
                    string mNew_Currency_Code;
                    string mNew_Mangement1;

                    bool mInsert_Check_YN = false;
                    bool mUpdate_Check_YN = false;                      // for 문을 통해 기존 자료 update 여부 체크.
                    int mSlip_RowCount = Convert.ToInt32(0);            // 전표 라인 count
                    for (int r = 0; r < idaUNLIQUIDATE_LIST.OraSelectData.Rows.Count; r++)
                    {//기존 전표라인 삭제(차대구분, 계정관리ID, 통화, 고객사, 단 현재 로우는 제외.)
                        if ("Y".ToString() == idaUNLIQUIDATE_LIST.OraSelectData.Rows[r]["CHECK_YN"].ToString()
                            && iString.ISDecimaltoZero(idaUNLIQUIDATE_LIST.OraSelectData.Rows[r]["NEW_GL_AMOUNT"]) != Convert.ToDecimal(0))
                        {
                            for (int sr = mSlip_RowCount; sr < igrSLIP_LINE.RowCount; sr++)
                            {// 전표.
                                mNew_Account_Dr_Cr = iString.ISNull(igrSLIP_LINE.GetCellValue(sr, igrSLIP_LINE.GetColumnToIndex("ACCOUNT_DR_CR")));
                                mNew_Account_Control_ID = iString.ISNumtoZero(igrSLIP_LINE.GetCellValue(sr, igrSLIP_LINE.GetColumnToIndex("ACCOUNT_CONTROL_ID")));
                                mNew_Currency_Code = iString.ISNull(igrSLIP_LINE.GetCellValue(sr, igrSLIP_LINE.GetColumnToIndex("CURRENCY_CODE")));
                                mNew_Mangement1 = iString.ISNull(igrSLIP_LINE.GetCellValue(sr, igrSLIP_LINE.GetColumnToIndex("MANAGEMENT1")));

                                if (mOld_Account_Dr_Cr == mNew_Account_Dr_Cr && mOld_Account_Control_ID == mNew_Account_Control_ID
                                    && mOld_Currency_Code == mNew_Currency_Code && mOld_Mangement1 == mNew_Mangement1)
                                {// 전표에 동일한 정보 존재.                                    
                                    igrSLIP_LINE.SetCellValue(sr, igrSLIP_LINE.GetColumnToIndex("UNLIQUIDATE_SLIP_LINE_ID"), idaUNLIQUIDATE_LIST.OraSelectData.Rows[r]["SLIP_LINE_ID"]);
                                    igrSLIP_LINE.SetCellValue(sr, igrSLIP_LINE.GetColumnToIndex("EXCHANGE_RATE"), idaUNLIQUIDATE_LIST.OraSelectData.Rows[r]["EXCHANGE_RATE"]);
                                    igrSLIP_LINE.SetCellValue(sr, igrSLIP_LINE.GetColumnToIndex("GL_CURRENCY_AMOUNT"), idaUNLIQUIDATE_LIST.OraSelectData.Rows[r]["NEW_CURRENCY_AMOUNT"]);
                                    igrSLIP_LINE.SetCellValue(sr, igrSLIP_LINE.GetColumnToIndex("GL_AMOUNT"), idaUNLIQUIDATE_LIST.OraSelectData.Rows[r]["NEW_GL_AMOUNT"]);
                                    mSlip_RowCount = sr + 1;
                                    mUpdate_Check_YN = true;
                                    break;
                                }
                            }

                            if (mCurrency_Code.ToString() != mOld_Currency_Code.ToString())
                            {// 기본통화가 아닐경우 환차손익 체크.
                                decimal mOld_Exchange_Rate = iString.ISDecimaltoZero(idaUNLIQUIDATE_LIST.OraSelectData.Rows[r]["EXCHANGE_RATE"]);
                                decimal mCurrency_Amount = iString.ISDecimaltoZero(idaUNLIQUIDATE_LIST.OraSelectData.Rows[r]["NEW_CURRENCY_AMOUNT"]);
                                decimal mGL_Amount = iString.ISDecimaltoZero(idaUNLIQUIDATE_LIST.OraSelectData.Rows[r]["NEW_GL_AMOUNT"]);
                                if (Init_Exchange_Profit_Loss(mExchange_Rate, mOld_Exchange_Rate, mCurrency_Amount, mGL_Amount, vCURRENT_ROW_INDEX) == true)
                                {
                                    mUpdate_Check_YN = true;
                                }
                            }

                            if (mUpdate_Check_YN == false)
                            {
                                idaSLIP_LINE.AddUnder();
                                for (int c = 0; c < igrSLIP_LINE.ColCount; c++)
                                {
                                    igrSLIP_LINE.SetCellValue(igrSLIP_LINE.RowIndex, c, igrSLIP_LINE.GetCellValue(vCURRENT_ROW_INDEX, c));
                                }
                                // 반제 SLIP_LINE_ID.
                                EXCHANGE_RATE.EditValue = iString.ISDecimaltoZero(idaUNLIQUIDATE_LIST.OraSelectData.Rows[r]["EXCHANGE_RATE"]);
                                GL_CURRENCY_AMOUNT.EditValue = iString.ISDecimaltoZero(idaUNLIQUIDATE_LIST.OraSelectData.Rows[r]["NEW_CURRENCY_AMOUNT"]);
                                GL_AMOUNT.EditValue = iString.ISDecimaltoZero(idaUNLIQUIDATE_LIST.OraSelectData.Rows[r]["NEW_GL_AMOUNT"]);
                                mInsert_Check_YN = true;
                            }
                            Init_DR_CR_Amount();
                            mUpdate_Check_YN = false;
                        }
                    }

                    if (mInsert_Check_YN == false)
                    {
                        for (int rc = igrSLIP_LINE.RowCount; mSlip_RowCount < rc; rc--)
                        {//기존 전표라인 삭제(차대구분, 계정관리ID, 통화, 고객사, 단 현재 로우는 제외.)
                            mNew_Account_Dr_Cr = iString.ISNull(igrSLIP_LINE.GetCellValue(rc - 1, igrSLIP_LINE.GetColumnToIndex("ACCOUNT_DR_CR")));
                            mNew_Account_Control_ID = iString.ISNumtoZero(igrSLIP_LINE.GetCellValue(rc - 1, igrSLIP_LINE.GetColumnToIndex("ACCOUNT_CONTROL_ID")));
                            mNew_Currency_Code = iString.ISNull(igrSLIP_LINE.GetCellValue(rc - 1, igrSLIP_LINE.GetColumnToIndex("CURRENCY_CODE")));
                            mNew_Mangement1 = iString.ISNull(igrSLIP_LINE.GetCellValue(rc - 1, igrSLIP_LINE.GetColumnToIndex("MANAGEMENT1")));
                            if (mOld_Account_Dr_Cr == mNew_Account_Dr_Cr
                                && mOld_Account_Control_ID == mNew_Account_Control_ID
                                && mOld_Currency_Code == mNew_Currency_Code
                                && mOld_Mangement1 == mNew_Mangement1)
                            {
                                igrSLIP_LINE.CurrentCellMoveTo(rc - 1, 0);
                                idaSLIP_LINE.Delete();
                            }
                        }
                    }
                }
                Application.DoEvents();
                igrSLIP_LINE.Invalidate();
                if (idaSLIP_LINE.OraSelectData.Rows.Count == Convert.ToInt32(0))
                {
                    idaSLIP_LINE.Cancel();
                }
                idaUNLIQUIDATE_LIST.Cancel();
                Application.DoEvents();
                vFCMF0292_UNLIQUIDATE_LIST.Dispose();                
            }
            this.Cursor = System.Windows.Forms.Cursors.Default;
            Application.UseWaitCursor = false;
        }

        private void SLIP_DATE_CurrentEditValidating(object pSender, ISEditAdvValidatingEventArgs e)
        {
            GL_DATE.EditValue = SLIP_DATE.EditValue;
        }
        #endregion

        #region ----- Lookup Event ----- 
        
        private void ilaSLIP_NUM_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildSLIP_NUM.SetLookupParamValue("W_SLIP_TYPE_CLASS", "BL");
        }

        private void ilaSLIP_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter_W("SLIP_TYPE", " VALUE1 = 'BL'", "Y");
        }

        private void ilaDEPT_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaSLIP_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter_W("SLIP_TYPE", " VALUE1 = 'BL'", "Y");
        }

        private void ilaREQ_PAYABLE_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("PAYABLE_TYPE", "Y");
        }

        private void ilaREQ_BANK_ACCOUNT_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildREQ_BANK_ACCOUNT.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaACCOUNT_DR_CR_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("ACCOUNT_DR_CR", "Y");
        }

        private void ilaACCOUNT_DR_CR_SelectedRowData(object pSender)
        {
            Set_Control_Item_Prompt();
            //Init_Control_Item_Prompt();
            Init_Set_Item_Prompt(idaSLIP_LINE.CurrentRow);
            Init_Control_Management_Value();
            Init_Currency_Code();
            Init_Default_Value();
            Init_DR_CR_Amount();
            GetSubForm();
            //Set_Control_Item_Prompt();
            //Init_Control_Item_Prompt();
            //Init_Control_Management_Value();
            //Init_DR_CR_Amount();
            //GetSubForm();
        }

        private void ilaACCOUNT_CONTROL_SelectedRowData(object pSender)
        {
            Set_Control_Item_Prompt();
            //Init_Control_Item_Prompt();
            Init_Set_Item_Prompt(idaSLIP_LINE.CurrentRow);
            Init_Control_Management_Value();
            Init_Currency_Code();
            Init_Default_Value();
            Init_DR_CR_Amount();
            GetSubForm();
        }

        private void ilaCURRENCY_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCURRENCY.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaCURRENCY_SelectedRowData(object pSender)
        {
            if (iString.ISNull(CURRENCY_DESC.EditValue) != string.Empty)
            {
                Init_Currency_Amount();
                if (CURRENCY_CODE.EditValue.ToString() != mCurrency_Code.ToString())
                {
                    idcEXCHANGE_RATE.ExecuteNonQuery();
                    EXCHANGE_RATE.EditValue = idcEXCHANGE_RATE.GetCommandParamValue("X_EXCHANGE_RATE");

                    Init_GL_Amount();
                }
            }
        }

        private void ilaACCOUNT_CONTROL_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildACCOUNT_CONTROL.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaBUDGET_DEPT_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT.SetLookupParamValue("W_ENABLED_YN", "Y");
        }
      
        private void ilaMANAGEMENT1_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetManagementParameter("MANAGEMENT1_ID", "Y");
        }

        private void ilaMANAGEMENT2_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetManagementParameter("MANAGEMENT2_ID", "Y");            
        }

        private void ilaREFER1_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetManagementParameter("REFER1_ID", "Y");
        }

        private void ilaREFER2_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetManagementParameter("REFER2_ID", "Y");
        }

        private void ilaREFER3_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetManagementParameter("REFER3_ID", "Y");
        }

        private void ilaREFER4_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetManagementParameter("REFER4_ID", "Y");
        }

        private void ilaREFER5_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetManagementParameter("REFER5_ID", "Y");
        }

        private void ilaREFER6_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetManagementParameter("REFER6_ID", "Y");
        }

        private void ilaREFER7_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetManagementParameter("REFER7_ID", "Y");
        }

        private void ilaREFER8_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetManagementParameter("REFER8_ID", "Y");
        }

        #endregion       

        #region ----- Adapter Event -----
        private void idaSLIP_HEADER_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["SLIP_TYPE"]) == string.Empty)
            {// 전표유형
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10116"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            
            if (iString.ISNull(e.Row["SLIP_DATE"]) == string.Empty)
            {// 기표일자.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10117"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["SLIP_NUM"]) == string.Empty)
            {// 기표번호
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10118"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["DEPT_ID"]) == string.Empty)
            {// 발의부서
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10119"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["PERSON_ID"]) == string.Empty)
            {// 발의부서
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10121"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }            
        }

        private void idaSLIP_HEADER_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                if (e.Row["CLOSED_YN"].ToString() == "Y".ToString())
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10052"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
            }
        }

        private void idaSLIP_LINE_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["ACCOUNT_DR_CR"]) == string.Empty)
            {// 차대구분
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10122"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["ACCOUNT_CONTROL_ID"]) == string.Empty)
            {// 계정과목.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10123"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["ACCOUNT_CODE"]) == string.Empty)
            {// 계정과목
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10123"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["CURRENCY_CODE"]) == string.Empty)
            {// 통화
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10124"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["CURRENCY_ENABLED_FLAG"]) == "Y".ToString())
            {// 외화 계좌.
                if (mCurrency_Code.ToString() != e.Row["CURRENCY_CODE"].ToString() && iString.ISDecimaltoZero(e.Row["EXCHANGE_RATE"]) == Convert.ToInt32(0))
                {// 입력통화와 기본 통화가 다를경우 환율입력 체크.
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10125"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }                
            }
            if (iString.ISNull(e.Row["MANAGEMENT1"]) == string.Empty && iString.ISNull(e.Row["MANAGEMENT1_YN"], "N") == "Y".ToString())
            {// 관리항목1 필수 입력 체크
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", string.Format("{0}{1}", "&&FIELD_NAME:=", e.Row["MANAGEMENT1_NAME"])), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["MANAGEMENT1_DATA_TYPE"]) == "DATE".ToString())
            {
                if (Validate_Date(e.Row["MANAGEMENT1"]) == false)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10178"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;                    
                }
            }
            if (iString.ISNull(e.Row["MANAGEMENT2"]) == string.Empty && iString.ISNull(e.Row["MANAGEMENT2_YN"], "N") == "Y".ToString())
            {// 관리항목2 필수 입력 체크
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", string.Format("{0}{1}", "&&FIELD_NAME:=", e.Row["MANAGEMENT2_NAME"])), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["MANAGEMENT2_DATA_TYPE"]) == "DATE".ToString())
            {
                if (Validate_Date(e.Row["MANAGEMENT2"]) == false)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10178"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
            }
            if (iString.ISNull(e.Row["REFER1"]) == string.Empty && iString.ISNull(e.Row["REFER1_YN"], "N") == "Y".ToString())
            {// 참고항목1 필수 입력 체크
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", string.Format("{0}{1}", "&&FIELD_NAME:=", e.Row["REFER1_NAME"])), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["REFER1_DATA_TYPE"]) == "DATE".ToString())
            {
                if (Validate_Date(e.Row["REFER1"]) == false)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10178"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
            }
            if (iString.ISNull(e.Row["REFER2"]) == string.Empty && iString.ISNull(e.Row["REFER2_YN"], "N") == "Y".ToString())
            {// 참고항목2 필수 입력 체크
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", string.Format("{0}{1}", "&&FIELD_NAME:=", e.Row["REFER2_NAME"])), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["REFER2_DATA_TYPE"]) == "DATE".ToString())
            {
                if (Validate_Date(e.Row["REFER2"]) == false)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10178"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
            }
            if (iString.ISNull(e.Row["REFER3"]) == string.Empty && iString.ISNull(e.Row["REFER3_YN"], "N") == "Y".ToString())
            {// 참고항목3 필수 입력 체크
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", string.Format("{0}{1}", "&&FIELD_NAME:=", e.Row["REFER3_NAME"])), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["REFER3_DATA_TYPE"]) == "DATE".ToString())
            {
                if (Validate_Date(e.Row["REFER3"]) == false)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10178"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
            }
            if (iString.ISNull(e.Row["REFER4"]) == string.Empty && iString.ISNull(e.Row["REFER4_YN"], "N") == "Y".ToString())
            {// 참고항목4 필수 입력 체크
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", string.Format("{0}{1}", "&&FIELD_NAME:=", e.Row["REFER4_NAME"])), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["REFER4_DATA_TYPE"]) == "DATE".ToString())
            {
                if (Validate_Date(e.Row["REFER4"]) == false)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10178"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
            }
            if (iString.ISNull(e.Row["REFER5"]) == string.Empty && iString.ISNull(e.Row["REFER5_YN"], "N") == "Y".ToString())
            {// 참고항목5 필수 입력 체크
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", string.Format("{0}{1}", "&&FIELD_NAME:=", e.Row["REFER5_NAME"])), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["REFER5_DATA_TYPE"]) == "DATE".ToString())
            {
                if (Validate_Date(e.Row["REFER5"]) == false)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10178"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
            }
            if (iString.ISNull(e.Row["REFER6"]) == string.Empty && iString.ISNull(e.Row["REFER6_YN"], "N") == "Y".ToString())
            {// 참고항목6 필수 입력 체크
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", string.Format("{0}{1}", "&&FIELD_NAME:=", e.Row["REFER6_NAME"])), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["REFER6_DATA_TYPE"]) == "DATE".ToString())
            {
                if (Validate_Date(e.Row["REFER6"]) == false)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10178"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
            }
            if (iString.ISNull(e.Row["REFER7"]) == string.Empty && iString.ISNull(e.Row["REFER7_YN"], "N") == "Y".ToString())
            {// 참고항목7 필수 입력 체크
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", string.Format("{0}{1}", "&&FIELD_NAME:=", e.Row["REFER7_NAME"])), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["REFER7_DATA_TYPE"]) == "DATE".ToString())
            {
                if (Validate_Date(e.Row["REFER7"]) == false)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10178"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
            }
            if (iString.ISNull(e.Row["REFER8"]) == string.Empty && iString.ISNull(e.Row["REFER8_YN"], "N") == "Y".ToString())
            {// 참고항목8 필수 입력 체크
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", string.Format("{0}{1}", "&&FIELD_NAME:=", e.Row["REFER8_NAME"])), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["REFER8_DATA_TYPE"]) == "DATE".ToString())
            {
                if (Validate_Date(e.Row["REFER8"]) == false)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10178"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
            }
        }

        private void idaSLIP_LINE_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                if (e.Row["CLOSED_YN"].ToString() == "Y".ToString())
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10052"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
            }
        }

        private void idaBILL_MASTER_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["BILL_NUM"]) == string.Empty)
            {// 어음번호
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10142"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            if (iString.ISNull(e.Row["BILL_TYPE"]) == string.Empty)
            {// 어음종류
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10143"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            if (iString.ISNull(e.Row["CUSTOMER_ID"]) == string.Empty)
            {// 고객정보
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10135"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            if (iString.ISNull(e.Row["ISSUE_DATE"]) == string.Empty)
            {// 발행일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10144"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            if (iString.ISNull(e.Row["DUE_DATE"]) == string.Empty)
            {// 만기일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10145"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            if (iString.ISNumtoZero(e.Row["BILL_AMOUNT"]) == 0)
            {// 어음금액
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10146"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            if (iString.ISNull(e.Row["RECEIPT_DATE"]) == string.Empty)
            {// 입금일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10147"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
        }

        private void idaSLIP_HEADER_UpdateCompleted(object pSender)
        {
            // Tab 이동 //
            idaSLIP_HEADER.SetSelectParamValue("W_SLIP_HEADER_ID", 0);
            idaSLIP_HEADER.Fill();
            itbSLIP.SelectedIndex = 0;
            itbSLIP.SelectedTab.Focus();
            Search_DB();
        }

        private void idaSLIP_LINE_NewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            Init_Currency_Code();
            Init_Currency_Amount();
            GetSubForm();
            if (SLIP_QUERY_STATUS.EditValue.ToString() != "QUERY".ToString())
            {
                Init_DR_CR_Amount();
            }
            Init_Total_GL_Amount();
        }

        private void idaSLIP_LINE_PreNewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            Init_Set_Item_Prompt(pBindingManager.DataRow);
        }

        #endregion

    }
}