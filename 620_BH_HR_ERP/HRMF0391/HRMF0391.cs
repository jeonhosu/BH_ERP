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

namespace HRMF0391
{
    public partial class HRMF0391 : Office2007Form
    {
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();
        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        String MDB_PATH = null;
        String MDB_NAME = null;        

        #region ----- Variables -----



        #endregion;

        #region ----- Constructor -----

        public HRMF0391()
        {
            InitializeComponent();
        }

        public HRMF0391(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- MDB 연결 / MDB 값 --> Oracle 저장 -----

        private void Connect_Secom_MDB(string pWork_Date)
        {
            ipbSECOM_INTERFACE.BarFillPercent = 0;

            System.Data.DataTable mDataTable = null;
            System.Data.OleDb.OleDbDataAdapter vOleDataAdapter = null;
            System.Data.OleDb.OleDbCommand vOleCommand = null;
            System.Data.OleDb.OleDbConnection vOleConnection = new System.Data.OleDb.OleDbConnection();

            string Secom_MDB = MDB_NAME.Replace("YYYYMMDD", pWork_Date);
            Secom_MDB = string.Format("{0}{1}", MDB_PATH, Secom_MDB);
            string vConnectString = string.Format("Provider = Microsoft.Jet.OLEDB.4.0; Data Source = {0};", Secom_MDB);

            vOleConnection.ConnectionString = vConnectString;           
            try
            {
                vOleConnection.Open();

                System.Text.StringBuilder vQueryString = new System.Text.StringBuilder();

                vQueryString.Append("  SELECT [ALARM.ATIME] AS ATIME ");
                vQueryString.Append("       , [ALARM.ID] AS ID_SEQ ");
                vQueryString.Append("       , [ALARM.EQCODE] AS EQCODE_A ");
                vQueryString.Append("       , [ALARM.MASTER] AS MASTER_A ");
                vQueryString.Append("       , [ALARM.LOCAL] AS LOCAL_A ");
                vQueryString.Append("       , [ALARM.POINT] AS POINT_A ");
                vQueryString.Append("       , [ALARM.LOOP] AS LOOP_A ");
                vQueryString.Append("       , [ALARM.EQNAME] AS EQNAME ");
                vQueryString.Append("       , [ALARM.STATE] AS STATE ");
                vQueryString.Append("       , [ALARM.PARAM] AS PARAM_A ");
                vQueryString.Append("       , [ALARM.USER] AS USER_A ");
                vQueryString.Append("       , [ALARM.CONTENT] AS CONTENT_A ");
                vQueryString.Append("       , [ALARM.ACK] AS ACK ");
                vQueryString.Append("       , [ALARM.ACKUSER] AS ACKUSER ");
                vQueryString.Append("       , [ALARM.ACKCONTENT] AS ACKCONTENT ");
                vQueryString.Append("       , [ALARM.ACKTIME] AS ACKTIME ");
                vQueryString.Append("       , [ALARM.TRANSFER] AS TRANSFER");
                vQueryString.Append("       , [ALARM.MODE] AS MODE_A ");
                vQueryString.Append("    FROM ALARM ");
                vQueryString.Append("   WHERE LEFT(ALARM.ATIME, 8) =  '").Append(pWork_Date).Append("' ");
                vQueryString.Append("  ORDER BY ALARM.ATIME; ");
                
                vOleCommand = new System.Data.OleDb.OleDbCommand();
                vOleCommand.CommandType = System.Data.CommandType.Text;
                vOleCommand.CommandText = vQueryString.ToString();

                vOleCommand.Connection = vOleConnection;

                vOleDataAdapter = new System.Data.OleDb.OleDbDataAdapter();
                vOleDataAdapter.SelectCommand = vOleCommand;

                mDataTable = new System.Data.DataTable();

                vOleDataAdapter.Fill(mDataTable);

                // insert.
                int vRowCount = 0;
                DateTime vSysDate = DateTime.Now;
                foreach (System.Data.DataRow vRow in mDataTable.Rows)
                {
                    vRowCount = vRowCount + 1;
                    idcSECOM_HISTORY_INSERT.SetCommandParamValue("P_ATIME", vRow["ATIME"]);
                    idcSECOM_HISTORY_INSERT.SetCommandParamValue("P_ID_SEQ", vRow["ID_SEQ"]);
                    idcSECOM_HISTORY_INSERT.SetCommandParamValue("P_EQCODE_A", vRow["EQCODE_A"]);
                    idcSECOM_HISTORY_INSERT.SetCommandParamValue("P_MASTER_A", vRow["MASTER_A"]);
                    idcSECOM_HISTORY_INSERT.SetCommandParamValue("P_LOCAL_A", vRow["LOCAL_A"]);
                    idcSECOM_HISTORY_INSERT.SetCommandParamValue("P_POINT_A", vRow["POINT_A"]);
                    idcSECOM_HISTORY_INSERT.SetCommandParamValue("P_LOOP_A", vRow["LOOP_A"]);
                    idcSECOM_HISTORY_INSERT.SetCommandParamValue("P_EQNAME", vRow["EQNAME"]);
                    idcSECOM_HISTORY_INSERT.SetCommandParamValue("P_STATE", vRow["STATE"]);
                    idcSECOM_HISTORY_INSERT.SetCommandParamValue("P_PARAM_A", vRow["PARAM_A"]);
                    idcSECOM_HISTORY_INSERT.SetCommandParamValue("P_USER_A", vRow["USER_A"]);
                    idcSECOM_HISTORY_INSERT.SetCommandParamValue("P_CONTENT_A", vRow["CONTENT_A"]);
                    idcSECOM_HISTORY_INSERT.SetCommandParamValue("P_ACK", vRow["ACK"]);
                    idcSECOM_HISTORY_INSERT.SetCommandParamValue("P_ACKUSER", vRow["ACKUSER"]);
                    idcSECOM_HISTORY_INSERT.SetCommandParamValue("P_ACKCONTENT", vRow["ACKCONTENT"]);
                    idcSECOM_HISTORY_INSERT.SetCommandParamValue("P_ACKTIME", vRow["ACKTIME"]);
                    idcSECOM_HISTORY_INSERT.SetCommandParamValue("P_TRANSFER", vRow["TRANSFER"]);
                    idcSECOM_HISTORY_INSERT.SetCommandParamValue("P_MODE_A", vRow["MODE_A"]);
                    idcSECOM_HISTORY_INSERT.SetCommandParamValue("P_SOB_ID", isAppInterfaceAdv1.SOB_ID);
                    idcSECOM_HISTORY_INSERT.SetCommandParamValue("P_ORG_ID", isAppInterfaceAdv1.ORG_ID);
                    idcSECOM_HISTORY_INSERT.SetCommandParamValue("P_CREATION_DATE", vSysDate);
                    idcSECOM_HISTORY_INSERT.SetCommandParamValue("P_USER_ID", isAppInterfaceAdv1.USER_ID);
                    idcSECOM_HISTORY_INSERT.ExecuteNonQuery();

                    ipbSECOM_INTERFACE.BarFillPercent = (Convert.ToSingle(vRowCount) / Convert.ToSingle(mDataTable.Rows.Count)) * 100F;
                }

                vOleDataAdapter.Dispose();
                vOleCommand.Dispose();
                mDataTable.Dispose();
                vOleConnection.Close();
                vOleConnection.Dispose();
            }
            catch (System.Exception ex)
            {
                vOleConnection.Close();
                vOleConnection.Dispose();
                
                MessageBoxAdv.Show(ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        #endregion

        #region ----- Private Methods ----
        private void DefaultCorporation()
        {
            // Lookup SETTING
            ildCORP.SetLookupParamValue("W_DUTY_CONTROL_YN", "Y");
            ildCORP.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");

            // LOOKUP DEFAULT VALUE SETTING - CORP
            idcDEFAULT_CORP.SetCommandParamValue("W_DUTY_CONTROL_YN", "Y");
            idcDEFAULT_CORP.SetCommandParamValue("W_ENABLED_FLAG_YN", "N");
            idcDEFAULT_CORP.ExecuteNonQuery();
            CORP_NAME_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_NAME");
            CORP_ID_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_ID");
        }

        private void GetSecomConfig()
        {
            idcSECOM_DB_PATH.ExecuteNonQuery();
            MDB_PATH = idcSECOM_DB_PATH.GetCommandParamValue("O_PATH").ToString();
            MDB_NAME = idcSECOM_DB_PATH.GetCommandParamValue("O_MDB_NAME").ToString();
        }

        private void SearchDB()
        {
            if (iString.ISNull(CORP_ID_0.EditValue) == string.Empty)
            {// 업체.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME_0.Focus();
                return;
            }
            if (iString.ISNull(START_DATE_0.EditValue) == string.Empty)
            {// 시작일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                START_DATE_0.Focus();
                return;
            }
            if (iString.ISNull(END_DATE_0.EditValue) == string.Empty)
            {// 종료일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                END_DATE_0.Focus();
                return;
            }

            if (Convert.ToDateTime(START_DATE_0.EditValue) > Convert.ToDateTime(END_DATE_0.EditValue))
            {// 종료일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10012"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                END_DATE_0.Focus();
                return;
            }

            Application.UseWaitCursor = true;            
            Application.DoEvents();            
            idaSECOM_HISTORY.Fill();            
            Application.UseWaitCursor = false;
            Application.DoEvents();
            igrSECOM_HISTORY.Focus();
        }

        #endregion;

        #region ----- Events -----

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    SearchDB();
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
        
        private void HRMF0391_Load(object sender, EventArgs e)
        {
            START_DATE_0.EditValue = DateTime.Today;
            END_DATE_0.EditValue = DateTime.Today;

            DefaultCorporation();
            GetSecomConfig();
        
            //DefaultSetFormReSize();             //[Child Form, Mdi Form에 맞게 ReSize]
            irbALL.CheckedState = ISUtil.Enum.CheckedState.Checked;
            igbSET_INTERFACE.Visible = false;            
        }

        private void irb_CheckChanged(object sender, EventArgs e)
        {
            ISRadioButtonAdv isSTATUS = sender as ISRadioButtonAdv;
            STATUS_FLAG.EditValue = isSTATUS.RadioCheckedString;
        }

        private void ibtnSET_SECOM_HISTORY_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            int RecordCount;

            if (iString.ISNull(CORP_ID_0.EditValue) == string.Empty)
            {// 업체.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME_0.Focus();
                return;
            }
            if (iString.ISNull(START_DATE_0.EditValue) == string.Empty)
            {// 시작일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                START_DATE_0.Focus();
                return;
            }
            if (iString.ISNull(END_DATE_0.EditValue) == string.Empty)
            {// 종료일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                END_DATE_0.Focus();
                return;
            }

            if (Convert.ToDateTime(START_DATE_0.EditValue) > Convert.ToDateTime(END_DATE_0.EditValue))
            {// 종료일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10012"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                END_DATE_0.Focus();
                return;
            }

            idcSECOM_HISTORY_COUNT.ExecuteNonQuery();
            RecordCount = Convert.ToInt32(idcSECOM_HISTORY_COUNT.GetCommandParamValue("O_COUNT"));
                       
            if (RecordCount > 0)
            {
                if (DialogResult.OK == MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10082"), "Question", MessageBoxButtons.OKCancel, MessageBoxIcon.Question))
                {
                    // 기존 자료 삭제.
                    idcSECOM_HISTORY_DELETE.ExecuteNonQuery();
                }
                else
                {
                    return;
                }                
            }

            // 동기화 처리.
            string SetDate;
            int Period_Day = Convert.ToInt32(0);
            
            DateTime vStartDate = Convert.ToDateTime(START_DATE_0.EditValue);
            DateTime vEndDate = Convert.ToDateTime(END_DATE_0.EditValue);
            System.TimeSpan vTimeSpan = vEndDate - vStartDate;
            Period_Day = vTimeSpan.Days + 1;
           
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;

            iptSET_MESSAGE.PromptText = "";
            ipbSECOM_INTERFACE.BarFillPercent = 0;
            igbSET_INTERFACE.Visible = true;
            Application.DoEvents();
            for (int i = 0; i < Period_Day; i++)
            {                
                SetDate = Convert.ToDateTime(iDate.ISDate_Add(Convert.ToDateTime(START_DATE_0.EditValue), i)).ToShortDateString();
                iptSET_MESSAGE.PromptText = string.Format("{0}{1}", "Set Interface Date : ", SetDate);
                Application.DoEvents();
                SetDate = SetDate.Replace("-", "");
                Connect_Secom_MDB(SetDate);
                Application.DoEvents();
            }           
            string OutMessage;
            idcSET_INTERFACE.ExecuteNonQuery();
            OutMessage = idcSET_INTERFACE.GetCommandParamValue("O_MESSAGE").ToString();
            igbSET_INTERFACE.Visible = false;
            this.Cursor = System.Windows.Forms.Cursors.Default;
            Application.DoEvents();
            MessageBoxAdv.Show(OutMessage, "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
        }

        #endregion

    }
}