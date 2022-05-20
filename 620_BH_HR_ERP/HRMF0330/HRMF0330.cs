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

namespace HRMF0330
{
    public partial class HRMF0330 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iConv = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public HRMF0330()
        {
            InitializeComponent();
        }

        public HRMF0330(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void DefaultCorporation()
        {
            // Lookup SETTING
            ILD_CORP.SetLookupParamValue("W_DUTY_CONTROL_YN", "Y");
            ILD_CORP.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");

            // LOOKUP DEFAULT VALUE SETTING - CORP
            IDC_DEFAULT_CORP.SetCommandParamValue("W_DUTY_CONTROL_YN", "Y");
            IDC_DEFAULT_CORP.SetCommandParamValue("W_ENABLED_FLAG_YN", "N");
            IDC_DEFAULT_CORP.ExecuteNonQuery();
            W_CORP_NAME.EditValue = IDC_DEFAULT_CORP.GetCommandParamValue("O_CORP_NAME");
            W_CORP_ID.EditValue = IDC_DEFAULT_CORP.GetCommandParamValue("O_CORP_ID");
        }

        private void Search_DB()
        {
            if (W_CORP_ID.EditValue == null)
            {// ��ü.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                W_CORP_NAME.Focus();
                return;
            }
            if (W_DUTY_YYYYMM.EditValue == null)
            {// �ٹ�����
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                W_DUTY_YYYYMM.Focus();
                return;
            }

            IDA_DAILY.Fill();
            IDA_MONTHLY.Fill();

            W_WORK_DATE.EditValue = null;
        }

        private void Search_DB_Detail()
        {
            TB_MAIN.SelectedIndex = 1;
            TB_MAIN.SelectedTab.Focus();

            IDA_DAILY_NOT_DUTY_MANAGER.Fill();                  //���´���� �̵���۾���
            IDA_DAILY_NOT_WORK_CALENDAR.Fill();                 //�ٹ���ȹ �̵����
            IDA_NOT_DAY_INTERFACE.Fill();                       //����� ���� ������
            IDA_DAY_INTERFACE_NOT_TRANS.Fill();                 //����� ��ø ������
            IDA_MISMATCH_DI_DL.Fill();                          //�����VS�ϱ��� ����
            IDA_DAY_LEAVE_NOT_CLOSED.Fill();                    //�ϱ��� ���� ������
            IDA_DAY_LEAVE_NOT_OT.Fill();                        //�ϱ��� �ܾ� ������
            IDA_MONTHLY_NOT_CLOSED.Fill();                      //������ ���� ������
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
                    
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                   
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (IDA_DAILY.IsFocused)
                    {
                        IDA_DAILY.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (IDA_DAILY.IsFocused)
                    {
                        IDA_DAILY.Delete();
                    }
                }
            }
        }

        #endregion;

        #region ----- Form Event -----
        
        private void HRMF0330_Load(object sender, EventArgs e)
        {
            // Year Month Setting
            ILD_YYYYMM.SetLookupParamValue("W_START_YYYYMM", "2010-01");
            W_DUTY_YYYYMM.EditValue = iDate.ISYearMonth(DateTime.Today);
            // CORP SETTING
            DefaultCorporation();

            IDA_DAILY.FillSchema();
            IDA_MONTHLY.FillSchema();

        }

        private void IGR_DAILY_CellDoubleClick(object pSender)
        {
            if (IGR_DAILY.RowIndex < 0)
            {
                return;
            }
            W_WORK_DATE.EditValue = IGR_DAILY.GetCellValue("WORK_DATE");
            Search_DB_Detail();
        }

        #endregion

    }
}