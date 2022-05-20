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

namespace FCMF0258
{
    public partial class FCMF0258 : Office2007Form
    {
        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #region ----- Variables -----



        #endregion;

        #region ----- Constructor -----

        public FCMF0258()
        {
            InitializeComponent();
        }

        public FCMF0258(Form pMainForm, ISAppInterface pAppInterface)
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
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search) // 검색 버튼
                {
                    // 조회년월 란이 비어있을 경우의 장애 처리
                    /*if (iString.ISNull(INQUIRY_YYYYMM_0.EditValue) == string.Empty)
                    {
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=시작일자"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        INQUIRY_YYYYMM_0.Focus();
                        return;
                    }*/
                    
                    idaCUSTOMER_INFO.Fill(); // 그리드 부분에 데이터 출력해주는 부분             

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

        private void FCMF0258_Load(object sender, EventArgs e) 
        {
            //조회 년월에 초기값 설정
            // INQUIRY_YYYYMM_0.EditValue = iDate.ISMonth_1st(DateTime.Today);

            //조회 년월에 초기값 설정
            INQUIRY_YYYYMM_0.EditValue = iDate.ISYearMonth(DateTime.Today);
            START_DATE_0.EditValue = iDate.ISMonth_1st(DateTime.Today);
            END_DATE_0.EditValue = iDate.ISMonth_Last(DateTime.Today);
            
        }

        private void ilaYEAR_MONTH_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            // 조회 년월 LookupData (2001.1 ~ 현재 날짜)
            ildYEAR_MONTH.SetLookupParamValue("W_START_YYYYMM", "2001-01");
            ildYEAR_MONTH.SetLookupParamValue("W_WORK_TERM_TYPE", "D2");
        }
    }
}