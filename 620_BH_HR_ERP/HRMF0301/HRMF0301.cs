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

namespace HRMF0301
{
    public partial class HRMF0301 : Office2007Form
    {
        ISFunction.ISDateTime isDateTime;

        #region ----- Variables -----



        #endregion;

        #region ----- Constructor -----
        public HRMF0301(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;

            isDateTime = new ISFunction.ISDateTime();
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

        private void isSEARCH_DB()
        {// 데이터 조회
            if (string.IsNullOrEmpty(iedDUTY_YYYY_0.EditValue.ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10022"), "Warning", MessageBoxButtons.OK,MessageBoxIcon.Warning);
                iedDUTY_YYYY_0.Focus();
                return;
            }
            isDataAdapter1.SetSelectParamValue("W_SOB_ID", isAppInterfaceAdv1.SOB_ID);
            isDataAdapter1.SetSelectParamValue("W_ORG_ID", isAppInterfaceAdv1.ORG_ID);
            isDataAdapter1.Fill();

            igrHOLIDAY.Focus();
        }

        private bool isData_Add()
        {// 데이터 추가전 검증.
            if (string.IsNullOrEmpty(iedDUTY_YYYY_0.EditValue.ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10022"), "Warning", MessageBoxButtons.OK,MessageBoxIcon.Warning);
                return false;
            }
            return true;
        }
        #endregion;

        #region ----- isAppInterfaceAdv1_AppMainButtonClick -----
        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    isSEARCH_DB();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    if (isData_Add() == false)
                    {
                        return;
                    }
                    isDataAdapter1.AddOver();
                    igrHOLIDAY.SetCellValue("WORK_YYYY", iedDUTY_YYYY_0.EditValue);

                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (isData_Add() == false)
                    {
                        return;
                    }
                    isDataAdapter1.AddUnder();
                    igrHOLIDAY.SetCellValue("WORK_YYYY", iedDUTY_YYYY_0.EditValue);
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    isDataAdapter1.Update();    
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    isDataAdapter1.Cancel();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    isDataAdapter1.Delete();
                }
            }
        }

        #endregion;

        #region ----- Form Event -----
        private void HRMF0301_Load(object sender, EventArgs e)
        {
            isDataAdapter1.FillSchema();
        }
        #endregion

        #region ----- Adapter Event -----
        private void isDataAdapter1_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {// 저장전 검증
            if (string.IsNullOrEmpty(e.Row["WORK_YYYY"].ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10022"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
            }
            if (string.IsNullOrEmpty(e.Row["WORK_DATE"].ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=휴일일자"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
            }
            if (string.IsNullOrEmpty(e.Row["HOLIDAY_NAME"].ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=휴일명"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
            }
        }

        private void isDataAdapter1_PreDelete(ISPreDeleteEventArgs e)
        {// 삭제 검증.
            if (e.Row["WORK_DATE"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:=해당 자료"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
            }
        }
        #endregion

        #region ------ Lookup Event -----
        private void ilaYEAR_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildYEAR.SetLookupParamValue("W_START_YEAR", isDateTime.ISYear(isDateTime.ISGetDate(), -10));
            ildYEAR.SetLookupParamValue("W_END_YEAR", isDateTime.ISYear(isDateTime.ISGetDate(), 1));
        }

        private void ilaYEAR_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildYEAR.SetLookupParamValue("W_START_YEAR", iedDUTY_YYYY_0.EditValue.ToString());
            ildYEAR.SetLookupParamValue("W_END_YEAR", iedDUTY_YYYY_0.EditValue.ToString());
        }
        #endregion        
    }
}