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

namespace FCMF0902
{
    public partial class FCMF0902 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public FCMF0902()
        {
            InitializeComponent();
        }

        public FCMF0902(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void SetSlipAggregate()
        {
            object mMessage;
            if (iString.ISNull(STD_DATE.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10015"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                STD_DATE.Focus();
                return;
            }
            idcSLIP_AGGREGATE.ExecuteNonQuery();
            mMessage = idcSLIP_AGGREGATE.GetCommandParamValue("O_MESSAGE");
            MessageBoxAdv.Show(mMessage.ToString(), "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
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
                   
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    
                }
            }
        }

        #endregion;

        #region ----- Form Event -----
        
        private void FCMF0902_Load(object sender, EventArgs e)
        {

        }

        private void FCMF0902_Shown(object sender, EventArgs e)
        {
            STD_DATE.EditValue = DateTime.Today;
        }

        private void ibtSLIP_SUM_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            SetSlipAggregate();
        }

        #endregion

    }
}