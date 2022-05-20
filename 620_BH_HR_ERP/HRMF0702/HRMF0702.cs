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

namespace HRMF0702
{
    public partial class HRMF0702 : Office2007Form
    {
        ISCommonUtil.ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISCommonUtil.ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #region ----- Variables -----

        #endregion;

        #region ----- Constructor -----

        public HRMF0702()
        {
            InitializeComponent();
        }

        public HRMF0702(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----


        #endregion;

        #region ----- Events -----

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    // 조회 전, 조건 체크하는 부분
                    if (iString.ISNull(CORP_NAME_0.EditValue) == string.Empty)
                    {
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        CORP_NAME_0.Focus();
                        return;
                    }
                    if (iString.ISNull(STANDARD_DATE_0.EditValue) == string.Empty)
                    {
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10036"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        STANDARD_DATE_0.Focus();
                        return;
                    }
                    if (iString.ISNull(PERSON_NAME_0.EditValue) == string.Empty)
                    {
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10037"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        PERSON_NAME_0.Focus();
                        return;
                    }

                    // Person Info.
                    idaPERSON_INFO.Fill();

                    //제1 종전근무지
                    idaSEQ_ONE_INFO.Fill();

                    //제2 종전근무지                    
                    idaSEQ_TWO_INFO.Fill();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    // 새로운 데이터 등록 시, 기준 사용자 조회 체크
                    if (iString.ISNull(PERSON_NAME_1.EditValue) == string.Empty)
                    {
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10058"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        PERSON_NAME_0.Focus();
                        return;
                    }

                    if (idaSEQ_ONE_INFO.IsFocused)
                    {
                        idaSEQ_ONE_INFO.AddOver();
                        //제1종전근무지 자료 순서
                        SEQ_NUM_1.EditValue = 1;
                    }
                    if (idaSEQ_TWO_INFO.IsFocused)
                    {
                        idaSEQ_TWO_INFO.AddOver();
                        //제2종전근무지 자료 순서
                        SEQ_NUM_2.EditValue = 2;
                    }
                    
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    // 새로운 데이터 등록 시, 기준 사용자 조회 체크
                    if (iString.ISNull(PERSON_NAME_1.EditValue) == string.Empty)
                    {
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10058"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        PERSON_NAME_0.Focus();
                        return;
                    }

                    if (idaSEQ_ONE_INFO.IsFocused)
                    {
                        idaSEQ_ONE_INFO.AddUnder();
                        //제1종전근무지 자료 순서
                        SEQ_NUM_1.EditValue = 1;
                    }
                    if (idaSEQ_TWO_INFO.IsFocused)
                    {
                        idaSEQ_TWO_INFO.AddUnder();
                        //제2종전근무지 자료 순서
                        SEQ_NUM_2.EditValue = 2;
                    }

                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    /*if (Convert.ToInt32(SEQ_NUM_1.EditValue) == Convert.ToInt32(SEQ_NUM_2.EditValue))
                    {
                        MessageBoxAdv.Show("순서가 중복될 수 없습니다.");
                        return;
                    }
                    if (Convert.ToInt32(SEQ_NUM_1.EditValue) != 0 || Convert.ToInt32(SEQ_NUM_1.EditValue) != 1)
                    {
                        MessageBoxAdv.Show("Sequence Error!");
                        SEQ_NUM_1.Focus();
                        return;
                    }
                    if (Convert.ToInt32(SEQ_NUM_2.EditValue) != 0 || Convert.ToInt32(SEQ_NUM_2.EditValue) != 2)
                    {
                        MessageBoxAdv.Show("Sequence Error!");
                        SEQ_NUM_2.Focus();
                        return;
                    }*/
                    idaPERSON_INFO.Update();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaSEQ_ONE_INFO.IsFocused)
                    {
                        idaSEQ_ONE_INFO.Cancel();
                    }
                    if (idaSEQ_TWO_INFO.IsFocused)
                    {
                        idaSEQ_TWO_INFO.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaSEQ_ONE_INFO.IsFocused)
                    {
                        idaSEQ_ONE_INFO.Delete();
                    }
                    if (idaSEQ_TWO_INFO.IsFocused)
                    {
                        idaSEQ_TWO_INFO.Delete();
                    }
                }
            }
        }

        #endregion;

        #region ----- Form Event ------

        private void HRMF0702_Load(object sender, EventArgs e)
        {
            //idaPERSON_INFO.FillSchema();

            // Lookup SETTING
            ildCORP_0.SetLookupParamValue("W_PAY_CONTROL_YN", "Y");
            ildCORP_0.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");

            // LOOKUP DEFAULT VALUE SETTING - CORP
            idcDEFAULT_CORP.SetCommandParamValue("W_PAY_CONTROL_YN", "Y");
            idcDEFAULT_CORP.SetCommandParamValue("W_ENABLED_FLAG_YN", "Y");
            idcDEFAULT_CORP.ExecuteNonQuery();
            CORP_NAME_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_NAME");
            CORP_ID_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_ID");

            // Standard Date SETTING
            if (DateTime.Today.Month <= 2)
            {
                DateTime dLastYearMonthDay = new DateTime(DateTime.Today.AddYears(-1).Year, 12, 31);
                STANDARD_DATE_0.EditValue = dLastYearMonthDay;
            }
            else
            {
                DateTime dLastYearMonthDay = new DateTime(DateTime.Today.Year, 12, 31);
                STANDARD_DATE_0.EditValue = dLastYearMonthDay;
            }

            idaPERSON_INFO.FillSchema();

            //제1종전근무지 자료 순서
            PLACE_1.EditValue = 1;
            //제2종전근무지 자료 순서
            PLACE_2.EditValue = 2;

            PERSON_NAME_0.Focus();
        }

        #endregion

        #region ----- Adapter Event ------

        private void idaSEQ_ONE_INFO_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iDate.ISGetDate(e.Row["JOIN_DATE"]) > iDate.ISGetDate(e.Row["RETR_DATE"]))
            {
                MessageBoxAdv.Show("퇴직일자보다 입사일자가 클 수 없습니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iDate.ISGetDate(e.Row["RETR_DATE"]).Year != iString.ISNumtoZero(YEAR_0.EditValue))
            {
                MessageBoxAdv.Show("퇴직일자는 당해년도 이내여야 합니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaSEQ_TWO_INFO_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iDate.ISGetDate(e.Row["JOIN_DATE"]) > iDate.ISGetDate(e.Row["RETR_DATE"]))
            {
                MessageBoxAdv.Show("퇴직일자보다 입사일자가 클 수 없습니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iDate.ISGetDate(e.Row["RETR_DATE"]).Year != iString.ISNumtoZero(YEAR_0.EditValue))
            {
                MessageBoxAdv.Show("퇴직일자는 당해년도 이내여야 합니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }
        #endregion
        
    }
}