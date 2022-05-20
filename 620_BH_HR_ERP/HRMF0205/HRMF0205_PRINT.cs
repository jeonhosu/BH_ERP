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

namespace HRMF0205
{
    public partial class HRMF0205_PRINT : Office2007Form
    {
        ISHR.isCertificatePrint mPrintInfo;
        ISFunction.ISConvert iString = new ISFunction.ISConvert();

        public HRMF0205_PRINT(Form pMainForm, ISHR.isCertificatePrint pPrintInfo, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;

            isAppInterfaceAdv1.AppInterface = pAppInterface;
            mPrintInfo = new ISHR.isCertificatePrint();
            mPrintInfo = pPrintInfo;
            mPrintInfo.ISPrinting += ISOnPrint;
        }

        private void ISOnPrint(string pFormID)
        {
            iedPRINT_NUM.EditValue = mPrintInfo.Print_Num;
            iedPRINT_DATE.EditValue = mPrintInfo.Print_Date;
            iedPRINT_COUNT.EditValue = Convert.ToInt32(1);
            if (mPrintInfo.Print_Num != null)
            {
                iedCERT_TYPE_NAME.EditValue = mPrintInfo.Cert_Type_Name;
                iedCERT_TYPE_ID.EditValue = mPrintInfo.Cert_Type_ID;
                iedNAME.EditValue = mPrintInfo.Name;
                iedPERSON_ID.EditValue = mPrintInfo.Person_ID;
                iedJOIN_DATE.EditValue = mPrintInfo.Join_Date;
                iedRETIRE_DATE.EditValue = mPrintInfo.Retire_Date;
                iedDESCRIPTION.EditValue = mPrintInfo.Description;
                iedSEND_ORG.EditValue = mPrintInfo.Send_Org;
                iedPRINT_COUNT.EditValue = mPrintInfo.Print_Count;
            }
        }

        private void Print_Certificate(object pPrint_num)
        {

        }

        #region ----- Form Event -----
        private void HRMF0205_PRINT_Load(object sender, EventArgs e)
        {
            iedPRINT_DATE.Focus();
        }

        private void HRMF0205_PRINT_FormClosed(object sender, FormClosedEventArgs e)
        {
            mPrintInfo.ISPrintedEvent(mPrintInfo.FormID);
        }

        private void ibtPRINT_ButtonClick(object pSender, EventArgs pEventArgs)
        {// 증명서 발급
            if (iedCERT_TYPE_ID.EditValue == null)
            {// 증명서 구분
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10033"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                iedCERT_TYPE_NAME.Focus();
                return;
            }

            if (iedPERSON_ID.EditValue == null)
            {// 사원 선택
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10016"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                iedCERT_TYPE_NAME.Focus();
                return;
            }

            if (string.IsNullOrEmpty(iedDESCRIPTION.EditValue.ToString()))
            {// 용도 입력
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10034"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                iedCERT_TYPE_NAME.Focus();
                return;
            }

            // 인쇄 메서드 호출.

            // 인쇄 결과 저장.     
            idcCERTIFICATE_PRINT_INSERT.SetCommandParamValue("P_CORP_ID", mPrintInfo.Corp_ID);
            idcCERTIFICATE_PRINT_INSERT.SetCommandParamValue("P_SOB_ID", isAppInterfaceAdv1.SOB_ID);
            idcCERTIFICATE_PRINT_INSERT.SetCommandParamValue("P_ORG_ID", isAppInterfaceAdv1.ORG_ID);
            idcCERTIFICATE_PRINT_INSERT.SetCommandParamValue("P_USER_ID", isAppInterfaceAdv1.USER_ID);
            idcCERTIFICATE_PRINT_INSERT.ExecuteNonQuery();
            iedPRINT_NUM.EditValue = idcCERTIFICATE_PRINT_INSERT.GetCommandParamValue("P_PRINT_NUM");

            // 인쇄발급 루틴 추가 //
            if (iString.ISNull(iedPRINT_NUM.EditValue) == string.Empty)
            {// 인쇄번호 없음. 인쇄 실패.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10172"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            Print_Certificate(iedPRINT_NUM.EditValue);
            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10035"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);

            iedPRINT_NUM.EditValue = null;
            iedRETIRE_DATE.EditValue = null;
            iedCERT_TYPE_ID.EditValue = null;
            iedCERT_TYPE_NAME.EditValue = null;
            iedPERSON_ID.EditValue = null;
            iedNAME.EditValue = null;
            iedJOIN_DATE.EditValue = null;
            iedRETIRE_DATE.EditValue = null;
            iedDESCRIPTION.EditValue = null;
            iedSEND_ORG.EditValue = null;
            iedPRINT_COUNT.EditValue = Convert.ToInt32(1);
        }

        private void ibtCANCEL_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            this.Close();
        }

        #endregion

        #region ----- Lookup Event -----
        private void ilaCERT_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON_W.SetLookupParamValue("W_GROUP_CODE", "CERT_TYPE");
            ildCOMMON_W.SetLookupParamValue("W_WHERE", "HC.VALUE1 = 10 ");
            ildCOMMON_W.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        private void ilaPERSON_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            if (iedEMPLOYE_TYPE.EditValue.ToString() == "1".ToString())
            {
                ildPERSON.SetLookupParamValue("W_START_DATE", iedPRINT_DATE.EditValue);
                ildPERSON.SetLookupParamValue("W_END_DATE", iedPRINT_DATE.EditValue);
            }
            else
            {
                ildPERSON.SetLookupParamValue("W_START_DATE", DateTime.Parse("2001-01-01"));
                ildPERSON.SetLookupParamValue("W_END_DATE", DateTime.Today);
            }
            ildPERSON.SetLookupParamValue("W_CORP_ID", mPrintInfo.Corp_ID);
        }        
        #endregion

        
    }
}