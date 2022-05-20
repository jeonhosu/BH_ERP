using System;
using System.Data;
using System.Drawing;
using System.Windows.Forms;
using System.Collections.Generic;

using Syncfusion.Windows.Forms;
using Syncfusion.Windows.Forms.Tools;
using Syncfusion.Windows.Forms.Grid;
using InfoSummit.Win.ControlAdv;

namespace FCMF0720
{
    public partial class FCMF0720 : Office2007Form
    {
        #region ----- Variables -----

        private ISCommonUtil.ISFunction.ISDateTime iDate = new ISCommonUtil.ISFunction.ISDateTime();
        private ISCommonUtil.ISFunction.ISConvert iString = new ISCommonUtil.ISFunction.ISConvert();

        private string[,] mQuarter;

        #endregion;

        #region ----- Constructor -----

        public FCMF0720()
        {
            InitializeComponent();
        }

        public FCMF0720(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- MDi ToolBar Button Event -----

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    int vIndexTab = isTAB.SelectedIndex;

                    if (vIndexTab == 0)
                    {
                        Search_CLOSING_ACCOUNT();
                    }
                    else if (vIndexTab == 1)
                    {
                        Search_CLOSING_ENDING_AMOUNT();
                    }
                    else if (vIndexTab == 2)
                    {
                        Search_LIST_CLOSING_SLIP();
                    }
                    else if (vIndexTab == 3)
                    {
                        Search_LIST_CLOSING_SLIP_MM();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    int vIndexTab = isTAB.SelectedIndex;

                    if (vIndexTab == 0)
                    {
                        if (idaCLOSING_ACCOUNT.IsFocused)
                        {
                            idaCLOSING_ACCOUNT.AddOver();
                        }
                    }
                    else if (vIndexTab == 1)
                    {
                        if (idaCLOSING_ENDING_AMOUNT.IsFocused)
                        {
                            //조회된 자료를 바탕으로 작업하시면 됩니다.
                            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10306"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                            return;
                        }
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    int vIndexTab = isTAB.SelectedIndex;

                    if (vIndexTab == 0)
                    {
                        if (idaCLOSING_ACCOUNT.IsFocused)
                        {
                            idaCLOSING_ACCOUNT.AddUnder();
                        }
                    }
                    else if (vIndexTab == 1)
                    {
                        if (idaCLOSING_ENDING_AMOUNT.IsFocused)
                        {
                            //조회된 자료를 바탕으로 작업하시면 됩니다.
                            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10306"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                            return;
                        }
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    int vIndexTab = isTAB.SelectedIndex;

                    if (vIndexTab == 0)
                    {
                        if (idaCLOSING_ACCOUNT.IsFocused)
                        {
                            idaCLOSING_ACCOUNT.Update();
                        }
                    }
                    else if (vIndexTab == 1)
                    {
                        if (idaCLOSING_ENDING_AMOUNT.IsFocused)
                        {
                            idaCLOSING_ENDING_AMOUNT.Update();
                        }
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    int vIndexTab = isTAB.SelectedIndex;

                    if (vIndexTab == 0)
                    {
                        if (idaCLOSING_ACCOUNT.IsFocused)
                        {
                            idaCLOSING_ACCOUNT.Cancel();
                        }
                    }
                    else if (vIndexTab == 1)
                    {
                        if (idaCLOSING_ENDING_AMOUNT.IsFocused)
                        {
                            idaCLOSING_ENDING_AMOUNT.Cancel();
                        }
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    int vIndexTab = isTAB.SelectedIndex;

                    if (vIndexTab == 0)
                    {
                        if (idaCLOSING_ACCOUNT.IsFocused)
                        {
                            idaCLOSING_ACCOUNT.Delete();
                        }
                    }
                    else if (vIndexTab == 1)
                    {
                        if (idaCLOSING_ENDING_AMOUNT.IsFocused)
                        {
                            //기준자료로 삭제할 수 없습니다.
                            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10307"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                            return;
                        }
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

        #region ----- Form Event -----

        private void FCMF0720_Load(object sender, EventArgs e)
        {
            idaCLOSING_ENDING_AMOUNT.FillSchema();

            PERIOD_FROM.EditValue = iDate.ISYearMonth(DateTime.Today);
            PERIOD_YEAR.EditValue = iDate.ISYear(System.DateTime.Today);

            GetValue_QUARTER();

            Default_Set();
        }

        private void FCMF0720_Shown(object sender, EventArgs e)
        {
            Default_QUARTER();
        }

        #endregion

        #region ----- Private Methods ----

        private void Search_CLOSING_ACCOUNT()
        {
            idaCLOSING_ACCOUNT.Fill();
        }

        private void Search_CLOSING_ENDING_AMOUNT()
        {
            object vObject1 = PERIOD_FROM.EditValue;
            if (iString.ISNull(vObject1) == string.Empty)
            {
                //결산년월은 필수항목입니다. 확인하세요
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10226"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                PERIOD_FROM.Focus();
                return;
            }

            idaCLOSING_ENDING_AMOUNT.Fill();
        }

        private void Search_LIST_CLOSING_SLIP()
        {
            object vObject1 = PERIOD_YEAR.EditValue;
            object vObject2 = QUARTER_NAME_0.EditValue;
            if (iString.ISNull(vObject1) == string.Empty || iString.ISNull(vObject2) == string.Empty)
            {
                //결산년도, 결산분기를 입력하세요!
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10329"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                PERIOD_YEAR.Focus();
                return;
            }

            idaLIST_CLOSING_SLIP.Fill();
        }

        private void Search_LIST_CLOSING_SLIP_MM()
        {
            object vObject1 = PERIOD_1.EditValue;
            if (iString.ISNull(vObject1) == string.Empty)
            {
                //결산년월은 필수항목입니다. 확인하세요
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10226"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                PERIOD_YEAR.Focus();
                return;
            }

            idaLIST_CLOSING_SLIP_MM.Fill();
        }

        private void SetCommonParameter(string pGroup_Code, string pEnabled_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        }

        private void GetValue_QUARTER()
        {
            idaQUARTER.SetSelectParamValue("W_GROUP_CODE", "QUARTER");
            idaQUARTER.SetSelectParamValue("W_ENABLED_YN", "Y");
            idaQUARTER.Fill();

            object vObject_NAME = null;
            object vObject_CODE = null;
            int vCountArray = idaQUARTER.OraSelectData.Rows.Count;
            mQuarter = new string[vCountArray, 2];

            for (int vRow = 0; vRow < vCountArray; vRow++)
            {
                vObject_NAME = idaQUARTER.OraSelectData.Rows[vRow]["CODE_NAME"];
                vObject_CODE = idaQUARTER.OraSelectData.Rows[vRow]["CODE"];
                mQuarter[vRow, 0] = iString.ISNull(vObject_NAME);
                mQuarter[vRow, 1] = iString.ISNull(vObject_CODE);
            }
        }

        private void Default_QUARTER()
        {
            int vMonth = System.DateTime.Today.Month;

            if (vMonth == 1 || vMonth == 2 || vMonth == 3)
            {
                QUARTER_NAME_0.EditValue = mQuarter[0, 0];
                QUARTER_CODE_0.EditValue = mQuarter[0, 1];
            }
            else if (vMonth == 4 || vMonth == 5 || vMonth == 6)
            {
                QUARTER_NAME_0.EditValue = mQuarter[1, 0];
                QUARTER_CODE_0.EditValue = mQuarter[1, 1];
            }
            else if (vMonth == 7 || vMonth == 8 || vMonth == 9)
            {
                QUARTER_NAME_0.EditValue = mQuarter[2, 0];
                QUARTER_CODE_0.EditValue = mQuarter[2, 1];
            }
            else if (vMonth == 10 || vMonth == 11 || vMonth == 12)
            {
                QUARTER_NAME_0.EditValue = mQuarter[3, 0];
                QUARTER_CODE_0.EditValue = mQuarter[3, 1];
            }
        }

        private void Default_Set()
        {
            idcSET_FS_SET.ExecuteNonQuery();
            object vMESSAGE_NM = idcSET_FS_SET.GetCommandParamValue("O_MESSAGE_NM");
            object vMESSAGE_ID = idcSET_FS_SET.GetCommandParamValue("O_MESSAGE_ID");

            FS_SET_NAME_1.EditValue = vMESSAGE_NM;
            FS_SET_ID_1.EditValue = vMESSAGE_ID;
        }

        #endregion;

        #region ----- Lookup Event -----

        private void ilaCLOSING_GROUP_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("CLOSING_GROUP", "Y");
        }

        private void ilaFS_SET_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("FS_SET", "Y");
        }

        private void ilaQUARTER_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("QUARTER", "Y");
        }

        #endregion;

        #region ----- Button Event -----

        private void bCREATE_CLOSING_SLIP_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            System.Windows.Forms.DialogResult ChoiceValue;

            object vObject1 = FS_SET_ID_0.EditValue;
            object vObject2 = PERIOD_YEAR.EditValue;
            object vObject3 = QUARTER_NAME_0.EditValue;

            if (iString.ISNull(vObject1) == string.Empty || iString.ISNull(vObject2) == string.Empty || iString.ISNull(vObject3) == string.Empty)
            {
                //재무제표양식세트, 결산년도, 결산분기를 입력하세요!
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10308"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                FS_SET_NAME_0.Focus();
                return;
            }

            //결산분개 자료를 생성하시겠습니까?[FCM_10332]
            ChoiceValue = MessageBox.Show(isMessageAdapter1.ReturnText("FCM_10332"), "Question", System.Windows.Forms.MessageBoxButtons.YesNo, System.Windows.Forms.MessageBoxIcon.Question, System.Windows.Forms.MessageBoxDefaultButton.Button2);
            if (ChoiceValue == System.Windows.Forms.DialogResult.No)
            {
                return;
            }

            try
            {
                idcSLIP_CREATE_YN.ExecuteNonQuery();
                object vObject4 = idcSLIP_CREATE_YN.GetCommandParamValue("O_YN");
                string vYN = iString.ISNull(vObject4);
                if (vYN == "Y")
                {
                    //해당 분기의 자료는 이미 전표로 생성되어 결산분개 자료를 (재)생성할 수 없습니다.
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10330"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }

                idcCREATE_CLOSING_SLIP.ExecuteNonQuery();

                Search_LIST_CLOSING_SLIP();
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void bCREATE_CRJ_SLIP_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            System.Windows.Forms.DialogResult ChoiceValue;

            object vObject1 = PERIOD_YEAR.EditValue;
            object vObject2 = QUARTER_NAME_0.EditValue;
            if (iString.ISNull(vObject1) == string.Empty || iString.ISNull(vObject2) == string.Empty)
            {
                //결산년도, 결산분기를 입력하세요!
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10329"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                PERIOD_YEAR.Focus();
                return;
            }

            //해당 전표를 생성하시겠습니까?
            ChoiceValue = MessageBox.Show(isMessageAdapter1.ReturnText("FCM_10303"), "Question", System.Windows.Forms.MessageBoxButtons.YesNo, System.Windows.Forms.MessageBoxIcon.Question, System.Windows.Forms.MessageBoxDefaultButton.Button2);
            if (ChoiceValue == System.Windows.Forms.DialogResult.No)
            {
                return;
            }

            try
            {
                idcCRJ_EXIST_YN.ExecuteNonQuery();
                object vObject3 = idcCRJ_EXIST_YN.GetCommandParamValue("O_YN");
                string vYN = iString.ISNull(vObject3);
                if (vYN == "N")
                {
                    //해당 분기의 결산분개자료 생성 후 작업바랍니다.
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10331"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }

                idcSLIP_CREATE_YN.ExecuteNonQuery();
                object vObject4 = idcSLIP_CREATE_YN.GetCommandParamValue("O_YN");
                vYN = iString.ISNull(vObject4);
                if (vYN == "Y")
                {
                    //해당 분기의 자료는 이미 전표로 생성되어 전표를 (재)생성할 수 없습니다.
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10337"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }

                idcCREATE_CRJ_SLIP.ExecuteNonQuery();
                object vObject5 = idcCREATE_CRJ_SLIP.GetCommandParamValue("O_MESSAGE");
                string vMessage = iString.ISNull(vObject5);
                if (vMessage == "CREATE_OK")
                {
                    //전표생성 작업이 정상 완료되었습니다.
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10334"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                }

                Search_LIST_CLOSING_SLIP();
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void bDELETE_CRJ_SLIP_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            System.Windows.Forms.DialogResult ChoiceValue;

            object vObject1 = PERIOD_YEAR.EditValue;
            object vObject2 = QUARTER_NAME_0.EditValue;
            if (iString.ISNull(vObject1) == string.Empty || iString.ISNull(vObject2) == string.Empty)
            {
                //결산년도, 결산분기를 입력하세요!
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10329"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                PERIOD_YEAR.Focus();
                return;
            }

            //해당 전표를 삭제하시겠습니까?
            ChoiceValue = MessageBox.Show(isMessageAdapter1.ReturnText("FCM_10333"), "Question", System.Windows.Forms.MessageBoxButtons.YesNo, System.Windows.Forms.MessageBoxIcon.Question, System.Windows.Forms.MessageBoxDefaultButton.Button2);
            if (ChoiceValue == System.Windows.Forms.DialogResult.No)
            {
                return;
            }

            try
            {
                idcSLIP_CREATE_YN.ExecuteNonQuery();
                object vObject3 = idcSLIP_CREATE_YN.GetCommandParamValue("O_YN");
                string vYN = iString.ISNull(vObject3);
                if (vYN == "N")
                {
                    //삭제할 전표가 없습니다.
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10335"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }

                idcDELETE_CRJ_SLIP.ExecuteNonQuery();
                object vObject4 = idcDELETE_CRJ_SLIP.GetCommandParamValue("O_MESSAGE");
                string vMessage = iString.ISNull(vObject4);
                if (vMessage == "DELETE_OK")
                {
                    //전표삭제 작업이 정상 완료되었습니다.
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10336"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                }

                Search_LIST_CLOSING_SLIP();
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }

        }

        private void bCREATE_CLOSING_SLIP_1_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            System.Windows.Forms.DialogResult ChoiceValue;

            object vObject1 = FS_SET_ID_1.EditValue;
            object vObject2 = PERIOD_1.EditValue;

            if (iString.ISNull(vObject1) == string.Empty || iString.ISNull(vObject2) == string.Empty)
            {
                //결산년월은 필수항목입니다.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10226"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                FS_SET_NAME_0.Focus();
                return;
            }

            //결산분개 자료를 생성하시겠습니까?[FCM_10332]
            ChoiceValue = MessageBox.Show(isMessageAdapter1.ReturnText("FCM_10332"), "Question", System.Windows.Forms.MessageBoxButtons.YesNo, System.Windows.Forms.MessageBoxIcon.Question, System.Windows.Forms.MessageBoxDefaultButton.Button2);
            if (ChoiceValue == System.Windows.Forms.DialogResult.No)
            {
                return;
            }

            try
            {
                idcSLIP_CREATE_YN_MM.ExecuteNonQuery();
                object vObject4 = idcSLIP_CREATE_YN_MM.GetCommandParamValue("O_YN");
                string vYN = iString.ISNull(vObject4);
                if (vYN == "Y")
                {
                    //해당 분기의 자료는 이미 전표로 생성되어 결산분개 자료를 (재)생성할 수 없습니다.
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10330"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }

                idcCREATE_CLOSING_SLIP_MM.ExecuteNonQuery();

                Search_LIST_CLOSING_SLIP_MM();
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void bCREATE_CRJ_SLIP_1_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            System.Windows.Forms.DialogResult ChoiceValue;

            object vObject1 = PERIOD_1.EditValue;
            if (iString.ISNull(vObject1) == string.Empty)
            {
                //결산년월은 필수항목입니다.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10226"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                PERIOD_YEAR.Focus();
                return;
            }

            //해당 전표를 생성하시겠습니까?
            ChoiceValue = MessageBox.Show(isMessageAdapter1.ReturnText("FCM_10303"), "Question", System.Windows.Forms.MessageBoxButtons.YesNo, System.Windows.Forms.MessageBoxIcon.Question, System.Windows.Forms.MessageBoxDefaultButton.Button2);
            if (ChoiceValue == System.Windows.Forms.DialogResult.No)
            {
                return;
            }

            try
            {
                idcCRJ_EXIST_YN_MM.ExecuteNonQuery();
                object vObject3 = idcCRJ_EXIST_YN_MM.GetCommandParamValue("O_YN");
                string vYN = iString.ISNull(vObject3);
                if (vYN == "N")
                {
                    //해당 분기의 결산분개자료 생성 후 작업바랍니다.
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10331"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }

                idcSLIP_CREATE_YN_MM.ExecuteNonQuery();
                object vObject4 = idcSLIP_CREATE_YN_MM.GetCommandParamValue("O_YN");
                vYN = iString.ISNull(vObject4);
                if (vYN == "Y")
                {
                    //해당 분기의 자료는 이미 전표로 생성되어 전표를 (재)생성할 수 없습니다.
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10337"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }

                idcCREATE_CRJ_SLIP_MM.ExecuteNonQuery();
                object vObject5 = idcCREATE_CRJ_SLIP_MM.GetCommandParamValue("O_MESSAGE");
                string vMessage = iString.ISNull(vObject5);
                if (vMessage == "CREATE_OK")
                {
                    //전표생성 작업이 정상 완료되었습니다.
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10334"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                }

                Search_LIST_CLOSING_SLIP_MM();
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void bDELETE_CRJ_SLIP_1_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            System.Windows.Forms.DialogResult ChoiceValue;

            object vObject1 = PERIOD_1.EditValue;
            if (iString.ISNull(vObject1) == string.Empty)
            {
                //결산년월은 필수항목입니다.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10226"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                PERIOD_YEAR.Focus();
                return;
            }

            //해당 전표를 삭제하시겠습니까?
            ChoiceValue = MessageBox.Show(isMessageAdapter1.ReturnText("FCM_10333"), "Question", System.Windows.Forms.MessageBoxButtons.YesNo, System.Windows.Forms.MessageBoxIcon.Question, System.Windows.Forms.MessageBoxDefaultButton.Button2);
            if (ChoiceValue == System.Windows.Forms.DialogResult.No)
            {
                return;
            }

            try
            {
                idcSLIP_CREATE_YN_MM.ExecuteNonQuery();
                object vObject3 = idcSLIP_CREATE_YN_MM.GetCommandParamValue("O_YN");
                string vYN = iString.ISNull(vObject3);
                if (vYN == "N")
                {
                    //삭제할 전표가 없습니다.
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10335"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }

                idcDELETE_CRJ_SLIP_MM.ExecuteNonQuery();
                object vObject4 = idcDELETE_CRJ_SLIP_MM.GetCommandParamValue("O_MESSAGE");
                string vMessage = iString.ISNull(vObject4);
                if (vMessage == "DELETE_OK")
                {
                    //전표삭제 작업이 정상 완료되었습니다.
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10336"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                }

                Search_LIST_CLOSING_SLIP_MM();
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        #endregion;

        private void Get_Amount_ButtonClick(object pSender, EventArgs pEventArgs)
        {

        }

    }
}