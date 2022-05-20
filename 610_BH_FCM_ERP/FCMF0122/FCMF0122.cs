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

namespace FCMF0122
{
    public partial class FCMF0122 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();


        #endregion;

        #region ----- Constructor -----

        public FCMF0122(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void SearchDB()
        {
            //if (iString.ISNull(ACCOUNT_SET_NAME_0.EditValue) == string.Empty)
            //{
            //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10007"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    ACCOUNT_SET_NAME_0.Focus();
            //    return;
            //}

            //if (iString.ISNull(ISSUE_DATE_FR_0.EditValue) == string.Empty)
            //{
            //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    ISSUE_DATE_FR_0.Focus();
            //    return;
            //}
            //if (iString.ISNull(ISSUE_DATE_TO_0.EditValue) == string.Empty)
            //{
            //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    ISSUE_DATE_FR_0.Focus();
            //    return;
            //}
            //if (Convert.ToDateTime(ISSUE_DATE_FR_0.EditValue) > Convert.ToDateTime(ISSUE_DATE_TO_0.EditValue))
            //{
            //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10012"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    ISSUE_DATE_FR_0.Focus();
            //    return;
            //}

            idaLIST_COA.Fill();
            igrLIST_COA.Focus();
        }

        private void Show_Slip_Detail()
        {
            //try
            //{
            //    int mSLIP_HEADER_ID = iString.ISNumtoZero(igrVAT_AP_AR.GetCellValue("SLIP_HEADER_ID"));
            //    if (mSLIP_HEADER_ID != Convert.ToInt32(0))
            //    {
            //        Application.UseWaitCursor = true;
            //        this.Cursor = System.Windows.Forms.Cursors.WaitCursor;

            //        FCMF0205.FCMF0205 vFCMF0205 = new FCMF0205.FCMF0205(this.MdiParent, isAppInterfaceAdv1.AppInterface, mSLIP_HEADER_ID);
            //        vFCMF0205.Show();

            //        this.Cursor = System.Windows.Forms.Cursors.Default;
            //        Application.UseWaitCursor = false;
            //    }
            //}
            //catch
            //{
            //}
        }

        //private void SetCommonParameter(object pGroup_Code, object pEnabled_YN)
        //{
        //    ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
        //    ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        //}

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

                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {

                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {

                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {

                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {

                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void FCMF0122_Load(object sender, EventArgs e)
        {
            ACCOUNT_SET_ID_0.EditValue = 10;
            ACCOUNT_SET_NAME_0.EditValue = "계정코드집";
        }
        
        private void FCMF0122_Shown(object sender, EventArgs e)
        {
            //idcDV_TAX_CODE.SetCommandParamValue("W_GROUP_CODE", "TAX_CODE");
            //idcDV_TAX_CODE.ExecuteNonQuery();
            //ACCOUNT_SET_NAME_0.EditValue = idcDV_TAX_CODE.GetCommandParamValue("O_CODE_NAME");
            //ACCOUNT_SET_ID_0.EditValue = idcDV_TAX_CODE.GetCommandParamValue("O_CODE");
        }

        private void igrVAT_AP_AR_CellDoubleClick(object pSender)
        {
            Show_Slip_Detail();
        }
        
        #endregion

        #region ----- Lookup Event -----

        //private void ilaTAX_CODE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        //{
        //    SetCommonParameter("TAX_CODE", "Y");
        //}

        //private void ilaVAT_CLASS_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        //{
        //    SetCommonParameter("VAT_CLASS", "Y");
        //}

        //private void ilaSUPPLIER_NAME_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        //{
        //    ildSUPPLIER_NAME.SetLookupParamValue("W_ENABLED_YN", "Y");
        //}

        //private void ilaVAT_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        //{
        //    //거래구분 : 매입 1
        //    //거래구분 : 매출 2
        //    string vVatClassId = iString.ISNull(ENABLED_FLAG_CODE_0.EditValue);
        //    if (vVatClassId == "2".ToString())
        //    {
        //        SetCommonParameter("VAT_TYPE_AR", "Y");
        //    }
        //    else if (vVatClassId == "1".ToString())
        //    {
        //        SetCommonParameter("VAT_TYPE_AP", "Y");
        //    }
        //    else
        //    {
        //        SetCommonParameter("", "Y");
        //    }
        //}

        private void ilaACCOUNT_DR_CR_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildACCOUNT_DR_CR.SetLookupParamValue("W_GROUP_CODE", "ACCOUNT_DR_CR");
        }

        private void ilaACCOUNT_FS_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildACCOUNT_DR_CR.SetLookupParamValue("W_GROUP_CODE", "FORM_TYPE");
        }

        private void ilaACCOUNT_CLASS_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildACCOUNT_DR_CR.SetLookupParamValue("W_GROUP_CODE", "ACCOUNT_CLASS");
        }

        #endregion

        #region ----- Form Event -----


        #endregion
    }
}