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

namespace FCMF0217
{
    public partial class FCMF0217 : Office2007Form
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
        string mAP_VAT_ACCOUNT_CODE = "1111700";        //부가세대급금 계정.

        #endregion;

        #region ----- Constructor -----

        public FCMF0217()
        {
            InitializeComponent();
        }

        public FCMF0217(Form pMainForm, ISAppInterface pAppInterface)
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
            idaSLIP_HEADER_IF_LIST.Fill();
        }

        private void Set_Control_Item_Prompt()
        {// 계정의 관리항목 정보.
            idaCONTROL_ITEM_PROMPT.Fill();
            if (idaCONTROL_ITEM_PROMPT.OraSelectData.Rows.Count > 0)
            {
                igrSLIP_LINE.SetCellValue("MANAGEMENT1_ID", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER1_ID"]);
                igrSLIP_LINE.SetCellValue("MANAGEMENT2_ID", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER2_ID"]);
                igrSLIP_LINE.SetCellValue("REFER1_ID", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER3_ID"]);
                igrSLIP_LINE.SetCellValue("REFER2_ID", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER4_ID"]);
                igrSLIP_LINE.SetCellValue("REFER3_ID", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER5_ID"]);
                igrSLIP_LINE.SetCellValue("REFER4_ID", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER6_ID"]);
                igrSLIP_LINE.SetCellValue("REFER5_ID", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER7_ID"]);
                igrSLIP_LINE.SetCellValue("REFER6_ID", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER8_ID"]);
                igrSLIP_LINE.SetCellValue("REFER7_ID", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER9_ID"]);
                igrSLIP_LINE.SetCellValue("REFER8_ID", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER10_ID"]);
                igrSLIP_LINE.SetCellValue("REFER9_ID", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER11_ID"]);
                igrSLIP_LINE.SetCellValue("REFER10_ID", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER12_ID"]);
                igrSLIP_LINE.SetCellValue("REFER11_ID", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER13_ID"]);
                igrSLIP_LINE.SetCellValue("REFER12_ID", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER14_ID"]);

                igrSLIP_LINE.SetCellValue("MANAGEMENT1_NAME", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER1_NAME"]);
                igrSLIP_LINE.SetCellValue("MANAGEMENT2_NAME", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER2_NAME"]);
                igrSLIP_LINE.SetCellValue("REFER1_NAME", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER3_NAME"]);
                igrSLIP_LINE.SetCellValue("REFER2_NAME", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER4_NAME"]);
                igrSLIP_LINE.SetCellValue("REFER3_NAME", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER5_NAME"]);
                igrSLIP_LINE.SetCellValue("REFER4_NAME", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER6_NAME"]);
                igrSLIP_LINE.SetCellValue("REFER5_NAME", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER7_NAME"]);
                igrSLIP_LINE.SetCellValue("REFER6_NAME", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER8_NAME"]);
                igrSLIP_LINE.SetCellValue("REFER7_NAME", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER9_NAME"]);
                igrSLIP_LINE.SetCellValue("REFER8_NAME", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER10_NAME"]);
                igrSLIP_LINE.SetCellValue("REFER9_NAME", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER11_NAME"]);
                igrSLIP_LINE.SetCellValue("REFER10_NAME", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER12_NAME"]);
                igrSLIP_LINE.SetCellValue("REFER11_NAME", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER13_NAME"]);
                igrSLIP_LINE.SetCellValue("REFER12_NAME", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER14_NAME"]);

                igrSLIP_LINE.SetCellValue("MANAGEMENT1_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER1_YN"]);
                igrSLIP_LINE.SetCellValue("MANAGEMENT2_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER2_YN"]);
                igrSLIP_LINE.SetCellValue("REFER1_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER3_YN"]);
                igrSLIP_LINE.SetCellValue("REFER2_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER4_YN"]);
                igrSLIP_LINE.SetCellValue("REFER3_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER5_YN"]);
                igrSLIP_LINE.SetCellValue("REFER4_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER6_YN"]);
                igrSLIP_LINE.SetCellValue("REFER5_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER7_YN"]);
                igrSLIP_LINE.SetCellValue("REFER6_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER8_YN"]);
                igrSLIP_LINE.SetCellValue("REFER7_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER9_YN"]);
                igrSLIP_LINE.SetCellValue("REFER8_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER10_YN"]);
                igrSLIP_LINE.SetCellValue("REFER9_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER11_YN"]);
                igrSLIP_LINE.SetCellValue("REFER10_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER12_YN"]);
                igrSLIP_LINE.SetCellValue("REFER11_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER13_YN"]);
                igrSLIP_LINE.SetCellValue("REFER12_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER14_YN"]);

                igrSLIP_LINE.SetCellValue("MANAGEMENT1_DR_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER1_DR_YN"]);
                igrSLIP_LINE.SetCellValue("MANAGEMENT2_DR_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER2_DR_YN"]);
                igrSLIP_LINE.SetCellValue("REFER1_DR_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER3_DR_YN"]);
                igrSLIP_LINE.SetCellValue("REFER2_DR_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER4_DR_YN"]);
                igrSLIP_LINE.SetCellValue("REFER3_DR_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER5_DR_YN"]);
                igrSLIP_LINE.SetCellValue("REFER4_DR_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER6_DR_YN"]);
                igrSLIP_LINE.SetCellValue("REFER5_DR_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER7_DR_YN"]);
                igrSLIP_LINE.SetCellValue("REFER6_DR_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER8_DR_YN"]);
                igrSLIP_LINE.SetCellValue("REFER7_DR_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER9_DR_YN"]);
                igrSLIP_LINE.SetCellValue("REFER8_DR_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER10_DR_YN"]);
                igrSLIP_LINE.SetCellValue("REFER9_DR_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER11_DR_YN"]);
                igrSLIP_LINE.SetCellValue("REFER10_DR_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER12_DR_YN"]);
                igrSLIP_LINE.SetCellValue("REFER11_DR_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER13_DR_YN"]);
                igrSLIP_LINE.SetCellValue("REFER12_DR_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER14_DR_YN"]);


                igrSLIP_LINE.SetCellValue("MANAGEMENT1_CR_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER1_CR_YN"]);
                igrSLIP_LINE.SetCellValue("MANAGEMENT2_CR_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER2_CR_YN"]);
                igrSLIP_LINE.SetCellValue("REFER1_CR_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER3_CR_YN"]);
                igrSLIP_LINE.SetCellValue("REFER2_CR_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER4_CR_YN"]);
                igrSLIP_LINE.SetCellValue("REFER3_CR_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER5_CR_YN"]);
                igrSLIP_LINE.SetCellValue("REFER4_CR_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER6_CR_YN"]);
                igrSLIP_LINE.SetCellValue("REFER5_CR_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER7_CR_YN"]);
                igrSLIP_LINE.SetCellValue("REFER6_CR_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER8_CR_YN"]);
                igrSLIP_LINE.SetCellValue("REFER7_CR_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER9_CR_YN"]);
                igrSLIP_LINE.SetCellValue("REFER8_CR_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER10_CR_YN"]);
                igrSLIP_LINE.SetCellValue("REFER9_CR_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER11_CR_YN"]);
                igrSLIP_LINE.SetCellValue("REFER10_CR_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER12_CR_YN"]);
                igrSLIP_LINE.SetCellValue("REFER11_CR_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER13_CR_YN"]);
                igrSLIP_LINE.SetCellValue("REFER12_CR_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER14_CR_YN"]);

                igrSLIP_LINE.SetCellValue("MANAGEMENT1_LOOKUP_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER1_LOOKUP_YN"]);
                igrSLIP_LINE.SetCellValue("MANAGEMENT2_LOOKUP_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER2_LOOKUP_YN"]);
                igrSLIP_LINE.SetCellValue("REFER1_LOOKUP_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER3_LOOKUP_YN"]);
                igrSLIP_LINE.SetCellValue("REFER2_LOOKUP_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER4_LOOKUP_YN"]);
                igrSLIP_LINE.SetCellValue("REFER3_LOOKUP_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER5_LOOKUP_YN"]);
                igrSLIP_LINE.SetCellValue("REFER4_LOOKUP_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER6_LOOKUP_YN"]);
                igrSLIP_LINE.SetCellValue("REFER5_LOOKUP_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER7_LOOKUP_YN"]);
                igrSLIP_LINE.SetCellValue("REFER6_LOOKUP_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER8_LOOKUP_YN"]);
                igrSLIP_LINE.SetCellValue("REFER7_LOOKUP_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER9_LOOKUP_YN"]);
                igrSLIP_LINE.SetCellValue("REFER8_LOOKUP_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER10_LOOKUP_YN"]);
                igrSLIP_LINE.SetCellValue("REFER9_LOOKUP_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER11_LOOKUP_YN"]);
                igrSLIP_LINE.SetCellValue("REFER10_LOOKUP_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER12_LOOKUP_YN"]);
                igrSLIP_LINE.SetCellValue("REFER11_LOOKUP_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER13_LOOKUP_YN"]);
                igrSLIP_LINE.SetCellValue("REFER12_LOOKUP_YN", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER14_LOOKUP_YN"]);

                igrSLIP_LINE.SetCellValue("MANAGEMENT1_LOOKUP_TYPE", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER1_LOOKUP_TYPE"]);
                igrSLIP_LINE.SetCellValue("MANAGEMENT2_LOOKUP_TYPE", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER2_LOOKUP_TYPE"]);
                igrSLIP_LINE.SetCellValue("REFER1_LOOKUP_TYPE", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER3_LOOKUP_TYPE"]);
                igrSLIP_LINE.SetCellValue("REFER2_LOOKUP_TYPE", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER4_LOOKUP_TYPE"]);
                igrSLIP_LINE.SetCellValue("REFER3_LOOKUP_TYPE", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER5_LOOKUP_TYPE"]);
                igrSLIP_LINE.SetCellValue("REFER4_LOOKUP_TYPE", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER6_LOOKUP_TYPE"]);
                igrSLIP_LINE.SetCellValue("REFER5_LOOKUP_TYPE", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER7_LOOKUP_TYPE"]);
                igrSLIP_LINE.SetCellValue("REFER6_LOOKUP_TYPE", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER8_LOOKUP_TYPE"]);
                igrSLIP_LINE.SetCellValue("REFER7_LOOKUP_TYPE", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER9_LOOKUP_TYPE"]);
                igrSLIP_LINE.SetCellValue("REFER8_LOOKUP_TYPE", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER10_LOOKUP_TYPE"]);
                igrSLIP_LINE.SetCellValue("REFER9_LOOKUP_TYPE", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER11_LOOKUP_TYPE"]);
                igrSLIP_LINE.SetCellValue("REFER10_LOOKUP_TYPE", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER12_LOOKUP_TYPE"]);
                igrSLIP_LINE.SetCellValue("REFER11_LOOKUP_TYPE", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER13_LOOKUP_TYPE"]);
                igrSLIP_LINE.SetCellValue("REFER12_LOOKUP_TYPE", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER14_LOOKUP_TYPE"]);

                igrSLIP_LINE.SetCellValue("MANAGEMENT1_DATA_TYPE", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER1_DATA_TYPE"]);
                igrSLIP_LINE.SetCellValue("MANAGEMENT2_DATA_TYPE", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER2_DATA_TYPE"]);
                igrSLIP_LINE.SetCellValue("REFER1_DATA_TYPE", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER3_DATA_TYPE"]);
                igrSLIP_LINE.SetCellValue("REFER2_DATA_TYPE", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER4_DATA_TYPE"]);
                igrSLIP_LINE.SetCellValue("REFER3_DATA_TYPE", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER5_DATA_TYPE"]);
                igrSLIP_LINE.SetCellValue("REFER4_DATA_TYPE", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER6_DATA_TYPE"]);
                igrSLIP_LINE.SetCellValue("REFER5_DATA_TYPE", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER7_DATA_TYPE"]);
                igrSLIP_LINE.SetCellValue("REFER6_DATA_TYPE", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER8_DATA_TYPE"]);
                igrSLIP_LINE.SetCellValue("REFER7_DATA_TYPE", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER9_DATA_TYPE"]);
                igrSLIP_LINE.SetCellValue("REFER8_DATA_TYPE", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER10_DATA_TYPE"]);
                igrSLIP_LINE.SetCellValue("REFER9_DATA_TYPE", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER11_DATA_TYPE"]);
                igrSLIP_LINE.SetCellValue("REFER10_DATA_TYPE", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER12_DATA_TYPE"]);
                igrSLIP_LINE.SetCellValue("REFER11_DATA_TYPE", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER13_DATA_TYPE"]);
                igrSLIP_LINE.SetCellValue("REFER12_DATA_TYPE", idaCONTROL_ITEM_PROMPT.CurrentRow["REFER14_DATA_TYPE"]);
            }
            else
            {
                igrSLIP_LINE.SetCellValue("MANAGEMENT1_ID", null);
                igrSLIP_LINE.SetCellValue("MANAGEMENT2_ID", null);
                igrSLIP_LINE.SetCellValue("REFER1_ID", null);
                igrSLIP_LINE.SetCellValue("REFER2_ID", null);
                igrSLIP_LINE.SetCellValue("REFER3_ID", null);
                igrSLIP_LINE.SetCellValue("REFER4_ID", null);
                igrSLIP_LINE.SetCellValue("REFER5_ID", null);
                igrSLIP_LINE.SetCellValue("REFER6_ID", null);
                igrSLIP_LINE.SetCellValue("REFER7_ID", null);
                igrSLIP_LINE.SetCellValue("REFER8_ID", null);
                igrSLIP_LINE.SetCellValue("REFER9_ID", null);
                igrSLIP_LINE.SetCellValue("REFER10_ID", null);
                igrSLIP_LINE.SetCellValue("REFER11_ID", null);
                igrSLIP_LINE.SetCellValue("REFER12_ID", null);

                igrSLIP_LINE.SetCellValue("MANAGEMENT1_NAME", null);
                igrSLIP_LINE.SetCellValue("MANAGEMENT2_NAME", null);
                igrSLIP_LINE.SetCellValue("REFER1_NAME", null);
                igrSLIP_LINE.SetCellValue("REFER2_NAME", null);
                igrSLIP_LINE.SetCellValue("REFER3_NAME", null);
                igrSLIP_LINE.SetCellValue("REFER4_NAME", null);
                igrSLIP_LINE.SetCellValue("REFER5_NAME", null);
                igrSLIP_LINE.SetCellValue("REFER6_NAME", null);
                igrSLIP_LINE.SetCellValue("REFER7_NAME", null);
                igrSLIP_LINE.SetCellValue("REFER8_NAME", null);
                igrSLIP_LINE.SetCellValue("REFER9_NAME", null);
                igrSLIP_LINE.SetCellValue("REFER10_NAME", null);
                igrSLIP_LINE.SetCellValue("REFER11_NAME", null);
                igrSLIP_LINE.SetCellValue("REFER12_NAME", null);

                igrSLIP_LINE.SetCellValue("MANAGEMENT1_YN", "F");
                igrSLIP_LINE.SetCellValue("MANAGEMENT2_YN", "F");
                igrSLIP_LINE.SetCellValue("REFER1_YN", "F");
                igrSLIP_LINE.SetCellValue("REFER2_YN", "F");
                igrSLIP_LINE.SetCellValue("REFER3_YN", "F");
                igrSLIP_LINE.SetCellValue("REFER4_YN", "F");
                igrSLIP_LINE.SetCellValue("REFER5_YN", "F");
                igrSLIP_LINE.SetCellValue("REFER6_YN", "F");
                igrSLIP_LINE.SetCellValue("REFER7_YN", "F");
                igrSLIP_LINE.SetCellValue("REFER8_YN", "F");
                igrSLIP_LINE.SetCellValue("REFER9_YN", "F");
                igrSLIP_LINE.SetCellValue("REFER10_YN", "F");
                igrSLIP_LINE.SetCellValue("REFER11_YN", "F");
                igrSLIP_LINE.SetCellValue("REFER12_YN", "F");

                igrSLIP_LINE.SetCellValue("MANAGEMENT1_DR_YN", "N");
                igrSLIP_LINE.SetCellValue("MANAGEMENT2_DR_YN", "N");
                igrSLIP_LINE.SetCellValue("REFER1_DR_YN", "N");
                igrSLIP_LINE.SetCellValue("REFER2_DR_YN", "N");
                igrSLIP_LINE.SetCellValue("REFER3_DR_YN", "N");
                igrSLIP_LINE.SetCellValue("REFER4_DR_YN", "N");
                igrSLIP_LINE.SetCellValue("REFER5_DR_YN", "N");
                igrSLIP_LINE.SetCellValue("REFER6_DR_YN", "N");
                igrSLIP_LINE.SetCellValue("REFER7_DR_YN", "N");
                igrSLIP_LINE.SetCellValue("REFER8_DR_YN", "N");
                igrSLIP_LINE.SetCellValue("REFER9_DR_YN", "N");
                igrSLIP_LINE.SetCellValue("REFER10_DR_YN", "N");
                igrSLIP_LINE.SetCellValue("REFER11_DR_YN", "N");
                igrSLIP_LINE.SetCellValue("REFER12_DR_YN", "N");

                igrSLIP_LINE.SetCellValue("MANAGEMENT1_CR_YN", "N");
                igrSLIP_LINE.SetCellValue("MANAGEMENT2_CR_YN", "N");
                igrSLIP_LINE.SetCellValue("REFER1_CR_YN", "N");
                igrSLIP_LINE.SetCellValue("REFER2_CR_YN", "N");
                igrSLIP_LINE.SetCellValue("REFER3_CR_YN", "N");
                igrSLIP_LINE.SetCellValue("REFER4_CR_YN", "N");
                igrSLIP_LINE.SetCellValue("REFER5_CR_YN", "N");
                igrSLIP_LINE.SetCellValue("REFER6_CR_YN", "N");
                igrSLIP_LINE.SetCellValue("REFER7_CR_YN", "N");
                igrSLIP_LINE.SetCellValue("REFER8_CR_YN", "N");
                igrSLIP_LINE.SetCellValue("REFER9_CR_YN", "N");
                igrSLIP_LINE.SetCellValue("REFER10_CR_YN", "N");
                igrSLIP_LINE.SetCellValue("REFER11_CR_YN", "N");
                igrSLIP_LINE.SetCellValue("REFER12_CR_YN", "N");

                igrSLIP_LINE.SetCellValue("MANAGEMENT1_LOOKUP_YN", "N");
                igrSLIP_LINE.SetCellValue("MANAGEMENT2_LOOKUP_YN", "N");
                igrSLIP_LINE.SetCellValue("REFER1_LOOKUP_YN", "N");
                igrSLIP_LINE.SetCellValue("REFER2_LOOKUP_YN", "N");
                igrSLIP_LINE.SetCellValue("REFER3_LOOKUP_YN", "N");
                igrSLIP_LINE.SetCellValue("REFER4_LOOKUP_YN", "N");
                igrSLIP_LINE.SetCellValue("REFER5_LOOKUP_YN", "N");
                igrSLIP_LINE.SetCellValue("REFER6_LOOKUP_YN", "N");
                igrSLIP_LINE.SetCellValue("REFER7_LOOKUP_YN", "N");
                igrSLIP_LINE.SetCellValue("REFER8_LOOKUP_YN", "N");
                igrSLIP_LINE.SetCellValue("REFER9_LOOKUP_YN", "N");
                igrSLIP_LINE.SetCellValue("REFER10_LOOKUP_YN", "N");
                igrSLIP_LINE.SetCellValue("REFER11_LOOKUP_YN", "N");
                igrSLIP_LINE.SetCellValue("REFER12_LOOKUP_YN", "N");

                igrSLIP_LINE.SetCellValue("MANAGEMENT1_LOOKUP_TYPE", null);
                igrSLIP_LINE.SetCellValue("MANAGEMENT2_LOOKUP_TYPE", null);
                igrSLIP_LINE.SetCellValue("REFER1_LOOKUP_TYPE", null);
                igrSLIP_LINE.SetCellValue("REFER2_LOOKUP_TYPE", null);
                igrSLIP_LINE.SetCellValue("REFER3_LOOKUP_TYPE", null);
                igrSLIP_LINE.SetCellValue("REFER4_LOOKUP_TYPE", null);
                igrSLIP_LINE.SetCellValue("REFER5_LOOKUP_TYPE", null);
                igrSLIP_LINE.SetCellValue("REFER6_LOOKUP_TYPE", null);
                igrSLIP_LINE.SetCellValue("REFER7_LOOKUP_TYPE", null);
                igrSLIP_LINE.SetCellValue("REFER8_LOOKUP_TYPE", null);
                igrSLIP_LINE.SetCellValue("REFER9_LOOKUP_TYPE", null);
                igrSLIP_LINE.SetCellValue("REFER10_LOOKUP_TYPE", null);
                igrSLIP_LINE.SetCellValue("REFER11_LOOKUP_TYPE", null);
                igrSLIP_LINE.SetCellValue("REFER12_LOOKUP_TYPE", null);

                igrSLIP_LINE.SetCellValue("MANAGEMENT1_DATA_TYPE", "VARCHAR2");
                igrSLIP_LINE.SetCellValue("MANAGEMENT2_DATA_TYPE", "VARCHAR2");
                igrSLIP_LINE.SetCellValue("REFER1_DATA_TYPE", "VARCHAR2");
                igrSLIP_LINE.SetCellValue("REFER2_DATA_TYPE", "VARCHAR2");
                igrSLIP_LINE.SetCellValue("REFER3_DATA_TYPE", "VARCHAR2");
                igrSLIP_LINE.SetCellValue("REFER4_DATA_TYPE", "VARCHAR2");
                igrSLIP_LINE.SetCellValue("REFER5_DATA_TYPE", "VARCHAR2");
                igrSLIP_LINE.SetCellValue("REFER6_DATA_TYPE", "VARCHAR2");
                igrSLIP_LINE.SetCellValue("REFER7_DATA_TYPE", "VARCHAR2");
                igrSLIP_LINE.SetCellValue("REFER8_DATA_TYPE", "VARCHAR2");
                igrSLIP_LINE.SetCellValue("REFER9_DATA_TYPE", "VARCHAR2");
                igrSLIP_LINE.SetCellValue("REFER10_DATA_TYPE", "VARCHAR2");
                igrSLIP_LINE.SetCellValue("REFER11_DATA_TYPE", "VARCHAR2");
                igrSLIP_LINE.SetCellValue("REFER12_DATA_TYPE", "VARCHAR2");
            }
        }

        //private void Set_SlipLIne_ControlItem()
        //{
        //    igrSLIP_LINE.SetCellValue("MANAGEMENT1_NAME", iString.ISNull(MANAGEMENT1_PROMPT.EditValue));
        //    igrSLIP_LINE.SetCellValue("MANAGEMENT2_NAME", iString.ISNull(MANAGEMENT2_PROMPT.EditValue));
        //    igrSLIP_LINE.SetCellValue("REFER1_NAME", iString.ISNull(REFER1_PROMPT.EditValue));
        //    igrSLIP_LINE.SetCellValue("REFER2_NAME", iString.ISNull(REFER2_PROMPT.EditValue));
        //    igrSLIP_LINE.SetCellValue("REFER3_NAME", iString.ISNull(REFER3_PROMPT.EditValue));
        //    igrSLIP_LINE.SetCellValue("REFER4_NAME", iString.ISNull(REFER4_PROMPT.EditValue));
        //    igrSLIP_LINE.SetCellValue("REFER5_NAME", iString.ISNull(REFER5_PROMPT.EditValue));
        //    igrSLIP_LINE.SetCellValue("REFER6_NAME", iString.ISNull(REFER6_PROMPT.EditValue));
        //    igrSLIP_LINE.SetCellValue("REFER7_NAME", iString.ISNull(REFER7_PROMPT.EditValue));
        //    igrSLIP_LINE.SetCellValue("REFER8_NAME", iString.ISNull(REFER8_PROMPT.EditValue));
        //    //igrSLIP_LINE.SetCellValue("REFER_RATE_NAME", iString.ISNull(REFER_RATE_PROMPT.EditValue));
        //    //igrSLIP_LINE.SetCellValue("REFER_AMOUNT_NAME", iString.ISNull(REFER_AMOUNT_PROMPT.EditValue));
        //    //igrSLIP_LINE.SetCellValue("REFER_DATE1_NAME", iString.ISNull(REFER_DATE1_PROMPT.EditValue));
        //    //igrSLIP_LINE.SetCellValue("REFER_DATE2_NAME", iString.ISNull(REFER_DATE2_PROMPT.EditValue));

        //    igrSLIP_LINE.SetCellValue("MANAGEMENT1_YN", iString.ISNull(MANAGEMENT1_YN.EditValue, "F"));
        //    igrSLIP_LINE.SetCellValue("MANAGEMENT2_YN", iString.ISNull(MANAGEMENT2_YN.EditValue, "F"));
        //    igrSLIP_LINE.SetCellValue("REFER1_YN", iString.ISNull(REFER1_YN.EditValue, "F"));
        //    igrSLIP_LINE.SetCellValue("REFER2_YN", iString.ISNull(REFER2_YN.EditValue, "F"));
        //    igrSLIP_LINE.SetCellValue("REFER3_YN", iString.ISNull(REFER3_YN.EditValue, "F"));
        //    igrSLIP_LINE.SetCellValue("REFER4_YN", iString.ISNull(REFER4_YN.EditValue, "F"));
        //    igrSLIP_LINE.SetCellValue("REFER5_YN", iString.ISNull(REFER5_YN.EditValue, "F"));
        //    igrSLIP_LINE.SetCellValue("REFER6_YN", iString.ISNull(REFER6_YN.EditValue, "F"));
        //    igrSLIP_LINE.SetCellValue("REFER7_YN", iString.ISNull(REFER7_YN.EditValue, "F"));
        //    igrSLIP_LINE.SetCellValue("REFER8_YN", iString.ISNull(REFER8_YN.EditValue, "F"));
        //    //igrSLIP_LINE.SetCellValue("REFER_RATE_YN", iString.ISNull(REFER_RATE_YN.EditValue, "F"));
        //    //igrSLIP_LINE.SetCellValue("REFER_AMOUNT_YN", iString.ISNull(REFER_AMOUNT_YN.EditValue, "F"));
        //    //igrSLIP_LINE.SetCellValue("REFER_DATE1_YN", iString.ISNull(REFER_DATE1_YN.EditValue, "F"));
        //    //igrSLIP_LINE.SetCellValue("REFER_DATE2_YN", iString.ISNull(REFER_DATE2_YN.EditValue, "F"));
        //    //igrSLIP_LINE.SetCellValue("VOUCH_YN", iString.ISNull(VOUCH_YN.EditValue, "F"));

        //    igrSLIP_LINE.SetCellValue("MANAGEMENT1_LOOKUP_YN", iString.ISNull(MANAGEMENT1_LOOKUP_YN.EditValue, "N"));
        //    igrSLIP_LINE.SetCellValue("MANAGEMENT2_LOOKUP_YN", iString.ISNull(MANAGEMENT2_LOOKUP_YN.EditValue, "N"));
        //    igrSLIP_LINE.SetCellValue("REFER1_LOOKUP_YN", iString.ISNull(REFER1_LOOKUP_YN.EditValue, "N"));
        //    igrSLIP_LINE.SetCellValue("REFER2_LOOKUP_YN", iString.ISNull(REFER2_LOOKUP_YN.EditValue, "N"));
        //    igrSLIP_LINE.SetCellValue("REFER3_LOOKUP_YN", iString.ISNull(REFER3_LOOKUP_YN.EditValue, "N"));
        //    igrSLIP_LINE.SetCellValue("REFER4_LOOKUP_YN", iString.ISNull(REFER4_LOOKUP_YN.EditValue, "N"));
        //    igrSLIP_LINE.SetCellValue("REFER5_LOOKUP_YN", iString.ISNull(REFER5_LOOKUP_YN.EditValue, "N"));
        //    igrSLIP_LINE.SetCellValue("REFER6_LOOKUP_YN", iString.ISNull(REFER6_LOOKUP_YN.EditValue, "N"));
        //    igrSLIP_LINE.SetCellValue("REFER7_LOOKUP_YN", iString.ISNull(REFER7_LOOKUP_YN.EditValue, "N"));
        //    igrSLIP_LINE.SetCellValue("REFER8_LOOKUP_YN", iString.ISNull(REFER8_LOOKUP_YN.EditValue, "N"));

        //    igrSLIP_LINE.SetCellValue("MANAGEMENT1_LOOKUP_TYPE", MANAGEMENT1_LOOKUP_TYPE.EditValue);
        //    igrSLIP_LINE.SetCellValue("MANAGEMENT2_LOOKUP_TYPE", MANAGEMENT2_LOOKUP_TYPE.EditValue);
        //    igrSLIP_LINE.SetCellValue("REFER1_LOOKUP_TYPE", REFER1_LOOKUP_TYPE.EditValue);
        //    igrSLIP_LINE.SetCellValue("REFER2_LOOKUP_TYPE", REFER2_LOOKUP_TYPE.EditValue);
        //    igrSLIP_LINE.SetCellValue("REFER3_LOOKUP_TYPE", REFER3_LOOKUP_TYPE.EditValue);
        //    igrSLIP_LINE.SetCellValue("REFER4_LOOKUP_TYPE", REFER4_LOOKUP_TYPE.EditValue);
        //    igrSLIP_LINE.SetCellValue("REFER5_LOOKUP_TYPE", REFER5_LOOKUP_TYPE.EditValue);
        //    igrSLIP_LINE.SetCellValue("REFER6_LOOKUP_TYPE", REFER6_LOOKUP_TYPE.EditValue);
        //    igrSLIP_LINE.SetCellValue("REFER7_LOOKUP_TYPE", REFER7_LOOKUP_TYPE.EditValue);
        //    igrSLIP_LINE.SetCellValue("REFER8_LOOKUP_TYPE", REFER8_LOOKUP_TYPE.EditValue);

        //    igrSLIP_LINE.SetCellValue("MANAGEMENT1_DATA_TYPE", iString.ISNull(MANAGEMENT1_DATA_TYPE.EditValue, "N"));
        //    igrSLIP_LINE.SetCellValue("MANAGEMENT2_DATA_TYPE", iString.ISNull(MANAGEMENT2_DATA_TYPE.EditValue, "N"));
        //    igrSLIP_LINE.SetCellValue("REFER1_DATA_TYPE", iString.ISNull(REFER1_DATA_TYPE.EditValue, "N"));
        //    igrSLIP_LINE.SetCellValue("REFER2_DATA_TYPE", iString.ISNull(REFER2_DATA_TYPE.EditValue, "N"));
        //    igrSLIP_LINE.SetCellValue("REFER3_DATA_TYPE", iString.ISNull(REFER3_DATA_TYPE.EditValue, "N"));
        //    igrSLIP_LINE.SetCellValue("REFER4_DATA_TYPE", iString.ISNull(REFER4_DATA_TYPE.EditValue, "N"));
        //    igrSLIP_LINE.SetCellValue("REFER5_DATA_TYPE", iString.ISNull(REFER5_DATA_TYPE.EditValue, "N"));
        //    igrSLIP_LINE.SetCellValue("REFER6_DATA_TYPE", iString.ISNull(REFER6_DATA_TYPE.EditValue, "N"));
        //    igrSLIP_LINE.SetCellValue("REFER7_DATA_TYPE", iString.ISNull(REFER7_DATA_TYPE.EditValue, "N"));
        //    igrSLIP_LINE.SetCellValue("REFER8_DATA_TYPE", iString.ISNull(REFER8_DATA_TYPE.EditValue, "N"));
        //}

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

        private void SetManagementParameter(string pREFER_Field, string pEnabled_YN, object pLookup_Type)
        {
            if (iString.ISNull(pLookup_Type) == "DEPT".ToString())
            {
                ildMANAGEMENT.SetLookupParamValue("W_INQURIY_VALUE", H_DEPT_CODE.EditValue);
            }
            else if (iString.ISNull(pLookup_Type) == "COSTCENTER".ToString())
            {
                ildMANAGEMENT.SetLookupParamValue("W_INQURIY_VALUE", GetLookup_Type("DEPT"));
            }
            else if (iString.ISNull(pLookup_Type) == "VAT_REASON".ToString())
            {
                ildMANAGEMENT.SetLookupParamValue("W_INQURIY_VALUE", REFER1.EditValue);
            }
            else if (iString.ISNull(pLookup_Type) == "CREDIT_CARD".ToString())
            {
                ildMANAGEMENT.SetLookupParamValue("W_INQURIY_VALUE", REFER1.EditValue);
            }
            else if (iString.ISNull(pLookup_Type) == "LC_NO".ToString())
            {
                string vGL_DATE = null;
                if (iString.ISNull(SLIP_DATE.EditValue) != string.Empty)
                {
                    vGL_DATE = SLIP_DATE.DateTimeValue.ToShortDateString();
                }
                else if (iString.ISNull(SLIP_DATE.EditValue) != string.Empty)
                {
                    vGL_DATE = SLIP_DATE.DateTimeValue.ToShortDateString();
                }
                ildMANAGEMENT.SetLookupParamValue("W_INQURIY_VALUE", vGL_DATE);
            }
            else
            {
                ildMANAGEMENT.SetLookupParamValue("W_INQURIY_VALUE", null);
            }
            ildMANAGEMENT.SetLookupParamValue("W_REFER_FIELD", pREFER_Field);
            ildMANAGEMENT.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        }

        private object GetLookup_Type(object pLookup_Type)
        {
            if (iString.ISNull(pLookup_Type) == string.Empty)
            {
                return null;
            }
            object mLookup_Value;
            if (iString.ISNull(igrSLIP_LINE.GetCellValue("MANAGEMENT1_LOOKUP_TYPE")) != string.Empty
                && iString.ISNull(igrSLIP_LINE.GetCellValue("MANAGEMENT1_LOOKUP_TYPE")) == iString.ISNull(pLookup_Type))
            {
                mLookup_Value = MANAGEMENT1.EditValue;
            }
            else if (iString.ISNull(igrSLIP_LINE.GetCellValue("MANAGEMENT2_LOOKUP_TYPE")) != string.Empty
                && iString.ISNull(igrSLIP_LINE.GetCellValue("MANAGEMENT2_LOOKUP_TYPE")) == iString.ISNull(pLookup_Type))
            {
                mLookup_Value = MANAGEMENT2.EditValue;
            }
            else if (iString.ISNull(igrSLIP_LINE.GetCellValue("REFER1_LOOKUP_TYPE")) != string.Empty
                && iString.ISNull(igrSLIP_LINE.GetCellValue("REFER1_LOOKUP_TYPE")) == iString.ISNull(pLookup_Type))
            {
                mLookup_Value = REFER1.EditValue;
            }
            else if (iString.ISNull(igrSLIP_LINE.GetCellValue("REFER2_LOOKUP_TYPE")) != string.Empty
                && iString.ISNull(igrSLIP_LINE.GetCellValue("REFER2_LOOKUP_TYPE")) == iString.ISNull(pLookup_Type))
            {
                mLookup_Value = REFER2.EditValue;
            }
            else if (iString.ISNull(igrSLIP_LINE.GetCellValue("REFER3_LOOKUP_TYPE")) != string.Empty
                && iString.ISNull(igrSLIP_LINE.GetCellValue("REFER3_LOOKUP_TYPE")) == iString.ISNull(pLookup_Type))
            {
                mLookup_Value = REFER3.EditValue;
            }
            else if (iString.ISNull(igrSLIP_LINE.GetCellValue("REFER4_LOOKUP_TYPE")) != string.Empty
                && iString.ISNull(igrSLIP_LINE.GetCellValue("REFER4_LOOKUP_TYPE")) == iString.ISNull(pLookup_Type))
            {
                mLookup_Value = REFER4.EditValue;
            }
            else if (iString.ISNull(igrSLIP_LINE.GetCellValue("REFER5_LOOKUP_TYPE")) != string.Empty
                && iString.ISNull(igrSLIP_LINE.GetCellValue("REFER5_LOOKUP_TYPE")) == iString.ISNull(pLookup_Type))
            {
                mLookup_Value = REFER5.EditValue;
            }
            else if (iString.ISNull(igrSLIP_LINE.GetCellValue("REFER6_LOOKUP_TYPE")) != string.Empty
                && iString.ISNull(igrSLIP_LINE.GetCellValue("REFER6_LOOKUP_TYPE")) == iString.ISNull(pLookup_Type))
            {
                mLookup_Value = REFER6.EditValue;
            }
            else if (iString.ISNull(igrSLIP_LINE.GetCellValue("REFER7_LOOKUP_TYPE")) != string.Empty
                && iString.ISNull(igrSLIP_LINE.GetCellValue("REFER7_LOOKUP_TYPE")) == iString.ISNull(pLookup_Type))
            {
                mLookup_Value = REFER7.EditValue;
            }
            else if (iString.ISNull(igrSLIP_LINE.GetCellValue("REFER8_LOOKUP_TYPE")) != string.Empty
                && iString.ISNull(igrSLIP_LINE.GetCellValue("REFER8_LOOKUP_TYPE")) == iString.ISNull(pLookup_Type))
            {
                mLookup_Value = REFER8.EditValue;
            }
            else if (iString.ISNull(igrSLIP_LINE.GetCellValue("REFER9_LOOKUP_TYPE")) != string.Empty
                && iString.ISNull(igrSLIP_LINE.GetCellValue("REFER9_LOOKUP_TYPE")) == iString.ISNull(pLookup_Type))
            {
                mLookup_Value = REFER9.EditValue;
            }
            else if (iString.ISNull(igrSLIP_LINE.GetCellValue("REFER10_LOOKUP_TYPE")) != string.Empty
                && iString.ISNull(igrSLIP_LINE.GetCellValue("REFER10_LOOKUP_TYPE")) == iString.ISNull(pLookup_Type))
            {
                mLookup_Value = REFER10.EditValue;
            }
            else if (iString.ISNull(igrSLIP_LINE.GetCellValue("REFER11_LOOKUP_TYPE")) != string.Empty
                && iString.ISNull(igrSLIP_LINE.GetCellValue("REFER11_LOOKUP_TYPE")) == iString.ISNull(pLookup_Type))
            {
                mLookup_Value = REFER11.EditValue;
            }
            else if (iString.ISNull(igrSLIP_LINE.GetCellValue("REFER12_LOOKUP_TYPE")) != string.Empty
            && iString.ISNull(igrSLIP_LINE.GetCellValue("REFER12_LOOKUP_TYPE")) == iString.ISNull(pLookup_Type))
            {
                mLookup_Value = REFER12.EditValue;
            }
            else
            {
                mLookup_Value = null;
            }
            return mLookup_Value;
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
            C_GL_NUM.EditValue = SLIP_NUM.EditValue;
        }

        #endregion;

        #region ----- XL Print 1 Methods ----

        private void XLPrinting1(string pOutChoice)
        {
            System.Windows.Forms.Application.UseWaitCursor = true;
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            System.Windows.Forms.Application.DoEvents();

            string vMessageText = string.Empty;
            int vPageTotal = 0;
            int vPageNumber = 0;

            int vCountRowGrid = igrSLIP_LIST.RowCount;
            if (vCountRowGrid > 0)
            {
                vMessageText = string.Format("Print Starting...", vPageTotal);
                isAppInterfaceAdv1.OnAppMessage(vMessageText);
                System.Windows.Forms.Application.DoEvents();

                //-------------------------------------------------------------------------------------
                XLPrinting xlPrinting = new XLPrinting(isAppInterfaceAdv1.AppInterface);

                try
                {
                    //-------------------------------------------------------------------------------------
                    xlPrinting.OpenFileNameExcel = "FCMF0217_001.xls";
                    xlPrinting.PrintingLineMAX = 57;         //엑셀에 출력될 총 라인수(반복해서 출력되는 부분의 엑셀의 행 값)
                    xlPrinting.IncrementCopyMAX = 67;        //엑셀 쉬트에 복사될 총 라인수
                    xlPrinting.PositionPrintLineSTART = 18;  //라인 출력시 엑셀 시작 행 위치 지정
                    xlPrinting.CopySumPrintingLine = 1;      //엑셀의 선택된 쉬트의 복사되어질 시작 행 위치
                    //-------------------------------------------------------------------------------------

                    vMessageText = string.Format("XL Opening...");
                    isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
                    System.Windows.Forms.Application.DoEvents();

                    //-------------------------------------------------------------------------------------
                    bool isOpen = xlPrinting.XLFileOpen();
                    //-------------------------------------------------------------------------------------

                    //-------------------------------------------------------------------------------------
                    if (isOpen == true)
                    {
                        int vRow = igrSLIP_LIST.RowIndex;
                        object vObject = igrSLIP_LIST.GetCellValue("HEADER_INTERFACE_ID");
                        object vObject_DEPT_ID = igrSLIP_LIST.GetCellValue("DEPT_ID");
                        object vConfirm_YN = "N";

                        if (itbSLIP.SelectedIndex == itpSLIP_DETAIL.TabIndex)
                        {
                            vObject = H_HEADER_INTERFACE_ID.EditValue;

                            idaPRINT_SLIP_HEADER.SetSelectParamValue("W_SLIP_HEADER_INTERFACE_ID", vObject);
                            idaPRINT_SLIP_HEADER.Fill();
                            xlPrinting.HeaderWrite(idaPRINT_SLIP_HEADER);
                        }
                        else
                        {
                            vObject = igrSLIP_LIST.GetCellValue("HEADER_INTERFACE_ID");
                            xlPrinting.HeaderWrite(igrSLIP_LIST, vRow);
                        }
                         
                        idaPRINT_SLIP_LINE.SetSelectParamValue("W_SLIP_HEADER_INTERFACE_ID", vObject);
                        idaPRINT_SLIP_LINE.Fill();
                           
                        //현업 결재라인//
                        idaDOC_APPROVAL_LINE.SetSelectParamValue("W_STD_DATE", SLIP_DATE.EditValue);
                        idaDOC_APPROVAL_LINE.SetSelectParamValue("W_DEPT_ID", vObject_DEPT_ID);
                        idaDOC_APPROVAL_LINE.Fill();

                        //재경 결재라인//
                        IDA_DOC_APPROVAL_LINE_FI.SetSelectParamValue("W_STD_DATE", SLIP_DATE.EditValue);
                        IDA_DOC_APPROVAL_LINE_FI.SetSelectParamValue("W_DEPT_ID", vObject_DEPT_ID);
                        IDA_DOC_APPROVAL_LINE_FI.SetSelectParamValue("W_FI_DEPT_FLAG", "Y");
                        IDA_DOC_APPROVAL_LINE_FI.Fill();

                        int vCountRow = idaPRINT_SLIP_LINE.OraSelectData.Rows.Count;
                        if (vCountRow > 0)
                        {
                            vPageNumber = xlPrinting.LineWrite(idaPRINT_SLIP_LINE, idaDOC_APPROVAL_LINE.OraSelectData, IDA_DOC_APPROVAL_LINE_FI.OraSelectData);

                            if (pOutChoice == "PRINT")
                            {
                                xlPrinting.Printing(1, vPageNumber);
                            }
                            else if (pOutChoice == "FILE")
                            {
                                xlPrinting.Save("SLIP_");
                            }
                        }
                        vPageTotal = vPageTotal + vPageNumber;
                    }
                    //-------------------------------------------------------------------------------------

                    //-------------------------------------------------------------------------------------
                    xlPrinting.Dispose();
                    //-------------------------------------------------------------------------------------
                }
                catch (System.Exception ex)
                {
                    string vMessage = ex.Message;
                    xlPrinting.Dispose();
                }
            }

            //-------------------------------------------------------------------------
            vMessageText = string.Format("Print End [Tatal Page : {0}]", vPageTotal);
            isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
            System.Windows.Forms.Application.DoEvents();

            System.Windows.Forms.Application.UseWaitCursor = false;
            this.Cursor = System.Windows.Forms.Cursors.Default;
            System.Windows.Forms.Application.DoEvents();
        }

        #endregion;

        #region ----- Initialize Event ----- 

        private Boolean Check_SlipHeader_Added()
        {
            Boolean Row_Added_Status = false;
            for (int r = 0; r < idaSLIP_HEADER.SelectRows.Count; r++)
            {
                if (idaSLIP_HEADER.SelectRows[r].RowState == DataRowState.Added)
                {
                    Row_Added_Status = true;
                }
            }
            if (Row_Added_Status == true)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10261"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
            return (Row_Added_Status);
        }

        private void InsertSlipHeader()
        {
            itbSLIP.SelectedIndex = 1;
            itbSLIP.SelectedTab.Focus();
            
            SLIP_DATE.EditValue = DateTime.Today;
            C_GL_DATE.EditValue = SLIP_DATE.EditValue;

            idcDV_SLIP_TYPE.SetCommandParamValue("W_GROUP_CODE", "SLIP_TYPE");
            idcDV_SLIP_TYPE.ExecuteNonQuery();
            SLIP_TYPE.EditValue = idcDV_SLIP_TYPE.GetCommandParamValue("O_CODE");
            SLIP_TYPE_NAME.EditValue = idcDV_SLIP_TYPE.GetCommandParamValue("O_CODE_NAME");
            SLIP_TYPE_CLASS.EditValue = idcDV_SLIP_TYPE.GetCommandParamValue("O_VALUE1");
            DOCUMENT_TYPE.EditValue = idcDV_SLIP_TYPE.GetCommandParamValue("O_VALUE2");

            idcUSER_INFO.ExecuteNonQuery();
            DEPT_NAME.EditValue = idcUSER_INFO.GetCommandParamValue("O_DEPT_NAME");
            H_DEPT_CODE.EditValue = idcUSER_INFO.GetCommandParamValue("O_DEPT_CODE");
            H_DEPT_ID.EditValue = idcUSER_INFO.GetCommandParamValue("O_DEPT_ID");
            PERSON_NAME.EditValue = idcUSER_INFO.GetCommandParamValue("O_PERSON_NAME");
            PERSON_ID.EditValue = isAppInterfaceAdv1.PERSON_ID;

            ACCOUNT_CODE.Focus();
        }

        private void InsertSlipLine()
        {
            CURRENCY_CODE.EditValue = mCurrency_Code;
            CURRENCY_DESC.EditValue = mCurrency_Code;
            Init_Currency_Amount();
            if (iString.ISNull(REMARK.EditValue) == string.Empty)
            {
                REMARK.EditValue = H_REMARK.EditValue;
            }
            ACCOUNT_CODE.Focus();
        }

        private void Init_GL_Amount()
        {
            if (iString.ISDecimaltoZero(GL_AMOUNT.EditValue) != 0)
            {
                return;
            }
            else if (iString.ISDecimaltoZero(EXCHANGE_RATE.EditValue) == 0)
            {
                return;
            }
            else if (iString.ISDecimaltoZero(GL_CURRENCY_AMOUNT.EditValue) == 0)
            {
                return;
            }
            decimal mGL_AMOUNT = iString.ISDecimaltoZero(GL_CURRENCY_AMOUNT.EditValue) * iString.ISDecimaltoZero(EXCHANGE_RATE.EditValue);
            try
            {
                idcCONVERSION_BASE_AMOUNT.SetCommandParamValue("W_BASE_CURRENCY_CODE", mCurrency_Code);
                idcCONVERSION_BASE_AMOUNT.SetCommandParamValue("W_CONVERSION_AMOUNT", mGL_AMOUNT);
                idcCONVERSION_BASE_AMOUNT.ExecuteNonQuery();
                GL_AMOUNT.EditValue = Convert.ToDecimal(idcCONVERSION_BASE_AMOUNT.GetCommandParamValue("O_BASE_AMOUNT"));
            }
            catch
            {
                GL_AMOUNT.EditValue = Convert.ToDecimal(Math.Round(mGL_AMOUNT, 0));
            }
            Init_DR_CR_Amount();
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
                //Init_Control_Item_Prompt();
                Init_Set_Item_Prompt(idaSLIP_LINE.CurrentRow);

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
                    if (idaSLIP_LINE.OraSelectData.Rows[r].RowState != DataRowState.Deleted)
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

        private void Init_Set_Item_Prompt(DataRow pDataRow)
        {// edit 데이터 형식, 사용여부 변경.
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
            MANAGEMENT1.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
            MANAGEMENT1.NumberDecimalDigits = 0;
            if (iString.ISNull(pDataRow["MANAGEMENT1_YN"], "F") == "F".ToString())
            {
                MANAGEMENT1.Nullable = true;
                MANAGEMENT1.ReadOnly = true;
                MANAGEMENT1.Insertable = false;
                MANAGEMENT1.Updatable = false;
                MANAGEMENT1.TabStop = false;
            }
            else
            {
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
                else if (iString.ISNull(pDataRow["MANAGEMENT1_DATA_TYPE"]) == "DATE".ToString())
                {
                    MANAGEMENT1.EditAdvType = ISUtil.Enum.EditAdvType.DateTimeEdit;
                }
                if (iString.ISNull(pDataRow["MANAGEMENT1_YN"], "N") == "Y".ToString())
                {
                    MANAGEMENT1.ReadOnly = false;
                }
            }
            MANAGEMENT1.Refresh();

            MANAGEMENT2.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
            MANAGEMENT2.NumberDecimalDigits = 0;
            if (iString.ISNull(pDataRow["MANAGEMENT2_YN"], "F") == "F".ToString())
            {
                MANAGEMENT2.Nullable = true;
                MANAGEMENT2.ReadOnly = true;
                MANAGEMENT2.Insertable = false;
                MANAGEMENT2.Updatable = false;
                MANAGEMENT2.TabStop = false;
            }
            else
            {
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
                else if (iString.ISNull(pDataRow["MANAGEMENT2_DATA_TYPE"]) == "DATE".ToString())
                {
                    MANAGEMENT2.EditAdvType = ISUtil.Enum.EditAdvType.DateTimeEdit;
                }
                else
                if (iString.ISNull(pDataRow["MANAGEMENT2_YN"], "N") == "Y".ToString())
                {
                    MANAGEMENT2.ReadOnly = false;
                }
            }
            MANAGEMENT2.Refresh();

            REFER1.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
            REFER1.NumberDecimalDigits = 0;
            if (iString.ISNull(pDataRow["REFER1_YN"], "F") == "F".ToString())
            {
                REFER1.Nullable = true;
                REFER1.ReadOnly = true;
                REFER1.Insertable = false;
                REFER1.Updatable = false;
                REFER1.TabStop = false;
            }
            else
            {
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
                else if (iString.ISNull(pDataRow["REFER1_DATA_TYPE"]) == "DATE".ToString())
                {
                    REFER1.EditAdvType = ISUtil.Enum.EditAdvType.DateTimeEdit;
                }
                if (iString.ISNull(pDataRow["REFER1_YN"], "N") == "Y".ToString())
                {
                    REFER1.ReadOnly = false;
                }
            }
            REFER1.Refresh();

            REFER2.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
            REFER2.NumberDecimalDigits = 0;
            if (iString.ISNull(pDataRow["REFER2_YN"], "F") == "F".ToString())
            {
                REFER2.Nullable = true;
                REFER2.ReadOnly = true;
                REFER2.Insertable = false;
                REFER2.Updatable = false;
                REFER2.TabStop = false;
            }
            else
            {
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
                else if (iString.ISNull(pDataRow["REFER2_DATA_TYPE"]) == "DATE".ToString())
                {
                    REFER2.EditAdvType = ISUtil.Enum.EditAdvType.DateTimeEdit;
                }
                if (iString.ISNull(pDataRow["REFER2_YN"], "N") == "Y".ToString())
                {
                    REFER2.ReadOnly = false;
                }
            }
            REFER2.Refresh();

            REFER3.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
            REFER3.NumberDecimalDigits = 0;
            if (iString.ISNull(pDataRow["REFER3_YN"], "F") == "F".ToString())
            {
                REFER3.Nullable = true;
                REFER3.ReadOnly = true;
                REFER3.Insertable = false;
                REFER3.Updatable = false;
                REFER3.TabStop = false;
            }
            else
            {
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
                else if (iString.ISNull(pDataRow["REFER3_DATA_TYPE"]) == "DATE".ToString())
                {
                    REFER3.EditAdvType = ISUtil.Enum.EditAdvType.DateTimeEdit;
                }
                if (iString.ISNull(pDataRow["REFER3_YN"], "N") == "Y".ToString())
                {
                    REFER3.ReadOnly = false;
                }
            }
            REFER3.Refresh();

            REFER4.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
            REFER4.NumberDecimalDigits = 0;
            if (iString.ISNull(pDataRow["REFER4_YN"], "F") == "F".ToString())
            {
                REFER4.Nullable = true;
                REFER4.ReadOnly = true;
                REFER4.Insertable = false;
                REFER4.Updatable = false;
                REFER4.TabStop = false;
            }
            else
            {
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
                else if (iString.ISNull(pDataRow["REFER4_DATA_TYPE"]) == "DATE".ToString())
                {
                    REFER4.EditAdvType = ISUtil.Enum.EditAdvType.DateTimeEdit;
                }
                if (iString.ISNull(pDataRow["REFER4_YN"], "N") == "Y".ToString())
                {
                    REFER4.ReadOnly = false;
                }
            }
            REFER4.Refresh();

            REFER5.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
            REFER5.NumberDecimalDigits = 0;
            if (iString.ISNull(pDataRow["REFER5_YN"], "F") == "F".ToString())
            {
                REFER5.Nullable = true;
                REFER5.ReadOnly = true;
                REFER5.Insertable = false;
                REFER5.Updatable = false;
                REFER5.TabStop = false;
            }
            else
            {
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
                else if (iString.ISNull(pDataRow["REFER5_DATA_TYPE"]) == "DATE".ToString())
                {
                    REFER5.EditAdvType = ISUtil.Enum.EditAdvType.DateTimeEdit;
                }
                if (iString.ISNull(pDataRow["REFER5_YN"], "N") == "Y".ToString())
                {
                    REFER5.ReadOnly = false;
                }
            }
            REFER5.Refresh();

            REFER6.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
            REFER6.NumberDecimalDigits = 0;
            if (iString.ISNull(pDataRow["REFER6_YN"], "F") == "F".ToString())
            {
                REFER6.Nullable = true;
                REFER6.ReadOnly = true;
                REFER6.Insertable = false;
                REFER6.Updatable = false;
                REFER6.TabStop = false;
            }
            else
            {
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
                else if (iString.ISNull(pDataRow["REFER6_DATA_TYPE"]) == "DATE".ToString())
                {
                    REFER6.EditAdvType = ISUtil.Enum.EditAdvType.DateTimeEdit;
                }
                if (iString.ISNull(pDataRow["REFER6_YN"], "N") == "Y".ToString())
                {
                    REFER6.ReadOnly = false;
                }
            }
            REFER6.Refresh();
            
            REFER7.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
            REFER7.NumberDecimalDigits = 0;
            if (iString.ISNull(pDataRow["REFER7_YN"], "F") == "F".ToString())
            {
                REFER7.Nullable = true;
                REFER7.ReadOnly = true;
                REFER7.Insertable = false;
                REFER7.Updatable = false;
                REFER7.TabStop = false;
            }
            else
            {
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
                else if (iString.ISNull(pDataRow["REFER7_DATA_TYPE"]) == "DATE".ToString())
                {
                    REFER7.EditAdvType = ISUtil.Enum.EditAdvType.DateTimeEdit;
                }
                if (iString.ISNull(pDataRow["REFER7_YN"], "N") == "Y".ToString())
                {
                    REFER7.ReadOnly = false;
                }
            }
            REFER7.Refresh();

            REFER8.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
            REFER8.NumberDecimalDigits = 0;
            if (iString.ISNull(pDataRow["REFER8_YN"], "F") == "F".ToString())
            {
                REFER8.Nullable = true;
                REFER8.ReadOnly = true;
                REFER8.Insertable = false;
                REFER8.Updatable = false;
                REFER8.TabStop = false;
            }
            else
            {
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
                else if (iString.ISNull(pDataRow["REFER8_DATA_TYPE"]) == "DATE".ToString())
                {
                    REFER8.EditAdvType = ISUtil.Enum.EditAdvType.DateTimeEdit;
                }
                if (iString.ISNull(pDataRow["REFER8_YN"], "N") == "Y".ToString())
                {
                    REFER8.ReadOnly = false;
                }
            }
            REFER8.Refresh();

            REFER9.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
            REFER9.NumberDecimalDigits = 0;
            if (iString.ISNull(pDataRow["REFER9_YN"], "F") == "F".ToString())
            {
                REFER9.Nullable = true;
                REFER9.ReadOnly = true;
                REFER9.Insertable = false;
                REFER9.Updatable = false;
                REFER9.TabStop = false;
            }
            else
            {
                REFER9.ReadOnly = false;
                REFER9.Insertable = true;
                REFER9.Updatable = true;
                REFER9.TabStop = true;
                if (iString.ISNull(pDataRow["REFER9_DATA_TYPE"]) == "NUMBER".ToString())
                {
                    REFER9.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                }
                else if (iString.ISNull(pDataRow["REFER9_DATA_TYPE"]) == "RATE".ToString())
                {
                    REFER9.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                    REFER9.NumberDecimalDigits = 4;
                }
                else if (iString.ISNull(pDataRow["REFER9_DATA_TYPE"]) == "DATE".ToString())
                {
                    REFER9.EditAdvType = ISUtil.Enum.EditAdvType.DateTimeEdit;
                }
                if (iString.ISNull(pDataRow["REFER9_YN"], "N") == "Y".ToString())
                {
                    REFER9.ReadOnly = false;
                }
            }
            REFER9.Refresh();
            
            REFER10.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
            REFER10.NumberDecimalDigits = 0;
            if (iString.ISNull(pDataRow["REFER10_YN"], "F") == "F".ToString())
            {
                REFER10.Nullable = true;
                REFER10.ReadOnly = true;
                REFER10.Insertable = false;
                REFER10.Updatable = false;
                REFER10.TabStop = false;
            }
            else
            {
                REFER10.ReadOnly = false;
                REFER10.Insertable = true;
                REFER10.Updatable = true;
                REFER10.TabStop = true;
                if (iString.ISNull(pDataRow["REFER10_DATA_TYPE"]) == "NUMBER".ToString())
                {
                    REFER10.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                }
                else if (iString.ISNull(pDataRow["REFER10_DATA_TYPE"]) == "RATE".ToString())
                {
                    REFER10.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                    REFER10.NumberDecimalDigits = 4;
                }
                else if (iString.ISNull(pDataRow["REFER10_DATA_TYPE"]) == "DATE".ToString())
                {
                    REFER10.EditAdvType = ISUtil.Enum.EditAdvType.DateTimeEdit;
                }
                if (iString.ISNull(pDataRow["REFER10_YN"], "N") == "Y".ToString())
                {
                    REFER10.ReadOnly = false;
                }
            }
            REFER10.Refresh();

            REFER11.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
            REFER11.NumberDecimalDigits = 0;
            if (iString.ISNull(pDataRow["REFER11_YN"], "F") == "F".ToString())
            {
                REFER11.Nullable = true;
                REFER11.ReadOnly = true;
                REFER11.Insertable = false;
                REFER11.Updatable = false;
                REFER11.TabStop = false;
            }
            else
            {
                REFER11.ReadOnly = false;
                REFER11.Insertable = true;
                REFER11.Updatable = true;
                REFER11.TabStop = true;
                if (iString.ISNull(pDataRow["REFER11_DATA_TYPE"]) == "NUMBER".ToString())
                {
                    REFER11.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                }
                else if (iString.ISNull(pDataRow["REFER11_DATA_TYPE"]) == "RATE".ToString())
                {
                    REFER11.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                    REFER11.NumberDecimalDigits = 4;
                }
                else if (iString.ISNull(pDataRow["REFER11_DATA_TYPE"]) == "DATE".ToString())
                {
                    REFER11.EditAdvType = ISUtil.Enum.EditAdvType.DateTimeEdit;
                }
                if (iString.ISNull(pDataRow["REFER11_YN"], "N") == "Y".ToString())
                {
                    REFER11.ReadOnly = false;
                }
            }
            REFER11.Refresh();

            REFER12.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
            REFER12.NumberDecimalDigits = 0;
            if (iString.ISNull(pDataRow["REFER12_YN"], "F") == "F".ToString())
            {
                REFER12.Nullable = true;
                REFER12.ReadOnly = true;
                REFER12.Insertable = false;
                REFER12.Updatable = false;
                REFER12.TabStop = false;
            }
            else
            {
                REFER12.ReadOnly = false;
                REFER12.Insertable = true;
                REFER12.Updatable = true;
                REFER12.TabStop = true;
                if (iString.ISNull(pDataRow["REFER12_DATA_TYPE"]) == "NUMBER".ToString())
                {
                    REFER12.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                }
                else if (iString.ISNull(pDataRow["REFER12_DATA_TYPE"]) == "RATE".ToString())
                {
                    REFER12.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                    REFER12.NumberDecimalDigits = 4;
                }
                else if (iString.ISNull(pDataRow["REFER12_DATA_TYPE"]) == "DATE".ToString())
                {
                    REFER12.EditAdvType = ISUtil.Enum.EditAdvType.DateTimeEdit;
                }
                if (iString.ISNull(pDataRow["REFER12_YN"], "N") == "Y".ToString())
                {
                    REFER12.ReadOnly = false;
                }
            }
            REFER12.Refresh();

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
            
            if (iString.ISNull(pDataRow["REFER9_LOOKUP_YN"], "N") == "Y".ToString())
            {
                REFER9.LookupAdapter = ilaREFER9;
            }
            else
            {
                REFER9.LookupAdapter = null;
            }

            if (iString.ISNull(pDataRow["REFER10_LOOKUP_YN"], "N") == "Y".ToString())
            {
                REFER10.LookupAdapter = ilaREFER10;
            }
            else
            {
                REFER10.LookupAdapter = null;
            }
            
            if (iString.ISNull(pDataRow["REFER11_LOOKUP_YN"], "N") == "Y".ToString())
            {
                REFER11.LookupAdapter = ilaREFER11;
            }
            else
            {
                REFER11.LookupAdapter = null;
            }

            if (iString.ISNull(pDataRow["REFER12_LOOKUP_YN"], "N") == "Y".ToString())
            {
                REFER12.LookupAdapter = ilaREFER12;
            }
            else
            {
                REFER12.LookupAdapter = null;
            }            
        }

        private void Init_Set_Item_Need(object pACCOUNT_DR_CR)
        {// 관리항목 필수여부 세팅.
            if (iString.ISNull(pACCOUNT_DR_CR) == string.Empty)
            {
                return;
            }
            object mDATA_VALUE;
            object mDATA_TYPE;
            object mDR_CR_YN = "N";
            ///////////////////////////////////////////////////////////////////////////////////////////////////
            //--1
            mDATA_VALUE = MANAGEMENT1.EditValue;
            MANAGEMENT1.Nullable = true;
            mDATA_TYPE = igrSLIP_LINE.GetCellValue("MANAGEMENT1_DATA_TYPE");
            if (iString.ISNull(pACCOUNT_DR_CR) == "1")
            {
                mDR_CR_YN = igrSLIP_LINE.GetCellValue("MANAGEMENT1_DR_YN");
            }
            else if (iString.ISNull(pACCOUNT_DR_CR) == "2")
            {
                mDR_CR_YN = igrSLIP_LINE.GetCellValue("MANAGEMENT1_CR_YN");
            }
            if (iString.ISNull(mDATA_TYPE) == "VARCHAR2" && iString.ISNull(mDR_CR_YN) == "Y")
            {
                MANAGEMENT1.Nullable = false;
            }
            MANAGEMENT1.EditValue = mDATA_VALUE;
            MANAGEMENT1.Refresh();
            //--2
            mDATA_VALUE = MANAGEMENT2.EditValue;
            MANAGEMENT2.Nullable = true;
            mDATA_TYPE = igrSLIP_LINE.GetCellValue("MANAGEMENT2_DATA_TYPE");
            if (iString.ISNull(pACCOUNT_DR_CR) == "1")
            {
                mDR_CR_YN = igrSLIP_LINE.GetCellValue("MANAGEMENT2_DR_YN");
            }
            else if (iString.ISNull(pACCOUNT_DR_CR) == "2")
            {
                mDR_CR_YN = igrSLIP_LINE.GetCellValue("MANAGEMENT2_CR_YN");
            }
            if (iString.ISNull(mDATA_TYPE) == "VARCHAR2" && iString.ISNull(mDR_CR_YN) == "Y")
            {
                MANAGEMENT2.Nullable = false;
            }
            MANAGEMENT2.Refresh();
            MANAGEMENT2.EditValue = mDATA_VALUE;
            //--3
            mDATA_VALUE = REFER1.EditValue;
            REFER1.Nullable = true;
            mDATA_TYPE = igrSLIP_LINE.GetCellValue("REFER1_DATA_TYPE");
            if (iString.ISNull(pACCOUNT_DR_CR) == "1")
            {
                mDR_CR_YN = igrSLIP_LINE.GetCellValue("REFER1_DR_YN");
            }
            else if (iString.ISNull(pACCOUNT_DR_CR) == "2")
            {
                mDR_CR_YN = igrSLIP_LINE.GetCellValue("REFER1_CR_YN");
            }            
            if (iString.ISNull(mDATA_TYPE) == "VARCHAR2" && iString.ISNull(mDR_CR_YN) == "Y")
            {
                REFER1.Nullable = false;
            }
            REFER1.Refresh();
            REFER1.EditValue = mDATA_VALUE;
            //--4
            mDATA_VALUE = REFER2.EditValue;
            REFER2.Nullable = true;
            mDATA_TYPE = igrSLIP_LINE.GetCellValue("REFER2_DATA_TYPE");
            if (iString.ISNull(pACCOUNT_DR_CR) == "1")
            {
                mDR_CR_YN = igrSLIP_LINE.GetCellValue("REFER2_DR_YN");
            }
            else if (iString.ISNull(pACCOUNT_DR_CR) == "2")
            {
                mDR_CR_YN = igrSLIP_LINE.GetCellValue("REFER2_CR_YN");
            }
            if (iString.ISNull(mDATA_TYPE) == "VARCHAR2" && iString.ISNull(mDR_CR_YN) == "Y")
            {
                REFER2.Nullable = false;
            }
            REFER2.Refresh();
            REFER2.EditValue = mDATA_VALUE;
            //--5
            mDATA_VALUE = REFER3.EditValue;
            REFER3.Nullable = true;
            mDATA_TYPE = igrSLIP_LINE.GetCellValue("REFER3_DATA_TYPE");
            if (iString.ISNull(pACCOUNT_DR_CR) == "1")
            {
                mDR_CR_YN = igrSLIP_LINE.GetCellValue("REFER3_DR_YN");
            }
            else if (iString.ISNull(pACCOUNT_DR_CR) == "2")
            {
                mDR_CR_YN = igrSLIP_LINE.GetCellValue("REFER3_CR_YN");
            }
            if (iString.ISNull(mDATA_TYPE) == "VARCHAR2" && iString.ISNull(mDR_CR_YN) == "Y")
            {
                REFER3.Nullable = false;
            }
            REFER3.Refresh();
            REFER3.EditValue = mDATA_VALUE;
            //--6
            mDATA_VALUE = REFER4.EditValue;
            REFER4.Nullable = true;
            mDATA_TYPE = igrSLIP_LINE.GetCellValue("REFER4_DATA_TYPE");
            if (iString.ISNull(pACCOUNT_DR_CR) == "1")
            {
                mDR_CR_YN = igrSLIP_LINE.GetCellValue("REFER4_DR_YN");
            }
            else if (iString.ISNull(pACCOUNT_DR_CR) == "2")
            {
                mDR_CR_YN = igrSLIP_LINE.GetCellValue("REFER4_CR_YN");
            }
            if (iString.ISNull(mDATA_TYPE) == "VARCHAR2" && iString.ISNull(mDR_CR_YN) == "Y")
            {
                REFER4.Nullable = false;
            }
            REFER4.Refresh();
            REFER4.EditValue = mDATA_VALUE;
            //--7
            mDATA_VALUE = REFER5.EditValue;
            REFER5.Nullable = true;
            mDATA_TYPE = igrSLIP_LINE.GetCellValue("REFER5_DATA_TYPE");
            if (iString.ISNull(pACCOUNT_DR_CR) == "1")
            {
                mDR_CR_YN = igrSLIP_LINE.GetCellValue("REFER5_DR_YN");
            }
            else if (iString.ISNull(pACCOUNT_DR_CR) == "2")
            {
                mDR_CR_YN = igrSLIP_LINE.GetCellValue("REFER5_CR_YN");
            }
            if (iString.ISNull(mDATA_TYPE) == "VARCHAR2" && iString.ISNull(mDR_CR_YN) == "Y")
            {
                REFER5.Nullable = false;
            }
            REFER5.Refresh();
            REFER5.EditValue = mDATA_VALUE;
            //--8
            mDATA_VALUE = REFER6.EditValue;
            REFER6.Nullable = true;
            mDATA_TYPE = igrSLIP_LINE.GetCellValue("REFER6_DATA_TYPE");
            if (iString.ISNull(pACCOUNT_DR_CR) == "1")
            {
                mDR_CR_YN = igrSLIP_LINE.GetCellValue("REFER6_DR_YN");
            }
            else if (iString.ISNull(pACCOUNT_DR_CR) == "2")
            {
                mDR_CR_YN = igrSLIP_LINE.GetCellValue("REFER6_CR_YN");
            }
            if (iString.ISNull(mDATA_TYPE) == "VARCHAR2" && iString.ISNull(mDR_CR_YN) == "Y")
            {
                REFER6.Nullable = false;
            }
            REFER6.Refresh();
            REFER6.EditValue = mDATA_VALUE;
            //--9
            mDATA_VALUE = REFER7.EditValue;
            REFER7.Nullable = true;
            mDATA_TYPE = igrSLIP_LINE.GetCellValue("REFER7_DATA_TYPE");
            if (iString.ISNull(pACCOUNT_DR_CR) == "1")
            {
                mDR_CR_YN = igrSLIP_LINE.GetCellValue("REFER7_DR_YN");
            }
            else if (iString.ISNull(pACCOUNT_DR_CR) == "2")
            {
                mDR_CR_YN = igrSLIP_LINE.GetCellValue("REFER7_CR_YN");
            }
            if (iString.ISNull(mDATA_TYPE) == "VARCHAR2" && iString.ISNull(mDR_CR_YN) == "Y")
            {
                REFER7.Nullable = false;
            }
            REFER7.Refresh();
            REFER7.EditValue = mDATA_VALUE;
            //--10
            mDATA_VALUE = REFER8.EditValue;
            REFER8.Nullable = true;
            mDATA_TYPE = igrSLIP_LINE.GetCellValue("REFER8_DATA_TYPE");
            if (iString.ISNull(pACCOUNT_DR_CR) == "1")
            {
                mDR_CR_YN = igrSLIP_LINE.GetCellValue("REFER8_DR_YN");
            }
            else if (iString.ISNull(pACCOUNT_DR_CR) == "2")
            {
                mDR_CR_YN = igrSLIP_LINE.GetCellValue("REFER8_CR_YN");
            }
            if (iString.ISNull(mDATA_TYPE) == "VARCHAR2" && iString.ISNull(mDR_CR_YN) == "Y")
            {
                REFER8.Nullable = false;
            }
            REFER8.Refresh();
            REFER8.EditValue = mDATA_VALUE;
            //--11
            mDATA_VALUE = REFER9.EditValue;
            REFER9.Nullable = true;
            mDATA_TYPE = igrSLIP_LINE.GetCellValue("REFER9_DATA_TYPE");
            if (iString.ISNull(pACCOUNT_DR_CR) == "1")
            {
                mDR_CR_YN = igrSLIP_LINE.GetCellValue("REFER9_DR_YN");
            }
            else if (iString.ISNull(pACCOUNT_DR_CR) == "2")
            {
                mDR_CR_YN = igrSLIP_LINE.GetCellValue("REFER9_CR_YN");
            }
            if (iString.ISNull(mDATA_TYPE) == "VARCHAR2" && iString.ISNull(mDR_CR_YN) == "Y")
            {
                REFER9.Nullable = false;
            }
            REFER9.Refresh();
            REFER9.EditValue = mDATA_VALUE;
            //--12
            mDATA_VALUE = REFER10.EditValue;
            REFER10.Nullable = true;
            mDATA_TYPE = igrSLIP_LINE.GetCellValue("REFER10_DATA_TYPE");
            if (iString.ISNull(pACCOUNT_DR_CR) == "1")
            {
                mDR_CR_YN = igrSLIP_LINE.GetCellValue("REFER10_DR_YN");
            }
            else if (iString.ISNull(pACCOUNT_DR_CR) == "2")
            {
                mDR_CR_YN = igrSLIP_LINE.GetCellValue("REFER10_CR_YN");
            }
            if (iString.ISNull(mDATA_TYPE) == "VARCHAR2" && iString.ISNull(mDR_CR_YN) == "Y")
            {
                REFER10.Nullable = false;
            }
            REFER10.Refresh();
            REFER10.EditValue = mDATA_VALUE;
            //--13
            mDATA_VALUE = REFER11.EditValue;
            REFER11.Nullable = true;
            mDATA_TYPE = igrSLIP_LINE.GetCellValue("REFER11_DATA_TYPE");
            if (iString.ISNull(pACCOUNT_DR_CR) == "1")
            {
                mDR_CR_YN = igrSLIP_LINE.GetCellValue("REFER11_DR_YN");
            }
            else if (iString.ISNull(pACCOUNT_DR_CR) == "2")
            {
                mDR_CR_YN = igrSLIP_LINE.GetCellValue("REFER11_CR_YN");
            }
            if (iString.ISNull(mDATA_TYPE) == "VARCHAR2" && iString.ISNull(mDR_CR_YN) == "Y")
            {
                REFER11.Nullable = false;
            }
            REFER11.Refresh();
            REFER11.EditValue = mDATA_VALUE;
            //--14
            mDATA_VALUE = REFER12.EditValue;
            REFER12.Nullable = true;
            mDATA_TYPE = igrSLIP_LINE.GetCellValue("REFER12_DATA_TYPE");
            if (iString.ISNull(pACCOUNT_DR_CR) == "1")
            {
                mDR_CR_YN = igrSLIP_LINE.GetCellValue("REFER12_DR_YN");
            }
            else if (iString.ISNull(pACCOUNT_DR_CR) == "2")
            {
                mDR_CR_YN = igrSLIP_LINE.GetCellValue("REFER12_CR_YN");
            }
            if (iString.ISNull(mDATA_TYPE) == "VARCHAR2" && iString.ISNull(mDR_CR_YN) == "Y")
            {
                REFER12.Nullable = false;
            }
            REFER12.Refresh();
            REFER12.EditValue = mDATA_VALUE;
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
            igrSLIP_LINE.SetCellValue("REFER9", null);
            igrSLIP_LINE.SetCellValue("REFER9_DESC", null);
            igrSLIP_LINE.SetCellValue("REFER10", null);
            igrSLIP_LINE.SetCellValue("REFER10_DESC", null);
            igrSLIP_LINE.SetCellValue("REFER11", null);
            igrSLIP_LINE.SetCellValue("REFER11_DESC", null);
            igrSLIP_LINE.SetCellValue("REFER12", null);
            igrSLIP_LINE.SetCellValue("REFER12_DESC", null);
        }

        private void Init_Default_Value()
        {
            int mPreviousRowPosition = idaSLIP_LINE.CurrentRowPosition() - 1;
            object mPrevious_Code;
            object mPrevious_Name;
            string mData_Type;
            string mLookup_Type;
            //1
            mData_Type = iString.ISNull(igrSLIP_LINE.GetCellValue("MANAGEMENT1_DATA_TYPE"));
            mLookup_Type = iString.ISNull(igrSLIP_LINE.GetCellValue("MANAGEMENT1_LOOKUP_TYPE"));
            if (mData_Type == "NUMBER".ToString())
            {
            }
            else if (mData_Type == "RATE".ToString())
            {
            }
            else if (mData_Type == "DATE".ToString())
            {
                if (iString.ISNull(MANAGEMENT1.EditValue) == string.Empty && iString.ISNull(SLIP_DATE.EditValue) != string.Empty)
                {
                    MANAGEMENT1.EditValue = Convert.ToDateTime(SLIP_DATE.EditValue).ToShortDateString();
                }
            }
            if (mPreviousRowPosition > -1
                && mLookup_Type != string.Empty
                && mLookup_Type == iString.ISNull(idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["MANAGEMENT1_LOOKUP_TYPE"]))
            {//MANAGEMENT1_LOOKUP_TYPE
                mPrevious_Code = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["MANAGEMENT1"];
                mPrevious_Name = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["MANAGEMENT1_DESC"];

                MANAGEMENT1.EditValue = mPrevious_Code;
                MANAGEMENT1_DESC.EditValue = mPrevious_Name;
            }
            //2
            mData_Type = iString.ISNull(igrSLIP_LINE.GetCellValue("MANAGEMENT2_DATA_TYPE"));
            mLookup_Type = iString.ISNull(igrSLIP_LINE.GetCellValue("MANAGEMENT2_LOOKUP_TYPE"));
            if (mData_Type == "NUMBER".ToString())
            {
            }
            else if (mData_Type == "RATE".ToString())
            {
            }
            else if (mData_Type == "DATE".ToString())
            {
                if (iString.ISNull(MANAGEMENT2.EditValue) == string.Empty && iString.ISNull(SLIP_DATE.EditValue) != string.Empty)
                {
                    MANAGEMENT2.EditValue = Convert.ToDateTime(SLIP_DATE.EditValue).ToShortDateString();
                }
            }
            if (mPreviousRowPosition > -1
                && mLookup_Type != string.Empty
                && mLookup_Type == iString.ISNull(idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["MANAGEMENT2_LOOKUP_TYPE"]))
            {//MANAGEMENT2_LOOKUP_TYPE
                mPrevious_Code = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["MANAGEMENT2"];
                mPrevious_Name = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["MANAGEMENT2_DESC"];

                MANAGEMENT2.EditValue = mPrevious_Code;
                MANAGEMENT2_DESC.EditValue = mPrevious_Name;
            }
            //3
            mData_Type = iString.ISNull(igrSLIP_LINE.GetCellValue("REFER1_DATA_TYPE"));
            mLookup_Type = iString.ISNull(igrSLIP_LINE.GetCellValue("REFER1_LOOKUP_TYPE"));
            if (mData_Type == "NUMBER".ToString())
            {
            }
            else if (mData_Type == "RATE".ToString())
            {
            }
            else if (mData_Type == "DATE".ToString())
            {
                if (iString.ISNull(REFER1.EditValue) == string.Empty && iString.ISNull(SLIP_DATE.EditValue) != string.Empty)
                {
                    REFER1.EditValue = Convert.ToDateTime(SLIP_DATE.EditValue).ToShortDateString();
                }
            }
            if (mPreviousRowPosition > -1
                && mLookup_Type != string.Empty
                && mLookup_Type == iString.ISNull(idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER1_LOOKUP_TYPE"]))
            {//REFER1_LOOKUP_TYPE
                mPrevious_Code = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER1"];
                mPrevious_Name = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER1_DESC"];

                REFER1.EditValue = mPrevious_Code;
                REFER1_DESC.EditValue = mPrevious_Name;
            }
            //4
            mData_Type = iString.ISNull(igrSLIP_LINE.GetCellValue("REFER2_DATA_TYPE"));
            mLookup_Type = iString.ISNull(igrSLIP_LINE.GetCellValue("REFER2_LOOKUP_TYPE"));
            if (mData_Type == "NUMBER".ToString())
            {
            }
            else if (mData_Type == "RATE".ToString())
            {
            }
            else if (mData_Type == "DATE".ToString())
            {
                if (iString.ISNull(REFER2.EditValue) == string.Empty && iString.ISNull(SLIP_DATE.EditValue) != string.Empty)
                {
                    REFER2.EditValue = Convert.ToDateTime(SLIP_DATE.EditValue).ToShortDateString();
                }
            }
            if (mPreviousRowPosition > -1
                && mLookup_Type != string.Empty
                && mLookup_Type == iString.ISNull(idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER2_LOOKUP_TYPE"]))
            {//REFER2_LOOKUP_TYPE
                mPrevious_Code = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER2"];
                mPrevious_Name = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER2_DESC"];

                REFER2.EditValue = mPrevious_Code;
                REFER2_DESC.EditValue = mPrevious_Name;
            }
            //5
            mData_Type = iString.ISNull(igrSLIP_LINE.GetCellValue("REFER3_DATA_TYPE"));
            mLookup_Type = iString.ISNull(igrSLIP_LINE.GetCellValue("REFER3_LOOKUP_TYPE"));
            if (mData_Type == "NUMBER".ToString())
            {
            }
            else if (mData_Type == "RATE".ToString())
            {
            }
            else if (mData_Type == "DATE".ToString())
            {
                if (iString.ISNull(REFER3.EditValue) == string.Empty && iString.ISNull(SLIP_DATE.EditValue) != string.Empty)
                {
                    REFER3.EditValue = Convert.ToDateTime(SLIP_DATE.EditValue).ToShortDateString();
                }
            }
            if (mPreviousRowPosition > -1
                && mLookup_Type != string.Empty
                && mLookup_Type == iString.ISNull(idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER3_LOOKUP_TYPE"]))
            {//REFER3_LOOKUP_TYPE
                mPrevious_Code = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER3"];
                mPrevious_Name = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER3_DESC"];

                REFER3.EditValue = mPrevious_Code;
                REFER3_DESC.EditValue = mPrevious_Name;
            }
            //6
            mData_Type = iString.ISNull(igrSLIP_LINE.GetCellValue("REFER4_DATA_TYPE"));
            mLookup_Type = iString.ISNull(igrSLIP_LINE.GetCellValue("REFER4_LOOKUP_TYPE"));
            if (mData_Type == "NUMBER".ToString())
            {
            }
            else if (mData_Type == "RATE".ToString())
            {
            }
            else if (mData_Type == "DATE".ToString())
            {
                if (iString.ISNull(REFER4.EditValue) == string.Empty && iString.ISNull(SLIP_DATE.EditValue) != string.Empty)
                {
                    REFER4.EditValue = Convert.ToDateTime(SLIP_DATE.EditValue).ToShortDateString();
                }
            }
            if (mPreviousRowPosition > -1
                && mLookup_Type != string.Empty
                && mLookup_Type == iString.ISNull(idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER4_LOOKUP_TYPE"]))
            {//REFER4_LOOKUP_TYPE
                mPrevious_Code = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER4"];
                mPrevious_Name = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER4_DESC"];

                REFER4.EditValue = mPrevious_Code;
                REFER4_DESC.EditValue = mPrevious_Name;
            }
            //7
            mData_Type = iString.ISNull(igrSLIP_LINE.GetCellValue("REFER5_DATA_TYPE"));
            mLookup_Type = iString.ISNull(igrSLIP_LINE.GetCellValue("REFER5_LOOKUP_TYPE"));
            if (mData_Type == "NUMBER".ToString())
            {
            }
            else if (mData_Type == "RATE".ToString())
            {
            }
            else if (mData_Type == "DATE".ToString())
            {
                if (iString.ISNull(REFER5.EditValue) == string.Empty && iString.ISNull(SLIP_DATE.EditValue) != string.Empty)
                {
                    REFER5.EditValue = Convert.ToDateTime(SLIP_DATE.EditValue).ToShortDateString();
                }
            }
            if (mPreviousRowPosition > -1
                && mLookup_Type != string.Empty
                && mLookup_Type == iString.ISNull(idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER5_LOOKUP_TYPE"]))
            {//REFER5_LOOKUP_TYPE
                mPrevious_Code = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER5"];
                mPrevious_Name = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER5_DESC"];

                REFER5.EditValue = mPrevious_Code;
                REFER5_DESC.EditValue = mPrevious_Name;
            }
            //8
            mData_Type = iString.ISNull(igrSLIP_LINE.GetCellValue("REFER6_DATA_TYPE"));
            mLookup_Type = iString.ISNull(igrSLIP_LINE.GetCellValue("REFER6_LOOKUP_TYPE"));
            if (mData_Type == "NUMBER".ToString())
            {
            }
            else if (mData_Type == "RATE".ToString())
            {
            }
            else if (mData_Type == "DATE".ToString())
            {
                if (iString.ISNull(REFER6.EditValue) == string.Empty && iString.ISNull(SLIP_DATE.EditValue) != string.Empty)
                {
                    REFER6.EditValue = Convert.ToDateTime(SLIP_DATE.EditValue).ToShortDateString();
                }
            }
            if (mPreviousRowPosition > -1
                && mLookup_Type != string.Empty
                && mLookup_Type == iString.ISNull(idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER6_LOOKUP_TYPE"]))
            {//REFER6_LOOKUP_TYPE
                mPrevious_Code = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER6"];
                mPrevious_Name = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER6_DESC"];

                REFER6.EditValue = mPrevious_Code;
                REFER6_DESC.EditValue = mPrevious_Name;
            }
            //9
            mData_Type = iString.ISNull(igrSLIP_LINE.GetCellValue("REFER7_DATA_TYPE"));
            mLookup_Type = iString.ISNull(igrSLIP_LINE.GetCellValue("REFER7_LOOKUP_TYPE"));
            if (mData_Type == "NUMBER".ToString())
            {
            }
            else if (mData_Type == "RATE".ToString())
            {
            }
            else if (mData_Type == "DATE".ToString())
            {
                if (iString.ISNull(REFER7.EditValue) == string.Empty && iString.ISNull(SLIP_DATE.EditValue) != string.Empty)
                {
                    REFER7.EditValue = Convert.ToDateTime(SLIP_DATE.EditValue).ToShortDateString();
                }
            }
            if (mPreviousRowPosition > -1
                && mLookup_Type != string.Empty
                && mLookup_Type == iString.ISNull(idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER7_LOOKUP_TYPE"]))
            {//REFER7_LOOKUP_TYPE
                mPrevious_Code = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER7"];
                mPrevious_Name = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER7_DESC"];

                REFER7.EditValue = mPrevious_Code;
                REFER7_DESC.EditValue = mPrevious_Name;
            }
            //10
            mData_Type = iString.ISNull(igrSLIP_LINE.GetCellValue("REFER8_DATA_TYPE"));
            mLookup_Type = iString.ISNull(igrSLIP_LINE.GetCellValue("REFER8_LOOKUP_TYPE"));
            if (mData_Type == "NUMBER".ToString())
            {
            }
            else if (mData_Type == "RATE".ToString())
            {
            }
            else if (mData_Type == "DATE".ToString())
            {
                if (iString.ISNull(REFER8.EditValue) == string.Empty && iString.ISNull(SLIP_DATE.EditValue) != string.Empty)
                {
                    REFER8.EditValue = Convert.ToDateTime(SLIP_DATE.EditValue).ToShortDateString();
                }
            }
            if (mPreviousRowPosition > -1
                && mLookup_Type != string.Empty
                && mLookup_Type == iString.ISNull(idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER8_LOOKUP_TYPE"]))
            {//REFER8_LOOKUP_TYPE
                mPrevious_Code = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER8"];
                mPrevious_Name = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER8_DESC"];

                REFER8.EditValue = mPrevious_Code;
                REFER8_DESC.EditValue = mPrevious_Name;
            }
            //11
            mData_Type = iString.ISNull(igrSLIP_LINE.GetCellValue("REFER9_DATA_TYPE"));
            mLookup_Type = iString.ISNull(igrSLIP_LINE.GetCellValue("REFER9_LOOKUP_TYPE"));
            if (mData_Type == "NUMBER".ToString())
            {
            }
            else if (mData_Type == "RATE".ToString())
            {
            }
            else if (mData_Type == "DATE".ToString())
            {
                if (iString.ISNull(REFER9.EditValue) == string.Empty && iString.ISNull(SLIP_DATE.EditValue) != string.Empty)
                {
                    REFER9.EditValue = Convert.ToDateTime(SLIP_DATE.EditValue).ToShortDateString();
                }
            }
            if (mPreviousRowPosition > -1
                && mLookup_Type != string.Empty
                && mLookup_Type == iString.ISNull(idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER9_LOOKUP_TYPE"]))
            {//REFER9_LOOKUP_TYPE
                mPrevious_Code = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER9"];
                mPrevious_Name = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER9_DESC"];

                REFER9.EditValue = mPrevious_Code;
                REFER9_DESC.EditValue = mPrevious_Name;
            }
            //12
            mData_Type = iString.ISNull(igrSLIP_LINE.GetCellValue("REFER10_DATA_TYPE"));
            mLookup_Type = iString.ISNull(igrSLIP_LINE.GetCellValue("REFER10_LOOKUP_TYPE"));
            if (mData_Type == "NUMBER".ToString())
            {
            }
            else if (mData_Type == "RATE".ToString())
            {
            }
            else if (mData_Type == "DATE".ToString())
            {
                if (iString.ISNull(REFER10.EditValue) == string.Empty && iString.ISNull(SLIP_DATE.EditValue) != string.Empty)
                {
                    REFER10.EditValue = Convert.ToDateTime(SLIP_DATE.EditValue).ToShortDateString();
                }
            }
            if (mPreviousRowPosition > -1
                && mLookup_Type != string.Empty
                && mLookup_Type == iString.ISNull(idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER10_LOOKUP_TYPE"]))
            {//REFER10_LOOKUP_TYPE
                mPrevious_Code = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER10"];
                mPrevious_Name = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER10_DESC"];

                REFER10.EditValue = mPrevious_Code;
                REFER10_DESC.EditValue = mPrevious_Name;
            }
            //13
            mData_Type = iString.ISNull(igrSLIP_LINE.GetCellValue("REFER11_DATA_TYPE"));
            mLookup_Type = iString.ISNull(igrSLIP_LINE.GetCellValue("REFER11_LOOKUP_TYPE"));
            if (mData_Type == "NUMBER".ToString())
            {
            }
            else if (mData_Type == "RATE".ToString())
            {
            }
            else if (mData_Type == "DATE".ToString())
            {
                if (iString.ISNull(REFER11.EditValue) == string.Empty && iString.ISNull(SLIP_DATE.EditValue) != string.Empty)
                {
                    REFER11.EditValue = Convert.ToDateTime(SLIP_DATE.EditValue).ToShortDateString();
                }
            }
            if (mPreviousRowPosition > -1
                && mLookup_Type != string.Empty
                && mLookup_Type == iString.ISNull(idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER11_LOOKUP_TYPE"]))
            {//REFER11_LOOKUP_TYPE
                mPrevious_Code = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER11"];
                mPrevious_Name = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER11_DESC"];

                REFER11.EditValue = mPrevious_Code;
                REFER11_DESC.EditValue = mPrevious_Name;
            }
            //14
            mData_Type = iString.ISNull(igrSLIP_LINE.GetCellValue("REFER12_DATA_TYPE"));
            mLookup_Type = iString.ISNull(igrSLIP_LINE.GetCellValue("REFER12_LOOKUP_TYPE"));
            if (mData_Type == "NUMBER".ToString())
            {
            }
            else if (mData_Type == "RATE".ToString())
            {
            }
            else if (mData_Type == "DATE".ToString())
            {
                if (iString.ISNull(REFER12.EditValue) == string.Empty && iString.ISNull(SLIP_DATE.EditValue) != string.Empty)
                {
                    REFER12.EditValue = Convert.ToDateTime(SLIP_DATE.EditValue).ToShortDateString();
                }
            }
            if (mPreviousRowPosition > -1
                && mLookup_Type != string.Empty
                && mLookup_Type == iString.ISNull(idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER12_LOOKUP_TYPE"]))
            {//REFER12_LOOKUP_TYPE
                mPrevious_Code = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER12"];
                mPrevious_Name = idaSLIP_LINE.CurrentRows[mPreviousRowPosition]["REFER12_DESC"];

                REFER12.EditValue = mPrevious_Code;
                REFER12_DESC.EditValue = mPrevious_Name;
            }
        }

        private void Init_Currency_Code()
        {
            CURRENCY_DESC.ReadOnly = false;
            CURRENCY_DESC.Insertable = true;
            CURRENCY_DESC.Updatable = true;
            CURRENCY_DESC.TabStop = true;
        }

        private void Init_Currency_Amount()
        {
            if (iString.ISNull(CURRENCY_CODE.EditValue) == string.Empty || CURRENCY_CODE.EditValue.ToString() == mCurrency_Code.ToString())
            {
                if (iString.ISDecimaltoZero(EXCHANGE_RATE.EditValue) != Convert.ToDecimal(0))
                {
                    EXCHANGE_RATE.EditValue = 0;
                }
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

        //관리항목 LOOKUP 선택시 처리.
        private void Init_SELECT_LOOKUP(object pManagement_Type)
        {
            string mMANAGEMENT = iString.ISNull(pManagement_Type);
            if (mMANAGEMENT == "REFER1")
            {
                if (mAP_VAT_ACCOUNT_CODE == iString.ISNull(ACCOUNT_CODE.EditValue))
                {
                    Init_Tax_Type();
                }
            }
        }

        // 부가세 관련 설정 제어 - 세액/공급가액(세액 * 10)
        private void Init_VAT_Amount()
        {
            if (iString.ISNull(ACCOUNT_CODE.EditValue) != mAP_VAT_ACCOUNT_CODE)
            {
                return;
            }
            Decimal mGL_AMOUNT = iString.ISDecimaltoZero(GL_AMOUNT.EditValue);

            REFER8.EditValue = mGL_AMOUNT;      //세액 설정.
            if (iString.ISNull(REFER5.EditValue) == string.Empty)
            {
                REFER5.EditValue = mGL_AMOUNT * 10; //공급가액 설정.
            }
        }

        // 부가세 관련 : 전자세금계산서 여부 
        private void Init_Tax_Type()
        {
            string mTAX_TYPE = iString.ISNull(REFER1.EditValue);
            if (mTAX_TYPE == "1" || mTAX_TYPE == "2" || mTAX_TYPE == "3" || mTAX_TYPE == "5" || mTAX_TYPE == "8" || mTAX_TYPE == "9")
            {
                REFER6.EditValue = "Y";
            }
            else
            {
                REFER6.EditValue = "N";
            }
            idcCODE_NAME.SetCommandParamValue("W_GROUP_CODE", "TAX_ELECTRO");
            idcCODE_NAME.SetCommandParamValue("W_CODE", REFER6.EditValue);
            idcCODE_NAME.ExecuteNonQuery();
            REFER6_DESC.EditValue = idcCODE_NAME.GetCommandParamValue("O_RETURN_VALUE");
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
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaSLIP_LINE.IsFocused)
                    {
                        idaSLIP_LINE.AddUnder();
                        InsertSlipLine();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (idaSLIP_HEADER_IF_LIST.IsFocused)
                    {
                        idaSLIP_HEADER_IF_LIST.Update();
                    }
                    else
                    {
                        ACCOUNT_CODE.Focus();
                        Init_DR_CR_Amount();
                        if (iString.ISDecimaltoZero(TOTAL_DR_AMOUNT.EditValue) != iString.ISDecimaltoZero(TOTAL_CR_AMOUNT.EditValue))
                        {// 차대금액 일치 여부 체크.
                            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10134"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                            return;
                        }
                        try
                        {
                            idaSLIP_HEADER.Update();
                        }
                        catch
                        {
                        }
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaSLIP_HEADER_IF_LIST.IsFocused)
                    {
                        idaSLIP_HEADER_IF_LIST.Cancel();
                    }
                    else if (idaSLIP_HEADER.IsFocused)
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
                    else if (idaSLIP_HEADER_IF_LIST.IsFocused)
                    {
                        idaSLIP_HEADER_IF_LIST.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaSLIP_HEADER_IF_LIST.IsFocused)
                    {
                        idaSLIP_HEADER_IF_LIST.Delete();
                    }
                    else if (idaSLIP_HEADER.IsFocused)
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
                    else if (idaSLIP_HEADER_IF_LIST.IsFocused)
                    {
                        idaSLIP_HEADER_IF_LIST.Delete();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {
                    XLPrinting1("PRINT");
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                    XLPrinting1("FILE");
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
            Init_Currency_Code();

            irbCONFIRM_NO.CheckedState = ISUtil.Enum.CheckedState.Checked;
            ibtSUB_FORM.Visible = false;
        }

        private void GL_CURRENCY_AMOUNT_CurrentEditValidating(object pSender, ISEditAdvValidatingEventArgs e)
        {
            Init_GL_Amount();
        }

        private void GL_AMOUNT_CurrentEditValidated(object pSender, ISEditAdvValidatedEventArgs e)
        {
            Init_DR_CR_Amount();
            Init_VAT_Amount();  //부가세대급금 설정.
        }

        private void igrSLIP_LIST_CellDoubleClick(object pSender)
        {
            if (igrSLIP_LIST.RowCount > 0)
            {
                if (iString.ISNull(igrSLIP_LIST.GetCellValue("HEADER_INTERFACE_ID")) != string.Empty)
                {
                    SLIP_QUERY_STATUS.EditValue = "QUERY";
                    itbSLIP.SelectedIndex = 1;
                    itbSLIP.SelectedTab.Focus();
                    idaSLIP_HEADER.SetSelectParamValue("W_HEADER_INTERFACE_ID", igrSLIP_LIST.GetCellValue("HEADER_INTERFACE_ID"));
                    try
                    {
                        idaSLIP_HEADER.Fill();
                    }
                    catch (Exception ex)
                    {
                        MessageBoxAdv.Show(ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }
                    idaSLIP_HEADER.OraSelectData.AcceptChanges();
                    idaSLIP_HEADER.Refillable = true;
                    idaSLIP_LINE.OraSelectData.AcceptChanges();
                    idaSLIP_LINE.Refillable = true;
                }
            }
        }

        private void CURRENCY_DESC_CurrentEditValidating(object pSender, ISEditAdvValidatingEventArgs e)
        {
            Init_Currency_Amount();
        }

        private void EXCHANGE_RATE_CurrentEditValidating(object pSender, ISEditAdvValidatingEventArgs e)
        {
            Init_GL_Amount();
        }

        private void igrSLIP_LIST_CurrentCellChanged(object pSender, ISGridAdvExChangedEventArgs e)
        {
            if (e.ColIndex == igrSLIP_LIST.GetColumnToIndex("SELECT_CHECK_YN"))
            {
                string vCONFIRM_YN = iString.ISNull(igrSLIP_LIST.GetCellValue("CONFIRM_YN"));
                if (vCONFIRM_YN == "N" && iString.ISNull(e.NewValue, "N") == "Y".ToString())
                {
                    igrSLIP_LIST.SetCellValue("GL_DATE", igrSLIP_LIST.GetCellValue("SLIP_DATE"));
                }
                else if (vCONFIRM_YN == "N")
                {
                    igrSLIP_LIST.SetCellValue("GL_DATE", null);
                }
            }
        }

        private void btnCONFIRM_YES_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            Init_DR_CR_Amount();
            if (iString.ISDecimaltoZero(TOTAL_DR_AMOUNT.EditValue) != iString.ISDecimaltoZero(TOTAL_CR_AMOUNT.EditValue))
            {// 차대금액 일치 여부 체크.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10134"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            if (iString.ISNull(C_GL_DATE.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10187"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                C_GL_DATE.Focus();
                return;
            }            
            idaSLIP_HEADER.Update();

            C_CONFIRM_YN.CheckBoxValue = "Y";
            idaCONFIRM_STATUS.Update();
        }

        private void btnCONFIRM_CANCEL_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            C_GL_DATE.EditValue = null;
            C_CONFIRM_USER_NAME.EditValue = null;
            C_GL_NUM.EditValue = null;
            C_CONFIRM_YN.CheckBoxValue = "N";
            idaCONFIRM_STATUS.Update();
        }

        private void btnSELECT_ALL_0_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            for (int i = 0; i < igrSLIP_LIST.RowCount; i++)
            {
                if (iString.ISNull(igrSLIP_LIST.GetCellValue(i, igrSLIP_LIST.GetColumnToIndex("SELECT_CHECK_YN")), "N") == "Y".ToString())
                {
                    igrSLIP_LIST.SetCellValue(i, igrSLIP_LIST.GetColumnToIndex("SELECT_CHECK_YN"), "N");
                    igrSLIP_LIST.SetCellValue(i, igrSLIP_LIST.GetColumnToIndex("GL_DATE"), null);
                }
                else
                {
                    igrSLIP_LIST.SetCellValue(i, igrSLIP_LIST.GetColumnToIndex("SELECT_CHECK_YN"), "Y");
                    igrSLIP_LIST.SetCellValue(i, igrSLIP_LIST.GetColumnToIndex("GL_DATE"), igrSLIP_LIST.GetCellValue(i, igrSLIP_LIST.GetColumnToIndex("SLIP_DATE")));
                }
            }
        }

        private void btnCONFIRM_YES_0_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            for (int i = 0; i < igrSLIP_LIST.RowCount; i++)
            {
                if (iString.ISNull(igrSLIP_LIST.GetCellValue(i, igrSLIP_LIST.GetColumnToIndex("SELECT_CHECK_YN")), "N") == "Y".ToString())
                {
                    if (iString.ISNull(igrSLIP_LIST.GetCellValue(i, igrSLIP_LIST.GetColumnToIndex("GL_DATE"))) == string.Empty)
                    {
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10187"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        igrSLIP_LIST.CurrentCellMoveTo(i, igrSLIP_LIST.GetColumnToIndex("GL_DATE"));
                        igrSLIP_LIST.Focus();
                        return;
                    }
                    igrSLIP_LIST.SetCellValue(i, igrSLIP_LIST.GetColumnToIndex("CONFIRM_YN"), "Y");
                }
            }
            idaSLIP_HEADER_IF_LIST.Update();
        }

        private void btnCONFIRM_CANCEL_0_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            for (int i = 0; i < igrSLIP_LIST.RowCount; i++)
            {
                if (iString.ISNull(igrSLIP_LIST.GetCellValue(i, igrSLIP_LIST.GetColumnToIndex("SELECT_CHECK_YN")), "N") == "Y".ToString()
                    && iString.ISNull(igrSLIP_LIST.GetCellValue(i, igrSLIP_LIST.GetColumnToIndex("CONFIRM_YN")), "N") == "Y".ToString())
                {
                    igrSLIP_LIST.SetCellValue(i, igrSLIP_LIST.GetColumnToIndex("CONFIRM_YN"), "N");
                }
            }
            idaSLIP_HEADER_IF_LIST.Update();
        }

        private void irbCONFIRM_Status_CheckChanged(object sender, EventArgs e)
        {
            ISRadioButtonAdv iStatus = sender as ISRadioButtonAdv;
            
            CONFIRM_STATUS_0.EditValue = iStatus.RadioCheckedString;
            Search_DB();
        }

        private void H_REMARK_CurrentEditValidated(object pSender, ISEditAdvValidatedEventArgs e)
        {
            if (iString.ISNull(REMARK.EditValue) == string.Empty)
            {
                REMARK.EditValue = H_REMARK.EditValue;
            }
        }

        #endregion

        #region ----- Lookup Event ----- 
        
        private void ilaSLIP_NUM_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildSLIP_NUM.SetLookupParamValue("W_SLIP_TYPE_CLASS", "DW");
        }

        private void ilaJOB_CODE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildJOB_CODE.SetLookupParamValue("W_ENABLED_YN", "N");
        }

        private void ilaSLIP_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter_W("SLIP_TYPE", " VALUE1 <> 'BL'", "Y");
        }

        private void ilaACCOUNT_CONTROL_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildACCOUNT_CONTROL.SetLookupParamValue("W_ENABLED_YN", "N");
        }

        private void ilaDEPT_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaSLIP_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter_W("SLIP_TYPE", " VALUE1 <> 'BL'", "Y");
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
            Init_Set_Item_Need(idaSLIP_LINE.CurrentRow["ACCOUNT_DR_CR"]);
            Init_DR_CR_Amount();
        }

        private void ilaACCOUNT_CONTROL_SelectedRowData(object pSender)
        {
            Set_Control_Item_Prompt();
            Init_Control_Management_Value();
            Init_Set_Item_Need(idaSLIP_LINE.CurrentRow["ACCOUNT_DR_CR"]);
            Init_Set_Item_Prompt(idaSLIP_LINE.CurrentRow);
            Init_Currency_Code();
            Init_Default_Value();
            Init_DR_CR_Amount();           
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
            SetManagementParameter("REFER1_ID", "Y", igrSLIP_LINE.GetCellValue("MANAGEMENT1_LOOKUP_TYPE"));
        }

        private void ilaMANAGEMENT2_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetManagementParameter("REFER2_ID", "Y", igrSLIP_LINE.GetCellValue("MANAGEMENT2_LOOKUP_TYPE"));
        }

        private void ilaREFER1_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetManagementParameter("REFER3_ID", "Y", igrSLIP_LINE.GetCellValue("REFER1_LOOKUP_TYPE"));
        }

        private void ilaREFER2_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetManagementParameter("REFER4_ID", "Y", igrSLIP_LINE.GetCellValue("REFER2_LOOKUP_TYPE"));
        }

        private void ilaREFER3_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetManagementParameter("REFER5_ID", "Y", igrSLIP_LINE.GetCellValue("REFER3_LOOKUP_TYPE"));
        }

        private void ilaREFER4_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetManagementParameter("REFER6_ID", "Y", igrSLIP_LINE.GetCellValue("REFER4_LOOKUP_TYPE"));
        }

        private void ilaREFER5_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetManagementParameter("REFER7_ID", "Y", igrSLIP_LINE.GetCellValue("REFER5_LOOKUP_TYPE"));
        }

        private void ilaREFER6_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetManagementParameter("REFER8_ID", "Y", igrSLIP_LINE.GetCellValue("REFER6_LOOKUP_TYPE"));
        }

        private void ilaREFER7_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetManagementParameter("REFER9_ID", "Y", igrSLIP_LINE.GetCellValue("REFER7_LOOKUP_TYPE"));
        }

        private void ilaREFER8_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetManagementParameter("REFER10_ID", "Y", igrSLIP_LINE.GetCellValue("REFER8_LOOKUP_TYPE"));
        }

        private void ilaREFER9_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetManagementParameter("REFER11_ID", "Y", igrSLIP_LINE.GetCellValue("REFER9_LOOKUP_TYPE"));
        }

        private void ilaREFER10_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetManagementParameter("REFER12_ID", "Y", igrSLIP_LINE.GetCellValue("REFER10_LOOKUP_TYPE"));
        }

        private void ilaREFER11_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetManagementParameter("REFER13_ID", "Y", igrSLIP_LINE.GetCellValue("REFER11_LOOKUP_TYPE"));
        }

        private void ilaREFER12_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetManagementParameter("REFER14_ID", "Y", igrSLIP_LINE.GetCellValue("REFER12_LOOKUP_TYPE"));
        }

        private void ilaMANAGEMENT1_SelectedRowData(object pSender)
        {// 관리항목1 선택시 적용.
            Init_SELECT_LOOKUP("MANAGEMENT1");
        }

        private void ilaMANAGEMENT2_SelectedRowData(object pSender)
        {// 관리항목2 선택시 적용.
            Init_SELECT_LOOKUP("MANAGEMENT2");
        }

        private void ilaREFER1_SelectedRowData(object pSender)
        {// 관리항목3 선택시 적용.
            Init_SELECT_LOOKUP("REFER1");
        }

        private void ilaREFER2_SelectedRowData(object pSender)
        {// 관리항목4 선택시 적용.
            Init_SELECT_LOOKUP("REFER2");
        }

        private void ilaREFER3_SelectedRowData(object pSender)
        {// 관리항목5 선택시 적용.
            Init_SELECT_LOOKUP("REFER3");
        }

        private void ilaREFER4_SelectedRowData(object pSender)
        {// 관리항목6 선택시 적용.
            Init_SELECT_LOOKUP("REFER4");
        }

        private void ilaREFER5_SelectedRowData(object pSender)
        {// 관리항목7 선택시 적용.
            Init_SELECT_LOOKUP("REFER5");
        }

        private void ilaREFER6_SelectedRowData(object pSender)
        {// 관리항목8 선택시 적용.
            Init_SELECT_LOOKUP("REFER6");
        }

        private void ilaREFER7_SelectedRowData(object pSender)
        {// 관리항목9 선택시 적용.
            Init_SELECT_LOOKUP("REFER7");
        }

        private void ilaREFER8_SelectedRowData(object pSender)
        {// 관리항목10 선택시 적용.
            Init_SELECT_LOOKUP("REFER8");
        }

        private void ilaREFER9_SelectedRowData(object pSender)
        {// 관리항목11 선택시 적용.
            Init_SELECT_LOOKUP("REFER9");
        }

        private void ilaREFER10_SelectedRowData(object pSender)
        {// 관리항목12 선택시 적용.
            Init_SELECT_LOOKUP("REFER10");
        }

        private void ilaREFER11_SelectedRowData(object pSender)
        {// 관리항목13 선택시 적용.
            Init_SELECT_LOOKUP("REFER11");

        }

        private void ilaREFER12_SelectedRowData(object pSender)
        {// 관리항목14 선택시 적용.
            Init_SELECT_LOOKUP("REFER12");
        }

        private void ILA_VOUCH_CODE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ILD_VOUCH_CODE.SetLookupParamValue("W_ENABLED_YN", "Y");
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
            //if (iString.ISNull(e.Row["VOUCH_CODE"]) == string.Empty)
            //{// 증빙코드
            //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10129"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    e.Cancel = true;
            //    return;
            //}
        }

        private void idaSLIP_HEADER_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                if (e.Row["CONFIRM_YN"].ToString() == "Y".ToString())
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
            if (iString.ISNull(e.Row["MANAGEMENT1"]) == string.Empty &&
                (iString.ISNull(e.Row["ACCOUNT_DR_CR"]) == "1" && iString.ISNull(e.Row["MANAGEMENT1_DR_YN"], "N") == "Y".ToString() ||
                iString.ISNull(e.Row["ACCOUNT_DR_CR"]) == "2" && iString.ISNull(e.Row["MANAGEMENT1_CR_YN"], "N") == "Y".ToString()))
            {// 관리항목1 필수 입력 체크
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", string.Format("{0}{1}", "&&FIELD_NAME:=", e.Row["MANAGEMENT1_NAME"])), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["MANAGEMENT2"]) == string.Empty &&
                (iString.ISNull(e.Row["ACCOUNT_DR_CR"]) == "1" && iString.ISNull(e.Row["MANAGEMENT2_DR_YN"], "N") == "Y".ToString() ||
                iString.ISNull(e.Row["ACCOUNT_DR_CR"]) == "2" && iString.ISNull(e.Row["MANAGEMENT2_CR_YN"], "N") == "Y".ToString()))
            {// 관리항목2 필수 입력 체크
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", string.Format("{0}{1}", "&&FIELD_NAME:=", e.Row["MANAGEMENT2_NAME"])), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["REFER1"]) == string.Empty &&
                (iString.ISNull(e.Row["ACCOUNT_DR_CR"]) == "1" && iString.ISNull(e.Row["REFER1_DR_YN"], "N") == "Y".ToString() ||
                iString.ISNull(e.Row["ACCOUNT_DR_CR"]) == "2" && iString.ISNull(e.Row["REFER1_CR_YN"], "N") == "Y".ToString()))
            {// 참고항목1 필수 입력 체크
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", string.Format("{0}{1}", "&&FIELD_NAME:=", e.Row["REFER1_NAME"])), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["REFER2"]) == string.Empty &&
                (iString.ISNull(e.Row["ACCOUNT_DR_CR"]) == "1" && iString.ISNull(e.Row["REFER2_DR_YN"], "N") == "Y".ToString() ||
                iString.ISNull(e.Row["ACCOUNT_DR_CR"]) == "2" && iString.ISNull(e.Row["REFER2_CR_YN"], "N") == "Y".ToString()))
            {// 참고항목2 필수 입력 체크
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", string.Format("{0}{1}", "&&FIELD_NAME:=", e.Row["REFER2_NAME"])), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["REFER3"]) == string.Empty &&
                (iString.ISNull(e.Row["ACCOUNT_DR_CR"]) == "1" && iString.ISNull(e.Row["REFER3_DR_YN"], "N") == "Y".ToString() ||
                iString.ISNull(e.Row["ACCOUNT_DR_CR"]) == "2" && iString.ISNull(e.Row["REFER3_CR_YN"], "N") == "Y".ToString()))
            {// 참고항목3 필수 입력 체크
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", string.Format("{0}{1}", "&&FIELD_NAME:=", e.Row["REFER3_NAME"])), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["REFER4"]) == string.Empty &&
                (iString.ISNull(e.Row["ACCOUNT_DR_CR"]) == "1" && iString.ISNull(e.Row["REFER4_DR_YN"], "N") == "Y".ToString() ||
                iString.ISNull(e.Row["ACCOUNT_DR_CR"]) == "2" && iString.ISNull(e.Row["REFER4_CR_YN"], "N") == "Y".ToString()))
            {// 참고항목4 필수 입력 체크
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", string.Format("{0}{1}", "&&FIELD_NAME:=", e.Row["REFER4_NAME"])), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["REFER5"]) == string.Empty &&
                (iString.ISNull(e.Row["ACCOUNT_DR_CR"]) == "1" && iString.ISNull(e.Row["REFER5_DR_YN"], "N") == "Y".ToString() ||
                iString.ISNull(e.Row["ACCOUNT_DR_CR"]) == "2" && iString.ISNull(e.Row["REFER5_CR_YN"], "N") == "Y".ToString()))
            {// 참고항목5 필수 입력 체크
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", string.Format("{0}{1}", "&&FIELD_NAME:=", e.Row["REFER5_NAME"])), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["REFER6"]) == string.Empty &&
                (iString.ISNull(e.Row["ACCOUNT_DR_CR"]) == "1" && iString.ISNull(e.Row["REFER6_DR_YN"], "N") == "Y".ToString() ||
                iString.ISNull(e.Row["ACCOUNT_DR_CR"]) == "2" && iString.ISNull(e.Row["REFER6_CR_YN"], "N") == "Y".ToString()))
            {// 참고항목6 필수 입력 체크
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", string.Format("{0}{1}", "&&FIELD_NAME:=", e.Row["REFER6_NAME"])), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["REFER7"]) == string.Empty &&
                (iString.ISNull(e.Row["ACCOUNT_DR_CR"]) == "1" && iString.ISNull(e.Row["REFER7_DR_YN"], "N") == "Y".ToString() ||
                iString.ISNull(e.Row["ACCOUNT_DR_CR"]) == "2" && iString.ISNull(e.Row["REFER7_CR_YN"], "N") == "Y".ToString()))
            {// 참고항목7 필수 입력 체크
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", string.Format("{0}{1}", "&&FIELD_NAME:=", e.Row["REFER7_NAME"])), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["REFER8"]) == string.Empty &&
                (iString.ISNull(e.Row["ACCOUNT_DR_CR"]) == "1" && iString.ISNull(e.Row["REFER8_DR_YN"], "N") == "Y".ToString() ||
                iString.ISNull(e.Row["ACCOUNT_DR_CR"]) == "2" && iString.ISNull(e.Row["REFER8_CR_YN"], "N") == "Y".ToString()))
            {// 참고항목8 필수 입력 체크
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", string.Format("{0}{1}", "&&FIELD_NAME:=", e.Row["REFER8_NAME"])), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["REFER9"]) == string.Empty &&
                (iString.ISNull(e.Row["ACCOUNT_DR_CR"]) == "1" && iString.ISNull(e.Row["REFER9_DR_YN"], "N") == "Y".ToString() ||
                iString.ISNull(e.Row["ACCOUNT_DR_CR"]) == "2" && iString.ISNull(e.Row["REFER9_CR_YN"], "N") == "Y".ToString()))
            {// 참고항목9 필수 입력 체크
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", string.Format("{0}{1}", "&&FIELD_NAME:=", e.Row["REFER9_NAME"])), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["REFER10"]) == string.Empty &&
                (iString.ISNull(e.Row["ACCOUNT_DR_CR"]) == "1" && iString.ISNull(e.Row["REFER10_DR_YN"], "N") == "Y".ToString() ||
                iString.ISNull(e.Row["ACCOUNT_DR_CR"]) == "2" && iString.ISNull(e.Row["REFER10_CR_YN"], "N") == "Y".ToString()))
            {// 참고항목10 필수 입력 체크
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", string.Format("{0}{1}", "&&FIELD_NAME:=", e.Row["REFER10_NAME"])), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["REFER11"]) == string.Empty &&
                (iString.ISNull(e.Row["ACCOUNT_DR_CR"]) == "1" && iString.ISNull(e.Row["REFER11_DR_YN"], "N") == "Y".ToString() ||
                iString.ISNull(e.Row["ACCOUNT_DR_CR"]) == "2" && iString.ISNull(e.Row["REFER11_CR_YN"], "N") == "Y".ToString()))
            {// 참고항목11 필수 입력 체크
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", string.Format("{0}{1}", "&&FIELD_NAME:=", e.Row["REFER11_NAME"])), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["REFER12"]) == string.Empty &&
                (iString.ISNull(e.Row["ACCOUNT_DR_CR"]) == "1" && iString.ISNull(e.Row["REFER12_DR_YN"], "N") == "Y".ToString() ||
                iString.ISNull(e.Row["ACCOUNT_DR_CR"]) == "2" && iString.ISNull(e.Row["REFER12_CR_YN"], "N") == "Y".ToString()))
            {// 참고항목12 필수 입력 체크
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", string.Format("{0}{1}", "&&FIELD_NAME:=", e.Row["REFER12_NAME"])), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            //부가세 추가 제어 부분//
            if (iString.ISNull(e.Row["ACCOUNT_CODE"]) == mAP_VAT_ACCOUNT_CODE)
            {
                if (iString.ISNull(e.Row["REFER1"]) == "3")
                {//세무유형 : 매입세액불공제 -> 공급가액, 세액 필수, 0보다 커야함.
                    //공급가액
                    if (iString.ISNull(e.Row["REFER5"]) == string.Empty)
                    {
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", string.Format("{0}{1}", "&&FIELD_NAME:=", e.Row["REFER5_NAME"])), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        e.Cancel = true;
                        return;
                    }
                    if (iString.ISNull(e.Row["REFER5_DATA_TYPE"]) == "NUMBER" || iString.ISNull(e.Row["REFER5_DATA_TYPE"]) == "RATE")
                    {
                        if (iString.ISDecimaltoZero(e.Row["REFER5"]) == 0)
                        {
                            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10023", string.Format("{0}{1}", "&&FIELD_NAME:=", e.Row["REFER5_NAME"])), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                            e.Cancel = true;
                            return;
                        }
                    }
                    //세액
                    if (iString.ISNull(e.Row["REFER8"]) == string.Empty)
                    {
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", string.Format("{0}{1}", "&&FIELD_NAME:=", e.Row["REFER8_NAME"])), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        e.Cancel = true;
                        return;
                    }
                    if (iString.ISNull(e.Row["REFER8_DATA_TYPE"]) == "NUMBER" || iString.ISNull(e.Row["REFER8_DATA_TYPE"]) == "RATE")
                    {
                        if (iString.ISDecimaltoZero(e.Row["REFER8"]) == 0)
                        {
                            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10023", string.Format("{0}{1}", "&&FIELD_NAME:=", e.Row["REFER8_NAME"])), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                            e.Cancel = true;
                            return;
                        }
                    }
                }
                else if (iString.ISNull(e.Row["REFER1"]) == "4")
                {//세무유형 : 면세매입 -> 세액은 0
                    //세액
                    if (iString.ISNull(e.Row["REFER8_DATA_TYPE"]) == "NUMBER" || iString.ISNull(e.Row["REFER8_DATA_TYPE"]) == "RATE")
                    {
                        if (iString.ISDecimaltoZero(e.Row["REFER8"]) != 0)
                        {
                            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10269", string.Format("{0}{1}", "&&FIELD_NAME:=", e.Row["REFER8_NAME"])), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                            e.Cancel = true;
                            return;
                        }
                    }
                }
                else if (iString.ISNull(e.Row["REFER1"]) == "6" || iString.ISNull(e.Row["REFER1"]) == "10")
                {//세무유형 : 카드매입, 카드기타 -> 카드번호 필수.
                    if (iString.ISNull(e.Row["REFER4"]) == string.Empty)
                    {
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", string.Format("{0}{1}", "&&FIELD_NAME:=", e.Row["REFER4_NAME"])), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        e.Cancel = true;
                        return;
                    }
                }
                else if (iString.ISNull(e.Row["REFER1"]) == "7")
                {//세무유형 : 현금영수증 -> 현금영수증 승인번호 필수
                    if (iString.ISNull(e.Row["REFER7"]) == string.Empty)
                    {
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", string.Format("{0}{1}", "&&FIELD_NAME:=", e.Row["REFER7_NAME"])), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        e.Cancel = true;
                        return;
                    }
                }
            }
        }

        private void idaSLIP_LINE_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                if (e.Row["CONFIRM_YN"].ToString() == "Y".ToString())
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

        private void idaSLIP_HEADER_FillCompleted(object pSender, DataView pOraDataView, ISBindingEventArgs pBindingManager)
        {
            
        }

        private void idaCONFIRM_STATUS_UpdateCompleted(object pSender)
        {
            string vGL_NUM = iString.ISNull(GL_NUM.EditValue); // igrSLIP_LIST.GetCellValue("GL_NUM"));
            int vIDX_GL_NUM = igrSLIP_LIST.GetColumnToIndex("GL_NUM");
            Search_DB();

            // 기존 위치 이동 : 없을 경우.
            for (int r = 0; r < igrSLIP_LIST.RowCount; r++)
            {
                if (vGL_NUM == iString.ISNull(igrSLIP_LIST.GetCellValue(r, vIDX_GL_NUM)))
                {
                    igrSLIP_LIST.CurrentCellMoveTo(r, vIDX_GL_NUM);
                    igrSLIP_LIST.CurrentCellActivate(r, vIDX_GL_NUM);
                }
            }
            SLIP_DATE.Focus();
        }

        private void idaSLIP_HEADER_IF_LIST_UpdateCompleted(object pSender)
        {
            string vGL_NUM = iString.ISNull(SLIP_NUM.EditValue); // igrSLIP_LIST.GetCellValue("GL_NUM"));
            int vIDX_GL_NUM = igrSLIP_LIST.GetColumnToIndex("SLIP_NUM");
            Search_DB();

            // 기존 위치 이동 : 없을 경우.
            for (int r = 0; r < igrSLIP_LIST.RowCount; r++)
            {
                if (vGL_NUM == iString.ISNull(igrSLIP_LIST.GetCellValue(r, vIDX_GL_NUM)))
                {
                    igrSLIP_LIST.CurrentCellMoveTo(r, vIDX_GL_NUM);
                    igrSLIP_LIST.CurrentCellActivate(r, vIDX_GL_NUM);
                }
            }
            SLIP_DATE.Focus();
        }

        private void idaSLIP_LINE_NewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            if (pBindingManager.DataRow == null)
            {
                return;
            }
            Init_Currency_Code();
            Init_Currency_Amount();
            if (SLIP_QUERY_STATUS.EditValue.ToString() != "QUERY".ToString())
            {
                Init_DR_CR_Amount();
            }
            Init_Total_GL_Amount();
        }

        private void idaSLIP_LINE_PreNewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            if (pBindingManager.DataRow == null)
            {
                return;
            }
            Init_Set_Item_Need(pBindingManager.DataRow["ACCOUNT_DR_CR"]);            // 필수여부 동기화 //
            Init_Set_Item_Prompt(pBindingManager.DataRow);
        }
        #endregion

    }
}