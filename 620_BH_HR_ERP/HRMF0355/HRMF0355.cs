using System;
using System.Data;
using System.Drawing;
using System.Windows.Forms;
using System.Collections.Generic;

using Syncfusion.Windows.Forms;
using Syncfusion.Windows.Forms.Tools;
using Syncfusion.Windows.Forms.Grid;
using InfoSummit.Win.ControlAdv;

namespace HRMF0355
{
    public partial class HRMF0355 : Office2007Form
    {
        #region ----- Variables -----

        private ISCommonUtil.ISFunction.ISDateTime mGetDate = new ISCommonUtil.ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public HRMF0355()
        {
            InitializeComponent();
        }

        public HRMF0355(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- MDi ToolBar Button Events -----

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    DB_Search();
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
                    if (idaDAY_INTERFACE_TRANS.IsFocused)
                    {
                        idaDAY_INTERFACE_TRANS.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void HRMF0355_Load(object sender, EventArgs e)
        {
            DefaultCorporation();
            DefaultEmploye();
        }

        private void HRMF0355_Shown(object sender, EventArgs e)
        {
            System.DateTime vDate = mGetDate.ISGetDate();

            WORK_DATE_FR_0.EditValue = mGetDate.ISMonth_1st(vDate);
            WORK_DATE_TO_0.EditValue = mGetDate.ISMonth_Last(vDate);
        }

        #endregion

        #region ----- Lookup Event -----

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

        private void ilaEMPLOYE_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "EMPLOYE_TYPE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        #endregion

        #region ----- User Method -----

        private void DefaultCorporation()
        {
            // Lookup SETTING
            ildCORP.SetLookupParamValue("W_DUTY_CONTROL_YN", "Y");
            ildCORP.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");

            // LOOKUP DEFAULT VALUE SETTING - CORP
            idcDEFAULT_CORP.SetCommandParamValue("W_DUTY_CONTROL_YN", "Y");
            idcDEFAULT_CORP.SetCommandParamValue("W_ENABLED_FLAG_YN", "N");
            idcDEFAULT_CORP.ExecuteNonQuery();
            //CORP_NAME_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_NAME");
            //CORP_ID_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_ID");
            WORK_CORP_NAME_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_NAME");
            WORK_CORP_ID_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_ID");
        }

        private void DefaultEmploye()
        {
            idcDEFAULT_EMPLOYE_TYPE_0.SetCommandParamValue("W_GROUP_CODE", "EMPLOYE_TYPE");
            idcDEFAULT_EMPLOYE_TYPE_0.ExecuteNonQuery();
            EMPLOYE_TYPE_NAME_0.EditValue = idcDEFAULT_EMPLOYE_TYPE_0.GetCommandParamValue("O_CODE_NAME");
            EMPLOYE_TYPE_0.EditValue = idcDEFAULT_EMPLOYE_TYPE_0.GetCommandParamValue("O_CODE");
        }

        private void DB_Search()
        {
            ISCommonUtil.ISFunction.ISConvert vString = new ISCommonUtil.ISFunction.ISConvert();

            object vObject1 = FLOOR_NAME_0.EditValue;
            object vObject2 = PERSON_NAME_0.EditValue;
            if (vString.ISNull(vObject1) == string.Empty && vString.ISNull(vObject2) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10305"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            idaDAY_INTERFACE_TRANS.Fill();
        }

        #endregion;

        #region ----- Edit Event -----

        private void WORK_DATE_FR_0_EditValueChanged(object pSender)
        {
            System.DateTime vDate = WORK_DATE_FR_0.DateTimeValue;
            WORK_DATE_TO_0.EditValue = mGetDate.ISMonth_Last(vDate);
        }

        #endregion
    }
}