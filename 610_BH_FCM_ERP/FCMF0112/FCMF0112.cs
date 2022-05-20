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

namespace FCMF0112
{
    public partial class FCMF0112 : Office2007Form
    {
        
        #region ----- Variables -----)
        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public FCMF0112()
        {
            InitializeComponent();
        }

        public FCMF0112(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----
        private void Search_DB()
        {
            idaAUTO_JOURNAL_H.Fill();
            igrAUTO_JOURNAL_H.Focus();
        }

        private void SetCommonParameter(string pGroup_Codee, string pEnabled_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Codee);
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        }

        private void Insert_Journal_Header()
        {
            igrAUTO_JOURNAL_H.SetCellValue("ENABLED_FLAG", "Y");
            igrAUTO_JOURNAL_H.SetCellValue("EFFECTIVE_DATE_FR", iDate.ISMonth_1st(DateTime.Today));
            igrAUTO_JOURNAL_H.CurrentCellActivate(1);
        }

        private void Insert_Journal_Line()
        {
            DISPLAY_YN.CheckBoxValue = "Y";
            ENABLED_FLAG.CheckBoxValue = "Y";
            EFFECTIVE_DATE_FR.EditValue = iDate.ISMonth_1st(DateTime.Today);
            ACCOUNT_CODE.Focus();
        }

        #endregion;

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
                    if (idaAUTO_JOURNAL_H.IsFocused)
                    {
                        idaAUTO_JOURNAL_H.AddOver();
                        Insert_Journal_Header();
                    }
                    else if (idaAUTO_JOURNAL_L.IsFocused)
                    {
                        idaAUTO_JOURNAL_L.AddOver();
                        Insert_Journal_Line();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaAUTO_JOURNAL_H.IsFocused)
                    {
                        idaAUTO_JOURNAL_H.AddUnder();
                        Insert_Journal_Header();
                    }
                    else if (idaAUTO_JOURNAL_L.IsFocused)
                    {
                        idaAUTO_JOURNAL_L.AddUnder();
                        Insert_Journal_Line();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {                    
                    idaAUTO_JOURNAL_H.Update();                    
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaAUTO_JOURNAL_H.IsFocused)
                    {
                        idaAUTO_JOURNAL_H.Cancel();
                    }
                    else if (idaAUTO_JOURNAL_L.IsFocused)
                    {
                        idaAUTO_JOURNAL_L.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaAUTO_JOURNAL_H.IsFocused)
                    {
                        idaAUTO_JOURNAL_H.Delete();
                    }
                    else if (idaAUTO_JOURNAL_L.IsFocused)
                    {
                        idaAUTO_JOURNAL_L.Delete();
                    }
                }
            }
        }

        #endregion;

        #region ---- Form Event -----
        private void FCMF0112_Load(object sender, EventArgs e)
        {
            idaAUTO_JOURNAL_H.FillSchema();

        }
        #endregion

        #region ----- Lookup Event -----

        private void ilaSLIP_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("SLIP_TYPE", "N");
        }

        private void ilaJOB_CATEGORY_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("JOB_CATEGORY", "N");
        }

        private void ilaSLIP_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("SLIP_TYPE", "Y");
        }

        private void ilaJOB_CATEGORY_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("JOB_CATEGORY", "Y");
        }

        private void ilaACCOUNT_DR_CR_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("ACCOUNT_DR_CR", "Y");
        }

        private void ilaACCOUNT_CONTROL_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildACCOUNT_CONTROL.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        #endregion

        #region ----- Adapter Event -----

        private void idaAUTO_JOURNAL_H_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["SLIP_TYPE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10116"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["JOB_CATEGORY_CODE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10154"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["JOB_CODE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10155"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["JOB_NAME"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10155"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
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

        private void idaAUTO_JOURNAL_H_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:= Data(해당 데이터)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaAUTO_JOURNAL_L_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["ACCOUNT_DR_CR"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10122"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["ACCOUNT_CONTROL_ID"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10123"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
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

        private void idaAUTO_JOURNAL_L_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:= Data(해당 데이터)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }
        #endregion
    }
}