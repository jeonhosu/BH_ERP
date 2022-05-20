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

namespace FCMF0903
{
    public partial class FCMF0903 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public FCMF0903()
        {
            InitializeComponent();
        }

        public FCMF0903(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void SearchDB()
        {
            if (iString.ISNull(PERIOD_NAME_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10226"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                PERIOD_NAME_0.Focus();
                return;
            }
            idaMONTH_SETTLEMENT.Fill();
            igrMONTH_SETTLEMENT.Focus();
        }

        private void Set_Item_Property()
        {
            if (iString.ISNull(igrMONTH_SETTLEMENT.GetCellValue("FORM_ITEM_CLASS")) == "90".ToString())
            {
                int vCol = igrMONTH_SETTLEMENT.GetColumnToIndex("GL_AMOUNT");
                igrMONTH_SETTLEMENT.GridAdvExColElement[vCol].Insertable = 1;
                igrMONTH_SETTLEMENT.GridAdvExColElement[vCol].Updatable = 1;
            }
            else
            {
                int vCol = igrMONTH_SETTLEMENT.GetColumnToIndex("GL_AMOUNT");
                igrMONTH_SETTLEMENT.GridAdvExColElement[vCol].Insertable = 0;
                igrMONTH_SETTLEMENT.GridAdvExColElement[vCol].Updatable = 0;
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
                   
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {

                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (idaMONTH_SETTLEMENT.IsFocused)
                    {
                        idaMONTH_SETTLEMENT.Update();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaMONTH_SETTLEMENT.IsFocused)
                    {
                        idaMONTH_SETTLEMENT.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaMONTH_SETTLEMENT.IsFocused)
                    {
                        idaMONTH_SETTLEMENT.Delete();
                    }
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void FCMF0903_Load(object sender, EventArgs e)
        {
            idaMONTH_SETTLEMENT.FillSchema();
        }

        private void FCMF0903_Shown(object sender, EventArgs e)
        {
            PERIOD_NAME_0.EditValue = iDate.ISYearMonth(DateTime.Today);
        }

        private void ibtnMONTH_SETTLEMENT_CREATE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            object vMessage;
            if (iString.ISNull(PERIOD_NAME_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10226"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                PERIOD_NAME_0.Focus();
                return;
            }

            idcMONTH_SETTLEMENT_SET.ExecuteNonQuery();
            vMessage = idcMONTH_SETTLEMENT_SET.GetCommandParamValue("O_MESSAGE");
            if (iString.ISNull(vMessage) != string.Empty)
            {
                MessageBoxAdv.Show(vMessage.ToString(), "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }        
        }

        #endregion

        #region ----- Lookup Event -----

        private void ilaPERIOD_NAME_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildPERIOD_NAME.SetLookupParamValue("W_END_YYYYMM", iDate.ISYearMonth(DateTime.Today));
        }

        #endregion

        #region ----- Adapter Event -----

        private void idaMONTH_SETTLEMENT_NewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            Set_Item_Property();
        }

        private void idaMONTH_SETTLEMENT_UpdateCompleted(object pSender)
        {
            idcMONTH_SETTLEMENT_SET_ROLLUP.ExecuteNonQuery();
            SearchDB();
        }

        #endregion


    }
}