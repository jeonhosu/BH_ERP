using System;
using System.Data;
using System.Drawing;
using System.Windows.Forms;
using System.Collections.Generic;

using Syncfusion.Windows.Forms;
using Syncfusion.Windows.Forms.Tools;
using Syncfusion.Windows.Forms.Grid;
using InfoSummit.Win.ControlAdv;

namespace FCMF0211
{
    public partial class FCMF0211 : Office2007Form
    {
        #region ----- Variables -----



        #endregion;

        #region ----- Constructor -----

        public FCMF0211()
        {
            InitializeComponent();
        }

        public FCMF0211(Form pMainForm, ISAppInterface pAppInterface)
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
            idcDEFAULT_VALUE.SetCommandParamValue("W_GROUP_CODE", "BILL_STATUS");
            idcDEFAULT_VALUE.ExecuteNonQuery();
            BILL_STATUS_NAME.EditValue = idcDEFAULT_VALUE.GetCommandParamValue("O_CODE_NAME");
            BILL_STATUS.EditValue = idcDEFAULT_VALUE.GetCommandParamValue("O_CODE");

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
                    idaBILL_MASTER.Update();                    
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

        private void FCMF0211_Load(object sender, EventArgs e)
        {
            idaBILL_MASTER.FillSchema();
        }

        #endregion

        #region ----- Lookup Event -----

        private void ilaBILL_STATUS_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("BILL_STATUS", "N");
        }

        private void ilaBILL_STATUS_1_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("BILL_STATUS", "Y");
        }

        private void ilaBILL_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("BILL_TYPE", "N");
        }

        private void ilaBILL_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("BILL_TYPE", "Y");
        }

        private void ilaBILL_MODE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("BILL_MODE", "Y");
        }

        private void ilaSUPP_CUST_RefreshLookupData(object pSender, ISRefreshLookupDataEventArgs e)
        {
            ildSUPP_CUST.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaBANK_RefreshLookupData(object pSender, ISRefreshLookupDataEventArgs e)
        {
            ildBANK.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaRECEIPT_DEPT_RefreshLookupData(object pSender, ISRefreshLookupDataEventArgs e)
        {
            ildDEPT.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaKEEP_DEPT_RefreshLookupData(object pSender, ISRefreshLookupDataEventArgs e)
        {
            ildDEPT.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        #endregion

        // Adapter Event //
        private void idaBILL_MASTER_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {

        }
        
    }
}