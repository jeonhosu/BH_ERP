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

namespace FCMF0291
{
    public partial class FCMF0291 : Office2007Form
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

        public FCMF0291()
        {
            InitializeComponent();
        }

        public FCMF0291(Form pMainForm, ISAppInterface pAppInterface)
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
                REFER_RATE_PROMPT.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER_RATE_NAME"];
                REFER_AMOUNT_PROMPT.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER_AMOUNT_NAME"];
                REFER_DATE1_PROMPT.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER_DATE1_NAME"];
                REFER_DATE2_PROMPT.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER_DATE2_NAME"];

                MANAGEMENT1_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["MANAGEMENT1_YN"];
                MANAGEMENT2_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["MANAGEMENT2_YN"];
                REFER1_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER1_YN"];
                REFER2_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER2_YN"];
                REFER3_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER3_YN"];
                REFER4_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER4_YN"];
                REFER5_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER5_YN"];
                VOUCH_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["VOUCH_YN"];
                REFER_RATE_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER_RATE_YN"];
                REFER_AMOUNT_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER_AMOUNT_YN"];
                REFER_DATE1_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER_DATE1_YN"];
                REFER_DATE2_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER_DATE2_YN"];


                MANAGEMENT1_LOOKUP_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["MANAGEMENT1_LOOKUP_YN"];
                MANAGEMENT2_LOOKUP_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["MANAGEMENT2_LOOKUP_YN"];
                REFER1_LOOKUP_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER1_LOOKUP_YN"];
                REFER2_LOOKUP_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER2_LOOKUP_YN"];
                REFER3_LOOKUP_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER3_LOOKUP_YN"];
                REFER4_LOOKUP_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER4_LOOKUP_YN"];
                REFER5_LOOKUP_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER5_LOOKUP_YN"];
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
                REFER_RATE_PROMPT.EditValue = null;
                REFER_AMOUNT_PROMPT.EditValue = null;
                REFER_DATE1_PROMPT.EditValue = null;
                REFER_DATE2_PROMPT.EditValue = null;

                MANAGEMENT1_YN.EditValue = "F".ToString();
                MANAGEMENT2_YN.EditValue = "F".ToString();
                REFER1_YN.EditValue = "F".ToString();
                REFER2_YN.EditValue = "F".ToString();
                REFER3_YN.EditValue = "F".ToString();
                REFER4_YN.EditValue = "F".ToString();
                REFER5_YN.EditValue = "F".ToString();
                VOUCH_YN.EditValue = "F".ToString();
                REFER_RATE_YN.EditValue = "F".ToString();
                REFER_AMOUNT_YN.EditValue = "F".ToString();
                REFER_DATE1_YN.EditValue = "F".ToString();
                REFER_DATE2_YN.EditValue = "F".ToString();


                MANAGEMENT1_LOOKUP_YN.EditValue = "N".ToString();
                MANAGEMENT2_LOOKUP_YN.EditValue = "N".ToString();
                REFER1_LOOKUP_YN.EditValue = "N".ToString();
                REFER2_LOOKUP_YN.EditValue = "N".ToString();
                REFER3_LOOKUP_YN.EditValue = "N".ToString();
                REFER4_LOOKUP_YN.EditValue = "N".ToString();
                REFER5_LOOKUP_YN.EditValue = "N".ToString();
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
            igrSLIP_LINE.SetCellValue("REFER_RATE_NAME", iString.ISNull(REFER_RATE_PROMPT.EditValue));
            igrSLIP_LINE.SetCellValue("REFER_AMOUNT_NAME", iString.ISNull(REFER_AMOUNT_PROMPT.EditValue));
            igrSLIP_LINE.SetCellValue("REFER_DATE1_NAME", iString.ISNull(REFER_DATE1_PROMPT.EditValue));
            igrSLIP_LINE.SetCellValue("REFER_DATE2_NAME", iString.ISNull(REFER_DATE2_PROMPT.EditValue));

            igrSLIP_LINE.SetCellValue("MANAGEMENT1_YN", iString.ISNull(MANAGEMENT1_YN.EditValue, "F"));
            igrSLIP_LINE.SetCellValue("MANAGEMENT2_YN", iString.ISNull(MANAGEMENT2_YN.EditValue, "F"));
            igrSLIP_LINE.SetCellValue("REFER1_YN", iString.ISNull(REFER1_YN.EditValue, "F"));
            igrSLIP_LINE.SetCellValue("REFER2_YN", iString.ISNull(REFER2_YN.EditValue, "F"));
            igrSLIP_LINE.SetCellValue("REFER3_YN", iString.ISNull(REFER3_YN.EditValue, "F"));
            igrSLIP_LINE.SetCellValue("REFER4_YN", iString.ISNull(REFER4_YN.EditValue, "F"));
            igrSLIP_LINE.SetCellValue("REFER5_YN", iString.ISNull(REFER5_YN.EditValue, "F"));
            igrSLIP_LINE.SetCellValue("REFER_RATE_YN", iString.ISNull(REFER_RATE_YN.EditValue, "F"));
            igrSLIP_LINE.SetCellValue("REFER_AMOUNT_YN", iString.ISNull(REFER_AMOUNT_YN.EditValue, "F"));
            igrSLIP_LINE.SetCellValue("REFER_DATE1_YN", iString.ISNull(REFER_DATE1_YN.EditValue, "F"));
            igrSLIP_LINE.SetCellValue("REFER_DATE2_YN", iString.ISNull(REFER_DATE2_YN.EditValue, "F"));
            igrSLIP_LINE.SetCellValue("VOUCH_YN", iString.ISNull(VOUCH_YN.EditValue, "F"));

            igrSLIP_LINE.SetCellValue("MANAGEMENT1_LOOKUP_YN", iString.ISNull(MANAGEMENT1_LOOKUP_YN.EditValue, "N"));
            igrSLIP_LINE.SetCellValue("MANAGEMENT2_LOOKUP_YN", iString.ISNull(MANAGEMENT2_LOOKUP_YN.EditValue, "N"));
            igrSLIP_LINE.SetCellValue("REFER1_LOOKUP_YN", iString.ISNull(REFER1_LOOKUP_YN.EditValue, "N"));
            igrSLIP_LINE.SetCellValue("REFER2_LOOKUP_YN", iString.ISNull(REFER2_LOOKUP_YN.EditValue, "N"));
            igrSLIP_LINE.SetCellValue("REFER3_LOOKUP_YN", iString.ISNull(REFER3_LOOKUP_YN.EditValue, "N"));
            igrSLIP_LINE.SetCellValue("REFER4_LOOKUP_YN", iString.ISNull(REFER4_LOOKUP_YN.EditValue, "N"));
            igrSLIP_LINE.SetCellValue("REFER5_LOOKUP_YN", iString.ISNull(REFER5_LOOKUP_YN.EditValue, "N"));            
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
        #endregion;

        #region ----- Initialize Event ----- 
        private void InsertSlipHeader()
        {
            itbSLIP.SelectedIndex = 1;
            itbSLIP.SelectedTab.Focus();

            SLIP_DATE.EditValue = DateTime.Today;
            GL_DATE.EditValue = SLIP_DATE.EditValue;
            
            idcUSER_INFO.ExecuteNonQuery();
            DEPT_NAME.EditValue = idcUSER_INFO.GetCommandParamValue("O_DEPT_NAME");
            DEPT_ID.EditValue = idcUSER_INFO.GetCommandParamValue("O_DEPT_ID");
            PERSON_NAME.EditValue = idcUSER_INFO.GetCommandParamValue("O_PERSON_NAME");
            PERSON_ID.EditValue = isAppInterfaceAdv1.PERSON_ID;

            SLIP_TYPE_NAME.Focus();
        }

        private void InsertSlipLine()
        {
            CURRENCY_CODE.EditValue = mCurrency_Code;
            CURRENCY_DESC.EditValue = mCurrency_Code;
            ACCOUNT_DR_CR_NAME.Focus();
        }

        private void Init_GL_Amount()
        {
            GL_AMOUNT.EditValue = iString.ISDecimaltoZero(GL_CURRENCY_AMOUNT.EditValue) * iString.ISDecimaltoZero(EXCHANGE_RATE.EditValue);
            idcCONVERSION_BASE_AMOUNT.SetCommandParamValue("W_BASE_CURRENCY_CODE", mCurrency_Code);
            idcCONVERSION_BASE_AMOUNT.SetCommandParamValue("W_CONVERSION_AMOUNT", GL_AMOUNT.EditValue);
            idcCONVERSION_BASE_AMOUNT.ExecuteNonQuery();
            GL_AMOUNT.EditValue = idcCONVERSION_BASE_AMOUNT.GetCommandParamValue("O_BASE_AMOUNT");
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
            TOTAL_DR_AMOUNT.EditValue = iString.ISDecimaltoZero(vDR_Amount);
            TOTAL_CR_AMOUNT.EditValue = iString.ISDecimaltoZero(vCR_Amount);
            MARGIN_AMOUNT.EditValue = -(System.Math.Abs(iString.ISDecimaltoZero(vDR_Amount) - iString.ISDecimaltoZero(vCR_Amount))); ;

            // 헤더 정보 동기화 //
            H_GL_AMOUNT.EditValue = iString.ISDecimaltoZero(vCR_Amount);
            H_GL_CURRENCY_AMOUNT.EditValue = iString.ISDecimaltoZero(vCurrency_DR_Amount);
        }

        private void Init_Control_Item_Prompt()
        {
///////////////////////////////////////////////////////////////////////////////////////////////////
            CURRENCY_DESC.Nullable = true;
            if (iString.ISNull(CURRENCY_ENABLED_FLAG.EditValue, "N") == "Y".ToString())
            {
                CURRENCY_DESC.Nullable = false;
            }
            CUSTOMER_NAME.Nullable = true;
            if (iString.ISNull(CUSTOMER_ENABLED_FLAG.EditValue, "N") == "Y".ToString())
            {
                CUSTOMER_NAME.Nullable = false;
            }
            BANK_ACCOUNT_NAME.Nullable = true;
            if (iString.ISNull(BANK_ACCOUNT_FLAG.EditValue, "N") == "Y".ToString())
            {
                BANK_ACCOUNT_NAME.Nullable = false;
            }
            BUDGET_DEPT_NAME.Nullable = true;
            if (iString.ISNull(BUDGET_BELONG_FLAG.EditValue, "N") == "Y".ToString())
            {
                BUDGET_DEPT_NAME.Nullable = false;
            }
            COST_CENTER_CODE.Nullable = true;
            if (iString.ISNull(COST_CENTER_FLAG.EditValue, "N") == "Y".ToString())
            {
                COST_CENTER_CODE.Nullable = false;
            }
            Application.DoEvents();
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
            ///////////////////////////////////////////////////////////////////////////////////////////////////
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
///////////////////////////////////////////////////////////////////////////////////////////////////
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
                if (iString.ISNull(MANAGEMENT1_YN.EditValue, "N") == "Y".ToString())
                {
                    MANAGEMENT1.Nullable = false;
                }
            }

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
                if (iString.ISNull(MANAGEMENT2_YN.EditValue, "N") == "Y".ToString())
                {
                    MANAGEMENT2.Nullable = false;
                }
            }

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
                if (iString.ISNull(REFER1_YN.EditValue, "N") == "Y".ToString())
                {
                    REFER1.Nullable = false;
                }
            }

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
                if (iString.ISNull(REFER2_YN.EditValue, "N") == "Y".ToString())
                {
                    REFER2.Nullable = false;
                }
            }

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
                if (iString.ISNull(REFER3_YN.EditValue, "N") == "Y".ToString())
                {
                    REFER3.Nullable = false;
                }
            }

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
                if (iString.ISNull(REFER4_YN.EditValue, "N") == "Y".ToString())
                {
                    REFER4.Nullable = false;
                }
            }

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
                if (iString.ISNull(REFER5_YN.EditValue, "N") == "Y".ToString())
                {
                    REFER5.Nullable = false;
                }
            }

            if (iString.ISNull(VOUCH_YN.EditValue, "F") == "F".ToString())
            {
                VOUCH_CODE.ReadOnly = true;
                VOUCH_CODE.Insertable = false;
                VOUCH_CODE.Updatable = false;
                VOUCH_CODE.TabStop = false;
            }
            else
            {
                VOUCH_CODE.Nullable = true;
                VOUCH_CODE.ReadOnly = false;
                VOUCH_CODE.Insertable = true;
                VOUCH_CODE.Updatable = true;
                VOUCH_CODE.TabStop = true;
                if (iString.ISNull(VOUCH_YN.EditValue, "N") == "Y".ToString())
                {
                    VOUCH_CODE.Nullable = false;
                }
            }

            if (iString.ISNull(REFER_RATE_YN.EditValue, "F") == "F".ToString())
            {
                REFER_RATE.ReadOnly = true;
                REFER_RATE.Insertable = false;
                REFER_RATE.Updatable = false;
                REFER_RATE.TabStop = false;
            }
            else
            {
                REFER_RATE.ReadOnly = false;
                REFER_RATE.Insertable = true;
                REFER_RATE.Updatable = true;
                REFER_RATE.TabStop = true;
            }

            if (iString.ISNull(REFER_AMOUNT_YN.EditValue, "F") == "F".ToString())
            {
                REFER_AMOUNT.ReadOnly = true;
                REFER_AMOUNT.Insertable = false;
                REFER_AMOUNT.Updatable = false;
                REFER_AMOUNT.TabStop = false;
            }
            else
            {
                REFER_AMOUNT.ReadOnly = false;
                REFER_AMOUNT.Insertable = true;
                REFER_AMOUNT.Updatable = true;
                REFER_AMOUNT.TabStop = true;
            }

            if (iString.ISNull(REFER_DATE1_YN.EditValue, "F") == "F".ToString())
            {
                REFER_DATE1.ReadOnly = true;
                REFER_DATE1.Insertable = false;
                REFER_DATE1.Updatable = false;
                REFER_DATE1.TabStop = false;
            }
            else
            {
                REFER_DATE1.ReadOnly = false;
                REFER_DATE1.Insertable = true;
                REFER_DATE1.Updatable = true;
                REFER_DATE1.TabStop = true;
            }

            if (iString.ISNull(REFER_DATE2_YN.EditValue, "F") == "F".ToString())
            {
                REFER_DATE2.ReadOnly = true;
                REFER_DATE2.Insertable = false;
                REFER_DATE2.Updatable = false;
                REFER_DATE2.TabStop = false;
            }
            else
            {
                REFER_DATE2.ReadOnly = false;
                REFER_DATE2.Insertable = true;
                REFER_DATE2.Updatable = true;
                REFER_DATE2.TabStop = true;
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
            igrSLIP_LINE.SetCellValue("VOUCH_NAME", null);
            igrSLIP_LINE.SetCellValue("VOUCH_CODE", null);
            igrSLIP_LINE.SetCellValue("REFER_RATE", null);
            igrSLIP_LINE.SetCellValue("REFER_AMOUNT", null);
            igrSLIP_LINE.SetCellValue("REFER_DATE1", null);
            igrSLIP_LINE.SetCellValue("REFER_DATE2", null);
        }

        private void Init_Currency()
        {
            if (iString.ISNull(CURRENCY_DESC.EditValue) == string.Empty || CURRENCY_DESC.EditValue.ToString() == mCurrency_Code.ToString())
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
        private void FCMF0291_Load(object sender, EventArgs e)
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
            Init_DR_CR_Amount();
        }

        private void igrSLIP_LIST_CellDoubleClick(object pSender)
        {
            if (igrSLIP_LIST.RowIndex > -1)
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
            Init_Currency();
        }

        private void EXCHANGE_RATE_CurrentEditValidating(object pSender, ISEditAdvValidatingEventArgs e)
        {
            Init_GL_Amount();
        }

        private void EXCHANGE_RATE_CurrentEditValidated(object pSender, ISEditAdvValidatedEventArgs e)
        {
            H_EXCHANGE_RATE.EditValue = iString.ISDecimaltoZero(EXCHANGE_RATE.EditValue);            
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
            Init_Control_Item_Prompt();
            Init_Control_Management_Value();
            Init_DR_CR_Amount();
            ACCOUNT_CODE.Focus();
        }

        private void ilaACCOUNT_CONTROL_SelectedRowData(object pSender)
        {
            Set_Control_Item_Prompt();
            Init_Control_Item_Prompt();
            Init_Control_Management_Value();
            Init_DR_CR_Amount();
            CURRENCY_DESC.Focus();            
        }

        private void ilaCURRENCY_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCURRENCY.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaBANK_ACCOUNT_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            string vAccount_Owner_Type = "-".ToString();
            if (iString.ISNull(CUSTOMER_ENABLED_FLAG.EditValue, "N") != "Y")
            {
                vAccount_Owner_Type = "OWNER".ToString();
            }
            ildBANK_ACCOUNT.SetLookupParamValue("W_ACCOUNT_OWNER_TYPE", vAccount_Owner_Type);
            ildBANK_ACCOUNT.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaCURRENCY_SelectedRowData(object pSender)
        {
            H_CURRENCY_CODE.EditValue = CURRENCY_DESC.EditValue;
            if (iString.ISNull(CURRENCY_DESC.EditValue) != string.Empty)
            {
                Init_Currency();
                if (CURRENCY_DESC.EditValue.ToString() != mCurrency_Code.ToString())
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

        private void ilaSUPPLIER_CUSTOMER_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildSUPPLIER_CUSTOMER.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaBUDGET_DEPT_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaCOST_CENTER_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOST_CENTER.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaVOUCH_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("VOUCH_CODE", "Y");
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

            if (iString.ISNull(e.Row["SLIP_TYPE_CLASS"]) == string.Empty)
            {// 전표유형
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10116"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            
            // 전표 번호 채번 //
            GetSlipNum();

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
            if (iString.ISDecimaltoZero(e.Row["GL_AMOUNT"]) == Convert.ToInt32(0))
            {// 금액
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10126"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
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
                if (mCurrency_Code.ToString() != e.Row["CURRENCY_CODE"].ToString() && iString.ISDecimaltoZero(e.Row["GL_CURRENCY_AMOUNT"]) == Convert.ToInt32(0))
                {// 입력통화와 기본 통화가 다를경우 외화금액 체크.
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10127"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
            }
            if (iString.ISDecimaltoZero(e.Row["GL_AMOUNT"]) == Convert.ToInt32(0))
            {// 금액
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10126"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["CUSTOMER_ID"]) == string.Empty && iString.ISNull(e.Row["CUSTOMER_ENABLED_FLAG"]) == "Y".ToString())
            {// 고객사 정보
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10135"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["BANK_ACCOUNT_ID"]) == string.Empty && iString.ISNull(e.Row["BANK_ACCOUNT_FLAG"]) == "Y".ToString())
            {// 계좌번호
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10136"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["BUDGET_DEPT_ID"]) == string.Empty && iString.ISNull(e.Row["BUDGET_BELONG_FLAG"]) == "Y".ToString())
            {// 귀속부서
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10120"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["COST_CENTER_ID"]) == string.Empty && iString.ISNull(e.Row["COST_CENTER_FLAG"]) == "Y".ToString())
            {// 원가코드
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10018"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["MANAGEMENT1"]) == string.Empty && iString.ISNull(e.Row["MANAGEMENT1_YN"], "N") == "Y".ToString())
            {// 관리항목1 필수 입력 체크
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", string.Format("{0}{1}", "&&FIELD_NAME:=", e.Row["MANAGEMENT1_NAME"])), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["MANAGEMENT2"]) == string.Empty && iString.ISNull(e.Row["MANAGEMENT2_YN"], "N") == "Y".ToString())
            {// 관리항목2 필수 입력 체크
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", string.Format("{0}{1}", "&&FIELD_NAME:=", e.Row["MANAGEMENT2_NAME"])), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["REFER1"]) == string.Empty && iString.ISNull(e.Row["REFER1_YN"], "N") == "Y".ToString())
            {// 참고항목1 필수 입력 체크
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", string.Format("{0}{1}", "&&FIELD_NAME:=", e.Row["REFER1_NAME"])), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["REFER2"]) == string.Empty && iString.ISNull(e.Row["REFER2_YN"], "N") == "Y".ToString())
            {// 참고항목2 필수 입력 체크
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", string.Format("{0}{1}", "&&FIELD_NAME:=", e.Row["REFER2_NAME"])), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["REFER3"]) == string.Empty && iString.ISNull(e.Row["REFER3_YN"], "N") == "Y".ToString())
            {// 참고항목3 필수 입력 체크
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", string.Format("{0}{1}", "&&FIELD_NAME:=", e.Row["REFER3_NAME"])), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["REFER4"]) == string.Empty && iString.ISNull(e.Row["REFER4_YN"], "N") == "Y".ToString())
            {// 참고항목4 필수 입력 체크
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", string.Format("{0}{1}", "&&FIELD_NAME:=", e.Row["REFER4_NAME"])), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["REFER5"]) == string.Empty && iString.ISNull(e.Row["REFER5_YN"], "N") == "Y".ToString())
            {// 참고항목5 필수 입력 체크
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", string.Format("{0}{1}", "&&FIELD_NAME:=", e.Row["REFER5_NAME"])), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["VOUCH_CODE"]) == string.Empty && iString.ISNull(e.Row["VOUCH_YN"], "N") == "Y".ToString())
            {// 증빙서류 필수 입력 체크
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10129"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["REFER_RATE"]) == string.Empty && iString.ISNull(e.Row["REFER_RATE_YN"], "N") == "Y".ToString())
            {// 관리율 필수 입력 체크
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", string.Format("{0}{1}", "&&FIELD_NAME:=", e.Row["REFER_RATE_NAME"])), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["REFER_AMOUNT"]) == string.Empty && iString.ISNull(e.Row["REFER_AMOUNT_YN"], "N") == "Y".ToString())
            {// 관리금액 필수 입력 체크
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", string.Format("{0}{1}", "&&FIELD_NAME:=", e.Row["REFER_AMOUNT_NAME"])), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["REFER_DATE1"]) == string.Empty && iString.ISNull(e.Row["REFER_DATE1_YN"], "N") == "Y".ToString())
            {// 관리일자1 필수 입력 체크
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", string.Format("{0}{1}", "&&FIELD_NAME:=", e.Row["REFER_DATE1_NAME"])), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["REFER_DATE2"]) == string.Empty && iString.ISNull(e.Row["REFER_DATE2_YN"], "N") == "Y".ToString())
            {// 관리일자2 필수 입력 체크
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", string.Format("{0}{1}", "&&FIELD_NAME:=", e.Row["REFER_DATE2_NAME"])), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
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
            if (SLIP_QUERY_STATUS.EditValue.ToString() != "QUERY".ToString())
            {
                Init_DR_CR_Amount();
            }
            Init_Total_GL_Amount();
        }

        #endregion        

    }
}