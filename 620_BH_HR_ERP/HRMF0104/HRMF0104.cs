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

namespace HRMF0104
{
    public partial class HRMF0104 : Office2007Form
    {
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();
        ISFunction.ISConvert iString = new ISFunction.ISConvert();

        public HRMF0104(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();

            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #region ----- Data Find -----
        private void DefaultSetFormReSize()
        {//[Child Form, Mdi Form에 맞게 ReSize]
            int vMinusWidth = 4;
            int vMinusHeight = 54;
            System.Drawing.Size vSize = this.MdiParent.ClientSize;
            this.Width = vSize.Width - vMinusWidth;
            this.Height = vSize.Height - vMinusHeight;
        } 

        private void SEARCH_DB()
        {
            if (iString.ISNull(iedYear_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10022"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                iedYear_0.Focus();
                return;
            }
            if (iString.ISNull(iedTAX_TYPE_NAME_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10023"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                iedYear_0.Focus();
                return;
            }

            isDataAdapter1.SetSelectParamValue("W_SOB_ID", isAppInterfaceAdv1.SOB_ID);
            isDataAdapter1.SetSelectParamValue("W_ORG_ID", isAppInterfaceAdv1.ORG_ID);
            isDataAdapter1.Fill();

        }
        #endregion

        #region ----- Application_MainButtonClick -----
        public void Application_MainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    SEARCH_DB();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    if (isDataAdapter1.IsFocused)
                    {
                        isDataAdapter1.AddOver();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (isDataAdapter1.IsFocused)
                    {
                        isDataAdapter1.AddUnder();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (isDataAdapter1.IsFocused)
                    {
                        isDataAdapter1.SetInsertParamValue("P_SOB_ID", isAppInterfaceAdv1.SOB_ID);
                        isDataAdapter1.SetInsertParamValue("P_ORG_ID", isAppInterfaceAdv1.ORG_ID);
                        isDataAdapter1.SetInsertParamValue("P_USER_ID", isAppInterfaceAdv1.AppInterface.UserId);
                        isDataAdapter1.SetUpdateParamValue("P_USER_ID", isAppInterfaceAdv1.AppInterface.UserId);

                        isDataAdapter1.Update();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (isDataAdapter1.IsFocused)
                    {
                        isDataAdapter1.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (isDataAdapter1.IsFocused)
                    {
                        isDataAdapter1.Delete();
                    }
                }
            }
        }
        #endregion         

        #region ----- Form Event -----
        private void HRMF0104_Load(object sender, EventArgs e)
        {
            string Start_Year = iDate.ISYear(DateTime.Today, -10);
            string End_Year = iDate.ISYear(DateTime.Today);

            isDataAdapter1.FillSchema();
            ildYEAR.SetLookupParamValue("W_START_YEAR", Start_Year);
            ildYEAR.SetLookupParamValue("W_END_YEAR", End_Year);

            ildTAX_TYPE.SetLookupParamValue("W_GROUP_CODE", "TAX_TYPE");
            ildTAX_TYPE.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }
        
        private void ibtCOPY_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            string mPre_YYYY;
            string mReturn_Value;
            DialogResult mDialogResult;

            if (iString.ISNull(iedYear_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10022"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                iedYear_0.Focus();
                return;
            }
            if (iString.ISNull(iedTAX_TYPE_NAME_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10023"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                iedYear_0.Focus();
                return;
            }
            
            // 전년도 자료 존재 체크
            mPre_YYYY = Convert.ToString(Convert.ToInt32(iedYear_0.EditValue) - Convert.ToInt32(1));
            idcTAX_RATE_CHECK_YN.SetCommandParamValue("W_TAX_YYYY", mPre_YYYY);
            idcTAX_RATE_CHECK_YN.ExecuteNonQuery();
            mReturn_Value = iString.ISNull(idcTAX_RATE_CHECK_YN.GetCommandParamValue("O_CHECK_YN"));
            if (mReturn_Value == "N".ToString())
            {// 기존 자료 존재하지 않음.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10083"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                iedYear_0.Focus();
                return;
            }

            // 당년도 자료 존재 체크
            idcTAX_RATE_CHECK_YN.SetCommandParamValue("W_TAX_YYYY", iedYear_0.EditValue);
            idcTAX_RATE_CHECK_YN.ExecuteNonQuery();
            mReturn_Value = iString.ISNull(idcTAX_RATE_CHECK_YN.GetCommandParamValue("O_CHECK_YN"));
            if (mReturn_Value == "Y".ToString())
            {// 기존 자료 존재.
                mDialogResult = MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10082"), "Question", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2);
                if (mDialogResult == DialogResult.No)
                {
                    return;
                }
            }

            // Copy 시작.
            idcTAX_RATE_COPY.ExecuteNonQuery();
            mReturn_Value = iString.ISNull(idcTAX_RATE_COPY.GetCommandParamValue("O_MESSAGE"));
            MessageBoxAdv.Show(mReturn_Value, "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
        }
        #endregion

        #region ----- Adapter Event -----
        private void isDataAdapter1_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["TAX_YYYY"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:= Tax Rate Year(정산년도)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["TAX_TYPE_ID"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10023"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISDecimaltoZero(e.Row["START_AMOUNT"], 0) < Convert.ToInt32(0))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=End Amount(시작금액)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISDecimaltoZero(e.Row["END_AMOUNT"], 0) == Convert.ToInt32(0))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10025"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISDecimaltoZero(e.Row["END_AMOUNT"], 0) < iString.ISDecimaltoZero(e.Row["START_AMOUNT"], 0))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10073"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISDecimaltoZero(e.Row["TAX_RATE"], 0) < Convert.ToInt32(0))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Tax Rate(세율)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void isDataAdapter1_PreDelete(ISPreDeleteEventArgs e)
        {
        }

        #endregion

        #region ----- Lookup Event -----

        #endregion

    }
}