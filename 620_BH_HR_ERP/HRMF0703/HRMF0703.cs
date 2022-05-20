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

namespace HRMF0703
{
    public partial class HRMF0703 : Office2007Form
    {
        #region ----- Variables -----
        ISCommonUtil.ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISCommonUtil.ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public HRMF0703()
        {
            InitializeComponent();
        }

        public HRMF0703(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        // 업체정보, 기준일자, 해당 년도 값 체크 후 - Person Info 그리드에 데이터 출력
        private void SearchDB()
        {
            if (iString.ISNull(CORP_ID_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME_0.Focus();
                return;
            }
            if (iString.ISNull(STANDARD_DATE_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10015"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                STANDARD_DATE_0.Focus();
                return;
            }
            YEAR_YYYY_0.EditValue = STANDARD_DATE_0.DateTimeValue.Year.ToString();
            if (iString.ISNull(YEAR_YYYY_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10022"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                STANDARD_DATE_0.Focus();
                return;
            }
                        
            string vMessage = string.Empty;
            try
            {
                idaPERSON.Fill();
            }
            catch (System.Exception ex)
            {
                vMessage = string.Format("Adapter Fill Error\n{0}", ex.Message);
                MessageBoxAdv.Show(vMessage, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        // Person Info 그리드를 선택 시, Person ID 및 Year 정보를 체크한 후 idaFOUNDATION에 정보를 출력해주는 함수
        private void SearchDB_Foundation()
        {
            if (iString.ISNull(igrPERSON_INFO.GetCellValue("PERSON_ID")) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10016"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                STANDARD_DATE_0.Focus();
                return;
            }
            YEAR_YYYY_0.EditValue = STANDARD_DATE_0.DateTimeValue.Year.ToString();
            if (iString.ISNull(YEAR_YYYY_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10022"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                STANDARD_DATE_0.Focus();
                return;
            }
            idaFOUNDATION.Fill();
        }

        // Insert 시, 해당 년도 값 셋팅하는 함수
        private void InsertFoundation()
        {
            string vYYYY = STANDARD_DATE_0.DateTimeValue.Year.ToString();
            YEAR_YYYY.EditValue = vYYYY;
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
                    if (idaFOUNDATION.IsFocused)
                    {
                        idaFOUNDATION.AddOver();
                        InsertFoundation();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaFOUNDATION.IsFocused)
                    {
                        idaFOUNDATION.AddUnder();
                        InsertFoundation();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    idaPERSON.Update();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaFOUNDATION.IsFocused)
                    {
                        idaFOUNDATION.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaFOUNDATION.IsFocused)
                    {
                        idaFOUNDATION.Delete();
                    }
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void HRMF0703_Load(object sender, EventArgs e)
        {
            // Lookup SETTING
            ildCORP_0.SetLookupParamValue("W_PAY_CONTROL_YN", "Y");
            ildCORP_0.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");

            // LOOKUP DEFAULT VALUE SETTING - CORP
            idcDEFAULT_CORP.SetCommandParamValue("W_PAY_CONTROL_YN", "Y");
            idcDEFAULT_CORP.SetCommandParamValue("W_ENABLED_FLAG_YN", "N");
            idcDEFAULT_CORP.ExecuteNonQuery();
            CORP_NAME_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_NAME");
            CORP_ID_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_ID");

            // Standard Date SETTING
            DateTime dLastYearMonthDay = new DateTime(DateTime.Today.Year, 12, 31);
            STANDARD_DATE_0.EditValue = dLastYearMonthDay;

            YEAR_YYYY.EditValue = STANDARD_DATE_0.DateTimeValue.Year.ToString();

            PERSON_NAME_0.Focus();
        }
        
        private void STANDARD_DATE_0_CurrentEditValidated(object pSender, ISEditAdvValidatedEventArgs e)
        {
            string vYYYY = STANDARD_DATE_0.DateTimeValue.Year.ToString();
            YEAR_YYYY_0.EditValue = vYYYY;
        }

        #endregion

        #region ----- Lookup Event -----


        #endregion

        #region ----- Adapter Event -----


        private void idaPERSON_0_NewRowMoved_1(object pSender, ISBindingEventArgs pBindingManager)
        {
            SearchDB_Foundation();
        }

        #endregion

        private void ilaKOR_FOR_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e) // 내외국인 구분
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "NATIONALITY_TYPE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        private void ilaHOUSE_HOLDER_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e) // 세대주 구분
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "HOUSEHOLD_TYPE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        private void ilaRESIDE_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e) // 거주 구분
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "RESIDENT_TYPE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }
    }
}