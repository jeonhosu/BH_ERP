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

namespace FCMF0120
{
    public partial class FCMF0120 : Office2007Form
    {
        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        public FCMF0120(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();

            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #region ----- Property / Method -----
        private void DefaultSetFormReSize()
        {//[Child Form, Mdi Form에 맞게 ReSize]
            int vMinusWidth = 4;
            int vMinusHeight = 54;
            System.Drawing.Size vSize = this.MdiParent.ClientSize;
            this.Width = vSize.Width - vMinusWidth;
            this.Height = vSize.Height - vMinusHeight;
        }

        private void DefaultCorporation()
        {
        }
        private void Init_Fiscal_Period_Insert()
        {
            igrFISCAL_PERIOD.SetCellValue("PERIOD_STATUS", DV_PERIOD_STATUS.EditValue);
            igrFISCAL_PERIOD.SetCellValue("PERIOD_STATUS_NAME", DV_PERIOD_STATUS_NAME.EditValue);
        }

        private void SEARCH_DB()
        {
            idaFISCAL_CALENDAR.Fill();
            FISCAL_CALENDAR_ID.Focus();
        }

        #endregion

        #region ----- Application_MainButtonClick -----
        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    SEARCH_DB();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    if (idaFISCAL_CALENDAR.IsFocused)
                    {
                        idaFISCAL_CALENDAR.AddOver();
                    }
                    else if (idaFISCAL_YEAR.IsFocused)
                    {
                        idaFISCAL_YEAR.AddOver();
                    }
                    else if (idaFISCAL_PERIOD.IsFocused)
                    {
                        idaFISCAL_PERIOD.AddOver();
                        Init_Fiscal_Period_Insert();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaFISCAL_CALENDAR.IsFocused)
                    {
                        idaFISCAL_CALENDAR.AddUnder();
                    }
                    else if (idaFISCAL_YEAR.IsFocused)
                    {
                        idaFISCAL_YEAR.AddUnder();
                    }
                    else if (idaFISCAL_PERIOD.IsFocused)
                    {
                        idaFISCAL_PERIOD.AddUnder();
                        Init_Fiscal_Period_Insert();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    idaFISCAL_CALENDAR.Update();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaFISCAL_CALENDAR.IsFocused)
                    {
                        idaFISCAL_CALENDAR.Cancel();
                    }
                    else if (idaFISCAL_YEAR.IsFocused)
                    {
                        idaFISCAL_YEAR.Cancel();
                    }
                    else if (idaFISCAL_PERIOD.IsFocused)
                    {
                        idaFISCAL_PERIOD.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaFISCAL_CALENDAR.IsFocused)
                    {
                        idaFISCAL_CALENDAR.Delete();
                    }
                    else if (idaFISCAL_YEAR.IsFocused)
                    {
                        idaFISCAL_YEAR.Delete();
                    }
                    else if (idaFISCAL_PERIOD.IsFocused)
                    {
                        idaFISCAL_PERIOD.Delete();
                    }
                }
            }
        }
        #endregion

        #region ----- Form Event -----
        private void FCMF0120_Load(object sender, EventArgs e)
        {
            idaFISCAL_CALENDAR.FillSchema();
            idcDV_PERIOD_STATUS.ExecuteNonQuery();
        }

        private void btnPERIOD_CREATE_ButtonClick(object pSender, EventArgs pEventArgs)
        {

            int mRecordCount = 0;
            string mMessage;
            idcRECORD_COUNT.ExecuteNonQuery();
            mRecordCount = iString.ISNumtoZero(idcRECORD_COUNT.GetCommandParamValue("O_RETURN_VALUE"));
            if (mRecordCount > 0)
            {
                if (DialogResult.Yes != MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10082"), "Question", MessageBoxButtons.YesNo, MessageBoxIcon.Question))
                {
                    return;
                }
            }

            idcCREATE_PERIOD.ExecuteNonQuery();
            mMessage = iString.ISNull(idcCREATE_PERIOD.GetCommandParamValue("O_MESSAGE"));
            if (mMessage != string.Empty)
            {
                MessageBoxAdv.Show(mMessage, "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }

        }
        #endregion

        #region ----- Adapter Event -----

        private void idaFISCAL_CALENDAR_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (e.Row["FISCAL_CALENDAR_ID"] == DBNull.Value)
            {// 회계달력ID
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10084", "&&VALUE:=Fiscal Calendar ID(회계달력 ID)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["FISCAL_CALENDAR_NAME"]) == string.Empty)
            {// 회계달력명
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10084", "&&VALUE:=Fiscal Calendar Name(회계달력명)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaFISCAL_CALENDAR_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:=Data(해당 자료)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
                e.Cancel = true;
                return;
            }
        }

        private void idaFISCAL_YEAR_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {            
            if (e.Row["FISCAL_COUNT"] == DBNull.Value)
            {// 회계기수
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10079"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["FISCAL_YEAR"]) == string.Empty)
            {// 회계년도
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Fiscal Year(회계년도)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["START_DATE"] == DBNull.Value)
            {// 회계년도 시작일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Fiscal Start Date(회계년도 시작일자"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["END_DATE"] == DBNull.Value)
            {// 회계년도 종료일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Fiscal End Date(회계년도 종료일자"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (Convert.ToDateTime(e.Row["START_DATE"]) > Convert.ToDateTime(e.Row["END_DATE"]))
            {// 회계년도 기간설정
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10012"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaFISCAL_YEAR_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:=Data(해당 자료)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
                e.Cancel = true;
                return;
            }
        }

        private void idaFISCAL_PERIOD_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["PERIOD_NAME"]) == string.Empty)
            {// 회계기간명
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Period Name(기간명)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["PERIOD_STATUS"]) == string.Empty)
            {// 기간 상태
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Period Status(기간상태)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["START_DATE"] == DBNull.Value)
            {// 회계기간 시작일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Period Start Date(회계기간 시작일자)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["END_DATE"] == DBNull.Value)
            {// 회계기간 종료일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Period End Date(회계기간 종료일자)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (Convert.ToDateTime(e.Row["START_DATE"]) > Convert.ToDateTime(e.Row["END_DATE"]))
            {// 회계기간 기간설정
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10012"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["QUARTER_NUM"] == DBNull.Value)
            {// 분기
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Quarter Num(분기)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["HALF_NUM"] == DBNull.Value)
            {// 반기
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Half Num(반기)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaFISCAL_PERIOD_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:=Data(해당 자료)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
                e.Cancel = true;
                return;
            }
        }

        private void idaFISCAL_YEAR_ExcuteKeySearch(object pSender)
        {
            SEARCH_DB();
        }

        private void idaFISCAL_CALENDAR_ExcuteKeySearch(object pSender)
        {
            SEARCH_DB();
        }

        private void igrFISCAL_PERIOD_CurrentCellValidating(object pSender, ISGridAdvExValidatingEventArgs e)
        {
            if (e.ColIndex == igrFISCAL_PERIOD.GetColumnToIndex("PERIOD_NAME"))
            {// 회계기간 입력.

            }
        }
        #endregion


        #region ----- Lookup Event -----

        #endregion

    }
}