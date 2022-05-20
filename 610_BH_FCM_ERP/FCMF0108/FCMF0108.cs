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

namespace FCMF0108
{
    public partial class FCMF0108 : Office2007Form
    {
        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #region ----- Variables -----



        #endregion;

        #region ----- Constructor -----

        public FCMF0108()
        {
            InitializeComponent();
        }

        public FCMF0108(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void Search_DB()
        {
            idaACCOUNT_BOOK.Fill();
            ACCOUNT_BOOK_NAME.Focus();
        }

        private void Insert_Account_Book()
        {
            ACCOUNT_BOOK_CODE.Focus();
        }

        #endregion;

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
                    if (idaACCOUNT_BOOK.IsFocused)
                    {
                        idaACCOUNT_BOOK.AddOver();
                        Insert_Account_Book();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaACCOUNT_BOOK.IsFocused)
                    {
                        idaACCOUNT_BOOK.AddUnder();
                        Insert_Account_Book();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (idaACCOUNT_BOOK.IsFocused)
                    {
                        idaACCOUNT_BOOK.Update();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaACCOUNT_BOOK.IsFocused)
                    {
                        idaACCOUNT_BOOK.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaACCOUNT_BOOK.IsFocused)
                    {
                        idaACCOUNT_BOOK.Delete();
                    }
                }
            }
        }

        #endregion;

        #region ----- Form Event -----
        private void FCMF0108_Load(object sender, EventArgs e)
        {
            idaACCOUNT_BOOK.FillSchema();
        }
        #endregion

        #region ----- Adapter Event -----
        private void idaACCOUNT_BOOK_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["ACCOUNT_BOOK_CODE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Account Book Code(회계장부 코드)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["ACCOUNT_BOOK_NAME"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Account Book Name(회계장부명)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
                e.Cancel = true;
                return;
            }
            if (e.Row["ACCOUNT_SET_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Account Set Name(계정코드집)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
                e.Cancel = true;
                return;
            }
            if (e.Row["FISCAL_CALENDAR_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Fiscal Calendar Name(회계달력)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
                e.Cancel = true;
                return;
            }
            if (e.Row["FUTURE_OPEN_PERIOD_COUNT"] == DBNull.Value || Convert.ToInt32(e.Row["FUTURE_OPEN_PERIOD_COUNT"]) == 0)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Future Open Period Count(미래 입력 회계 월수)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["CURRENCY_CODE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Currency(통화)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["EXCHANGE_RATE_TYPE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Exchange Rate Type(환율구분)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["DEPT_LEVEL"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Department Level(부서관리 레벨)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
                e.Cancel = true;
                return;
            } 
        }

        private void idaACCOUNT_BOOK_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:=Data(데이터)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
                e.Cancel = true;
                return;
            }
        }
        #endregion

        #region ----- Lookup Event -----
        private void ilaEXCHANGE_RATE_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildEXCHANGE_RATE_TYPE.SetLookupParamValue("W_LOOKUP_MODULE", "EAPP");
            ildEXCHANGE_RATE_TYPE.SetLookupParamValue("W_LOOKUP_TYPE", "EXCHANGE_RATE_TYPE");
            ildEXCHANGE_RATE_TYPE.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaCURRENCY_CODE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCURRENCY_CODE.SetLookupParamValue("W_ENABLED_YN", "Y");
        }
        #endregion             

    }
}