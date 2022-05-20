using System;
using System.Windows.Forms;

using Syncfusion.Windows.Forms;
using InfoSummit.Win.ControlAdv;

namespace EAPF0103
{
    public partial class EAPF0103 : Office2007Form
    {
        #region ----- Variables -----

        ISCommonUtil.ISFunction.ISConvert iConv = new ISCommonUtil.ISFunction.ISConvert();

        private object mRadioValue_1_Search = 'N';
        private object mRadioValue_2_Insert = 'N';

        private bool mIsAllSelectRead = false;
        private bool mIsAllSelectWrite = false;
        private bool mIsAllSelectPrint = false;
        private bool mIsAllSelect = false;

        private bool mIsExistResponsibility = false;
        private bool mIsSearch = false;

        private bool mIsAppend = false;
        private bool mIsRows = false;

        #endregion;

        #region ----- Constructor -----

        public EAPF0103()
        {
            InitializeComponent();
        }

        public EAPF0103(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();

            this.MdiParent = pMainForm;

            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- User Methods -----

        private DateTime GetDateTime()
        {
            DateTime vDateTime = DateTime.Today;

            try
            {
                idcGetDate.ExecuteNonQuery();
                object vObject = idcGetDate.GetCommandParamValue("X_LOCAL_DATE");

                bool isConvert = vObject is DateTime;
                if (isConvert == true)
                {
                    vDateTime = (DateTime)vObject;
                }
            }
            catch (Exception ex)
            {
                string vMessage = ex.Message;
                vDateTime = new DateTime(9999, 12, 31, 23, 59, 59);
            }
            return vDateTime;
        }

        #endregion;

        #region ----- Select All Read Write Print Method -----

        #region ----- Select All Assembly Read Method -----

        private void SelectAllAssemblyRead(ISGridAdvEx pGrid)
        {
            int vCountRows = pGrid.RowCount;
            if (vCountRows > 0)
            {
                int vIndexCheckBox = pGrid.GetColumnToIndex("READ_FLAG");
                string vCheckedString = pGrid.GridAdvExColElement[vIndexCheckBox].CheckedString;
                string vUnCheckedString = pGrid.GridAdvExColElement[vIndexCheckBox].UncheckedString;

                for (int vRow = 0; vRow < vCountRows; vRow++)
                {
                    if (mIsAllSelectRead == true)
                    {
                        pGrid.SetCellValue(vRow, vIndexCheckBox, vCheckedString);
                    }
                    else
                    {
                        pGrid.SetCellValue(vRow, vIndexCheckBox, vUnCheckedString);
                    }
                }

                if (mIsAllSelectRead == true)
                {
                    int vMoveRow = vCountRows - 1;
                    pGrid.CurrentCellMoveTo(vMoveRow, vIndexCheckBox);
                    pGrid.Focus();
                    pGrid.CurrentCellActivate(vMoveRow, vIndexCheckBox);
                }
                else
                {
                    pGrid.CurrentCellMoveTo(0, vIndexCheckBox);
                    pGrid.Focus();
                    pGrid.CurrentCellActivate(0, vIndexCheckBox);
                }
            }
        }

        #endregion;

        #region ----- Select All Assembly Write Method -----

        private void SelectAllAssemblyWrite(ISGridAdvEx pGrid)
        {
            int vCountRows = pGrid.RowCount;
            if (vCountRows > 0)
            {
                int vIndexCheckBox = pGrid.GetColumnToIndex("WIRTE_FLAG");
                string vCheckedString = pGrid.GridAdvExColElement[vIndexCheckBox].CheckedString;
                string vUnCheckedString = pGrid.GridAdvExColElement[vIndexCheckBox].UncheckedString;

                for (int vRow = 0; vRow < vCountRows; vRow++)
                {
                    if (mIsAllSelectWrite == true)
                    {
                        pGrid.SetCellValue(vRow, vIndexCheckBox, vCheckedString);
                    }
                    else
                    {
                        pGrid.SetCellValue(vRow, vIndexCheckBox, vUnCheckedString);
                    }
                }

                if (mIsAllSelectWrite == true)
                {
                    int vMoveRow = vCountRows - 1;
                    pGrid.CurrentCellMoveTo(vMoveRow, vIndexCheckBox);
                    pGrid.Focus();
                    pGrid.CurrentCellActivate(vMoveRow, vIndexCheckBox);
                }
                else
                {
                    pGrid.CurrentCellMoveTo(0, vIndexCheckBox);
                    pGrid.Focus();
                    pGrid.CurrentCellActivate(0, vIndexCheckBox);
                }
            }
        }

        #endregion;

        #region ----- Select All Assembly Print Method -----

        private void SelectAllAssemblyPrint(ISGridAdvEx pGrid)
        {
            int vCountRows = pGrid.RowCount;
            if (vCountRows > 0)
            {
                int vIndexCheckBox = pGrid.GetColumnToIndex("PRINT_FLAG");
                string vCheckedString = pGrid.GridAdvExColElement[vIndexCheckBox].CheckedString;
                string vUnCheckedString = pGrid.GridAdvExColElement[vIndexCheckBox].UncheckedString;

                for (int vRow = 0; vRow < vCountRows; vRow++)
                {
                    if (mIsAllSelectPrint == true)
                    {
                        pGrid.SetCellValue(vRow, vIndexCheckBox, vCheckedString);
                    }
                    else
                    {
                        pGrid.SetCellValue(vRow, vIndexCheckBox, vUnCheckedString);
                    }
                }

                if (mIsAllSelectPrint == true)
                {
                    int vMoveRow = vCountRows - 1;
                    pGrid.CurrentCellMoveTo(vMoveRow, vIndexCheckBox);
                    pGrid.Focus();
                    pGrid.CurrentCellActivate(vMoveRow, vIndexCheckBox);
                }
                else
                {
                    pGrid.CurrentCellMoveTo(0, vIndexCheckBox);
                    pGrid.Focus();
                    pGrid.CurrentCellActivate(0, vIndexCheckBox);
                }
            }
        }

        #endregion;

        #region ----- Select All Assembly Method -----

        private void SelectAllAssembly(ISGridAdvEx pGrid)
        {
            int vCountRows = pGrid.RowCount;
            if (vCountRows > 0)
            {
                int vIndexCheckBox1 = pGrid.GetColumnToIndex("READ_FLAG");
                string vCheckedString1 = pGrid.GridAdvExColElement[vIndexCheckBox1].CheckedString;
                string vUnCheckedString1 = pGrid.GridAdvExColElement[vIndexCheckBox1].UncheckedString;

                int vIndexCheckBox2 = pGrid.GetColumnToIndex("WIRTE_FLAG");
                string vCheckedString2 = pGrid.GridAdvExColElement[vIndexCheckBox2].CheckedString;
                string vUnCheckedString2 = pGrid.GridAdvExColElement[vIndexCheckBox2].UncheckedString;

                int vIndexCheckBox3 = pGrid.GetColumnToIndex("PRINT_FLAG");
                string vCheckedString3 = pGrid.GridAdvExColElement[vIndexCheckBox3].CheckedString;
                string vUnCheckedString3 = pGrid.GridAdvExColElement[vIndexCheckBox3].UncheckedString;

                for (int vRow = 0; vRow < vCountRows; vRow++)
                {
                    if (mIsAllSelect == true)
                    {
                        pGrid.SetCellValue(vRow, vIndexCheckBox1, vCheckedString1);
                        pGrid.SetCellValue(vRow, vIndexCheckBox2, vCheckedString2);
                        pGrid.SetCellValue(vRow, vIndexCheckBox3, vCheckedString3);
                    }
                    else
                    {
                        pGrid.SetCellValue(vRow, vIndexCheckBox1, vUnCheckedString1);
                        pGrid.SetCellValue(vRow, vIndexCheckBox2, vUnCheckedString2);
                        pGrid.SetCellValue(vRow, vIndexCheckBox3, vUnCheckedString3);
                    }
                }

                if (mIsAllSelect == true)
                {
                    int vMoveRow = vCountRows - 1;
                    pGrid.CurrentCellMoveTo(vMoveRow, vIndexCheckBox1);
                    pGrid.Focus();
                    pGrid.CurrentCellActivate(vMoveRow, vIndexCheckBox1);
                }
                else
                {
                    pGrid.CurrentCellMoveTo(0, vIndexCheckBox1);
                    pGrid.Focus();
                    pGrid.CurrentCellActivate(0, vIndexCheckBox1);
                }
            }
        }

        #endregion;

        #endregion;

        #region ----- Loing Infomation -----

        private void ListBoxMessage(string pMessage)
        {
            //listBox1.BringToFront();
            //listBox1.SendToBack();
            listBox1.Items.Add(pMessage);
            listBox1.SelectedIndex = listBox1.Items.Count - 1;
        }


        private void InfomationLoginView()
        {
            try
            {
                string vString01 = string.Format("DB Host: {0}", isAppInterfaceAdv1.AppInterface.OraConnectionInfo.Host);
                string vString02 = string.Format("DB Port : {0}", isAppInterfaceAdv1.AppInterface.OraConnectionInfo.Port);
                string vString03 = string.Format("DB ServiceName : {0}", isAppInterfaceAdv1.AppInterface.OraConnectionInfo.ServiceName);
                string vString04 = string.Format("DB UserId : {0}", isAppInterfaceAdv1.AppInterface.OraConnectionInfo.UserId);

                string vString05 = string.Format("FTP Host : {0}", isAppInterfaceAdv1.AppInterface.AppHostInfo.Host);
                string vString06 = string.Format("FTP Port : {0}", isAppInterfaceAdv1.AppInterface.AppHostInfo.Port);
                string vString07 = string.Format("FTP UserId : {0}", isAppInterfaceAdv1.AppInterface.AppHostInfo.UserId);

                string vString11 = string.Format("LoginNo : {0}", isAppInterfaceAdv1.AppInterface.LoginNo);
                string vString12 = string.Format("LoginDescription : {0}", isAppInterfaceAdv1.AppInterface.LoginDescription);
                string vString13 = string.Format("LoginDate : {0}", isAppInterfaceAdv1.AppInterface.LoginDate.ToString());
                string vString14 = string.Format("UserId : {0}", isAppInterfaceAdv1.AppInterface.UserId.ToString());

                string vString15 = string.Format("DisplayName : {0}", isAppInterfaceAdv1.AppInterface.DisplayName);
                string vString16 = string.Format("DeptName : {0}", isAppInterfaceAdv1.AppInterface.DeptName);
                string vString17 = string.Format("PersonId : {0}", isAppInterfaceAdv1.AppInterface.PersonId.ToString());
                string vString18 = string.Format("DeptId : {0}", isAppInterfaceAdv1.AppInterface.DeptId.ToString());
                string vString19 = string.Format("SOB_ID : {0}", isAppInterfaceAdv1.AppInterface.SOB_ID.ToString());

                string vString20 = string.Format("TerritoryLanguage : {0}", isAppInterfaceAdv1.AppInterface.OraConnectionInfo.TerritoryLanguage.ToString());

                ListBoxMessage(vString01);
                ListBoxMessage(vString02);
                ListBoxMessage(vString03);
                ListBoxMessage(vString04);
                ListBoxMessage(vString05);
                ListBoxMessage(vString06);
                ListBoxMessage(vString07);

                ListBoxMessage(vString11);
                ListBoxMessage(vString12);
                ListBoxMessage(vString13);
                ListBoxMessage(vString14);
                ListBoxMessage(vString15);
                ListBoxMessage(vString16);
                ListBoxMessage(vString17);
                ListBoxMessage(vString18);
                ListBoxMessage(vString19);

                ListBoxMessage(vString20);
            }
            catch(System.Exception ex)
            {
                MessageBoxAdv.Show(ex.Message);
            }
        }

        #endregion;

        #region ----- Private Methods ----

        private bool IsNull(object pObject)
        {
            bool isNull = false;
            bool isConvert = pObject is string;
            if (isConvert == true)
            {
                string vString = pObject as string;
                isNull = string.IsNullOrEmpty(vString.Trim());
            }
            return isNull;
        }

        private void DefaultSetDateTime1()
        {
            DateTime vGetDateTime = GetDateTime();

            //ISCommonUtil.ISFunction.ISDateTime vDate = new ISCommonUtil.ISFunction.ISDateTime();
            //DateTime vMonthFirstDay = vDate.ISMonth_1st(vGetDateTime);

            isEditAdv107.EditValue = vGetDateTime;
        }

        private void DefaultSetDateTime2()
        {
            DateTime vGetDateTime = GetDateTime();

            //ISCommonUtil.ISFunction.ISDateTime vDate = new ISCommonUtil.ISFunction.ISDateTime();
            //DateTime vMonthFirstDay = vDate.ISMonth_1st(vGetDateTime);

            isGridAdvEx2.SetCellValue("EFFECTIVE_DATE_FR", vGetDateTime);
        }

        private void DefaultSetCheckBox2()
        {
            isCheckBoxAdv1.CheckedState = ISUtil.Enum.CheckedState.Checked;
        }

        private void DefaultSetCheckBox()
        {
            object vCheckBox = "Y";

            isGridAdvEx2.SetCellValue("ENABLED_FLAG", vCheckBox);
        }

        private bool IsCodeValidation(char vChar)
        {
            bool IsValidation = false;

            char[] vAlphaArray = new char[37] { '_', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' };

            int vCountFalse = 0;
            int vLength = vAlphaArray.Length;
            for (int vCol = 0; vCol < vLength; vCol++)
            {
                if (vAlphaArray[vCol] == vChar)
                {
                    vCountFalse++;
                }
            }

            if (vCountFalse > 0)
            {
                IsValidation = true;
            }

            return IsValidation;
        }

        private bool IsCode(string vText)
        {
            bool vIsCode = true;
            int vCountFalse = 0;
            int vLength = vText.Length;
            char[] vChars = vText.ToCharArray();

            for (int vCol = 0; vCol < vLength; vCol++)
            {
                bool isCode = IsCodeValidation(vChars[vCol]);
                if (isCode != true)
                {
                    vCountFalse++;
                }
            }

            if (vCountFalse > 0)
            {
                vIsCode = false;
            }

            return vIsCode;
        }

        private bool IsAbleToNewAdded(ISDataAdapter pDataAdapter)
        {
            bool IsAble = false;

            if (pDataAdapter.CurrentRow.RowState == System.Data.DataRowState.Added)
            {
                IsAble = true;
            }

            return IsAble;
        }

        #endregion;

        #region ----- Is User Select -----
        //사용자 추가시
        //사용자 형식의 Super User, Outside User에서는
        //HRM_PERSON_MASTER.PERSON_ID 가 필요없고,
        //General User 에서는
        //꼭 HRM_PERSON_MASTER.PERSON_ID 가 필수 이다.
        private bool IsUserSelect(ISEditAdv pEditAdv1, ISEditAdv pEditAdv2)
        {
            //mRadioValue_2_Insert
            bool isAble = false;
            string vUserType = mRadioValue_2_Insert as string;

            if (vUserType == "S" || vUserType == "B") //Super User
            {
                isAble = true;
            }
            else if (vUserType == "A") //General User
            {
                if (pEditAdv2.EditValue != null)
                {
                    bool isConvert1 = pEditAdv1.EditValue is string;
                    bool isConvert2 = pEditAdv2.EditValue is decimal;
                    if (isConvert1 == true && isConvert2 == true)
                    {
                        string vText1 = pEditAdv1.EditValue as string;
                        decimal vValue = (decimal)pEditAdv2.EditValue;
                        bool isNull1 = string.IsNullOrEmpty(vText1);
                        if (isNull1 != true && vValue != 0)
                        {
                            isAble = true;
                        }
                    }
                }
            }

            return isAble;
        }

        #endregion;

        #region ----- Validating -----

        private void ValidatingDate1(ISEditAdv pEditAdv, ISEditAdvValidatingEventArgs e)
        {
            DateTime vDateFrom = pEditAdv.DateTimeValue;
            if (e.EditValue != null)
            {
                DateTime vDateTo = (DateTime)e.EditValue;

                if (vDateFrom > vDateTo)
                {
                    string vMessageGet = isMessageAdapter1.ReturnText("FCM_10012"); //시작일자 ~ 종료일자의 기간이 정확하지 않습니다
                    string vMessageString = string.Format("[{0}]~[{1}]\n{2}", vDateFrom, vDateTo, vMessageGet);
                    MessageBoxAdv.Show(vMessageString, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);

                    e.Cancel = true;
                }
            }
        }

        private void ValidatingDate2(object pSender, ISGridAdvExValidatingEventArgs e)
        {
            ISGridAdvEx vGrid = pSender as ISGridAdvEx;

            int vColIndex_DateFrom = vGrid.GetColumnToIndex("EFFECTIVE_DATE_FR"); //유효시작일
            int vColIndex_DateTo = vGrid.GetColumnToIndex("EFFECTIVE_DATE_TO"); //유효종료일

            if (e.ColIndex == vColIndex_DateTo)
            {
                if (e.NewValue != null)
                {
                    Type vType = e.NewValue.GetType();
                    bool isNull1 = vType == Type.GetType("System.DBNull") ? true : false;
                    if (isNull1 == false)
                    {
                        string vTextDate = e.NewValue.ToString();
                        bool isNull2 = string.IsNullOrEmpty(vTextDate);
                        bool isConvert = e.NewValue is DateTime;
                        if (isNull2 == false && isConvert == true)
                        {

                            ISGridAdvEx vGridAdvEx = pSender as ISGridAdvEx;
                            DateTime vDateFrom = (DateTime)vGridAdvEx.GetCellValue(vColIndex_DateFrom);
                            DateTime vDateTo = (DateTime)e.NewValue;

                            if (vDateFrom > vDateTo)
                            {
                                e.Cancel = true;

                                string vFrom = vDateFrom.ToShortDateString();
                                string vTo = vDateTo.ToShortDateString();
                                string vMessageGet = isMessageAdapter1.ReturnText("FCM_10012"); //시작일자 ~ 종료일자의 기간이 정확하지 않습니다
                                string vMessageString = string.Format("[{0}]~[{1}]\n{2}", vFrom, vTo, vMessageGet);
                                MessageBoxAdv.Show(vMessageString, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                            }
                        }
                    }
                }
            }
        }

        private void ValidatingDate3(object pSender, ISEditAdvValidatingEventArgs e)
        {
            ISEditAdv vEditAdv = pSender as ISEditAdv;

            if (e.EditValue != null)
            {
                bool isConvert = e.EditValue is string;
                if (isConvert == true)
                {
                    string vCodeString = e.EditValue as string;
                    bool isNull = string.IsNullOrEmpty(vCodeString);
                    if (isNull == false)
                    {
                        //bool vIsCode = IsCode(vCodeString);
                        //if (vIsCode == false)
                        //{
                        //    e.Cancel = true;

                        //    string vMessageGet = isMessageAdapter1.ReturnText("EAPP_10012"); //대문자 영어와 숫자를 조합한 코드만 입력하세요!
                        //    string vMessageString = string.Format("{0}", vMessageGet);
                        //    MessageBoxAdv.Show(vMessageString, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        //}
                        ISCommonUtil.ISFunction.ISCode isCode = new ISCommonUtil.ISFunction.ISCode();
                        bool vIsCode = isCode.ISCheckCode(vCodeString);
                        if (vIsCode != true)
                        {
                            e.Cancel = true;

                            string vMessageGet = isMessageAdapter1.ReturnText("EAPP_10012"); //대문자 영어와 숫자를 조합한 코드만 입력하세요!
                            string vMessageString = string.Format("{0}", vMessageGet);
                            MessageBoxAdv.Show(vMessageString, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        }
                    }
                }
            }
        }

        private bool ValidatingDate4(ISGridAdvEx pGrid)
        {
            bool isAble = true;

            int vColIndex_DateFrom = pGrid.GetColumnToIndex("EFFECTIVE_DATE_FR"); //유효시작일
            int vColIndex_DateTo = pGrid.GetColumnToIndex("EFFECTIVE_DATE_TO");   //유효종료일

            Type vType = pGrid.GetCellValue(vColIndex_DateFrom).GetType();
            bool isNull1 = vType == Type.GetType("System.DBNull") ? true : false;
            if (isNull1 == false)
            {
                bool isConvert1 = pGrid.GetCellValue(vColIndex_DateFrom) is DateTime;
                bool isConvert2 = pGrid.GetCellValue(vColIndex_DateTo) is DateTime;
                if (isConvert1 == true && isConvert2 == true)
                {
                    DateTime vDateFrom = (DateTime)pGrid.GetCellValue(vColIndex_DateFrom);
                    DateTime vDateTo = (DateTime)pGrid.GetCellValue(vColIndex_DateTo);

                    if (vDateFrom > vDateTo)
                    {
                        isAble = false;

                        string vFrom = vDateFrom.ToShortDateString();
                        string vTo = vDateTo.ToShortDateString();
                        string vMessageGet = isMessageAdapter1.ReturnText("FCM_10012"); //시작일자 ~ 종료일자의 기간이 정확하지 않습니다
                        string vMessageString = string.Format("[{0}]~[{1}]\n{2}", vFrom, vTo, vMessageGet);
                        MessageBoxAdv.Show(vMessageString, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    }
                }
            }

            return isAble;
        }

        #endregion;

        #region ----- Search From DataAdapter -----

        private void SearchFromDataAdapter()
        {
            bool isNull = false;
            object vOjbect = false;

            vOjbect = isEditAdv301.EditValue;
            isNull = IsNull(vOjbect);
            if (isNull != true)
            {
                isDataAdapter1.SetSelectParamValue("W_DESCRIPTION", vOjbect);
            }
            else
            {
                isDataAdapter1.SetSelectParamValue("W_DESCRIPTION", null);
            }

            vOjbect = isEditAdv401.EditValue;
            isNull = IsNull(isEditAdv401.EditValue);
            if (isNull != true)
            {
                isDataAdapter1.SetSelectParamValue("W_DEPT_NAME", vOjbect);
            }
            else
            {
                isDataAdapter1.SetSelectParamValue("W_DEPT_NAME", null);
            }

            isNull = IsNull(mRadioValue_1_Search);
            if (isNull != true)
            {
                isDataAdapter1.SetSelectParamValue("W_USER_TYPE", mRadioValue_1_Search);
            }
            else
            {
                isDataAdapter1.SetSelectParamValue("W_USER_TYPE", null);
            }

            isDataAdapter1.Fill();
        }

        #endregion;

        #region ----- Events -----

        #region ----- Form Load -----

        private void EAPF0103_Load(object sender, EventArgs e)
        {
            isDataAdapter1.FillSchema();

            idaUSER_RESPONSIBLE.FillSchema();
            idaUSER_PRG_AUTHOR.FillSchema();

            mRadioValue_1_Search = 'N';
            mRadioValue_2_Insert = 'A';

            idaUSER_RESPONSIBLE_COPY.FillSchema();
            idaUSER_PRG_AUTHOR_COPY.FillSchema();
        }

        private void EAPF0103_Shown(object sender, EventArgs e)
        {
            isEditAdv301.Focus();
        }

        #endregion;

        #region ----- Radio Button Check Changed -----

        private void isRadioButtonAdv_1_CheckChanged(object sender, EventArgs e)
        {
            ISRadioButtonAdv vRadio = sender as ISRadioButtonAdv;

            if (vRadio.Checked == true)
            {
                mRadioValue_1_Search = vRadio.RadioCheckedString;
            }
        }

        private void isRadioButtonAdv_2_CheckChanged(object sender, EventArgs e)
        {
            ISRadioButtonAdv vRadio = sender as ISRadioButtonAdv;

            if (vRadio.Checked == true)
            {
                mRadioValue_2_Insert = vRadio.RadioCheckedString;
            }
        }

        #endregion;

        #region ----- Validating -----

        private void isEditAdv12_CurrentEditValidating(object pSender, ISEditAdvValidatingEventArgs e)
        {
            ValidatingDate1(isEditAdv107, e);
        }

        private void isGridAdvEx2_CurrentCellValidating(object pSender, ISGridAdvExValidatingEventArgs e)
        {
            ValidatingDate2(pSender, e);
        }

        private void isEditAdv3_CurrentEditValidating(object pSender, ISEditAdvValidatingEventArgs e)
        {
            ValidatingDate3(pSender, e);
        }

        #endregion;

        #region ----- New Row Moved -----

        private void isDataAdapter1_NewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            try
            {
                IDC_GET_TRY_LOGIN_CNT.ExecuteNonQuery();

                idaUSER_RESPONSIBLE.Fill();

                idaUSER_PRG_AUTHOR.Fill();
            }
            catch
            {
            }
        }

        #endregion;

        #region ----- isEditAdv1 Key Down -----

        private void isEditAdv1_KeyDown(object pSender, KeyEventArgs e)
        {
            string vMessageText = string.Empty;

            if (e.Modifiers == Keys.Control)
            {
                switch (e.KeyCode)
                {
                    case Keys.F11:
                        listBox1.BringToFront();
                        InfomationLoginView();
                        break;
                    default:
                        listBox1.SendToBack();
                        break;
                }
            }
            else
            {
                listBox1.SendToBack();
            }
        }

        #endregion;

        #region ----- Tab Selected -----

        private void isTabAdv1_SelectedIndexChanged(object sender, EventArgs e)
        {
            int vIndexTab = isTabAdv1.SelectedIndex;
            if (vIndexTab == 0)
            {
                isGridAdvEx2.Focus();
            }
            else if (vIndexTab == 1)
            {
                isGridAdvEx3.Focus();
            }
        }

        #endregion;

        #region ----- CheckBox Checked Change -----

        private void isCheckBoxAdv2_CheckedChange(object pSender, ISCheckEventArgs e)
        {
            if (e.CheckedState == ISUtil.Enum.CheckedState.Checked)
            {
                mIsAllSelectRead = true;
            }
            else
            {
                mIsAllSelectRead = false;
            }
            SelectAllAssemblyRead(isGridAdvEx3);
        }

        private void isCheckBoxAdv3_CheckedChange(object pSender, ISCheckEventArgs e)
        {
            if (e.CheckedState == ISUtil.Enum.CheckedState.Checked)
            {
                mIsAllSelectWrite = true;
            }
            else
            {
                mIsAllSelectWrite = false;
            }
            SelectAllAssemblyWrite(isGridAdvEx3);
        }

        private void isCheckBoxAdv4_CheckedChange(object pSender, ISCheckEventArgs e)
        {
            if (e.CheckedState == ISUtil.Enum.CheckedState.Checked)
            {
                mIsAllSelectPrint = true;
            }
            else
            {
                mIsAllSelectPrint = false;
            }
            SelectAllAssemblyPrint(isGridAdvEx3);
        }

        private void isCheckBoxAdv5_CheckedChange(object pSender, ISCheckEventArgs e)
        {
            if (e.CheckedState == ISUtil.Enum.CheckedState.Checked)
            {
                mIsAllSelect = true;
            }
            else
            {
                mIsAllSelect = false;
            }
            SelectAllAssembly(isGridAdvEx3);
        }

        #endregion;

        #region ----- Convert Number Method -----

        private decimal ConvertNumber(object pObject)
        {
            bool vIsConvert = false;
            decimal vConvertDecimal = 0m;

            try
            {
                if (pObject != null)
                {
                    vIsConvert = pObject is decimal;
                    if (vIsConvert == true)
                    {
                        vConvertDecimal = (decimal)pObject;
                    }
                }
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
            }

            return vConvertDecimal;
        }

        #endregion;

        #region ----- Convert String Method ----

        private string ConvertString(object pObject)
        {
            string vString = string.Empty;

            try
            {
                if (pObject != null)
                {
                    bool IsConvert = pObject is string;
                    if (IsConvert == true)
                    {
                        vString = pObject as string;
                    }
                }
            }
            catch
            {
            }

            return vString;
        }

        #endregion;

        #region ----- RESPONSIBLE Exist Same -----

        private bool ResponsibilityExistSame()
        {
            bool IsExistSame = false;

            if (idaUSER_RESPONSIBLE_VIEW.OraSelectData == null)
            {
                return IsExistSame;
            }

            if (idaUSER_RESPONSIBLE_COPY.OraSelectData == null)
            {
                return IsExistSame;
            }

            object vObject = idaUSER_RESPONSIBLE_VIEW.OraSelectData.Rows[0]["RESPONSIBILITY_ID"];
            decimal vConvertDecimal1 = ConvertNumber(vObject);
            decimal vConvertDecimal2 = 0m;

            foreach(System.Data.DataRow vRow in idaUSER_RESPONSIBLE_COPY.OraSelectData.Rows)
            {
                vObject = vRow["RESPONSIBILITY_ID"];
                vConvertDecimal2 = ConvertNumber(vObject);
                if (vConvertDecimal1 == vConvertDecimal2)
                {
                    IsExistSame = true;
                }
            }

            return IsExistSame;
        }

        #endregion;

        #region ----- RESPONSIBLE Copy -----

        private void btnResponsibilityCopy_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            //[2011-03-31]
            //권한 그리드의 행수가 [기준 사용자] 보다 [복사 사용자]가 작으면
            //[복사 사용자] 권한을 모두 지우고, 모두 복사한다.

            //[기준 사용자]의 권한 행수가 1개이면,
            //[복사 사용자] 권한을 추가한다.

            if (mIsSearch == true && mIsRows != true && mIsAppend != true)
            {
                ReFill7();

                string vMessageGet = "같은 권한이 이미 존재합니다!";
                string vMessageString = string.Format("{0}", vMessageGet);
                Syncfusion.Windows.Forms.MessageBoxAdv.Show(vMessageString, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);

                System.Windows.Forms.DialogResult ChoiceValue;

                vMessageGet = "같은 권한 내의 미부여된 어셈블리를 추가 하시겠습니까?";
                vMessageString = string.Format("{0}", vMessageGet);
                ChoiceValue = Syncfusion.Windows.Forms.MessageBoxAdv.Show(vMessageString, "[권한추가]", System.Windows.Forms.MessageBoxButtons.YesNo, System.Windows.Forms.MessageBoxIcon.Question, System.Windows.Forms.MessageBoxDefaultButton.Button2);

                if (ChoiceValue == System.Windows.Forms.DialogResult.Yes)
                {
                    System.Windows.Forms.Application.DoEvents();

                    ResponsibilityADD();
                }

                return;
            }

            if (mIsSearch == true && mIsExistResponsibility == true && mIsRows == true && mIsAppend != true)
            {
                System.Windows.Forms.DialogResult ChoiceValue;

                string vMessageGet = isMessageAdapter1.ReturnText("EAPP_10060"); //이미 지정된 권한을 모두 삭제후 복사 하시겠습니까?
                string vMessageString = string.Format("{0}\n\n{1}", isEditAdv801.EditValue, vMessageGet);
                ChoiceValue = Syncfusion.Windows.Forms.MessageBoxAdv.Show(vMessageString, "[권한삭제]", System.Windows.Forms.MessageBoxButtons.YesNo, System.Windows.Forms.MessageBoxIcon.Question, System.Windows.Forms.MessageBoxDefaultButton.Button2);

                if (ChoiceValue == System.Windows.Forms.DialogResult.Yes)
                {
                    System.Windows.Forms.Application.DoEvents();

                    ResponsibilityDELETE();

                    ResponsibilityCOPY();
                }
            }
            else if (mIsSearch == true && mIsExistResponsibility == true && mIsRows != true && mIsAppend == true)
            {
                System.Windows.Forms.DialogResult ChoiceValue;

                string vMessageGet = "권한을 추가 하시겠습니까?";
                string vMessageString = string.Format("{0}", vMessageGet);
                ChoiceValue = Syncfusion.Windows.Forms.MessageBoxAdv.Show(vMessageString, "[권한추가]", System.Windows.Forms.MessageBoxButtons.YesNo, System.Windows.Forms.MessageBoxIcon.Question, System.Windows.Forms.MessageBoxDefaultButton.Button2);

                if (ChoiceValue == System.Windows.Forms.DialogResult.Yes)
                {
                    System.Windows.Forms.Application.DoEvents();

                    ResponsibilityCOPY();
                }
            }
            else if (mIsSearch == true)
            {
                ResponsibilityCOPY(); //권한이 전혀 부여 되지 않은 사용자 복사
            }
            else
            {
                isEditAdv911.EditValue = null;
                isEditAdv912.EditValue = null;
                isEditAdv913.EditValue = null;

                isEditAdv801.EditValue = null;
                isEditAdv802.EditValue = null;

                isGridAdvEx6.RowCount = 0;
                isGridAdvEx7.RowCount = 0;

                string vMessageGet = isMessageAdapter1.ReturnText("EAPP_10059"); //복사 사용자가 선택 되지 않았습니다.
                Syncfusion.Windows.Forms.MessageBoxAdv.Show(vMessageGet, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        private void btnResponsibilityDELETE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            object vObject = isEditAdv913.EditValue;
            decimal vRESPONSIBILITY_ID = ConvertNumber(vObject);
            if (vRESPONSIBILITY_ID == 0)
            {
                string vMessageGet = "삭제할 권한을 선택 하세요!";
                string vMessageString = string.Format("{0}", vMessageGet);
                Syncfusion.Windows.Forms.MessageBoxAdv.Show(vMessageString, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);

                return;
            }
            ResponsibilityDELETE();
        }

        private void ilaUSERFrom_SelectedRowData(object pSender)
        {
            ReFill4();
        }

        private void ilaRESPONSIBILITY3_SelectedRowData(object pSender)
        {
            ReFill4();
        }

        private void ilaRESPONSIBILITY4_SelectedRowData(object pSender)
        {
            ReFill5();
        }

        private void ilaUSERTo_SelectedRowData(object pSender)
        {
            mIsRows = false;
            mIsAppend = false;
            mIsSearch = false;
            mIsExistResponsibility = false;
            if (idaUSER_RESPONSIBLE_VIEW.OraSelectData == null && idaUSER_PRG_AUTHOR_VIEW.OraSelectData == null)
            {
                string vMessageGet = isMessageAdapter1.ReturnText("EAPP_10058"); //[기준 사용자]를 선택하지 않았습니다!
                string vMessageString = string.Format("{0}", vMessageGet);
                Syncfusion.Windows.Forms.MessageBoxAdv.Show(vMessageString, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                //Syncfusion.Windows.Forms.MessageBoxAdv.Show("Source User, Not is Exist", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);

                return;
            }
            int vCountRow1 = idaUSER_RESPONSIBLE_VIEW.OraSelectData.Rows.Count;
            int vCountRow2 = idaUSER_PRG_AUTHOR_VIEW.OraSelectData.Rows.Count;

            if (vCountRow1 < 1 || vCountRow2 < 1)
            {
                string vMessageGet = isMessageAdapter1.ReturnText("EAPP_10058"); //[기준 사용자]를 선택하지 않았습니다!
                string vMessageString = string.Format("{0}", vMessageGet);
                Syncfusion.Windows.Forms.MessageBoxAdv.Show(vMessageString, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                //Syncfusion.Windows.Forms.MessageBoxAdv.Show("Source User, Not is Exist", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);

                return;
            }

            idaUSER_RESPONSIBLE_COPY.Fill();
            idaUSER_PRG_AUTHOR_COPY.Fill();
            int vCountRow3 = idaUSER_RESPONSIBLE_COPY.OraSelectData.Rows.Count;
            int vCountRow4 = idaUSER_PRG_AUTHOR_COPY.OraSelectData.Rows.Count;

            mIsSearch = true;

            if (vCountRow1 == 1)
            {
                bool IsExistSame = ResponsibilityExistSame();
                if (IsExistSame != true)
                {
                    mIsAppend = true;
                }
            }
            else
            {
                mIsRows = true;
            }

            if (vCountRow3 > 0 || vCountRow4 > 0)
            {
                mIsExistResponsibility = true;

                //string vMessageGet = isMessageAdapter1.ReturnText("EAPP_10057"); //이미 존재 합니다.
                //string vMessageString = string.Format("{0}\n\n{1}", isEditAdv801.EditValue, vMessageGet);
                //Syncfusion.Windows.Forms.MessageBoxAdv.Show(vMessageString, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                //Syncfusion.Windows.Forms.MessageBoxAdv.Show("Exist is already", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);

                string vMessageGet = isMessageAdapter1.ReturnText("EAPP_10057"); //이미 존재 합니다.
                string vMessageString = string.Format("[{0}] {1}", isEditAdv801.EditValue, vMessageGet);
                isAppInterfaceAdv1.OnAppMessage(vMessageString);

                return;
            }
            else
            {
                string vMessageGet = isMessageAdapter1.ReturnText("EAPP_10061"); //Data가 없습니다.
                string vMessageString = string.Format("{0}\n\n{1}", isEditAdv801.EditValue, vMessageGet);
                Syncfusion.Windows.Forms.MessageBoxAdv.Show(vMessageString, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                //Syncfusion.Windows.Forms.MessageBoxAdv.Show("Without DB Data", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);

                return;
            }
        }

        private void ResponsibilityDELETE()
        {
            int vCountRowGrid = isGridAdvEx7.RowCount;
            for (int vRow = 0; vRow < vCountRowGrid; vRow++)
            {
                idaUSER_PRG_AUTHOR_COPY.Delete();
            }
            idaUSER_PRG_AUTHOR_COPY.Update();
            idaUSER_PRG_AUTHOR_COPY.Fill();
            System.Windows.Forms.Application.DoEvents();

            vCountRowGrid = isGridAdvEx6.RowCount;
            for (int vRow = 0; vRow < vCountRowGrid; vRow++)
            {
                idaUSER_RESPONSIBLE_COPY.Delete();
            }
            idaUSER_RESPONSIBLE_COPY.Update();
            idaUSER_RESPONSIBLE_COPY.Fill();
            System.Windows.Forms.Application.DoEvents();
        }

        private void ResponsibilityCOPY()
        {
            object vObject = null;

            int vCountRow1 = idaUSER_RESPONSIBLE_VIEW.OraSelectData.Rows.Count;
            int vCountRow2 = idaUSER_PRG_AUTHOR_VIEW.OraSelectData.Rows.Count;

            if (vCountRow1 < 1 || vCountRow2 < 1)
            {
                string vMessageGet = isMessageAdapter1.ReturnText("EAPP_10058"); //[기준 사용자]를 선택하지 않았습니다!
                string vMessageString = string.Format("{0}", isEditAdv801.EditValue, vMessageGet);
                Syncfusion.Windows.Forms.MessageBoxAdv.Show(vMessageString, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                //Syncfusion.Windows.Forms.MessageBoxAdv.Show("Source User, Not is Exist", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);

                return;
            }

            //idaUSER_RESPONSIBLE_COPY.Fill();
            //idaUSER_PRG_AUTHOR_COPY.Fill();
            //int vCountRow3 = idaUSER_RESPONSIBLE_COPY.OraSelectData.Rows.Count;
            //int vCountRow4 = idaUSER_PRG_AUTHOR_COPY.OraSelectData.Rows.Count;

            ////if (vCountRow3 > 0 || vCountRow4 > 0)
            //if (mIsSearch == true && mIsExistResponsibility == true && mIsRows == true && mIsAppend != true)
            //{
            //    mIsExistResponsibility = true;

            //    string vMessageGet = isMessageAdapter1.ReturnText("EAPP_10057"); //이미 존재 합니다.
            //    string vMessageString = string.Format("{0}\n\n{1}", isEditAdv801.EditValue, vMessageGet);
            //    Syncfusion.Windows.Forms.MessageBoxAdv.Show(vMessageString, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    //Syncfusion.Windows.Forms.MessageBoxAdv.Show("Exist is already", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);

            //    return;
            //}

            if (mIsRows == true && mIsAppend != true) //모두 삭제후 복사
            {
                int vCountRowGrid = isGridAdvEx4.RowCount;
                int vCountColGrid = isGridAdvEx4.ColCount;
                for (int vRow = 0; vRow < vCountRowGrid; vRow++)
                {
                    idaUSER_RESPONSIBLE_COPY.AddUnder();
                    for (int vCol = 0; vCol < vCountColGrid; vCol++)
                    {
                        vObject = isGridAdvEx4.GetCellValue(vRow, vCol);
                        isGridAdvEx6.SetCellValue(vRow, vCol, vObject);
                    }
                    vObject = isEditAdv802.EditValue;
                    isGridAdvEx6.SetCellValue(vRow, 6, vObject);
                }
                vObject = idaUSER_RESPONSIBLE_COPY.CurrentRow;
                idaUSER_RESPONSIBLE_COPY.Update();
                idaUSER_RESPONSIBLE_COPY.Fill();

                vCountRowGrid = isGridAdvEx5.RowCount;
                vCountColGrid = isGridAdvEx5.ColCount;
                for (int vRow = 0; vRow < vCountRowGrid; vRow++)
                {
                    idaUSER_PRG_AUTHOR_COPY.AddUnder();
                    for (int vCol = 0; vCol < vCountColGrid; vCol++)
                    {
                        vObject = isGridAdvEx5.GetCellValue(vRow, vCol);
                        isGridAdvEx7.SetCellValue(vRow, vCol, vObject);
                    }
                    vObject = isEditAdv802.EditValue;
                    isGridAdvEx7.SetCellValue(vRow, 5, vObject);
                }
                idaUSER_PRG_AUTHOR_COPY.Update();
                idaUSER_PRG_AUTHOR_COPY.Fill();
            }
            else //추가
            {
                int vCurrentRowGrid = isGridAdvEx6.RowCount;
                int vCountRowGrid = 0;
                int vCountColGrid = isGridAdvEx4.ColCount;

                isGridAdvEx6.CurrentCellMoveTo((vCurrentRowGrid - 1), 0);
                isGridAdvEx6.Focus();
                isGridAdvEx6.CurrentCellActivate((vCurrentRowGrid - 1), 0);

                idaUSER_RESPONSIBLE_COPY.AddUnder();
                vCurrentRowGrid = idaUSER_RESPONSIBLE_COPY.OraSelectData.Rows.IndexOf(idaUSER_RESPONSIBLE_COPY.CurrentRow);
                for (int vCol = 0; vCol < vCountColGrid; vCol++)
                {
                    vObject = isGridAdvEx4.GetCellValue(0, vCol);
                    isGridAdvEx6.SetCellValue(vCurrentRowGrid, vCol, vObject);
                }
                vObject = isEditAdv802.EditValue;
                isGridAdvEx6.SetCellValue(vCurrentRowGrid, 6, vObject);

                vObject = idaUSER_RESPONSIBLE_COPY.CurrentRow;
                idaUSER_RESPONSIBLE_COPY.Update();
                idaUSER_RESPONSIBLE_COPY.Fill();


                vCurrentRowGrid = isGridAdvEx7.RowCount;
                vCountRowGrid = isGridAdvEx5.RowCount;
                vCountColGrid = isGridAdvEx5.ColCount;

                isGridAdvEx7.CurrentCellMoveTo((vCurrentRowGrid - 1), 0);
                isGridAdvEx7.Focus();
                isGridAdvEx7.CurrentCellActivate((vCurrentRowGrid - 1), 0);

                for (int vRow = 0; vRow < vCountRowGrid; vRow++)
                {
                    idaUSER_PRG_AUTHOR_COPY.AddUnder();
                    vCurrentRowGrid = idaUSER_PRG_AUTHOR_COPY.OraSelectData.Rows.IndexOf(idaUSER_PRG_AUTHOR_COPY.CurrentRow);
                    for (int vCol = 0; vCol < vCountColGrid; vCol++)
                    {
                        vObject = isGridAdvEx5.GetCellValue(vRow, vCol);
                        isGridAdvEx7.SetCellValue(vCurrentRowGrid, vCol, vObject);
                    }
                    vObject = isEditAdv802.EditValue;
                    isGridAdvEx7.SetCellValue(vCurrentRowGrid, 5, vObject);
                }
                idaUSER_PRG_AUTHOR_COPY.Update();
                idaUSER_PRG_AUTHOR_COPY.Fill();
            }

            mIsSearch = false;
            mIsExistResponsibility = false;
        }

        #endregion;

        #region ----- Responsibility ADD -----

        private void ResponsibilityADD()
        {
            int vCountExist = 0;
            object vObject = null;
            string vStringFROM = string.Empty;
            string vStringTO = string.Empty;

            int vCountRowGrid = isGridAdvEx5.RowCount;
            int vCountColGrid = isGridAdvEx5.ColCount;

            int vCurrentRowGrid = isGridAdvEx7.RowCount;
            isGridAdvEx7.CurrentCellMoveTo((vCurrentRowGrid - 1), 0);
            isGridAdvEx7.Focus();
            isGridAdvEx7.CurrentCellActivate((vCurrentRowGrid - 1), 0);

            for (int vRow1 = 0; vRow1 < vCountRowGrid; vRow1++)
            {
                vCountExist = 0;
                vObject = isGridAdvEx5.GetCellValue(vRow1, 0);
                vStringFROM = ConvertString(vObject);

                for (int vRow2 = 0; vRow2 < vCountRowGrid; vRow2++)
                {
                    vObject = isGridAdvEx7.GetCellValue(vRow2, 0);
                    vStringTO = ConvertString(vObject);
                    if (vStringFROM == vStringTO)
                    {
                        vCountExist++;
                    }
                }

                if (vCountExist == 0)
                {
                    idaUSER_PRG_AUTHOR_COPY.AddUnder();
                    vCurrentRowGrid = idaUSER_PRG_AUTHOR_COPY.OraSelectData.Rows.IndexOf(idaUSER_PRG_AUTHOR_COPY.CurrentRow);
                    for (int vCol = 0; vCol < vCountColGrid; vCol++)
                    {
                        vObject = isGridAdvEx5.GetCellValue(vRow1, vCol);
                        isGridAdvEx7.SetCellValue(vCurrentRowGrid, vCol, vObject);
                    }

                    vObject = isEditAdv802.EditValue;
                    isGridAdvEx7.SetCellValue(vCurrentRowGrid, 5, vObject);
                }
            }
            idaUSER_PRG_AUTHOR_COPY.Update();
            idaUSER_PRG_AUTHOR_COPY.Fill();

            mIsSearch = false;
            mIsExistResponsibility = false;
        }

        #endregion;

        #endregion;

        #region ----- Responsibility Fill View -----

        private void ilaRESPONSIBILITY2_SelectedRowData(object pSender)
        {
            try
            {
                //isGridAdvEx1에 포커스가 한번이라도 가지 않고, 아래 아답터를 채우면, 넘겨진 파라미터에 null도 아닌 문자가 넘어가 에러 발생
                idaUSER_RESPONSIBLE.Fill();
                idaUSER_PRG_AUTHOR.Fill();
            }
            catch(System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void ilaPROGRAM2_SelectedRowData(object pSender)
        {
            try
            {
                idaUSER_PRG_AUTHOR.Fill();
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        #endregion;

        #region ----- ReFill Method -----

        private void ReFill1()
        {
            isEditAdv502.EditValue = null;
            isEditAdv503.EditValue = null;

            int vIndexRow = isGridAdvEx1.RowIndex;
            int vIndexColumn = isGridAdvEx1.ColIndex;

            SearchFromDataAdapter();

            isGridAdvEx1.CurrentCellMoveTo(vIndexRow, vIndexColumn);
            isGridAdvEx1.Focus();
            isGridAdvEx1.CurrentCellActivate(vIndexRow, vIndexColumn);
        }

        private void ReFill2()
        {
            isEditAdv602.EditValue = null;
            isEditAdv603.EditValue = null;

            int vIndexRow = isGridAdvEx1.RowIndex;
            int vIndexColumn = isGridAdvEx1.ColIndex;

            SearchFromDataAdapter();

            isGridAdvEx1.CurrentCellMoveTo(vIndexRow, vIndexColumn);
            isGridAdvEx1.Focus();
            isGridAdvEx1.CurrentCellActivate(vIndexRow, vIndexColumn);
        }

        private void ReFill3()
        {
            mIsRows = false;
            mIsAppend = false;
            mIsSearch = false;
            mIsExistResponsibility = false;

            isEditAdv902.EditValue = null;
            isEditAdv903.EditValue = null;
            
            isEditAdv912.EditValue = null;
            isEditAdv913.EditValue = null;
            
            isEditAdv801.EditValue = null;
            isEditAdv802.EditValue = null;

            isAppInterfaceAdv1.OnAppMessage("");

            isGridAdvEx6.RowCount = 0;
            isGridAdvEx7.RowCount = 0;

            idaUSER_RESPONSIBLE_VIEW.Fill();
            idaUSER_PRG_AUTHOR_VIEW.Fill();

            int vCountRow1 = idaUSER_RESPONSIBLE_VIEW.OraSelectData.Rows.Count;

            if (vCountRow1 == 1)
            {
                bool IsExistSame = ResponsibilityExistSame();
                if (IsExistSame != true)
                {
                    mIsAppend = true;
                }
            }
        }

        private void ReFill4()
        {
            mIsRows = false;
            mIsAppend = false;
            mIsSearch = false;
            mIsExistResponsibility = false;

            isEditAdv911.EditValue = null;
            isEditAdv912.EditValue = null;
            isEditAdv913.EditValue = null;

            isEditAdv801.EditValue = null;
            isEditAdv802.EditValue = null;

            isAppInterfaceAdv1.OnAppMessage("");

            isGridAdvEx6.RowCount = 0;
            isGridAdvEx7.RowCount = 0;

            idaUSER_RESPONSIBLE_VIEW.Fill();
            idaUSER_PRG_AUTHOR_VIEW.Fill();

            int vCountRow1 = idaUSER_RESPONSIBLE_VIEW.OraSelectData.Rows.Count;

            if (vCountRow1 == 1)
            {
                bool IsExistSame = ResponsibilityExistSame();
                if (IsExistSame != true)
                {
                    mIsAppend = true;
                }
            }
        }

        private void ReFill5()
        {
            idaUSER_RESPONSIBLE_COPY.Fill();
            idaUSER_PRG_AUTHOR_COPY.Fill();
        }

        private void ReFill6()
        {
            isEditAdv912.EditValue = null;
            isEditAdv913.EditValue = null;

            idaUSER_RESPONSIBLE_COPY.Fill();
            idaUSER_PRG_AUTHOR_COPY.Fill();
        }

        private void ReFill7()
        {
            isEditAdv911.EditValue = isEditAdv901.EditValue;
            isEditAdv912.EditValue = isEditAdv902.EditValue;
            isEditAdv913.EditValue = isEditAdv903.EditValue;

            idaUSER_RESPONSIBLE_COPY.Fill();
            idaUSER_PRG_AUTHOR_COPY.Fill();

            System.Windows.Forms.Application.DoEvents();
        }

        #endregion;

        #region ----- Key Down Event -----

        private void isEditAdv501_KeyDown(object pSender, KeyEventArgs e)
        {
            switch (e.KeyCode)
            {
                case Keys.Back:
                    ReFill1();
                    break;
                default:
                    break;
            }
        }

        private void isEditAdv601_KeyDown(object pSender, KeyEventArgs e)
        {
            switch (e.KeyCode)
            {
                case Keys.Back:
                    ReFill2();
                    break;
                default:
                    break;
            }
        }

        private void isEditAdv901_KeyDown(object pSender, KeyEventArgs e)
        {
            switch (e.KeyCode)
            {
                case Keys.Back:
                    ReFill3();
                    break;
                default:
                    break;
            }
        }

        private void isEditAdv911_KeyDown(object pSender, KeyEventArgs e)
        {
            switch (e.KeyCode)
            {
                case Keys.Back:
                    ReFill6();
                    break;
                default:
                    break;
            }
        }

        #endregion;

        #region ----- Main Tool Bar Button -----

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    int vIndexRow = isGridAdvEx1.RowIndex;
                    int vIndexColumn = isGridAdvEx1.ColIndex;

                    SearchFromDataAdapter();

                    int vCountRow = isGridAdvEx1.RowCount;
                    if (vCountRow == 1)
                    {
                        vIndexRow = 1;
                    }

                    isGridAdvEx1.CurrentCellMoveTo(vIndexRow, vIndexColumn);
                    isGridAdvEx1.Focus();
                    isGridAdvEx1.CurrentCellActivate(vIndexRow, vIndexColumn);

                    int vIndexTab2 = isTabAdv2.SelectedIndex;
                    int vIndexTab1 = isTabAdv1.SelectedIndex;
                    if (vIndexTab2 == 0)
                    {
                        if (vIndexTab1 == 0)
                        {
                            idaUSER_RESPONSIBLE_VIEW.Fill();
                        }
                        else if (vIndexTab1 == 1)
                        {
                            idaUSER_PRG_AUTHOR_VIEW.Fill();
                        }
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    if (isDataAdapter1.IsFocused == true)
                    {
                        isDataAdapter1.AddOver();

                        DefaultSetCheckBox2();
                        DefaultSetDateTime1();
                        isRadioButtonAdv1.Checked = true;
                    }
                    else if (idaUSER_RESPONSIBLE.IsFocused == true)
                    {
                        idaUSER_RESPONSIBLE.AddOver();

                        DefaultSetDateTime2();
                        DefaultSetCheckBox();
                    }
                    else if (idaUSER_PRG_AUTHOR.IsFocused == true)
                    {
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (isDataAdapter1.IsFocused == true)
                    {
                        isDataAdapter1.AddUnder();

                        DefaultSetCheckBox2();
                        DefaultSetDateTime1();
                        isRadioButtonAdv1.Checked = true;
                    }
                    else if (idaUSER_RESPONSIBLE.IsFocused == true)
                    {
                        idaUSER_RESPONSIBLE.AddUnder();

                        DefaultSetDateTime2();
                        DefaultSetCheckBox();
                    }
                    else if (idaUSER_PRG_AUTHOR.IsFocused == true)
                    {
                    }
                }
                ////[FilterBase]
                //else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                //{
                //    if (isDataAdapter1.IsFocused == true || idaUSER_RESPONSIBLE.IsFocused == true)
                //    {
                //        bool IsAble = IsUserSelect(isEditAdv104, isEditAdv105);
                //        if (IsAble == false)
                //        {
                //            string vMessageGet = isMessageAdapter1.ReturnText("EAPP_10037"); //사용자를 선택 하세요!
                //            string vMessageString = string.Format("{0}", vMessageGet);
                //            MessageBoxAdv.Show(vMessageString, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                //            return;
                //        }

                //        //IsAble = ValidatingDate4(isGridAdvEx2);
                //        //if (IsAble == false)
                //        //{
                //        //    isGridAdvEx2.CurrentCellMoveTo(2);
                //        //    isGridAdvEx2.Focus();
                //        //    isGridAdvEx2.CurrentCellActivate(2);

                //        //    return;
                //        //}

                //        object vAuthorityType = vAuthorityType = "S";

                //        isDataAdapter1.SetInsertParamValue("P_USER_TYPE", mRadioValue_2_Insert);
                //        isDataAdapter1.SetInsertParamValue("P_AUTHORITY_TYPE", vAuthorityType);

                //        //-----------------------------------------------------------

                //        isDataAdapter1.SetUpdateParamValue("P_USER_TYPE", mRadioValue_2_Insert);
                //        isDataAdapter1.SetUpdateParamValue("P_AUTHORITY_TYPE", vAuthorityType);

                //        isDataAdapter1.Update();
                //    }
                //    else if (idaUSER_PRG_AUTHOR.IsFocused == true)
                //    {
                //        idaUSER_PRG_AUTHOR.Update();
                //    }
                //}

                //[QueryBase]
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (isDataAdapter1.IsFocused == true)
                    {
                        bool IsAble = IsUserSelect(isEditAdv104, isEditAdv105);
                        if (IsAble == false)
                        {
                            string vMessageGet = isMessageAdapter1.ReturnText("EAPP_10037"); //사용자를 선택 하세요!
                            string vMessageString = string.Format("{0}", vMessageGet);
                            MessageBoxAdv.Show(vMessageString, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                            return;
                        }

                        object vAuthorityType = vAuthorityType = "S";

                        isDataAdapter1.SetInsertParamValue("P_USER_TYPE", mRadioValue_2_Insert);
                        isDataAdapter1.SetInsertParamValue("P_AUTHORITY_TYPE", vAuthorityType);

                        //-----------------------------------------------------------

                        isDataAdapter1.SetUpdateParamValue("P_USER_TYPE", mRadioValue_2_Insert);
                        isDataAdapter1.SetUpdateParamValue("P_AUTHORITY_TYPE", vAuthorityType);
                        isDataAdapter1.Update();
                    }
                    else if (idaUSER_RESPONSIBLE.IsFocused == true)
                    {
                        bool IsAble = ValidatingDate4(isGridAdvEx2);
                        if (IsAble == false)
                        {
                            isGridAdvEx2.CurrentCellMoveTo(3);
                            isGridAdvEx2.Focus();
                            isGridAdvEx2.CurrentCellActivate(3);

                            return;
                        }
                        idaUSER_RESPONSIBLE.Update();

                        //권한 수정/추가 후, 프로그램 권한을 줄려고 할때
                        //어셈블리 목록이 보이지 않아
                        //isDataAdapter1을 강제로 Fill 시켜
                        //어셈블리 목록이 보이도록 한다.
                        int vIndexRow = isGridAdvEx1.RowIndex;
                        int vIndexColumn = isGridAdvEx1.ColIndex;
                        isDataAdapter1.Fill();
                        isGridAdvEx1.CurrentCellMoveTo(vIndexRow, vIndexColumn);
                        isGridAdvEx1.Focus();
                        isGridAdvEx1.CurrentCellActivate(vIndexRow, vIndexColumn);
                    }
                    else if (idaUSER_PRG_AUTHOR.IsFocused == true)
                    {
                        idaUSER_PRG_AUTHOR.Update();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (isDataAdapter1.IsFocused == true)
                    {
                        isDataAdapter1.Cancel();
                    }
                    else if (idaUSER_RESPONSIBLE.IsFocused == true)
                    {
                        idaUSER_RESPONSIBLE.Cancel();
                    }
                    else if (idaUSER_PRG_AUTHOR.IsFocused == true)
                    {
                        idaUSER_PRG_AUTHOR.Cancel();
                    }
                    else if (idaUSER_RESPONSIBLE_COPY.IsFocused == true)
                    {
                        idaUSER_RESPONSIBLE_COPY.Cancel();
                    }
                    else if (idaUSER_PRG_AUTHOR_COPY.IsFocused == true)
                    {
                        idaUSER_PRG_AUTHOR_COPY.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (isDataAdapter1.IsFocused == true)
                    {
                        bool IsAble = IsAbleToNewAdded(isDataAdapter1);
                        if (IsAble == false)
                        {
                            string vMessageGet = isMessageAdapter1.ReturnText("EAPP_10013"); //삭제할 수 없습니다!
                            string vMessageString = string.Format("{0}", vMessageGet);
                            MessageBoxAdv.Show(vMessageString, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                            return;
                        }

                        isDataAdapter1.Delete();
                    }
                    else if (idaUSER_RESPONSIBLE.IsFocused == true)
                    {
                        //bool IsAble = IsAbleToNewAdded(idaUSER_RESPONSIBLE);
                        //if (IsAble == false)
                        //{
                        //    string vMessageGet = isMessageAdapter1.ReturnText("EAPP_10013"); //삭제할 수 없습니다!
                        //    string vMessageString = string.Format("{0}", vMessageGet);
                        //    MessageBoxAdv.Show(vMessageString, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        //    return;
                        //}

                        idaUSER_RESPONSIBLE.Delete();
                    }
                    else if (idaUSER_PRG_AUTHOR.IsFocused == true)
                    {
                        bool IsAble = IsAbleToNewAdded(idaUSER_PRG_AUTHOR);
                        if (IsAble == false)
                        {
                            string vMessageGet = isMessageAdapter1.ReturnText("EAPP_10013"); //삭제할 수 없습니다!
                            string vMessageString = string.Format("{0}", vMessageGet);
                            MessageBoxAdv.Show(vMessageString, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                            return;
                        }

                        idaUSER_PRG_AUTHOR.Delete();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {
                    string vMessageText = string.Format("{0}\nUser : {1} | Person : {2}\n{3} | {4}  | {5} | {6} | {7} | {8}", isAppInterfaceAdv1.AppInterface.LoginNo, isAppInterfaceAdv1.AppInterface.UserId, isAppInterfaceAdv1.AppInterface.PersonId, isAppInterfaceAdv1.AppInterface.DisplayName, isAppInterfaceAdv1.AppInterface.DeptName, isAppInterfaceAdv1.AppInterface.LoginDate, isAppInterfaceAdv1.AppInterface.LoginDescription, isAppInterfaceAdv1.AppInterface.DeptId, isAppInterfaceAdv1.AppInterface.DeptName);
                    MessageBoxAdv.Show(vMessageText);
                }
            }
        }

        #endregion;

        private void BTN_SET_TRY_LOGIN_CNT_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10067"), "Question", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.No)
            {
                return;
            }

            IDC_SET_TRY_LOGIN_CNT.ExecuteNonQuery();
            string vSTATUS = iConv.ISNull(IDC_SET_TRY_LOGIN_CNT.GetCommandParamValue("O_STATUS"));
            string vMESSAGE = iConv.ISNull(IDC_SET_TRY_LOGIN_CNT.GetCommandParamValue("O_MESSAGE"));
            if (vSTATUS == "F")
            {
                if (vMESSAGE != string.Empty)
                {
                    MessageBoxAdv.Show(vMESSAGE, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
                return;
            }
            if (vMESSAGE != string.Empty)
            {
                MessageBoxAdv.Show(vMESSAGE, "Information", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }

            IDC_GET_TRY_LOGIN_CNT.ExecuteNonQuery();
        }
    }
}