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

namespace FCMF0521
{
    public partial class FCMF0521 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public FCMF0521()
        {
            InitializeComponent();
        }

        public FCMF0521(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void SearchDB()
        {
            idaBALANCE_ACCOUNTS.Fill();
            igrACCOUNTS.Focus();
        }

        private void INSERT_ACCOUNTS()
        {
            ENABLED_FLAG.CheckBoxValue = "Y";
            EFFECTIVE_DATE_FR.EditValue = iDate.ISMonth_1st(DateTime.Today) ;

            ACCOUNT_CODE.Focus();
        }

        private void SetCommonParameter(string pGroup_Code, string pEnabled_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        }

        private void Set_Account_Item()
        {// 계정의 관리항목 정보.
            idaACCOUNT_ITEM.Fill();
            if (idaACCOUNT_ITEM.OraSelectData.Rows.Count > 0)
            {                
                MANAGEMENT1_DESC.EditValue = idaACCOUNT_ITEM.CurrentRow["MANAGEMENT1_DESC"];
                MANAGEMENT1_CODE.EditValue = idaACCOUNT_ITEM.CurrentRow["MANAGEMENT1_CODE"];
                MANAGEMENT1_ID.EditValue = idaACCOUNT_ITEM.CurrentRow["MANAGEMENT1_ID"];
                ENABLED1_FLAG.CheckBoxValue = idaACCOUNT_ITEM.CurrentRow["MANAGEMENT1_YN"];
                
                MANAGEMENT2_DESC.EditValue = idaACCOUNT_ITEM.CurrentRow["MANAGEMENT2_DESC"];
                MANAGEMENT2_CODE.EditValue = idaACCOUNT_ITEM.CurrentRow["MANAGEMENT2_CODE"];
                MANAGEMENT2_ID.EditValue = idaACCOUNT_ITEM.CurrentRow["MANAGEMENT2_ID"];
                ENABLED2_FLAG.CheckBoxValue = idaACCOUNT_ITEM.CurrentRow["MANAGEMENT2_YN"];

                MANAGEMENT3_DESC.EditValue = idaACCOUNT_ITEM.CurrentRow["MANAGEMENT3_DESC"];
                MANAGEMENT3_CODE.EditValue = idaACCOUNT_ITEM.CurrentRow["MANAGEMENT3_CODE"];
                MANAGEMENT3_ID.EditValue = idaACCOUNT_ITEM.CurrentRow["MANAGEMENT3_ID"];
                ENABLED3_FLAG.CheckBoxValue = idaACCOUNT_ITEM.CurrentRow["MANAGEMENT3_YN"];

                MANAGEMENT4_DESC.EditValue = idaACCOUNT_ITEM.CurrentRow["MANAGEMENT4_DESC"];
                MANAGEMENT4_CODE.EditValue = idaACCOUNT_ITEM.CurrentRow["MANAGEMENT4_CODE"];
                MANAGEMENT4_ID.EditValue = idaACCOUNT_ITEM.CurrentRow["MANAGEMENT4_ID"];
                ENABLED4_FLAG.CheckBoxValue = idaACCOUNT_ITEM.CurrentRow["MANAGEMENT4_YN"];

                MANAGEMENT5_DESC.EditValue = idaACCOUNT_ITEM.CurrentRow["MANAGEMENT5_DESC"];
                MANAGEMENT5_CODE.EditValue = idaACCOUNT_ITEM.CurrentRow["MANAGEMENT5_CODE"];
                MANAGEMENT5_ID.EditValue = idaACCOUNT_ITEM.CurrentRow["MANAGEMENT5_ID"];
                ENABLED5_FLAG.CheckBoxValue = idaACCOUNT_ITEM.CurrentRow["MANAGEMENT5_YN"];

                MANAGEMENT6_DESC.EditValue = idaACCOUNT_ITEM.CurrentRow["MANAGEMENT6_DESC"];
                MANAGEMENT6_CODE.EditValue = idaACCOUNT_ITEM.CurrentRow["MANAGEMENT6_CODE"];
                MANAGEMENT6_ID.EditValue = idaACCOUNT_ITEM.CurrentRow["MANAGEMENT6_ID"];
                ENABLED6_FLAG.CheckBoxValue = idaACCOUNT_ITEM.CurrentRow["MANAGEMENT6_YN"];

                MANAGEMENT7_DESC.EditValue = idaACCOUNT_ITEM.CurrentRow["MANAGEMENT7_DESC"];
                MANAGEMENT7_CODE.EditValue = idaACCOUNT_ITEM.CurrentRow["MANAGEMENT7_CODE"];
                MANAGEMENT7_ID.EditValue = idaACCOUNT_ITEM.CurrentRow["MANAGEMENT7_ID"];
                ENABLED7_FLAG.CheckBoxValue = idaACCOUNT_ITEM.CurrentRow["MANAGEMENT7_YN"];

                MANAGEMENT8_DESC.EditValue = idaACCOUNT_ITEM.CurrentRow["MANAGEMENT8_DESC"];
                MANAGEMENT8_CODE.EditValue = idaACCOUNT_ITEM.CurrentRow["MANAGEMENT8_CODE"];
                MANAGEMENT8_ID.EditValue = idaACCOUNT_ITEM.CurrentRow["MANAGEMENT8_ID"];
                ENABLED8_FLAG.CheckBoxValue = idaACCOUNT_ITEM.CurrentRow["MANAGEMENT8_YN"];

                MANAGEMENT9_DESC.EditValue = idaACCOUNT_ITEM.CurrentRow["MANAGEMENT9_DESC"];
                MANAGEMENT9_CODE.EditValue = idaACCOUNT_ITEM.CurrentRow["MANAGEMENT9_CODE"];
                MANAGEMENT9_ID.EditValue = idaACCOUNT_ITEM.CurrentRow["MANAGEMENT9_ID"];
                ENABLED9_FLAG.CheckBoxValue = idaACCOUNT_ITEM.CurrentRow["MANAGEMENT9_YN"];

                MANAGEMENT10_DESC.EditValue = idaACCOUNT_ITEM.CurrentRow["MANAGEMENT10_DESC"];
                MANAGEMENT10_CODE.EditValue = idaACCOUNT_ITEM.CurrentRow["MANAGEMENT10_CODE"];
                MANAGEMENT10_ID.EditValue = idaACCOUNT_ITEM.CurrentRow["MANAGEMENT10_ID"];
                ENABLED10_FLAG.CheckBoxValue = idaACCOUNT_ITEM.CurrentRow["MANAGEMENT10_YN"];
            }
            else
            {
                MANAGEMENT1_DESC.EditValue = null;
                MANAGEMENT1_CODE.EditValue = null;
                MANAGEMENT1_ID.EditValue = null;
                ENABLED1_FLAG.CheckBoxValue = "N";

                MANAGEMENT2_DESC.EditValue = null;
                MANAGEMENT2_CODE.EditValue = null;
                MANAGEMENT2_ID.EditValue = null;
                ENABLED2_FLAG.CheckBoxValue = "N";

                MANAGEMENT3_DESC.EditValue = null;
                MANAGEMENT3_CODE.EditValue = null;
                MANAGEMENT3_ID.EditValue = null;
                ENABLED3_FLAG.CheckBoxValue = "N";

                MANAGEMENT4_DESC.EditValue = null;
                MANAGEMENT4_CODE.EditValue = null;
                MANAGEMENT4_ID.EditValue = null;
                ENABLED4_FLAG.CheckBoxValue = "N";

                MANAGEMENT5_DESC.EditValue = null;
                MANAGEMENT5_CODE.EditValue = null;
                MANAGEMENT5_ID.EditValue = null;
                ENABLED5_FLAG.CheckBoxValue = "N";

                MANAGEMENT6_DESC.EditValue = null;
                MANAGEMENT6_CODE.EditValue = null;
                MANAGEMENT6_ID.EditValue = null;
                ENABLED6_FLAG.CheckBoxValue = "N";

                MANAGEMENT7_DESC.EditValue = null;
                MANAGEMENT7_CODE.EditValue = null;
                MANAGEMENT7_ID.EditValue = null;
                ENABLED7_FLAG.CheckBoxValue = "N";

                MANAGEMENT8_DESC.EditValue = null;
                MANAGEMENT8_CODE.EditValue = null;
                MANAGEMENT8_ID.EditValue = null;
                ENABLED8_FLAG.CheckBoxValue = "N";

                MANAGEMENT9_DESC.EditValue = null;
                MANAGEMENT9_CODE.EditValue = null;
                MANAGEMENT9_ID.EditValue = null;
                ENABLED9_FLAG.CheckBoxValue = "N";

                MANAGEMENT10_DESC.EditValue = null;
                MANAGEMENT10_CODE.EditValue = null;
                MANAGEMENT10_ID.EditValue = null;
                ENABLED10_FLAG.CheckBoxValue = "N";
            }
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
                    if (idaBALANCE_ACCOUNTS.IsFocused)
                    {
                        idaBALANCE_ACCOUNTS.AddOver();
                        INSERT_ACCOUNTS();
                     }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaBALANCE_ACCOUNTS.IsFocused)
                    {                        
                        idaBALANCE_ACCOUNTS.AddUnder();
                        INSERT_ACCOUNTS();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    idaBALANCE_ACCOUNTS.Update();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaBALANCE_ACCOUNTS.IsFocused)
                    {
                        idaBALANCE_ACCOUNTS.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaBALANCE_ACCOUNTS.IsFocused)
                    {
                        idaBALANCE_ACCOUNTS.Delete();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {
                    if (idaBALANCE_ACCOUNTS.IsFocused)
                    {
                    } 
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                    if (idaBALANCE_ACCOUNTS.IsFocused)
                    {
                    }
                }
            }
        }

        #endregion;

        #region ----- Form Event -----
        
        private void FCMF0521_Load(object sender, EventArgs e)
        {
            idaBALANCE_ACCOUNTS.FillSchema();
        }
        
        private void FCMF0521_Shown(object sender, EventArgs e)
        {
            ESTIMATE_YN_0.CheckBoxValue = "N";
            ENABLED_FLAG_0.CheckBoxValue = "Y";
        }

        private void CONTROL_CURRENCY_YN_CheckedChange(object pSender, ISCheckEventArgs e)
        {
            if (iString.ISNull(CONTROL_CURRENCY_YN.CheckBoxValue) == "Y" && iString.ISNull(ESTIMATE_YN.CheckBoxValue) == "N")
            {
                ESTIMATE_YN.CheckBoxValue = "Y";
            }
        }
        #endregion

        #region ----- Lookup Event -----

        private void ilaACCOUNT_CONTROL_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildACCOUNT_CONTROL.SetLookupParamValue("W_ACCOUNT_CODE_FR", null);
            ildACCOUNT_CONTROL.SetLookupParamValue("W_ENABLED_YN", "N");
        }

        private void ilaACCOUNT_CODE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildACCOUNT_CONTROL.SetLookupParamValue("W_ACCOUNT_CODE_FR", null);
            ildACCOUNT_CONTROL.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaACCOUNT_CONTROL_SelectedRowData(object pSender)
        {
            Set_Account_Item();
        }

        private void ilaMANAGEMENT_CODE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("MANAGEMENT_CODE", "Y");
        }

        #endregion

        #region ----- Adapter Event -----


        private void idaBALANCE_ACCOUNTS_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["ACCOUNT_CODE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10123"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["ACCOUNT_CONTROL_ID"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10123"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["EFFECTIVE_DATE_FR"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            //관리항목 미선택시 사용여부선택할수 없음.
            if (iString.ISNull(MANAGEMENT1_ID.EditValue) == string.Empty && iString.ISNull(e.Row["ENABLED1_FLAG"]) == "Y")
            {
                MessageBoxAdv.Show(string.Format("[1]-{0}", isMessageAdapter1.ReturnText("FCM_10310")), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(MANAGEMENT2_ID.EditValue) == string.Empty && iString.ISNull(e.Row["ENABLED2_FLAG"]) == "Y")
            {
                MessageBoxAdv.Show(string.Format("[2]-{0}", isMessageAdapter1.ReturnText("FCM_10310")), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(MANAGEMENT3_ID.EditValue) == string.Empty && iString.ISNull(e.Row["ENABLED3_FLAG"]) == "Y")
            {
                MessageBoxAdv.Show(string.Format("[3]-{0}", isMessageAdapter1.ReturnText("FCM_10310")), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(MANAGEMENT4_ID.EditValue) == string.Empty && iString.ISNull(e.Row["ENABLED4_FLAG"]) == "Y")
            {
                MessageBoxAdv.Show(string.Format("[4]-{0}", isMessageAdapter1.ReturnText("FCM_10310")), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(MANAGEMENT5_ID.EditValue) == string.Empty && iString.ISNull(e.Row["ENABLED5_FLAG"]) == "Y")
            {
                MessageBoxAdv.Show(string.Format("[5]-{0}", isMessageAdapter1.ReturnText("FCM_10310")), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(MANAGEMENT6_ID.EditValue) == string.Empty && iString.ISNull(e.Row["ENABLED6_FLAG"]) == "Y")
            {
                MessageBoxAdv.Show(string.Format("[6]-{0}", isMessageAdapter1.ReturnText("FCM_10310")), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(MANAGEMENT7_ID.EditValue) == string.Empty && iString.ISNull(e.Row["ENABLED7_FLAG"]) == "Y")
            {
                MessageBoxAdv.Show(string.Format("[7]-{0}", isMessageAdapter1.ReturnText("FCM_10310")), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(MANAGEMENT8_ID.EditValue) == string.Empty && iString.ISNull(e.Row["ENABLED8_FLAG"]) == "Y")
            {
                MessageBoxAdv.Show(string.Format("[8]-{0}", isMessageAdapter1.ReturnText("FCM_10310")), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(MANAGEMENT9_ID.EditValue) == string.Empty && iString.ISNull(e.Row["ENABLED9_FLAG"]) == "Y")
            {
                MessageBoxAdv.Show(string.Format("[9]-{0}", isMessageAdapter1.ReturnText("FCM_10310")), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(MANAGEMENT10_ID.EditValue) == string.Empty && iString.ISNull(e.Row["ENABLED10_FLAG"]) == "Y")
            {
                MessageBoxAdv.Show(string.Format("[10]-{0}", isMessageAdapter1.ReturnText("FCM_10310")), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (iString.ISNull(e.Row["ENABLED1_FLAG"]) == "N" && iString.ISNull(e.Row["BALANCE1_YN"]) == "Y")
            {
                MessageBoxAdv.Show(string.Format("[1]-{0}", isMessageAdapter1.ReturnText("FCM_10309")), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["ENABLED2_FLAG"]) == "N" && iString.ISNull(e.Row["BALANCE2_YN"]) == "Y")
            {
                MessageBoxAdv.Show(string.Format("[2]-{0}", isMessageAdapter1.ReturnText("FCM_10309")), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["ENABLED3_FLAG"]) == "N" && iString.ISNull(e.Row["BALANCE3_YN"]) == "Y")
            {
                MessageBoxAdv.Show(string.Format("[3]-{0}", isMessageAdapter1.ReturnText("FCM_10309")), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["ENABLED4_FLAG"]) == "N" && iString.ISNull(e.Row["BALANCE4_YN"]) == "Y")
            {
                MessageBoxAdv.Show(string.Format("[4]-{0}", isMessageAdapter1.ReturnText("FCM_10309")), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["ENABLED5_FLAG"]) == "N" && iString.ISNull(e.Row["BALANCE5_YN"]) == "Y")
            {
                MessageBoxAdv.Show(string.Format("[5]-{0}", isMessageAdapter1.ReturnText("FCM_10309")), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["ENABLED6_FLAG"]) == "N" && iString.ISNull(e.Row["BALANCE6_YN"]) == "Y")
            {
                MessageBoxAdv.Show(string.Format("[6]-{0}", isMessageAdapter1.ReturnText("FCM_10309")), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["ENABLED7_FLAG"]) == "N" && iString.ISNull(e.Row["BALANCE7_YN"]) == "Y")
            {
                MessageBoxAdv.Show(string.Format("[7]-{0}", isMessageAdapter1.ReturnText("FCM_10309")), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["ENABLED8_FLAG"]) == "N" && iString.ISNull(e.Row["BALANCE8_YN"]) == "Y")
            {
                MessageBoxAdv.Show(string.Format("[8]-{0}", isMessageAdapter1.ReturnText("FCM_10309")), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["ENABLED9_FLAG"]) == "N" && iString.ISNull(e.Row["BALANCE9_YN"]) == "Y")
            {
                MessageBoxAdv.Show(string.Format("[9]-{0}", isMessageAdapter1.ReturnText("FCM_10309")), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["ENABLED10_FLAG"]) == "N" && iString.ISNull(e.Row["BALANCE10_YN"]) == "Y")
            {
                MessageBoxAdv.Show(string.Format("[10]-{0}", isMessageAdapter1.ReturnText("FCM_10309")), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaBALANCE_ACCOUNTS_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:=Data(데이터)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
                e.Cancel = true;
                return;
            }
        }
        
        #endregion               

    }
}