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

namespace FCMF0209
{
    public partial class FCMF0209 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public FCMF0209()
        {
            InitializeComponent();
        }

        public FCMF0209(Form pMainForm, ISAppInterface pAppInterface)
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

        private void DefaultValue()
        {
            DateTime vGetDate = GetDate();
                        
            GL_DATE_FR_0.EditValue = iDate.ISMonth_1st(vGetDate);
            GL_DATE_TO_0.EditValue = vGetDate;
        }

        private void SEARCH_DB()
        {
            if (iString.ISNull(GL_DATE_FR_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                GL_DATE_FR_0.Focus();
                return;
            }

            if (iString.ISNull(GL_DATE_TO_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                GL_DATE_TO_0.Focus();
                return;
            }

            if (Convert.ToDateTime(GL_DATE_FR_0.EditValue) > Convert.ToDateTime(GL_DATE_TO_0.EditValue))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10012"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                GL_DATE_FR_0.Focus();
                return;
            }

            SET_GRID_COL_VISIBLE();  // 그리드 보이기/감추기 설정.

            Application.DoEvents();
            Application.UseWaitCursor = true;
            this.Cursor = Cursors.WaitCursor;
            

            object mMANAGEMENT_DESC = Get_Management_Desc();
            idaSLIP_MANAGEMENT.SetSelectParamValue("P_MANAGEMENT_DESC", mMANAGEMENT_DESC);
            idaSLIP_MANAGEMENT.Fill();
            igrSLIP_MANAGEMENT.Focus();
            Application.UseWaitCursor = false;
            this.Cursor = Cursors.Default;
        }

        private object Get_Management_Desc()
        {
            object mMANAGEMENT_DESC = null;
            if (iString.ISNull(MANAGEMENT_DESC_0.EditValue) == String.Empty)
            {
                mMANAGEMENT_DESC = null;
            }
            else if (iString.ISNull(DATA_TYPE_0.EditValue) == "DATE")
            {
                mMANAGEMENT_DESC = MANAGEMENT_DESC_0.DateTimeValue.ToShortDateString().ToString();
            }
            else
            {
                mMANAGEMENT_DESC = MANAGEMENT_DESC_0.EditValue;
            }
            return mMANAGEMENT_DESC;
        }

        private void INIT_MANAGEMENT_COLUMN()
        {
            idaMANAGEMENT_PROMPT.Fill();
            if (idaMANAGEMENT_PROMPT.OraSelectData.Rows.Count == 0)
            {
                return;
            }

            // Adapter Column.
            int mIDX_Column;            // 시작 COLUMN.
            int mMax_Column = idaMANAGEMENT_PROMPT.SelectColumns.Count - 2; // 종료 COLUMN.
            object mCOLUMN_DESC;        // 헤더 프롬프트.
            
            //Grid Column.
            int mGrid_Column = 14;     // 그리드 시작 Column.
            for (mIDX_Column = 1; mIDX_Column < mMax_Column; mIDX_Column++)
            {
                mCOLUMN_DESC = idaMANAGEMENT_PROMPT.CurrentRow[mIDX_Column];
                if (iString.ISNull(mCOLUMN_DESC, ":=") == ":=".ToString())
                {
                    igrSLIP_MANAGEMENT.GridAdvExColElement[mGrid_Column].Visible = 0;
                }
                else
                {
                    igrSLIP_MANAGEMENT.GridAdvExColElement[mGrid_Column].Visible = 1;
                    igrSLIP_MANAGEMENT.GridAdvExColElement[mGrid_Column].HeaderElement[0].Default = iString.ISNull(mCOLUMN_DESC);
                    igrSLIP_MANAGEMENT.GridAdvExColElement[mGrid_Column].HeaderElement[0].TL1_KR = iString.ISNull(mCOLUMN_DESC);
                }
                mGrid_Column = mGrid_Column + 1;
            }
            igrSLIP_MANAGEMENT.ResetDraw = true;
        }

        private void INIT_EDIT_TYPE()
        {
            MANAGEMENT_DESC_0.EditValue = null;
            MANAGEMENT_DESC_0.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
            MANAGEMENT_DESC_0.NumberDecimalDigits = 0;
            if (iString.ISNull(DATA_TYPE_0.EditValue) == "NUMBER".ToString())
            {
                MANAGEMENT_DESC_0.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
            }
            else if (iString.ISNull(DATA_TYPE_0.EditValue) == "RATE".ToString())
            {
                MANAGEMENT_DESC_0.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                MANAGEMENT_DESC_0.NumberDecimalDigits = 4;
            }
            else if (iString.ISNull(DATA_TYPE_0.EditValue) == "DATE".ToString())
            {
                MANAGEMENT_DESC_0.EditAdvType = ISUtil.Enum.EditAdvType.DateTimeEdit;
            }

            if (iString.ISNull(LOOKUP_YN_0.EditValue, "N") == "N")
            {
                MANAGEMENT_DESC_0.LookupAdapter = null;
            }
            else
            {
                MANAGEMENT_DESC_0.LookupAdapter = ilaMANAGEMENT_ITEM;
            }
            MANAGEMENT_DESC_0.Refresh();
        }

        private void SET_GRID_COL_VISIBLE()
        {
            object mMANAGEMENT_DESC = Get_Management_Desc();
            idaSLIP_MANAGEMENT_YN.SetSelectParamValue("P_MANAGEMENT_DESC", mMANAGEMENT_DESC);
            idaSLIP_MANAGEMENT_YN.Fill();

            // Adapter Column.
            int mIDX_Column;            // 시작 COLUMN.
            int mMax_Column = 0;        // 종료 COLUMN.
            int mGrid_Column = 14;      // 그리드 시작 Column.
            object mVISIBLE_YN = ":=";   // 보이기 여부.

            if (idaSLIP_MANAGEMENT_YN.OraSelectData.Rows.Count == 0)
            {
                // Adapter Column.
                mMax_Column = idaMANAGEMENT_PROMPT.SelectColumns.Count - 2; // 종료 COLUMN.
                for (mIDX_Column = 1; mIDX_Column < mMax_Column; mIDX_Column++)
                {
                    mVISIBLE_YN = idaMANAGEMENT_PROMPT.CurrentRow[mIDX_Column];
                    if (iString.ISNull(mVISIBLE_YN, ":=") == ":=".ToString())
                    {
                        igrSLIP_MANAGEMENT.GridAdvExColElement[mGrid_Column].Visible = 0;
                    }
                    else
                    {
                        igrSLIP_MANAGEMENT.GridAdvExColElement[mGrid_Column].Visible = 1;
                    }
                    mGrid_Column = mGrid_Column + 1;
                }
            }
            else
            {
                // Adapter Column.
                mMax_Column = idaSLIP_MANAGEMENT_YN.SelectColumns.Count - 2; // 종료 COLUMN.
                for (mIDX_Column = 1; mIDX_Column < mMax_Column; mIDX_Column++)
                {
                    mVISIBLE_YN = idaSLIP_MANAGEMENT_YN.CurrentRow[mIDX_Column];
                    if (iString.ISNull(mVISIBLE_YN, ":=") == ":=".ToString())
                    {
                        igrSLIP_MANAGEMENT.GridAdvExColElement[mGrid_Column].Visible = 0;
                    }
                    else
                    {
                        igrSLIP_MANAGEMENT.GridAdvExColElement[mGrid_Column].Visible = 1;
                    }
                    mGrid_Column = mGrid_Column + 1;
                }
            }
            igrSLIP_MANAGEMENT.ResetDraw = true;
        }

        private void Show_Slip_Detail()
        {
            int mSLIP_HEADER_ID = iString.ISNumtoZero(igrSLIP_MANAGEMENT.GetCellValue("SLIP_HEADER_ID"));
            if (mSLIP_HEADER_ID != Convert.ToInt32(0))
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

        #region ----- Territory Get Methods ----

        private object GetTerritory()
        {

            object vTerritory = "Default";
            vTerritory = isAppInterfaceAdv1.AppInterface.OraConnectionInfo.TerritoryLanguage;
            return vTerritory;
        }

        #endregion;

        #region ----- XL Print 1 Method ----

        private void XLPrinting_1(string pOutChoice, object pGL_DATE_FR, object pGL_DATE_TO, ISGridAdvEx pGRID)
        {// pOutChoice : 출력구분.
            string vMessageText = string.Empty;
            string vSaveFileName = string.Empty;
            object vTerritory = string.Empty;
                        
            int vCountRow = pGRID.RowCount;
            if (vCountRow < 1)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10386"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            System.IO.DirectoryInfo vSaveFolder = new System.IO.DirectoryInfo(System.Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments));
            vSaveFileName = String.Format("Document_List_{0}~{1}", pGL_DATE_FR.ToString().Substring(0, 10), pGL_DATE_TO.ToString().Substring(0, 10));

            saveFileDialog1.Title = "Excel Save";
            saveFileDialog1.FileName = vSaveFileName;
            saveFileDialog1.DefaultExt = "xls";

            if (saveFileDialog1.ShowDialog() != DialogResult.OK)
            {
                return;
            }
            else
            {
                vSaveFileName = saveFileDialog1.FileName;
                System.IO.FileInfo vFileName = new System.IO.FileInfo(vSaveFileName);
                if (vFileName.Exists)
                {
                    try
                    {
                        vFileName.Delete();
                    }
                    catch (Exception EX)
                    {
                        MessageBoxAdv.Show(EX.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return;
                    }
                }
            }

            System.Windows.Forms.Application.UseWaitCursor = true;
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            System.Windows.Forms.Application.DoEvents();

            int vPageNumber = 0;

            vMessageText = string.Format(" Printing Starting...");
            isAppInterfaceAdv1.OnAppMessage(vMessageText);
            System.Windows.Forms.Application.DoEvents();

            vTerritory = GetTerritory();
            XLPrinting xlPrinting = new XLPrinting(isAppInterfaceAdv1.AppInterface, isMessageAdapter1);

            try
            {// 폼에 있는 항목들중 기본적으로 출력해야 하는 값.

                // open해야 할 파일명 지정.
                //-------------------------------------------------------------------------------------
                xlPrinting.OpenFileNameExcel = "FCMF0209_001.xls";
                //-------------------------------------------------------------------------------------
                // 파일 오픈.
                //-------------------------------------------------------------------------------------
                bool isOpen = xlPrinting.XLFileOpen();
                //-------------------------------------------------------------------------------------

                //-------------------------------------------------------------------------------------
                if (isOpen == true)
                {
                    // 실제 인쇄
                    vPageNumber = xlPrinting.LineWrite(iString.ISNull(vTerritory), pGRID);

                    //출력구분에 따른 선택(인쇄 or file 저장)
                    if (pOutChoice == "PRINT")
                    {
                        xlPrinting.Printing(1, vPageNumber);
                    }
                    else if (pOutChoice == "FILE")
                    {
                        xlPrinting.SAVE(vSaveFileName);
                    }

                    //-------------------------------------------------------------------------------------
                    xlPrinting.Dispose();
                    //-------------------------------------------------------------------------------------

                    vMessageText = "Printing End";
                    isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
                    System.Windows.Forms.Application.DoEvents();
                }
                else
                {
                    vMessageText = "Excel File Open Error";
                    isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
                    System.Windows.Forms.Application.DoEvents();
                }
                //-------------------------------------------------------------------------------------
            }
            catch (System.Exception ex)
            {
                xlPrinting.Dispose();

                vMessageText = ex.Message;
                isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
                System.Windows.Forms.Application.DoEvents();
            }

            System.Windows.Forms.Application.UseWaitCursor = false;
            this.Cursor = System.Windows.Forms.Cursors.Default;
            System.Windows.Forms.Application.DoEvents();
        }

        #endregion;

        #region ----- Events -----

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    SEARCH_DB();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    if (idaSLIP_MANAGEMENT.IsFocused)
                    {

                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaSLIP_MANAGEMENT.IsFocused)
                    {

                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (idaSLIP_MANAGEMENT.IsFocused)
                    {

                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaSLIP_MANAGEMENT.IsFocused)
                    {

                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaSLIP_MANAGEMENT.IsFocused)
                    {
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                    XLPrinting_1("FILE", GL_DATE_FR_0.EditValue, GL_DATE_TO_0.EditValue, igrSLIP_MANAGEMENT);
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void FCMF0209_Load(object sender, EventArgs e)
        {
            
        }
        
        private void FCMF0209_Shown(object sender, EventArgs e)
        {
            DefaultValue();
            INIT_MANAGEMENT_COLUMN();
        }

        private void igrSLIP_MANAGEMENT_CellDoubleClick(object pSender)
        {
            Show_Slip_Detail(); 
        }

        #endregion

        #region ------ Lookup Event ------

        private void ilaGL_NUM_0_RefreshLookupData(object pSender, ISRefreshLookupDataEventArgs e)
        {
            ildGL_NUM.SetLookupParamValue("W_GL_NUM", GL_NUM_0.EditValue);
        }

        private void ilaACCOUNT_CODE_FR_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildACCOUNT_CONTROL_FR.SetLookupParamValue("W_ACCOUNT_CODE_FR", null);
            ildACCOUNT_CONTROL_FR.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaACCOUNT_CODE_TO_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildACCOUNT_CONTROL_FR.SetLookupParamValue("W_ACCOUNT_CODE_FR", ACCOUNT_CODE_FR_0.EditValue);
            ildACCOUNT_CONTROL_FR.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaMANAGEMENT_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "MANAGEMENT_CODE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", "Y");
        }
        
        private void ilaMANAGEMENT_TYPE_SelectedRowData(object pSender)
        {
            INIT_EDIT_TYPE();
        }
        
        private void ilaMANAGEMENT_ITEM_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildMANAGEMENT_ITEM.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        #endregion


        #region ----- Adapter Event -----

        #endregion


    }
}