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

namespace FCMF0110
{
    public partial class FCMF0110 : Office2007Form
    {
        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        public FCMF0110(Form pMainForm, ISAppInterface pAppInterface)
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

        private void Init_Account_Group_Insert()
        {
            Init_Account_Group_Column();            
            igrACCOUNT_GROUP.SetCellValue("ENABLED_FLAG", "Y");
            igrACCOUNT_GROUP.SetCellValue("EFFECTIVE_DATE_FR", iDate.ISMonth_1st(DateTime.Today));

            Init_Account_Control_Insert();
            
            // 그리드 처음 으로 포커스 이동.
            itbACCOUNT_GROUP.SelectedIndex = 0;
            itbACCOUNT_GROUP.SelectedTab.Focus();

            igrACCOUNT_GROUP.CurrentCellMoveTo(igrACCOUNT_GROUP.GetColumnToIndex("SEGMENT1_CODE"));
            igrACCOUNT_GROUP.Focus();
        }

        private void Init_Account_Control_Insert()
        {            
            ENABLED_FLAG.CheckBoxValue = "Y";
            EFFECTIVE_DATE_FR.EditValue = iDate.ISMonth_1st(DateTime.Today);
        }

        private void Init_Account_Group_Column()
        {
            int mStart_Column;

            int mMin_Column;
            int mMax_Column = 22;
            mMin_Column = (Convert.ToInt32(ACCOUNT_LEVEL.EditValue)) * 2;

            for (mStart_Column = 2; mStart_Column < mMin_Column; mStart_Column++)
            {
                igrACCOUNT_GROUP.GridAdvExColElement[mStart_Column].Visible = (int)1;
            }

            for (mStart_Column = mMin_Column; mStart_Column < mMax_Column; mStart_Column++)
            {
                igrACCOUNT_GROUP.GridAdvExColElement[mStart_Column].Visible = (int)0;

                for (int R = 0; R < igrACCOUNT_GROUP.RowCount; R++)
                {
                    if (iString.ISNull(igrACCOUNT_GROUP.GetCellValue(R, mStart_Column)) != string.Empty)
                    {
                        igrACCOUNT_GROUP.SetCellValue(R, mStart_Column, String.Empty);
                    }
                }
            }
            igrACCOUNT_GROUP.ResetDraw = true;
        }

        private void Insert_Account_Control_Item_DR()
        {
            DR_ACCOUNT_DR_CR.EditValue = DR_ACCOUNT_DR_CR_0.EditValue;
        }

        private void Insert_Account_Control_Item_CR()
        {
            CR_ACCOUNT_DR_CR.EditValue = CR_ACCOUNT_DR_CR_0.EditValue;
        }

        private void isSetCommonParameter(string pGroup_Code, string pEnabled_Flag)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_Flag);
        }

        private void SEARCH_DB()
        {            
            idaACCOUNT_SET.Fill();
            ACCOUNT_SET_ID.Focus();
            Init_Account_Group_Column();
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
                    if (idaACCOUNT_SET.IsFocused)
                    {
                        idaACCOUNT_SET.AddOver();
                    }
                    else if (idaACCOUNT_CONTROL.IsFocused)
                    {
                        idaACCOUNT_CONTROL.AddOver();
                        Init_Account_Control_Insert();
                    }
                    else if (idaACCOUNT_CONTROL_ITEM_DR.IsFocused)
                    {
                        idaACCOUNT_CONTROL_ITEM_DR.AddOver();
                        Insert_Account_Control_Item_DR();
                    }
                    else if (idaACCOUNT_CONTROL_ITEM_CR.IsFocused)
                    {
                        idaACCOUNT_CONTROL_ITEM_CR.AddOver();
                        Insert_Account_Control_Item_CR();
                    }
                    else
                    {
                        idaACCOUNT_GROUP.AddOver();
                        idaACCOUNT_CONTROL.AddOver();
                        Init_Account_Group_Insert();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaACCOUNT_SET.IsFocused)
                    {
                        idaACCOUNT_SET.AddUnder();
                    }
                    else if (idaACCOUNT_CONTROL.IsFocused)
                    {
                        idaACCOUNT_CONTROL.AddUnder();
                        Init_Account_Control_Insert();
                    }
                    else if (idaACCOUNT_CONTROL_ITEM_DR.IsFocused)
                    {
                        idaACCOUNT_CONTROL_ITEM_DR.AddUnder();
                        Insert_Account_Control_Item_DR();
                    }
                    else if (idaACCOUNT_CONTROL_ITEM_CR.IsFocused)
                    {
                        idaACCOUNT_CONTROL_ITEM_CR.AddUnder();
                        Insert_Account_Control_Item_CR();
                    }
                    else
                    {
                        idaACCOUNT_GROUP.AddUnder();
                        idaACCOUNT_CONTROL.AddUnder();
                        Init_Account_Group_Insert();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    idaACCOUNT_SET.Update();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaACCOUNT_SET.IsFocused)
                    {
                        idaACCOUNT_SET.Cancel();
                    }
                    else if (idaACCOUNT_CONTROL.IsFocused)
                    {
                        idaACCOUNT_CONTROL.Cancel();
                    }
                    else if (idaACCOUNT_CONTROL_ITEM_DR.IsFocused)
                    {
                        idaACCOUNT_CONTROL_ITEM_DR.Cancel();
                    }
                    else if (idaACCOUNT_CONTROL_ITEM_CR.IsFocused)
                    {
                        idaACCOUNT_CONTROL_ITEM_CR.Cancel();
                    }
                    else 
                    {
                        idaACCOUNT_CONTROL.Cancel();
                        idaACCOUNT_GROUP.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaACCOUNT_SET.IsFocused)
                    {
                        idaACCOUNT_SET.Delete();
                    }
                    else if (idaACCOUNT_CONTROL.IsFocused)
                    {
                        idaACCOUNT_CONTROL.Delete();
                    }
                    else if (idaACCOUNT_CONTROL_ITEM_DR.IsFocused)
                    {
                        idaACCOUNT_CONTROL_ITEM_DR.Delete();
                    }
                    else if (idaACCOUNT_CONTROL_ITEM_CR.IsFocused)
                    {
                        idaACCOUNT_CONTROL_ITEM_CR.Delete();
                    }
                    else
                    {
                        idaACCOUNT_CONTROL.Delete();
                        idaACCOUNT_GROUP.Delete();                        
                    }
                }
            }
        }

        #endregion

        #region ----- Form Event -----
        private void FCMF0110_Load(object sender, EventArgs e)
        {
            idaACCOUNT_SET.FillSchema();
            Init_Account_Group_Column();
        }

        private void ACCOUNT_LEVEL_CurrentEditValidating(object pSender, ISEditAdvValidatingEventArgs e)
        {
            if (idaACCOUNT_SET.CurrentRow.RowState == DataRowState.Added)
            {
                DialogResult mChoiceValue;
                mChoiceValue = MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10085"), "Question", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2);
                if (mChoiceValue == DialogResult.No)
                {// 작업 취소.
                    ACCOUNT_SET_NAME.Focus();
                    return;
                }
                igrACCOUNT_GROUP.Focus();
                Init_Account_Group_Column();
            }
        }

        private void igrACCOUNT_GROUP_CurrentCellValidated(object pSender, ISGridAdvExValidatedEventArgs e)
        {
            if (iString.ISNull(EFFECTIVE_DATE_FR.EditValue) == string.Empty && iString.ISNull(igrACCOUNT_GROUP.GetColumnToIndex("EFFECTIVE_DATE_FR")) != string.Empty)
            {
                if (e.ColIndex == igrACCOUNT_GROUP.GetColumnToIndex("EFFECTIVE_DATE_FR"))
                {
                    EFFECTIVE_DATE_FR.EditValue = igrACCOUNT_GROUP.GetCellValue("EFFECTIVE_DATE_FR");
                }
            }
            if (iString.ISNull(EFFECTIVE_DATE_TO.EditValue) == string.Empty && iString.ISNull(igrACCOUNT_GROUP.GetColumnToIndex("EFFECTIVE_DATE_TO")) != string.Empty)
            {
                if (e.ColIndex == igrACCOUNT_GROUP.GetColumnToIndex("EFFECTIVE_DATE_TO"))
                {
                    EFFECTIVE_DATE_TO.EditValue = igrACCOUNT_GROUP.GetCellValue("EFFECTIVE_DATE_TO");
                }
            }
        }

        private void igrACCOUNT_GROUP_CellKeyDown(object pSender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Tab)
            {
                if (igrACCOUNT_GROUP.GetColumnToIndex("EFFECTIVE_DATE_TO") == igrACCOUNT_GROUP.ColIndex
                    && igrACCOUNT_GROUP.RowCount == igrACCOUNT_GROUP.RowIndex + 1)
                {
                    itbACCOUNT_GROUP.SelectedIndex = 1;
                    itbACCOUNT_GROUP.SelectedTab.Focus();

                    ACCOUNT_DESC_S.Focus();
                }
            }
        }
        #endregion

        #region ----- Adapter Event -----

        private void idaACCOUNT_SET_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (e.Row["ACCOUNT_SET_ID"] == DBNull.Value)
            {// 계정SET ID
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10086", "&&VALUE:=Account Set ID(계정 세트ID)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["ACCOUNT_SET_CODE"]) == string.Empty)
            {// 계정세트코드
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10086", "&&VALUE:=Account Set Code(계정 세트코드)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["ACCOUNT_SET_NAME"]) == string.Empty)
            {// 계정세트명
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10086", "&&VALUE:=Account Set Name(계정 세트명)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["ACCOUNT_LEVEL"] == DBNull.Value)
            {// 계정세트레벨
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10086", "&&VALUE:=Account Level(계정 세트 레벨)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }            
        }

        private void idaACCOUNT_SET_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:=Data(해당 자료)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
                e.Cancel = true;
                return;
            }
        }

        private void idaACCOUNT_GROUP_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (ACCOUNT_LEVEL.EditValue == null)
            {// 계정세트레벨
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10087", "&&VALUE:=Account Level(계정 세트 레벨)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["ACCOUNT_CODE"]) == string.Empty)
            {// 계정코드
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10087", "&&VALUE:=Account Code(계정 코드)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["ACCOUNT_DESC"]) == string.Empty)
            {// 계정명
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10087", "&&VALUE:=Account Desc(계정명)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (2 <= Convert.ToInt32(ACCOUNT_LEVEL.EditValue))
            {
                if (iString.ISNull(e.Row["SEGMENT1_CODE"]) == string.Empty)
                {// 세그먼트코드1
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10087", "&&VALUE:=Segment1 Code(세그먼트1 코드)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
                if (iString.ISNull(e.Row["SEGMENT1_DESC"]) == string.Empty)
                {// 세그먼트명1
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10087", "&&VALUE:=Segment1 Desc(세그먼트1명)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
            }
            if (3 <= Convert.ToInt32(ACCOUNT_LEVEL.EditValue))
            {
                if (iString.ISNull(e.Row["SEGMENT2_CODE"]) == string.Empty)
                {// 세그먼트코드2
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10087", "&&VALUE:=Segment2 Code(세그먼트2 코드)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
                if (iString.ISNull(e.Row["SEGMENT2_DESC"]) == string.Empty)
                {// 세그먼트명2
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10087", "&&VALUE:=Segment2 Desc(세그먼트2명)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
            }
            if (4 <= Convert.ToInt32(ACCOUNT_LEVEL.EditValue))
            {
                if (iString.ISNull(e.Row["SEGMENT3_CODE"]) == string.Empty)
                {// 세그먼트코드3
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10087", "&&VALUE:=Segment3 Code(세그먼트3 코드)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
                if (iString.ISNull(e.Row["SEGMENT3_DESC"]) == string.Empty)
                {// 세그먼트명3
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10087", "&&VALUE:=Segment3 Desc(세그먼트3명)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
            }
            if (5 <= Convert.ToInt32(ACCOUNT_LEVEL.EditValue))
            {
                if (iString.ISNull(e.Row["SEGMENT4_CODE"]) == string.Empty)
                {// 세그먼트코드4
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10087", "&&VALUE:=Segment4 Code(세그먼트4 코드)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
                if (iString.ISNull(e.Row["SEGMENT4_DESC"]) == string.Empty)
                {// 세그먼트명4
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10087", "&&VALUE:=Segment4 Desc(세그먼트4명)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
            }
            if (6 <= Convert.ToInt32(ACCOUNT_LEVEL.EditValue))
            {
                if (iString.ISNull(e.Row["SEGMENT5_CODE"]) == string.Empty)
                {// 세그먼트코드5
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10087", "&&VALUE:=Segment5 Code(세그먼트5 코드)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
                if (iString.ISNull(e.Row["SEGMENT5_DESC"]) == string.Empty)
                {// 세그먼트명5
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10087", "&&VALUE:=Segment5 Desc(세그먼트5명)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
            }
            if (7 <= Convert.ToInt32(ACCOUNT_LEVEL.EditValue))
            {
                if (iString.ISNull(e.Row["SEGMENT6_CODE"]) == string.Empty)
                {// 세그먼트코드6
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10087", "&&VALUE:=Segment6 Code(세그먼트6 코드)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
                if (iString.ISNull(e.Row["SEGMENT6_DESC"]) == string.Empty)
                {// 세그먼트명6
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10087", "&&VALUE:=Segment6 Desc(세그먼트6명)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
            }
            if (8 <= Convert.ToInt32(ACCOUNT_LEVEL.EditValue))
            {
                if (iString.ISNull(e.Row["SEGMENT7_CODE"]) == string.Empty)
                {// 세그먼트코드7
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10087", "&&VALUE:=Segment7 Code(세그먼트7 코드)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
                if (iString.ISNull(e.Row["SEGMENT7_DESC"]) == string.Empty)
                {// 세그먼트명7
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10087", "&&VALUE:=Segment7 Desc(세그먼트7명)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
            }
            if (9 <= Convert.ToInt32(ACCOUNT_LEVEL.EditValue))
            {
                if (iString.ISNull(e.Row["SEGMENT8_CODE"]) == string.Empty)
                {// 세그먼트코드8
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10087", "&&VALUE:=Segment8 Code(세그먼트8 코드)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
                if (iString.ISNull(e.Row["SEGMENT8_DESC"]) == string.Empty)
                {// 세그먼트명8
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10087", "&&VALUE:=Segment8 Desc(세그먼트8명)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
            }
            if (10 <= Convert.ToInt32(ACCOUNT_LEVEL.EditValue))
            {
                if (iString.ISNull(e.Row["SEGMENT9_CODE"]) == string.Empty)
                {// 세그먼트코드9
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10087", "&&VALUE:=Segment9 Code(세그먼트9 코드)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
                if (iString.ISNull(e.Row["SEGMENT9_DESC"]) == string.Empty)
                {// 세그먼트명9
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10087", "&&VALUE:=Segment9 Desc(세그먼트9명)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
            }
            if (11 <= Convert.ToInt32(ACCOUNT_LEVEL.EditValue))
            {
                if (iString.ISNull(e.Row["SEGMENT10_CODE"]) == string.Empty)
                {// 세그먼트코드10
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10087", "&&VALUE:=Segment10 Code(세그먼트10 코드)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
                if (iString.ISNull(e.Row["SEGMENT10_DESC"]) == string.Empty)
                {// 세그먼트명10
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10087", "&&VALUE:=Segment10 Desc(세그먼트10명)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
            }
            if (e.Row["EFFECTIVE_DATE_FR"] == DBNull.Value)
            {// 적용 시작일자.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10087", "&&VALUE:=Effective Date From(적용 시작일자)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaACCOUNT_GROUP_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:=Data(해당 자료)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
                e.Cancel = true;
                return;
            }
        }

        private void idaACCOUNT_CONTROL_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["ACCOUNT_DR_CR"]) == string.Empty)
            {// 차대구분
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10088", "&&VALUE:=Account DR/CR(차대 구분)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (e.Row["EFFECTIVE_DATE_FR"] == DBNull.Value)
            {// 적용 시작일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10088", "&&VALUE:=Effective Date From(적용 시작일자)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (Convert.ToString(e.Row["ACCOUNT_MICH_YN"]) == "Y" && iString.ISNull(e.Row["LIQUIDATE_METHOD_TYPE"]) == string.Empty)
            {// 미청산 항목 --> 반제처리 방법 선택.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10102"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;                
            }
            if (Convert.ToString(e.Row["ACCOUNT_MICH_YN"]) == "N" && iString.ISNull(e.Row["LIQUIDATE_METHOD_TYPE"]) != string.Empty)
            {// 미청산 항목 --> 반제처리 방법 선택.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10103"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;                
            }
        }

        private void idaACCOUNT_CONTROL_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:=Data(해당 자료)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
                e.Cancel = true;
                return;
            }
        }

        private void idaACCOUNT_CONTROL_ITEM_DR_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["ACCOUNT_DR_CR"]) == String.Empty)
            {// 차대구분
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10087", "&&VALUE:=Account DR/CR(차대구분)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }            

            ////////////////
            if (e.Row["MANAGEMENT1_ID"] == DBNull.Value && e.Row["MANAGEMENT1_YN"].ToString() == "Y".ToString())
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Balance Management1(잔액관리1)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["MANAGEMENT2_ID"] == DBNull.Value && e.Row["MANAGEMENT2_YN"].ToString() == "Y".ToString())
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Balance Management2(잔액관리2)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (e.Row["REFER1_ID"] == DBNull.Value && e.Row["REFER1_YN"].ToString() == "Y".ToString())
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Refer Item1(참고사항1)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (e.Row["REFER2_ID"] == DBNull.Value && e.Row["REFER2_YN"].ToString() == "Y".ToString())
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Refer Item2(참고사항2)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (e.Row["REFER3_ID"] == DBNull.Value && e.Row["REFER3_YN"].ToString() == "Y".ToString())
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Refer Item3(참고사항3)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (e.Row["REFER4_ID"] == DBNull.Value && e.Row["REFER4_YN"].ToString() == "Y".ToString())
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Refer Item4(참고사항4)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (e.Row["REFER5_ID"] == DBNull.Value && e.Row["REFER5_YN"].ToString() == "Y".ToString())
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Refer Item5(참고사항5)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (e.Row["REFER6_ID"] == DBNull.Value && e.Row["REFER6_YN"].ToString() == "Y".ToString())
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Refer Item6(참고사항6)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (e.Row["REFER7_ID"] == DBNull.Value && e.Row["REFER7_YN"].ToString() == "Y".ToString())
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Refer Item7(참고사항7)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (e.Row["REFER8_ID"] == DBNull.Value && e.Row["REFER8_YN"].ToString() == "Y".ToString())
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Refer Item8(참고사항8)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (e.Row["REFER9_ID"] == DBNull.Value && e.Row["REFER9_YN"].ToString() == "Y".ToString())
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Refer Item9(참고사항9)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (e.Row["REFER_RATE_ID"] == DBNull.Value && e.Row["REFER_RATE_YN"].ToString() == "Y".ToString())
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Management Rate(관리율)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (e.Row["REFER_AMOUNT_ID"] == DBNull.Value && e.Row["REFER_AMOUNT_YN"].ToString() == "Y".ToString())
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Management Amount(관리 금액)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (e.Row["REFER_DATE1_ID"] == DBNull.Value && e.Row["REFER_DATE1_YN"].ToString() == "Y".ToString())
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Management Date1(관리일자1)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (e.Row["REFER_DATE2_ID"] == DBNull.Value && e.Row["REFER_DATE2_YN"].ToString() == "Y".ToString())
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Management Date2(관리일자2)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            //if (e.Row["VOUCH_ID"] == DBNull.Value && e.Row["VOUCH_YN"].ToString() == "Y".ToString())
            //{
            //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Vouch Y/N(증빙 유무)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    e.Cancel = true;
            //    return;
            //}
            /////////////////////////////////////
            
            if (e.Row["MANAGEMENT1_ID"] == DBNull.Value && e.Row["MANAGEMENT2_ID"] != DBNull.Value)
            {// 계정코드
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10087", "&&VALUE:=Balance Management1(잔액관리1)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (e.Row["REFER1_ID"] == DBNull.Value && e.Row["REFER2_ID"] != DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10089"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["REFER2_ID"] == DBNull.Value && e.Row["REFER3_ID"] != DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10089"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["REFER3_ID"] == DBNull.Value && e.Row["REFER4_ID"] != DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10089"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["REFER4_ID"] == DBNull.Value && e.Row["REFER5_ID"] != DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10089"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["REFER5_ID"] == DBNull.Value && e.Row["REFER6_ID"] != DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10089"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["REFER6_ID"] == DBNull.Value && e.Row["REFER7_ID"] != DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10089"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["REFER7_ID"] == DBNull.Value && e.Row["REFER8_ID"] != DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10089"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["REFER8_ID"] == DBNull.Value && e.Row["REFER9_ID"] != DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10089"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaACCOUNT_CONTROL_ITEM_DR_PreDelete(ISPreDeleteEventArgs e)
        {

        }

        private void idaACCOUNT_CONTROL_ITEM_CR_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["ACCOUNT_DR_CR"]) == String.Empty)
            {// 차대구분
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10087", "&&VALUE:=Account DR/CR(차대구분)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            ////////////////
            if (e.Row["MANAGEMENT1_ID"] == DBNull.Value && e.Row["MANAGEMENT1_YN"].ToString() == "Y".ToString())
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Balance Management1(잔액관리1)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["MANAGEMENT2_ID"] == DBNull.Value && e.Row["MANAGEMENT2_YN"].ToString() == "Y".ToString())
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Balance Management2(잔액관리2)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (e.Row["REFER1_ID"] == DBNull.Value && e.Row["REFER1_YN"].ToString() == "Y".ToString())
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Refer Item1(참고사항1)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (e.Row["REFER2_ID"] == DBNull.Value && e.Row["REFER2_YN"].ToString() == "Y".ToString())
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Refer Item2(참고사항2)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (e.Row["REFER3_ID"] == DBNull.Value && e.Row["REFER3_YN"].ToString() == "Y".ToString())
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Refer Item3(참고사항3)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (e.Row["REFER4_ID"] == DBNull.Value && e.Row["REFER4_YN"].ToString() == "Y".ToString())
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Refer Item4(참고사항4)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (e.Row["REFER5_ID"] == DBNull.Value && e.Row["REFER5_YN"].ToString() == "Y".ToString())
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Refer Item5(참고사항5)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (e.Row["REFER6_ID"] == DBNull.Value && e.Row["REFER6_YN"].ToString() == "Y".ToString())
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Refer Item6(참고사항6)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (e.Row["REFER7_ID"] == DBNull.Value && e.Row["REFER7_YN"].ToString() == "Y".ToString())
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Refer Item7(참고사항7)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (e.Row["REFER8_ID"] == DBNull.Value && e.Row["REFER8_YN"].ToString() == "Y".ToString())
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Refer Item8(참고사항8)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (e.Row["REFER9_ID"] == DBNull.Value && e.Row["REFER9_YN"].ToString() == "Y".ToString())
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Refer Item9(참고사항9)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (e.Row["REFER_RATE_ID"] == DBNull.Value && e.Row["REFER_RATE_YN"].ToString() == "Y".ToString())
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Management Rate(관리율)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (e.Row["REFER_AMOUNT_ID"] == DBNull.Value && e.Row["REFER_AMOUNT_YN"].ToString() == "Y".ToString())
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Management Amount(관리 금액)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (e.Row["REFER_DATE1_ID"] == DBNull.Value && e.Row["REFER_DATE1_YN"].ToString() == "Y".ToString())
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Management Date1(관리일자1)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (e.Row["REFER_DATE2_ID"] == DBNull.Value && e.Row["REFER_DATE2_YN"].ToString() == "Y".ToString())
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Management Date2(관리일자2)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            //if (e.Row["VOUCH_ID"] == DBNull.Value && e.Row["VOUCH_YN"].ToString() == "Y".ToString())
            //{
            //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Vouch Y/N(증빙 유무)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    e.Cancel = true;
            //    return;
            //}
            /////////////////////////////////////

            if (e.Row["MANAGEMENT1_ID"] == DBNull.Value && e.Row["MANAGEMENT2_ID"] != DBNull.Value)
            {// 계정코드
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10087", "&&VALUE:=Balance Management1(잔액관리1)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (e.Row["REFER1_ID"] == DBNull.Value && e.Row["REFER2_ID"] != DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10089"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["REFER2_ID"] == DBNull.Value && e.Row["REFER3_ID"] != DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10089"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["REFER3_ID"] == DBNull.Value && e.Row["REFER4_ID"] != DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10089"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["REFER4_ID"] == DBNull.Value && e.Row["REFER5_ID"] != DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10089"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["REFER5_ID"] == DBNull.Value && e.Row["REFER6_ID"] != DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10089"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["REFER6_ID"] == DBNull.Value && e.Row["REFER7_ID"] != DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10089"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["REFER7_ID"] == DBNull.Value && e.Row["REFER8_ID"] != DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10089"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["REFER8_ID"] == DBNull.Value && e.Row["REFER9_ID"] != DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10089"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaACCOUNT_CONTROL_ITEM_CR_PreDelete(ISPreDeleteEventArgs e)
        {

        }

        private void idaACCOUNT_SET_NewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            Init_Account_Group_Column();
        }

        private void idaACCOUNT_SET_ExcuteKeySearch(object pSender)
        {
            SEARCH_DB();
        }

        #endregion
        
        #region ----- Lookup Event -----

        private void ilaACCOUNT_DR_CR_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonParameter("ACCOUNT_DR_CR", "Y");
        }

        private void ilaGL_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonParameter("GL_TYPE", "Y");
        }

        private void ilaFS_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonParameter("FORM_TYPE", "Y");
        }

        private void ilaLIQUIDATE_METHOD_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonParameter("LIQUIDATE_METHOD_TYPE", "Y");
        }

        private void ilaACCOUNT_CLASS_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonParameter("ACCOUNT_CLASS", "Y");
        }

        private void ilaBALANCE_MANAGEMENT_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonParameter("MANAGEMENT_CODE", "Y");
        }

        private void ilaREFER_ITEM_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonParameter("MANAGEMENT_CODE", "Y");
        }

        private void ilaREFER_RATE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonParameter("REFERENCE_RATE", "Y");
        }

        private void ilaREFER_AMOUNT_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonParameter("REFERENCE_AMOUNT", "Y");
        }

        private void ilaREFER_DATE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonParameter("REFERENCE_DATE", "Y");
        }

        private void ilaVOUCH_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonParameter("VOUCH_CODE", "Y");
        }

        #endregion
    }
}