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

namespace FCMF0274
{
    public partial class FCMF0274 : Office2007Form
    {
        #region ----- Variables -----

        private ISFunction.ISConvert iString = new ISFunction.ISConvert();
        private ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        private string[,] mMonth;

        private int mIndexRowCellMoved = 0;
        private int mIndexColumnCellMoved = 0;

        #endregion;

        #region ----- Constructor -----

        public FCMF0274(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Convert decimal  Method ----

        private decimal ConvertNumber(object pObject)
        {
            bool vIsConvert = false;
            decimal vConvertDecimal = 0m;

            try
            {
                if (pObject != null)
                {
                    vIsConvert = pObject is decimal;
                    if (vIsConvert == true)
                    {
                        decimal vIsConvertNum = (decimal)pObject;
                        vConvertDecimal = vIsConvertNum;
                    }
                }

            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }

            return vConvertDecimal;
        }

        private decimal ConvertNumber(string pStringNumber)
        {
            decimal vConvertDecimal = 0m;

            try
            {
                bool isNull = string.IsNullOrEmpty(pStringNumber);
                if (isNull != true)
                {
                    vConvertDecimal = decimal.Parse(pStringNumber);
                }

            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }

            return vConvertDecimal;
        }

        #endregion;

        #region ----- Convert String Method ----

        private string ConvertString(object pObject)
        {
            string vString = string.Empty;

            try
            {
                if (pObject != null)
                {
                    bool IsConvert = pObject is string;
                    if (IsConvert == true)
                    {
                        vString = pObject as string;
                    }
                }
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }

            return vString;
        }

        #endregion;


        #region ----- DB Search Method -----

        private void SearchDB(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, InfoSummit.Win.ControlAdv.ISDataAdapter pAdapter)
        {
            object vObject1 = PERIOD_YEAR_0.EditValue;
            object vObject2 = MONTH_FR_NAME_0.EditValue;
            object vObject3 = MONTH_TO_NAME_0.EditValue;
            if (iString.ISNull(vObject1) == string.Empty || iString.ISNull(vObject2) == string.Empty || iString.ISNull(vObject3) == string.Empty)
            {
                //기간(년, 월)은 필수입니다.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10442"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                MONTH_FR_NAME_0.Focus();
                return;
            }

            object vObject6 = MONTH_FR_CODE_0.EditValue;
            object vObject7 = MONTH_TO_CODE_0.EditValue;
            string vMonthFrString = iString.ISNull(vObject6);
            string vMonthToString = iString.ISNull(vObject7);
            decimal vMonthFrDecimal = ConvertNumber(vMonthFrString.Substring(1, 2));
            decimal vMonthToDecimal = ConvertNumber(vMonthToString.Substring(1, 2));
            if (vMonthFrDecimal > vMonthToDecimal)
            {
                //종료기간은 시작기간 보다 커야 합니다.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10345"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                MONTH_FR_CODE_0.Focus();
                return;
            }

            object vObject4 = ACCOUNT_CODE_FR_0.EditValue;
            object vObject5 = ACCOUNT_CODE_TO_0.EditValue;
            if (iString.ISNull(vObject4) == string.Empty || iString.ISNull(vObject5) == string.Empty)
            {
                //계정과목은 필수입니다.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10123"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                ACCOUNT_CODE_FR_0.Focus();
                return;
            }

            pAdapter.Fill();
            pGrid.Focus();
        }

        #endregion;

        #region ----- Default Set Method -----

        //월 조회 조건 - 결산월 가져오기
        private void GetValue_MONTH()
        {
            idaMONTH.SetSelectParamValue("W_GROUP_CODE", "MONTH");
            idaMONTH.SetSelectParamValue("W_ENABLED_YN", "Y");
            idaMONTH.Fill();

            object vObject_NAME = null;
            object vObject_CODE = null;
            int vCountArray = idaMONTH.OraSelectData.Rows.Count;
            mMonth = new string[vCountArray, 2];

            for (int vRow = 0; vRow < vCountArray; vRow++)
            {
                vObject_NAME = idaMONTH.OraSelectData.Rows[vRow]["CODE_NAME"];
                vObject_CODE = idaMONTH.OraSelectData.Rows[vRow]["CODE"];
                mMonth[vRow, 0] = iString.ISNull(vObject_NAME);
                mMonth[vRow, 1] = iString.ISNull(vObject_CODE);
            }
        }

        //월 조회 조건 - 결산월 기본값 설정
        private void Default_MONTH()
        {
            int vMonth = System.DateTime.Today.Month;
            int vIndexArray = vMonth - 1;

            MONTH_FR_NAME_0.EditValue = mMonth[0, 0];
            MONTH_FR_CODE_0.EditValue = mMonth[0, 1];

            MONTH_TO_NAME_0.EditValue = mMonth[vIndexArray, 0];
            MONTH_TO_CODE_0.EditValue = mMonth[vIndexArray, 1];
        }

        #endregion;

        #region ----- MDi ToolBar Button Event -----

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    int vIndexTAB = isTAB.SelectedIndex;

                    if (vIndexTAB == 0)
                    {
                        SearchDB(igrLIST_DEPT_AMT, idaLIST_DEPT_AMT);
                    }
                    else if (vIndexTAB == 1)
                    {
                        SearchDB(igrLIST_ACCOUNT_AMT, idaLIST_ACCOUNT_AMT);
                    }
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
                    if (idaLIST_DEPT_AMT.IsFocused == true)
                    {
                        idaLIST_DEPT_AMT.Cancel();
                    }
                    else if (idaLIST_ACCOUNT_AMT.IsFocused == true)
                    {
                        idaLIST_ACCOUNT_AMT.Cancel();
                    }
                    else if (idaLIST_DETAIL.IsFocused == true)
                    {
                        idaLIST_DETAIL.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {

                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void FCMF0274_Load(object sender, EventArgs e)
        {
            PERIOD_YEAR_0.EditValue = iDate.ISYear(System.DateTime.Today);

            GetValue_MONTH();
        }
        
        private void FCMF0274_Shown(object sender, EventArgs e)
        {
            Default_MONTH();
        }

        #endregion

        #region ----- Lookup Event -----

        private void ilaACCOUNT_CODE_FR_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildACCOUNT_CONTROL_0.SetLookupParamValue("W_ACCOUNT_SET_ID", null);
            ildACCOUNT_CONTROL_0.SetLookupParamValue("W_ACCOUNT_CODE", null);
        }

        private void ilaACCOUNT_CODE_TO_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildACCOUNT_CONTROL_0.SetLookupParamValue("W_ACCOUNT_SET_ID", null);
            ildACCOUNT_CONTROL_0.SetLookupParamValue("W_ACCOUNT_CODE", ACCOUNT_CODE_FR_0.EditValue);
        }

        private void ilaMONTH_TO_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildMONTH_0.SetLookupParamValue("W_GROUP_CODE", "MONTH");
            ildMONTH_0.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaMONTH_FR_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {

            ildMONTH_0.SetLookupParamValue("W_GROUP_CODE", "MONTH");
            ildMONTH_0.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        #endregion

        #region ----- Grid Double Click After Call Method -----

        private void Search_LIST_DETAIL(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, InfoSummit.Win.ControlAdv.ISDataAdapter pAdapter_1, InfoSummit.Win.ControlAdv.ISDataAdapter pAdapter_2)
        {
            string vMessageText = string.Empty;

            try
            {
                if (pGrid.RowIndex > -1)
                {
                    int vIndexColunm_YEAR_AMT = pGrid.GetColumnToIndex("YEAR_AMT");     // 년합계 컬럼 인데스
                    int vIndexColunm_PERIOD_AMT = pGrid.GetColumnToIndex("PERIOD_AMT"); //기간합계 컬럼 인데스

                    object oDEPT_CODE = pGrid.GetCellValue("DEPT_CODE");
                    object oACCOUNT_CODE = pGrid.GetCellValue("ACCOUNT_CODE");

                    object oDEPT_NAME = pGrid.GetCellValue("DEPT_NAME");
                    object oACCOUNT_NAME = pGrid.GetCellValue("ACCOUNT_NM");

                    object oSELECT_MONTH = pAdapter_1.OraSelectData.Columns[mIndexColumnCellMoved].ColumnName;

                    object oMONTH_FR_CODE = MONTH_FR_CODE_0.EditValue;
                    object oMONTH_TO_CODE = MONTH_TO_CODE_0.EditValue;

                    string vDEPT_CODE = ConvertString(oDEPT_CODE);
                    string vACCOUNT_CODE = ConvertString(oACCOUNT_CODE);

                    string vMONTH_FR_CODE = ConvertString(oMONTH_FR_CODE);
                    string vMONTH_TO_CODE = ConvertString(oMONTH_TO_CODE);

                    string vSELECT_MONTH = ConvertString(oSELECT_MONTH);

                    if (vIndexColunm_YEAR_AMT > mIndexColumnCellMoved)
                    {
                        return;
                    }

                    if (iString.ISNull(oACCOUNT_CODE) == string.Empty)
                    {
                        return;
                    }

                    if (vIndexColunm_YEAR_AMT == mIndexColumnCellMoved) //년합계를 더블클릭 했다면
                    {
                        pAdapter_2.SetSelectParamValue("W_MONTH_FROM", "M01");
                        pAdapter_2.SetSelectParamValue("W_MONTH_TO", "M12");
                        pAdapter_2.SetSelectParamValue("W_DEPT_CODE", vDEPT_CODE);
                        pAdapter_2.SetSelectParamValue("W_ACCOUNT", vACCOUNT_CODE);
                    }
                    else if (vIndexColunm_PERIOD_AMT == mIndexColumnCellMoved) //기간합계를 더블클릭 했다면
                    {
                        pAdapter_2.SetSelectParamValue("W_MONTH_FROM", vMONTH_FR_CODE);
                        pAdapter_2.SetSelectParamValue("W_MONTH_TO", vMONTH_TO_CODE);
                        pAdapter_2.SetSelectParamValue("W_DEPT_CODE", vDEPT_CODE);
                        pAdapter_2.SetSelectParamValue("W_ACCOUNT", vACCOUNT_CODE);
                    }
                    else
                    {
                        pAdapter_2.SetSelectParamValue("W_MONTH_FROM", vSELECT_MONTH);
                        pAdapter_2.SetSelectParamValue("W_MONTH_TO", vSELECT_MONTH);
                        pAdapter_2.SetSelectParamValue("W_DEPT_CODE", vDEPT_CODE);
                        pAdapter_2.SetSelectParamValue("W_ACCOUNT", vACCOUNT_CODE);
                    }


                    pAdapter_2.Fill();
                    isTAB.SelectedIndex = 2;

                    pGrid.Focus();

                    //DEPT_ID = pAdapter_2.GetSelectParamValue("W_DEPT_ID");
                    //ACCOUNT_CODE = pAdapter_2.GetSelectParamValue("W_ACCOUNT");
                    //object MONTH_FROM = pAdapter_2.GetSelectParamValue("W_MONTH_FROM");
                    //object MONTH_TO = pAdapter_2.GetSelectParamValue("W_MONTH_TO");

                    //vMessageText = string.Format("{0}[{1}] - {2}[{3}] - {4}~{5}", DEPT_NAME, DEPT_ID, ACCOUNT_NAME, ACCOUNT_CODE, MONTH_FROM, MONTH_TO);
                    //isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
                }
            }
            catch (System.Exception ex)
            {
                MessageBoxAdv.Show(ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        #endregion

        #region ----- Grid Event -----

        private void igrLIST_DEPT_AMT_CellMoved(object pSender, ISGridAdvExCellClickEventArgs e)
        {
            try
            {
                mIndexRowCellMoved = e.RowIndex;
                mIndexColumnCellMoved = e.ColIndex;

                //string vNameColumn = idaLIST_DEPT_AMT.OraSelectData.Columns[mIndexColumnCellMoved].ColumnName;
                //string vMessageText = string.Format("igrLIST_DEPT_AMT Index Column : R{0:D3},C{1:D3} - [{2}]", mIndexRowCellMoved, mIndexColumnCellMoved, vNameColumn);
                //isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
                //System.Windows.Forms.Application.DoEvents();
            }
            catch (System.Exception ex)
            {
                MessageBoxAdv.Show(ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void igrLIST_DEPT_AMT_CellDoubleClick(object pSender)
        {
            Search_LIST_DETAIL(igrLIST_DEPT_AMT, idaLIST_DEPT_AMT, idaLIST_DETAIL);
        }

        private void igrLIST_ACCOUNT_AMT_CellMoved(object pSender, ISGridAdvExCellClickEventArgs e)
        {
            try
            {
                mIndexRowCellMoved = e.RowIndex;
                mIndexColumnCellMoved = e.ColIndex;

                //string vNameColumn = idaLIST_ACCOUNT_AMT.OraSelectData.Columns[mIndexColumnCellMoved].ColumnName;
                //string vMessageText = string.Format("igrLIST_ACCOUNT_AMT Index Column : R{0:D3},C{1:D3} - [{2}]", mIndexRowCellMoved, mIndexColumnCellMoved, vNameColumn);
                //isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
                //System.Windows.Forms.Application.DoEvents();
            }
            catch (System.Exception ex)
            {
                MessageBoxAdv.Show(ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void igrLIST_ACCOUNT_AMT_CellDoubleClick(object pSender)
        {
            Search_LIST_DETAIL(igrLIST_ACCOUNT_AMT, idaLIST_ACCOUNT_AMT, idaLIST_DETAIL);
        }

        private void igrLIST_DETAIL_CellDoubleClick(object pSender)
        {
            if (igrLIST_DETAIL.RowIndex > -1)
            {
                object ACCOUNT_CODE = igrLIST_DETAIL.GetCellValue("ACCOUNT_CODE");

                if (iString.ISNull(ACCOUNT_CODE) == string.Empty)
                {
                    return;
                }

                //int vSLIP_HEADER_ID = iString.ISNumtoZero(igrLIST_DETAIL.GetCellValue("SLIP_HEADER_ID"));
                //if (vSLIP_HEADER_ID > Convert.ToInt32(0))
                //{
                //    System.Windows.Forms.Application.UseWaitCursor = true;
                //    this.Cursor = System.Windows.Forms.Cursors.WaitCursor;

                //    FCMF0205.FCMF0205 vFCMF0205 = new FCMF0205.FCMF0205(this.MdiParent, isAppInterfaceAdv1.AppInterface, vSLIP_HEADER_ID);
                //    vFCMF0205.Show();

                //    this.Cursor = System.Windows.Forms.Cursors.Default;
                //    System.Windows.Forms.Application.UseWaitCursor = false;
                //}

                object vObject_SLIP_HEADER_ID = igrLIST_DETAIL.GetCellValue("SLIP_HEADER_ID");
                string vString_SLIP_HEADER_ID = ConvertString(vObject_SLIP_HEADER_ID);

                decimal vDecimal_SLIP_HEADER_ID = ConvertNumber(vString_SLIP_HEADER_ID);
                if (vDecimal_SLIP_HEADER_ID > 0)
                {
                    System.Windows.Forms.Application.UseWaitCursor = true;
                    this.Cursor = System.Windows.Forms.Cursors.WaitCursor;

                    FCMF0205.FCMF0205 vFCMF0205 = new FCMF0205.FCMF0205(this.MdiParent, isAppInterfaceAdv1.AppInterface, vDecimal_SLIP_HEADER_ID);
                    vFCMF0205.Show();

                    this.Cursor = System.Windows.Forms.Cursors.Default;
                    System.Windows.Forms.Application.UseWaitCursor = false;
                }
            }
        }

        #endregion
    }
}