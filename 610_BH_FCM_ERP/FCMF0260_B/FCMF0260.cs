using System;
using System.Data;
using System.Drawing;
using System.Windows.Forms;
using System.Collections.Generic;

using Syncfusion.Windows.Forms;
using Syncfusion.Windows.Forms.Tools;
using Syncfusion.Windows.Forms.Grid;
using InfoSummit.Win.ControlAdv;

namespace FCMF0260
{
    public partial class FCMF0260 : Office2007Form
    {
        #region ----- Variables -----



        #endregion;

        #region ----- Constructor -----

        public FCMF0260()
        {
            InitializeComponent();
        }

        public FCMF0260(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;

            //int vCountRow = ((ISGridAdvEx)(pObject)).RowCount;
            //((mdiMMPS52)(this.MdiParent)).StatusSTRIP_Form_Open_iF_Value.Text = "0";
            //(()(this.MdiParent)).

            //System.Type vType = this.MdiParent.GetType();
            //object vO1 = Convert.ChangeType(pMainForm, System.Type.GetType(vType.FullName));
            string vPathReport = string.Empty;
            object vObject = this.MdiParent.Tag;
            if (vObject != null)
            {
                bool isConvert = vObject is string;
                if (isConvert == true)
                {
                    vPathReport = vObject as string;
                }
            }
        }

        #endregion;

        #region ----- Private Methods ----

        private void SearchFromDataAdapter()
        {
            isDataAdapter1.Fill();
        }

        private DateTime GetDate()
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

        private void DefaultSetDate1()
        {
            DateTime vGetDateTime = GetDate();

            ISCommonUtil.ISFunction.ISDateTime vDate = new ISCommonUtil.ISFunction.ISDateTime();
            DateTime vMonthFirstDay = vDate.ISMonth_1st(vGetDateTime);

            GL_DATE_FR_0.EditValue = vMonthFirstDay;
            GL_DATE_TO_0.EditValue = vGetDateTime;
        }

        #endregion;

        #region ----- XL Export Methods ----

        private void ExportXL(ISDataAdapter pAdapter)
        {
            int vCountRow = pAdapter.OraSelectData.Rows.Count;
            if (vCountRow < 1)
            {
                return;
            }

            string vsMessage = string.Empty;
            string vsSheetName = "Slip_Line";

            saveFileDialog1.Title = "Excel_Save";
            saveFileDialog1.FileName = "XL_00";
            saveFileDialog1.DefaultExt = "xls";
            System.IO.DirectoryInfo vSaveFolder = new System.IO.DirectoryInfo(System.Environment.GetFolderPath(Environment.SpecialFolder.Desktop));
            saveFileDialog1.InitialDirectory = vSaveFolder.FullName;
            saveFileDialog1.Filter = "Excel Files (*.xls)|*.xls";
            if (saveFileDialog1.ShowDialog() == System.Windows.Forms.DialogResult.OK)
            {
                string vsSaveExcelFileName = saveFileDialog1.FileName;
                XL.XLPrint xlExport = new XL.XLPrint();
                bool vXLSaveOK = xlExport.XLExport(pAdapter.OraSelectData, vsSaveExcelFileName, vsSheetName);
                if (vXLSaveOK == true)
                {
                    vsMessage = string.Format("Save OK [{0}]", vsSaveExcelFileName);
                    MessageBoxAdv.Show(vsMessage);
                }
                else
                {
                    vsMessage = string.Format("Save Err [{0}]", vsSaveExcelFileName);
                    MessageBoxAdv.Show(vsMessage);
                }
                xlExport.XLClose();
            }
        }

        #endregion;

        #region ----- Territory Get Methods ----

        private int GetTerritory(ISUtil.Enum.TerritoryLanguage pTerritoryEnum)
        {
            int vTerritory = 0;

            switch (pTerritoryEnum)
            {
                case ISUtil.Enum.TerritoryLanguage.Default:
                    vTerritory = 1;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL1_KR:
                    vTerritory = 2;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL2_CN:
                    vTerritory = 3;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL3_VN:
                    vTerritory = 4;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL4_JP:
                    vTerritory = 5;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL5_XAA:
                    vTerritory = 6;
                    break;
            }

            return vTerritory;
        }

        #endregion;

        #region ----- XL Print 1 Methods ----

        private void XLPrinting1()
        {
            int vPageNumber = 0;
            string vMessageText = string.Empty;

            int vCountRowGrid = igrDAILY.RowCount;
            if (vCountRowGrid > 0)
            {
                System.Windows.Forms.Application.UseWaitCursor = true;
                this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
                System.Windows.Forms.Application.DoEvents();

                vMessageText = string.Format("Printing Starting");
                isAppInterfaceAdv1.OnAppMessage(vMessageText);
                System.Windows.Forms.Application.DoEvents();

                XLPrinting xlPrinting = new XLPrinting();

                try
                {
                    //-------------------------------------------------------------------------
                    xlPrinting.OpenFileNameExcel = "FCMF0260_001.xls";
                    xlPrinting.XLFileOpen();

                    int vTerritory = GetTerritory(igrDAILY.TerritoryLanguage);
                    string vPeriodFrom = GL_DATE_FR_0.DateTimeValue.ToString("yyyy-MM-dd", null);
                    string vPeriodTo = GL_DATE_TO_0.DateTimeValue.ToString("yyyy-MM-dd", null);

                    string vUserName = string.Format("[{0}]{1}", isAppInterfaceAdv1.DEPT_NAME, isAppInterfaceAdv1.DISPLAY_NAME);

                    int viCutStart = this.Text.LastIndexOf("]") + 1;
                    string vCaption = this.Text.Substring(0, viCutStart);
                    vPageNumber = xlPrinting.XLWirte(igrDAILY, vTerritory, vPeriodFrom, vPeriodTo, vUserName, vCaption);


                    ////[PRINT]
                    ////xlPrinting.Printing(3, 4); //시작 페이지 번호, 종료 페이지 번호
                    xlPrinting.Printing(1, vPageNumber);


                    ////[SAVE]
                    //xlPrinting.Save("Final_"); //저장 파일명

                    //xlPrinting.PreView();
                    //-------------------------------------------------------------------------
                }
                catch (System.Exception ex)
                {
                    string vMessage = ex.Message;
                    xlPrinting.Dispose();
                }

                xlPrinting.Dispose();

                vMessageText = string.Format("Print End! [Page : {0}]", vPageNumber);
                isAppInterfaceAdv1.OnAppMessage(vMessageText);
                System.Windows.Forms.Application.DoEvents();

                System.Windows.Forms.Application.UseWaitCursor = false;
                this.Cursor = System.Windows.Forms.Cursors.Default;
                System.Windows.Forms.Application.DoEvents();
            }
        }

        #endregion;

        #region ----- Events -----

        private void FCMF0260_Load(object sender, EventArgs e)
        {
            DefaultSetDate1();
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
                    if (isDataAdapter1.IsFocused)
                    {

                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (isDataAdapter1.IsFocused)
                    {

                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (isDataAdapter1.IsFocused)
                    {

                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (isDataAdapter1.IsFocused)
                    {

                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (isDataAdapter1.IsFocused)
                    {
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {
                    XLPrinting1();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                    ExportXL(isDataAdapter1);
                }
            }
        }

        #endregion;

        private void GL_DATE_FR_0_CurrentEditValidating(object pSender, ISEditAdvValidatingEventArgs e)
        {
            GL_DATE_TO_0.EditValue = GL_DATE_FR_0.EditValue;
        }
    }
}