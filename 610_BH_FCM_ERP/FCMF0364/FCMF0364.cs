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

namespace FCMF0364
{
    public partial class FCMF0364 : Office2007Form
    {
        #region ----- Variables -----

        private ISFunction.ISConvert iString = new ISFunction.ISConvert();
        private ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public FCMF0364(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void SearchDB()
        {
            object vObject2 = PERIOD_FROM.EditValue;
            object vObject3 = PERIOD_TO.EditValue;
            if (iString.ISNull(vObject2) == string.Empty || iString.ISNull(vObject3) == string.Empty)
            {
                //상각기간은 필수입니다.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10412"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            idcCREATE_DPR_EXPENSE.ExecuteNonQuery();

            idaLIST_DPR_EXPENSE_SUM.Fill();
            idaLIST_DPR_EXPENSE_DET.Fill();
            igrLIST_DPR_EXPENSE_SUM.Focus();
        }

        private void SetCommonParameter(object pGroup_Code, object pEnabled_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
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

                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {

                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {

                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaLIST_DPR_EXPENSE_SUM.IsFocused == true)
                    {
                        idaLIST_DPR_EXPENSE_SUM.Cancel();
                    }
                    else if (idaLIST_DPR_EXPENSE_DET.IsFocused == true)
                    {
                        idaLIST_DPR_EXPENSE_DET.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {

                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void FCMF0364_Load(object sender, EventArgs e)
        {
            int vYear = System.DateTime.Today.Year;
            System.DateTime vDate = new System.DateTime(vYear, 1, 1);
            PERIOD_FROM.EditValue = iDate.ISYearMonth(vDate);
            PERIOD_TO.EditValue = iDate.ISYearMonth(DateTime.Today);
        }
        
        private void FCMF0364_Shown(object sender, EventArgs e)
        {
            idcDV_TAX_CODE.SetCommandParamValue("W_GROUP_CODE", "TAX_CODE");
            idcDV_TAX_CODE.ExecuteNonQuery();
            TAX_CODE_NAME_0.EditValue = idcDV_TAX_CODE.GetCommandParamValue("O_CODE_NAME");
            TAX_CODE_0.EditValue = idcDV_TAX_CODE.GetCommandParamValue("O_CODE");
        }

        #endregion

        #region ----- Lookup Event -----

        private void ilaTAX_CODE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("TAX_CODE", "Y");
        }

        private void ilaEXPENSE_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("EXPENSE_TYPE", "Y");
        }

        private void ilaPERIOD_TO_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildPERIOD_NAME.SetLookupParamValue("W_END_YYYYMM", string.Format("{0}-12", iDate.ISDate_Month_Add(DateTime.Today, 36).Year));
        }

        #endregion

        #region ----- Grid Event -----

        private void igrLIST_DPR_EXPENSE_SUM_CellDoubleClick(object pSender)
        {
            idaLIST_DPR_EXPENSE_DET.Fill();
        }

        #endregion

    }
}