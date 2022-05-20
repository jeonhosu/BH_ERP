using System;
using System.Data;
using System.Drawing;
using System.Windows.Forms;
using System.Collections.Generic;

using Syncfusion.Windows.Forms;
using Syncfusion.Windows.Forms.Tools;
using Syncfusion.Windows.Forms.Grid;
using InfoSummit.Win.ControlAdv;

namespace HRMF0344
{
    public partial class HRMF0344 : Office2007Form
    {
        #region ----- Variables -----

        private ISCommonUtil.ISFunction.ISDateTime mGetDate = new ISCommonUtil.ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public HRMF0344()
        {
            InitializeComponent();
        }

        public HRMF0344(Form pMainForm, ISAppInterface pAppInterface)
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
                    if (idaDAY_INTERFACE.IsFocused)
                    {
                        idaDAY_INTERFACE.Cancel();
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

        private void HRMF0344_Shown(object sender, EventArgs e)
        {
            ISCommonUtil.ISFunction.ISDateTime vGetDate = new ISCommonUtil.ISFunction.ISDateTime();
            System.DateTime vDate =vGetDate.ISGetDate();

            WORK_DATE_FR_0.EditValue = vGetDate.ISMonth_1st(vDate);
            WORK_DATE_TO_0.EditValue = DateTime.Today;
            
            DATE_COLLECT.EditValue = DateTime.Today;
        }

        #endregion

        #region ----- Lookup Event -----

        private void ilaFLOOR_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildFLOOR_0.SetLookupParamValue("W_GROUP_CODE", "FLOOR");
            ildFLOOR_0.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        #endregion

        #region ----- Click Event -----

        //ÃâÅðÁý°è
        private void ibtnSET_DAY_INTERFACE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            string vMessage;

            idcSET_DAY_INTERFACE.ExecuteNonQuery();
            vMessage = idcSET_DAY_INTERFACE.GetCommandParamValue("O_MESSAGE").ToString();
            MessageBoxAdv.Show(vMessage, "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
        }

        #endregion

        #region ----- User Method -----

        private void DefaultCorporation()
        {
            // LOOKUP DEFAULT VALUE SETTING - CORP
            idcDEFAULT_CORP.SetCommandParamValue("W_DUTY_CONTROL_YN", "Y");
            idcDEFAULT_CORP.SetCommandParamValue("W_ENABLED_FLAG_YN", "N");
            idcDEFAULT_CORP.ExecuteNonQuery();
            CORP_ID_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_ID");
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

            idaDAY_INTERFACE.Fill();
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