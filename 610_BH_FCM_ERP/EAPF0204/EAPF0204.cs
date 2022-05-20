using System;
using System.Windows.Forms;

using Syncfusion.Windows.Forms;
using InfoSummit.Win.ControlAdv;

namespace EAPF0204
{
    public partial class EAPF0204 : Office2007Form
    {
        #region ----- Variables -----

        private int mGridCurrentCellValidatingCount = 0;

        #endregion;

        #region ----- Constructor -----

        public EAPF0204()
        {
            InitializeComponent();
        }

        public EAPF0204(Form pMainForm, ISAppInterface pAppInterface)
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
            //ISCommonUtil.ISFunction.ISDateTime vDate = new ISCommonUtil.ISFunction.ISDateTime();
            //DateTime vMonthFirstDay = vDate.ISMonth_1st(DateTime.Today);

            //isGridAdvEx2.SetCellValue("EFFECTIVE_DATE_FR", vMonthFirstDay);

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

        private void ValidatingDate(object pSender, ISGridAdvExValidatingEventArgs e)
        {
            int vColIndex_DateFrom = idaLOOKUP_ENTRY.OraSelectData.Columns.IndexOf("EFFECTIVE_DATE_FR"); //유효시작일
            int vColIndex_DateTo = idaLOOKUP_ENTRY.OraSelectData.Columns.IndexOf("EFFECTIVE_DATE_TO");   //유효종료일

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

        private int GetIndexISGridAdvExColElement(ISGenericCollection<ISGridAdvExColElement> pGridAdvExColElement, string pColumnType, string pDataColumn)
        {
            int vIndex = 0;
            string vColumnType = string.Empty;
            string vDataColumn = string.Empty;

            foreach (ISGridAdvExColElement ce in pGridAdvExColElement)
            {
                vColumnType = ce.ColumnType.ToString();
                vDataColumn = ce.DataColumn.ToString();
                

                if (vColumnType == pColumnType && vDataColumn == pDataColumn)
                {
                    vIndex = int.Parse(ce.Ordinal.ToString());
                }
            }

            return vIndex;
        }

        private void DefaultSetting(object pSender, int pRowIndex, int pColIndex, string pCheckedString, string pUnCheckedString)
        {
            ISGridAdvEx vGridAdvEx = pSender as ISGridAdvEx;

            object vObject = null;
            string vGetValue = string.Empty;
            int vRowCount = vGridAdvEx.RowCount;
            for (int vRow = 0; vRow < vRowCount; vRow++)
            {
                if (vGridAdvEx.GetCellValue(vRow, pColIndex) != null)
                {
                    Type vType = vGridAdvEx.GetCellValue(vRow, pColIndex).GetType();
                    bool isNull1 = vType == Type.GetType("System.DBNull") ? true : false;
                    if (isNull1 == false)
                    {
                        vGetValue = vGridAdvEx.GetCellValue(vRow, pColIndex).ToString();
                        bool isNull2 = string.IsNullOrEmpty(vGetValue);
                        if (isNull2 == false)
                        {
                            vObject = pUnCheckedString as object;
                            vGridAdvEx.SetCellValue(vRow, pColIndex, vObject);
                            idaLOOKUP_ENTRY.OraSelectData.Rows[vRow][pColIndex] = vObject;
                        }
                    }
                }
            }
        }

        private void CellMovedGrid(object pSender, ISGridAdvExCellClickEventArgs e)
        {
            ISGridAdvEx vGridAdvEx = pSender as ISGridAdvEx;

            int vColIndex = idaLOOKUP_ENTRY.OraSelectData.Columns.IndexOf("DEFAULT_FLAG"); //Default Column
            if (e.ColIndex == vColIndex)
            {
                string vColumnType = "CheckBox";
                string vDataColumn = "DEFAULT_FLAG";
                int vIndexCollection = GetIndexISGridAdvExColElement(vGridAdvEx.GridAdvExColElement, vColumnType, vDataColumn);
                string vCheckedString = ((ISGridAdvExColElement)vGridAdvEx.GridAdvExColElement[vIndexCollection]).CheckedString;
                string vUnCheckedString = ((ISGridAdvExColElement)vGridAdvEx.GridAdvExColElement[vIndexCollection]).UncheckedString;

                DefaultSetting(pSender, e.RowIndex, vColIndex, vCheckedString, vUnCheckedString);
            }
        }

        #endregion;

        #region ----- Events -----

        private void EAPF0204_Load(object sender, EventArgs e)
        {
            //DefaultSetFormReSize();

            try
            {
                isDataAdapter1.FillSchema();
            }
            catch (Exception ex)
            {
                string vMessage = ex.Message;

                isOraConnection1.Open();

                isDataAdapter1.FillSchema();
            }
        }

        private void isGridAdvEx2_CurrentCellValidating(object pSender, ISGridAdvExValidatingEventArgs e)
        {
            ValidatingDate(pSender, e);
        }

        private void isGridAdvEx2_CellMoved(object pSender, ISGridAdvExCellClickEventArgs e)
        {
            CellMovedGrid(pSender, e);
        }

        private void isDataAdapter2_NewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            idaLOOKUP_ENTRY.Fill();
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

                        isRadioButtonAdv2.Checked = true;
                    }
                    else if (idaLOOKUP_ENTRY.IsFocused == true)
                    {
                        idaLOOKUP_ENTRY.AddOver();

                        DefaultSetDateTime1();
                        DefaultSetCheckBox();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (isDataAdapter1.IsFocused == true)
                    {
                        isDataAdapter1.AddUnder();

                        isRadioButtonAdv2.Checked = true;
                    }
                    else if (idaLOOKUP_ENTRY.IsFocused == true)
                    {
                        idaLOOKUP_ENTRY.AddUnder();

                        DefaultSetDateTime1();
                        DefaultSetCheckBox();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    object vLevel = string.Empty;

                    if (isDataAdapter1.IsFocused == true)
                    {
                        isDataAdapter1.Update();
                    }
                    else if (idaLOOKUP_ENTRY.IsFocused == true)
                    {
                        idaLOOKUP_ENTRY.Update();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (isDataAdapter1.IsFocused == true)
                    {
                        isDataAdapter1.Cancel();
                    }
                    else if (idaLOOKUP_ENTRY.IsFocused == true)
                    {
                        idaLOOKUP_ENTRY.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (isDataAdapter1.IsFocused == true)
                    {
                        isDataAdapter1.Delete();
                    }
                    else if (idaLOOKUP_ENTRY.IsFocused == true)
                    {
                        idaLOOKUP_ENTRY.Delete();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {
                }
            }
        }

        #endregion;
    }
}