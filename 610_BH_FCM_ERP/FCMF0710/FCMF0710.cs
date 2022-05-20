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

namespace FCMF0710
{
    public partial class FCMF0710 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        private object mSOB_ID = null;
        private object mORG_ID = null;
        private object mFS_SET_ID = null;
        private object mFORM_TYPE_ID = null;
        private object mITEM_CODE = null;
        private object mITEM_LEVEL = null;

        #endregion;

        #region ----- Constructor -----

        public FCMF0710()
        {
            InitializeComponent();
        }

        public FCMF0710(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void Copy_FS_MST(object pFS_Set_ID, object pForm_Type_ID
                                , object pNew_FS_Set_ID, object pNew_Form_Type_ID)
        {
            if (iString.ISNull(pFS_Set_ID) == string.Empty)
            {
                return;
            }

            if (iString.ISNull(pForm_Type_ID) == string.Empty)
            {
                return;
            }

            Application.UseWaitCursor = true;
            this.Cursor = Cursors.WaitCursor;
            Application.DoEvents();

            DialogResult vdlgResult;
            decimal vRecord_Count = 0;
            IDC_FORM_MST_COUNT.SetCommandParamValue("P_FS_SET_ID", pNew_FS_Set_ID);
            IDC_FORM_MST_COUNT.SetCommandParamValue("P_FORM_TYPE_ID", pNew_Form_Type_ID);
            IDC_FORM_MST_COUNT.ExecuteNonQuery();
            vRecord_Count = iString.ISDecimaltoZero(IDC_FORM_MST_COUNT.GetCommandParamValue("O_RECORD_COUNT"));
            Application.UseWaitCursor = false;
            this.Cursor = Cursors.Default;
            Application.DoEvents();

            if (vRecord_Count != 0)
            {
                vdlgResult = MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10082"), "Question", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
                if (vdlgResult == DialogResult.No)
                {
                    return;
                }
            }
            
            Application.UseWaitCursor = true;
            this.Cursor = Cursors.WaitCursor;
            Application.DoEvents();

            string vSTATUS = String.Empty;
            string vMESSAGE = string.Empty;


            IDC_COPY_FORM_MST.SetCommandParamValue("P_FS_SET_ID", pFS_Set_ID);
            IDC_COPY_FORM_MST.SetCommandParamValue("P_FORM_TYPE_ID", pForm_Type_ID);
            IDC_COPY_FORM_MST.SetCommandParamValue("P_NEW_FS_SET_ID", pNew_FS_Set_ID);
            IDC_COPY_FORM_MST.SetCommandParamValue("P_NEW_FORM_TYPE_ID", pNew_Form_Type_ID);
            IDC_COPY_FORM_MST.ExecuteNonQuery();
            vSTATUS = iString.ISNull(IDC_COPY_FORM_MST.GetCommandParamValue("O_STATUS"));
            vMESSAGE = iString.ISNull(IDC_COPY_FORM_MST.GetCommandParamValue("O_MESSAGE"));
            
            Application.UseWaitCursor = false;
            this.Cursor = Cursors.Default;
            Application.DoEvents();

            if (IDC_COPY_FORM_MST.ExcuteError || vSTATUS == "F")
            {
                if (vMESSAGE == string.Empty)
                {
                    return;
                }
                MessageBoxAdv.Show(vMESSAGE, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        #endregion;

        #region ----- MDi ToolBar Button Event -----

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    int vIndexTAB = isTAB.SelectedIndex;

                    if (vIndexTAB == 0)
                    {
                        SearchFORM_MASTER();
                    }
                    else if (vIndexTAB == 1)
                    {
                        SearchOMISSION_ACCOUNT();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    if (idaLIST_FORM_MASTER.IsFocused)
                    {
                        idaLIST_FORM_MASTER.AddOver();
                        DefaultInsertSetMASTER();
                        ITEM_CODE.Focus();
                    }
                    else if (idaFORM_DET.IsFocused)
                    {
                        idaFORM_DET.AddOver();
                        DefaultInsertSetDETAIL();
                        DefaultSetCheckBox(igrFORM_DETAIL);
                        DefaultSetSign(igrFORM_DETAIL);
                        FocusSetGrid(igrFORM_DETAIL);
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaLIST_FORM_MASTER.IsFocused)
                    {
                        idaLIST_FORM_MASTER.AddUnder();
                        DefaultInsertSetMASTER();
                        ITEM_CODE.Focus();
                    }
                    else if (idaFORM_DET.IsFocused)
                    {
                        idaFORM_DET.AddUnder();
                        DefaultInsertSetDETAIL();
                        DefaultSetCheckBox(igrFORM_DETAIL);
                        DefaultSetSign(igrFORM_DETAIL);
                        FocusSetGrid(igrFORM_DETAIL);
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    
                    if (idaLIST_FORM_MASTER.IsFocused)
                    {
                        idaLIST_FORM_MASTER.Update();
                    }
                    else if (idaFORM_DET.IsFocused)
                    {
                        idaFORM_DET.Update();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaLIST_FORM_MASTER.IsFocused)
                    {
                        idaLIST_FORM_MASTER.Cancel();
                    }
                    else if (idaFORM_DET.IsFocused)
                    {
                        idaFORM_DET.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaLIST_FORM_MASTER.IsFocused)
                    {
                        idaLIST_FORM_MASTER.Delete();
                    }
                    else if (idaFORM_DET.IsFocused)
                    {
                        idaFORM_DET.Delete();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                }
            }
        }

        #endregion;

        #region ----- Method -----

        private void SearchFORM_MASTER()
        {
            object vObject1 = FS_SET_ID_0.EditValue;
            object vObject2 = FORM_TYPE_ID_0.EditValue;
            if (iString.ISNull(vObject1) == string.Empty || iString.ISNull(vObject2) == string.Empty)
            {
                //재무제표양식세트와 보고서양식을 선택하세요!
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10320"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                FS_SET_NAME_0.Focus();
                return;
            }

            idaLIST_FORM_MASTER.Fill();
        }

        private void SearchOMISSION_ACCOUNT()
        {
            object vObject1 = FS_SET_ID_0.EditValue;
            object vObject2 = FORM_TYPE_ID_0.EditValue;
            if (iString.ISNull(vObject1) == string.Empty || iString.ISNull(vObject2) == string.Empty)
            {
                //재무제표양식세트와 보고서양식을 선택하세요!
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10320"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                FS_SET_NAME_0.Focus();
                return;
            }

            idaOMISSION_ACCOUNT.Fill();
        }

        private void SetCommonParameter(string pGroup_Code, string pEnabled_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        }

        private void DefaultSetCheckBox(ISGridAdvEx vGridAdv)
        {
            object vCheckBox = "Y";

            vGridAdv.SetCellValue("ENABLED_FLAG", vCheckBox);
        }

        private void DefaultSetSign(ISGridAdvEx vGridAdv)
        {
            object vSign = "+";

            vGridAdv.SetCellValue("ITEM_SIGN_SHOW", vSign);
        }

        private void FocusSetGrid(ISGridAdvEx vGridAdv)
        {
            int vIndexCheckBox = vGridAdv.GetColumnToIndex("DET_ITEM_NAME");
            vGridAdv.CurrentCellMoveTo(vIndexCheckBox);
            vGridAdv.Focus();
            vGridAdv.CurrentCellActivate(vIndexCheckBox);
        }

        private void DefaultInsertSetMASTER()
        {
            object vFS_SET_ID = FS_SET_ID_0.EditValue;
            object vFORM_TYPE_ID = FORM_TYPE_ID_0.EditValue;

            ENABLED_FLAG.CheckedState = ISUtil.Enum.CheckedState.Checked;

            igrFORM_MASTER.SetCellValue("SOB_ID", isAppInterfaceAdv1.AppInterface.SOB_ID);
            igrFORM_MASTER.SetCellValue("ORG_ID", isAppInterfaceAdv1.AppInterface.ORG_ID);
            igrFORM_MASTER.SetCellValue("FS_SET_ID", vFS_SET_ID);
            igrFORM_MASTER.SetCellValue("FORM_TYPE_ID", vFORM_TYPE_ID);

            idaLIST_FORM_MASTER.SetInsertParamValue("P_SOB_ID", isAppInterfaceAdv1.AppInterface.SOB_ID);
            idaLIST_FORM_MASTER.SetInsertParamValue("P_ORG_ID", isAppInterfaceAdv1.AppInterface.ORG_ID);
            idaLIST_FORM_MASTER.SetInsertParamValue("P_FS_SET_ID", vFS_SET_ID);
            idaLIST_FORM_MASTER.SetInsertParamValue("P_FORM_TYPE_ID", vFORM_TYPE_ID);
        }

        private void DefaultInsertSetDETAIL()
        {
            mSOB_ID = igrFORM_MASTER.GetCellValue("SOB_ID");
            mORG_ID = igrFORM_MASTER.GetCellValue("ORG_ID");
            mFS_SET_ID = igrFORM_MASTER.GetCellValue("FS_SET_ID");
            mFORM_TYPE_ID = igrFORM_MASTER.GetCellValue("FORM_TYPE_ID");
            mITEM_CODE = igrFORM_MASTER.GetCellValue("ITEM_CODE");
            mITEM_LEVEL = igrFORM_MASTER.GetCellValue("ITEM_LEVEL");

            igrFORM_DETAIL.SetCellValue("SOB_ID", mSOB_ID);
            igrFORM_DETAIL.SetCellValue("ORG_ID", mORG_ID);
            igrFORM_DETAIL.SetCellValue("FS_SET_ID", mFS_SET_ID);
            igrFORM_DETAIL.SetCellValue("FORM_TYPE_ID", mFORM_TYPE_ID);
            igrFORM_DETAIL.SetCellValue("ITEM_CODE", mITEM_CODE);
            igrFORM_DETAIL.SetCellValue("ITEM_LEVEL", mITEM_LEVEL);

            idaFORM_DET.SetInsertParamValue("P_SOB_ID", mSOB_ID);
            idaFORM_DET.SetInsertParamValue("P_ORG_ID", mORG_ID);
            idaFORM_DET.SetInsertParamValue("P_FS_SET_ID", mFS_SET_ID);
            idaFORM_DET.SetInsertParamValue("P_FORM_TYPE_ID", mFORM_TYPE_ID);
            idaFORM_DET.SetInsertParamValue("P_ITEM_CODE", mITEM_CODE);
            idaFORM_DET.SetInsertParamValue("P_ITEM_LEVEL", mITEM_LEVEL);
        }

        #endregion;

        #region ----- Form Events -----

        private void FCMF0710_Shown(object sender, EventArgs e)
        {
            FS_SET_NAME_0.Focus();
        }

        private void ilaFORM_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("FORM_TYPE", "Y");
        }

        private void ilaFS_SET_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("FS_SET", "Y");
        }

        private void ilaACCOUNT_DR_CR_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("ACCOUNT_DR_CR", "Y");
        }

        private void ilaREF_FORM_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("FORM_TYPE", "Y");
        }

        private void ilaFORM_ITEM_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("FORM_ITEM_TYPE", "Y");
        }

        private void bCREATE_FORM_MST_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            object vObject1 = FS_SET_ID_0.EditValue;
            object vObject2 = FORM_TYPE_NAME_0.EditValue;
            if (iString.ISNull(vObject1) == string.Empty || iString.ISNull(vObject2) == string.Empty)
            {
                //재무제표양식세트와 보고서양식을 선택하세요!
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10320"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                FS_SET_NAME_0.Focus();
                return;
            }

            System.Windows.Forms.DialogResult vChoiceValue;

            string vMessageString1 = isMessageAdapter1.ReturnText("FCM_10324"); //재무제표양식을 일괄 생성하시겠습니까?
            string vMessageString2 = isMessageAdapter1.ReturnText("FCM_10323"); //기존자료가 삭제되고 (재)생성됩니다.
            string vMessageString3 = isMessageAdapter1.ReturnText("FCM_10322"); //재무제표양식일괄생성
            string vMessage = string.Format("{0}\n\n{1}", vMessageString1, vMessageString2);
            vChoiceValue = MessageBoxAdv.Show(vMessage, vMessageString3, System.Windows.Forms.MessageBoxButtons.YesNo, System.Windows.Forms.MessageBoxIcon.Question, System.Windows.Forms.MessageBoxDefaultButton.Button2);

            try
            {
                if (vChoiceValue == System.Windows.Forms.DialogResult.Yes)
                {
                    idcCREATE_FORM_MST.ExecuteNonQuery();

                    //재무제표양식 일괄생성 작업이 정상 처리되었습니다. FCM_10321
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10321"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                }
            }
            catch (System.Exception ex)
            {
                MessageBoxAdv.Show(ex.Message, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        private void idaLIST_FORM_MASTER_NewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            idaFORM_DET.Fill();
        }

        #endregion;

        private void BTN_FS_COPY_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            DialogResult vdlgResult;
            FCMF0710_COPY vFCMF0710_COPY = new FCMF0710_COPY(this.MdiParent, isAppInterfaceAdv1.AppInterface
                                                            , FS_SET_ID_0.EditValue, FS_SET_NAME_0.EditValue
                                                            , FORM_TYPE_ID_0.EditValue, FORM_TYPE_NAME_0.EditValue);
            vdlgResult = vFCMF0710_COPY.ShowDialog();
            if (vdlgResult == DialogResult.OK)
            {
                object vFS_Set_ID = vFCMF0710_COPY.Get_FS_Set_ID;
                object vForm_Type_ID = vFCMF0710_COPY.Get_Form_Type_ID;

                object vNew_FS_Set_ID = vFCMF0710_COPY.Get_New_FS_Set_ID;
                object vNew_Form_Type_ID = vFCMF0710_COPY.Get_New_Form_Type_ID;


                Copy_FS_MST(vFS_Set_ID, vForm_Type_ID, vNew_FS_Set_ID, vNew_Form_Type_ID);   
            }
            vFCMF0710_COPY.Dispose();

            Application.UseWaitCursor = false;
            this.Cursor = Cursors.Default;
            Application.DoEvents();
        }

    }
}