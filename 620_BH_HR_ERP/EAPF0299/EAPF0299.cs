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

namespace EAPF0299
{
    public partial class EAPF0299 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iConvert = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        public object Get_Zip_Code
        {
            get
            {
                return IGR_ADDRESS.GetCellValue("ZIP_CODE");
            }
        }

        public object Get_Address
        {
            get
            {
                return IGR_ADDRESS.GetCellValue("ADDRESS");
            }
        }

        #endregion;

        #region ----- Constructor -----

        public EAPF0299()
        {
            InitializeComponent();
        }

        public EAPF0299(Form pMainForm, ISAppInterface pAppInterface, object pZIP_CODE, object pADDRESS)
        {
            InitializeComponent();
            //this.MdiParent = pMainForm; //항상 최상위 폼 유지 위해.
            isAppInterfaceAdv1.AppInterface = pAppInterface;

            ADDRESS.EditValue = pADDRESS;
        }

        #endregion;

        #region ----- Private Methods ----

        private void SEARCH_DB()
        {
            if (iConvert.ISNull(ADDRESS.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10297"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                ADDRESS.Focus();
                return;
            }

            IDA_ADDRESS.SetSelectParamValue("W_ENABLED_FLAG", "Y");
            IDA_ADDRESS.Fill();
            if (IDA_ADDRESS.OraSelectData.Rows.Count < 1)
            {
                ADDRESS.Focus();
            }
            else
            {
                IGR_ADDRESS.Focus();
            }
        }

        private void ADDRESS_CHOOSE()
        {
            if (IGR_ADDRESS.RowIndex < 0)
            {
                this.DialogResult = DialogResult.Cancel;
                return;
            }

            this.DialogResult = DialogResult.OK;
            this.Close();
        }

        #endregion;

        #region ----- Events -----

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    
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
                    if (IDA_ADDRESS.IsFocused)
                    {
                        IDA_ADDRESS.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (IDA_ADDRESS.IsFocused)
                    {
                        IDA_ADDRESS.Delete();
                    }
                }
            }
        }

        #endregion;

        #region ----- Form event -----

        private void EAPF0299_Load(object sender, EventArgs e)
        {

        }

        private void EAPF0299_Shown(object sender, EventArgs e)
        {
            RB_LAND.CheckedState = ISUtil.Enum.CheckedState.Checked;
            ADDRESS_TYPE.EditValue = RB_LAND.RadioCheckedString;

            ADDRESS.Focus();

            Application.UseWaitCursor = false;
            this.Cursor = Cursors.Default;
            Application.DoEvents();
        }

        private void RB_LAND_CheckChanged(object sender, EventArgs e)
        {
            ISRadioButtonAdv RB = sender as ISRadioButtonAdv;

            ADDRESS_TYPE.EditValue = RB.RadioCheckedString;
            ADDRESS.Focus();
        }

        private void ADDRESS_KeyDown(object pSender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                SEARCH_DB();
            }
            else if(e.KeyCode == Keys.Escape)
            {
                this.DialogResult = DialogResult.Cancel;
                this.Close();
            }
        }

        private void BTN_FIND_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            SEARCH_DB();
        }

        private void BTN_OK_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            ADDRESS_CHOOSE();
        }

        private void BTN_CLOSED_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            this.DialogResult = DialogResult.Cancel;
            this.Close();
        }

        private void IGR_ADDRESS_CellDoubleClick(object pSender)
        {
            ADDRESS_CHOOSE();
        }

        private void IGR_ADDRESS_CellKeyDown(object pSender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                ADDRESS_CHOOSE();
            }
            else if (e.KeyCode == Keys.Escape)
            {
                this.DialogResult = DialogResult.Cancel;
                this.Close();
            }
        }

        #endregion

    }
}