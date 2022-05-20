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

namespace FCMF0522
{
    public partial class FCMF0522 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public FCMF0522()
        {
            InitializeComponent();
        }

        public FCMF0522(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void SearchDB()
        {
            if (iString.ISNull(GL_DATE_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10015"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                GL_DATE_0.Focus();
                return;
            }
            Set_Tab_Focus();
        }

        private void Set_Tab_Focus()
        {
            if (itbBALANCE_STATEMENT.SelectedTab.TabIndex == 1)
            {
                int vIDX_Col = igrBALANCE_STATEMENT.GetColumnToIndex("ITEM_GROUP_ID");
                int vITEM_GROUP_ID = -1;
                if (iString.ISNull(ACCOUNT_CONTROL_ID_0.EditValue) == string.Empty)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10123"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    ACCOUNT_CODE_0.Focus();
                    return;
                }
                vITEM_GROUP_ID = Convert.ToInt32(iString.ISDecimaltoZero(igrBALANCE_STATEMENT.GetCellValue(vIDX_Col), -1));
                idaBALANCE_STATEMENT.Fill();
                INIT_MANAGEMENT_COLUMN();

                //focus 이동.
                if (vITEM_GROUP_ID == -1)
                {
                    igrBALANCE_STATEMENT.Focus();    
                }
                for (int nRow = 0; nRow < igrBALANCE_STATEMENT.RowCount; nRow++)
                {
                    if (vITEM_GROUP_ID == Convert.ToInt32(iString.ISDecimaltoZero(igrBALANCE_STATEMENT.GetCellValue(nRow, vIDX_Col), 0)))
                    {
                        igrBALANCE_STATEMENT.CurrentCellMoveTo(nRow, 1);
                        igrBALANCE_STATEMENT.CurrentCellActivate(nRow, 1);
                        igrBALANCE_STATEMENT.Focus();
                        return;
                    }
                }                
            }
            else if (itbBALANCE_STATEMENT.SelectedTab.TabIndex == 2)
            {
                idaSTATEMENT_EXCHANGE.Fill();
                igrSTATEMENT_EXCHANGE.Focus();
            }
            else if (itbBALANCE_STATEMENT.SelectedTab.TabIndex == 3)
            {
                idaSTATEMENT_SLIP.Fill();
                igrSTATEMENT_SLIP.Focus();
            }
        }

        private void INIT_MANAGEMENT_COLUMN()
        {            
            idaITEM_PROMPT.Fill();
            if (idaITEM_PROMPT.OraSelectData.Rows.Count == 0)
            {
                return;
            }

            int mIDX_Column;          // 시작 COLUMN.            
            int mMax_Column = 13;       // 종료 COLUMN.
            int mENABLED_COLUMN;        // 사용여부 COLUMN.

            object mENABLED_FLAG;       // 사용(표시)여부.
            object mCOLUMN_DESC;        // 헤더 프롬프트.

            for (mIDX_Column = 3; mIDX_Column < mMax_Column; mIDX_Column++)
            {
                mENABLED_COLUMN = mMax_Column + mIDX_Column;
                mENABLED_FLAG = idaITEM_PROMPT.CurrentRow[mENABLED_COLUMN];
                mCOLUMN_DESC = idaITEM_PROMPT.CurrentRow[mIDX_Column];
                if (iString.ISNull(mENABLED_FLAG, "N") == "N".ToString())
                {
                    igrBALANCE_STATEMENT.GridAdvExColElement[mIDX_Column].Visible = 0;
                }
                else
                {
                    igrBALANCE_STATEMENT.GridAdvExColElement[mIDX_Column].Visible = 1;
                    igrBALANCE_STATEMENT.GridAdvExColElement[mIDX_Column].HeaderElement[0].Default = iString.ISNull(mCOLUMN_DESC);
                    igrBALANCE_STATEMENT.GridAdvExColElement[mIDX_Column].HeaderElement[0].TL1_KR = iString.ISNull(mCOLUMN_DESC);
                }
            }

            // 외화금액 - 통화관리 하는 경우 적용.
            mIDX_Column = 0;
            mIDX_Column = igrBALANCE_STATEMENT.GetColumnToIndex("CURR_REMAIN_AMOUNT");
            mENABLED_FLAG = iString.ISNull(idaITEM_PROMPT.CurrentRow["CONTROL_CURRENCY_YN"]);
            if (iString.ISNull(mENABLED_FLAG, "N") == "N".ToString())
            {                
                igrBALANCE_STATEMENT.GridAdvExColElement[mIDX_Column].Visible = 0;
                igrBALANCE_STATEMENT.GridAdvExColElement[mIDX_Column].Insertable = 0;
                igrBALANCE_STATEMENT.GridAdvExColElement[mIDX_Column].Updatable = 0;
            }
            else
            {
                igrBALANCE_STATEMENT.GridAdvExColElement[mIDX_Column].Visible = 1;
                igrBALANCE_STATEMENT.GridAdvExColElement[mIDX_Column].Insertable = 1;
                igrBALANCE_STATEMENT.GridAdvExColElement[mIDX_Column].Updatable = 1;
            }

            // 환산환율 적용 - 환산환율 관리 하는 경우 적용.
            mIDX_Column = 0;
            mIDX_Column = igrBALANCE_STATEMENT.GetColumnToIndex("NEW_EXCHANGE_RATE");
            mENABLED_FLAG = iString.ISNull(idaITEM_PROMPT.CurrentRow["ESTIMATE_YN"]);
            if (iString.ISNull(mENABLED_FLAG, "N") == "N".ToString())
            {   
                // 환산환율.
                igrBALANCE_STATEMENT.GridAdvExColElement[mIDX_Column].Visible = 0;
                //환산원화.
                igrBALANCE_STATEMENT.GridAdvExColElement[mIDX_Column + 1].Visible = 0;
                //환산손익.
                igrBALANCE_STATEMENT.GridAdvExColElement[mIDX_Column + 2].Visible = 0;
            }
            else
            {
                // 환산환율.
                igrBALANCE_STATEMENT.GridAdvExColElement[mIDX_Column].Visible = 1;
                //환산원화.
                igrBALANCE_STATEMENT.GridAdvExColElement[mIDX_Column + 1].Visible = 1;
                //환산손익.
                igrBALANCE_STATEMENT.GridAdvExColElement[mIDX_Column + 2].Visible = 1;
            }
            igrBALANCE_STATEMENT.ResetDraw = true;            
        }

        private void SET_GRID_COL_STATUS(DataRow pDATA_ROW)
        {
            if (pDATA_ROW == null)
            {
                return;
            }
            int mIDX_CURR_REMAIN_AMOUNT = igrBALANCE_STATEMENT.GetColumnToIndex("CURR_REMAIN_AMOUNT");
            int mIDX_REMAIN_AMOUNT = igrBALANCE_STATEMENT.GetColumnToIndex("REMAIN_AMOUNT");
            int mIDX_DESCRIPTION = igrBALANCE_STATEMENT.GetColumnToIndex("DESCRIPTION");

            if (iString.ISNull(pDATA_ROW["SUMMARY_YN"], "N") == "Y")
            {
                //외화금액.
                igrBALANCE_STATEMENT.GridAdvExColElement[mIDX_CURR_REMAIN_AMOUNT].Insertable = 0;
                igrBALANCE_STATEMENT.GridAdvExColElement[mIDX_CURR_REMAIN_AMOUNT].Updatable = 0;
                //원화금액.
                igrBALANCE_STATEMENT.GridAdvExColElement[mIDX_REMAIN_AMOUNT].Insertable = 0;
                igrBALANCE_STATEMENT.GridAdvExColElement[mIDX_REMAIN_AMOUNT].Updatable = 0;
                //비고.
                igrBALANCE_STATEMENT.GridAdvExColElement[mIDX_DESCRIPTION].Insertable = 0;
                igrBALANCE_STATEMENT.GridAdvExColElement[mIDX_DESCRIPTION].Updatable = 0;
            }
            else
            {
                //외화금액.
                igrBALANCE_STATEMENT.GridAdvExColElement[mIDX_CURR_REMAIN_AMOUNT].Insertable = 1;
                igrBALANCE_STATEMENT.GridAdvExColElement[mIDX_CURR_REMAIN_AMOUNT].Updatable = 1;
                //원화금액.
                igrBALANCE_STATEMENT.GridAdvExColElement[mIDX_REMAIN_AMOUNT].Insertable = 1;
                igrBALANCE_STATEMENT.GridAdvExColElement[mIDX_REMAIN_AMOUNT].Updatable = 1;
                //비고.
                igrBALANCE_STATEMENT.GridAdvExColElement[mIDX_DESCRIPTION].Insertable = 1;
                igrBALANCE_STATEMENT.GridAdvExColElement[mIDX_DESCRIPTION].Updatable = 1;
            }
        }

        private void SET_STATEMENT_EXCHANGE()
        {
            igrSTATEMENT_EXCHANGE.SetCellValue("GL_DATE", GL_DATE_0.EditValue);
            igrSTATEMENT_EXCHANGE.Focus();
        }

        private void Show_Slip_Detail()
        {
            int mSLIP_HEADER_ID = iString.ISNumtoZero(igrSTATEMENT_SLIP.GetCellValue("SLIP_HEADER_ID"));
            if (mSLIP_HEADER_ID != Convert.ToInt32(0))
            {
                Application.UseWaitCursor = true;
                this.Cursor = System.Windows.Forms.Cursors.WaitCursor;

                FCMF0204.FCMF0204 vFCMF0204 = new FCMF0204.FCMF0204(this.MdiParent, isAppInterfaceAdv1.AppInterface, mSLIP_HEADER_ID);
                vFCMF0204.Show();

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
                    if (idaSTATEMENT_EXCHANGE.IsFocused)
                    {
                        idaSTATEMENT_EXCHANGE.AddOver();
                        SET_STATEMENT_EXCHANGE();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaSTATEMENT_EXCHANGE.IsFocused)
                    {
                        idaSTATEMENT_EXCHANGE.AddUnder();
                        SET_STATEMENT_EXCHANGE();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (idaBALANCE_STATEMENT.IsFocused)
                    {
                        idaBALANCE_STATEMENT.Update();
                    }
                    else if (idaSTATEMENT_EXCHANGE.IsFocused)
                    {
                        idaSTATEMENT_EXCHANGE.Update();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaBALANCE_STATEMENT.IsFocused)
                    {
                        idaBALANCE_STATEMENT.Cancel();
                    }
                    else if (idaSTATEMENT_EXCHANGE.IsFocused)
                    {
                        idaSTATEMENT_EXCHANGE.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaBALANCE_STATEMENT.IsFocused)
                    {
                        idaBALANCE_STATEMENT.Delete();
                    }
                    else if (idaSTATEMENT_EXCHANGE.IsFocused)
                    {
                        idaSTATEMENT_EXCHANGE.Delete();
                    }
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void FCMF0522_Load(object sender, EventArgs e)
        {
            idaBALANCE_STATEMENT.FillSchema();
            idaSTATEMENT_EXCHANGE.FillSchema();
        }

        private void FCMF0522_Shown(object sender, EventArgs e)
        {
            GL_DATE_0.EditValue = DateTime.Today;
        }

        private void igrSTATEMENT_SLIP_CellDoubleClick(object pSender)
        {
            Show_Slip_Detail();
        }

        private void btnEXE_STATEMENT_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (iString.ISNull(GL_DATE_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10015"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                GL_DATE_0.Focus();
                return;
            }

            DialogResult vRESULT;
            FCMF0522_CLOSED vFCMF0522_CLOSED = new FCMF0522_CLOSED(isAppInterfaceAdv1.AppInterface, GL_DATE_0.EditValue);
            vRESULT = vFCMF0522_CLOSED.ShowDialog();
            if (vRESULT == DialogResult.OK)
            {
                SearchDB();
            }
        }

        private void btnEXE_FORWARD_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (iString.ISNull(GL_DATE_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10015"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                GL_DATE_0.Focus();
                return;
            }

            String mMESSAGE;
            idcSET_CARRY_FORWARD.ExecuteNonQuery();
            mMESSAGE = iString.ISNull(idcSET_CARRY_FORWARD.GetCommandParamValue("O_MESSAGE"));
            if (mMESSAGE != string.Empty)
            {
                MessageBoxAdv.Show(mMESSAGE, "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void btnEXE_FORWARD_CANCEL_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (iString.ISNull(GL_DATE_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10015"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                GL_DATE_0.Focus();
                return;
            }

            String mMESSAGE;
            idcSET_CARRY_FORWARD_CANCEL.ExecuteNonQuery();
            mMESSAGE = iString.ISNull(idcSET_CARRY_FORWARD_CANCEL.GetCommandParamValue("O_MESSAGE"));
            if (mMESSAGE != string.Empty)
            {
                MessageBoxAdv.Show(mMESSAGE, "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void btnEXE_ESTIMATE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (iString.ISNull(GL_DATE_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10015"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                GL_DATE_0.Focus();
                return;
            }

            String mMESSAGE;
            idcSET_CURRENCY_ESTIMATE.ExecuteNonQuery();
            mMESSAGE = iString.ISNull(idcSET_CURRENCY_ESTIMATE.GetCommandParamValue("O_MESSAGE"));
            if (mMESSAGE != string.Empty)
            {
                MessageBoxAdv.Show(mMESSAGE, "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void btnEXE_ESTIMATE_CANCEL_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (iString.ISNull(GL_DATE_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10015"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                GL_DATE_0.Focus();
                return;
            }

            String mMESSAGE;
            idcSET_CURRENCY_ESTIMATE_CANCEL.ExecuteNonQuery();
            mMESSAGE = iString.ISNull(idcSET_CURRENCY_ESTIMATE_CANCEL.GetCommandParamValue("O_MESSAGE"));
            if (mMESSAGE != string.Empty)
            {
                MessageBoxAdv.Show(mMESSAGE, "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void itbBALANCE_STATEMENT_Click(object sender, EventArgs e)
        {
            Set_Tab_Focus();
        }

        #endregion

        #region ----- Lookup Event -----

        private void ilaACCOUNT_CONTROL_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildACCOUNT_CONTROL.SetLookupParamValue("W_ACCOUNT_CODE_FR", null);
            ildACCOUNT_CONTROL.SetLookupParamValue("W_ENABLED_YN", "N");
        }

        private void ilaCURRENCY_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCURRENCY.SetLookupParamValue("W_EXCEPT_BASE_YN", "Y");
            ildCURRENCY.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        #endregion

        #region ----- Adapter Event -----
        
        private void idaBALANCE_STATEMENT_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["GL_DATE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10015"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (iString.ISNull(e.Row["ACCOUNT_CONTROL_ID"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10123"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (iString.ISNull(e.Row["CURRENCY_CODE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10124"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (iString.ISNull(e.Row["ITEM_GROUP_ID"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", "&&FIELD_NAME:=Item Group ID(관리항목 그룹 ID)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaBALANCE_STATEMENT_PreDelete(ISPreDeleteEventArgs e)
        {
            if (iString.ISNull(e.Row["GL_DATE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10015"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (iString.ISNull(e.Row["ACCOUNT_CONTROL_ID"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10123"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (iString.ISNull(e.Row["CURRENCY_CODE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10124"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (iString.ISNull(e.Row["ITEM_GROUP_ID"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", "&&FIELD_NAME:=Item Group ID(관리항목 그룹 ID)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaBALANCE_STATEMENT_PreNewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            SET_GRID_COL_STATUS(pBindingManager.DataRow);
        }

        private void idaSTATEMENT_EXCHANGE_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["GL_DATE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10015"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (iString.ISNull(e.Row["CURRENCY_CODE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10124"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaSTATEMENT_EXCHANGE_PreDelete(ISPreDeleteEventArgs e)
        {
            if (iString.ISNull(e.Row["GL_DATE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10015"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (iString.ISNull(e.Row["CURRENCY_CODE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10124"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        #endregion

    }
}