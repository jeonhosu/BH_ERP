using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using Syncfusion.Windows.Forms;

using Syncfusion.Windows.Forms.Tools;
using Syncfusion.Windows.Forms.Grid;
using System.IO;
using Syncfusion.GridExcelConverter;

using InfoSummit.Win.ControlAdv;
using ISCommonUtil;

namespace HRMF0348
{
    public partial class HRMF0348 : Office2007Form
    {
        #region ----- Variables -----

        private ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();
        private ISFunction.ISConvert iString = new ISFunction.ISConvert();

        #endregion;

        #region ----- Constructor -----

        public HRMF0348(Form pMainForm, ISAppInterface pAppInterface)
        {
            this.Visible = false;
            this.DoubleBuffered = true;

            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods -----

        private void DefaultSetFormReSize()
        {//[Child Form, Mdi Form에 맞게 ReSize]
            int vMinusWidth = 4;
            int vMinusHeight = 54;
            System.Drawing.Size vSize = this.MdiParent.ClientSize;
            this.Width = vSize.Width - vMinusWidth;
            this.Height = vSize.Height - vMinusHeight;
        }

        private void DefaultCorporation()
        {
            // Lookup SETTING
            ildCORP.SetLookupParamValue("W_DUTY_CONTROL_YN", "Y");
            ildCORP.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");

            // LOOKUP DEFAULT VALUE SETTING - CORP
            idcDEFAULT_CORP.SetCommandParamValue("W_DUTY_CONTROL_YN", "Y");
            idcDEFAULT_CORP.SetCommandParamValue("W_ENABLED_FLAG_YN", "N");
            idcDEFAULT_CORP.ExecuteNonQuery();
            CORP_NAME_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_NAME");
            CORP_ID_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_ID");
            WORK_CORP_NAME_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_NAME");
            WORK_CORP_ID_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_ID");
        }

        private void Search_DB()
        {
             if (DUTY_TYPE_0.EditValue != null && string.IsNullOrEmpty(DUTY_TYPE_0.EditValue.ToString()) )
            {// 근무일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10059"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                DUTY_TYPE_NAME_0.Focus();
                return;
            }
            if (DUTY_YYYYMM_0.EditValue == null)
            {// 근무일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                DUTY_YYYYMM_0.Focus();
                return;
            }

            string vPERSON_NUM = iString.ISNull(IGR_MONTH_TOTAL_VALIDATE.GetCellValue("PERSON_NUM"));
            int vIDX_Col = IGR_MONTH_TOTAL_VALIDATE.GetColumnToIndex("PERSON_NUM");

            IDA_MONTH_TOTAL_VALIDATE.Fill();
            IGR_MONTH_TOTAL_VALIDATE.Focus();

            if (IGR_MONTH_TOTAL_VALIDATE.RowCount > 0)
            {
                for (int vRow = 0; vRow < IGR_MONTH_TOTAL_VALIDATE.RowCount; vRow++)
                {
                    if (vPERSON_NUM == iString.ISNull(IGR_MONTH_TOTAL_VALIDATE.GetCellValue(vRow, vIDX_Col)))
                    {
                        IGR_MONTH_TOTAL_VALIDATE.CurrentCellMoveTo(vRow, vIDX_Col);
                    }
                }
            }
        }

        #endregion;

        #region ----- Excel Export -----

        private void ExcelExport()
        {
            SaveFileDialog saveFileDialog = new SaveFileDialog();
            GridExcelConverterControl vExport = new GridExcelConverterControl();

            saveFileDialog.RestoreDirectory = true;
            saveFileDialog.Title = "Save File Name";
            saveFileDialog.Filter = "Excel Files(*.xls)|*.xls";
            saveFileDialog.DefaultExt = ".xls";

            if (saveFileDialog.ShowDialog() == DialogResult.OK)
            {
                vExport.GridToExcel(IGR_MONTH_TOTAL_VALIDATE.BaseGrid, saveFileDialog.FileName,
                                    Syncfusion.GridExcelConverter.ConverterOptions.RowHeaders);

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


        #region ----- isAppInterfaceAdv1_AppMainButtonClick Events -----

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
                    ExcelExport();
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void HRMF0348_Load(object sender, EventArgs e)
        {
            
        }

        private void HRMF0348_Shown(object sender, EventArgs e)
        {
            // Year Month Setting
            ildYYYYMM.SetLookupParamValue("W_START_YYYYMM", "2010-01");
            DUTY_YYYYMM_0.EditValue = iDate.ISYearMonth(DateTime.Today);
            WORK_DATE_FR.EditValue = iDate.ISMonth_1st(DateTime.Today);
            WORK_DATE_TO.EditValue = iDate.ISMonth_Last(DateTime.Today);

            // CORP SETTING
            DefaultCorporation();

            // Duty TYPE SETTING
            ildDUTY_TYPE_0.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
            idcDEFAULT_MONTH_DUTY_TYPE.ExecuteNonQuery();
            DUTY_TYPE_NAME_0.EditValue = idcDEFAULT_MONTH_DUTY_TYPE.GetCommandParamValue("O_CODE_NAME");
            DUTY_TYPE_0.EditValue = idcDEFAULT_MONTH_DUTY_TYPE.GetCommandParamValue("O_CODE");
             
            WORK_DATE_FR.BringToFront();
            WORK_DATE_TO.BringToFront();

            //DefaultSetFormReSize();             //[Child Form, Mdi Form에 맞게 ReSize]
        }

        #endregion  

        #region ----- Adapter Event -----

        #endregion

        #region ----- LookUp Event -----

        private void ilaDEPT_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT_0.SetLookupParamValue("W_USABLE_CHECK_YN", "Y");
        }

        private void ILA_JOB_CATEGORY_0_PrePopupShow_1(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "JOB_CATEGORY");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        private void ilaFLOOR_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "FLOOR");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        private void ILA_JOB_CATEGORY_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "JOB_CATEGORY");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        private void ilaDUTY_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDUTY_TYPE_0.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        #endregion


    }
}