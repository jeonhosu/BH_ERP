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

using System.IO;
using Syncfusion.GridExcelConverter;
using Syncfusion.XlsIO;


namespace HRMF0367
{
    public partial class HRMF0367 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iConv = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();
        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        #endregion;

        #region ----- Constructor -----

        public HRMF0367()
        {
            InitializeComponent();
        }

        public HRMF0367(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;

            //if (iString.ISNull(isAppInterfaceAdv1.AppInterface.Attribute_A) != string.Empty)
            //{
            //    W_USER_CAP_FLAG.EditValue =  isAppInterfaceAdv1.AppInterface.Attribute_A;
            //}
        }

        #endregion;

        #region ----- Private Methods ----

        private void DefaultValues()
        {
            // Lookup SETTING
            ILD_CORP.SetLookupParamValue("W_DUTY_CONTROL_YN", "Y");
            ILD_CORP.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");

            // USER_CAP
            IDC_USER_CAP.SetCommandParamValue("W_MODULE_CODE", "20");
            IDC_USER_CAP.ExecuteNonQuery();
             W_USER_CAP_FLAG.EditValue = IDC_USER_CAP.GetCommandParamValue("O_CAP_LEVEL");

            // LOOKUP DEFAULT VALUE SETTING - CORP
            idcDEFAULT_CORP.SetCommandParamValue("W_DUTY_CONTROL_YN", "Y");
            idcDEFAULT_CORP.SetCommandParamValue("W_ENABLED_FLAG_YN", "N");
            idcDEFAULT_CORP.ExecuteNonQuery();
            CORP_NAME_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_NAME");
            CORP_ID_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_ID");

            CORP_NAME_0.BringToFront();

            idcDEFAULT_VALUE.SetCommandParamValue("W_GROUP_CODE", "LEAVE_CLOSE_TYPE");
            idcDEFAULT_VALUE.ExecuteNonQuery();

        }

        private void Search_DB()
        {
            if (CORP_ID_0.EditValue == null)
            {// 업체.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME_0.Focus();
                return;
            }
            if (WEEK_START_DATE_0.EditValue == null)
            {// 근무일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10635"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                WEEK_CODE_0.Focus();
                return;
            }
            if (WEEK_END_DATE_0.EditValue == null)
            {// 근무일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10635"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                WEEK_CODE_0.Focus();
                return;
            }


            INIT_COLUMN();

            IDA_WEEKLY_DATA.Fill();
            ISG_WEEKLY_DATA.Focus();
        }

        private void SetCommonParameter(object pGroup_Code, object pEnabled_YN)
        {
            ILD_COMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
            ILD_COMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", pEnabled_YN);
        }

        private void INIT_COLUMN()
        {
            IDA_WEEKLY_DAY.Fill();

            if (IDA_WEEKLY_DAY.OraSelectData.Rows.Count == 0)
            {
                return;
            }

            int mGRID_START_COL = 6;   // 그리드 시작 COLUMN.
            int mIDX_Column;            // 시작 COLUMN.            
            int mMax_Column = 7;       // 종료 COLUMN.
            //int mENABLED_COLUMN;        // 사용여부 COLUMN.

            //object mENABLED_FLAG;       // 사용(표시)여부.
            object mCOLUMN_DESC;        // 헤더 프롬프트.

            for (mIDX_Column = 0; mIDX_Column < mMax_Column; mIDX_Column++)
            {
                //mENABLED_COLUMN = mMax_Column + mIDX_Column;
                //mENABLED_FLAG = IDA_MONTH_DAY_WEEK.CurrentRow[mENABLED_COLUMN];
                mCOLUMN_DESC = IDA_WEEKLY_DAY.CurrentRow[mIDX_Column];
                //if (iString.ISNull(mCOLUMN_DESC, "N") == "N".ToString())
                //{
                //    ISG_WEEKLY_DATA.GridAdvExColElement[mGRID_START_COL + mIDX_Column].Visible = 0;
                //}
                //else
                //{
                    ISG_WEEKLY_DATA.GridAdvExColElement[mGRID_START_COL + mIDX_Column].Visible = 1;
                    ISG_WEEKLY_DATA.GridAdvExColElement[mGRID_START_COL + mIDX_Column].HeaderElement[0].Default = iString.ISNull(mCOLUMN_DESC);
                    ISG_WEEKLY_DATA.GridAdvExColElement[mGRID_START_COL + mIDX_Column].HeaderElement[0].TL1_KR = iString.ISNull(mCOLUMN_DESC);
               // }
            }
            ISG_WEEKLY_DATA.ResetDraw = true;
        }

        #endregion;

        #region ----- Events -----

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    Search_DB();
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
                    
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                    ExcelExport(ISG_WEEKLY_DATA);
                }
            }
        }

        #endregion;

        #region ----- Excel Export -----

        private void ExcelExport(ISGridAdvEx pGrid)
        {
            SaveFileDialog saveFileDialog = new SaveFileDialog();
            GridExcelConverterControl vExport = new GridExcelConverterControl();

            saveFileDialog.RestoreDirectory = true;
            saveFileDialog.Title = "Save File Name";
            saveFileDialog.Filter = "Excel Files(*.xlsx)|*.xlsx";
            saveFileDialog.DefaultExt = ".xlsx";

            if (saveFileDialog.ShowDialog() == DialogResult.OK)
            {
                Application.UseWaitCursor = true;
                System.Windows.Forms.Cursor.Current = Cursors.WaitCursor;
                Application.DoEvents();

                //xls 저장방법
                //vExport.GridToExcel(pGrid.BaseGrid, saveFileDialog.FileName,
                //                    Syncfusion.GridExcelConverter.ConverterOptions.ColumnHeaders);



                //if (MessageBox.Show("Do you wish to open the xls file now?",
                //                    "Export to Excel", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
                //{
                //    System.Diagnostics.Process vProc = new System.Diagnostics.Process();
                //    vProc.StartInfo.FileName = saveFileDialog.FileName;
                //    vProc.Start();
                //}

                //xlsx 파일 저장 방법
                GridExcelConverterControl converter = new GridExcelConverterControl();
                ExcelEngine excelEngine = new ExcelEngine();
                IApplication application = excelEngine.Excel;
                application.DefaultVersion = ExcelVersion.Excel2007;
                IWorkbook workBook = ExcelUtils.CreateWorkbook(1);
                workBook.Version = ExcelVersion.Excel2007;
                IWorksheet sheet = workBook.Worksheets[0];
                //used to convert grid to excel 
                converter.GridToExcel(pGrid.BaseGrid, sheet, ConverterOptions.ColumnHeaders);
                //used to save the file
                workBook.SaveAs(saveFileDialog.FileName);

                Application.UseWaitCursor = false;
                System.Windows.Forms.Cursor.Current = Cursors.Default;
                Application.DoEvents();

                if (MessageBox.Show("Do you wish to open the xls file now?",
                                        "Export to Excel", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
                {
                    System.Diagnostics.Process vProc = new System.Diagnostics.Process();
                    vProc.StartInfo.FileName = saveFileDialog.FileName;
                    vProc.Start();
                }
            }
        }

        #endregion



        #region ----- Form event -----

        private void HRMF0367_Load(object sender, EventArgs e)
        {
            IDA_WEEKLY_DATA.FillSchema();
            IDA_WEEKLY_DAY.FillSchema();
        }

        private void HRMF0367_Shown(object sender, EventArgs e)
        {
            DefaultValues();

            DUTY_YYYYMM_0.EditValue = iDate.ISYearMonth(DateTime.Today);
        }

        #endregion

        #region ----- Lookup event ------

        private void ilaYYYYMM_0_SelectedRowData(object pSender)
        {
            WEEK_CODE_0.EditValue = null;
            WEEK_START_DATE_0.EditValue = null;
            WEEK_END_DATE_0.EditValue = null;
        }

        private void ILA_PERSON_0_SelectedRowData(object pSender)
        {
            Search_DB();
        }

        private void ILA_DEPT_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ILD_DEPT_0.SetLookupParamValue("W_USABLE_CHECK_YN", "Y");
        }

        private void ILA_HOLY_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("HOLY_TYPE", "Y");
        }

        private void ILA_WORK_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("WORK_TYPE", "Y");
        }

        private void ILA_DUTY_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("DUTY", "Y");
        }

        private void ILA_FLOOR_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("FLOOR", "Y");
        }

        private void ILA_JOB_CATEGORY_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("JOB_CATEGORY", "Y");
        }

        private void ILA_DUTY_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("DUTY", "Y");
        }

        private void ILA_HOLY_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("HOLY_TYPE", "Y");
        }

        private void ILA_YYYYMM_WEEK_SelectedRowData(object pSender)
        {
            idcYYYYMM_WEEK.SetCommandParamValue("W_WEEK_CODE", WEEK_CODE_0.EditValue);
            idcYYYYMM_WEEK.ExecuteNonQuery();
        }
        #endregion

        #region ------ Adpater event ------

        private void IDA_DAY_LEAVE_WEEK_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iConv.ISNull(e.Row["DAY_LEAVE_ID"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10471"), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                e.Cancel = true;
                return;
            }
            if (iConv.ISNull(e.Row["DUTY_ID"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10175"), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                e.Cancel = true;
                return;
            }
            if (iConv.ISNull(e.Row["HOLY_TYPE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10470"), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                e.Cancel = true;
                return;
            }

            //근태코드 && 근무구분 상호 검증 //
            //1.근태 (정상/결근) => 근무구분(주간/야간) 선택가능.
            if (iConv.ISNull(e.Row["DUTY_CODE"]) == "00" || iConv.ISNull(e.Row["DUTY_CODE"]) == "11")
            {
                if (iConv.ISNull(e.Row["HOLY_TYPE"]) == "2" || iConv.ISNull(e.Row["HOLY_TYPE"]) == "3")
                {
                }
                else
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10472", string.Format("&&DUTY_NAME:={0}&&HOLY_TYPE:={1}", "출근/결근", "주간/야간")), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    e.Cancel = true;
                    return;
                }
            }
            //2.근태(무급휴일) => 근무구분(무휴) 선택가능.
            if (iConv.ISNull(e.Row["DUTY_CODE"]) == "52" )
            {
                if (iConv.ISNull(e.Row["HOLY_TYPE"]) == "0")
                {
                }
                else
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10472", string.Format("&&DUTY_NAME:={0}&&HOLY_TYPE:={1}", "무급휴일", "무휴")), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    e.Cancel = true;
                    return;
                }
            }
            //3.근태(유급휴일) => 근무구분(유휴) 선택가능.
            if (iConv.ISNull(e.Row["DUTY_CODE"]) == "51")
            {
                if (iConv.ISNull(e.Row["HOLY_TYPE"]) == "1")
                {
                }
                else
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10472", string.Format("&&DUTY_NAME:={0}&&HOLY_TYPE:={1}", "유급휴일", "유휴")), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    e.Cancel = true;
                    return;
                }
            }
            //4.근태(휴일근무) => 근무구분(무휴/유휴) 선택가능.
            if (iConv.ISNull(e.Row["DUTY_CODE"]) == "53")
            {
                if (iConv.ISNull(e.Row["HOLY_TYPE"]) == "0" || iConv.ISNull(e.Row["HOLY_TYPE"]) == "1")
                {
                }
                else
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10472", string.Format("&&DUTY_NAME:={0}&&HOLY_TYPE:={1}", "휴일근무", "유휴/무휴")), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    e.Cancel = true;
                    return;
                }
            }
        }

        #endregion

    }
}