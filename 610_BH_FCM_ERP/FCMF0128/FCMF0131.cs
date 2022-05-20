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

namespace FCMF0131
{
    public partial class FCMF0131 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public FCMF0131()
        {
            InitializeComponent();
        }

        public FCMF0131(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void Search_DB()
        {
            idaCORPORATE.Fill();
            igrCORPORATE.Focus();
        }

        private void Insert_Header()
        {            
            CORPORATE_CODE.Focus();
        }

        private void SetCommonParameter(string pGroup_Code, string pEnabled_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        }

        private void isSetAddressParameter(object pAddress)
        {
            ildADDRESS.SetLookupParamValue("W_ADDRESS", pAddress);
        }

        #endregion;

        #region ----- Initialization -----

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
                    if (idaCORPORATE.IsFocused)
                    {
                        idaCORPORATE.AddOver();
                        Insert_Header();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaCORPORATE.IsFocused)
                    {
                        idaCORPORATE.AddUnder();
                        Insert_Header();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    idaCORPORATE.Update();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaCORPORATE.IsFocused)
                    {
                        idaCORPORATE.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaCORPORATE.IsFocused)
                    {
                        idaCORPORATE.Delete();
                    }
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void FCMF0131_Load(object sender, EventArgs e)
        {
            idaCORPORATE.FillSchema();
        }

        #endregion

        #region ----- Lookup Event -----

        private void ilaFORM_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("FORM_TYPE", "Y");
        }

        private void ilaADDRESS_RefreshLookupData(object pSender, ISRefreshLookupDataEventArgs e)
        {
            isSetAddressParameter(e.FilterString);
        }

        #endregion

        #region ----- Adapter Event -----

        private void idaFORM_HEADER_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            //if (iString.ISNull(e.Row["FORM_TYPE_ID"]) == string.Empty)
            //{
            //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10156"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    e.Cancel = true;
            //    return;
            //}
            //if (iString.ISNull(e.Row["FORM_ITEM_CODE"]) == string.Empty)
            //{
            //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10157"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    e.Cancel = true;
            //    return;
            //}
            //if (iString.ISNull(e.Row["FORM_ITEM_NAME"]) == string.Empty)
            //{
            //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10158"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    e.Cancel = true;
            //    return;
            //}
            //if (iString.ISNull(e.Row["SORT_SEQ"]) == string.Empty)
            //{
            //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10159"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    e.Cancel = true;
            //    return;
            //}
            //if (iString.ISNumtoZero(e.Row["ITEM_LEVEL"], 0) == Convert.ToInt32(0))
            //{
            //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10160"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    e.Cancel = true;
            //    return;
            //}
            //if (iString.ISNumtoZero(FORM_TYPE_LEVEL_1.EditValue, 0) < iString.ISNumtoZero(e.Row["ITEM_LEVEL"], 0))
            //{
            //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10133"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    ITEM_LEVEL.Focus();
            //}
            //if (iString.ISNull(e.Row["COLUMN_POSITION_NUM"]) == string.Empty)
            //{
            //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10162"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    e.Cancel = true;
            //    return;
            //}
            //if (iString.ISNull(e.Row["ACCOUNT_DR_CR"]) == string.Empty)
            //{
            //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10122"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    e.Cancel = true;
            //    return;
            //}            
            //if (iString.ISNull(e.Row["EFFECTIVE_DATE_FR"]) == string.Empty)
            //{
            //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    e.Cancel = true;
            //    return;
            //}
        }

        #endregion        

 
    }
}