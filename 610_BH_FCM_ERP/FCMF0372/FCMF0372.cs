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

namespace FCMF0372
{
    public partial class FCMF0372 : Office2007Form
    {
        #region ----- Variables -----

        private ISFunction.ISConvert iString = new ISFunction.ISConvert();
        private ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();
        
        #endregion;

        #region ----- Constructor -----

        public FCMF0372()
        {
            InitializeComponent();
        }

        public FCMF0372(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Convert decimal  Method ----

        private decimal ConvertNumber(object pObject)
        {
            bool vIsConvert = false;
            decimal vConvertDecimal = 0m;

            try
            {
                if (pObject != null)
                {
                    vIsConvert = pObject is decimal;
                    if (vIsConvert == true)
                    {
                        decimal vIsConvertNum = (decimal)pObject;
                        vConvertDecimal = vIsConvertNum;
                    }
                }

            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }

            return vConvertDecimal;
        }

        #endregion;

        #region ----- Convert String Method ----

        private string ConvertString(object pObject)
        {
            string vString = string.Empty;

            try
            {
                if (pObject != null)
                {
                    bool IsConvert = pObject is string;
                    if (IsConvert == true)
                    {
                        vString = pObject as string;
                    }
                }
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }

            return vString;
        }

        #endregion;

        #region ----- Private Methods -----

        private void Search_DB()
        {
            if (iString.ISNull(ASSET_CATEGORY_ID_0.EditValue) == string.Empty)
            {
                //자산유형은 필수입니다.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10398"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                ASSET_CATEGORY_NAME_0.Focus();
                return;
            };

            string vASSET_CODE = iString.ISNull(ASSET_CODE.EditValue);
            int vIDX_ASSET_CODE = igrASSET_MASTER.GetColumnToIndex("ASSET_CODE");

            idaASSET_MASTER.Fill();

            for (int r = 0; r < igrASSET_MASTER.RowCount; r++)
            {
                if (iString.ISNull(igrASSET_MASTER.GetCellValue(r, vIDX_ASSET_CODE)) == vASSET_CODE)
                {
                    igrASSET_MASTER.CurrentCellMoveTo(r, vIDX_ASSET_CODE);
                    igrASSET_MASTER.CurrentCellActivate(r, vIDX_ASSET_CODE);
                    igrASSET_MASTER.Focus();
                    return;
                }
            }
            igrASSET_MASTER.Focus();
        }

        private void Search_DB_HISTORY()
        {
            //idaASSET_HISTORY.Fill();
        }

        private void Search_DB_LIST_ASSET_DPR_HISTORY()
        {
            idaLIST_ASSET_DPR_HISTORY.Fill();
        }

        private void UpdateDB()
        {
            object vOjbect = null;
            decimal vDecimal = 0;

            if (AMOUNT.EditValue != null)
            {
                vOjbect = AMOUNT.EditValue;
                vDecimal = ConvertNumber(vOjbect);

                if (vDecimal == 0)
                {
                    //자산 취득금액은 0보다 커야 합니다.
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10400"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }
            }

            if (IFRS_PROGRESS_YEAR.EditValue != null)
            {
                vOjbect = IFRS_PROGRESS_YEAR.EditValue;
                vDecimal = ConvertNumber(vOjbect);

                if (vDecimal == 0)
                {
                    //내용년수는 0보다 커야 합니다.
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10401"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }
            }

            idaASSET_MASTER.Update();

            Search_DB();
        }

        private void SetCommon_Lookup_Parameter(string pGroup_Code, string pEnabled_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        }

        private void Insert_ASSET_CATEGORY()
        {
            ACQUIRE_DATE.EditValue = System.DateTime.Today;
            ASSET_CATEGORY_NAME.EditValue = ASSET_CATEGORY_NAME_0.EditValue;
            ASSET_CATEGORY_ID.EditValue = ASSET_CATEGORY_ID_0.EditValue;
            ASSET_STATUS_NAME.EditValue = "사용";
            ASSET_STATUS_CODE.EditValue = "10";
            IFRS_RESIDUAL_AMOUNT.EditValue = IFRS_RESIDUAL_AMOUNT_0.EditValue;
            IFRS_PROGRESS_YEAR.EditValue = IFRS_PROGRESS_YEAR_0.EditValue;
            IFRS_DPR_METHOD_TYPE.EditValue = IFRS_DPR_METHOD_TYPE_0.EditValue;
            IFRS_DPR_METHOD_NAME.EditValue = IFRS_DPR_METHOD_TYPE_NAME_0.EditValue;

            IFRS_DPR_STATUS_NAME.EditValue = "미상각";
            IFRS_DPR_STATUS_CODE.EditValue = "20";

            ASSET_DESC.Focus();
        }

        private void Insert_ASSET_HISTORY()
        {
            if (CC_DESC.EditValue != null && COST_CENTER_ID.EditValue != null)
            {
                object vObject_CC_DESC = CC_DESC.EditValue;
                object vObject_COST_CENTER_ID = COST_CENTER_ID.EditValue;

                igrASSET_HISTORY.SetCellValue("CC_DESC", vObject_CC_DESC);
                igrASSET_HISTORY.SetCellValue("COST_CENTER_ID", vObject_COST_CENTER_ID);
            }
        }

        private bool IsInsert_ASSET_MASTER()
        {
            bool IsInsert = true;

            object vObject_ASSET_STATUS_CODE = ASSET_STATUS_CODE.EditValue;

            string vString_ASSET_STATUS_CODE = ConvertString(vObject_ASSET_STATUS_CODE);

            if (vString_ASSET_STATUS_CODE == "80" || vString_ASSET_STATUS_CODE == "90")
            {
                IsInsert = false;
            }

            return IsInsert;
        }

        private bool IsDelete_ASSET_MASTER()
        {
            bool IsDelete = true;

            object vObject_ASSET_CHANGE_YN = igrASSET_MASTER.GetCellValue("ASSET_CHANGE_YN");
            object vObject_IFRS_DPR_STATUS_CODE = igrASSET_MASTER.GetCellValue("IFRS_DPR_STATUS_CODE");

            string vString_ASSET_CHANGE_YN = ConvertString(vObject_ASSET_CHANGE_YN);
            string vString_IFRS_DPR_STATUS_CODE = ConvertString(vObject_IFRS_DPR_STATUS_CODE);

            if (vString_ASSET_CHANGE_YN == "Y" || vString_IFRS_DPR_STATUS_CODE != "20")
            {
                IsDelete = false;
            }

            return IsDelete;
        }

        #endregion;

        #region ----- Territory Get Methods ----

        private int GetTerritory(ISUtil.Enum.TerritoryLanguage pTerritoryEnum)
        {
            int vTerritory = 0;

            switch (pTerritoryEnum)
            {
                case ISUtil.Enum.TerritoryLanguage.Default:
                    vTerritory = 1;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL1_KR:
                    vTerritory = 2;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL2_CN:
                    vTerritory = 3;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL3_VN:
                    vTerritory = 4;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL4_JP:
                    vTerritory = 5;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL5_XAA:
                    vTerritory = 6;
                    break;
            }

            return vTerritory;
        }

        private object Get_Edit_Prompt(InfoSummit.Win.ControlAdv.ISEditAdv pEdit)
        {
            int mIDX = 0;
            object mPrompt = null;
            switch (isAppInterfaceAdv1.AppInterface.OraConnectionInfo.TerritoryLanguage)
            {
                case ISUtil.Enum.TerritoryLanguage.Default:
                    mPrompt = pEdit.PromptTextElement[mIDX].Default;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL1_KR:
                    mPrompt = pEdit.PromptTextElement[mIDX].TL1_KR;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL2_CN:
                    mPrompt = pEdit.PromptTextElement[mIDX].TL2_CN;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL3_VN:
                    mPrompt = pEdit.PromptTextElement[mIDX].TL3_VN;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL4_JP:
                    mPrompt = pEdit.PromptTextElement[mIDX].TL4_JP;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL5_XAA:
                    mPrompt = pEdit.PromptTextElement[mIDX].TL5_XAA;
                    break;
            }
            return mPrompt;
        }

        #endregion;

        #region ----- MDi ToolBar Button Events -----

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
                    if (idaASSET_MASTER.IsFocused)
                    {
                        if (iString.ISNull(ASSET_CATEGORY_ID_0.EditValue) == string.Empty)
                        {
                            //자산유형은 필수입니다.
                            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10398"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                            ASSET_CATEGORY_NAME_0.Focus();
                            return;
                        };

                        idaASSET_MASTER.AddOver();

                        Insert_ASSET_CATEGORY();
                    }
                    else if (idaASSET_HISTORY.IsFocused)
                    {
                        if (iString.ISNull(ASSET_CODE.EditValue) == string.Empty)
                        {
                            //자산 선택후 추가 바랍니다.
                            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10399"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                            return;
                        }
                        else
                        {
                            bool IsInsert = IsInsert_ASSET_MASTER();

                            if (IsInsert == false)
                            {
                                //매각 또는 폐기된 자산으로 변동내역을 등록할 수 없습니다.
                                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10403"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                                return;
                            }

                            idaASSET_HISTORY.AddOver();

                            Insert_ASSET_HISTORY();
                        }
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaASSET_MASTER.IsFocused)
                    {
                        if (iString.ISNull(ASSET_CATEGORY_ID_0.EditValue) == string.Empty)
                        {
                            //자산유형은 필수입니다.
                            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10398"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                            ASSET_CATEGORY_NAME_0.Focus();
                            return;
                        };

                        idaASSET_MASTER.AddUnder();

                        Insert_ASSET_CATEGORY();
                    }
                    else if (idaASSET_HISTORY.IsFocused)
                    {
                        if (iString.ISNull(ASSET_CODE.EditValue) == string.Empty)
                        {
                            //자산 선택후 추가 바랍니다.
                            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10399"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                            return;
                        }
                        else
                        {
                            bool IsInsert = IsInsert_ASSET_MASTER();

                            if (IsInsert == false)
                            {
                                //매각 또는 폐기된 자산으로 변동내역을 등록할 수 없습니다.
                                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10403"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                                return;
                            }

                            idaASSET_HISTORY.AddUnder();

                            Insert_ASSET_HISTORY();
                        }

                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    System.Windows.Forms.SendKeys.Send("{TAB}");

                    idaASSET_MASTER.Update();

                    //if (idaASSET_MASTER.IsFocused)
                    //{
                    //    UpdateDB();
                    //}
                    //else if (idaASSET_HISTORY.IsFocused)
                    //{
                    //    idaASSET_HISTORY.Update();
                    //}
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaASSET_MASTER.IsFocused)
                    {
                        idaASSET_MASTER.Cancel();
                    }
                    else if (idaASSET_HISTORY.IsFocused)
                    {
                        idaASSET_HISTORY.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaASSET_MASTER.IsFocused)
                    {
                        bool isDelete = IsDelete_ASSET_MASTER();

                        if (isDelete == false)
                        {
                            //자산변동내역 자료 존재 또는 상각이 진행된 자료로 삭제할 수 없습니다.
                            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10402"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                            return;
                        }

                        System.Windows.Forms.DialogResult vChoiceValue;

                        string vMessageString1 = isMessageAdapter1.ReturnText("EAPP_10030"); //삭제 하시겠습니까?
                        vChoiceValue = MessageBoxAdv.Show(vMessageString1, "Delete", System.Windows.Forms.MessageBoxButtons.YesNo, System.Windows.Forms.MessageBoxIcon.Question, System.Windows.Forms.MessageBoxDefaultButton.Button2);

                        if (vChoiceValue == System.Windows.Forms.DialogResult.Yes)
                        {
                            try
                            {
                                idaASSET_MASTER.Delete();

                                idaASSET_MASTER.Update();
                            }
                            catch
                            {
                            }
                        }
                    }
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void FCMF0372_Load(object sender, EventArgs e)
        {
            idaASSET_MASTER.FillSchema();
            idaASSET_HISTORY.FillSchema();
            idaLIST_ASSET_DPR_HISTORY.FillSchema();
        }

        #endregion
        
        #region ----- Lookup Event -----

        private void ilaASSET_CATEGORY_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildASSET_CATEGORY.SetLookupParamValue("W_ENABLED_YN", "N");
        }

        private void ilaCOSTCENTER_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOSTCENTER.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaEXPENSE_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommon_Lookup_Parameter("EXPENSE_TYPE", "Y");
        }

        private void ilaIFRS_DPR_METHOD_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommon_Lookup_Parameter("DPR_METHOD_TYPE", "Y");
        }

        private void ilaDEPT_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaDPR_METHOD_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommon_Lookup_Parameter("DPR_METHOD_TYPE", "Y");
        }

        private void ilaASSET_STATUS_NAME_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommon_Lookup_Parameter("ASSET_STATUS", "Y");
        }

        private void ilaCUSTOMER_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCUSTOMER.SetLookupParamValue("W_SUPP_CUST_TYPE", "S");
            ildCUSTOMER.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaH_ASSET_CHARGE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommon_Lookup_Parameter("ASSET_CHARGE", "Y");
        }

        private void ilaH_DEPT_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaASSET_CATEGORY_0_SelectedRowData(object pSender)
        {
            Search_DB();
        }

        private void ilaIFRS_DPR_STATUS_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommon_Lookup_Parameter("DPR_STATUS", "Y");
        }

        private void ilaASSET_STATUS_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommon_Lookup_Parameter("ASSET_STATUS", "Y");
        }

        private void ILA_TAX_CODE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommon_Lookup_Parameter("TAX_CODE", "Y");
        }

        private void ILA_HISTORY_TAX_CODE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommon_Lookup_Parameter("TAX_CODE", "Y");
        }

        #endregion

        #region ----- Adapeter Event -----

        private void idaASSET_MASTER_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["ASSET_DESC"]) == string.Empty)
            {
                //자산명은 필수항목입니다.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10201"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["ASSET_STATUS_CODE"]) == string.Empty)
            {
                //자산상태는 필수입니다.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10410"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["IFRS_DPR_STATUS_CODE"]) == string.Empty)
            {
                //상각상태는 필수입니다.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10411"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISDecimaltoZero(e.Row["AMOUNT"], 0) == 0)
            {
                //자산 취득금액은 0보다 커야 합니다.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10400"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["TAX_CODE"]) == string.Empty)
            {// 사업장코드
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", string.Format("&&FIELD_NAME:={0}", TAX_DESC.PromptText)), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["IFRS_DPR_METHOD_TYPE"]) != string.Empty && iString.ISDecimaltoZero(e.Row["IFRS_PROGRESS_YEAR"], 0) == 0)
            {
                //내용년수는 0보다 커야 합니다.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10401"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaASSET_MASTER_NewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            Search_DB_HISTORY();
            Search_DB_LIST_ASSET_DPR_HISTORY();
        }

        private void idaASSET_MASTER_UpdateCompleted(object pSender)
        {
            Search_DB();
        }

        #endregion

        #region ----- Edit Event -----

        private void ACQUIRE_DATE_EditValueChanged(object pSender)
        {
            REGISTER_DATE.EditValue = ACQUIRE_DATE.EditValue;
        }

        #endregion

        #region ----- Grid Event -----


        #endregion

    }
}