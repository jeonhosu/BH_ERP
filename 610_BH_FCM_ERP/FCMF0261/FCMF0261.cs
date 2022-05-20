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

namespace FCMF0261
{
    public partial class FCMF0261 : Office2007Form
    {
        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #region ----- Variables -----



        #endregion;

        #region ----- Constructor -----

        public FCMF0261()
        {
            InitializeComponent();
        }

        public FCMF0261(Form pMainForm, ISAppInterface pAppInterface)
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
                    // 차입일자 란이 비어있을 경우의 장애 처리
                    if (iString.ISNull(DUE_DATE_FR_0.EditValue) == string.Empty)
                    {
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=시작일자"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        DUE_DATE_FR_0.Focus();
                        return;
                    }
                    if (iString.ISNull(DUE_DATE_TO_0.EditValue) == string.Empty)
                    {
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=종료일자"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        DUE_DATE_TO_0.Focus();
                        return;
                    }
                    if (Convert.ToDateTime(DUE_DATE_FR_0.EditValue) > Convert.ToDateTime(DUE_DATE_TO_0.EditValue))
                    {
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10012"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        DUE_DATE_FR_0.Focus();
                        return;
                    }
                    
                    idaLOAN_INFO.Fill(); // 그리드 부분에 데이터 출력해주는 부분             

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

        private void FCMF0261_Load(object sender, EventArgs e) 
        {
            //차입일자에 초기값 설정
            DUE_DATE_FR_0.EditValue = iDate.ISMonth_1st(DateTime.Today);
            DUE_DATE_TO_0.EditValue = DateTime.Today;
        }
    }
}