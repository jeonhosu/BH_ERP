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

namespace HRMF0801
{
    public partial class HRMF0801 : Office2007Form
    {
        #region ----- Variables -----



        #endregion;
        
        #region ----- Constructor -----

        public HRMF0801(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----
        private void DefaultSetFormReSize()
        {//[Child Form, Mdi Form에 맞게 ReSize]
            int vMinusWidth = 4;
            int vMinusHeight = 54;
            System.Drawing.Size vSize = this.MdiParent.ClientSize;
            this.Width = vSize.Width - vMinusWidth;
            this.Height = vSize.Height - vMinusHeight;
        }

        private void isSearch_DB()
        {
            if (START_DATE_0.EditValue == null)
            {// 시작일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                START_DATE_0.Focus();
                return;
            }
            if (END_DATE_0.EditValue == null)
            {// 종료일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                END_DATE_0.Focus();
                return;
            }
            if (Convert.ToDateTime(START_DATE_0.EditValue) > Convert.ToDateTime( END_DATE_0.EditValue))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10012"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                START_DATE_0.Focus();
                return;
            }

            idaFOOD_SUMMARY.SetSelectParamValue("W_SEARCH_TYPE", "R");
            idaFOOD_SUMMARY.Fill();
        }


        private bool isAdd_DB_Check()
        {// 데이터 추가시 검증.
            if (DEVICE_ID_0.EditValue == null)
            {// 업체.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                DEVICE_NAME_0.Focus();
                return false;
            }
            return true;
        }

        #endregion;

        #region ----- isAppInterfaceAdv1_AppMainButtonClick Events -----
        
        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    isSearch_DB();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    if(idaFOOD_SUMMARY.IsFocused)
                    {
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaFOOD_SUMMARY.IsFocused)
                    {
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (idaFOOD_SUMMARY.IsFocused)
                    {                
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaFOOD_SUMMARY.IsFocused)
                    {
                        idaFOOD_SUMMARY.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaFOOD_SUMMARY.IsFocused)
                    {
                        idaFOOD_SUMMARY.Delete();
                    }
                }
            }
        }
        #endregion;

        #region ----- Form Event -----
        private void HRMF0801_Load(object sender, EventArgs e)
        {
            ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

            idaFOOD_SUMMARY.FillSchema();
            START_DATE_0.EditValue = iDate.ISMonth_1st(DateTime.Today);
            END_DATE_0.EditValue = DateTime.Today;
            
            //DefaultSetFormReSize();		//[Child Form, Mdi Form에 맞게 ReSize]           
        }

        private void ibtSET_FOOD_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            string iReturn_Message;
            idcSET_FOOD.ExecuteNonQuery();
            iReturn_Message = idcSET_FOOD.GetCommandParamValue("O_MESSAGE").ToString();
            MessageBoxAdv.Show(iReturn_Message, "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
        }

        #endregion  

        #region ----- Adapter Event -----
        
        #endregion

        #region ----- LookUp Event -----
        private void ilaDEVICE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCAFETERIA.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }
        #endregion

    }
}