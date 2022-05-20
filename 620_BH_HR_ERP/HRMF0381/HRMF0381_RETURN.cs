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

namespace HRMF0381
{
    public partial class HRMF0381_RETURN : Office2007Form
    {
        #region ----- Variables -----

        private ISCommonUtil.ISFunction.ISConvert iString = new ISCommonUtil.ISFunction.ISConvert();
        private ISCommonUtil.ISFunction.ISDateTime iDate = new ISCommonUtil.ISFunction.ISDateTime();

        object mWORK_CORP_ID = null;
        object mWORK_DATE = null;
        object mAPPROVE_STATUS = null;
        object mWORK_TYPE_ID = null;
        object mFLOOR_ID = null;
        object mPERSON_ID = null;

        #endregion;

        #region ----- Constructor -----

        public HRMF0381_RETURN(ISAppInterface pAppInterface, object pCORP_ID, object pWORK_DATE
                              , object pAPPROVE_STATUS, object pWORK_TYPE_ID, object pFLOOR_ID, object pPERSON_ID)
        {
            InitializeComponent();
            isAppInterfaceAdv1.AppInterface = pAppInterface;

            mWORK_CORP_ID = pCORP_ID;
            mWORK_DATE = pWORK_DATE;
            mAPPROVE_STATUS = pAPPROVE_STATUS;
            mWORK_TYPE_ID = pWORK_TYPE_ID;
            mFLOOR_ID = pFLOOR_ID;
            mPERSON_ID = pPERSON_ID;
        }

        #endregion;

        #region ----- Search Method ----

        private void SEARCH_DB()
        {
            if (iString.ISNull(mWORK_CORP_ID) == string.Empty)
            {// 업체.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            if (iString.ISNull(mWORK_DATE) == string.Empty)
            {// 시작일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            idaDAY_INTERFACE_RETURN.SetSelectParamValue("W_WORK_CORP_ID", mWORK_CORP_ID);
            idaDAY_INTERFACE_RETURN.SetSelectParamValue("W_WORK_DATE", mWORK_DATE);
            idaDAY_INTERFACE_RETURN.SetSelectParamValue("W_APPROVE_STATUS", mAPPROVE_STATUS);
            idaDAY_INTERFACE_RETURN.SetSelectParamValue("W_WORK_TYPE_ID", mWORK_TYPE_ID);
            idaDAY_INTERFACE_RETURN.SetSelectParamValue("W_FLOOR_ID", mFLOOR_ID);
            idaDAY_INTERFACE_RETURN.SetSelectParamValue("W_PERSON_ID", mPERSON_ID);
            idaDAY_INTERFACE_RETURN.Fill();
            this.Cursor = System.Windows.Forms.Cursors.Default;
            Application.UseWaitCursor = false;
        }

        #endregion;

        #region ----- MDi ToolBar Button Event -----

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

        private void HRMF0381_RETURN_Load(object sender, EventArgs e)
        {
            idaDAY_INTERFACE_RETURN.FillSchema();
        }
        
        private void HRMF0381_RETURN_Shown(object sender, EventArgs e)
        {
            SEARCH_DB();
        }

        #endregion

        #region ----- Grid Event -----

        private void igrDUTY_PERIOD_CellDoubleClick(object pSender)
        {
            if (igrDAY_INTERFACE_RETURN.RowIndex < 0 && igrDAY_INTERFACE_RETURN.ColIndex == igrDAY_INTERFACE_RETURN.GetColumnToIndex("SELECT_YN"))
            {
                for (int r = 0; r < igrDAY_INTERFACE_RETURN.RowCount; r++)
                {
                    if (iString.ISNull(igrDAY_INTERFACE_RETURN.GetCellValue(r, igrDAY_INTERFACE_RETURN.GetColumnToIndex("SELECT_YN")), "N") == "Y".ToString())
                    {
                        igrDAY_INTERFACE_RETURN.SetCellValue(r, igrDAY_INTERFACE_RETURN.GetColumnToIndex("SELECT_YN"), "N");
                    }
                    else
                    {
                        igrDAY_INTERFACE_RETURN.SetCellValue(r, igrDAY_INTERFACE_RETURN.GetColumnToIndex("SELECT_YN"), "Y");
                    }
                }
            }
        }

        #endregion

        #region ----- Lookup Event -----

        private void ibtnSEARCH_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            SEARCH_DB();
        }

        private void ibtnSAVE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            idaDAY_INTERFACE_RETURN.SetUpdateParamValue("P_APPROVE_STATUS", mAPPROVE_STATUS);
            idaDAY_INTERFACE_RETURN.Update();

            this.Close();
        }

        private void ibtCANCEL_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            idaDAY_INTERFACE_RETURN.Cancel();
        }

        private void ibtnCLOSE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            this.Close();
        }

        #endregion

        #region ------ Adapter Event ------

        private void idaPERIOD_RETURN_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["SELECT_YN"]) == "Y" && iString.ISNull(e.Row["REJECT_REMARK"]) == string.Empty)
            {
                //&&FIELD_NAME은(는) 필수 입력 항목입니다.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", "&&FIELD_NAME:=Reject Remark(반려사유)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["SELECT_YN"]) == "N" && iString.ISNull(e.Row["REJECT_REMARK"]) != string.Empty)
            {
                //선택후 반려사유를 입력 하세요.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10276"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaPERIOD_RETURN_UpdateCompleted(object pSender)
        {
            // EMAIL 발송.
            idcEMAIL_SEND.SetCommandParamValue("P_GUBUN", "RETURN");
            idcEMAIL_SEND.SetCommandParamValue("P_SOURCE_TYPE", "DUTY");
            idcEMAIL_SEND.SetCommandParamValue("P_CORP_ID", mWORK_CORP_ID);
            idcEMAIL_SEND.SetCommandParamValue("P_WORK_DATE", DateTime.Today);
            idcEMAIL_SEND.SetCommandParamValue("P_REQ_DATE", DateTime.Today);
            idcEMAIL_SEND.ExecuteNonQuery();
        }

        #endregion
    }
}