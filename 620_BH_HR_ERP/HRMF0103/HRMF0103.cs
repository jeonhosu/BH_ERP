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

namespace HRMF0103
{
    public partial class HRMF0103 : Office2007Form
    {
        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        public HRMF0103(Form pMainFom, ISAppInterface pAppInterface)
        {
            InitializeComponent();

            this.MdiParent = pMainFom;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #region ----- Method -----
        private void DefaultSetFormReSize()
        {//[Child Form, Mdi Form에 맞게 ReSize]
            int vMinusWidth = 4;
            int vMinusHeight = 54;
            System.Drawing.Size vSize = this.MdiParent.ClientSize;
            this.Width = vSize.Width - vMinusWidth;
            this.Height = vSize.Height - vMinusHeight;
        }

        private void DefaultCorporation()
        {
            // Lookup SETTING
            ildCORP.SetLookupParamValue("W_DUTY_CONTROL_YN", "Y");
            ildCORP.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");

            // LOOKUP DEFAULT VALUE SETTING - CORP
            idcDEFAULT_CORP.SetCommandParamValue("W_DUTY_CONTROL_YN", "Y");
            idcDEFAULT_CORP.SetCommandParamValue("W_ENABLED_FLAG_YN", "N");
            idcDEFAULT_CORP.ExecuteNonQuery();
            CORP_NAME_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_NAME");
            CORP_ID_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_ID");
            DEPT_LEVEL_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_DEPT_CONTROL_LEVEL");
        }

        private void SEARCH_DB()
        {
            if (CORP_ID_0.EditValue == null)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME_0.Focus();
                return;
            }
            
            if (itbDEPT.SelectedTab.TabIndex == Convert.ToInt32(1))
            {
                isDataAdapter1.SetSelectParamValue("W_SOB_ID", isAppInterfaceAdv1.SOB_ID);
                isDataAdapter1.SetSelectParamValue("W_ORG_ID", isAppInterfaceAdv1.ORG_ID);
                isDataAdapter1.Fill();
                igrDEPT.Focus();
            }
            else if (itbDEPT.SelectedTab.TabIndex == Convert.ToInt32(2))
            {
                if (iString.ISNull(MODULE_TYPE_0.EditValue) == string.Empty)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10130"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    MODULE_TYPE_NAME_0.Focus();
                    return;
                }
                idaDEPT_MAPPING.Fill();
                igrDEPT_MAPPING.Focus();
            }
        }

        private void Insert_Dept()
        {
            igrDEPT.SetCellValue("USABLE", "Y");
            igrDEPT.SetCellValue("START_DATE", iDate.ISMonth_1st(DateTime.Today));
        }

        private void Insert_Dept_Mapping()
        {
            igrDEPT_MAPPING.SetCellValue("MODULE_TYPE", MODULE_TYPE_0.EditValue);
            igrDEPT_MAPPING.SetCellValue("MODULE_TYPE_NAME", MODULE_TYPE_NAME_0.EditValue);
            igrDEPT_MAPPING.SetCellValue("CORP_ID", CORP_ID_0.EditValue);
            igrDEPT_MAPPING.SetCellValue("ENABLED_FLAG", "Y");
            igrDEPT_MAPPING.SetCellValue("EFFECTIVE_DATE_FR", DateTime.Today);

        }

        #endregion

        #region ----- main Button Click ------
        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
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
                        Insert_Dept();
                    }
                    else if (idaDEPT_MAPPING.IsFocused)
                    {
                        idaDEPT_MAPPING.AddOver();
                        Insert_Dept_Mapping();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (isDataAdapter1.IsFocused)
                    {
                        isDataAdapter1.AddUnder();
                        Insert_Dept();
                    }
                    else if (idaDEPT_MAPPING.IsFocused)
                    {
                        idaDEPT_MAPPING.AddUnder();
                        Insert_Dept_Mapping();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (isDataAdapter1.IsFocused)
                    {
                        isDataAdapter1.SetInsertParamValue("P_SOB_ID", isAppInterfaceAdv1.SOB_ID);
                        isDataAdapter1.SetInsertParamValue("P_ORG_ID", isAppInterfaceAdv1.ORG_ID);

                        isDataAdapter1.SetInsertParamValue("P_CORP_ID", CORP_ID_0.EditValue);
                        isDataAdapter1.SetInsertParamValue("P_USER_ID", isAppInterfaceAdv1.AppInterface.UserId);

                        isDataAdapter1.SetUpdateParamValue("P_CORP_ID", CORP_ID_0.EditValue);
                        isDataAdapter1.SetUpdateParamValue("P_USER_ID", isAppInterfaceAdv1.AppInterface.UserId);

                        isDataAdapter1.Update();
                    }
                    else if (idaDEPT_MAPPING.IsFocused)
                    {
                        idaDEPT_MAPPING.SetInsertParamValue("P_CORP_ID", CORP_ID_0.EditValue);
                        idaDEPT_MAPPING.Update();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (isDataAdapter1.IsFocused)
                    {
                        isDataAdapter1.Cancel();
                    }
                    else if (idaDEPT_MAPPING.IsFocused)
                    {
                        idaDEPT_MAPPING.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (isDataAdapter1.IsFocused)
                    {
                        isDataAdapter1.Delete();
                    }
                    else if (idaDEPT_MAPPING.IsFocused)
                    {
                        idaDEPT_MAPPING.Delete();
                    }
                }
            }
        }
        #endregion

        #region ----- Form Event -----
        private void HRMF0103_Load(object sender, EventArgs e)
        {
            isDataAdapter1.FillSchema();
            idaDEPT_MAPPING.FillSchema();

            DefaultCorporation();
            //DefaultSetFormReSize();		//[Child Form, Mdi Form에 맞게 ReSize]
        }
        #endregion

        #region ---- Adapter Event -----
        private void isDataAdapter1_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {

            if (iString.ISNull(CORP_ID_0.EditValue) == string.Empty)
            {// 업체
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["DEPT_CODE"]) == string.Empty)
            {// 부서코드
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10019"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["DEPT_NAME"]) == string.Empty)
            {// 부서명
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10020"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["DEPT_LEVEL"]) == string.Empty)
            {// 부서 레벨
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10021"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNumtoZero(e.Row["DEPT_LEVEL"]) > Convert.ToInt32(1))
            {// 부서 레벨이 0이 아닐경우 상위부서는 반드시 선택해야 합니다.
                if (iString.ISNull(e.Row["UPPER_DEPT_ID"]) == string.Empty)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10132"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
            }
            if (iString.ISNumtoZero(e.Row["DEPT_LEVEL"]) > iString.ISNumtoZero(DEPT_LEVEL_0.EditValue))
            {// 회계장부의 부서레벨과 입력 부서 레벨 체크.                
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10133"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["START_DATE"]) == string.Empty)
            {// 시작일자 
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["END_DATE"]) != string.Empty)
            {// 종료일자 
                if (Convert.ToDateTime(e.Row["START_DATE"]) > Convert.ToDateTime(e.Row["END_DATE"]))
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
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

        private void idaDEPT_MAPPING_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (CORP_ID_0.EditValue == null)
            {// 업체
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["MODULE_TYPE"]) == String.Empty)
            {// 모듈명
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10130"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["HR_DEPT_ID"]) == String.Empty)
            {// 인사부서
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10020"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["M_DEPT_ID"]) == String.Empty)
            {// 맵핑부서
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10131"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["EFFECTIVE_DATE_FR"]) == String.Empty)
            {// 시작일자 
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["EFFECTIVE_DATE_TO"]) != String.Empty)
            {// 종료일자 
                if (Convert.ToDateTime(e.Row["EFFECTIVE_DATE_FR"]) > Convert.ToDateTime(e.Row["EFFECTIVE_DATE_TO"]))
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
            }
        }

        private void idaDEPT_MAPPING_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:=해당 자료"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
                e.Cancel = true;
                return;
            }
        }

        #endregion

        #region ---- Lookup Event -----
        private void ilaDEPT_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT_2.SetLookupParamValue("W_USABLE_CHECK_YN", "Y");
        }

        private void ilaDEPT_UPPER_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT_UPPER.SetLookupParamValue("W_USABLE_CHECK_YN", "Y");
        }

        private void ilaMODULE_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "SYS_MODULE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        private void ilaMODULE_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "SYS_MODULE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }
        
        private void ilaHR_DEPT_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT_2.SetLookupParamValue("W_USABLE_CHECK_YN", "Y");
        }

        private void ilaM_DEPT_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildM_MAPPING_DEPT.SetLookupParamValue("W_MODULE_TYPE", MODULE_TYPE_0.EditValue);
            ildM_MAPPING_DEPT.SetLookupParamValue("W_ENABLED_YN", "N");
        }

        private void ilaM_DEPT_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildM_MAPPING_DEPT.SetLookupParamValue("W_MODULE_TYPE", igrDEPT_MAPPING.GetCellValue("MODULE_TYPE"));
            ildM_MAPPING_DEPT.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        #endregion

    }
}