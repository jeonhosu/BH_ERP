﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using Syncfusion.Windows.Forms;
using Syncfusion.Windows.Forms.Tools;
using Syncfusion.Windows.Forms.Grid;
using InfoSummit.Win.ControlAdv;
using ISCommonUtil;

namespace FCMF0803
{
    public partial class FCMF0803 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();


        #endregion;

        #region ----- Constructor -----

        public FCMF0803(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void SearchDB()
        {
            if (iString.ISNull(TAX_CODE_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10007"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                TAX_CODE_NAME_0.Focus();
                return;
            }

            if (iString.ISNull(ISSUE_DATE_FR_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                ISSUE_DATE_FR_0.Focus();
                return;
            }
            if (iString.ISNull(ISSUE_DATE_TO_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                ISSUE_DATE_FR_0.Focus();
                return;
            }
            if (Convert.ToDateTime(ISSUE_DATE_FR_0.EditValue) > Convert.ToDateTime(ISSUE_DATE_TO_0.EditValue))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10012"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                ISSUE_DATE_FR_0.Focus();
                return;
            }

            if (itbVAT_MASTER.SelectedTab.TabIndex == 1)
            {
                idaVAT_MASTER.Fill();
                igrVAT_MASTER.Focus();
            }

            //if (itbVAT_MASTER.SelectedIndex == 0)
            //{
            //    idaVAT_MASTER.Fill();
            //    igrVAT_MASTER.Focus();
            //}
            //else if (itbVAT_MASTER.SelectedIndex == 1)
            //{
            //    idaNOT_CONFIRM_VAT.Fill();
            //    igrNOT_CONFIRM_VAT.Focus();
            //}
        }

        private void Show_Slip_Detail()
        {
            int mSLIP_HEADER_ID = iString.ISNumtoZero(igrVAT_MASTER.GetCellValue("SLIP_HEADER_ID"));
            if (mSLIP_HEADER_ID != Convert.ToInt32(0))
            {
                Application.UseWaitCursor = true;
                this.Cursor = System.Windows.Forms.Cursors.WaitCursor;

                FCMF0204.FCMF0204 vFCMF0204 = new FCMF0204.FCMF0204(this.MdiParent, isAppInterfaceAdv1.AppInterface, mSLIP_HEADER_ID);
                vFCMF0204.Show();

                this.Cursor = System.Windows.Forms.Cursors.Default;
                Application.UseWaitCursor = false;
            }
        }

        private void Show_Slip_Interface_Detail()
        {
            //System.Windows.Forms.DialogResult vdlgResultValue;
            //int mHEADER_INTERFACE_ID = iString.ISNumtoZero(igrNOT_CONFIRM_VAT.GetCellValue("HEADER_INTERFACE_ID"));
            //if (mHEADER_INTERFACE_ID != Convert.ToInt32(0))
            //{
            //    Application.UseWaitCursor = true;
            //    this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            //    Application.DoEvents();

            //    Form vSLIP_IF_DETAIL = new SLIP_IF_DETAIL(isAppInterfaceAdv1.AppInterface, mHEADER_INTERFACE_ID);
            //    vdlgResultValue = vSLIP_IF_DETAIL.ShowDialog();
            //    vSLIP_IF_DETAIL.Dispose();

            //    Application.DoEvents();
            //    this.Cursor = System.Windows.Forms.Cursors.Default;
            //    Application.UseWaitCursor = false;
            //}
        }

        private void SetCommonParameter(object pGroup_Code, object pEnabled_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        }

        #endregion;

        #region ----- XL Export Methods ----

        private void ExportXL()
        {
            int vCountRow = idaVAT_MASTER.OraSelectData.Rows.Count;
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
                bool vXLSaveOK = xlExport.XLExport(idaVAT_MASTER.OraSelectData, vsSaveExcelFileName, vsSheetName);
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
            int vTerritory = -1;

            switch (pTerritoryEnum)
            {
                case ISUtil.Enum.TerritoryLanguage.Default:
                    vTerritory = 0;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL1_KR:
                    vTerritory = 1;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL2_CN:
                    vTerritory = 2;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL3_VN:
                    vTerritory = 3;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL4_JP:
                    vTerritory = 4;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL5_XAA:
                    vTerritory = 5;
                    break;
            }

            return vTerritory;
        }

        #endregion;

        #region ----- XL Print 1 Methods ----

        private void XLPrinting1()
        {
            string vMessageText = string.Empty;

            XLPrinting xlPrinting = new XLPrinting();

            try
            {
                //mMainForm
                //string vPathReport = string.Empty;
                //object vObject = mMainForm.Tag;
                //if (vObject != null)
                //{
                //    vPathReport = mMainForm.Tag;
                //}
                //-------------------------------------------------------------------------
                xlPrinting.OpenFileNameExcel = @"K:\00_5_XL_Print\Ex_XL_Print\XL_Print_02.xls";
                xlPrinting.XLFileOpen();

                int vTerritory = GetTerritory(igrVAT_MASTER.TerritoryLanguage);
                string vPeriodFrom = ISSUE_DATE_FR_0.EditText;
                string vPeriodTo = ISSUE_DATE_FR_0.EditText;
                int vPageNumber = xlPrinting.XLWirte(igrVAT_MASTER, vTerritory, vPeriodFrom, vPeriodTo);

                //xlPrinting.Printing(1, vPageNumber); //시작 페이지 번호, 종료 페이지 번호
                ////xlPrinting.Printing(3, 4);


                xlPrinting.Save("t_XL_"); //저장 파일명
                //vMessageText = string.Format("Err : {0}", xlPrinting.ErrorMessage);
                //MessageGrid(vMessageText);

                //xlPrinting.PreView();

                xlPrinting.Dispose();
                //-------------------------------------------------------------------------

                vMessageText = string.Format("Print End! [Page : {0}]", vPageNumber);
                MessageBoxAdv.Show(vMessageText);
            }
            catch (System.Exception ex)
            {
                string vMessage = ex.Message;
                xlPrinting.Dispose();
            }
        }

        #endregion;

        #region ----- Events -----

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    SearchDB(); 
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
                    idaVAT_MASTER.Cancel();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {

                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void FCMF0803_Load(object sender, EventArgs e)
        {
            
        }
        
        private void FCMF0803_Shown(object sender, EventArgs e)
        {
            ISSUE_DATE_FR_0.EditValue = iDate.ISMonth_1st(DateTime.Today);
            ISSUE_DATE_TO_0.EditValue = DateTime.Today;

            idcDV_TAX_CODE.SetCommandParamValue("W_GROUP_CODE", "TAX_CODE");
            idcDV_TAX_CODE.ExecuteNonQuery();
            TAX_CODE_NAME_0.EditValue = idcDV_TAX_CODE.GetCommandParamValue("O_CODE_NAME");
            TAX_CODE_0.EditValue = idcDV_TAX_CODE.GetCommandParamValue("O_CODE");
        }

        private void igrVAT_MASTER_CellDoubleClick(object pSender)
        {
            Show_Slip_Detail();
        }

        private void igrNOT_CONFIRM_VAT_CellDoubleClick(object pSender)
        {
            Show_Slip_Interface_Detail();
        }
        
        #endregion

        #region ----- Lookup Event -----

        private void ilaTAX_CODE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("TAX_CODE", "Y");
        }

        private void ilaVAT_CLASS_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("VAT_GUBUN", "Y");
        }

        private void ilaCUSTOMER_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCUSTOMER.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaVAT_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("VAT_TYPE", "Y");
        }

        #endregion


    }
}