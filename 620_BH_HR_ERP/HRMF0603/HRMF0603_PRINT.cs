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

namespace HRMF0603
{
    public partial class HRMF0603_PRINT : Office2007Form
    {
        #region ----- Variables -----
        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        int mCorp_ID;            //업체ID
        string mAdjustment_Type; //정산구분
        int mPerson_ID;          //사원ID
        int mDept_ID;            //부서ID
        int mPayGrade_ID;        //직급ID
        decimal mADJUSTMENT_ID;  //정산구분ID

        #endregion;

        #region ----- Constructor -----

        public HRMF0603_PRINT(ISAppInterface pAppInterface
                             , object pCorpID           //업체ID
                             , object pAdjustment_Type  //정산구분
                             , object pPerson_ID        //사원ID
                             , object pDept_ID          //부서ID
                             , object pPayGrade_ID      //직급ID
                             , object pADJUSTMENT_ID    //정산구분ID
                             )
        {
            InitializeComponent();
            isAppInterfaceAdv1.AppInterface = pAppInterface;
            mCorp_ID = Convert.ToInt32(pCorpID);                 //업체ID
            mAdjustment_Type = pAdjustment_Type.ToString();      //정산구분
            mPerson_ID = Convert.ToInt32(pPerson_ID);            //사원ID
            mDept_ID = Convert.ToInt32(pDept_ID);                //부서ID
            mPayGrade_ID = Convert.ToInt32(pPayGrade_ID);        //직급ID
            mADJUSTMENT_ID = Convert.ToDecimal(pADJUSTMENT_ID);  //정산구분ID
        }

        #endregion;

        #region ----- Private Methods ----


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

        // 인쇄 부분
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
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }

            return vString;
        }

        #endregion;

        #region ----- XL Print 1 Method ----

        private void XLPrinting1(string pOutChoice)
        {
            System.DateTime vStartTime = DateTime.Now;
            string vMessageText = string.Empty;

            int vCountRow = girdRETIRE_ADJUSTMENT.RowCount; //girdRETIRE_ADJUSTMENT 그리드의 총 행수
            if (vCountRow < 1)
            {
                vMessageText = string.Format("Without Data");
                isAppInterfaceAdv1.OnAppMessage(vMessageText);
                System.Windows.Forms.Application.DoEvents();
                return;
            }

            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            //iedPRINT_DATE.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            System.Windows.Forms.Application.DoEvents();

            int vPageNumber = 0;

            vMessageText = string.Format(" Printing Starting...");
            isAppInterfaceAdv1.OnAppMessage(vMessageText);
            System.Windows.Forms.Application.DoEvents();

            XLPrinting1 xlPrinting = new XLPrinting1(isAppInterfaceAdv1.AppInterface, isMessageAdapter1);

            try
            {
                //-------------------------------------------------------------------------------------
                xlPrinting.OpenFileNameExcel = "HRMF0603_001.xls";
                //-------------------------------------------------------------------------------------

                //-------------------------------------------------------------------------------------
                // 명세서 선택 시, 해당 명세서 양식에 맞는 Printing... (다중 선택 가능)
                //-------------------------------------------------------------------------------------
                // 퇴직금 정산 내역
                if (RETIRE_ADJUSTMENT_YN.CheckBoxString == "Y")
                {
                    vPageNumber = xlPrinting.WriteRetireAdjustment(girdRETIRE_ADJUSTMENT, idaDETAIL_RETIRE_PAYMENT, idaSUM_RETIRE_PAYMENT, pOutChoice);
                    //vPageNumber = 0;
                }

                // 퇴직소득원천징수영수증/지급조서
                if (INVOICE_WITHHOLDING_TAX_YN.CheckBoxString == "Y")
                {
                    // 출력 용도 구분 체크
                    if (EARNER_YN.CheckBoxString != "Y" && ADDRESSOR1_YN.CheckBoxString != "Y" && ADDRESSOR2_YN.CheckBoxString != "Y")
                    {
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("출력 용도를 한 개 이상 선택해주세요."), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        EARNER_YN.Focus();
                        return;
                    }
                }     
            }
            catch (System.Exception ex)
            {
                vMessageText = ex.Message;
                isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
                System.Windows.Forms.Application.DoEvents();
            }

            //xlPrinting.PreView(1, vPageNumber);

            //-------------------------------------------------------------------------------------
            xlPrinting.Dispose();
            //-------------------------------------------------------------------------------------

            System.DateTime vEndTime = DateTime.Now;
            System.TimeSpan vTimeSpan = vEndTime - vStartTime;

            vMessageText = string.Format("Printing End [Total Page : {0}] ---> {1}", vPageNumber, vTimeSpan.ToString());
            isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
            System.Windows.Forms.Application.DoEvents();

            this.Cursor = System.Windows.Forms.Cursors.Default;
            System.Windows.Forms.Application.DoEvents();
        }

        #endregion;

        #region ----- XL Print 2 Method ----

        private void XLPrinting2(string pOutChoice)
        {
            System.DateTime vStartTime = DateTime.Now;
            string vMessageText = string.Empty;

            int vCountRow = gridWITHHOLDING_TAX.RowCount; //girdRETIRE_ADJUSTMENT 그리드의 총 행수
            int vCountRow2 = gridPRINT_2013.RowCount;
            string vRetire_Year = gridPRINT_2013.GetCellValue("FINAL_RETIRE_DATE").ToString();

            if (vRetire_Year == "2011" || vRetire_Year == "2012")
            {
                if (vCountRow < 1)
                {
                    vMessageText = string.Format("Without Data");
                    isAppInterfaceAdv1.OnAppMessage(vMessageText);
                    System.Windows.Forms.Application.DoEvents();
                    return;
                }               
            }
            else
            {
                if (vCountRow2 < 1)
                {
                    vMessageText = string.Format("Without Data");
                    isAppInterfaceAdv1.OnAppMessage(vMessageText);
                    System.Windows.Forms.Application.DoEvents();
                    return;
                }
            }

            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            //iedPRINT_DATE.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            System.Windows.Forms.Application.DoEvents();

            int vPageNumber = 0;

            vMessageText = string.Format(" Printing Starting...");
            isAppInterfaceAdv1.OnAppMessage(vMessageText);
            System.Windows.Forms.Application.DoEvents();

            XLPrinting2 xlPrinting = new XLPrinting2(isAppInterfaceAdv1.AppInterface, isMessageAdapter1);

            try
            {
                if (vRetire_Year == "2011" || vRetire_Year == "2012")
                {
                    //-------------------------------------------------------------------------------------
                    xlPrinting.OpenFileNameExcel = "HRMF0603_002.xls";
                    //-------------------------------------------------------------------------------------                    
                }
                else if (vRetire_Year == "2013" || vRetire_Year == "2014" || vRetire_Year == "2015")
                {
                    //-------------------------------------------------------------------------------------
                    xlPrinting.OpenFileNameExcel = "HRMF0603_003.xls";
                    //-------------------------------------------------------------------------------------
                }
                else
                {
                    //-------------------------------------------------------------------------------------
                    xlPrinting.OpenFileNameExcel = "HRMF0603_004.xls";
                    //-------------------------------------------------------------------------------------
                }

                // 퇴직소득원천징수영수증/지급조서
                if (INVOICE_WITHHOLDING_TAX_YN.CheckBoxString == "Y")
                {
                    // 출력 용도 구분 체크
                    if (EARNER_YN.CheckBoxString != "Y" && ADDRESSOR1_YN.CheckBoxString != "Y" && ADDRESSOR2_YN.CheckBoxString != "Y")
                    {
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("출력 용도를 한 개 이상 선택해주세요."), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        EARNER_YN.Focus();
                        return;
                    }

                    object vPrintType = null;
                    if (EARNER_YN.CheckBoxString == "Y")
                    {
                        vPrintType = "소득자 보관용";
                        vPageNumber = xlPrinting.WriteWithholdingTax(gridWITHHOLDING_TAX, gridPRINT_2013, vPrintType, pOutChoice);
                        vPageNumber = 0;
                    }
                    if (ADDRESSOR1_YN.CheckBoxString == "Y")
                    {
                        vPrintType = "발행자 보관용";
                        vPageNumber = xlPrinting.WriteWithholdingTax(gridWITHHOLDING_TAX, gridPRINT_2013, vPrintType, pOutChoice);
                        vPageNumber = 0;
                    }
                    if (ADDRESSOR2_YN.CheckBoxString == "Y")
                    {
                        vPrintType = "발행자 보고용";
                        vPageNumber = xlPrinting.WriteWithholdingTax(gridWITHHOLDING_TAX, gridPRINT_2013, vPrintType, pOutChoice);
                        vPageNumber = 0;
                    }
                }
            }
            catch (System.Exception ex)
            {
                vMessageText = ex.Message;
                isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
                System.Windows.Forms.Application.DoEvents();
            }

            //-------------------------------------------------------------------------------------
            xlPrinting.Dispose();
            //-------------------------------------------------------------------------------------

            System.DateTime vEndTime = DateTime.Now;
            System.TimeSpan vTimeSpan = vEndTime - vStartTime;

            vMessageText = string.Format("Printing End [Total Page : {0}] ---> {1}", vPageNumber, vTimeSpan.ToString());
            isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
            System.Windows.Forms.Application.DoEvents();

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
            }
        }

        #endregion;

        #region ----- Button Events -----

        // 명세서 발급 취소
        private void btnCANCEL_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            // EditBox 초기화
            CORP_ID.EditValue = null;         //업체ID
            ADJUSTMENT_TYPE.EditValue = null; //정산구분ID
            PERSON_ID.EditValue = null;       //사원ID
            DEPT_ID.EditValue = null;         //부서ID
            PAY_GRADE_ID.EditValue = null;    //직급ID

            // 명세서 발급 CheckBox 초기화
            RETIRE_ADJUSTMENT_YN.CheckBoxValue ="N";
            INVOICE_WITHHOLDING_TAX_YN.CheckBoxValue ="N";
            EARNER_YN.CheckBoxValue ="N";
            ADDRESSOR1_YN.CheckBoxValue ="N";
            ADDRESSOR2_YN.CheckBoxValue = "N";

            this.Close();
        }

        // 명세서 발급[인쇄]
        private void btnPRINT_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            PRINT("PRINT");
        }

        // 명세서 발급[저장]
        private void btnSAVE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            PRINT("FILE");
        }

        private void PRINT(string pOutChoice)
        {
            try
            {
                idaRETIRE_STANDARD.SetSelectParamValue("W_ADJUSTMENT_ID", mADJUSTMENT_ID);
                idaRETIRE_STANDARD.Fill();

                idaRETIRE_WITHHOLDING_TAX.SetSelectParamValue("W_ADJUSTMENT_ID", mADJUSTMENT_ID);
                idaRETIRE_WITHHOLDING_TAX.Fill();

                idaPRINT_2013.SetSelectParamValue("W_ADJUSTMENT_ID", mADJUSTMENT_ID);
                idaPRINT_2013.Fill();

                //-------------------------------------------------------------------------------------
                // 명세서 선택 여부 체크
                //-------------------------------------------------------------------------------------
                if (RETIRE_ADJUSTMENT_YN.CheckBoxString != "Y" && INVOICE_WITHHOLDING_TAX_YN.CheckBoxString != "Y")
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("명세서를 선택해주세요."), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    RETIRE_ADJUSTMENT_YN.Focus();
                    return;
                }

                if (INVOICE_WITHHOLDING_TAX_YN.CheckBoxString == "Y")
                {
                    // 출력 용도 구분 체크
                    if (EARNER_YN.CheckBoxString != "Y" && ADDRESSOR1_YN.CheckBoxString != "Y" && ADDRESSOR2_YN.CheckBoxString != "Y")
                    {
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("출력 용도를 한 개 이상 선택해주세요."), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        EARNER_YN.Focus();
                        return;
                    }
                }

                if (RETIRE_ADJUSTMENT_YN.CheckBoxString == "Y")
                {
                    XLPrinting1(pOutChoice);
                }

                if (INVOICE_WITHHOLDING_TAX_YN.CheckBoxString == "Y")
                {
                    XLPrinting2(pOutChoice);
                }
            }
            catch (System.Exception ex)
            {
                MessageBoxAdv.Show(ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }

            //MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10035"), "", MessageBoxButtons.OK, MessageBoxIcon.None);
            // 인쇄 완료 메시지 출력   
        }

        #endregion;

        #region ----- Form Event -----

        private void HRMF0603_PRINT_Load(object sender, EventArgs e)
        {
            CORP_ID.EditValue = mCorp_ID;                 //업체ID
            ADJUSTMENT_TYPE.EditValue = mAdjustment_Type; //정산구분ID
            PERSON_ID.EditValue = mPerson_ID;             //사원ID
            DEPT_ID.EditValue = mDept_ID;                 //부서ID
            PAY_GRADE_ID.EditValue = mPayGrade_ID;        //직급ID

            string vMessage = string.Format("{0} - Person_ID : {1} PayGrade_ID : {2} mAdjustment_Type : {3} mADJUSTMENT_ID : {4}", this.Text, mPerson_ID, mPayGrade_ID, mAdjustment_Type, mADJUSTMENT_ID);
            isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessage);
            System.Windows.Forms.Application.DoEvents();
        }

        #endregion;
    }
}