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

namespace HRMF0221
{
    public partial class HRMF0221 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public HRMF0221()
        {
            InitializeComponent();
        }

        public HRMF0221(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----
        private void DefaultCorporation()
        {
            ildCORP.SetLookupParamValue("W_DUTY_CONTROL_YN", "Y");
            ildCORP.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");

            // Lookup SETTING
            ildDISPATCH_CORP.SetLookupParamValue("W_CORP_TYPE", "4");
            ildDISPATCH_CORP.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");

            // LOOKUP DEFAULT VALUE SETTING - CORP
            idcDEFAULT_CORP.SetCommandParamValue("W_DUTY_CONTROL_YN", "Y");
            idcDEFAULT_CORP.SetCommandParamValue("W_ENABLED_FLAG_YN", "N");
            idcDEFAULT_CORP.ExecuteNonQuery();
            WORK_CORP_NAME_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_NAME");
            WORK_CORP_ID_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_ID");
        }

        private void Insert_Dispatch_Person()
        {
            igrPERSON_INFO.SetCellValue("WORK_CORP_ID", WORK_CORP_ID_0.EditValue);
            igrPERSON_INFO.SetCellValue("WORK_CORP_NAME", WORK_CORP_NAME_0.EditValue);
            igrPERSON_INFO.SetCellValue("ORI_JOIN_DATE", DateTime.Today);
            igrPERSON_INFO.SetCellValue("JOIN_DATE", DateTime.Today);

            idcEMPLOYE_STATUS.SetCommandParamValue("W_GROUP_CODE", "EMPLOYE_TYPE");
            idcEMPLOYE_STATUS.ExecuteNonQuery();
            igrPERSON_INFO.SetCellValue("EMPLOYE_TYPE", idcEMPLOYE_STATUS.GetCommandParamValue("O_CODE"));
            igrPERSON_INFO.SetCellValue("EMPLOYE_TYPE_NAME", idcEMPLOYE_STATUS.GetCommandParamValue("O_CODE_NAME"));

            igrPERSON_INFO.CurrentCellMoveTo(igrPERSON_INFO.GetColumnToIndex("NAME"));
            igrPERSON_INFO.Focus();
        }

        private void Set_Common_Parameter(string pGroup_Code, string pEnabled_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", pEnabled_YN);
        }

        private void Search_DB()
        {
            idaPERSON.Fill();

            igrPERSON_INFO.CurrentCellMoveTo(igrPERSON_INFO.GetColumnToIndex("NAME"));
            igrPERSON_INFO.Focus();
        }
        #endregion;

        #region ----- 주민번호 체크 ------
        private bool Repre_Num_Validating_Check(object pRepre_Num)
        {
            if (iString.ISNull(pRepre_Num) == string.Empty)
            {
                return true;
            }

            // 전호수 주석 : '-' 입력 체크 안함. 단, DB에서 자릿수 검증후 '-' 자동 입력 처리.
            //if (pRepre_Num.ToString().IndexOf("-") == -1)
            //{
            //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10092"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    return false;
            //}

            string isReturnValue = null;
            idcREPRE_NUM_CHECK.SetCommandParamValue("P_REPRE_NUM", pRepre_Num);
            idcREPRE_NUM_CHECK.ExecuteNonQuery();
            isReturnValue = idcREPRE_NUM_CHECK.GetCommandParamValue("O_RETURN_VALUE").ToString();
            igrPERSON_INFO.SetCellValue("SEX_TYPE", idcREPRE_NUM_CHECK.GetCommandParamValue("O_SEX_TYPE"));
            if (isReturnValue == "N".ToString())
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10026"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return false;
            }
            idcSEX_TYPE.SetCommandParamValue("W_GROUP_CODE", "SEX_TYPE");
            idcSEX_TYPE.SetCommandParamValue("W_CODE", igrPERSON_INFO.GetCellValue("SEX_TYPE"));
            idcSEX_TYPE.ExecuteNonQuery();
            igrPERSON_INFO.SetCellValue("SEX_NAME", idcSEX_TYPE.GetCommandParamValue("O_RETURN_VALUE"));

            if (iString.ISNull(igrPERSON_INFO.GetCellValue("BIRTHDAY")) == string.Empty)
            {// 생년월일이 기존에 없을 경우 자동 설정.                
                string mSex_Type = pRepre_Num.ToString().Replace("-", "").Substring(6, 1);
                if (mSex_Type == "1".ToString() || mSex_Type == "2".ToString() || mSex_Type == "5".ToString() || mSex_Type == "6".ToString())
                {
                    igrPERSON_INFO.SetCellValue("BIRTHDAY", DateTime.Parse("19" + pRepre_Num.ToString().Substring(0, 2)
                                                        + "-".ToString()
                                                        + pRepre_Num.ToString().Substring(2, 2)
                                                        + "-".ToString()
                                                        + pRepre_Num.ToString().Substring(4, 2)));
                }
                else
                {
                    igrPERSON_INFO.SetCellValue("BIRTHDAY", DateTime.Parse("20" + pRepre_Num.ToString().Substring(0, 2)
                                                        + "-".ToString()
                                                        + pRepre_Num.ToString().Substring(2, 2)
                                                        + "-".ToString()
                                                        + pRepre_Num.ToString().Substring(4, 2)));
                }
                // 음양구분.
                idcCOMMON_W.SetCommandParamValue("W_GROUP_CODE", "BIRTHDAY_TYPE");
                idcCOMMON_W.SetCommandParamValue("W_WHERE", " 1 = 1 ");
                idcCOMMON_W.ExecuteNonQuery();
                igrPERSON_INFO.SetCellValue("BIRTHDAY_TYPE_NAME", idcCOMMON_W.GetCommandParamValue("O_CODE_NAME"));
                igrPERSON_INFO.SetCellValue("BIRTHDAY_TYPE", idcCOMMON_W.GetCommandParamValue("O_CODE"));
            }
            return true;
        }
        #endregion

        #region ----- Events -----
        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    Search_DB();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    if (idaPERSON.IsFocused)
                    {
                        idaPERSON.AddOver();
                        Insert_Dispatch_Person();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaPERSON.IsFocused)
                    {
                        idaPERSON.AddUnder();
                        Insert_Dispatch_Person();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    
                    idaPERSON.Update();
                    
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaPERSON.IsFocused)
                    {
                        idaPERSON.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaPERSON.IsFocused)
                    {
                        idaPERSON.Delete();
                    }
                }
            }
        }

        #endregion;

        #region ----- Form Event -----
        private void HRMF0221_Load(object sender, EventArgs e)
        {
            idaPERSON.FillSchema();
            DefaultCorporation();
        }

        #endregion

        #region ----- Adapter Event -----
        private void idaPERSON_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (string.IsNullOrEmpty(e.Row["NAME"].ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Person Name(성명)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["CORP_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Corporation(소속 업체)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["WORK_CORP_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Dispatch Corporation(근무 업체)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            //if (e.Row["OPERATING_UNIT_ID"] == DBNull.Value)
            //{
            //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Operating Unit(사업장)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    e.Cancel = true;
            //    return;
            //}
            if (e.Row["DEPT_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Department(부서)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            //if (e.Row["NATION_ID"] == DBNull.Value)
            //{
            //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=국가"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    e.Cancel = true;
            //    return;
            //}
            if (e.Row["JOB_CLASS_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Job Class(직군)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            //if (e.Row["JOB_ID"] == DBNull.Value)
            //{
            //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Job(직종)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    e.Cancel = true;
            //    return;
            //}
            //if (e.Row["POST_ID"] == DBNull.Value)
            //{
            //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Post(직위)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    e.Cancel = true;
            //    return;
            //}
            //if (e.Row["OCPT_ID"] == DBNull.Value)
            //{
            //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Ocpt(직무)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    e.Cancel = true;
            //    return;
            //}
            //if (e.Row["ABIL_ID"] == DBNull.Value)
            //{
            //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Abil(직책)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    e.Cancel = true;
            //    return;
            //}
            //if (e.Row["PAY_GRADE_ID"] == DBNull.Value)
            //{
            //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Pay Grade(직급)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    e.Cancel = true;
            //    return;
            //}
            if (string.IsNullOrEmpty(e.Row["REPRE_NUM"].ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Repre Num(주민번호)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (string.IsNullOrEmpty(e.Row["SEX_TYPE"].ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Sex Type(성별)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            //if (e.Row["JOIN_ID"] == DBNull.Value)
            //{
            //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=입사구분"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    e.Cancel = true;
            //    return;
            //}
            if (e.Row["ORI_JOIN_DATE"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Ori Join Date(그룹입사일)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["JOIN_DATE"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Join Date(입사일)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            //if (string.IsNullOrEmpty(e.Row["DIR_INDIR_TYPE"].ToString()))
            //{
            //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Dir/InDir Type(직간접 구분)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    e.Cancel = true;
            //    return;
            //}
            if (string.IsNullOrEmpty(e.Row["EMPLOYE_TYPE"].ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Employee Status(재직구분)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["RETIRE_DATE"]) != string.Empty && iString.ISNull(e.Row["RETIRE_ID"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10170"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["RETIRE_DATE"]) == string.Empty && iString.ISNull(e.Row["RETIRE_ID"]) != string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10171"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["JOB_CATEGORY_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Job Category(직구분)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["FLOOR_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Floor(작업장)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaPERSON_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:=Person Infomation(인사정보)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        } 
        #endregion

        #region ----- LOOKUP Event -----

        private void ilaEMPLOYE_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            Set_Common_Parameter("EMPLOYE_TYPE", "Y");
        }

        private void ilaEMPLOYE_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            Set_Common_Parameter("EMPLOYE_TYPE", "Y");
        }

        private void ilaJOB_CLASS_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            Set_Common_Parameter("JOB_CLASS", "Y");
        }

        private void ilaFLOOR_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            Set_Common_Parameter("FLOOR", "Y");
        }

        private void ilaWORK_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            Set_Common_Parameter("WORK_TYPE", "Y");
        }

        private void ilaJOB_CATEGORY_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            Set_Common_Parameter("JOB_CATEGORY", "Y");
        }

        private void ilaRETIRE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            Set_Common_Parameter("RETIRE", "Y");
        }

        private void ilaWORK_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "WORK_TYPE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        private void ilaFLOOR_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildFLOOR_0.SetLookupParamValue("W_GROUP_CODE", "FLOOR");
            ildFLOOR_0.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        private void ilaFLOOR_1_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildFLOOR_1.SetLookupParamValue("W_GROUP_CODE", "FLOOR");
            ildFLOOR_1.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }
        private void ilaCOST_CENTER_SelectedRowData(object pSender)
        {
            System.Windows.Forms.SendKeys.Send("{TAB}");
        }

        #endregion

        #region ----- Cell Validating Event -----

        private void igrPERSON_INFO_CurrentCellValidating(object pSender, ISGridAdvExValidatingEventArgs e)
        {
            if (e.ColIndex == igrPERSON_INFO.GetColumnToIndex("REPRE_NUM"))
            {
                if (Repre_Num_Validating_Check(e.NewValue) == false)
                {
                }
            }
        }

        #endregion

        #region ----- KeyDown Event -----

        private void NAME_0_KeyDown(object pSender, KeyEventArgs e)
        {
            if (e.KeyCode == System.Windows.Forms.Keys.Enter)
            {
                Search_DB();
            }
        }

        #endregion

    }
}