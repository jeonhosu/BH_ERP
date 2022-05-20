using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

using Syncfusion.Windows.Forms;
using Syncfusion.Windows.Forms.Tools;
using Syncfusion.Windows.Forms.Grid;
using InfoSummit.Win.ControlAdv;
using ISCommonUtil;

namespace FCMF0871
{
    public partial class FCMF0871 : Office2007Form
    {
        #region ----- Variables -----

        private ISFunction.ISConvert iString = new ISFunction.ISConvert();
        private ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public FCMF0871(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void SearchDB()
        {
            if (iString.ISNull(W_TAX_DESC.EditValue) == string.Empty)
            {
                //사업장은 필수입니다
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10007"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                W_TAX_DESC.Focus();
                return;
            }

            idaVAT_REPORT_MNG.Fill();
            igrVAT_REPORT_MNG.Focus();
        }

        private void SetCommonParameter(object pGroup_Code, object pEnabled_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        }

        private void Default_CLOSING_YN()
        {
            igrVAT_REPORT_MNG.SetCellValue("CLOSING_YN", "N");
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
                    if (idaVAT_REPORT_MNG.IsFocused == true)
                    {
                        idaVAT_REPORT_MNG.AddOver();
                        Default_CLOSING_YN();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaVAT_REPORT_MNG.IsFocused == true)
                    {
                        idaVAT_REPORT_MNG.AddUnder();
                        Default_CLOSING_YN();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (idaVAT_REPORT_MNG.IsFocused == true)
                    {
                        idaVAT_REPORT_MNG.Update();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaVAT_REPORT_MNG.IsFocused == true)
                    {
                        idaVAT_REPORT_MNG.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaVAT_REPORT_MNG.IsFocused == true)
                    {
                        idaVAT_REPORT_MNG.Delete();
                    }
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void FCMF0871_Load(object sender, EventArgs e)
        {
            idaVAT_REPORT_MNG.FillSchema();

            W_PERIOD_YEAR.EditValue = iDate.ISYear(System.DateTime.Today);
        }
        
        private void FCMF0871_Shown(object sender, EventArgs e)
        {
            IDC_SET_TAX_CODE.ExecuteNonQuery();
            W_TAX_DESC.EditValue = IDC_SET_TAX_CODE.GetCommandParamValue("O_TAX_DESC");
            W_TAX_CODE.EditValue = IDC_SET_TAX_CODE.GetCommandParamValue("O_TAX_CODE");
        }

        
        #endregion

        #region ----- Lookup Event -----

        private void ilaVAT_REPORT_TURN_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("VAT_REPORT_TURN", "Y");
        }

        private void ilaVAT_REPORT_GB_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("VAT_REPORT_GB", "Y");
        }

        #endregion

    }
}