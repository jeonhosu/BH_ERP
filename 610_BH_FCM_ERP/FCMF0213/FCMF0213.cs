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

namespace FCMF0213
{
    public partial class FCMF0213 : Office2007Form
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

        public FCMF0213()
        {
            InitializeComponent();
        }

        public FCMF0213(Form pMainForm, ISAppInterface pAppInterface)
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
            igrSLIP_LIST_IF.Focus();
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
                //REFER_RATE_PROMPT.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER_RATE_NAME"];
                //REFER_AMOUNT_PROMPT.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER_AMOUNT_NAME"];
                //REFER_DATE1_PROMPT.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER_DATE1_NAME"];
                //REFER_DATE2_PROMPT.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER_DATE2_NAME"];

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
                //VOUCH_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["VOUCH_YN"];
                //REFER_RATE_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER_RATE_YN"];
                //REFER_AMOUNT_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER_AMOUNT_YN"];
                //REFER_DATE1_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER_DATE1_YN"];
                //REFER_DATE2_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER_DATE2_YN"];

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
                //REFER_RATE_PROMPT.EditValue = null;
                //REFER_AMOUNT_PROMPT.EditValue = null;
                //REFER_DATE1_PROMPT.EditValue = null;
                //REFER_DATE2_PROMPT.EditValue = null;

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
                //VOUCH_YN.EditValue = "F".ToString();
                //REFER_RATE_YN.EditValue = "F".ToString();
                //REFER_AMOUNT_YN.EditValue = "F".ToString();
                //REFER_DATE1_YN.EditValue = "F".ToString();
                //REFER_DATE2_YN.EditValue = "F".ToString();


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
            //igrSLIP_LINE.SetCellValue("REFER_RATE_NAME", iString.ISNull(REFER_RATE_PROMPT.EditValue));
            //igrSLIP_LINE.SetCellValue("REFER_AMOUNT_NAME", iString.ISNull(REFER_AMOUNT_PROMPT.EditValue));
            //igrSLIP_LINE.SetCellValue("REFER_DATE1_NAME", iString.ISNull(REFER_DATE1_PROMPT.EditValue));
            //igrSLIP_LINE.SetCellValue("REFER_DATE2_NAME", iString.ISNull(REFER_DATE2_PROMPT.EditValue));

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
            //igrSLIP_LINE.SetCellValue("REFER_RATE_YN", iString.ISNull(REFER_RATE_YN.EditValue, "F"));
            //igrSLIP_LINE.SetCellValue("REFER_AMOUNT_YN", iString.ISNull(REFER_AMOUNT_YN.EditValue, "F"));
            //igrSLIP_LINE.SetCellValue("REFER_DATE1_YN", iString.ISNull(REFER_DATE1_YN.EditValue, "F"));
            //igrSLIP_LINE.SetCellValue("REFER_DATE2_YN", iString.ISNull(REFER_DATE2_YN.EditValue, "F"));
            //igrSLIP_LINE.SetCellValue("VOUCH_YN", iString.ISNull(VOUCH_YN.EditValue, "F"));

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
        }

        #endregion;

        #region ----- Initialize Event ----- 

        private void InsertSlipHeader()
        {
            itbSLIP.SelectedIndex = 1;
            itbSLIP.SelectedTab.Focus();
            
            SLIP_DATE.EditValue = DateTime.Today;

            idcDV_SLIP_TYPE.SetCommandParamValue("W_WHERE", "GROUP_CODE = 'SLIP_TYPE' AND VALUE1 = 'GE' ");
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
            
            JOB_NAME.Focus();
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

        private void Init_Total_GL_Amount()
        {
            SLIP_QUERY_STATUS.EditValue = "NON-QUERY";
            decimal vDR_Amount = Convert.ToDecimal(0);           
            if (igrSLIP_LINE.RowCount > 0)
            {
                for (int r = 0; r < igrSLIP_LINE.RowCount; r++)
                {
                    vDR_Amount = vDR_Amount + iString.ISDecimaltoZero(igrSLIP_LINE.GetCellValue(r, igrSLIP_LINE.GetColumnToIndex("GL_AMOUNT")));                    
                }
            }     
            TOTAL_AMOUNT.EditValue = iString.ISDecimaltoZero(vDR_Amount);
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

        private void Init_Currency()
        {
            if (iString.ISNull(CURRENCY_CODE.EditValue) == string.Empty || CURRENCY_CODE.EditValue.ToString() == mCurrency_Code.ToString())
            {
                EXCHANGE_RATE.EditValue = DBNull.Value;
                GL_CURRENCY_AMOUNT.EditValue = 0;

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
            catch
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
                    // 전표번호 채번//
                    GetSlipNum();
                    idaSLIP_HEADER.Update();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaSLIP_HEADER.IsFocused)
                    {                        
                        idaSLIP_LINE.Cancel();
                        idaSLIP_HEADER.Cancel();
                    }
                    else if (idaSLIP_LINE.IsFocused)
                    {
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
            Init_Currency();
        }

        private void GL_CURRENCY_AMOUNT_CurrentEditValidating(object pSender, ISEditAdvValidatingEventArgs e)
        {
            Init_GL_Amount();
        }

        private void GL_AMOUNT_CurrentEditValidated(object pSender, ISEditAdvValidatedEventArgs e)
        {
            Init_Total_GL_Amount();
        }

        private void igrSLIP_LIST_CellDoubleClick(object pSender)
        {
            if (igrSLIP_LIST_IF.RowCount > 0)
            {
                if (iString.ISNull(igrSLIP_LIST_IF.GetCellValue("HEADER_INTERFACE_ID")) != string.Empty)
                {
                    SLIP_QUERY_STATUS.EditValue = "QUERY";
                    itbSLIP.SelectedIndex = 1;
                    itbSLIP.SelectedTab.Focus();
                    idaSLIP_HEADER.SetSelectParamValue("W_HEADER_INTERFACE_ID", igrSLIP_LIST_IF.GetCellValue("HEADER_INTERFACE_ID"));
                    idaSLIP_HEADER.Fill();
                    SLIP_TYPE_NAME.Focus();
                }
            }
        }

        private void CURRENCY_DESC_CurrentEditValidating(object pSender, ISEditAdvValidatingEventArgs e)
        {
            Init_Currency();
        }

        private void EXCHANGE_RATE_CurrentEditValidating(object pSender, ISEditAdvValidatingEventArgs e)
        {
            Init_GL_Amount();
        }

        #endregion

        #region ----- Lookup Event ----- 
        
        private void ilaSLIP_NUM_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildSLIP_NUM.SetLookupParamValue("W_SLIP_TYPE_CLASS", "DW");
        }

        private void ilaSLIP_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter_W("SLIP_TYPE", " VALUE1 = 'GE'", "Y");
        }

        private void ilaJOB_CODE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildJOB_CODE.SetLookupParamValue("W_ENABLED_YN", "N");
        }

        private void ilaJOB_CODE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildJOB_CODE.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaDEPT_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaSLIP_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter_W("SLIP_TYPE", " VALUE1 = 'GE'", "Y");
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

        private void ilaACCOUNT_CONTROL_SelectedRowData(object pSender)
        {
            Set_Control_Item_Prompt();
            Init_Control_Item_Prompt();
            Init_Control_Management_Value();
        }

        private void ilaCURRENCY_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCURRENCY.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaCURRENCY_SelectedRowData(object pSender)
        {
            if (iString.ISNull(CURRENCY_DESC.EditValue) != string.Empty)
            {
                Init_Currency();
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
                if (e.Row["CONFIRM_YN"].ToString() == "Y".ToString())
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10115"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
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
                if (mCurrency_Code.ToString() != e.Row["CURRENCY_CODE"].ToString() && iString.ISDecimaltoZero(e.Row["GL_CURRENCY_AMOUNT"]) == Convert.ToInt32(0))
                {// 입력통화와 기본 통화가 다를경우 외화금액 체크.
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10127"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
            }
            //if(iString.ISNull(e.Row["GL_AMOUNT"]) == string.Empty)
            //{// 금액
            //    GL_AMOUNT.EditValue = 0;
            //}
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
                if (e.Row["CONFIRM_YN"].ToString() == "Y".ToString())
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10115"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
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
            Init_Control_Item_Prompt();            
            Init_Total_GL_Amount();
        }

        #endregion

    }
}