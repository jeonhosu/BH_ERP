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

namespace HRMF0231
{
    public partial class HRMF0231_PRINT : Office2007Form
    {
        #region ----- Variables -----

        private ISHR.isCertificatePrint mPrintInfo;
        private ISFunction.ISConvert iString = new ISFunction.ISConvert();

        private string mOutChoice = string.Empty;

        #endregion;

        #region ----- Constructor -----

        public HRMF0231_PRINT(Form pMainForm, ISHR.isCertificatePrint pPrintInfo, ISAppInterface pAppInterface, string pOutChoice)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;

            isAppInterfaceAdv1.AppInterface = pAppInterface;
            mPrintInfo = new ISHR.isCertificatePrint();
            mPrintInfo = pPrintInfo;
            mPrintInfo.ISPrinting += ISOnPrint;

            mOutChoice = pOutChoice;
        }

        #endregion;

        #region ----- Form Event -----

        private void HRMF0231_PRINT_Load(object sender, EventArgs e)
        {
            this.Text = string.Format("{0} - {1}", this.Text, mOutChoice);
        }

        private void HRMF0231_PRINT_Shown(object sender, EventArgs e)
        {
            V_RB_KO.CheckedState = ISUtil.Enum.CheckedState.Checked;
            V_LANG_CODE.EditValue = V_RB_KO.RadioCheckedString;

            iedPRINT_DATE.Focus();
        }

        private void HRMF0231_PRINT_FormClosed(object sender, FormClosedEventArgs e)
        {
            mPrintInfo.ISPrintedEvent(mPrintInfo.FormID);
        }

        private void ibtPRINT_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            Certificate();
        }

        private void ibtCANCEL_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            this.Close();
        }

        private void V_RB_KO_Click(object sender, EventArgs e)
        {
            if (V_RB_KO.Checked == true)
            {
                V_LANG_CODE.EditValue = V_RB_KO.RadioCheckedString;
            }
        }

        private void V_RB_EN_Click(object sender, EventArgs e)
        {
            if (V_RB_EN.Checked == true)
            {
                V_LANG_CODE.EditValue = V_RB_EN.RadioCheckedString;
            }
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

        #region ----- Certificate Method -----

        private void Certificate()
        {
            // 증명서 발급
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
            idcCERTIFICATE_PRINT_INSERT.ExecuteNonQuery();
            iedPRINT_NUM.EditValue = idcCERTIFICATE_PRINT_INSERT.GetCommandParamValue("P_PRINT_NUM");

            // 인쇄발급 루틴 추가 //
            if (iString.ISNull(iedPRINT_NUM.EditValue) == string.Empty)
            {// 인쇄번호 없음. 인쇄 실패.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10172"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            bool isPrinting = Print_Certificate(iedPRINT_NUM.EditValue, V_LANG_CODE.EditValue); // 증명서 인쇄 폼 안에 있는 그리드 관련 함수
            if (isPrinting == false)
            {
                //해당 자료를 인쇄하지 못했습니다. 확인하세요
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10172"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }

            iedPRINT_NUM.EditValue = null;
            iedRETIRE_DATE.EditValue = null;
            iedCERT_TYPE_ID.EditValue = null;
            iedCERT_TYPE_NAME.EditValue = null;
            iedCERT_TYPE_CODE.EditValue = null;
            iedPERSON_ID.EditValue = null;
            iedPERSON_NAME.EditValue = null;
            iedJOIN_DATE.EditValue = null;
            iedRETIRE_DATE.EditValue = null;
            iedDESCRIPTION.EditValue = null;
            iedSEND_ORG.EditValue = null;
            iedPERSON_NUMBER.EditValue = null;
            iedEMPLOYE_TYPE.EditValue = null;
            iedPRINT_COUNT.EditValue = Convert.ToInt32(1);
        }

        #endregion;

        #region ----- User Event -----

        private void ISOnPrint(string pFormID)
        {
            iedPRINT_NUM.EditValue = mPrintInfo.Print_Num;
            iedPRINT_DATE.EditValue = mPrintInfo.Print_Date;
            iedPRINT_COUNT.EditValue = Convert.ToInt32(1);
            if (mPrintInfo.Print_Num != null)
            {
                iedCERT_TYPE_NAME.EditValue = mPrintInfo.Cert_Type_Name;
                iedCERT_TYPE_ID.EditValue = mPrintInfo.Cert_Type_ID;
                iedPERSON_NAME.EditValue = mPrintInfo.Name;
                iedPERSON_ID.EditValue = mPrintInfo.Person_ID;
                if (mPrintInfo.Join_Date.ToShortDateString() == "0001-01-01")
                {
                    iedJOIN_DATE.EditValue = null;
                }
                else
                {
                    iedJOIN_DATE.EditValue = mPrintInfo.Join_Date;
                }
                if (mPrintInfo.Retire_Date.ToShortDateString() == "0001-01-01")
                {
                    iedRETIRE_DATE.EditValue = null;
                }
                else
                {
                    iedRETIRE_DATE.EditValue = mPrintInfo.Retire_Date;
                }
                iedDESCRIPTION.EditValue = mPrintInfo.Description;
                iedSEND_ORG.EditValue = mPrintInfo.Send_Org;
                iedPRINT_COUNT.EditValue = mPrintInfo.Print_Count;
            }
        }

        private bool Print_Certificate(object pPrint_num, object pLANG_CODE)
        {
            bool isPrinting = false;

            IDA_DATA_PRINT.SetSelectParamValue("W_PRINT_NUM", pPrint_num);
            IDA_DATA_PRINT.Fill(); // 증명서 인쇄 폼 내에 그리드 부분에 삽입될 데이터 처리.

            if (IDA_DATA_PRINT.OraSelectData.Rows != null)
            {
                int vCountRow = IDA_DATA_PRINT.OraSelectData.Rows.Count;
                if (vCountRow > 0)
                {
                    isPrinting = XLPrinting1(IDA_DATA_PRINT, pLANG_CODE); // 출력 함수 호출
                }
            }

            return isPrinting;
        }

        #endregion;

        #region ----- XL Print 1 Methods ----

        private bool XLPrinting1(ISDataAdapter pAdapter, object pLANG_CODE)
        {
            bool isPrinting = false;
            bool IsOpen = false;
            string vMessageText = string.Empty;
            int vCopies = 0;

            System.Windows.Forms.Application.UseWaitCursor = true;
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            System.Windows.Forms.Application.DoEvents();

            vMessageText = string.Format("Printing Starting...");
            isAppInterfaceAdv1.OnAppMessage(vMessageText);
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            System.Windows.Forms.Application.DoEvents();

            XLPrinting xlPrinting = new XLPrinting(isAppInterfaceAdv1.AppInterface, isMessageAdapter1);

            try
            {
                vMessageText = string.Format(" XL Opening...");
                isAppInterfaceAdv1.OnAppMessage(vMessageText);
                System.Windows.Forms.Application.DoEvents();

                //-------------------------------------------------------------------------
                xlPrinting.OpenFileNameExcel = "HRMF0231_001.xls";

                IsOpen = xlPrinting.XLFileOpen();

                if (IsOpen == true)
                {
                    System.Data.DataRow vROW = pAdapter.CurrentRow;
                    isPrinting = xlPrinting.LineWrite(vROW, pLANG_CODE);

                    vCopies = (int)iedPRINT_COUNT.NumberValue;
                    vCopies = (vCopies == 0) ? 1 : vCopies;

                    ////////[PRINT]
                    ////xlPrinting.Printing(1, 1, vCopies); //시작 페이지 번호, 종료 페이지 번호

                    ////[SAVE]
                    //xlPrinting.Save("Certify_"); //저장 파일명

                    if (mOutChoice == "PRINT")
                    {
                        xlPrinting.Printing(1, 1, vCopies);
                    }
                    else if (mOutChoice == "FILE")
                    {
                        xlPrinting.SAVE("CERTIFY_");
                    }

                    //-------------------------------------------------------------------------------------
                    xlPrinting.Dispose();
                    //-------------------------------------------------------------------------------------

                    vMessageText = string.Format("Print End [Copies - {0}]", vCopies);
                    isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
                    System.Windows.Forms.Application.DoEvents();
                }
                else
                {
                    vMessageText = "Excel File Open Error";
                    isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
                    System.Windows.Forms.Application.DoEvents();
                }
            }
            catch (System.Exception ex)
            {
                xlPrinting.Dispose();

                vMessageText = ex.Message;
                isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
                System.Windows.Forms.Application.DoEvents();
            }

            //-------------------------------------------------------------------------

            System.Windows.Forms.Application.UseWaitCursor = false;
            this.Cursor = System.Windows.Forms.Cursors.Default;
            System.Windows.Forms.Application.DoEvents();

            return isPrinting;
        }

        #endregion;

       
    }
}