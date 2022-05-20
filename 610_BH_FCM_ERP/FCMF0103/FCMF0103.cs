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

namespace FCMF0103
{
    public partial class FCMF0103 : Office2007Form
    {
        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #region ----- Variables -----



        #endregion;

        #region ----- Constructor -----

        public FCMF0103(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void FCMF0103_Load(object sender, EventArgs e)
        {
            idaCUSTOMER_SITE.FillSchema();
            idaCUST_SHIP_TO.FillSchema();
            idaCUST_PERSON.FillSchema();
        }

        private void Insert_Bank_Account()
        {
            isgBANK_ACCOUNT.SetCellValue("ENABLED_FLAG", "Y");
            isgBANK_ACCOUNT.SetCellValue("EFFECTIVE_DATE_FR", DateTime.Today);
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
                    AR_CUSTOMER_INQUIRY();
                    // Select Error Routine
                    if (idaCUSTOMER_SITE.GetSelectParamValue("X_ERR_MSG") != null)
                    {
                        MessageBoxAdv.Show(idaCUSTOMER_SITE.GetSelectParamValue("X_ERR_MSG").ToString());
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    if (idaCUSTOMER_SITE.IsFocused)    // AR_CUSTOMER
                    {
                        idaCUSTOMER_SITE.AddOver();
                        Form_DefaultValue();
                    }
                    if (idaCUST_SHIP_TO.IsFocused && idaCUSTOMER_SITE.CurrentRow != null)    // AR_CUSTOMER_SHIP_TO
                    {
                        idaCUST_SHIP_TO.AddOver();
                        isgCUST_SHIP_TO.SetCellValue("EFFECTIVE_DATE_FR", DateTime.Today);
                        isgCUST_SHIP_TO.SetCellValue("ENABLED_FLAG", "Y");
                    }
                    if (idaCUST_PERSON.IsFocused && idaCUSTOMER_SITE.CurrentRow != null)    // AR_CUSTOMER_PERSON
                    {
                        idaCUST_PERSON.AddOver();
                        isgCUST_PERSON.SetCellValue("EFFECTIVE_DATE_FR", DateTime.Today);
                        isgCUST_PERSON.SetCellValue("ENABLED_FLAG", "Y");
                    }
                    if (idaCUST_BANK_ACCT.IsFocused && idaCUSTOMER_SITE.CurrentRow != null)
                    {
                        idaCUST_BANK_ACCT.AddOver();
                        isgBANK_ACCOUNT.SetCellValue("EFFECTIVE_DATE_FR", DateTime.Today);
                        isgBANK_ACCOUNT.SetCellValue("ENABLED_FLAG", "Y");
                        Insert_Bank_Account();
                    }

                    //if (isAppInterfaceAdv1.SOB_ID.ToString() == "10")
                    //{
                    //    CUST_SITE_CODE.Nullable = true;
                    //    CUST_SITE_CODE.ReadOnly = true;
                    //}
                    //else
                    //{
                    //    CUST_SITE_CODE.Nullable = false;
                    //    CUST_SITE_CODE.ReadOnly = false;
                    //}
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaCUSTOMER_SITE.IsFocused)    // AR_CUSTOMER
                    {
                        idaCUSTOMER_SITE.AddUnder();
                        Form_DefaultValue();
                    }
                    if (idaCUST_SHIP_TO.IsFocused && idaCUSTOMER_SITE.CurrentRow != null)    // AR_CUSTOMER_SHIP_TO
                    {
                        idaCUST_SHIP_TO.AddUnder();
                        isgCUST_SHIP_TO.SetCellValue("EFFECTIVE_DATE_FR", DateTime.Today);
                        isgCUST_SHIP_TO.SetCellValue("ENABLED_FLAG", "Y");
                    }
                    if (idaCUST_PERSON.IsFocused && idaCUSTOMER_SITE.CurrentRow != null)    // AR_CUSTOMER_PERSON
                    {
                        idaCUST_PERSON.AddUnder();
                        isgCUST_PERSON.SetCellValue("EFFECTIVE_DATE_FR", DateTime.Today);
                        isgCUST_PERSON.SetCellValue("ENABLED_FLAG", "Y");
                    }
                    if (idaCUST_BANK_ACCT.IsFocused && idaCUSTOMER_SITE.CurrentRow != null)
                    {
                        idaCUST_BANK_ACCT.AddUnder();
                        isgBANK_ACCOUNT.SetCellValue("EFFECTIVE_DATE_FR", DateTime.Today);
                        isgBANK_ACCOUNT.SetCellValue("ENABLED_FLAG", "Y");
                        Insert_Bank_Account();
                    }

                    //if (isAppInterfaceAdv1.SOB_ID.ToString() == "10")
                    //{
                    //    CUST_SITE_CODE.Nullable = true;
                    //    CUST_SITE_CODE.ReadOnly = true;
                    //}
                    //else
                    //{
                    //    CUST_SITE_CODE.Nullable = false;
                    //    CUST_SITE_CODE.ReadOnly = false;
                    //}
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    //if (idaCUSTOMER_SITE.Refillable == false)
                    //{
                        if (Pre_Update() == false)
                        {
                            return;
                        }
                        idaCUSTOMER_SITE.Update();

                        //if (Convert.ToString(idaCUSTOMER_SITE.GetInsertParamValue("O_CUST_CODE")) != "")
                        //{
                        //    CUST_SITE_CODE.EditValue = idaCUSTOMER_SITE.GetInsertParamValue("O_CUST_CODE");
                        //    idaCUSTOMER_SITE.CurrentRow.AcceptChanges();
                        //    idaCUSTOMER_SITE.Refillable = true;
                        //}

                        // Insert Error Routine
                        //if (idaCUSTOMER_SITE.GetInsertParamValue("X_ERR_MSG") != null)
                        //{
                        //    MessageBoxAdv.Show(idaCUSTOMER_SITE.GetInsertParamValue("X_ERR_MSG").ToString());
                        //}
                        //// Update Error Routine
                        //if (idaCUSTOMER_SITE.GetUpdateParamValue("X_ERR_MSG") != null)
                        //{
                        //    MessageBoxAdv.Show(idaCUSTOMER_SITE.GetUpdateParamValue("X_ERR_MSG").ToString());
                        //}
                    //}

                    //if (idaCUST_SHIP_TO.Refillable == false)
                    //{
                    //    idaCUST_SHIP_TO.Update();
                    //    // Insert Error Routine
                    //    if (idaCUST_SHIP_TO.GetInsertParamValue("X_ERR_MSG") != null)
                    //    {
                    //        MessageBoxAdv.Show(idaCUST_SHIP_TO.GetInsertParamValue("X_ERR_MSG").ToString());
                    //    }
                    //    // Update Error Routine
                    //    if (idaCUST_SHIP_TO.GetUpdateParamValue("X_ERR_MSG") != null)
                    //    {
                    //        MessageBoxAdv.Show(idaCUST_SHIP_TO.GetUpdateParamValue("X_ERR_MSG").ToString());
                    //    }
                    //}

                    //if (idaCUST_PERSON.Refillable == false)
                    //{
                    //    idaCUST_PERSON.Update();
                    //    // Insert Error Routine
                    //    if (idaCUST_PERSON.GetInsertParamValue("X_ERR_MSG") != null)
                    //    {
                    //        MessageBoxAdv.Show(idaCUST_PERSON.GetInsertParamValue("X_ERR_MSG").ToString());
                    //    }
                    //    // Update Error Routine
                    //    if (idaCUST_PERSON.GetUpdateParamValue("X_ERR_MSG") != null)
                    //    {
                    //        MessageBoxAdv.Show(idaCUST_PERSON.GetUpdateParamValue("X_ERR_MSG").ToString());
                    //    }
                    //}
                    //if (idaCUST_BANK_ACCT.Refillable == false)
                    //{
                    //    idaCUST_BANK_ACCT.Update();
                    //}
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaCUSTOMER_SITE.IsFocused)
                    {
                        idaCUSTOMER_SITE.Cancel();
                    }
                    if (idaCUST_SHIP_TO.IsFocused)
                    {
                        idaCUST_SHIP_TO.Cancel();
                    }
                    if (idaCUST_PERSON.IsFocused)
                    {
                        idaCUST_PERSON.Cancel();
                    }
                    if (idaCUST_BANK_ACCT.IsFocused)
                    {
                        idaCUST_BANK_ACCT.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaCUST_BANK_ACCT.IsFocused)
                    {
                        idaCUST_BANK_ACCT.Delete();
                    }
                }
            }
        }

        #endregion;

        #region -- Data Find --
        private void AR_CUSTOMER_INQUIRY()
        {
            idaCUSTOMER_SITE.Fill();

            CUST_SITE_CODE.Focus();
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

        #region 
        private bool Pre_Update()
        {
            bool CHK_RESULT = true;

            //if (idaCUSTOMER_SITE.Refillable == false)
            //{
            //    //고객코드
            //    if (string.IsNullOrEmpty(CUST_SITE_CODE.EditValue.ToString()))
            //    {
            //        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", "&&FIELD_NAME:=Customer Code"), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            //        CHK_RESULT = false;
            //        return CHK_RESULT;
            //    }

            //    //고객명
            //    if (string.IsNullOrEmpty(CUST_SITE_FULL_NAME.EditValue.ToString()))
            //    {
            //        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", "&&FIELD_NAME:=Customer Full Name"), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            //        CHK_RESULT = false;
            //        return CHK_RESULT;
            //    }

            //    //약명
            //    if (string.IsNullOrEmpty(CUST_SITE_SHORT_NAME.EditValue.ToString()))
            //    {
            //        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", "&&FIELD_NAME:=Customer Short Name"), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            //        CHK_RESULT = false;
            //        return CHK_RESULT;
            //    }

            //    //고객 Party
            //    if (string.IsNullOrEmpty(CUST_PARTY_DESC.EditValue.ToString()))
            //    {
            //        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", "&&FIELD_NAME:=Customer Party"), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            //        CHK_RESULT = false;
            //        return CHK_RESULT;
            //    }

            //    //국가
            //    if (string.IsNullOrEmpty(COUNTRY_CODE.EditValue.ToString()))
            //    {
            //        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", "&&FIELD_NAME:=Country"), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            //        CHK_RESULT = false;
            //        return CHK_RESULT;
            //    }

            //    //거래시작일
            //    if (EFFECTIVE_DATE_FR.EditValue == null)
            //    {
            //        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", "&&FIELD_NAME:=Effective Date(F)"), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            //        CHK_RESULT = false;
            //        return CHK_RESULT;
            //    }
            //}

            if (idaCUST_SHIP_TO.Refillable == false)
            {
                
            }

            if (idaCUST_PERSON.Refillable == false)
            {

            }
            return CHK_RESULT;
        }

        #endregion

        private void CUST_SITE_CODE_CurrentEditValidating(object pSender, ISEditAdvValidatingEventArgs e)
        {

            //if (idaCUSTOMER_SITE.CurrentRow != null && idaCUSTOMER_SITE.CurrentRow.RowState == DataRowState.Added)
            //{
            //    string V_Check_Result = null;

            //    idcCUST_SITE_CODE.ExecuteNonQuery();
            //    V_Check_Result = idcCUST_SITE_CODE.GetCommandParamValue("X_CHECK_RESULT").ToString();


            //    if (V_Check_Result == "N".ToString())
            //    {
            //        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90003", "&&FIELD_NAME:=Customer Site Code"), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            //        e.Cancel = true;
            //    }
            //}
        }

        private void TAX_REG_NO_CurrentEditValidating(object pSender, ISEditAdvValidatingEventArgs e)
        {
            //if (idaCUSTOMER_SITE.CurrentRow != null && idaCUSTOMER_SITE.CurrentRow.RowState == DataRowState.Added)
            //{
            //    string V_Check_Result = null;

            //    idcTAX_REG_NO.ExecuteNonQuery();
            //    V_Check_Result = idcTAX_REG_NO.GetCommandParamValue("X_CHECK_RESULT").ToString();

            //    if (V_Check_Result == 'N'.ToString())
            //    {
            //        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90003", "&&FIELD_NAME:=Tax Registration No"), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            //        e.Cancel = true;
            //    }
            //}
        }


        private void ilaCUST_PARTY_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCUST_PARTY.SetLookupParamValue("W_LOOKUP_MODULE", Convert.ToString("PO"));
            ildCUST_PARTY.SetLookupParamValue("W_LOOKUP_TYPE", Convert.ToString("SUPPLIER_CLASS"));
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

        private void ilaTAX_BILL_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildTAX_BILL_TYPE.SetLookupParamValue("W_LOOKUP_MODULE", Convert.ToString("EAPP"));
            ildTAX_BILL_TYPE.SetLookupParamValue("W_LOOKUP_TYPE", Convert.ToString("TAX_BILL_TYPE"));
        }

        private void ilaACCOUNT_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            //ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "ACCOUNT_TYPE");
            //ildCOMMON.SetLookupParamValue("W_ENABLED_YN", "Y");
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

        #region ----- Adapter Event ------
        
        private void idaCUSTOMER_SITE_PreRowUpdate(ISPreRowUpdateEventArgs e)
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

        private void idaCUSTOMER_SITE_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10047"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
                e.Cancel = true;
                return;
            }
        }

        private void idaCUST_BANK_ACCT_PreRowUpdate(ISPreRowUpdateEventArgs e)
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

        private void idaCUST_BANK_ACCT_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10047"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
                e.Cancel = true;
                return;
            }
        }
        #endregion

        private void ilaCUST_SITE_V_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCUST_SITE_V.SetLookupParamValue("W_SUPP_CUST_TYPE", "C");
            ildCUST_SITE_V.SetLookupParamValue("W_ENABLED_YN", "N");
        }

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