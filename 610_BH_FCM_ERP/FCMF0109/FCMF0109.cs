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

namespace FCMF0109
{
    public partial class FCMF0109 : Office2007Form
    {
        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        public FCMF0109(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();

            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #region ----- Property Method ------
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
            isDataAdapter1.Fill();
            igrHEADER.Focus();
        }

        private void Insert_Line()
        {
            igrLINE.SetCellValue("ENABLED_FLAG", "Y");
            igrLINE.SetCellValue("EFFECTIVE_DATE_FR", iDate.ISMonth_1st(DateTime.Today));
        }
        #endregion

        #region ----- isAppInterfaceAdv1_AppMainButtonClick Button Click -----
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
                    if (isDataAdapter1.IsFocused)
                    {
                        isDataAdapter1.AddOver();
                    }
                    else if (isDataAdapter2.IsFocused)
                    {
                        isDataAdapter2.AddOver();
                        Insert_Line();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (isDataAdapter1.IsFocused)
                    {
                        isDataAdapter1.AddUnder();
                    }
                    else if (isDataAdapter2.IsFocused)
                    {
                        isDataAdapter2.AddUnder();
                        Insert_Line();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                { 
                        isDataAdapter1.Update();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (isDataAdapter1.IsFocused)
                    {
                        isDataAdapter1.Cancel();
                    }
                    else if (isDataAdapter2.IsFocused)
                    {
                        isDataAdapter2.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (isDataAdapter1.IsFocused)
                    {
                        isDataAdapter1.Delete();
                    }
                    else if (isDataAdapter2.IsFocused)
                    {
                        isDataAdapter2.Delete();
                    }
                }
            }
        }
        #endregion
        
        #region ----- Form Event -----
        private void FCMF0109_Load(object sender, EventArgs e)
        {
            isDataAdapter1.FillSchema();
        }
        #endregion

        #region ----- Adapter Event -----
        private void isDataAdapter1_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["CODE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10013"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);  //코드 입력
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["CODE_NAME"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10014"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);  // 코드명 입력
                e.Cancel = true;
                return;
            }
        }

        private void isDataAdapter2_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["CODE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10013"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);  // 코드명 입력
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["CODE_NAME"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10013"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);  // 코드명 입력
                e.Cancel = true;
                return;
            }
            if (e.Row["EFFECTIVE_DATE_FR"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);  // 시작일자 입력
                e.Cancel = true;
                return;
            }
            if (e.Row["EFFECTIVE_DATE_TO"] != DBNull.Value)
            {
                if (Convert.ToDateTime(e.Row["EFFECTIVE_DATE_FR"]) > Convert.ToDateTime(e.Row["EFFECTIVE_DATE_TO"]))
                {// 시작일자 ~ 종료일자
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10012"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);  // 기간 검증 오류
                    e.Cancel = true;
                    return;
                }
            }
        }

        private void isDataAdapter1_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:=Data(데이터)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
                e.Cancel = true;
                return;
            }
        }

        private void isDataAdapter2_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:=Data(데이터)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
                e.Cancel = true;
                return;
            }
        }
        #endregion

    }
}