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


namespace HRMF1391
{
    public partial class HRMF1391 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iConv = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();
        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        #endregion;

        #region ----- Constructor -----

        public HRMF1391()
        {
            InitializeComponent();
        }

        public HRMF1391(Form pMainForm, ISAppInterface pAppInterface)
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

            if (iString.ISNull(W_USER_CAP_FLAG.EditValue) == "C")
            {
                ibt_Set.Visible = true;
            }
            else if (iString.ISNull(W_USER_CAP_FLAG.EditValue) == "A")
            {
                ibt_Set.Visible = false;
            }

        }

        private void Search_DB()
        {
            if (CORP_ID_0.EditValue == null)
            {// ????.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME_0.Focus();
                return;
            }
            if (WEEK_START_DATE_0.EditValue == null)
            {// ????????
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10635"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                WEEK_CODE_0.Focus();
                return;
            }
            if (WEEK_END_DATE_0.EditValue == null)
            {// ????????
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10635"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                WEEK_CODE_0.Focus();
                return;
            }

            IDA_WEEKLY_FLEX.SetSelectParamValue("W_SOB_ID", -1);
            IDA_WEEKLY_FLEX.Fill();

            INIT_COLUMN();

            IDA_WEEKLY_FLEX.SetSelectParamValue("W_SOB_ID", isAppInterfaceAdv1.SOB_ID);
            IDA_WEEKLY_FLEX.Fill();
            ISG_WEEKLY_FLEX.Focus();

            Application.DoEvents();
            SetRowColor(ISG_WEEKLY_FLEX);
            Application.DoEvents();

            ISG_WEEKLY_FLEX.Focus();
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

            int mGRID_START_COL = 6;   // ?????? ???? COLUMN.
            int mIDX_Column;            // ???? COLUMN.            
            int mMax_Column = 7;       // ???? COLUMN.
            //int mENABLED_COLUMN;        // ???????? COLUMN.

            //object mENABLED_FLAG;       // ????(????)????.
            object mCOLUMN_DESC;        // ???? ????????.

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
                    ISG_WEEKLY_FLEX.GridAdvExColElement[mGRID_START_COL + mIDX_Column].Visible = 1;
                    ISG_WEEKLY_FLEX.GridAdvExColElement[mGRID_START_COL + mIDX_Column].HeaderElement[0].Default = iString.ISNull(mCOLUMN_DESC);
                    ISG_WEEKLY_FLEX.GridAdvExColElement[mGRID_START_COL + mIDX_Column].HeaderElement[0].TL1_KR = iString.ISNull(mCOLUMN_DESC);
               // }
            }
            ISG_WEEKLY_FLEX.ResetDraw = true;
        }

        private void SetRowColor(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid)
        {
            int vIDX_MISMATCH_YN = pGrid.GetColumnToIndex("MISMATCH_YN");
            for (int r = 0; r < pGrid.RowCount; r++)
            {
                if ("Y" == iConv.ISNull(pGrid.GetCellValue(r, vIDX_MISMATCH_YN)))
                {
                    pGrid.CellBackColor(r, vIDX_MISMATCH_YN, Color.FromArgb(90,191,255));
                } 
                else 
                {
                    pGrid.CellBackColor(r, vIDX_MISMATCH_YN, Color.White);
                }
            }
            pGrid.ResetDraw = true;
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
                    ExcelExport(ISG_WEEKLY_FLEX);
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

                //xls ????????
                //vExport.GridToExcel(pGrid.BaseGrid, saveFileDialog.FileName,
                //                    Syncfusion.GridExcelConverter.ConverterOptions.ColumnHeaders);



                //if (MessageBox.Show("Do you wish to open the xls file now?",
                //                    "Export to Excel", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
                //{
                //    System.Diagnostics.Process vProc = new System.Diagnostics.Process();
                //    vProc.StartInfo.FileName = saveFileDialog.FileName;
                //    vProc.Start();
                //}

                //xlsx ???? ???? ????
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

        private void HRMF1391_Load(object sender, EventArgs e)
        {
        }

        private void HRMF1391_Shown(object sender, EventArgs e)
        {
            DefaultValues();

            DUTY_YYYYMM_0.EditValue = iDate.ISYearMonth(DateTime.Today);
            IDA_WEEKLY_DAY.FillSchema();
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
            IDC_YYYYMM_WEEK.SetCommandParamValue("W_WEEK_CODE", WEEK_CODE_0.EditValue);
            IDC_YYYYMM_WEEK.ExecuteNonQuery();
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

            //???????? && ???????? ???? ???? //
            //1.???? (????/????) => ????????(????/????) ????????.
            if (iConv.ISNull(e.Row["DUTY_CODE"]) == "00" || iConv.ISNull(e.Row["DUTY_CODE"]) == "11")
            {
                if (iConv.ISNull(e.Row["HOLY_TYPE"]) == "2" || iConv.ISNull(e.Row["HOLY_TYPE"]) == "3")
                {
                }
                else
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10472", string.Format("&&DUTY_NAME:={0}&&HOLY_TYPE:={1}", "????/????", "????/????")), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    e.Cancel = true;
                    return;
                }
            }
            //2.????(????????) => ????????(????) ????????.
            if (iConv.ISNull(e.Row["DUTY_CODE"]) == "52" )
            {
                if (iConv.ISNull(e.Row["HOLY_TYPE"]) == "0")
                {
                }
                else
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10472", string.Format("&&DUTY_NAME:={0}&&HOLY_TYPE:={1}", "????????", "????")), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    e.Cancel = true;
                    return;
                }
            }
            //3.????(????????) => ????????(????) ????????.
            if (iConv.ISNull(e.Row["DUTY_CODE"]) == "51")
            {
                if (iConv.ISNull(e.Row["HOLY_TYPE"]) == "1")
                {
                }
                else
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10472", string.Format("&&DUTY_NAME:={0}&&HOLY_TYPE:={1}", "????????", "????")), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    e.Cancel = true;
                    return;
                }
            }
            //4.????(????????) => ????????(????/????) ????????.
            if (iConv.ISNull(e.Row["DUTY_CODE"]) == "53")
            {
                if (iConv.ISNull(e.Row["HOLY_TYPE"]) == "0" || iConv.ISNull(e.Row["HOLY_TYPE"]) == "1")
                {
                }
                else
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10472", string.Format("&&DUTY_NAME:={0}&&HOLY_TYPE:={1}", "????????", "????/????")), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    e.Cancel = true;
                    return;
                }
            }
        }

        #endregion

        private void isButton1_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (CORP_ID_0.EditValue == null)
            {// ????.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME_0.Focus();
                return;
            }
            if (WEEK_START_DATE_0.EditValue == null)
            {// ???? ????
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
              //  WEEK_START_DATE_0.Focus();
                return;
            }
            if (WEEK_END_DATE_0.EditValue == null)
            {// ???? ????
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
              //  WEEK_END_DATE_0.Focus();
                return;
            }


            DialogResult dlgResult;
            HRMF1391_CAL vHRMF0634_CAL = new HRMF1391_CAL(isAppInterfaceAdv1.AppInterface
                                                        , WEEK_START_DATE_0.EditValue
                                                        , WEEK_END_DATE_0.EditValue
                                                        , CORP_ID_0.EditValue, CORP_NAME_0.EditValue
                                                        , DEPT_ID_0.EditValue, DEPT_NAME_0.EditValue
                                                        , FLOOR_ID_0.EditValue, FLOOR_NAME_0.EditValue
                                                        , WORK_TYPE_ID_0.EditValue, WORK_TYPE_NAME_0.EditValue
                                                        , JOB_CATEGORY_ID_0.EditValue, JOB_CATEGORY_NAME_0.EditValue
                                                        , PERSON_ID_0.EditValue, NAME_0.EditValue
                                                       // , this.MdiParent
                                                        );
            // vHRMF0634_CAL.Show();
            dlgResult = vHRMF0634_CAL.ShowDialog();
            if (dlgResult == DialogResult.OK)
            {
                // refill.
                Search_DB();
            }
            vHRMF0634_CAL.Dispose();

        }
    }
}