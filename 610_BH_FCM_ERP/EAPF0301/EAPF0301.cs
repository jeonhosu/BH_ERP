using System;
using System.Windows.Forms;

using Syncfusion.Windows.Forms;
using InfoSummit.Win.ControlAdv;

namespace EAPF0301
{
    public partial class EAPF0301 : Office2007Form
    {
        #region ----- Variables -----

        private int mGridCurrentCellValidatingCount = 0;
        private object mRadioValue = null;

        #endregion;

        #region ----- Constructor -----

        public EAPF0301()
        {
            InitializeComponent();
        }

        public EAPF0301(Form pMainForm, ISAppInterface pAppInterface)
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

        #region ----- Private Methods ----

        private void SearchFromDataAdapter()
        {
            isDataAdapter1.SetSelectParamValue("W_USER_TYPE", mRadioValue);

            isDataAdapter1.Fill();
        }

        private void DefaultSetFormReSize()
        {
            int vMinusWidth = 4;
            int vMinusHeight = 54;
            System.Drawing.Size vSize = this.MdiParent.ClientSize;
            this.Width = vSize.Width - vMinusWidth;
            this.Height = vSize.Height - vMinusHeight;
        }

        private void DefaultSetDateTime1()
        {
            DateTime vGetDateTime = GetDateTime();

            ISCommonUtil.ISFunction.ISDateTime vDate = new ISCommonUtil.ISFunction.ISDateTime();
            DateTime vMonthFirstDay = vDate.ISMonth_1st(vGetDateTime);

            isEditAdv11.EditValue = vMonthFirstDay;
        }

        private void DefaultSetDateTime2()
        {
            DateTime vGetDateTime = GetDateTime();

            ISCommonUtil.ISFunction.ISDateTime vDate = new ISCommonUtil.ISFunction.ISDateTime();
            DateTime vMonthFirstDay = vDate.ISMonth_1st(vGetDateTime);

            isGridAdvEx2.SetCellValue("EFFECTIVE_DATE_FR", vMonthFirstDay);
        }

        private void DefaultSetCheckBox()
        {
            object vCheckBox = "Y";

            isGridAdvEx2.SetCellValue("ENABLED_FLAG", vCheckBox);
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

        private void ValidatingDate1(ISEditAdv pEditAdv, ISEditAdvValidatingEventArgs e)
        {
            DateTime vDateFrom = pEditAdv.DateTimeValue;
            DateTime vDateTo = (DateTime)e.EditValue;

            if (vDateFrom > vDateTo)
            {
                string vMessageString = string.Format("[{0}]~[{1}]\n{2}", vDateFrom, vDateTo, isMessageAdapter1.ReturnText("FCM_10012"));
                MessageBoxAdv.Show(vMessageString, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);

                e.Cancel = true;
            }
        }

        private void ValidatingDate2(object pSender, ISGridAdvExValidatingEventArgs e)
        {
            int vColIndex_DateFrom = idaUSER_RESPONSIBLE.OraSelectData.Columns.IndexOf("EFFECTIVE_DATE_FR"); //유효시작일
            int vColIndex_DateTo = idaUSER_RESPONSIBLE.OraSelectData.Columns.IndexOf("EFFECTIVE_DATE_TO");   //유효종료일

            if (e.ColIndex == vColIndex_DateTo)
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

                            if (mGridCurrentCellValidatingCount == 1)
                            {
                                string vMessageString = string.Format("[{0}]~[{1}]\n{2}", vDateFrom, vDateTo, isMessageAdapter1.ReturnText("FCM_10012"));
                                MessageBoxAdv.Show(vMessageString, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);

                                mGridCurrentCellValidatingCount = 0;
                            }
                            else
                            {
                                mGridCurrentCellValidatingCount++;
                            }
                        }
                    }
                }
            }
        }

        private void GridView(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, InfoSummit.Win.ControlAdv.ISDataAdapter pAdapter)
        {
            pGrid.RowCount = pAdapter.OraSelectData.Rows.Count + 1;
            pGrid.ColCount = pAdapter.OraSelectData.Columns.Count;

            foreach (System.Data.DataColumn vCol in pAdapter.OraSelectData.Columns)
            {
                int vColIndex = pAdapter.OraSelectData.Columns.IndexOf(vCol);
                pGrid.SetCellValue(0, vColIndex, vCol.ColumnName);
            }

            foreach (System.Data.DataRow vRow in pAdapter.OraSelectData.Rows)
            {
                foreach (System.Data.DataColumn vCol in pAdapter.OraSelectData.Columns)
                {
                    int vRowIndex = vRow.Table.Rows.IndexOf(vRow);
                    int vColIndex = vRow.Table.Columns.IndexOf(vCol);

                    pGrid.SetCellValue((vRowIndex + 1), vColIndex, vRow[vCol]);
                }
            }
        }

        #endregion;

        #region ----- Events -----

        private void EAPF0301_Load(object sender, EventArgs e)
        {
            //DefaultSetFormReSize();

            isDataAdapter1.FillSchema();

            idaUSER_RESPONSIBLE.FillSchema();
        }

        private void isRadioButtonAdv_CheckChanged(object sender, EventArgs e)
        {
            ISRadioButtonAdv vRadio = sender as ISRadioButtonAdv;

            if (vRadio.Checked == true)
            {
                mRadioValue = vRadio.RadioCheckedString;
            }
        }

        private void isEditAdv12_CurrentEditValidating(object pSender, ISEditAdvValidatingEventArgs e)
        {
            ValidatingDate1(isEditAdv11, e);
        }

        private void isGridAdvEx2_CurrentCellValidating(object pSender, ISGridAdvExValidatingEventArgs e)
        {
            ValidatingDate2(pSender, e);
        }

        private void isDataAdapter1_NewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            idaUSER_RESPONSIBLE.Fill();

            idaUSER_PRG_AUTHOR.Fill();
        }

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    SearchFromDataAdapter();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    if (isDataAdapter1.IsFocused == true)
                    {
                        isDataAdapter1.AddOver();

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
                        idaUSER_PRG_AUTHOR.AddOver();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (isDataAdapter1.IsFocused == true)
                    {
                        isDataAdapter1.AddUnder();

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
                        idaUSER_PRG_AUTHOR.AddUnder();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (isDataAdapter1.IsFocused == true)
                    {
                        object vAuthorityType = vAuthorityType = "S";

                        isDataAdapter1.SetInsertParamValue("P_AUTHORITY_TYPE", vAuthorityType);

                        //-----------------------------------------------------------

                        isDataAdapter1.SetUpdateParamValue("P_AUTHORITY_TYPE", vAuthorityType);

                        isDataAdapter1.Update();
                    }
                    else if (idaUSER_RESPONSIBLE.IsFocused == true)
                    {
                        idaUSER_RESPONSIBLE.Update();
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
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (isDataAdapter1.IsFocused == true)
                    {
                        bool IsAble = IsAbleToNewAdded(isDataAdapter1);
                        if (IsAble == false)
                        {
                            string vMessageString = string.Format("{0}", isMessageAdapter1.ReturnText("EAPP_10013"));
                            MessageBoxAdv.Show(vMessageString, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                            return;
                        }

                        isDataAdapter1.Delete();
                    }
                    else if (idaUSER_RESPONSIBLE.IsFocused == true)
                    {
                        bool IsAble = IsAbleToNewAdded(idaUSER_RESPONSIBLE);
                        if (IsAble == false)
                        {
                            string vMessageString = string.Format("{0}", isMessageAdapter1.ReturnText("EAPP_10013"));
                            MessageBoxAdv.Show(vMessageString, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                            return;
                        }

                        idaUSER_RESPONSIBLE.Delete();
                    }
                    else if (idaUSER_PRG_AUTHOR.IsFocused == true)
                    {
                        bool IsAble = IsAbleToNewAdded(idaUSER_PRG_AUTHOR);
                        if (IsAble == false)
                        {
                            string vMessageString = string.Format("{0}", isMessageAdapter1.ReturnText("EAPP_10013"));
                            MessageBoxAdv.Show(vMessageString, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                            return;
                        }

                        idaUSER_PRG_AUTHOR.Delete();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {
                    //GridView(isGridAdvEx4, isDataAdapter3);
                }
            }
        }

        #endregion;
    }
}