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

namespace EAPF0306
{
    public partial class EAPF0306 : Office2007Form
    {
        public EAPF0306(Form pMainFom, ISAppInterface pAppInterface)
        {
            this.Visible = false;
            this.DoubleBuffered = true;

            InitializeComponent();

            this.MdiParent = pMainFom;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }


        #region ----- Method ------
        private void DefaultSetFormReSize()
        {//[Child Form, Mdi Form에 맞게 ReSize]
            int vMinusWidth = 4;
            int vMinusHeight = 54;
            System.Drawing.Size vSize = this.MdiParent.ClientSize;
            this.Width = vSize.Width - vMinusWidth;
            this.Height = vSize.Height - vMinusHeight;
        }

        private void SEARCH_DB()
        {
            isDataAdapter1.SetSelectParamValue("W_SOB_ID", isAppInterfaceAdv1.SOB_ID);
            isDataAdapter1.SetSelectParamValue("W_ORG_ID", isAppInterfaceAdv1.ORG_ID);
            isDataAdapter1.Fill();

            igrMESSAGE.Focus();
        }
        #endregion

        #region -- MainButtonClick --
        public void Application_MainButtonClick(ISAppButtonEvents e)
        {
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
                        isDataAdapter1.InsertParamElement[1].SourceColumn = "MESSAGE_CODE";
                        isDataAdapter1.Update();
                        isDataAdapter1.InsertParamElement[1].SourceColumn = string.Empty;
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
                        isDataAdapter1.Delete();
                    }
                }
            }
        }
        #endregion

        #region ----- Form Event -----
        private void EAPF0305_Load(object sender, EventArgs e)
        {
            this.Visible = true;

            isDataAdapter1.FillSchema();
            iedLANG_CODE_0.Focus();

            //DefaultSetFormReSize();             //[Child Form, Mdi Form에 맞게 ReSize]
        } 

        private void isDataAdapter1_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            // 필수 입력 데이터 검증 //
            if (string.IsNullOrEmpty(e.Row["LANG_CODE"].ToString()))
            {// 언어
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10004"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 언어 입력 선택
                e.Cancel = true;
            }
            if (string.IsNullOrEmpty(e.Row["MESSAGE_TEXT"].ToString()))
            {// 메세지 내용
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10006"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 메세지내용 입력
                e.Cancel = true;
            }
            if (string.IsNullOrEmpty(e.Row["APPLICATION_CODE"].ToString()))
            {//모듈코드
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10007"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
                e.Cancel = true;
            }
        }

        private void isDataAdapter1_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:=해당 자료"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
                e.Cancel = true;
                return;
            }
        }
        #endregion    

        #region ----- Lookup Event -----
        private void ilaMESSAGE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildMESSAGE.SetLookupParamValue("W_APPLICATION_CODE", igrMESSAGE.GetCellValue("APPLICATION_CODE"));
        }

        private void ilaAPPLICATION_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            // APPLICATION PARAMETER.
            ildAPPLICATION.SetLookupParamValue("W_SOB_ID", isAppInterfaceAdv1.SOB_ID);
            ildAPPLICATION.SetLookupParamValue("W_ORG_ID", isAppInterfaceAdv1.ORG_ID);
            ildAPPLICATION.SetLookupParamValue("W_LOOKUP_MODULE", "EAPP");
            ildAPPLICATION.SetLookupParamValue("W_LOOKUP_TYPE", "SYSTEM_MODULE");
        }

        private void ilaAPPLICATION_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            // APPLICATION PARAMETER.
            ildAPPLICATION.SetLookupParamValue("W_SOB_ID", isAppInterfaceAdv1.SOB_ID);
            ildAPPLICATION.SetLookupParamValue("W_ORG_ID", isAppInterfaceAdv1.ORG_ID);
            ildAPPLICATION.SetLookupParamValue("W_LOOKUP_MODULE", "EAPP");
            ildAPPLICATION.SetLookupParamValue("W_LOOKUP_TYPE", "SYSTEM_MODULE");
        }

        private void ilaLANG_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            // LANGUAGE PARAMETER.
            ildLANG.SetLookupParamValue("W_SOB_ID", isAppInterfaceAdv1.SOB_ID);
            ildLANG.SetLookupParamValue("W_ORG_ID", isAppInterfaceAdv1.ORG_ID);
            ildLANG.SetLookupParamValue("W_LOOKUP_MODULE", "EAPP");
            ildLANG.SetLookupParamValue("W_LOOKUP_TYPE", "SYSTEM_TERRITORY");
        }

        private void ilaLANG_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            // LANGUAGE PARAMETER.
            ildLANG.SetLookupParamValue("W_SOB_ID", isAppInterfaceAdv1.SOB_ID);
            ildLANG.SetLookupParamValue("W_ORG_ID", isAppInterfaceAdv1.ORG_ID);
            ildLANG.SetLookupParamValue("W_LOOKUP_MODULE", "EAPP");
            ildLANG.SetLookupParamValue("W_LOOKUP_TYPE", "SYSTEM_TERRITORY");
        }
        #endregion
        
    }
}