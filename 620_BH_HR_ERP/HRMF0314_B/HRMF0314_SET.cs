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
    public partial class HRMF0314_SET : Office2007Form
    {       

        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        string mPROCESS_TYPE;
        object mCORP_ID;
        object mCORP_NAME;
        object mDUTY_YYYYMM;
        object mDUTY_TYPE;
        object mDUTY_TYPE_NAME;
        object mDEPT_ID;
        object mDEPT_NAME;
        object mFLOOR_ID;
        object mFLOOR_NAME;
        object mPERSON_ID;
        object mPERSON_NAME;

        #endregion;

        #region ----- Constructor -----

        public HRMF0314_SET(ISAppInterface pAppInterface, string pPROCESS_TYPE, object pCorp_ID, object pCorp_NAME
                            , object pDuty_YYYYMM, object pDuty_Type, object pDuty_Type_NAME
                            , object pDept_ID, object pDept_Name
                            , object pFloor_ID, object pFloor_Name
                            , object pPerson_ID, object pPerson_Name)
        {
            InitializeComponent();
            isAppInterfaceAdv1.AppInterface = pAppInterface;
            mPROCESS_TYPE = pPROCESS_TYPE;
            mCORP_ID = pCorp_ID;
            mCORP_NAME = pCorp_NAME;
            mDUTY_YYYYMM = pDuty_YYYYMM;
            mDUTY_TYPE = pDuty_Type;
            mDUTY_TYPE_NAME = pDuty_Type_NAME;
            mDEPT_ID = pDept_ID;
            mDEPT_NAME = pDept_Name;
            mFLOOR_ID = pFloor_ID;
            mFLOOR_NAME = pFloor_Name;
            mPERSON_ID = pPerson_ID;
            mPERSON_NAME= pPerson_Name;
        }

        #endregion;

        #region ----- Private Methods ----

        private void Init_Process_Status()
        {
            if (mPROCESS_TYPE == "CAL")
            {
                TITLE.PromptTextElement[0].TL1_KR = "(월)근태 계산";
                TITLE.PromptTextElement[0].Default = "(Month) Duty Calculate";

                EXCEPT_YN.Visible = false;
                START_DATE.ReadOnly = false;
                START_DATE.Insertable = true;
                START_DATE.Updatable = true;
                END_DATE.ReadOnly = false;
                END_DATE.Insertable = true;
                END_DATE.Updatable = true;
            }
            else if (mPROCESS_TYPE == "CLOSE")
            {
                TITLE.PromptTextElement[0].TL1_KR = "(월)근태 마감";
                TITLE.PromptTextElement[0].Default = "(Month) Duty Close";

                EXCEPT_YN.Visible = false;
                START_DATE.ReadOnly = true;
                START_DATE.Insertable = false;
                START_DATE.Updatable = false;
                END_DATE.ReadOnly = true;
                END_DATE.Insertable = false;
                END_DATE.Updatable = false;
            }
            else if (mPROCESS_TYPE == "CLOSED_CANCEL")
            {
                TITLE.PromptTextElement[0].TL1_KR = "(월)근태 마감 취소";
                TITLE.PromptTextElement[0].Default = "(Month) Duty Closed Cancel";

                EXCEPT_YN.Visible = true;
                START_DATE.ReadOnly = true;
                START_DATE.Insertable = false;
                START_DATE.Updatable = false;
                END_DATE.ReadOnly = true;
                END_DATE.Insertable = false;
                END_DATE.Updatable = false;
            }
            EXCEPT_YN.Invalidate();
            TITLE.Invalidate();
            START_DATE.Invalidate();
            END_DATE.Invalidate();
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

        #region ----- Form Event -----

        private void HRMF0314_SET_Load(object sender, EventArgs e)
        {
            
        }

        private void HRMF0314_SET_Shown(object sender, EventArgs e)
        {
            Init_Process_Status();

            CORP_NAME.EditValue = mCORP_NAME;
            CORP_ID.EditValue = mCORP_ID;

            DUTY_YYYYMM.EditValue = mDUTY_YYYYMM;
            START_DATE.EditValue = iDate.ISMonth_1st(mDUTY_YYYYMM.ToString());
            END_DATE.EditValue = iDate.ISMonth_Last(mDUTY_YYYYMM.ToString());
            DUTY_TYPE.EditValue = mDUTY_TYPE;
            DUTY_TYPE_NAME.EditValue = mDUTY_TYPE_NAME;
            DEPT_ID.EditValue = mDEPT_ID;
            DEPT_NAME.EditValue = mDEPT_NAME;
            FLOOR_ID.EditValue = mFLOOR_ID;
            FLOOR_NAME.EditValue = mFLOOR_NAME;
            PERSON_ID.EditValue = mPERSON_ID;
            PERSON_NAME.EditValue = mPERSON_NAME;

            Application.UseWaitCursor = false;
            this.Cursor = Cursors.Default;
            Application.DoEvents();
        }
            
        private void ibtCREATE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (CORP_ID.EditValue == null)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME.Focus();
                return;
            }
            if (iString.ISNull(DUTY_YYYYMM.EditValue) == String.Empty)
            {// 근태년월
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10375"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                DUTY_YYYYMM.Focus();
                return;
            }
            if (iString.ISNull(DUTY_TYPE.EditValue) == string.Empty)
            {// 월근태구분
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10059"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                DUTY_TYPE_NAME.Focus();
                return;
            }
            if (iString.ISNull(START_DATE.EditValue) == string.Empty)
            {// 시작일자 구분
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                START_DATE.Focus();
                return;
            }
            if (iString.ISNull(END_DATE.EditValue) == string.Empty)
            {// 종료일자 구분
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                END_DATE.Focus();
                return;
            }
            if (iString.ISNull(DUTY_YYYYMM.EditValue) != iDate.ISYearMonth(START_DATE.DateTimeValue))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10418"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                START_DATE.Focus();
                return;
            }
            if (iString.ISNull(DUTY_YYYYMM.EditValue) != iDate.ISYearMonth(END_DATE.DateTimeValue))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10418"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                END_DATE.Focus();
                return;
            }
            string mSTATUS = "F";
            string mMESSAGE = null;
            if (mPROCESS_TYPE == "CAL")
            {
                DialogResult vdlgResult;
                vdlgResult = MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10313"), "Question", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
                if (vdlgResult == DialogResult.No)
                {
                    return;
                }

                isDataTransaction1.BeginTran();
                Application.UseWaitCursor = true;
                this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
                Application.DoEvents();
                idcSET_MONTH_TOTAL.ExecuteNonQuery();
                mSTATUS = iString.ISNull(idcSET_MONTH_TOTAL.GetCommandParamValue("O_STATUS"));
                mMESSAGE = iString.ISNull(idcSET_MONTH_TOTAL.GetCommandParamValue("O_MESSAGE"));

                Application.UseWaitCursor = false;
                this.Cursor = System.Windows.Forms.Cursors.Default;
                Application.DoEvents();

                if (idcSET_MONTH_TOTAL.ExcuteError || mSTATUS == "F")
                {
                    isDataTransaction1.RollBack();
                    MessageBoxAdv.Show(mMESSAGE, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return;
                }

                isDataTransaction1.Commit();
                if (mMESSAGE != string.Empty)
                {
                    MessageBoxAdv.Show(mMESSAGE, "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
            }
            else if (mPROCESS_TYPE == "CLOSE")
            {
                DialogResult vdlgResult;
                vdlgResult = MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10314"), "Question", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
                if (vdlgResult == DialogResult.No)
                {
                    return;
                }

                isDataTransaction1.BeginTran();
                Application.DoEvents();
                Application.UseWaitCursor = true;
                this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
                idcSET_CLOSED.ExecuteNonQuery();
                mSTATUS = iString.ISNull(idcSET_CLOSED.GetCommandParamValue("O_STATUS"));
                mMESSAGE = iString.ISNull(idcSET_CLOSED.GetCommandParamValue("O_MESSAGE"));
                Application.DoEvents();
                Application.UseWaitCursor = false;
                this.Cursor = System.Windows.Forms.Cursors.Default;

                if (idcSET_CLOSED.ExcuteError || mSTATUS == "F")
                {
                    isDataTransaction1.RollBack();
                    MessageBoxAdv.Show(mMESSAGE, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return;
                }

                isDataTransaction1.Commit();
                if (mMESSAGE != string.Empty)
                {
                    MessageBoxAdv.Show(mMESSAGE, "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
            }
            else if (mPROCESS_TYPE == "CLOSED_CANCEL")
            {
                DialogResult vdlgResult;
                vdlgResult = MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10315"), "Question", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
                if (vdlgResult == DialogResult.No)
                {
                    return;
                }

                isDataTransaction1.BeginTran();
                Application.DoEvents();
                Application.UseWaitCursor = true;
                this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
                idcSET_CANCEL_CLOSED.ExecuteNonQuery();
                mSTATUS = iString.ISNull(idcSET_CANCEL_CLOSED.GetCommandParamValue("O_STATUS"));
                mMESSAGE = iString.ISNull(idcSET_CANCEL_CLOSED.GetCommandParamValue("O_MESSAGE"));
                Application.DoEvents();
                Application.UseWaitCursor = false;
                this.Cursor = System.Windows.Forms.Cursors.Default;

                if (idcSET_CANCEL_CLOSED.ExcuteError || mSTATUS == "F")
                {
                    isDataTransaction1.RollBack();
                    MessageBoxAdv.Show(mMESSAGE, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return;
                }

                isDataTransaction1.Commit();
                if (mMESSAGE != string.Empty)
                {
                    MessageBoxAdv.Show(mMESSAGE, "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
            }
            DialogResult = DialogResult.OK;
            this.Close();
        }

        private void ibtCANCEL_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            DialogResult = DialogResult.None;
            this.Close();
        }

        #endregion              

        #region ----- Lookup Event -----

        private void ilaCORP_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCORP.SetLookupParamValue("W_DUTY_CONTROL_YN", "Y");
            ildCORP.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        private void ilaWAGE_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON_W.SetLookupParamValue("W_GROUP_CODE", "CLOSING_TYPE");
            ildCOMMON_W.SetLookupParamValue("W_WHERE", "HC.VALUE1 = 'DUTY' ");
            ildCOMMON_W.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        private void ilaPAY_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "FLOOR");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG", "Y");
        }

        private void ilaDEPT_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT.SetLookupParamValue("W_USABLE_CHECK_YN", "Y");
        }

        private void ilaYYYYMM_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildYYYYMM.SetLookupParamValue("W_START_YYYYMM", "2001-01");
            ildYYYYMM.SetLookupParamValue("W_END_YYYYMM", iDate.ISYearMonth(DateTime.Today));
        }

        #endregion
    
    }
}