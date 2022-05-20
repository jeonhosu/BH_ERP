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

namespace FCMF0515
{
    public partial class FCMF0515 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();
        ISFunction.ISConvert iString = new ISFunction.ISConvert();

        #endregion;

        #region ----- Constructor -----

        public FCMF0515()
        {
            InitializeComponent();
        }

        public FCMF0515(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void SearchDB()
        {
            idaBILL_MASTER.Fill();
            igrBILL_LIST.Focus();
        }

        private void SetCommonParameter(object pGroup_Code, object pEnabled_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        }

        private void Insert_Data()
        {
            // 어음상태.
            idcDV_COMMON.SetCommandParamValue("W_GROUP_CODE", "BILL_STATUS");
            idcDV_COMMON.ExecuteNonQuery();
            BILL_STATUS_NAME.EditValue = idcDV_COMMON.GetCommandParamValue("O_CODE_NAME");
            BILL_STATUS.EditValue = idcDV_COMMON.GetCommandParamValue("O_CODE");

            //자타구분.
            idcDV_COMMON.SetCommandParamValue("W_GROUP_CODE", "BILL_MODE");
            idcDV_COMMON.ExecuteNonQuery();
            BILL_MODE_NAME.EditValue = idcDV_COMMON.GetCommandParamValue("O_CODE_NAME");
            BILL_MODE.EditValue = idcDV_COMMON.GetCommandParamValue("O_CODE");


            //어음구분
            idcCOMMON_CODE_NAME.SetCommandParamValue("W_GROUP_CODE", "BILL_TYPE");
            idcCOMMON_CODE_NAME.SetCommandParamValue("W_CODE", BILL_TYPE_0.EditValue);
            idcCOMMON_CODE_NAME.ExecuteNonQuery();
            BILL_TYPE_NAME.EditValue = idcCOMMON_CODE_NAME.GetCommandParamValue("O_RETURN_VALUE");
            if (iString.ISNull(BILL_TYPE_NAME.EditValue) == string.Empty)
            {
                //DEFAULT VALUE 설정 : 어음구분.
                idcDV_COMMON.SetCommandParamValue("W_GROUP_CODE", "BILL_TYPE");
                idcDV_COMMON.ExecuteNonQuery();
                BILL_TYPE_NAME.EditValue = idcDV_COMMON.GetCommandParamValue("O_CODE_NAME");
                BILL_TYPE.EditValue = idcDV_COMMON.GetCommandParamValue("O_CODE");
            }

            VAT_ISSUE_DATE.EditValue = DateTime.Today;
            ISSUE_DATE.EditValue = DateTime.Today;
            DUE_DATE.EditValue = DateTime.Today;

            BILL_NUM.Focus();
        }

        #endregion;

        #region ----- Events -----

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    SearchDB();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    if (idaBILL_MASTER.IsFocused)
                    {
                        idaBILL_MASTER.AddOver();
                        Insert_Data();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaBILL_MASTER.IsFocused)
                    {
                        idaBILL_MASTER.AddUnder();
                        Insert_Data();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (idaBILL_MASTER.IsFocused)
                    {
                        idaBILL_MASTER.Update();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaBILL_MASTER.IsFocused)
                    {
                        idaBILL_MASTER.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    idaBILL_MASTER.Delete();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {
                    if (idaBILL_MASTER.IsFocused)
                    {
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                    if (idaBILL_MASTER.IsFocused)
                    {
                    }
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void FCMF0515_Load(object sender, EventArgs e)
        {
            idaBILL_MASTER.FillSchema();
        }

        #endregion

        #region ----- Lookup Event -----

        private void ilaBILL_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("BILL_TYPE", "N");
        }

        private void ilaBILL_NUM_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {

        }

        private void ilaVENDOR_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildVENDOR.SetLookupParamValue("W_ENABLED_YN", "N");
        }

        private void ilaBILL_STATUS_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("BILL_STATUS", "N");
        }
                
        private void ilaBILL_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("BILL_TYPE", "Y");
        }

        private void ilaBILL_STATUS_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("BILL_STATUS", "Y");
        }

        private void ilaVENDOR_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildVENDOR.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaBANK_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildBANK.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaBILL_MODE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("BILL_MODE", "Y");
        }

        private void ilaSUPP_CUST_RefreshLookupData(object pSender, ISRefreshLookupDataEventArgs e)
        {
            ildVENDOR.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaBANK_RefreshLookupData(object pSender, ISRefreshLookupDataEventArgs e)
        {
            ildBANK.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaRECEIPT_DEPT_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaKEEP_DEPT_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaRECEIPT_DEPT_RefreshLookupData(object pSender, ISRefreshLookupDataEventArgs e)
        {
            ildDEPT.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        #endregion

        #region ----- Adapter Event -----

        private void idaBILL_MASTER_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["BILL_NUM"]) == string.Empty)
            {// 어음번호
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10142"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                BILL_NUM.Focus();
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["BILL_TYPE"]) == string.Empty)
            {// 어음종류
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10143"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                BILL_TYPE_NAME.Focus();
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["VENDOR_ID"]) == string.Empty)
            {// 고객정보
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10135"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                VENDOR_NAME.Focus();
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["ISSUE_DATE"]) == string.Empty)
            {// 발행일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10144"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                ISSUE_DATE.Focus();
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["DUE_DATE"]) == string.Empty)
            {// 만기일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10145"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                ISSUE_DATE.Focus();
                e.Cancel = true;
                return;
            }
            if (iString.ISNumtoZero(e.Row["BILL_AMOUNT"]) == 0)
            {// 어음금액
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10146"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                BILL_AMOUNT.Focus();
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["BILL_MODE"]) == string.Empty)
            {// 자타구분
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10353"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                BILL_MODE_NAME.Focus();
                e.Cancel = true;
                return;
            }
        }

        #endregion

    }
}