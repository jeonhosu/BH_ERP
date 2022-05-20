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

namespace FCMF0113
{
    public partial class FCMF0113 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public FCMF0113()
        {
            InitializeComponent();
        }

        public FCMF0113(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void Search_DB()
        {
            if (iString.ISNull(FORM_TYPE_ID_0.EditValue) == string.Empty)               
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10156"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                FORM_TYPE_NAME_0.Focus();
                return;
            }

            idaFORM_HEADER.Fill();
            idaFORM.Fill();
            idaMISS_ACCOUNT.Fill();
            if (itbFORM.SelectedTab.TabIndex == 1)
            {                
                Init_Form_Line();
                igrFORM_HEADER.Focus();
            }
            else if (itbFORM.SelectedTab.TabIndex == 2)
            {                
                igrFORM.Focus();
            }
            else if (itbFORM.SelectedTab.TabIndex == 3)
            {                
                igrMISS_ACCOUNT.Focus();
            }
        }

        private void Insert_Header()
        {            
            FORM_TYPE_NAME_0.ReadOnly = true;
            
            FORM_TYPE_ID.EditValue = FORM_TYPE_ID_0.EditValue;
            DISPLAY_YN.CheckBoxValue = "Y";
            AMOUNT_PRINT_YN.CheckBoxValue = "Y";
            ENABLED_FLAG.CheckBoxValue = "Y";
            EFFECTIVE_DATE_FR.EditValue = iDate.ISMonth_1st(DateTime.Today);

            FORM_ITEM_CODE.Focus();
        }

        private void Insert_Line()
        {
            if (iString.ISNull(ITEM_LEVEL.EditValue) == string.Empty)
            {
                idaFORM_LINE.Delete();
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10160"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                ITEM_LEVEL.Focus();
                return;
            }
            FORM_TYPE_NAME_0.ReadOnly = true;
            Set_Last_Level();            
            igrFORM_LINE.SetCellValue("ITEM_SIGN_SHOW", "+");
            igrFORM_LINE.SetCellValue("LAST_LEVEL_YN", LAST_LEVEL_YN.EditValue);
            igrFORM_LINE.SetCellValue("ENABLED_FLAG", "Y");  
            igrFORM_LINE.SetCellValue("EFFECTIVE_DATE_FR", iDate.ISMonth_1st(DateTime.Today));
        }
      
        private void SetCommonParameter(string pGroup_Code, string pEnabled_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        }

        #endregion;

        #region ----- Initialization -----

        private void Set_Last_Level()
        {
            int mForm_Type_Level = iString.ISNumtoZero(FORM_TYPE_LEVEL_1.EditValue);
            int mItem_Level = iString.ISNumtoZero(ITEM_LEVEL.EditValue);
            if (mForm_Type_Level == mItem_Level)
            {// 최종 레벨.
                LAST_LEVEL_YN.EditValue = "Y";
            }
            else
            {
                LAST_LEVEL_YN.EditValue = "N";
            }
            Init_Form_Line();
        }

        private void Init_Form_Line()
        {            
            if (iString.ISNull(LAST_LEVEL_YN.EditValue, "N") == "Y".ToString())
            {// 최종레벨 --> 계정과목 표시.
                igrFORM_LINE.GridAdvExColElement[igrFORM_LINE.GetColumnToIndex("JOIN_LINE_CONTROL_NAME")].LookupAdapter = ilaACCOUNT_CONTROL;
            }
            else
            {
                igrFORM_LINE.GridAdvExColElement[igrFORM_LINE.GetColumnToIndex("JOIN_LINE_CONTROL_NAME")].LookupAdapter = ilaFORM_ITEM_LEVEL;
            }
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
                    if (idaFORM_LINE.IsFocused)
                    {
                        idaFORM_LINE.AddOver();
                        Insert_Line();
                    }
                    else if (idaFORM_HEADER.IsFocused)
                    {
                        if (iString.ISNull(FORM_TYPE_ID_0.EditValue) == string.Empty)
                        {
                            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10156"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                            FORM_TYPE_NAME_0.Focus();
                            return;
                        }
                        idaFORM_HEADER.AddOver();
                        Insert_Header();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaFORM_LINE.IsFocused)
                    {
                        idaFORM_LINE.AddUnder();
                        Insert_Line();                        
                    }
                    else if (idaFORM_HEADER.IsFocused)
                    {
                        if (iString.ISNull(FORM_TYPE_ID_0.EditValue) == string.Empty)
                        {
                            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10156"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                            FORM_TYPE_NAME_0.Focus();
                            return;
                        }
                        idaFORM_HEADER.AddUnder();
                        Insert_Header();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    try
                    {
                        idaFORM_HEADER.Update();
                    }
                    catch
                    {
                    }
                    FORM_TYPE_NAME_0.ReadOnly = false;
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaFORM_LINE.IsFocused)
                    {
                        idaFORM_LINE.Cancel();
                    }
                    else if (idaFORM_HEADER.IsFocused)
                    {
                        idaFORM_LINE.Cancel();
                        idaFORM_HEADER.Cancel();
                    }
                    FORM_TYPE_NAME_0.ReadOnly = false;
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaFORM_LINE.IsFocused)
                    {
                        idaFORM_LINE.Delete();
                    }
                    else if (idaFORM_HEADER.IsFocused)
                    {
                        idaFORM_HEADER.Delete();
                    }
                    FORM_TYPE_NAME_0.ReadOnly = false;
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void FCMF0113_Load(object sender, EventArgs e)
        {
            idaFORM_HEADER.FillSchema();
        }

        private void ITEM_LEVEL_CurrentEditValidating(object pSender, ISEditAdvValidatingEventArgs e)
        {
            if (iString.ISNumtoZero(FORM_TYPE_LEVEL_1.EditValue) < iString.ISNumtoZero(ITEM_LEVEL.EditValue))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10133"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                ITEM_LEVEL.Focus();
            }
        }

        private void ITEM_LEVEL_CurrentEditValidated(object pSender, ISEditAdvValidatedEventArgs e)
        {            
            Set_Last_Level();
        }

        #endregion

        #region ----- Lookup Event -----

        private void ilaFORM_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("FORM_TYPE", "Y");
        }

        private void ilaFORM_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("FORM_TYPE", "Y");
        }

        private void ilaACCOUNT_DR_CR_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("ACCOUNT_DR_CR", "Y");
        }

        private void ilaACCOUNT_CONTROL_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildACCOUNT_CONTROL.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaFORM_ITEM_LEVEL_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildFORM_ITEM_LEVEL.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaFORM_ITEM_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("FORM_ITEM_TYPE", "Y");
        }

        private void ilaFORM_ITEM_CLASS_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("FORM_ITEM_CLASS", "Y");
        }

        private void ilaRELATE_FORM_ITEM_RefreshLookupData(object pSender, ISRefreshLookupDataEventArgs e)
        {
            ildRELATE_FORM_ITEM.SetLookupParamValue("W_ENABLED_YN", "Y");
        }
               
        #endregion

        #region ----- Adapter Event -----

        private void idaFORM_HEADER_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["FORM_TYPE_ID"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10156"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["FORM_ITEM_CODE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10157"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["FORM_ITEM_NAME"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10158"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["SORT_SEQ"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10159"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNumtoZero(e.Row["ITEM_LEVEL"], 0) == Convert.ToInt32(0))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10160"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNumtoZero(FORM_TYPE_LEVEL_1.EditValue, 0) < iString.ISNumtoZero(e.Row["ITEM_LEVEL"], 0))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10133"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                ITEM_LEVEL.Focus();
            }
            if (iString.ISNull(e.Row["COLUMN_POSITION_NUM"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10162"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["ACCOUNT_DR_CR"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10122"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }            
            if (iString.ISNull(e.Row["EFFECTIVE_DATE_FR"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaFORM_HEADER_PreDelete(ISPreDeleteEventArgs e)
        {
        }

        private void idaFORM_LINE_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["JOIN_LINE_CONTROL_ID"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10163"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["ITEM_SIGN_SHOW"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10164"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }            
            if (iString.ISNull(e.Row["EFFECTIVE_DATE_FR"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaFORM_LINE_PreDelete(ISPreDeleteEventArgs e)
        {
        }

        private void idaFORM_HEADER_NewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            Init_Form_Line();
        }

        #endregion        

 
    }
}