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
using InfoSummit.Win.ControlAdv;
using ISCommonUtil;

namespace HRMF0506
{
    public partial class HRMF0506 : Office2007Form
    {
        #region ----- Variables -----

        private ISCommonUtil.ISFunction.ISConvert iString = new ISFunction.ISConvert();
        private ISCommonUtil.ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;
        
        #region ----- Constructor -----
        public HRMF0506(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }
        #endregion;

        #region ----- Private Methods ----
        private void DefaultSetFormReSize()
        {//[Child Form, Mdi Form에 맞게 ReSize]
            int vMinusWidth = 4;
            int vMinusHeight = 54;
            System.Drawing.Size vSize = this.MdiParent.ClientSize;
            this.Width = vSize.Width - vMinusWidth;
            this.Height = vSize.Height - vMinusHeight;
        }

        private void DefaultCorp()
        {
            // Lookup SETTING
            ildCORP.SetLookupParamValue("W_DUTY_CONTROL_YN", "Y");
            ildCORP.SetLookupParamValue("W_USABLE_CHECK_YN", "N");

            // LOOKUP DEFAULT VALUE SETTING - CORP
            idcDEFAULT_CORP.SetCommandParamValue("W_DUTY_CONTROL_YN", "Y");
            idcDEFAULT_CORP.ExecuteNonQuery();

            CORP_NAME_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_NAME");
            CORP_ID_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_ID");
        }

        private void Search_DB()
        {
            if (CORP_ID_0.EditValue == null)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME_0.Focus();
                return;
            }

            if (iString.ISNull(START_YYYYMM_0.EditValue) == String.Empty)
            {// 시작년월
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10036"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                START_YYYYMM_0.Focus();
                return;
            }
            if (iString.ISNull(END_YYYYMM_0.EditValue) == String.Empty)
            {// 종료년월
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10036"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                END_YYYYMM_0.Focus();
                return;
            }
            idaPAY_MASTER.SetSelectParamValue("W_STD_YYYYMM",END_YYYYMM_0.EditValue);
            idaPAY_MASTER.SetSelectParamValue("W_PAY_TYPE", PAY_GRADE_NAME_0.EditValue);

            idaPAY_MASTER.Fill();
            igrPERSON.Focus();
            
        }
       

        #endregion;

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
                    if (idaPAYMENT_TERM.IsFocused)
                    {
                        idaPAYMENT_TERM.AddOver();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaPAYMENT_TERM.IsFocused)
                    {
                        idaPAYMENT_TERM.AddUnder();
                    } 
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    idaPAY_MASTER.Update();                    
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaPAY_MASTER.IsFocused)
                    {
                        idaPAY_MASTER.Cancel();
                    }
                    else if (idaPAYMENT_TERM.IsFocused)
                    {
                        idaPAYMENT_TERM.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaPAY_MASTER.IsFocused)
                    {
                        idaPAY_MASTER.Delete();
                    }
                    else if (idaPAYMENT_TERM.IsFocused)
                    {
                        idaPAYMENT_TERM.Delete();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {
                    XLPrinting_1("PRINT", idaPRINT_PAYMENT_TERM);
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                    XLPrinting_1("FILE", idaPRINT_PAYMENT_TERM);
                }
            }
        }
        #endregion;

        #region ----- Form Event -----
        private void HRMF0506_Load(object sender, EventArgs e)
        {
            ildYYYYMM.SetLookupParamValue("W_START_YYYYMM", "2009-01");

            START_YYYYMM_0.EditValue = iDate.ISYear(DateTime.Today) + "-01".ToString();
            END_YYYYMM_0.EditValue = iDate.ISYearMonth(DateTime.Today);
                        
            DefaultCorp();              //Default Corp.
        }
        #endregion  

        #region ----- Adapter Event -----
        // Pay Master 항목.
        //private void idaGRADE_HEADER_PreRowUpdate(ISPreRowUpdateEventArgs e)
        //{
        //    if (e.Row["CORP_ID"] == DBNull.Value)
        //    {
        //        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Corporation(업체)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        //        e.Cancel = true;
        //        return;
        //    }
        //    if (iString.ISNull(e.Row["START_YYYYMM"]) == string.Empty)
        //    {
        //        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Start Year Month(시작년월)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        //        e.Cancel = true;
        //        return;
        //    }
        //    if (e.Row["PERSON_ID"] == DBNull.Value)
        //    {
        //        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Person(사원)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        //        e.Cancel = true;
        //        return;
        //    }
        //    if (e.Row["PAY_TYPE"] == DBNull.Value)
        //    {
        //        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Pay Type(급여제)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        //        e.Cancel = true;
        //        return;
        //    }
        //    if (e.Row["PAY_GRADE_ID"] == DBNull.Value)
        //    {
        //        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Pay Grade(직급)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        //        e.Cancel = true;
        //        return;
        //    }
        //}

        //private void idaGRADE_HEADER_PreDelete(ISPreDeleteEventArgs e)
        //{
        //    if (e.Row.RowState != DataRowState.Added)
        //    {
        //        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:=Data(해당 자료)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
        //        e.Cancel = true;
        //        return;
        //    }
        //}

        //// Allowance 항목.
        //private void idaPAY_ALLOWANCE_PreRowUpdate(ISPreRowUpdateEventArgs e)
        //{
        //    if (e.Row["ALLOWANCE_ID"] == DBNull.Value)
        //    {
        //        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Allowance(항목)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        //        e.Cancel = true;
        //        return;
        //    }
        //    if (e.Row["ALLOWANCE_AMOUNT"] == DBNull.Value)
        //    {
        //        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Allowance Amount(금액)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        //        e.Cancel = true;
        //        return;
        //    }
        //}

        //private void idaPAY_ALLOWANCE_PreDelete(ISPreDeleteEventArgs e)
        //{
        //    if (e.Row.RowState != DataRowState.Added)
        //    {
        //        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:=Data(해당 자료)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
        //        e.Cancel = true;
        //        return;
        //    }
        //}

        //// Deduction 항목.
        //private void idaPAY_DEDUCTION_PreRowUpdate(ISPreRowUpdateEventArgs e)
        //{
        //    if (e.Row["ALLOWANCE_ID"] == DBNull.Value)
        //    {
        //        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Allowance(항목)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        //        e.Cancel = true;
        //        return;
        //    }
        //    if (e.Row["ALLOWANCE_AMOUNT"] == DBNull.Value)
        //    {
        //        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Allowance Amount(금액)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        //        e.Cancel = true;
        //        return;
        //    }
        //}

        //private void idaPAY_DEDUCTION_PreDelete(ISPreDeleteEventArgs e)
        //{
        //    if (e.Row.RowState != DataRowState.Added)
        //    {
        //        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:=Data(해당 자료)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
        //        e.Cancel = true;
        //        return;
        //    }
        //}      
        #endregion

        #region ----- LookUp Event -----
        private void ilaPAY_GRADE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "PAY_GRADE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        private void ilaPERSON_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            string vYYYYMM = iString.ISNull(END_YYYYMM_0.EditValue);
            string vYYYY = vYYYYMM.Substring(0, 4);
            string vMM = vYYYYMM.Substring(5, 2);
            int vYYYY_Integer = int.Parse(vYYYY);
            int vMM_Integer = int.Parse(vMM);
            System.DateTime vDateTime = iDate.ISMonth_Last(new System.DateTime(vYYYY_Integer, vMM_Integer, 1));
            ildPERSON_0.SetLookupParamValue("W_WORK_DATE_TO", vDateTime);
        }

        #endregion

        #region ----- XL Print 1 Method ----

        private void XLPrinting_1(string pOutChoice, InfoSummit.Win.ControlAdv.ISDataAdapter pAdapter)
        {
            string vMessageText = string.Empty;
            string vSaveFileName = string.Empty;

            pAdapter.Fill();

            //object vObject_01 = pAdapter.GetSelectParamValue("W_CORP_ID");
            //object vObject_02 = pAdapter.GetSelectParamValue("W_START_YYYYMM");
            //object vObject_03 = pAdapter.GetSelectParamValue("W_END_YYYYMM");
            //object vObject_04 = pAdapter.GetSelectParamValue("W_PAY_GRADE_ID");
            //object vObject_05 = pAdapter.GetSelectParamValue("W_DEPT_ID");
            //object vObject_06 = pAdapter.GetSelectParamValue("W_PERSON_ID");

            if (pAdapter.OraSelectData.Rows == null)
            {
                return;
            }

            int vCountRow = pAdapter.OraSelectData.Rows.Count;

            if (vCountRow < 1)
            {
                vMessageText = string.Format("Without Data");
                isAppInterfaceAdv1.OnAppMessage(vMessageText);
                System.Windows.Forms.Application.DoEvents();
                return;
            }

            System.Windows.Forms.Application.UseWaitCursor = true;
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            System.Windows.Forms.Application.DoEvents();

            int vPageNumber = 0;

            vMessageText = string.Format(" Printing Starting...");
            isAppInterfaceAdv1.OnAppMessage(vMessageText);
            System.Windows.Forms.Application.DoEvents();

            XLPrinting xlPrinting = new XLPrinting(isAppInterfaceAdv1.AppInterface, isMessageAdapter1);

            try
            {
                vMessageText = string.Format(" XL Opening...");
                isAppInterfaceAdv1.OnAppMessage(vMessageText);
                System.Windows.Forms.Application.DoEvents();


                string vLoginUser = string.Format("{0}[{1}]", isAppInterfaceAdv1.AppInterface.LoginDescription, isAppInterfaceAdv1.DEPT_NAME);
                string vAssembly = this.Name;
                string vPERIOD = string.Format("{0} ~ {1}", START_YYYYMM_0.EditValue, END_YYYYMM_0.EditValue);

                //-------------------------------------------------------------------------------------
                xlPrinting.OpenFileNameExcel = "HRMF0506_001.xls";
                //-------------------------------------------------------------------------------------

                //-------------------------------------------------------------------------------------
                bool isOpen = xlPrinting.XLFileOpen();
                //-------------------------------------------------------------------------------------

                //-------------------------------------------------------------------------------------
                if (isOpen == true)
                {
                    vPageNumber = xlPrinting.LineWrite(pAdapter.OraSelectData, vLoginUser, vAssembly, vPERIOD);

                    if (pOutChoice == "PRINT")
                    {
                        xlPrinting.Printing(1, vPageNumber);
                    }
                    else if (pOutChoice == "FILE")
                    {
                        xlPrinting.SAVE("PAYMENT_TERM_");
                    }

                    //-------------------------------------------------------------------------------------
                    xlPrinting.Dispose();
                    //-------------------------------------------------------------------------------------

                    vMessageText = string.Format("Printing End [Total Page : {0}]", vPageNumber);
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
    }
}