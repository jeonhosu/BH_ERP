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

namespace FCMF0301
{
    public partial class FCMF0301 : Office2007Form
    {
        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #region ----- Variables -----



        #endregion;

        #region ----- Constructor -----

        public FCMF0301()
        {
            InitializeComponent();
        }

        public FCMF0301(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void Search_DB()
        {
            idaASSET_CATEGORY.Fill();
            igrASSET_CATEGORY.Focus();
        }

        private void Insert_Asset_Category()
        {
            ENABLED_FLAG.CheckBoxValue = "Y";
            EFFECTIVE_DATE_FR.EditValue = iDate.ISMonth_1st(DateTime.Today);
            ASSET_CATEGORY_CODE.Focus();
        }

        private void Insert_Asset_Class()
        {
            A_ENABLED_FLAG.CheckBoxValue = "Y";
            A_EFFECTIVE_DATE_FR.EditValue = iDate.ISMonth_1st(DateTime.Today);
            A_ASSET_CLASS_CODE.Focus();
        }

        private void SetCommon_Lookup_Parameter(string pGroup_Code, string pEnabled_YN)
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
                    Search_DB();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    if (idaASSET_CATEGORY.IsFocused)
                    {
                        idaASSET_CATEGORY.AddOver();
                        Insert_Asset_Category();
                    }
                    else if (idaASSET_CLASS.IsFocused)
                    {
                        idaASSET_CLASS.AddOver();
                        Insert_Asset_Class();
                    }  
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaASSET_CATEGORY.IsFocused)
                    {
                        idaASSET_CATEGORY.AddUnder();
                        Insert_Asset_Category();
                    }
                    else if (idaASSET_CLASS.IsFocused)
                    {
                        idaASSET_CLASS.AddUnder();
                        Insert_Asset_Class();
                    }  
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    idaASSET_CATEGORY.Update();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaASSET_CATEGORY.IsFocused)
                    {
                        idaASSET_CATEGORY.Cancel();
                    }
                    else if (idaASSET_CLASS.IsFocused)
                    {
                        idaASSET_CLASS.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaASSET_CATEGORY.IsFocused)
                    {
                        idaASSET_CATEGORY.Delete();
                    }
                    else if (idaASSET_CLASS.IsFocused)
                    {
                        idaASSET_CLASS.Delete();
                    }
                }
            }
        }

        #endregion;

        #region ----- Component Event -----
        private void FCMF0301_Load(object sender, EventArgs e)
        {
            idaASSET_CATEGORY.FillSchema();
            idaASSET_CLASS.FillSchema();
        }

        private void FCMF0301_Shown(object sender, EventArgs e)
        {

        }

        private void PROGRESS_YEAR_CurrentEditValidated(object pSender, ISEditAdvValidatedEventArgs e)
        {
            if (iString.ISNull(IFRS_PROGRESS_YEAR.EditValue) == string.Empty)
            {
                IFRS_PROGRESS_YEAR.EditValue = PROGRESS_YEAR.EditValue;
            }
        }

        private void RESIDUAL_AMOUNT_CurrentEditValidated(object pSender, ISEditAdvValidatedEventArgs e)
        {
            if (iString.ISNull(IFRS_RESIDUAL_AMOUNT.EditValue) == string.Empty)
            {
                IFRS_RESIDUAL_AMOUNT.EditValue = RESIDUAL_AMOUNT.EditValue;
            }
        }

        #endregion

        #region ----- Lookup Event -----

        private void ilaASSET_CATEGORY_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildASSET_CATEGORY.SetLookupParamValue("W_ENABLED_YN", "N");
        }

        private void ilaA_ASSET_CATEGORY_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildASSET_CATEGORY.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaASSET_CLASS_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildASSET_CLASS.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaEXPENSE_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommon_Lookup_Parameter("EXPENSE_TYPE", "Y");
        }

        private void ilaASSET_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommon_Lookup_Parameter("ASSET_TYPE", "Y");
        }

        private void ilaDPR_METHOD_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommon_Lookup_Parameter("DPR_METHOD_TYPE", "Y");
        }

        private void ilaIFRS_DPR_METHOD_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommon_Lookup_Parameter("DPR_METHOD_TYPE", "Y");
        }

        private void ilaACCOUNT_CONTROL_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildACCOUNT_CONTROL.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaDPR_METHOD_SelectedRowData(object pSender)
        {
            if (iString.ISNull(IFRS_DPR_METHOD_TYPE.EditValue) == string.Empty)
            {
                IFRS_DPR_METHOD_TYPE_NAME.EditValue = DPR_METHOD_TYPE_NAME.EditValue;
                IFRS_DPR_METHOD_TYPE.EditValue = DPR_METHOD_TYPE.EditValue;
            }
        }

        #endregion
        
        #region ----- Adapeter Event -----

        private void idaASSET_CATEGORY_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["ASSET_CATEGORY_CODE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10093"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["ASSET_CATEGORY_NAME"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10094"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["ASSET_TYPE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10095"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["DPR_METHOD_TYPE"]) != string.Empty && iString.ISNull(e.Row["PROGRESS_YEAR"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10098"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["IFRS_DPR_METHOD_TYPE"]) != string.Empty && iString.ISNull(e.Row["IFRS_PROGRESS_YEAR"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10098"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            //if (iString.ISNull(e.Row["ACCOUNT_CONTROL_ID"]) == string.Empty)
            //{
            //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10088", "&&VALUE:=Account Name(계정)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    e.Cancel = true;
            //    return;
            //}
            //if (iString.ISNull(e.Row["RESIDUAL_VALUE_AMOUNT"]) == string.Empty)
            //{
            //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10088", "&&VALUE:=Residual Value Amount(잔존가액)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    e.Cancel = true;
            //    return;
            //}
        }

        private void idaASSET_CATEGORY_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:= Data(해당 데이터)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaASSET_CLASS_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["ASSET_CLASS_CODE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10099"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["ASSET_CLASS_NAME"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10100"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["ASSET_CATEGORY_ID"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10101"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["EFFECTIVE_DATE_FR"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["EFFECTIVE_DATE_TO"]) != string.Empty &&
               Convert.ToDateTime(e.Row["EFFECTIVE_DATE_FR"]) > Convert.ToDateTime(e.Row["EFFECTIVE_DATE_TO"]))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10012"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaASSET_CLASS_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:= Data(해당 데이터)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        #endregion



    }
}