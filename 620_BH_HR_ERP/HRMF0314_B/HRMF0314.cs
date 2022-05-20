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

namespace HRMF0314
{
    public partial class HRMF0314 : Office2007Form
    {
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();
        ISFunction.ISConvert iString = new ISFunction.ISConvert();

        #region ----- Variables -----



        #endregion;

        #region ----- Constructor -----

        public HRMF0314(Form pMainForm, ISAppInterface pAppInterface)
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
        }

        private void Search_DB()
        {
            if (CORP_ID_0.EditValue == null)
            {// 업체.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME_0.Focus();
                return;
            }
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
            
            string vPERSON_NAME = iString.ISNull(igrMONTH_TOTAL.GetCellValue("DISPLAY_NAME"));
            int vIDX_Col = igrMONTH_TOTAL.GetColumnToIndex("DISPLAY_NAME");

            idaMONTH_TOTAL.Fill();
            if (igrMONTH_TOTAL.RowCount > 0)
            {
                for (int vRow = 0; vRow < igrMONTH_TOTAL.RowCount; vRow++)
                {
                    if(vPERSON_NAME == iString.ISNull(igrMONTH_TOTAL.GetCellValue(vRow, vIDX_Col)))
                    {
                        igrMONTH_TOTAL.CurrentCellActivate(vRow, vIDX_Col);
                        igrMONTH_TOTAL.CurrentCellMoveTo(vRow, vIDX_Col);
                    }
                }
            }
            igrMONTH_TOTAL.Focus();
        }

        private void Init_Total_Day_Count()
        {
            if (iString.ISNull(CLOSED_YN.CheckBoxValue) == "Y")
            {
                return;
            }

            int mNon_Pay_Count = 0;
            int mHOLY_0_COUNT = 0;
            //for (int r = 0; r < igrMONTH_DUTY.RowCount; r++)
            //{
            //    if (iString.ISNull(igrMONTH_DUTY.GetCellValue(r, igrMONTH_DUTY.GetColumnToIndex("NON_PAY_YN")), "Y") == "Y".ToString())
            //    {
            //        mNon_Pay_Count = mNon_Pay_Count + iString.ISNumtoZero(igrMONTH_DUTY.GetCellValue(r, igrMONTH_DUTY.GetColumnToIndex("DUTY_COUNT")), 0);
            //    }
            //}
            if (iString.ISNull(HOLY_0_DED_FLAG.EditValue) == "Y".ToString())
            {
                mHOLY_0_COUNT = iString.ISNumtoZero(HOLY_0_COUNT.EditValue, 0);
            }
            TOTAL_DED_DAY.EditValue = mNon_Pay_Count + iString.ISNumtoZero(WEEKLY_DED_COUNT.EditValue, 0) + iString.ISNumtoZero(LATE_DED_COUNT.EditValue, 0);
            PAY_DAY.EditValue = iString.ISNumtoZero(TOTAL_DAY.EditValue) - (iString.ISNumtoZero(TOTAL_DED_DAY.EditValue) + mHOLY_0_COUNT);
        }

        private void Init_Pay_Day_Count()
        {
            if (iString.ISNull(CLOSED_YN.CheckBoxValue) == "Y")
            {
                return;
            }
            int mHOLY_0_COUNT = 0;
            if (iString.ISNull(HOLY_0_DED_FLAG.EditValue) == "Y".ToString())
            {
                mHOLY_0_COUNT = iString.ISNumtoZero(HOLY_0_COUNT.EditValue, 0);
            }
            PAY_DAY.EditValue = iString.ISNumtoZero(TOTAL_DAY.EditValue) - (iString.ISNumtoZero(TOTAL_DED_DAY.EditValue) + mHOLY_0_COUNT);
        }

        private void isInit_Day_Count()
        {
            if (iString.ISNull(CLOSED_YN.CheckBoxValue) == "Y")
            {
                return;
            }

            idcINIT_TOT_DED_COUNT.ExecuteNonQuery();
            TOTAL_DED_DAY.EditValue = idcINIT_TOT_DED_COUNT.GetCommandParamValue("O_TOTAL_DED_COUNT");
            PAY_DAY.EditValue = idcINIT_TOT_DED_COUNT.GetCommandParamValue("O_PAY_DAY");
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
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    isInit_Day_Count();
                    idaMONTH_TOTAL.Update();                        
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaMONTH_TOTAL.IsFocused)
                    {
                        idaMONTH_TOTAL.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaMONTH_TOTAL.IsFocused)
                    {
                        idaMONTH_TOTAL.Delete();
                    }
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void HRMF0314_Load(object sender, EventArgs e)
        {
            this.Visible = true;

            idaMONTH_TOTAL.FillSchema();            
        }

        private void HRMF0314_Shown(object sender, EventArgs e)
        {
            // Year Month Setting
            ildYYYYMM.SetLookupParamValue("W_START_YYYYMM", "2010-01");
            DUTY_YYYYMM_0.EditValue = iDate.ISYearMonth(DateTime.Today);
            START_DATE_0.EditValue = iDate.ISMonth_1st(DateTime.Today);
            END_DATE_0.EditValue = iDate.ISMonth_Last(DateTime.Today);

            // CORP SETTING
            DefaultCorporation();

            // Duty TYPE SETTING
            ildDUTY_TYPE_0.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");

            idcDEFAULT_VALUE.ExecuteNonQuery();
            DUTY_TYPE_NAME_0.EditValue = idcDEFAULT_VALUE.GetCommandParamValue("O_CODE_NAME").ToString();
            DUTY_TYPE_0.EditValue = idcDEFAULT_VALUE.GetCommandParamValue("O_CODE").ToString();

            //DefaultSetFormReSize();             //[Child Form, Mdi Form에 맞게 ReSize]
        }

        private void ibtSET_MONTH_TOTAL_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (CORP_ID_0.EditValue == null)
            {// 업체.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME_0.Focus();
                return;
            }
            if (DUTY_TYPE_0.EditValue != null && string.IsNullOrEmpty(DUTY_TYPE_0.EditValue.ToString()))
            {// 월근태유형
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10059"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                DUTY_TYPE_NAME_0.Focus();
                return;
            }
            if (DUTY_YYYYMM_0.EditValue != null && string.IsNullOrEmpty(DUTY_YYYYMM_0.EditValue.ToString()))
            {// 월근태년월
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10036"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                DUTY_YYYYMM_0.Focus();
                return;
            }

            Application.UseWaitCursor = true;
            this.Cursor = Cursors.WaitCursor;
            Application.DoEvents();

            DialogResult vdlgResult;
            HRMF0314_SET vHRMF0314_SET = new HRMF0314_SET(isAppInterfaceAdv1.AppInterface,"CAL"
                                                        , CORP_ID_0.EditValue, CORP_NAME_0.EditValue
                                                        , DUTY_YYYYMM_0.EditValue, DUTY_TYPE_0.EditValue, DUTY_TYPE_NAME_0.EditValue
                                                        , DEPT_ID_0.EditValue, DEPT_NAME_0.EditValue, FLOOR_ID_0.EditValue, FLOOR_NAME_0.EditValue
                                                        , PERSON_ID_0.EditValue, NAME_0.EditValue);
            vdlgResult = vHRMF0314_SET.ShowDialog();
            if (vdlgResult == DialogResult.OK)
            {
                Search_DB();
            }
            vHRMF0314_SET.Dispose();

            Application.UseWaitCursor = false;
            this.Cursor = Cursors.Default;
            Application.DoEvents();


            //string mSTATUS = "F";
            //string mMESSAGE = null;
            //isDataTransaction1.BeginTran();

            //Application.DoEvents();
            //Application.UseWaitCursor = true;
            //this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            //idcSET_MONTH_TOTAL.ExecuteNonQuery();
            //mSTATUS = iString.ISNull(idcSET_MONTH_TOTAL.GetCommandParamValue("O_STATUS"));
            //mMESSAGE = iString.ISNull(idcSET_MONTH_TOTAL.GetCommandParamValue("O_MESSAGE"));
            //Application.DoEvents();
            //Application.UseWaitCursor = false;
            //this.Cursor = System.Windows.Forms.Cursors.Default;

            //if (idcSET_MONTH_TOTAL.ExcuteError || mSTATUS == "F")
            //{
            //    isDataTransaction1.RollBack();
            //    MessageBoxAdv.Show(mMESSAGE, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            //    return;
            //}

            //isDataTransaction1.Commit();
            //if (mMESSAGE != string.Empty)
            //{
            //    MessageBoxAdv.Show(mMESSAGE, "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);   
            //}
            //Search_DB();  // refill.
        }

        private void ibtSET_CLOSED_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (CORP_ID_0.EditValue == null)
            {// 업체.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME_0.Focus();
                return;
            }
            if (DUTY_TYPE_0.EditValue != null && string.IsNullOrEmpty(DUTY_TYPE_0.EditValue.ToString()))
            {// 월근태유형
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10059"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                DUTY_TYPE_NAME_0.Focus();
                return;
            }
            if (DUTY_YYYYMM_0.EditValue != null && string.IsNullOrEmpty(DUTY_YYYYMM_0.EditValue.ToString()))
            {// 월근태년월
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10036"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                DUTY_YYYYMM_0.Focus();
                return;
            }

            Application.UseWaitCursor = true;
            this.Cursor = Cursors.WaitCursor;
            Application.DoEvents();

            DialogResult vdlgResult;
            HRMF0314_SET vHRMF0314_SET = new HRMF0314_SET(isAppInterfaceAdv1.AppInterface, "CLOSE"
                                                        , CORP_ID_0.EditValue, CORP_NAME_0.EditValue
                                                        , DUTY_YYYYMM_0.EditValue, DUTY_TYPE_0.EditValue, DUTY_TYPE_NAME_0.EditValue
                                                        , DEPT_ID_0.EditValue, DEPT_NAME_0.EditValue, FLOOR_ID_0.EditValue, FLOOR_NAME_0.EditValue
                                                        , PERSON_ID_0.EditValue, NAME_0.EditValue);
            vdlgResult = vHRMF0314_SET.ShowDialog();
            if (vdlgResult == DialogResult.OK)
            {
                Search_DB();
            }
            vHRMF0314_SET.Dispose();

            Application.UseWaitCursor = false;
            this.Cursor = Cursors.Default;
            Application.DoEvents();
            //DialogResult vdlgResult;
            //vdlgResult = MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10314"), "Question", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            //if (vdlgResult == DialogResult.No)
            //{
            //    return;
            //}

            //string mSTATUS = "F";
            //string mMESSAGE = null;
            //isDataTransaction1.BeginTran();

            //Application.DoEvents();
            //Application.UseWaitCursor = true;
            //this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            //idcSET_CLOSED.ExecuteNonQuery();
            //mSTATUS = iString.ISNull(idcSET_CLOSED.GetCommandParamValue("O_STATUS"));
            //mMESSAGE = iString.ISNull(idcSET_CLOSED.GetCommandParamValue("O_MESSAGE"));
            //Application.DoEvents();
            //Application.UseWaitCursor = false;
            //this.Cursor = System.Windows.Forms.Cursors.Default;

            //if (idcSET_CLOSED.ExcuteError || mSTATUS == "F")
            //{
            //    isDataTransaction1.RollBack();
            //    MessageBoxAdv.Show(mMESSAGE, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            //    return;
            //}

            //isDataTransaction1.Commit();
            //if (mMESSAGE != string.Empty)
            //{
            //    MessageBoxAdv.Show(mMESSAGE, "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
            //}
            //Search_DB();  // refill.
        }

        private void ibtSET_CANCEL_CLOSED_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (CORP_ID_0.EditValue == null)
            {// 업체.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME_0.Focus();
                return;
            }
            if (DUTY_TYPE_0.EditValue != null && string.IsNullOrEmpty(DUTY_TYPE_0.EditValue.ToString()))
            {// 월근태유형
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10059"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                DUTY_TYPE_NAME_0.Focus();
                return;
            }
            if (DUTY_YYYYMM_0.EditValue != null && string.IsNullOrEmpty(DUTY_YYYYMM_0.EditValue.ToString()))
            {// 월근태년월
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10036"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                DUTY_YYYYMM_0.Focus();
                return;
            }

            Application.UseWaitCursor = true;
            this.Cursor = Cursors.WaitCursor;
            Application.DoEvents();

            DialogResult vdlgResult;
            HRMF0314_SET vHRMF0314_SET = new HRMF0314_SET(isAppInterfaceAdv1.AppInterface, "CLOSED_CANCEL"
                                                        , CORP_ID_0.EditValue, CORP_NAME_0.EditValue
                                                        , DUTY_YYYYMM_0.EditValue, DUTY_TYPE_0.EditValue, DUTY_TYPE_NAME_0.EditValue
                                                        , DEPT_ID_0.EditValue, DEPT_NAME_0.EditValue, FLOOR_ID_0.EditValue, FLOOR_NAME_0.EditValue
                                                        , PERSON_ID_0.EditValue, NAME_0.EditValue);
            vdlgResult = vHRMF0314_SET.ShowDialog();
            if (vdlgResult == DialogResult.OK)
            {
                Search_DB();
            }
            vHRMF0314_SET.Dispose();

            Application.UseWaitCursor = false;
            this.Cursor = Cursors.Default;
            Application.DoEvents();

            //DialogResult vdlgResult;
            //vdlgResult = MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10315"), "Question", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            //if (vdlgResult == DialogResult.No)
            //{
            //    return;
            //}

            //string mSTATUS = "F";
            //string mMESSAGE = null;
            //isDataTransaction1.BeginTran();

            //Application.DoEvents();
            //Application.UseWaitCursor = true;
            //this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            //idcSET_CANCEL_CLOSED.ExecuteNonQuery();
            //mSTATUS = iString.ISNull(idcSET_CANCEL_CLOSED.GetCommandParamValue("O_STATUS"));
            //mMESSAGE = iString.ISNull(idcSET_CANCEL_CLOSED.GetCommandParamValue("O_MESSAGE"));
            //Application.DoEvents();
            //Application.UseWaitCursor = false;
            //this.Cursor = System.Windows.Forms.Cursors.Default;

            //if (idcSET_CANCEL_CLOSED.ExcuteError || mSTATUS == "F")
            //{
            //    isDataTransaction1.RollBack();
            //    MessageBoxAdv.Show(mMESSAGE, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            //    return;
            //}

            //isDataTransaction1.Commit();
            //if (mMESSAGE != string.Empty)
            //{
            //    MessageBoxAdv.Show(mMESSAGE, "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
            //}
            //Search_DB();  // refill.
        }

        private void WEEKLY_DED_COUNT_EditValueChanged(object pSender)
        {
            Init_Total_Day_Count();
        }

        private void LATE_DED_COUNT_EditValueChanged(object pSender)
        {
            Init_Total_Day_Count();
        }

        private void TOTAL_DED_DAY_EditValueChanged(object pSender)
        {
            Init_Total_Day_Count();
        }

        #endregion  

        #region ----- Adapter Event -----

        private void idaMONTH_TOTAL_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (e.Row["MONTH_TOTAL_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Month Total ID(월근태ID)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        #endregion

        #region ----- LookUp Event -----
        private void ilaDEPT_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT_0.SetLookupParamValue("W_USABLE_CHECK_YN", "N");
        }

        private void ilaFLOOR_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "FLOOR");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        private void ilaPERSON_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildPERSON.SetLookupParamValue("W_END_DATE", END_DATE_0.EditValue);
        }

        private void ilaFLOOR_0_PrePopupShow_1(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildFLOOR_0.SetLookupParamValue("W_GROUP_CODE", "FLOOR");
            ildFLOOR_0.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        #endregion

    }
}