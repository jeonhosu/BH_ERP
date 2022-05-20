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

namespace HRMF0233
{
    public partial class HRMF0233 : Office2007Form
    {
        #region ----- Variables -----

        private ISFunction.ISConvert iString = new ISFunction.ISConvert();
        private ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        private ISUtil.Enum.AppMainButtonType mMainButton;

        #endregion;

        #region ----- Constructor -----

        public HRMF0233(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();

            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Method -----

        private void DefaultCorporation()
        {
            try
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
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void SEARCH_DB()
        {
            try
            {
                //if (CORP_ID_0.EditValue == null)
                //{// 업체 선택
                //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                //    CORP_NAME_0.Focus();
                //    return;
                //}
                if (iedSTART_DATE_0.EditValue == null)
                {// 발령기간_시작
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    iedSTART_DATE_0.Focus();
                    return;
                }
                if (iedEND_DATE_0.EditValue == null)
                {// 발령기간_종료
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    iedEND_DATE_0.Focus();
                    return;
                }
                if (Convert.ToDateTime(iedSTART_DATE_0.EditValue) > Convert.ToDateTime(iedEND_DATE_0.EditValue))
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10012"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    iedSTART_DATE_0.Focus();
                    return;
                }

                idaHISTORY_HEADER.Fill();

                if (idaHISTORY_HEADER.OraSelectData != null)
                {
                    int vCountRow = idaHISTORY_HEADER.OraSelectData.Rows.Count;
                    if (vCountRow > 0)
                    {
                        idaHISTORY_LINE.Fill();
                    }

                    igrHEADER.Focus();
                }
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private bool iNewcomer_Check()
        {
            try
            {
                ISCommonUtil.ISFunction.ISConvert iConvert = new ISCommonUtil.ISFunction.ISConvert();
                if (iConvert.ISNull(igrHEADER.GetCellValue("NEWCOMER_YN")) == "Y")
                {
                    return true;
                }
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }

            return false;
        }
        #endregion
        
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
                else
                {
                    vConvertDecimal = -1;
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

        #region ----- MDi ToolBar Button Evetn -----

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
                    if (idaHISTORY_HEADER.IsFocused)
                    {
                        idaHISTORY_HEADER.AddOver();

                        igrHEADER.CurrentCellMoveTo(igrHEADER.GetColumnToIndex("CHARGE_DATE"));
                        igrHEADER.Focus();
                    }
                    else if (idaHISTORY_LINE.IsFocused)
                    {
                        idaHISTORY_LINE.AddOver();
                        
                        igrLINE.SetCellValue("CHARGE_DATE", igrHEADER.GetCellValue("CHARGE_DATE"));
                        igrLINE.SetCellValue("CHARGE_ID", igrHEADER.GetCellValue("CHARGE_ID"));
                        igrLINE.SetCellValue("CHARGE_NAME", igrHEADER.GetCellValue("CHARGE_NAME"));

                        PRINT_YN.CheckedState = ISUtil.Enum.CheckedState.Checked;

                        //int vCountRow = idaHISTORY_HEADER.OraSelectData.Rows.Count;

                        //if (vCountRow > 0)
                        //{
                        //    object vObject_HISTORY_HEADER_ID = igrHEADER.GetCellValue("HISTORY_HEADER_ID");
                        //    decimal vDECIMAL_HISTORY_HEADER_ID = ConvertNumber(vObject_HISTORY_HEADER_ID);

                        //    if (vDECIMAL_HISTORY_HEADER_ID != 0 && vDECIMAL_HISTORY_HEADER_ID != -1)
                        //    {
                        //        idaHISTORY_LINE.AddOver();

                        //        igrLINE.SetCellValue("HISTORY_HEADER_ID", igrHEADER.GetCellValue("HISTORY_HEADER_ID"));
                        //        igrLINE.SetCellValue("HISTORY_NUM", igrHEADER.GetCellValue("HISTORY_NUM"));
                        //        igrLINE.SetCellValue("CHARGE_DATE", igrHEADER.GetCellValue("CHARGE_DATE"));
                        //        igrLINE.SetCellValue("CHARGE_ID", igrHEADER.GetCellValue("CHARGE_ID"));
                        //        igrLINE.SetCellValue("CHARGE_NAME", igrHEADER.GetCellValue("CHARGE_NAME"));
                        //    }
                        //}
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaHISTORY_HEADER.IsFocused)
                    {
                        idaHISTORY_HEADER.AddUnder();

                        igrHEADER.CurrentCellMoveTo(igrHEADER.GetColumnToIndex("CHARGE_DATE"));
                        igrHEADER.Focus();
                    }
                    else if (idaHISTORY_LINE.IsFocused)
                    {
                        idaHISTORY_LINE.AddUnder();

                        igrLINE.SetCellValue("CHARGE_DATE", igrHEADER.GetCellValue("CHARGE_DATE"));
                        igrLINE.SetCellValue("CHARGE_ID", igrHEADER.GetCellValue("CHARGE_ID"));
                        igrLINE.SetCellValue("CHARGE_NAME", igrHEADER.GetCellValue("CHARGE_NAME"));

                        PRINT_YN.CheckedState = ISUtil.Enum.CheckedState.Checked;

                        //int vCountRow = idaHISTORY_HEADER.OraSelectData.Rows.Count;

                        //if (vCountRow > 0)
                        //{
                        //    object vObject_HISTORY_HEADER_ID = igrHEADER.GetCellValue("HISTORY_HEADER_ID");
                        //    decimal vDECIMAL_HISTORY_HEADER_ID = ConvertNumber(vObject_HISTORY_HEADER_ID);

                        //    if (vDECIMAL_HISTORY_HEADER_ID != 0 && vDECIMAL_HISTORY_HEADER_ID != -1)
                        //    {
                        //        idaHISTORY_LINE.AddUnder();

                        //        igrLINE.SetCellValue("HISTORY_HEADER_ID", igrHEADER.GetCellValue("HISTORY_HEADER_ID"));
                        //        igrLINE.SetCellValue("HISTORY_NUM", igrHEADER.GetCellValue("HISTORY_NUM"));
                        //        igrLINE.SetCellValue("CHARGE_DATE", igrHEADER.GetCellValue("CHARGE_DATE"));
                        //        igrLINE.SetCellValue("CHARGE_ID", igrHEADER.GetCellValue("CHARGE_ID"));
                        //        igrLINE.SetCellValue("CHARGE_NAME", igrHEADER.GetCellValue("CHARGE_NAME"));
                        //    }
                        //}
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    idaHISTORY_HEADER.Update(); 
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaHISTORY_HEADER.IsFocused)
                    {
                        idaHISTORY_LINE.Cancel();
                        idaHISTORY_HEADER.Cancel();
                    }
                    else if (idaHISTORY_LINE.IsFocused)
                    {
                        idaHISTORY_LINE.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaHISTORY_HEADER.IsFocused)
                    {
                        idaHISTORY_HEADER.Delete();
                    }
                    else if (idaHISTORY_LINE.IsFocused)
                    {
                        idaHISTORY_LINE.Delete();
                    }
                }
            }
        }

        #endregion

        #region ----- Form Event -----

        private void HRMF0233_Load(object sender, EventArgs e)
        {
            DateTime pStart_Date = DateTime.Parse(DateTime.Today.Year.ToString() + "-" + DateTime.Today.Month.ToString() + "-01".ToString());
            DateTime pEnd_Date = iDate.ISMonth_Last(pStart_Date);

            idaHISTORY_HEADER.FillSchema();
            idaHISTORY_LINE.FillSchema();

            iedSTART_DATE_0.EditValue = pStart_Date;
            iedEND_DATE_0.EditValue = pEnd_Date;

            DefaultCorporation();

            isAppInterfaceAdv1.OnAppMessage("");
            System.Windows.Forms.Application.DoEvents();
        }

        #endregion

        #region ----- Adapter Event -----

        private void idaHISTORY_HEADER_NewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            try
            {
                if (mMainButton != ISUtil.Enum.AppMainButtonType.AddOver && mMainButton != ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaHISTORY_HEADER.OraSelectData != null)
                    {
                        int vCountRow = idaHISTORY_HEADER.OraSelectData.Rows.Count;
                        if (vCountRow > 0)
                        {
                            idaHISTORY_LINE.Fill();
                        }
                        else
                        {
                            igrLINE.RowCount = 0;
                        }

                        igrHEADER.Focus();
                    }
                }
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void idaHISTORY_HEADER_UpdateCompleted(object pSender)
        {
            ////[EAPP_10010]저장되었습니다.
            //string vGetMessage_1 = isMessageAdapter1.ReturnText("EAPP_10010");
            ////[FCM_10431]다시 조회 합니다.
            //string vGetMessage_2 = isMessageAdapter1.ReturnText("FCM_10431");
            //string vMessage = string.Format("{0}\n\n{1}", vGetMessage_1, vGetMessage_2);
            //MessageBoxAdv.Show(vMessage, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);

            //idaHISTORY_HEADER.Fill();
        }

        private void idaHISTORY_HEADER_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            try
            {
                if (e.Row["CHARGE_DATE"] == DBNull.Value)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Charge Date(발령일자)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
                if (e.Row["CHARGE_ID"] == DBNull.Value)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Charge Type(발령구분)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void idaHISTORY_HEADER_PreDelete(ISPreDeleteEventArgs e)
        {
            //삭제 하고자 하는 발령번호를 기준으로
            //큰 번호가 이미 존재하면 지울수가 없다.
            try
            {
                if (e.Row.RowState != DataRowState.Added)
                {
                    if (igrLINE.RowCount > Convert.ToInt32(0))
                    {
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:=Data Exists(발령정보가 존재합니다. 해당 자료)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        e.Cancel = true;
                        return;
                    }
                }
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void idaHISTORY_LINE_PreDelete(ISPreDeleteEventArgs e)
        {
            try
            {
                if (e.Row.RowState != DataRowState.Added)
                {
                    // 신규발령 수정 못함.
                    if (iNewcomer_Check() == true)
                    {
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10030"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        e.Cancel = true;
                        return;
                    }

                    if (e.Row["HISTORY_LINE_ID"] == DBNull.Value)
                    {
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:=Data(해당 자료)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
                        e.Cancel = true;
                        return;
                    }
                }
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void idaHISTORY_LINE_UpdateCompleted(object pSender)
        {
            //[EAPP_10010]저장되었습니다.
            //string vGetMessage_1 = isMessageAdapter1.ReturnText("EAPP_10010");
            //MessageBoxAdv.Show(vGetMessage_1, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        }

        private void idaHISTORY_LINE_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            try
            {
                // 신규발령 수정 못함.
                if (iNewcomer_Check() == true)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10048"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
                if (e.Row["PERSON_ID"] == DBNull.Value)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Person(사원)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }

                if (e.Row["CHARGE_DATE"] == DBNull.Value)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Charge Date(발령일자)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
                if (e.Row["CHARGE_ID"] == DBNull.Value)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Charge Type(발령구분)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
                if (iString.ISNull(igrHEADER.GetCellValue("RETIRE_YN")) != string.Empty)
                {
                    if (igrHEADER.GetCellValue("RETIRE_YN").ToString() == "Y".ToString())
                    {
                        if (e.Row["RETIRE_ID"] == DBNull.Value)
                        {
                            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Retire Reason(퇴직발령시 퇴직사유)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                            e.Cancel = true;
                            return;
                        }
                    }
                }
                else
                {
                    if (e.Row["RETIRE_ID"] != DBNull.Value)
                    {
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10039"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        e.Cancel = true;
                        return;
                    }
                }

                // 발령후 정보
                if (e.Row["OPERATING_UNIT_ID"] == DBNull.Value)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=After Operating Unit(발령후 사업장)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
                if (e.Row["DEPT_ID"] == DBNull.Value)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=After Department(발령후 부서)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
                if (e.Row["JOB_CLASS_ID"] == DBNull.Value)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=After Job Class((발령후 직군)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
                if (e.Row["JOB_ID"] == DBNull.Value)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=After Job(발령후 직종)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
                if (e.Row["POST_ID"] == DBNull.Value)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=After Post(발령후 직위)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
                if (e.Row["OCPT_ID"] == DBNull.Value)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=After OCPT(발령후 직무)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
                if (e.Row["ABIL_ID"] == DBNull.Value)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=After Abil(발령후 직책)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
                if (e.Row["PAY_GRADE_ID"] == DBNull.Value)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=After Pay Grade(발령후 직급)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
                if (e.Row["JOB_CATEGORY_ID"] == DBNull.Value)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=After Job Category(발령후 직구분)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
                if (e.Row["FLOOR_ID"] == DBNull.Value)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=After Floor(발령후 작업장)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
                // 발령전 정보
                if (e.Row["PRE_OPERATING_UNIT_ID"] == DBNull.Value)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Before Operating Unit(발령전 사업장)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
                if (e.Row["PRE_DEPT_ID"] == DBNull.Value)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Before Department(발령전 부서)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
                if (e.Row["PRE_JOB_CLASS_ID"] == DBNull.Value)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Before Job Class(발령전 직군)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
                if (e.Row["PRE_JOB_ID"] == DBNull.Value)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Before Job(발령전 직종)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
                if (e.Row["PRE_POST_ID"] == DBNull.Value)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Before Post(발령전 직위)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
                if (e.Row["PRE_OCPT_ID"] == DBNull.Value)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Before Ocpt(발령전 직무)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
                if (e.Row["PRE_ABIL_ID"] == DBNull.Value)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Before Abil(발령전 직책)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
                if (e.Row["PRE_PAY_GRADE_ID"] == DBNull.Value)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Before Pay Grade(발령전 직급)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
                if (e.Row["PRE_JOB_CATEGORY_ID"] == DBNull.Value)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Before Job Category(발령전 직구분)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
                if (e.Row["PRE_FLOOR_ID"] == DBNull.Value)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Before Floor(발령전 작업장)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        #endregion

        #region ----- Lookup Parameter -----

        private void isSetCommonLookUpParameter(string P_GROUP_CODE, string P_CODE_NAME, string P_ENABLED_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", P_GROUP_CODE);
            ildCOMMON.SetLookupParamValue("W_CODE_NAME", P_CODE_NAME);
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", P_ENABLED_YN);
        }

        #endregion

        #region ----- LookUp PopupShow Event -----

        private void ilaDEPT_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT_0.SetLookupParamValue("W_DEPT_LEVEL", DBNull.Value);
            ildDEPT_0.SetLookupParamValue("W_USABLE_CHECK_YN", "N");
        }

        private void ilaCHARGE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("CHARGE", null, "N");
        }

        private void ilaPERSON_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildPERSON_0.SetLookupParamValue("W_NAME", DBNull.Value);
        }

        private void ilaPERSON_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildPERSON.SetLookupParamValue("W_NAME", DBNull.Value);
        }
                
        private void ilaCHARGE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("CHARGE", null, "Y");
        }

        private void ilaRETIRE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("RETIRE", null, "Y");
        }

        private void ilaDEPT_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT.SetLookupParamValue("W_DEPT_LEVEL", DBNull.Value);
            ildDEPT.SetLookupParamValue("W_USABLE_CHECK_YN", "Y");
        }

        private void ilaOPERATING_UNIT_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildOPERATING_UNIT.SetLookupParamValue("W_OPERATING_UNIT_NAME", DBNull.Value);
            ildOPERATING_UNIT.SetLookupParamValue("W_USABLE_CHECK_YN", "Y");
        }

        private void ilaJOB_CLASS_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("JOB_CLASS", null, "Y");
        }

        private void ilaJOB_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("JOB", null, "Y");
        }

        private void ilaPOST_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("POST", null, "Y");
        }

        private void ilaOCPT_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("OCPT", null, "Y");
        }

        private void ilaABIL_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("ABIL", null, "Y");
        }

        private void ilaPAY_GRADE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("PAY_GRADE", null, "Y");
        }

        private void ilaJOB_CATEGORY_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("JOB_CATEGORY", null, "Y");
        }

        private void ilaFLOOR_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("FLOOR", null, "Y");
        }

        private void ilaPERSON_SelectedRowData(object pSender)
        {
            SendKeys.Send("{TAB}");
        }

        #endregion 

        #region ----- Edit Event -----

        private void iedSTART_DATE_0_EditValueChanged(object pSender)
        {
            try
            {
                System.DateTime vDate = iedSTART_DATE_0.DateTimeValue;
                iedEND_DATE_0.EditValue = iDate.ISMonth_Last(vDate);

            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        #endregion
    }
}