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

namespace FCMF0231
{
    public partial class FCMF0231 : Office2007Form
    {
        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #region ----- Variables -----



        #endregion;

        #region ----- Constructor -----

        public FCMF0231()
        {
            InitializeComponent();
        }

        public FCMF0231(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----
        private void Search_DB()
        {
            if (itbMAPPING.SelectedIndex == 0)
            {
                idaDEPT_MAPPING.Fill();
                igrDEPT_MAPPING.Focus();
            }
            else if (itbMAPPING.SelectedIndex == 1)
            {
                idaCOSTCENTER_MAPPING.Fill();
                igrCONDITION_COSTCENTER.Focus();
            }
        }

        private void Insert_DEPT_MAPPING()
        {
            igrDEPT_MAPPING.SetCellValue("ENABLE_YN", "Y");
            igrDEPT_MAPPING.SetCellValue("EFFECTIVE_DATE_FR", iDate.ISMonth_1st(DateTime.Today));
            igrDEPT_MAPPING.CurrentCellMoveTo(igrDEPT_MAPPING.GetColumnToIndex("DEPT_CODE"));            
            igrDEPT_MAPPING.Focus();
        }

        private void Insert_Costcenter_MAPPING()
        {
            igrCOSTCENTER.SetCellValue("ENABLE_YN", "Y");
            igrCOSTCENTER.SetCellValue("EFFECTIVE_DATE_FR", iDate.ISMonth_1st(DateTime.Today));
            igrCOSTCENTER.CurrentCellMoveTo(igrDEPT_MAPPING.GetColumnToIndex("DEPT_CODE"));
            igrCOSTCENTER.Focus();
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
                    if (idaDEPT_MAPPING.IsFocused)
                    {
                        idaDEPT_MAPPING.AddOver();
                        Insert_DEPT_MAPPING();
                    }
                    else if (idaCOSTCENTER_MAPPING.IsFocused)
                    {
                        idaCOSTCENTER_MAPPING.AddOver();
                        Insert_Costcenter_MAPPING();
                    } 
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaDEPT_MAPPING.IsFocused)
                    {
                        idaDEPT_MAPPING.AddUnder();
                        Insert_DEPT_MAPPING();
                    }
                    else if (idaCOSTCENTER_MAPPING.IsFocused)
                    {
                        idaCOSTCENTER_MAPPING.AddUnder();
                        Insert_Costcenter_MAPPING();
                    } 
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (idaDEPT_MAPPING.IsFocused)
                    {
                        idaDEPT_MAPPING.Update();
                    }
                    else if (idaCOSTCENTER_MAPPING.IsFocused)
                    {
                        idaCOSTCENTER_MAPPING.Update();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaDEPT_MAPPING.IsFocused)
                    {
                        idaDEPT_MAPPING.Cancel();
                    }
                    else if (idaCOSTCENTER_MAPPING.IsFocused)
                    {
                        idaCOSTCENTER_MAPPING.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaDEPT_MAPPING.IsFocused)
                    {
                        idaDEPT_MAPPING.Delete();
                    }
                    else if (idaCOSTCENTER_MAPPING.IsFocused)
                    {
                        idaCOSTCENTER_MAPPING.Delete();
                    }
                }
            }
        }

        #endregion;

        #region ----- Form Event -----


        private void FCMF0231_Load(object sender, EventArgs e)
        {
            idaDEPT_MAPPING.FillSchema();
        }

        private void FCMF0231_Shown(object sender, EventArgs e)
        {
            STD_DATE_0.EditValue = DateTime.Today;
            C_STD_DATE_0.EditValue = DateTime.Today;
        }

        #endregion
        
        #region ----- Lookup Event -----

        private void ilaDEPT_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaDEPT_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaMAPPING_DEPT_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaC_COSTCENTER_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOSTCENTER.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        #endregion

        #region ----- Adapeter Event -----

        private void idaDEPT_MAPPING_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["DEPT_CODE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10019"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                igrDEPT_MAPPING.CurrentCellMoveTo(igrDEPT_MAPPING.GetColumnToIndex("DEPT_CODE"));
                return;
            }
            if (iString.ISNull(e.Row["MAPPING_DEPT_ALL"]) != "Y" && iString.ISNull(e.Row["MAPPING_DEPT_CODE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10019"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                igrDEPT_MAPPING.CurrentCellMoveTo(igrDEPT_MAPPING.GetColumnToIndex("MAPPING_DEPT_CODE"));
                return;
            }
            if (iString.ISNull(e.Row["EFFECTIVE_DATE_FR"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                igrDEPT_MAPPING.CurrentCellMoveTo(igrDEPT_MAPPING.GetColumnToIndex("EFFECTIVE_DATE_FR"));
                return;
            }
        }

        private void idaDEPT_MAPPING_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:= Data(해당 데이터)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaCOSTCENTER_MAPPING_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["DEPT_CODE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10019"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                igrDEPT_MAPPING.CurrentCellMoveTo(igrDEPT_MAPPING.GetColumnToIndex("DEPT_CODE"));
                return;
            }
            if (iString.ISNull(e.Row["MAPPING_COSTCENTER_ALL"]) != "Y" && iString.ISNull(e.Row["MAPPING_COSTCENTER_CODE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10018"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                igrDEPT_MAPPING.CurrentCellMoveTo(igrDEPT_MAPPING.GetColumnToIndex("MAPPING_COSTCENTER_CODE"));
                return;
            }
            if (iString.ISNull(e.Row["EFFECTIVE_DATE_FR"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                igrDEPT_MAPPING.CurrentCellMoveTo(igrDEPT_MAPPING.GetColumnToIndex("EFFECTIVE_DATE_FR"));
                return;
            }
        }

        private void idaCOSTCENTER_MAPPING_PreDelete(ISPreDeleteEventArgs e)
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