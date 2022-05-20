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

namespace HRMF0603
{
    public partial class HRMF0603 : Office2007Form
    {
        #region ----- Variables -----

        private ISCommonUtil.ISFunction.ISConvert iString = new ISFunction.ISConvert();
        private ISCommonUtil.ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;
        
        #region ----- Constructor -----

        public HRMF0603(Form pMainForm, ISAppInterface pAppInterface)
        {
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
            ildCORP.SetLookupParamValue("W_PAY_CONTROL_YN", "Y");
            ildCORP.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");

            // LOOKUP DEFAULT VALUE SETTING - CORP
            idcDEFAULT_CORP.SetCommandParamValue("W_PAY_CONTROL_YN", "Y");
            idcDEFAULT_CORP.SetCommandParamValue("W_ENABLED_FLAG_YN", "N");
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

            if (iString.ISNull(ADJUSTMENT_TYPE_0.EditValue) == String.Empty)
            {// 시작일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10023"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                ADJUSTMENT_TYPE_NAME_0.Focus();
                return;
            }
            idaPERSON.Fill();
            igrPERSON.Focus();
        }

        private void Insert_Retire_Cal()
        {
            object mStart_Date;
            object mEnd_Date;
            if (iString.ISNull(EXPIRE_DATE.EditValue) != string.Empty)
            {
                DateTime mEXPIRE_DATE = Convert.ToDateTime(EXPIRE_DATE.EditValue);
                mStart_Date = iDate.ISDate_Add(mEXPIRE_DATE, 1);
            }
            else
            {
                mStart_Date = ORI_JOIN_DATE.EditValue;
            }
            if (iString.ISNull(RETIRE_DATE.EditValue) != string.Empty)
            {
                mEnd_Date = RETIRE_DATE.EditValue;
            }
            else
            {
                mEnd_Date = DateTime.Today;
            }
            RETIRE_DATE_FR.EditValue = mStart_Date;
            RETIRE_DATE_TO.EditValue = mEnd_Date;
            PAY_DATE_TO.EditValue = mEnd_Date;

            CORP_ID.EditValue = CORP_ID_0.EditValue;
            PERSON_ID.EditValue = igrPERSON.GetCellValue("PERSON_ID");
            ADJUSTMENT_TYPE.EditValue = ADJUSTMENT_TYPE_0.EditValue;
        }

        private void Insert_Pay()
        {
            igrPAYMENT_PAY.SetCellValue("ADJUSTMENT_ID", ADJUSTMENT_ID.EditValue);
            igrPAYMENT_PAY.SetCellValue("WAGE_TYPE", WAGE_TYPE_P1.EditValue);
        }

        private void Insert_Bonus()
        {
            igrPAYMENT_BONUS.SetCellValue("ADJUSTMENT_ID", ADJUSTMENT_ID.EditValue);
            igrPAYMENT_BONUS.SetCellValue("WAGE_TYPE", WAGE_TYPE_P2.EditValue);
        }

        private void Insert_Pay_Detail()
        {
            igrPAY_DETAIL.SetCellValue("ADJUSTMENT_ID", ADJUSTMENT_ID.EditValue);
            igrPAY_DETAIL.SetCellValue("WAGE_TYPE", WAGE_TYPE_P1.EditValue);
        }

        private void Insert_Bonus_Detail()
        {
            igrBONUS_DETAIL.SetCellValue("ADJUSTMENT_ID", ADJUSTMENT_ID.EditValue);
            igrBONUS_DETAIL.SetCellValue("WAGE_TYPE", WAGE_TYPE_P2.EditValue);
        }

        private void SET_RE_CALCULATE(object pRETIRE_CAL_TYPE)
        {
            idaPAYMENT_PAY.Update();
            idaPAYMENT_BONUS.Update();
            idaRETIRE_ADJUSTMENT.Update();

            Application.UseWaitCursor = true;
            this.Cursor = Cursors.WaitCursor;
            Application.DoEvents();

            string mSTATUS = "F";
            string mMessage = null;
            isDataTransaction1.BeginTran();            

            // 실행.
            idcRETIRE_CALCULATE.SetCommandParamValue("W_RETIRE_CAL_TYPE", pRETIRE_CAL_TYPE);
            idcRETIRE_CALCULATE.ExecuteNonQuery();
            mSTATUS = iString.ISNull(idcRETIRE_CALCULATE.GetCommandParamValue("O_STATUS"));
            mMessage = iString.ISNull(idcRETIRE_CALCULATE.GetCommandParamValue("O_MESSAGE"));
            Application.UseWaitCursor = false;
            this.Cursor = Cursors.Default;
            Application.DoEvents();

            if (idcRETIRE_CALCULATE.ExcuteError || mSTATUS == "F")
            {
                isDataTransaction1.RollBack();
                if (mMessage != string.Empty)
                {
                    MessageBoxAdv.Show(mMessage, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
                return;
            }
            isDataTransaction1.Commit();
            idaRETIRE_ADJUSTMENT.Fill();
        }

        #endregion;

        #region ----- DialogBox Print Form View Method -----

        private void isOnPrinting()
        {
            if (CORP_ID_0.EditValue == null) // 업체명
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME_0.Focus();
                return;
            }

            if (iString.ISNull(ADJUSTMENT_TYPE_0.EditValue) == String.Empty) // 정산구분
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10023"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                ADJUSTMENT_TYPE_NAME_0.Focus();
                return;
            }

            if (iString.ISNull(PERSON_NAME.EditValue) == String.Empty) // 직원 선택 여부 체크
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("해당 인원에 대한 정보를 선택해주세요."), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                igrPERSON.Focus();
                return;
            }

            // Child Form Load
            DialogResult vdlgResult;
            HRMF0603_PRINT vHRMF0603_PRINT = new HRMF0603_PRINT( isAppInterfaceAdv1.AppInterface
                                                               , CORP_ID_0.EditValue
                                                               , ADJUSTMENT_TYPE_0.EditValue
                                                               , igrPERSON.GetCellValue("PERSON_ID")
                                                               , igrPERSON.GetCellValue("DEPT_ID")
                                                               , igrPERSON.GetCellValue("PAY_GRADE_ID")
                                                               , ADJUSTMENT_ID.EditValue
                                                               );

            vdlgResult = vHRMF0603_PRINT.ShowDialog();
            if (vdlgResult == DialogResult.OK)
            { }
            vHRMF0603_PRINT.Dispose();
        }

        #endregion;

        #region ------ Initialize -----

        private void Init_Real_Amount()
        {            
            // 실 총지급액 정리.
            REAL_TOTAL_AMOUNT.EditValue = iString.ISDecimaltoZero(REAL_AMOUNT.EditValue) + iString.ISDecimaltoZero(H_REAL_AMOUNT.EditValue)
                                        - iString.ISDecimaltoZero(ETC_DED_AMOUNT.EditValue)
                                        - iString.ISDecimaltoZero(HEALTH_INSUR_AMOUNT.EditValue);
            if (iString.ISDecimaltoZero(REAL_TOTAL_AMOUNT.EditValue) < 0)
            {
                REAL_TOTAL_AMOUNT.EditValue = 0;
            }
        }

        #endregion

        #region ----- isAppInterfaceAdv1_AppMainButtonClick Events ------

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
                    if (idaPERSON.IsFocused || idaRETIRE_ADJUSTMENT.IsFocused)
                    {
                        idaRETIRE_ADJUSTMENT.AddOver();
                        Insert_Retire_Cal();
                    }
                    //else if (idaPAYMENT_PAY.IsFocused)
                    //{
                    //    idaPAYMENT_PAY.AddOver();
                    //    Insert_Pay();
                    //}
                    //else if (idaPAYMENT_BONUS.IsFocused)
                    //{
                    //    idaPAYMENT_BONUS.AddOver();
                    //    Insert_Bonus();
                    //}
                    else if (idaPAY_DETAIL.IsFocused)
                    {
                        idaPAY_DETAIL.AddOver();
                        Insert_Pay_Detail();
                    }
                    else if (idaBONUS_DETAIL.IsFocused)
                    {
                        idaBONUS_DETAIL.AddOver();
                        Insert_Bonus_Detail();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaPERSON.IsFocused || idaRETIRE_ADJUSTMENT.IsFocused)
                    {
                        idaRETIRE_ADJUSTMENT.AddUnder();
                        Insert_Retire_Cal();
                    }
                    //else if (idaPAYMENT_PAY.IsFocused)
                    //{
                    //    idaPAYMENT_PAY.AddUnder();
                    //    Insert_Pay();
                    //}
                    //else if (idaPAYMENT_BONUS.IsFocused)
                    //{
                    //    idaPAYMENT_BONUS.AddUnder();
                    //    Insert_Bonus();
                    //}
                    else if (idaPAY_DETAIL.IsFocused)
                    {
                        idaPAY_DETAIL.AddUnder();
                        Insert_Pay_Detail();
                    }
                    else if (idaBONUS_DETAIL.IsFocused)
                    {
                        idaBONUS_DETAIL.AddUnder();
                        Insert_Bonus_Detail();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    //Init_Real_Amount();
                    //idaPAYMENT_PAY.Update();
                    //idaPAYMENT_BONUS.Update();
                    PERSON_NAME.Focus();
                    idaRETIRE_ADJUSTMENT.Update();
                    idaPAY_DETAIL.Update();
                    idaBONUS_DETAIL.Update();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaPERSON.IsFocused || idaRETIRE_ADJUSTMENT.IsFocused)
                    {
                        idaRETIRE_ADJUSTMENT.Cancel();
                    }
                    else if (idaPAYMENT_PAY.IsFocused)
                    {
                        idaPAYMENT_PAY.Cancel();
                    }
                    else if (idaPAYMENT_BONUS.IsFocused)
                    {
                        idaPAYMENT_BONUS.Cancel();
                    }
                    else if (idaPAY_DETAIL.IsFocused)
                    {
                        idaPAY_DETAIL.Cancel();
                    }
                    else if (idaBONUS_DETAIL.IsFocused)
                    {
                        idaBONUS_DETAIL.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaPERSON.IsFocused || idaRETIRE_ADJUSTMENT.IsFocused)
                    {
                        idaRETIRE_ADJUSTMENT.Delete();
                    }
                    else if (idaPAYMENT_PAY.IsFocused)
                    {
                        idaPAYMENT_PAY.Delete();
                    }
                    else if (idaPAYMENT_BONUS.IsFocused)
                    {
                        idaPAYMENT_BONUS.Delete();
                    }
                    else if (idaPAY_DETAIL.IsFocused)
                    {
                        idaPAY_DETAIL.Delete();
                    }
                    else if (idaBONUS_DETAIL.IsFocused)
                    {
                        idaBONUS_DETAIL.Delete();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {
                    isOnPrinting();
                }
            }
        }
        #endregion;

        #region ----- Form Event -----

        private void HRMF0603_Load(object sender, EventArgs e)
        {            
            DefaultCorporation();              //Default Corp.
            //DefaultSetFormReSize();		//[Child Form, Mdi Form에 맞게 ReSize]           
        }

        private void HRMF0603_Shown(object sender, EventArgs e)
        {
            //idaPAY_MASTER_HEADER.FillSchema();
            idaPERSON.FillSchema();           
        }

        private void ETC_DED_AMOUNT_CurrentEditValidating(object pSender, ISEditAdvValidatingEventArgs e)
        {
            Init_Real_Amount();
        }

        private void ibtPAYMENT_SEARCH_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (ADJUSTMENT_ID.EditValue == null)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText(""), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            idaPAY_DETAIL.Fill();
            idaBONUS_DETAIL.Fill();
        }

        private void ibtRETIRE_CALCULATE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            SET_RE_CALCULATE("NEW");
        }

        private void ibtRE_CALCULATE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            SET_RE_CALCULATE("UPDATE");
        }

        private void ibtCLOSED_YN_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            idaADJUSTMENT_CLOSED.Update();
        }

        private void btnPAYMENT_PERIOD_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (iString.ISNull(ADJUSTMENT_ID.EditValue) == string.Empty)
            {
                return;
            }

            DialogResult dlgResult;
            HRMF0603_PAYMENT_PERIOD vHRMF0603_PAYMENT_PERIOD = new HRMF0603_PAYMENT_PERIOD(isAppInterfaceAdv1.AppInterface, ADJUSTMENT_ID.EditValue, "P1");

            dlgResult = vHRMF0603_PAYMENT_PERIOD.ShowDialog();
            if (dlgResult == DialogResult.OK)
            {
            }
            vHRMF0603_PAYMENT_PERIOD.Dispose();
        }

        private void RETIRE_AMOUNT_CurrentEditValidated(object pSender, ISEditAdvValidatedEventArgs e)
        {
            SET_RE_CALCULATE("TAX");
        }

        private void BTN_PREVIOUS_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            idaRETIRE_ADJUSTMENT.MovePrevious(TOTAL_PAY_AMOUNT.Name);
        }

        private void BTN_NEXT_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            idaRETIRE_ADJUSTMENT.MoveNext(TOTAL_PAY_AMOUNT.Name);
        }

        #endregion  

        #region ----- LookUp Event -----
        private void ilaADJUSTMENT_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "RETIRE_ADJUSTMENT_TYPE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        private void ilaPAY_GRADE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "PAY_GRADE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        private void ilaDEPT_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT.SetLookupParamValue("W_USABLE_CHECK_YN", "N");
        }

        private void ilaPAY_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "PAY_TYPE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        private void ilaALLOWANCE_PAY_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "ALLOWANCE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        private void ilaALLOWANCE_BONUS_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "ALLOWANCE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        #endregion

        #region ----- Adapter Event -----

        private void idaPAYMENT_PAY_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["ADJUSTMENT_ID"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10023"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["PAY_YYYYMM"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10107"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["WAGE_TYPE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10105"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaPAYMENT_PAY_PreDelete(ISPreDeleteEventArgs e)
        {
            
        }

        private void idaPAYMENT_BONUS_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["ADJUSTMENT_ID"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10023"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["PAY_YYYYMM"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10107"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["WAGE_TYPE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10105"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaPAYMENT_BONUS_PreDelete(ISPreDeleteEventArgs e)
        {
            
        }

        private void idaPERSON_NewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            idaRETIRE_ADJUSTMENT.Fill();
        }

        private void idaADJUSTMENT_CLOSED_UpdateCompleted(object pSender)
        {
            Search_DB();
        }

        #endregion

    }
}