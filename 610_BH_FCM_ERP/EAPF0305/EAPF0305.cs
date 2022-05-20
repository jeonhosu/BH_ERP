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

namespace EAPF0305
{
    public partial class EAPF0305 : Office2007Form
    {
        public EAPF0305(Form pMainFom, ISAppInterface pAppInterface)
        {
            InitializeComponent();

            this.MdiParent = pMainFom;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #region -- MainButtonClick --
        public void Application_MainButtonClick(ISAppButtonEvents e)
        {
            //DateTime mDate = DateTime.Today;
            //mDate = mDate.AddDays(-mDate.Day + 1);
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    SEARCH_DB();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    if (isDataAdapter1.IsFocused)
                    {
                        isDataAdapter1.AddOver();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (isDataAdapter1.IsFocused)
                    {
                        isDataAdapter1.AddUnder();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (isDataAdapter1.IsFocused)
                    {
                        // 필수 입력 데이터 검증 //
                        if (string.IsNullOrEmpty(igrMESSAGE.GetCellValue("LANG_CODE").ToString()))
                        {// 언어
                            MessageBox.Show(isMessageAdapter1.ReturnText("EAPP_10004"), "Warning");        // 언어 입력 선택
                            return;
                        }
                        if (string.IsNullOrEmpty(igrMESSAGE.GetCellValue("MESSAGE_TEXT").ToString()))
                        {// 메세지 내용
                            MessageBox.Show(isMessageAdapter1.ReturnText("EAPP_10006"), "Warning");        // 메세지내용 입력
                            return;
                        }
                        if (string.IsNullOrEmpty(igrMESSAGE.GetCellValue("APPLICATION_CODE").ToString()))
                        {//모듈코드
                            MessageBox.Show(isMessageAdapter1.ReturnText("EAPP_10007"), "Warning");        // 모듈 코드 입력
                            return;
                        }

                        isDataAdapter1.SetInsertParamValue("P_USER_ID", isAppInterfaceAdv1.AppInterface.UserId);
                        isDataAdapter1.SetUpdateParamValue("P_USER_ID", isAppInterfaceAdv1.AppInterface.UserId);

                        isDataAdapter1.Update();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (isDataAdapter1.IsFocused)
                    {
                        isDataAdapter1.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (isDataAdapter1.IsFocused)
                    {
                        // SYSTEM MESSAGE는 삭제 불가.
                        if (igrMESSAGE.GetCellValue("CATEGORY").ToString() == "SYSTEM")
                        {
                            MessageBox.Show(isMessageAdapter1.ReturnText("EAPP_10008"), "Warning");
                            return;
                        }
                        isDataAdapter1.Delete();
                    }
                }
            }
        }
        #endregion

        #region -- DATA FIND --
        private void SEARCH_DB()
        {
            isDataAdapter1.SetSelectParamValue("W_SOB_ID", (int)10);
            isDataAdapter1.SetSelectParamValue("W_ORG_ID", (int)101);
            isDataAdapter1.Fill();
        }
        #endregion

        private void EAPF0305_Load(object sender, EventArgs e)
        {
            isDataAdapter1.FillSchema();

            // LANGUAGE PARAMETER.
            ildLANG.SetLookupParamValue("W_SOB_ID", (int)10);
            ildLANG.SetLookupParamValue("W_ORG_ID", (int)101);
            ildLANG.SetLookupParamValue("W_LOOKUP_MODULE", "EAPP");
            ildLANG.SetLookupParamValue("W_LOOKUP_TYPE", "SYSTEM_LANGUAGE");

            // APPLICATION PARAMETER.
            ildAPPLICATION.SetLookupParamValue("W_SOB_ID", (int)10);
            ildAPPLICATION.SetLookupParamValue("W_ORG_ID", (int)101);
            ildAPPLICATION.SetLookupParamValue("W_LOOKUP_MODULE", "EAPP");
            ildAPPLICATION.SetLookupParamValue("W_LOOKUP_TYPE", "SYSTEM_MODULE");
        }
    }
}