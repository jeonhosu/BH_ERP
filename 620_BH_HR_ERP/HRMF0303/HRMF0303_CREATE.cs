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

namespace HRMF0303
{
    public partial class HRMF0303_CREATE : Office2007Form
    {
        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        public HRMF0303_CREATE(Form pMainForm, ISAppInterface pAppInterface, object pCorp_ID, object pWork_YYYYMM)
        {
            InitializeComponent();
            isAppInterfaceAdv1.AppInterface = pAppInterface;

            CORP_ID.EditValue = pCorp_ID;
            WORK_YYYYMM.EditValue = pWork_YYYYMM;
        }

        #region ----- Private / Method ----- 

        private void Search_DB(object pCreated_Method)
        {
            idaCALENDAR_SET.Cancel();
            if (START_DATE.EditValue == null)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                START_DATE.Focus();
                return;
            }
            if (END_DATE.EditValue == null)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                END_DATE.Focus();
                return;
            }
            if (WORK_TYPE_ID.EditValue == null)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Work Type(교대 유형)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                WORK_TYPE.Focus();
                return;
            }
            if (iString.ISNull(pCreated_Method) == string.Empty)
            {
                pCreated_Method = "A";
            }
            idaCALENDAR_SET.SetSelectParamValue("W_CREATED_METHOD", pCreated_Method);
            idaCALENDAR_SET.Fill();
            igrCALENDAR_SET.Focus();

            int mRecordCount = idaCALENDAR_SET.SelectRows.Count;
            if (mRecordCount == 0)
            {
                Init_Work_Plan_STD();
            }            
        }

        private void isSetCommonLookUpParameter(string P_GROUP_CODE, String P_USABLE_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", P_GROUP_CODE);
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", P_USABLE_YN);
        }

        #endregion

        #region ----- Initialize -----

        private void Insert_Before_Apply_Day()
        {
            igrCALENDAR_SET.SetCellValue("HOLY_TYPE", -1);
            igrCALENDAR_SET.SetCellValue("HOLY_TYPE_NAME", isMessageAdapter1.ReturnText("FCM_10166"));
            igrCALENDAR_SET.SetCellValue("DAY_COUNT", 0);
        }

        private bool Insert_Holy_Type()
        {
            if (START_DATE.EditValue == null)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                START_DATE.Focus();
                return false;
            }
            if (END_DATE.EditValue == null)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                END_DATE.Focus();
                return false;
            }
            if (WORK_TYPE_ID.EditValue == null)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Work Type(교대 유형)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                WORK_TYPE.Focus();
                return false;
            }
            return true;
        }                
        
        private void Init_Cell_Status()
        {
            if (iString.ISNumtoZero(igrCALENDAR_SET.GetCellValue("HOLY_TYPE")) == Convert.ToInt32(-1))
            {
                igrCALENDAR_SET.GridAdvExColElement[igrCALENDAR_SET.GetColumnToIndex("HOLY_TYPE")].Insertable = 0;
                igrCALENDAR_SET.GridAdvExColElement[igrCALENDAR_SET.GetColumnToIndex("HOLY_TYPE")].Updatable = 0;
                igrCALENDAR_SET.GridAdvExColElement[igrCALENDAR_SET.GetColumnToIndex("HOLY_TYPE_NAME")].Insertable = 0;
                igrCALENDAR_SET.GridAdvExColElement[igrCALENDAR_SET.GetColumnToIndex("HOLY_TYPE_NAME")].Updatable = 0;

                igrCALENDAR_SET.CurrentCellMoveTo(3);
            }
            else
            {
                igrCALENDAR_SET.GridAdvExColElement[igrCALENDAR_SET.GetColumnToIndex("HOLY_TYPE")].Insertable = 1;
                igrCALENDAR_SET.GridAdvExColElement[igrCALENDAR_SET.GetColumnToIndex("HOLY_TYPE")].Updatable = 1;
                igrCALENDAR_SET.GridAdvExColElement[igrCALENDAR_SET.GetColumnToIndex("HOLY_TYPE_NAME")].Insertable = 1;
                igrCALENDAR_SET.GridAdvExColElement[igrCALENDAR_SET.GetColumnToIndex("HOLY_TYPE_NAME")].Updatable = 1;

                igrCALENDAR_SET.CurrentCellMoveTo(1);
            }
        }

        private void Init_Work_Plan()
        {
            //기존 자료 삭제.
            igrCALENDAR_SET.BeginUpdate();
            idaCALENDAR_SET.OraSelectData.AcceptChanges();
            for (int i = 0; i < idaCALENDAR_SET.SelectRows.Count; i++)
            {
                idaCALENDAR_SET.OraSelectData.Rows[i].SetAdded();
            }
            idaCALENDAR_SET.Refillable = false;
            igrCALENDAR_SET.EndUpdate();
            
            igrCALENDAR_SET.CurrentCellMoveTo(0, 0);
            igrCALENDAR_SET.CurrentCellActivate(0, 0);
            igrCALENDAR_SET.Focus();
        }

        private void Init_Work_Plan_STD()
        {
            idaWORK_PLAN_STD.Fill();
            if (idaWORK_PLAN_STD.SelectRows.Count == 0)
            {
                return;
            }

            igrCALENDAR_SET.BeginUpdate();
            for (int i = 0; i < idaWORK_PLAN_STD.SelectRows.Count; i++)
            {
                idaCALENDAR_SET.AddUnder();
                for (int j = 0; j < igrCALENDAR_SET.GridAdvExColElement.Count; j++)
                {
                    igrCALENDAR_SET.SetCellValue(i, j, idaWORK_PLAN_STD.SelectRows[i][j]);
                }
            }
            igrCALENDAR_SET.EndUpdate();

            igrCALENDAR_SET.CurrentCellMoveTo(0, 0);
            igrCALENDAR_SET.CurrentCellActivate(0, 0);
            igrCALENDAR_SET.Focus();            
        }

        #endregion

        #region ----- isAppInterfaceAdv1_AppMainButtonClick Events -----

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

        private void HRMF0303_CREATE_Load(object sender, EventArgs e)
        {
            idaCALENDAR_SET.FillSchema();
        }

        private void HRMF0303_CREATE_Shown(object sender, EventArgs e)
        {
            DateTime dStart_Date;
            DateTime dEnd_Date;
            idcYYYYMM_TERM.SetCommandParamValue("W_YYYYMM", WORK_YYYYMM.EditValue);
            idcYYYYMM_TERM.ExecuteNonQuery();
            dStart_Date = Convert.ToDateTime(idcYYYYMM_TERM.GetCommandParamValue("O_START_DATE"));
            dEnd_Date = Convert.ToDateTime(idcYYYYMM_TERM.GetCommandParamValue("O_END_DATE"));

            START_DATE.EditValue = dStart_Date;
            END_DATE.EditValue = dEnd_Date;
        }

        private void igrCALENDAR_SET_CurrentCellValidating(object pSender, ISGridAdvExValidatingEventArgs e)
        {
            if (e.ColIndex == igrCALENDAR_SET.GetColumnToIndex("HOLY_TYPE"))
            {
                igrCALENDAR_SET.CurrentCellActivate(igrCALENDAR_SET.GetColumnToIndex("DAY_COUNT"));
            }
        }

        private void ibtCREATE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            UseWaitCursor = true;
            Application.DoEvents();
            string sMessage = null;
            string mCREATED_METHOD;
            if (iString.ISNull(PERSON_ID.EditValue) != string.Empty)
            {
                mCREATED_METHOD = "P".ToString();
            }
            else if (iString.ISNull(DEPT_ID.EditValue) != string.Empty)
            {
                mCREATED_METHOD = "D".ToString();
            }
            else
            {
                mCREATED_METHOD = "A".ToString();
            }
            // 기존자료 삭제.
            idcDELETE_CALENDAR_SET.SetCommandParamValue("W_CREATED_METHOD", mCREATED_METHOD);
            idcDELETE_CALENDAR_SET.ExecuteNonQuery();

            Init_Work_Plan();

            idaCALENDAR_SET.SetInsertParamValue("P_CREATED_METHOD", mCREATED_METHOD);
            idaCALENDAR_SET.SetDeleteParamValue("W_CREATED_METHOD", mCREATED_METHOD);
            idaCALENDAR_SET.Update();

            try
            {               
                idcCALENDAR_CREATE.ExecuteNonQuery();
                sMessage = idcCALENDAR_CREATE.GetCommandParamValue("O_MESSAGE").ToString();
                if (sMessage != null)
                {
                    MessageBoxAdv.Show(sMessage, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                }
            }
            catch
            {
                Application.DoEvents();
                UseWaitCursor = false;
                this.Cursor = Cursors.Default;
                return;
            }
            Application.DoEvents();
            UseWaitCursor = false;
            this.Cursor = Cursors.Default;
        }

        private void ibtCANCEL_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            this.Close();
        }

        private void btnINSERT_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (Insert_Holy_Type() == false)
            {
                return;
            }
            idaCALENDAR_SET.AddUnder();
            if (igrCALENDAR_SET.RowIndex == Convert.ToInt32(0))
            {
                Insert_Before_Apply_Day();
            }
            Init_Cell_Status();
            if (iString.ISNull(WORK_TYPE.EditValue).Substring(0, 2) == "11" 
               && iString.ISNumtoZero(igrCALENDAR_SET.GetCellValue("HOLY_TYPE")) != Convert.ToInt32(-1))
            {
                idaCALENDAR_SET.Delete();
            }            
        }

        private void btnDELETE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            idaCALENDAR_SET.Delete();
        }

        private void btnCANCEL_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            idaCALENDAR_SET.Cancel();
        }

        #endregion

        #region ----- Lookup Event -----

        private void ilaWORK_TYPE_SelectedRowData(object pSender)
        {
            Search_DB("A");
        }

        private void ilaPERSON_SelectedRowData(object pSender)
        {
            Search_DB("P");
        }

        private void ilaDEPT_SelectedRowData(object pSender)
        {
            Search_DB("D");
        }
        
        private void ilaPERSON_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildPERSON.SetLookupParamValue("W_CORP_ID", CORP_ID.EditValue);
        }

        private void ilaDEPT_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT.SetLookupParamValue("W_CORP_ID", CORP_ID.EditValue);
            ildDEPT.SetLookupParamValue("W_USABLE_CHECK_YN", "Y");
        }

        private void ilaWORK_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("WORK_TYPE", "Y");
        }

        private void ilaHOLY_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("HOLY_TYPE", "Y");
        }

        #endregion

        #region ----- Adapter Event -----

        private void idaCALENDAR_SET_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(START_DATE.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            if (iString.ISNull(END_DATE.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            if (iString.ISNull(WORK_TYPE_ID.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Work Type(교대 유형)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            if (iString.ISNull(WORK_TYPE.EditValue).Substring(0, 2) == "11")
            {
            }
            else
            {

                if (iString.ISNull(e.Row["HOLY_TYPE"]) == String.Empty)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Holy Type(근무구분)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }
                if (iString.ISNull(e.Row["HOLY_TYPE_NAME"]) == String.Empty)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Holy Type Name(근무명) "), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }
                if (iString.ISNull(e.Row["DAY_COUNT"]) == String.Empty)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Day Count(근무일수) "), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }
            }
        }
        
        private void idaCALENDAR_SET_NewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            Init_Cell_Status();
        }

        #endregion
    }
}