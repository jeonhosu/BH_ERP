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

namespace HRMF0106
{   
    public partial class HRMF0106 : Office2007Form
    {
        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();
                
        public HRMF0106(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();

            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #region ----- Property / Method ----
        private void DefaultSetFormReSize()
        {//[Child Form, Mdi Form에 맞게 ReSize]
            int vMinusWidth = 4;
            int vMinusHeight = 54;
            System.Drawing.Size vSize = this.MdiParent.ClientSize;
            this.Width = vSize.Width - vMinusWidth;
            this.Height = vSize.Height - vMinusHeight;
        }

        private void SEARCH_DB()
        {
            if (iString.ISNull(STD_DATE_0.EditValue) == string.Empty)
            {// 기준일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10015"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                STD_DATE_0.Focus();
                return;
            }
            isDataAdapter1.Fill();
            igrTAX_STANDARD.Focus();
        }

        private void Init_Insert()
        {
            igrTAX_STANDARD.SetCellValue("START_DATE", STD_DATE_0.EditValue);
        }
        #endregion

        #region ----- isAppInterfaceAdv1_AppMainButtonClick -----
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
                    if (isDataAdapter1.IsFocused)
                    {
                        isDataAdapter1.AddOver();
                    }
                    Init_Insert();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (isDataAdapter1.IsFocused)
                    {
                        isDataAdapter1.AddUnder();
                    }
                    Init_Insert();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (isDataAdapter1.IsFocused)
                    {
                        isDataAdapter1.Update();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (isDataAdapter1.IsFocused)
                    {
                        isDataAdapter1.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (isDataAdapter1.IsFocused)
                    {
                        isDataAdapter1.Delete();
                    }
                }
            }
        }
        #endregion

        #region ----- Form Event -----
        private void HRMF0106_Load(object sender, EventArgs e)
        {
            // FillSchema
            isDataAdapter1.FillSchema();
            STD_DATE_0.EditValue = DateTime.Today;

            //DefaultSetFormReSize();		//[Child Form, Mdi Form에 맞게 ReSize]
        }

        #endregion

        #region ----- Data Adapter Event ----
        private void isDataAdapter1_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (e.Row["START_DATE"] == DBNull.Value)
            {// START_DATE.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["BEGIN_AMOUNT"] == DBNull.Value)
            {// BEGIN_AMOUNT
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10024"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["END_AMOUNT"] == DBNull.Value)
            {// END_AMOUNT
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10025"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (Convert.ToInt32(e.Row["BEGIN_AMOUNT"]) > Convert.ToInt32(e.Row["END_AMOUNT"]))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10073"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["SUPP_NUM1"] == DBNull.Value)
            {// SUPP_NUM1
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10074", "&&VALUE:=Support1(부양1)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["SUPP_NUM2"] == DBNull.Value)
            {// SUPP_NUM1
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10074", "&&VALUE:=Support2(부양2)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["SUPP_NUM3"] == DBNull.Value)
            {// SUPP_NUM1
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10074", "&&VALUE:=Support3(부양3)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["SUPP_NUM4"] == DBNull.Value)
            {// SUPP_NUM1
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10074", "&&VALUE:=Support4(부양4)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["SUPP_NUM5"] == DBNull.Value)
            {// SUPP_NUM1
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10074", "&&VALUE:=Support5(부양5)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["SUPP_NUM6"] == DBNull.Value)
            {// SUPP_NUM1
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10074", "&&VALUE:=Support6(부양6)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["SUPP_NUM7"] == DBNull.Value)
            {// SUPP_NUM1
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10074", "&&VALUE:=Support7(부양7)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["SUPP_NUM8"] == DBNull.Value)
            {// SUPP_NUM1
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10074", "&&VALUE:=Support8(부양8)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["SUPP_NUM9"] == DBNull.Value)
            {// SUPP_NUM1
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10074", "&&VALUE:=Support9(부양9)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["SUPP_NUM10"] == DBNull.Value)
            {// SUPP_NUM1
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10074", "&&VALUE:=Support10(부양10)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["SUPP_NUM11"] == DBNull.Value)
            {// SUPP_NUM1
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10074", "&&VALUE:=Support11(부양11)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }
        #endregion

        #region ----- Lookup Event -----
        
        #endregion
    }
}