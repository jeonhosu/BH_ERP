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

namespace HRMF0213
{
    public partial class HRMF0213 : Office2007Form
    {
        #region ----- Constructor -----

        public HRMF0213(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();

            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- User Method ----

        private void DefaultCorporation()
        {
            // Lookup SETTING
            ildCORP.SetLookupParamValue("W_DEPT_CONTROL_YN", "Y");
            ildCORP.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");

            // LOOKUP DEFAULT VALUE SETTING - CORP
            idcDEFAULT_CORP.SetCommandParamValue("W_DEPT_CONTROL_YN", "Y");
            idcDEFAULT_CORP.SetCommandParamValue("W_ENABLED_FLAG_YN", "N");
            idcDEFAULT_CORP.ExecuteNonQuery();
            CORP_NAME_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_NAME");
            CORP_ID_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_ID");
        }

        private void DefaultEmploye()
        {
            idcDEFAULT_EMPLOYE_TYPE_1.SetCommandParamValue("W_GROUP_CODE", "EMPLOYE_TYPE");
            idcDEFAULT_EMPLOYE_TYPE_1.ExecuteNonQuery();
            EMPLOYE_TYPE_NAME_0.EditValue = idcDEFAULT_EMPLOYE_TYPE_1.GetCommandParamValue("O_CODE_NAME");
            EMPLOYE_TYPE_0.EditValue = idcDEFAULT_EMPLOYE_TYPE_1.GetCommandParamValue("O_CODE");
        }

        private void SetCommonParameter(object pGroup_Code, object pEnabled_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);            
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        }

        private void SEARCH_DB()
        {
            //ISCommonUtil.ISFunction.ISConvert vString = new ISCommonUtil.ISFunction.ISConvert();

            //object vObject1 = FLOOR_NAME_0.EditValue;
            //object vObject2 = WORK_TYPE_NAME_0.EditValue;
            //object vObject3 = DEPT_NAME_0.EditValue;
            //if (vString.ISNull(vObject1) == string.Empty && vString.ISNull(vObject2) == string.Empty && vString.ISNull(vObject3) == string.Empty)
            //{
            //    //검색 조건을 선택 하세요!
            //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10305"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    return;
            //}
            idaPERSON_LIST.Fill();
            igrPERSON_DETAIL.Focus();
        }

        #endregion

        #region ----- MDi TollBar Button Event -----

        public void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    SEARCH_DB();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                   
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {

                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {

                }
            }
        }
        #endregion

        #region ----- Form Event -----

        private void HRMF0213_Load(object sender, EventArgs e)
        {
                      
        }

        private void HRMF0213_Shown(object sender, EventArgs e)
        {
            //DefaultCorporation();
            DefaultEmploye();
        }
        
        #endregion

        #region ----- Lookup Event -----

        private void ilaEMPLOYE_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("EMPLOYE_TYPE", "Y");
        }

        private void ilaDEPT_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT.SetLookupParamValue("W_USABLE_CHECK_YN", "Y");
        }

        private void ilaFLOOR_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildFLOOR_0.SetLookupParamValue("W_GROUP_CODE", "FLOOR");
            ildFLOOR_0.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        private void ilaWORK_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "WORK_TYPE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        private void ilaPERSON_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            object vObject_START_DATE = new System.DateTime(1999, 01, 02);
            object vObject_END_DATE = System.DateTime.Today;
            ildPERSON_0.SetLookupParamValue("W_START_DATE", vObject_START_DATE);
            ildPERSON_0.SetLookupParamValue("W_END_DATE", vObject_END_DATE);
        }

        #endregion


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

        #region ----- Edit Event ----

        private void SEARCH_NAME_KeyDown(object pSender, KeyEventArgs e)
        {
            if (e.KeyCode == System.Windows.Forms.Keys.Enter)
            {
                bool isConvert = SEARCH_NAME.EditValue is string;
                if (isConvert == true)
                {
                    string vText = SEARCH_NAME.EditValue as string;
                    bool isNull = string.IsNullOrEmpty(vText);
                    if (isNull != true)
                    {
                        SEARCH_DB();
                    }
                }
            }
        }

        #endregion
    }
}