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

namespace FCMF0363
{
    public partial class FCMF0363 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public FCMF0363()
        {
            InitializeComponent();
        }

        public FCMF0363(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Search Method ----

        private void Search_List_CREATE_DPR_SLIP()
        {
            if (igrASSET_DPR_HISTORY.RowCount > 0)
            {
                icbCHECK_YN.CheckedState = ISUtil.Enum.CheckedState.Unchecked;
                idaASSET_DPR_HISTORY.OraSelectData.AcceptChanges();
                idaASSET_DPR_HISTORY.Refillable = true;
            }
            idaASSET_DPR_HISTORY.Fill();
            igrASSET_DPR_HISTORY.Focus();
        }

        private void Search_CREATE_DPR_SLIP()
        {
            if (iString.ISNull(PERIOD_NAME_0.EditValue) == string.Empty)
            {
                //감가상각년월은 필수 항목입니다. 확인하세요
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10300"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                PERIOD_NAME_0.Focus();
                return;
            }
            if (iString.ISNull(ASSET_CATEGORY_ID_0.EditValue) == string.Empty)
            {
                //자산유형은 필수입니다.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10398"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                ASSET_CATEGORY_ID_0.Focus();
                return;
            }

            Search_List_CREATE_DPR_SLIP();
        }

        private void Search_LIST_SLIP()
        {
            idaLIST_SLIP_DPR.Fill();
            igrLIST_SLIP_DPR.Focus();
        }

        #endregion;

        #region ----- MDi ToolBar Button Event -----

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    int vIndexTab = isTab.SelectedIndex;
                    if (vIndexTab == 0)
                    {
                        Search_CREATE_DPR_SLIP();
                    }
                    else if (vIndexTab == 1)
                    {
                        Search_LIST_SLIP();
                    }
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
                    if (idaASSET_DPR_HISTORY.IsFocused)
                    {
                        idaASSET_DPR_HISTORY.Cancel();
                    }
                    else if (idaLIST_SLIP_DPR.IsFocused)
                    {
                        idaLIST_SLIP_DPR.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaLIST_SLIP_DPR.IsFocused)
                    {
                        idaLIST_SLIP_DPR.Delete();
                    }
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void FCMF0363_Load(object sender, EventArgs e)
        {

        }

        private void FCMF0363_Shown(object sender, EventArgs e)
        {
            PERIOD_NAME_0.EditValue = iDate.ISYearMonth(DateTime.Today);
            PERIOD_NAME_1.EditValue = iDate.ISYearMonth(DateTime.Today);
        }

        #endregion

        #region ----- Button Event -----

        private void ibtnCREATE_SLIP_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            int vCountCheck = 0;
            int vIndexColumn_SLIP_YN = igrASSET_DPR_HISTORY.GetColumnToIndex("SLIP_YN");
            int vCountRow = igrASSET_DPR_HISTORY.RowCount;
            for (int vRow = 0; vRow < vCountRow; vRow++)
            {
                if (iString.ISNull(igrASSET_DPR_HISTORY.GetCellValue(vRow, vIndexColumn_SLIP_YN)) == "Y")
                {
                    vCountCheck = vCountCheck + 1;
                }
            }

            if (vCountCheck == 0)
            {
                //선택한 자료가 없습니다. 선택후 다시 실행하세요
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10299"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            string vMessage = isMessageAdapter1.ReturnText("FCM_10303"); //해당 전표를 생성하시겠습니까?
            System.Windows.Forms.DialogResult vChoiceValue;

            vChoiceValue = MessageBoxAdv.Show(vMessage, "Question", System.Windows.Forms.MessageBoxButtons.YesNo, System.Windows.Forms.MessageBoxIcon.Question, System.Windows.Forms.MessageBoxDefaultButton.Button2);

            if (vChoiceValue == System.Windows.Forms.DialogResult.Yes)
            {
                try
                {
                    idaASSET_DPR_HISTORY.Update();
                    idcCREATE_DPR_SLIP.ExecuteNonQuery();

                    object vObject_Return = idcCREATE_DPR_SLIP.GetCommandParamValue("O_MESSAGE");
                    vMessage = string.Format("{0}", vObject_Return);
                    MessageBoxAdv.Show(vMessage, "Message", MessageBoxButtons.OK, MessageBoxIcon.Information);

                    Search_List_CREATE_DPR_SLIP();
                }
                catch (System.Exception ex)
                {
                    isAppInterfaceAdv1.OnAppMessage(ex.Message);
                    System.Windows.Forms.Application.DoEvents();
                }
            }
        }

        private void DELETE_DPR_SLIP_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            string vMessage = isMessageAdapter1.ReturnText("EAPP_10030"); //삭제 하시겠습니까?
            System.Windows.Forms.DialogResult vChoiceValue;

            vChoiceValue = MessageBoxAdv.Show(vMessage, "Question", System.Windows.Forms.MessageBoxButtons.YesNo, System.Windows.Forms.MessageBoxIcon.Question, System.Windows.Forms.MessageBoxDefaultButton.Button2);

            if (vChoiceValue == System.Windows.Forms.DialogResult.Yes)
            {
                try
                {
                    idcDELETE_DPR_SLIP.ExecuteNonQuery();

                    object vObject_Return = idcDELETE_DPR_SLIP.GetCommandParamValue("O_MESSAGE");
                    vMessage = string.Format("{0}", vObject_Return);
                    MessageBoxAdv.Show(vMessage, "Message", MessageBoxButtons.OK, MessageBoxIcon.Information);

                    Search_LIST_SLIP();
                }
                catch (System.Exception ex)
                {
                    isAppInterfaceAdv1.OnAppMessage(ex.Message);
                    System.Windows.Forms.Application.DoEvents();
                }
            }
        }

        #endregion

        #region ----- CheckBOX Event -----

        private void Set_CheckBox(string pStringCheck)
        {
            int vIndexColumn_SLIP_YN = igrASSET_DPR_HISTORY.GetColumnToIndex("SLIP_YN");
            int vCountRow = igrASSET_DPR_HISTORY.RowCount;
            for (int vRow = 0; vRow < vCountRow; vRow++)
            {
                igrASSET_DPR_HISTORY.SetCellValue(vRow, vIndexColumn_SLIP_YN, pStringCheck);
            }
        }

        private void icbCHECK_YN_CheckedChange(object pSender, ISCheckEventArgs e)
        {
            string vStringCheck = string.Empty;

            if (icbCHECK_YN.CheckedState == ISUtil.Enum.CheckedState.Checked)
            {
                vStringCheck = "Y";
            }
            else
            {
                vStringCheck = "N";
            }

            Set_CheckBox(vStringCheck);
        }

        #endregion

        #region ----- Grid Event -----

        private void Show_Slip_Detail(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid)
        {
            if (pGrid.RowIndex > -1)
            {
                int vSLIP_HEADER_ID = iString.ISNumtoZero(pGrid.GetCellValue("SLIP_HEADER_ID"));
                if (vSLIP_HEADER_ID > Convert.ToInt32(0))
                {
                    System.Windows.Forms.Application.UseWaitCursor = true;
                    this.Cursor = System.Windows.Forms.Cursors.WaitCursor;

                    FCMF0205.FCMF0205 vFCMF0205 = new FCMF0205.FCMF0205(this.MdiParent, isAppInterfaceAdv1.AppInterface, vSLIP_HEADER_ID);
                    vFCMF0205.Show();

                    this.Cursor = System.Windows.Forms.Cursors.Default;
                    System.Windows.Forms.Application.UseWaitCursor = false;
                }
            }
        }

        private void igrASSET_DPR_HISTORY_CellDoubleClick(object pSender)
        {
            Show_Slip_Detail(igrASSET_DPR_HISTORY);
        }

        private void igrLIST_SLIP_DPR_CellDoubleClick(object pSender)
        {
            Show_Slip_Detail(igrLIST_SLIP_DPR);
        }

        #endregion

        #region ----- Lookup Event ------

        private void ilaPERIOD_NAME_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildPERIOD.SetLookupParamValue("W_START_YYYYMM", null);
        }

        #endregion

        #region ----- Adapter Event ------

        private void idaLIST_SLIP_DPR_NewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            idaLIST_SLIP_JOURNAL.Fill();
            idaLIST_SLIP_ASSET.Fill();
        }

        #endregion
    }
}