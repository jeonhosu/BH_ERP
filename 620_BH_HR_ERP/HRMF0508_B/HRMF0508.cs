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

namespace HRMF0508
{
    public partial class HRMF0508 : Office2007Form
    {
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();
        ISFunction.ISConvert iString = new ISFunction.ISConvert();

        #region ----- Variables -----

        


        #endregion;

        #region ----- Constructor -----

        public HRMF0508()
        {
            InitializeComponent();
        }

        public HRMF0508(Form pMainForm, ISAppInterface pAppInterface)
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
                    idaWAGE_TRANSFER_INFO.Fill();
                    //if (idaWAGE_TRANSFER_INFO.IsFocused)
                    //{

                    //}
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    //if (idaWAGE_TRANSFER_INFO.IsFocused)
                    //{
                    //    idaWAGE_TRANSFER_INFO.AddOver();
                    //}
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    //if (idaWAGE_TRANSFER_INFO.IsFocused)
                    //{
                    //    idaWAGE_TRANSFER_INFO.AddUnder();
                    //}
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    //if (idaWAGE_TRANSFER_INFO.IsFocused)
                    //{
                    //    idaWAGE_TRANSFER_INFO.Update();
                    //}
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    //if (idaWAGE_TRANSFER_INFO.IsFocused)
                    //{
                    //    idaWAGE_TRANSFER_INFO.Cancel();
                    //}
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    //if (idaWAGE_TRANSFER_INFO.IsFocused)
                    //{
                    //    idaWAGE_TRANSFER_INFO.Delete();
                    //}
                }
            }
        }

        #endregion;

        private void HRMF0508_Load(object sender, EventArgs e)
        {
            PAY_YYYYMM_0.EditValue = iDate.ISYearMonth(DateTime.Today); //년월
            START_DATE_0.EditValue = iDate.ISMonth_1st(DateTime.Today); 
            END_DATE_0.EditValue = iDate.ISMonth_Last(DateTime.Today);

            ildCORP.SetLookupParamValue("W_PAY_CONTROL_YN", "Y");
            ildCORP.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");

            idcDV_CORP.SetCommandParamValue("W_PAY_CONTROL_YN", "Y");
            idcDV_CORP.SetCommandParamValue("W_ENABLED_FLAG_YN", "N");
            idcDV_CORP.ExecuteNonQuery();
            CORP_NAME_0.EditValue = idcDV_CORP.GetCommandParamValue("O_CORP_NAME");
            CORP_ID_0.EditValue = idcDV_CORP.GetCommandParamValue("O_CORP_ID");
        }

        private void ilaYEAR_MONTH_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildYEAR_MONTH.SetLookupParamValue("W_START_YYYYMM", "2001-01");
            ildYEAR_MONTH.SetLookupParamValue("W_WORK_TERM_TYPE", "D2");
        }

        private void ilaDEPT_ID_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT.SetLookupParamValue("W_CORP_ID", CORP_ID_0.EditValue);
            ildDEPT.SetLookupParamValue("W_USABLE_CHECK_YN", "N");
        }

        private void ilaWAGE_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON_W.SetLookupParamValue("W_GROUP_CODE", "CLOSING_TYPE");
            ildCOMMON_W.SetLookupParamValue("W_WHERE", "VALUE1 = 'PAY' ");
            ildCOMMON_W.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        private void ilaPAY_GRADE_ID_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "PAY_GRADE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        private void ilaPERSON_NAME_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildPERSON.SetLookupParamValue("W_CORP_ID", CORP_ID_0.EditValue);
            ildPERSON.SetLookupParamValue("W_DEPT_ID", DEPT_ID_0.EditValue);
            ildPERSON.SetLookupParamValue("W_STD_DATE", END_DATE_0.EditValue);
        }

    }
}