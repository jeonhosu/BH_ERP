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

namespace HRMF0203
{
    public partial class HRMF0203 : Office2007Form
    {
        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        public HRMF0203(Form pMainForm, ISAppInterface pAppInterface)
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

        private void SEARCH_DB()
        {
            if (CORP_ID_0.EditValue == null)
            {// 업체 선택
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME_0.Focus();
                return;
            }
            if (iedSTART_DATE_0.EditValue == null)
            {// 적용년월
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                iedSTART_DATE_0.Focus();
                return;
            }
            if (iedEND_DATE_0.EditValue == null)
            {// 적용년월
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
            idaHISTORY_HEADER.SetSelectParamValue("W_SOB_ID", isAppInterfaceAdv1.SOB_ID);
            idaHISTORY_HEADER.SetSelectParamValue("W_ORG_ID", isAppInterfaceAdv1.ORG_ID);
            idaHISTORY_HEADER.Fill();
            igrHEADER.Focus();
        }

        private void SEARCH_SUB_DB()
        {

            if (igrHEADER.GetCellValue("HISTORY_HEADER_ID") == null)
            {
                idaHISTORY_LINE.SetSelectParamValue("W_HISTORY_HEADER_ID", 0);
            }
            else
            {
                idaHISTORY_LINE.SetSelectParamValue("W_HISTORY_HEADER_ID", igrHEADER.GetCellValue("HISTORY_HEADER_ID"));
                History_Info();             // 발령 기초 정보 설정.
            }            
            idaHISTORY_LINE.Fill();
        }

        private void History_Info()
        {
            iedHISTORY_NUM.EditValue = igrHEADER.GetCellValue("HISTORY_NUM");
            iedCHARGE_DATE.EditValue = igrHEADER.GetCellValue("CHARGE_DATE");
            iedCHARGE_NAME.EditValue = igrHEADER.GetCellValue("CHARGE_NAME");
            iedDESCRIPTION.EditValue = igrHEADER.GetCellValue("DESCRIPTION");
        }

        private bool iNewcomer_Check()
        {
            ISCommonUtil.ISFunction.ISConvert iConvert = new ISCommonUtil.ISFunction.ISConvert();
            if (iConvert.ISNull(igrHEADER.GetCellValue("NEWCOMER_YN")) == "Y")
            {
                return true;
            }
            return false;
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
                    if (idaHISTORY_HEADER.IsFocused)
                    {
                        idaHISTORY_HEADER.AddOver();
                        igrHEADER.CurrentCellMoveTo(3);
                        igrHEADER.Focus();
                    }
                    else if (idaHISTORY_LINE.IsFocused)
                    {
                        idaHISTORY_LINE.AddOver();

                        igrLINE.SetCellValue("HISTORY_HEADER_ID", igrHEADER.GetCellValue("HISTORY_HEADER_ID"));
                        igrLINE.SetCellValue("HISTORY_NUM", igrHEADER.GetCellValue("HISTORY_NUM"));
                        igrLINE.SetCellValue("CHARGE_DATE", igrHEADER.GetCellValue("CHARGE_DATE"));
                        igrLINE.SetCellValue("CHARGE_ID", igrHEADER.GetCellValue("CHARGE_ID"));
                        igrLINE.SetCellValue("CHARGE_NAME", igrHEADER.GetCellValue("CHARGE_NAME"));

                        icbPRINT_YN.CheckedState = ISUtil.Enum.CheckedState.Checked;

                        igrLINE.CurrentCellMoveTo(4);
                        igrLINE.Focus();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaHISTORY_HEADER.IsFocused)
                    {
                        idaHISTORY_HEADER.AddUnder();
                        igrHEADER.CurrentCellMoveTo(3);
                        igrHEADER.Focus();
                    }
                    else if (idaHISTORY_LINE.IsFocused)
                    {
                        idaHISTORY_LINE.AddUnder();

                        igrLINE.SetCellValue("HISTORY_HEADER_ID", igrHEADER.GetCellValue("HISTORY_HEADER_ID"));
                        igrLINE.SetCellValue("HISTORY_NUM", igrHEADER.GetCellValue("HISTORY_NUM"));
                        igrLINE.SetCellValue("CHARGE_DATE", igrHEADER.GetCellValue("CHARGE_DATE"));
                        igrLINE.SetCellValue("CHARGE_ID", igrHEADER.GetCellValue("CHARGE_ID"));
                        igrLINE.SetCellValue("CHARGE_NAME", igrHEADER.GetCellValue("CHARGE_NAME"));

                        icbPRINT_YN.CheckedState = ISUtil.Enum.CheckedState.Checked;

                        igrLINE.CurrentCellMoveTo(4);
                        igrLINE.Focus();
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
        private void HRMF0203_Load(object sender, EventArgs e)
        {
            DateTime pStart_Date = DateTime.Parse(DateTime.Today.Year.ToString() + "-" + DateTime.Today.Month.ToString() + "-01".ToString());
            DateTime pEnd_Date = DateTime.Today;

            idaHISTORY_HEADER.FillSchema();
            idaHISTORY_LINE.FillSchema();

            iedSTART_DATE_0.EditValue = pStart_Date;
            iedEND_DATE_0.EditValue = pEnd_Date;

            DefaultCorporation();
            //DefaultSetFormReSize();		//[Child Form, Mdi Form에 맞게 ReSize]
        }
        #endregion

        #region ------ Adapter Event -----
        private void idaHISTORY_HEADER_PreRowUpdate(ISPreRowUpdateEventArgs e)
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

        private void idaHISTORY_HEADER_PreDelete(ISPreDeleteEventArgs e)
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

        private void idaHISTORY_LINE_PreRowUpdate(ISPreRowUpdateEventArgs e)
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

        private void idaHISTORY_LINE_PreDelete(ISPreDeleteEventArgs e)
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
        #endregion        
    }
}