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

namespace FCMF0310
{
    public partial class FCMF0310 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public FCMF0310()
        {
            InitializeComponent();
        }

        public FCMF0310(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----
        
        private void SearchDB()
        {
            if (iString.ISNull(PERIOD_NAME_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10300"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                PERIOD_NAME_0.Focus();
                return;
            }
            if (iString.ISNull(ASSET_CATEGORY_ID_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10095"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                ASSET_CATEGORY_DESC_0.Focus();
                return;
            }
            if (iString.ISNull(DPR_TYPE_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10221"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                DPR_TYPE_NAME_0.Focus();
                return;
            }

            if (igrDPR_SLIP.RowCount > 0)
            {
                idaDPR_SLIP.OraSelectData.AcceptChanges();
                idaDPR_SLIP.Refillable = true;
            }
            idaDPR_SLIP.Fill();
            igrDPR_SLIP.Focus();
        }

        private void SetCommonParameter_W(object pGroup_Code, object pEnabled_YN)
        {
            ildCOMMON_W.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
            ildCOMMON_W.SetLookupParamValue("W_WHERE", "VALUE1 = 'Y'");
            ildCOMMON_W.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        }

        private void Set_CheckBox()
        {
            int mIDX_Col = igrDPR_SLIP.GetColumnToIndex("CHECK_YN");
            int mCOL_SLIP_YN = igrDPR_SLIP.GetColumnToIndex("SLIP_YN");
            object mCheck_YN = icbCHECK_YN.CheckBoxValue;
            for (int r = 0; r < igrDPR_SLIP.RowCount; r++)
            {
                if (iString.ISNull(igrDPR_SLIP.GetCellValue(r, mCOL_SLIP_YN)) == "N")
                {
                    igrDPR_SLIP.SetCellValue(r, mIDX_Col, mCheck_YN);
                }
            }
        }

        private void SET_GRIDE_CELL_STATE(DataRow pDataRow)
        {
            bool mREAD_ONLY_YN = true;
            int mINSERT_YN = 0;
            int mUPDATE_YN = 0;
            int mIDX_COL = igrDPR_SLIP.GetColumnToIndex("CHECK_YN");

            if (pDataRow == null || iString.ISNull(pDataRow["SLIP_YN"]) == "N")
            {
                mREAD_ONLY_YN = false;
                mINSERT_YN = 1;
                mUPDATE_YN = 1;
            }
            else
            {
                mREAD_ONLY_YN = true;
                mINSERT_YN = 0;
                mUPDATE_YN = 0;
            }
            igrDPR_SLIP.GridAdvExColElement[mIDX_COL].ReadOnly = mREAD_ONLY_YN;
            igrDPR_SLIP.GridAdvExColElement[mIDX_COL].Insertable = mINSERT_YN;
            igrDPR_SLIP.GridAdvExColElement[mIDX_COL].Updatable = mUPDATE_YN;

            igrDPR_SLIP.ResetDraw = true;
        }

        private void Show_Slip_Detail()
        {
            int mSLIP_HEADER_ID = iString.ISNumtoZero(igrDPR_SLIP.GetCellValue("SLIP_HEADER_ID"));
            if (mSLIP_HEADER_ID > Convert.ToInt32(0))
            {
                Application.UseWaitCursor = true;
                this.Cursor = System.Windows.Forms.Cursors.WaitCursor;

                FCMF0205.FCMF0205 vFCMF0205 = new FCMF0205.FCMF0205(this.MdiParent, isAppInterfaceAdv1.AppInterface, mSLIP_HEADER_ID);
                vFCMF0205.Show();

                this.Cursor = System.Windows.Forms.Cursors.Default;
                Application.UseWaitCursor = false;
            }
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
                    if (idaDPR_SLIP.IsFocused)
                    {
                        idaDPR_SLIP.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaDPR_SLIP.IsFocused)
                    {
                        idaDPR_SLIP.Delete();
                    }
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void FCMF0310_Load(object sender, EventArgs e)
        {

        }

        private void FCMF0310_Shown(object sender, EventArgs e)
        {
            PERIOD_NAME_0.EditValue = iDate.ISYearMonth(DateTime.Today);

            idcDV_COMMON.SetCommandParamValue("W_GROUP_CODE", "DPR_TYPE");
            idcDV_COMMON.SetCommandParamValue("W_WHERE", " VALUE1 = 'Y'");
            idcDV_COMMON.ExecuteNonQuery();
            DPR_TYPE_0.EditValue = idcDV_COMMON.GetCommandParamValue("O_CODE");
            DPR_TYPE_NAME_0.EditValue = idcDV_COMMON.GetCommandParamValue("O_CODE_NAME");

        }

        private void icbCHECK_YN_CheckedChange(object pSender, ISCheckEventArgs e)
        {
            Set_CheckBox();
        }

        private void ibtnCREATE_SLIP_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            int mCHECK_COUNT = 0;
            int mIDX_COL = igrDPR_SLIP.GetColumnToIndex("CHECK_YN");
            for (int nRow = 0; nRow < igrDPR_SLIP.RowCount; nRow++)
            {
                if (iString.ISNull(igrDPR_SLIP.GetCellValue(nRow, mIDX_COL)) == "Y")
                {
                    mCHECK_COUNT = mCHECK_COUNT + 1;
                }
            }
            if (mCHECK_COUNT == 0)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10299"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            //전표생성여부 묻기.
            if (MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10303"), "Question", MessageBoxButtons.OKCancel, MessageBoxIcon.Question, MessageBoxDefaultButton.Button1) ==  DialogResult.Cancel)
            {
                return;
            }            
            idaDPR_SLIP.Update();
        }

        private void btnCANCEL_SLIP_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            DialogResult dlgRESULT;
            dlgRESULT = MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10030"), "Question", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            if (dlgRESULT == DialogResult.No)
            {
                return;
            }

            Application.DoEvents();
            Application.UseWaitCursor = true;
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            string mMESSAGE;
            idcCANCEL_DPR_SLIP.ExecuteNonQuery();
            mMESSAGE = iString.ISNull(idcCANCEL_DPR_SLIP.GetCommandParamValue("O_MESSAGE"));
            Application.DoEvents();
            Application.UseWaitCursor = false;
            this.Cursor = System.Windows.Forms.Cursors.Default;

            if (mMESSAGE != String.Empty)
            {
                MessageBoxAdv.Show(mMESSAGE, "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }

            // RE-QUERY.
            SearchDB();
        }

        private void igrDPR_SLIP_CellDoubleClick(object pSender)
        {
            Show_Slip_Detail();
        }

        #endregion

        #region ----- Lookup Event ------

        private void ilaPERIOD_NAME_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildPERIOD.SetLookupParamValue("W_START_YYYYMM", null);
        }

        private void ilaASSET_CATEGORY_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildASSET_CATEGORY.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaDPR_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter_W("DPR_TYPE", "N");
        }

        #endregion

        #region ----- Adapter : DPR_SLIP ------

        private void idaDPR_SLIP_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["CHECK_YN"]) != "Y")
            {
                return;
            }
            if (iString.ISNull(e.Row["ASSET_CATEGORY_ID"]) == String.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10095"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["DPR_TYPE"]) == String.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10097"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["EXPENSE_TYPE"]) == String.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10220"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["COST_CENTER_ID"]) == String.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10302"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaDPR_SLIP_UpdateCompleted(object pSender)
        {
            Application.DoEvents();
            Application.UseWaitCursor = true;
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            string mMESSAGE;
            idcCREATE_DPR_SLIP.ExecuteNonQuery();
            mMESSAGE = iString.ISNull(idcCREATE_DPR_SLIP.GetCommandParamValue("O_MESSAGE"));
            Application.DoEvents();
            Application.UseWaitCursor = false;
            this.Cursor = System.Windows.Forms.Cursors.Default;

            if (mMESSAGE != String.Empty)
            {
                MessageBoxAdv.Show(mMESSAGE, "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            
            // RE-QUERY.
            SearchDB();
        }

        private void idaDPR_SLIP_PreNewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            SET_GRIDE_CELL_STATE(pBindingManager.DataRow);
        }

        #endregion

    }
}