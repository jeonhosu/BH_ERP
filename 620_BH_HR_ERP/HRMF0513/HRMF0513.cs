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


namespace HRMF0513
{
    public partial class HRMF0513 : Office2007Form
    {
        #region ----- Variables -----
        ISCommonUtil.ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISCommonUtil.ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();


        #endregion;

        #region ----- Constructor -----

        public HRMF0513()
        {
            InitializeComponent();
        }

        public HRMF0513(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----


        #endregion;

        #region ----- Events -----

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    if (iString.ISNull(isCORP0_ID.EditValue) == string.Empty)
                    {
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        isCORP0_NAME.Focus();
                        return;
                    }
                    if (iString.ISNull(isSTDDATE0.EditValue) == string.Empty)
                    {
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10015"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        isSTDDATE0.Focus();
                        return;
                    }
                    idaBANK_ACCOUNT.Fill();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    if (idaBANK_ACCOUNT.IsFocused)
                    {
                        idaBANK_ACCOUNT.AddOver();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaBANK_ACCOUNT.IsFocused)
                    {
                        idaBANK_ACCOUNT.AddUnder();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    idaBANK_ACCOUNT.Update();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaBANK_ACCOUNT.IsFocused)
                    {
                        idaBANK_ACCOUNT.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaBANK_ACCOUNT.IsFocused)
                    {
                        idaBANK_ACCOUNT.Delete();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {
                    if (idaBANK_ACCOUNT.IsFocused)
                    {
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                    if (idaBANK_ACCOUNT.IsFocused)
                    {
                    }
                }
            }
        }

        #endregion;

        private void ilaPAYTYPE0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildPAYTYPE.SetLookupParamValue("W_GROUP_CODE", "PAY_TYPE");
            ildPAYTYPE.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");

        }

        private void HRMF0513_Load(object sender, EventArgs e)
        {
            // Lookup SETTING
            ildCORP.SetLookupParamValue("W_PAY_CONTROL_YN", "Y");
            ildCORP.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");

            // LOOKUP DEFAULT VALUE SETTING - CORP
            idcDEFAULT_CORP.SetCommandParamValue("W_PAY_CONTROL_YN", "Y");
            idcDEFAULT_CORP.SetCommandParamValue("W_ENABLED_FLAG_YN", "N");
            idcDEFAULT_CORP.ExecuteNonQuery();
            isCORP0_NAME.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_NAME");
            isCORP0_ID.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_ID");

            // Standard Date SETTING   
            DateTime dToday = DateTime.Today;
            isSTDDATE0.EditValue = dToday.ToString("yyyy-MM", null);


            idaBANK_ACCOUNT.FillSchema();

      
        }

        private void ilaBANK0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildBANK.SetLookupParamValue("W_GROUP_CODE", "BANK");
            ildBANK.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }
            
    }
}