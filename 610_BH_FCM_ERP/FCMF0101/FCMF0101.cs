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

namespace FCMF0101
{
    public partial class FCMF0101 : Office2007Form
    {
        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #region ----- Variables -----

        
        #endregion;

        #region ----- Constructor -----

        public FCMF0101(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void FCMF0101_Load(object sender, EventArgs e)
        {
            idaSUPPLIER.FillSchema();
        }

        private void Insert_Bank_Account()
        {
            isgSUP_BANK_ACCT.SetCellValue("ENABLED_FLAG", "Y");
            isgSUP_BANK_ACCT.SetCellValue("EFFECTIVE_DATE_FR", DateTime.Today);
        }
        #endregion;

        #region ----- 주소 조회 -----

        private void Show_Address()
        {
            Application.UseWaitCursor = true;
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            Application.DoEvents();

            DialogResult dlgRESULT;
            EAPF0299.EAPF0299 vEAPF0299 = new EAPF0299.EAPF0299(this.MdiParent, isAppInterfaceAdv1.AppInterface, ZIP_CODE.EditValue, ADDRESS1.EditValue);
            dlgRESULT = vEAPF0299.ShowDialog();

            if (dlgRESULT == DialogResult.OK)
            {
                ZIP_CODE.EditValue = vEAPF0299.Get_Zip_Code;
                ADDRESS1.EditValue = vEAPF0299.Get_Address;
            }
            vEAPF0299.Dispose();
            this.Cursor = System.Windows.Forms.Cursors.Default;
            Application.UseWaitCursor = false;
            Application.DoEvents();
        }

        #endregion

        #region ----- Events -----

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    INQUIRY_DB();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    if (idaSUPPLIER.IsFocused)
                    {
                        idaSUPPLIER.AddOver();
                        Form_DefaultValue();
                        
                    }
                    else if (idaSUP_BANK_ACCT.IsFocused)
                    {
                        idaSUP_BANK_ACCT.AddOver();
                        Insert_Bank_Account();
                    }

                    //if (isAppInterfaceAdv1.SOB_ID.ToString() == "10")
                    //{
                    //    SUPPLIER_CODE.Nullable = true;
                    //    SUPPLIER_CODE.ReadOnly = true;
                    //}
                    //else
                    //{
                    //    SUPPLIER_CODE.Nullable = false;
                    //    SUPPLIER_CODE.ReadOnly = false;
                    //}
                    

                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaSUPPLIER.IsFocused)
                    {
                        idaSUPPLIER.AddUnder();
                        Form_DefaultValue();
                    }
                    else if (idaSUP_BANK_ACCT.IsFocused)
                    {
                        idaSUP_BANK_ACCT.AddUnder();
                        Insert_Bank_Account();
                    }

                    //if (isAppInterfaceAdv1.SOB_ID.ToString() == "10")
                    //{
                    //    SUPPLIER_CODE.Nullable = true;
                    //    SUPPLIER_CODE.ReadOnly = true;
                    //}
                    //else
                    //{
                    //    SUPPLIER_CODE.Nullable = false;
                    //    SUPPLIER_CODE.ReadOnly = false;
                    //}
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    idaSUPPLIER.Update();

                    ////if (iConvert.ISNull(idaSUPPLIER.GetInsertParamValue("O_SUPPLIER_CODE")) != string.Empty)

                    //if (Convert.ToString(idaSUPPLIER.GetInsertParamValue("O_SUPPLIER_CODE")) != "")
                    //{
                    //    SUPPLIER_CODE.EditValue = idaSUPPLIER.GetInsertParamValue("O_SUPPLIER_CODE");
                    //    idaSUPPLIER.CurrentRow.AcceptChanges();
                    //    idaSUPPLIER.Refillable = true;
                    //}

                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaSUPPLIER.IsFocused)
                    {
                        idaSUPPLIER.Cancel();
                    }
                    else if (idaSUP_BANK_ACCT.IsFocused)
                    {
                        idaSUP_BANK_ACCT.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaSUPPLIER.IsFocused)
                    {
                        idaSUPPLIER.Delete();
                    }
                    else if (idaSUP_BANK_ACCT.IsFocused)
                    {
                        idaSUP_BANK_ACCT.Delete();
                    }
                }
            }
        }

        #endregion;

        #region -- Data Find --
        private void INQUIRY_DB()
        {
            //isDataAdapter1.SetSelectParamValue("W_SUPPLIER_ID", SUPPLIER_ID.EditValue);
            idaSUPPLIER.Fill();

            SUPPLIER_CODE.Focus();
        }

        #endregion

        #region -- Default Value Setting --
        private void Form_DefaultValue()
        {
            idcLOCAL_DATE.ExecuteNonQuery();
            EFFECTIVE_DATE_FR.EditValue = idcLOCAL_DATE.GetCommandParamValue("X_LOCAL_DATE");
            ENABLED_FLAG.CheckBoxValue = "Y";
        }
        #endregion

        // Supplier Code Duplication Check//
        private void SUPPLIER_CODE_CurrentEditValidating(object pSender, ISEditAdvValidatingEventArgs e)
        {

            if (idaSUPPLIER.CurrentRow != null && idaSUPPLIER.CurrentRow.RowState == DataRowState.Added)
            {
                string V_Check_Result = null;

                idcCHK_SUP_CODE.ExecuteNonQuery();
                V_Check_Result = idcCHK_SUP_CODE.GetCommandParamValue("X_CHECK_RESULT").ToString();
                

                if (V_Check_Result == 'N'.ToString())
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90003", "&&FIELD_NAME:=Supplier Code"), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    e.Cancel = true;
                }
            }

        }

        // Tax_Reg_No Duplication Check //
        private void TAX_REG_NO_CurrentEditValidating(object pSender, ISEditAdvValidatingEventArgs e)
        {
            //if (idaSUPPLIER.CurrentRow != null && idaSUPPLIER.CurrentRow.RowState == DataRowState.Added)
            //{
            //    string V_Check_Result = null;

            //    idcCHK_TAX_REG_NO.ExecuteNonQuery();
            //    V_Check_Result = idcCHK_TAX_REG_NO.GetCommandParamValue("X_CHECK_RESULT").ToString();

            //    if (V_Check_Result == "N".ToString())
            //    {
            //        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90003", "&&FIELD_NAME:=Tax Registration No"), "Error",MessageBoxButtons.OK, MessageBoxIcon.Error);
            //        e.Cancel = true;
            //    }
            //}
        }

        private void ilaSUPPLIER_V_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildSUPPLIER_V.SetLookupParamValue("W_SUPP_CUST_TYPE", "S");
            ildSUPPLIER_V.SetLookupParamValue("W_SOB_ID", isAppInterfaceAdv1.SOB_ID);
            ildSUPPLIER_V.SetLookupParamValue("W_ORG_ID", isAppInterfaceAdv1.ORG_ID);
        }

        //private void ilaCLASS_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        //{
        //    ildCLASS.SetLookupParamValue("W_LOOKUP_MODULE", Convert.ToString("PO"));
        //    ildCLASS.SetLookupParamValue("W_LOOKUP_TYPE", Convert.ToString("SUPPLIER_CLASS"));
        //}

        private void ilaTYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildTYPE.SetLookupParamValue("W_SUPPLIER_CLASS_CODE", SUPPLIER_CLASS_CODE.EditValue.ToString());
        }

        private void ilaBUSINESS_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildBUSINESS_TYPE.SetLookupParamValue("W_LOOKUP_MODULE", Convert.ToString("PO"));
            ildBUSINESS_TYPE.SetLookupParamValue("W_LOOKUP_TYPE", Convert.ToString("BUSINESS_TYPE"));
        }

        private void ilaSHIPPING_METHOD_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildSHIPPING_METHOD.SetLookupParamValue("W_LOOKUP_MODULE", Convert.ToString("EAPP"));
            ildSHIPPING_METHOD.SetLookupParamValue("W_LOOKUP_TYPE", Convert.ToString("SHIPPING_METHOD"));
        }

        private void ilaTYPE_V_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildTYPE.SetLookupParamValue("W_SUPPLIER_CLASS_CODE", SUPPLIER_CLASS_CODE_V.EditValue.ToString());
        }

        private void ilaACCOUNT_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "ACCOUNT_TYPE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaCURRENCY_BANK_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCURRENCY_BANK.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaBANK_SITE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "BANK_CODE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaTAX_BILL_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildTAX_BILL_TYPE.SetLookupParamValue("W_LOOKUP_MODULE", Convert.ToString("EAPP"));
            ildTAX_BILL_TYPE.SetLookupParamValue("W_LOOKUP_TYPE", Convert.ToString("TAX_BILL_TYPE"));
        }
        
        #region ----- Adapter Event -----

        private void idaSUPPLIER_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["TAX_REG_NO"]) != string.Empty)
            {
                string vCheck_Result = "N";
                DialogResult dlgResult;
                IDC_TAX_REG_NO_DUP_P.ExecuteNonQuery();
                vCheck_Result = IDC_TAX_REG_NO_DUP_P.GetCommandParamValue("X_CHECK_RESULT").ToString();
                if (vCheck_Result == "N")
                {
                    dlgResult = MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10459"), "Question", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
                    if (dlgResult == DialogResult.No)
                    {
                        e.Cancel = true;
                        return;
                    }
                }
            }
        }

        private void idaSUPPLIER_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10047"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
                e.Cancel = true;
                return;
            }
        }

        private void idaSUP_BANK_ACCT_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["BANK_ACCOUNT_NAME"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", "&&FIELD_NAME:=Bank Account Name(은행 계좌명)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);  //코드 입력
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["BANK_ACCOUNT_NUM"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", "&&FIELD_NAME:=Bank Account Number(은행 계좌번호)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);  // 코드명 입력
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["OWNER_NAME"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", "&&FIELD_NAME:=Owner Name(예금주)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);  // 코드명 입력
                e.Cancel = true;
                return;
            }
            if (e.Row["EFFECTIVE_DATE_FR"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);  // 시작일자 입력
                e.Cancel = true;
                return;
            }
            if (e.Row["EFFECTIVE_DATE_TO"] != DBNull.Value)
            {
                if (Convert.ToDateTime(e.Row["EFFECTIVE_DATE_FR"]) > Convert.ToDateTime(e.Row["EFFECTIVE_DATE_TO"]))
                {// 시작일자 ~ 종료일자
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10012"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);  // 기간 검증 오류
                    e.Cancel = true;
                    return;
                }
            }
        }

        private void idaSUP_BANK_ACCT_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10047"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
                e.Cancel = true;
                return;
            }
        }
        #endregion

        private void ZIP_CODE_KeyDown(object pSender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                Show_Address();
            }
        }

        private void ADDRESS1_KeyDown(object pSender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                Show_Address();
            }
        }

        
    }
}