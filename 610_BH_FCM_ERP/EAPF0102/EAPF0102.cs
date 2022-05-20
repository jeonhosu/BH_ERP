using System;
using System.Windows.Forms;

using Syncfusion.Windows.Forms;
using InfoSummit.Win.ControlAdv;

namespace EAPF0102
{
    public partial class EAPF0102 : Office2007Form
    {
        #region ----- Variables -----

        private int mGridCurrentCellValidatingCount = 0;

        #endregion;

        #region ----- Constructor -----

        public EAPF0102()
        {
            InitializeComponent();
        }

        public EAPF0102(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();

            this.MdiParent = pMainForm;

            isAppInterfaceAdv1.AppInterface = pAppInterface;
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

        private void GridCurrentCellValidating(ISGridAdvExValidatingEventArgs e)
        {
            string vColumnType = "TextEdit";
            string vDataColumn = "ORG_CODE";
            int vIndexColumn = GetIndexISGridAdvExColElement(isGridAdvEx1.GridAdvExColElement, vColumnType, vDataColumn);

            if (e.ColIndex == vIndexColumn)
            {
                string vMessageString = string.Empty;
                string vText = e.NewValue.ToString();
                bool vIsNull = string.IsNullOrEmpty(vText);
                if (vIsNull == true)
                {
                    e.Cancel = true;

                    vMessageString = string.Format("{0}", isMessageAdapter1.ReturnText("EAPP_90002"));
                    MessageBoxAdv.Show(vMessageString, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                }
                else
                {
                    bool vIsNumAlpha = IsNumAlpha(vText);
                    if (vIsNumAlpha == false)
                    {
                        e.Cancel = true;

                        if (mGridCurrentCellValidatingCount == 1)
                        {
                            vMessageString = string.Format("[{0}]{1}", vText, isMessageAdapter1.ReturnText("EAPP_10012"));
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

        private bool IsNumAlpha(string vText)
        {
            bool vIsNumAlpha = false;
            int vCountNum = 0;
            int vCountChar = 0;
            int vLenght = vText.Length;
            char[] vChars = vText.ToCharArray();

            for (int vCol = 0; vCol < vLenght; vCol++)
            {
                bool isAlpha = char.IsUpper(vChars[vCol]);
                if (isAlpha == true)
                {
                    vCountChar++;
                }
                bool isNumber = char.IsNumber(vChars[vCol]);
                if (isNumber == true)
                {
                    vCountNum++;
                }
            }

            if (vCountChar > 0 && vCountNum > 0)
            {
                vIsNumAlpha = true;
            }

            return vIsNumAlpha;
        }

        #endregion;

        #region ----- Events -----

        private void EAPF0102_Load(object sender, EventArgs e)
        {
            DefaultSetFormReSize();

            isDataAdapter1.FillSchema();
        }

        private void isGridAdvEx1_CurrentCellValidating(object pSender, ISGridAdvExValidatingEventArgs e)
        {
            GridCurrentCellValidating(e);
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
                    isDataAdapter1.AddOver();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    isDataAdapter1.AddUnder();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (isDataAdapter1.IsFocused == true)
                    {
                        isDataAdapter1.Update();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    isDataAdapter1.Cancel();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {
                }
            }
        }

        #endregion;
    }
}
