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

namespace FCMF0882
{
    public partial class FCMF0882 : Office2007Form
    {
        #region ----- Variables -----

        private ISFunction.ISConvert iString = new ISFunction.ISConvert();
        private ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public FCMF0882()
        {
            InitializeComponent();
        }

        public FCMF0882(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
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

        #endregion;

        #region ----- User Methods ----

        private DateTime GetDate()
        {
            DateTime vDateTime = DateTime.Today;

            try
            {
                idcGetDate.ExecuteNonQuery();
                object vObject = idcGetDate.GetCommandParamValue("X_LOCAL_DATE");

                bool isConvert = vObject is DateTime;
                if (isConvert == true)
                {
                    vDateTime = (DateTime)vObject;
                }
            }
            catch (Exception ex)
            {
                string vMessage = ex.Message;
                vDateTime = new DateTime(9999, 12, 31, 23, 59, 59);
            }
            return vDateTime;
        }

        private void SetCommonParameter(object pGroup_Code, object pEnabled_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        }

        private void DefaultValueSet()
        {
            W_PERIOD_YEAR.EditValue = iDate.ISYear(System.DateTime.Today);

            TITLE_14.EditValue = System.DateTime.Today;

            IDC_SET_TAX_CODE.ExecuteNonQuery();
            W_TAX_DESC.EditValue = IDC_SET_TAX_CODE.GetCommandParamValue("O_TAX_DESC");
            W_TAX_CODE.EditValue = IDC_SET_TAX_CODE.GetCommandParamValue("O_TAX_CODE");
        }

        private void SearchDB()
        {
            object vObject1 = W_TAX_DESC.EditValue;
            object vObject2 = W_PERIOD_YEAR.EditValue;
            object vObject3 = W_VAT_REPORT_NM.EditValue;
            if (iString.ISNull(vObject1) == string.Empty || iString.ISNull(vObject2) == string.Empty || iString.ISNull(vObject3) == string.Empty)
            {
                //사업장, 과세년도, 신고기간구분은 필수 입니다.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10366"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            if (iString.ISNull(W_VAT_MAKE_GB.EditValue) == string.Empty)
            {
                //신고구분
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", string.Format("&&FIELD_NAME:={0}", Get_Edit_Prompt(W_VAT_MAKE_GB_DESC))), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            if (iString.ISNull(W_VAT_MAKE_GB.EditValue) == "02" && iString.ISNull(W_MODIFY_DEGREE.EditValue) == string.Empty)
            {
                //수정차수
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10492"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            idaLIST_SURTAX_CARD.Fill();
        }

        private bool IS_CLOSING_YN()
        {
            bool isClosing = false;

            object vObject = W_CLOSING_YN.EditValue;
            if (iString.ISNull(vObject) == string.Empty || iString.ISNull(vObject) == "Y")
            {
                isClosing = true;
                //해당 신고기간의 자료는 마감되어 변경할 수 없습니다.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10365"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }

            return isClosing;
        }

        #endregion;


        #region ----- Territory Get Methods ----

        private int GetTerritory(ISUtil.Enum.TerritoryLanguage pTerritoryEnum)
        {
            int vTerritory = 0;

            switch (pTerritoryEnum)
            {
                case ISUtil.Enum.TerritoryLanguage.Default:
                    vTerritory = 1;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL1_KR:
                    vTerritory = 2;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL2_CN:
                    vTerritory = 3;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL3_VN:
                    vTerritory = 4;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL4_JP:
                    vTerritory = 5;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL5_XAA:
                    vTerritory = 6;
                    break;
            }

            return vTerritory;
        }

        private object Get_Edit_Prompt(InfoSummit.Win.ControlAdv.ISEditAdv pEdit)
        {
            int mIDX = 0;
            object mPrompt = null;
            switch (isAppInterfaceAdv1.AppInterface.OraConnectionInfo.TerritoryLanguage)
            {
                case ISUtil.Enum.TerritoryLanguage.Default:
                    mPrompt = pEdit.PromptTextElement[mIDX].Default;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL1_KR:
                    mPrompt = pEdit.PromptTextElement[mIDX].TL1_KR;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL2_CN:
                    mPrompt = pEdit.PromptTextElement[mIDX].TL2_CN;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL3_VN:
                    mPrompt = pEdit.PromptTextElement[mIDX].TL3_VN;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL4_JP:
                    mPrompt = pEdit.PromptTextElement[mIDX].TL4_JP;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL5_XAA:
                    mPrompt = pEdit.PromptTextElement[mIDX].TL5_XAA;
                    break;
            }
            return mPrompt;
        }

        #endregion;


        #region ----- MDi ToolBar Button Event -----

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
                    if (idaLIST_SURTAX_CARD.IsFocused)
                    {
                        bool isClosing = IS_CLOSING_YN();
                        if (isClosing == false)
                        {
                            idaLIST_SURTAX_CARD.Update();
                        }
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaLIST_SURTAX_CARD.IsFocused)
                    {
                        idaLIST_SURTAX_CARD.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {

                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {                    
                    XLPrinting_1("PRINT", idaLIST_SURTAX_CARD);
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                    XLPrinting_1("FILE", idaLIST_SURTAX_CARD);
                }
            }
        }

        #endregion;

        #region ----- Form Event ------

        private void FCMF0882_Load(object sender, EventArgs e)
        {
            DefaultValueSet();

            idaLIST_SURTAX_CARD.FillSchema();
            IDA_PRINT_SURTAX_CARD_01.FillSchema();
        }

        #endregion

        #region ----- Lookup Event -----

        private void ILA_VAT_MAKE_GB_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "VAT_MAKE_GB");
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ILA_VAT_MAKE_GB_SelectedRowData(object pSender)
        {
            if (iString.ISNull(W_VAT_MAKE_GB.EditValue) == "02")
            {//수정신고//
                W_MODIFY_DESC.ReadOnly = false;
            }
            else
            {
                W_MODIFY_DESC.EditValue = string.Empty;
                W_MODIFY_DEGREE.EditValue = DBNull.Value;

                W_MODIFY_DESC.ReadOnly = true;
            }
        }

        private void ilaTAX_CODE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("TAX_CODE", "Y");
        }

        private void ilaPOP_VAT_REPORT_MNG_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildPOP_VAT_REPORT_MNG.SetLookupParamValue("W_OPERATING_UNIT_ID", 42);
        }

        private void ilaVAT_CLASS_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("VAT_CLASS", "Y");
        }

        #endregion

        #region ----- Adapter Event ------



        #endregion


        #region ----- Edit Value Changed Event ----

        private void COL09_1_EditValueChanged(object pSender)
        {
            SumAmount_COL09_1();
        }

        private void COL09_2_EditValueChanged(object pSender)
        {
            SumTax_COL09_2();
        }

        private void COL15_1_EditValueChanged(object pSender)
        {
            SumAmount_COL15_1();
        }

        private void COL15_2_EditValueChanged(object pSender)
        {
            SumTax_COL15_2();
        }

        private void P_EXPORT_IMPORT_POSTPONE_VAT_EditValueChanged(object pSender)
        {
            SumTax_COL15_2();
        }

        private void COL17_1_EditValueChanged(object pSender)
        {
            SubAmount_COL17_1();
        }

        private void COL17_2_EditValueChanged(object pSender)
        {
            SubTax_COL17_2();
        }

        private void COL_DA_EditValueChanged(object pSender)
        {
            SubTax_COL_DA();
        }

        private void COL20_2_EditValueChanged(object pSender)
        {
            SumTax_COL20_2();
        }

        private void COL25_EditValueChanged(object pSender)
        {
            SumSubTax_COL25();
        }

        private void COL35_1_EditValueChanged(object pSender)
        {
            SumAmount_COL35_1();
        }

        private void COL35_2_EditValueChanged(object pSender)
        {
            SumTax_COL35_2();
        }

        private void COL38_1_EditValueChanged(object pSender)
        {
            SumAmount_COL38_1();
        }

        private void COL38_2_EditValueChanged(object pSender)
        {
            SumTax_COL38_2();
        }

        private void COL47_1_EditValueChanged(object pSender)
        {
            SumAmount_COL47_1();
        }

        private void COL47_2_EditValueChanged(object pSender)
        {
            SumTax_COL47_2();
        }

        private void COL51_1_EditValueChanged(object pSender)
        {
            SumAmount_COL51_1();
        }

        private void COL51_2_EditValueChanged(object pSender)
        {
            SumTax_COL51_2();
        }

        private void COL57_2_EditValueChanged(object pSender)
        {
            SumTax_COL57_2();
        }

        private void COL68_2_EditValueChanged(object pSender)
        {
            SumTax_COL68_2();
        }

        private void COL30_EditValueChanged(object pSender)
        {
            SumAmount_COL30();
        }

        private void COL72_EditValueChanged(object pSender)
        {
            SumAmount_COL72();
        }

        #endregion;

        #region ----- Sum Mothods ----

        private void SumAmount_COL09_1()
        {
            try
            {
                object vObject_01_1 = COL01_1.EditValue;
                object vObject_02_1 = COL02_1.EditValue;
                object vObject_03_1 = COL03_1.EditValue;
                object vObject_04_1 = COL04_1.EditValue;
                object vObject_05_1 = COL05_1.EditValue;
                object vObject_06_1 = COL06_1.EditValue;
                object vObject_07_1 = COL07_1.EditValue;

                decimal vSumAmount = 0m;

                decimal vDecimal_01_1 = ConvertNumber(vObject_01_1);
                decimal vDecimal_02_1 = ConvertNumber(vObject_02_1);
                decimal vDecimal_03_1 = ConvertNumber(vObject_03_1);
                decimal vDecimal_04_1 = ConvertNumber(vObject_04_1);
                decimal vDecimal_05_1 = ConvertNumber(vObject_05_1);
                decimal vDecimal_06_1 = ConvertNumber(vObject_06_1);
                decimal vDecimal_07_1 = ConvertNumber(vObject_07_1);

                vSumAmount = vDecimal_01_1 + vDecimal_02_1 + vDecimal_03_1 + vDecimal_04_1 + vDecimal_05_1 + vDecimal_06_1 + vDecimal_07_1;
                COL09_1.EditValue = vSumAmount;
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void SumTax_COL09_2()
        {
            try
            {
                object vObject_01_2 = COL01_2.EditValue;
                object vObject_02_2 = COL02_2.EditValue;
                object vObject_03_2 = COL03_2.EditValue;
                object vObject_04_2 = COL04_2.EditValue;
                object vObject_07_2 = COL07_2.EditValue;
                object vObject_08_2 = COL08_2.EditValue;

                decimal vSumTax = 0m;

                decimal vDecimal_01_2 = ConvertNumber(vObject_01_2);
                decimal vDecimal_02_2 = ConvertNumber(vObject_02_2);
                decimal vDecimal_03_2 = ConvertNumber(vObject_03_2);
                decimal vDecimal_04_2 = ConvertNumber(vObject_04_2);
                decimal vDecimal_07_2 = ConvertNumber(vObject_07_2);
                decimal vDecimal_08_2 = ConvertNumber(vObject_08_2);

                vSumTax = vDecimal_01_2 + vDecimal_02_2 + vDecimal_03_2 + vDecimal_04_2 + vDecimal_07_2 + vDecimal_08_2;
                COL09_2.EditValue = vSumTax;
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void SumAmount_COL15_1()
        {
            try
            {
                object vObject_10_1 = COL10_1.EditValue;
                object vObject_11_1 = COL11_1.EditValue;
                object vObject_12_1 = COL12_1.EditValue;
                object vObject_13_1 = COL13_1.EditValue;
                object vObject_14_1 = COL14_1.EditValue;

                decimal vSumAmount = 0m;

                decimal vDecimal_10_1 = ConvertNumber(vObject_10_1);
                decimal vDecimal_11_1 = ConvertNumber(vObject_11_1);
                decimal vDecimal_12_1 = ConvertNumber(vObject_12_1);
                decimal vDecimal_13_1 = ConvertNumber(vObject_13_1);
                decimal vDecimal_14_1 = ConvertNumber(vObject_14_1);

                vSumAmount = vDecimal_10_1 + vDecimal_11_1 + vDecimal_12_1 + vDecimal_13_1 + vDecimal_14_1;
                COL15_1.EditValue = vSumAmount;
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void SumTax_COL15_2()
        {
            try
            {
                object vObject_10_2 = COL10_2.EditValue;
                object vObject_11_2 = COL11_2.EditValue;
                object vObject_12_2 = COL12_2.EditValue;
                object vObject_13_2 = COL13_2.EditValue;
                object vObject_14_2 = COL14_2.EditValue;

                decimal vSumTax = 0m;

                decimal vDecimal_10_2 = ConvertNumber(vObject_10_2);
                decimal vDecimal_10_1_2 = ConvertNumber(P_EXPORT_IMPORT_POSTPONE_VAT.EditValue);
                decimal vDecimal_11_2 = ConvertNumber(vObject_11_2);
                decimal vDecimal_12_2 = ConvertNumber(vObject_12_2);
                decimal vDecimal_13_2 = ConvertNumber(vObject_13_2);
                decimal vDecimal_14_2 = ConvertNumber(vObject_14_2);

                vSumTax = vDecimal_10_2 - vDecimal_10_1_2 + vDecimal_11_2 + vDecimal_12_2 + vDecimal_13_2 + vDecimal_14_2;
                COL15_2.EditValue = vSumTax;
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void SubAmount_COL17_1()
        {
            try
            {
                object vObject_15_1 = COL15_1.EditValue;
                object vObject_16_1 = COL16_1.EditValue;

                decimal vSubAmount = 0m;

                decimal vDecimal_15_1 = ConvertNumber(vObject_15_1);
                decimal vDecimal_16_1 = ConvertNumber(vObject_16_1);

                vSubAmount = vDecimal_15_1 - vDecimal_16_1;
                COL17_1.EditValue = vSubAmount;
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void SubTax_COL17_2()
        {
            try
            {
                object vObject_15_2 = COL15_2.EditValue;
                object vObject_16_2 = COL16_2.EditValue;

                decimal vSubTax = 0m;

                decimal vDecimal_15_2 = ConvertNumber(vObject_15_2);
                decimal vDecimal_16_2 = ConvertNumber(vObject_16_2);

                vSubTax = vDecimal_15_2 - vDecimal_16_2;
                COL17_2.EditValue = vSubTax;
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void SubTax_COL_DA()
        {
            try
            {
                object vObject_09_2 = COL09_2.EditValue;
                object vObject_17_2 = COL17_2.EditValue;

                decimal vSubTax = 0m;

                decimal vDecimal_09_2 = ConvertNumber(vObject_09_2);
                decimal vDecimal_17_2 = ConvertNumber(vObject_17_2);

                vSubTax = vDecimal_09_2 - vDecimal_17_2;
                COL_DA.EditValue = vSubTax;
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void SumTax_COL20_2()
        {
            try
            {
                object vObject_18_2 = COL18_2.EditValue;
                object vObject_19_2 = COL19_2.EditValue;

                decimal vSumTax = 0m;

                decimal vDecimal_18_2 = ConvertNumber(vObject_18_2);
                decimal vDecimal_19_2 = ConvertNumber(vObject_19_2);

                vSumTax = vDecimal_18_2 + vDecimal_19_2;
                COL20_2.EditValue = vSumTax;
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void SumSubTax_COL25()
        {
            try
            {
                object vObject_DA = COL_DA.EditValue;
                object vObject_20_2 = COL20_2.EditValue;
                object vObject_21_2 = COL21_2.EditValue;
                object vObject_22_2 = COL22_2.EditValue;
                object vObject_23_2 = COL23_2.EditValue;
                object vObject_24_2 = COL24_2.EditValue;

                decimal vSumSubTax = 0m;

                decimal vDecimal_DA = ConvertNumber(vObject_DA);
                decimal vDecimal_20_2 = ConvertNumber(vObject_20_2);
                decimal vDecimal_21_2 = ConvertNumber(vObject_21_2);
                decimal vDecimal_22_2 = ConvertNumber(vObject_22_2);
                decimal vDecimal_23_2 = ConvertNumber(vObject_23_2);
                decimal vDecimal_24_2 = ConvertNumber(vObject_24_2);

                

                //2014.1기 추가 
                decimal vPROXY_PAY_TAX_VAT = iString.ISDecimaltoZero(PROXY_PAY_TAX_VAT.EditValue, 0);
                decimal vSPECIAL_PAY_TAX_VAT = iString.ISDecimaltoZero(SPECIAL_PAY_TAX_VAT.EditValue, 0);
                decimal vCARD_AGENT_PAY_TAX_VAT = ConvertNumber(CARD_AGENT_PAY_TAX_VAT.EditValue);
                decimal vSMALL_PB_REDUC_VAT_VAT = ConvertNumber(SMALL_PB_REDUC_VAT_VAT.EditValue);

                vSumSubTax = vDecimal_DA - vDecimal_20_2 - vDecimal_21_2 - vDecimal_22_2 - vDecimal_23_2 - 
                            vPROXY_PAY_TAX_VAT - vSPECIAL_PAY_TAX_VAT - vCARD_AGENT_PAY_TAX_VAT - vSMALL_PB_REDUC_VAT_VAT  + 
                            vDecimal_24_2;
                COL25.EditValue = vSumSubTax;
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void SumAmount_COL35_1()
        {
            try
            {
                object vObject_31_1 = COL31_1.EditValue;
                object vObject_32_1 = COL32_1.EditValue;
                object vObject_33_1 = COL33_1.EditValue;
                object vObject_34_1 = COL34_1.EditValue;

                decimal vSumAmount = 0m;

                decimal vDecimal_31_1 = ConvertNumber(vObject_31_1);
                decimal vDecimal_32_1 = ConvertNumber(vObject_32_1);
                decimal vDecimal_33_1 = ConvertNumber(vObject_33_1);
                decimal vDecimal_34_1 = ConvertNumber(vObject_34_1);

                vSumAmount = vDecimal_31_1 + vDecimal_32_1 + vDecimal_33_1 + vDecimal_34_1;
                COL35_1.EditValue = vSumAmount;
                COL07_1.EditValue = vSumAmount;
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void SumTax_COL35_2()
        {
            try
            {
                object vObject_31_2 = COL31_2.EditValue;
                object vObject_32_2 = COL32_2.EditValue;

                decimal vSumTax = 0m;

                decimal vDecimal_31_2 = ConvertNumber(vObject_31_2);
                decimal vDecimal_32_2 = ConvertNumber(vObject_32_2);

                vSumTax = vDecimal_31_2 + vDecimal_32_2;
                COL35_2.EditValue = vSumTax;
                COL07_2.EditValue = vSumTax;
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void SumAmount_COL38_1()
        {
            try
            {
                object vObject_36_1 = COL36_1.EditValue;
                object vObject_37_1 = COL37_1.EditValue;

                decimal vSumAmount = 0m;

                decimal vDecimal_36_1 = ConvertNumber(vObject_36_1);
                decimal vDecimal_37_1 = ConvertNumber(vObject_37_1);

                vSumAmount = vDecimal_36_1 + vDecimal_37_1;
                COL38_1.EditValue = vSumAmount;
                COL12_1.EditValue = vSumAmount;
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void SumTax_COL38_2()
        {
            try
            {
                object vObject_36_2 = COL36_2.EditValue;
                object vObject_37_2 = COL37_2.EditValue;

                decimal vSumTax = 0m;

                decimal vDecimal_36_2 = ConvertNumber(vObject_36_2);
                decimal vDecimal_37_2 = ConvertNumber(vObject_37_2);

                vSumTax = vDecimal_36_2 + vDecimal_37_2;
                COL38_2.EditValue = vSumTax;
                COL12_2.EditValue = vSumTax;
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void SumAmount_COL47_1()
        {
            try
            {
                object vObject_39_1 = COL39_1.EditValue;
                object vObject_40_1 = COL40_1.EditValue;
                object vObject_41_1 = COL41_1.EditValue;
                object vObject_42_1 = COL42_1.EditValue;
                object vObject_43_1 = COL43_1.EditValue;

                decimal vSumAmount = 0m;

                decimal vDecimal_39_1 = ConvertNumber(vObject_39_1);
                decimal vDecimal_40_1 = ConvertNumber(vObject_40_1);
                decimal vDecimal_41_1 = ConvertNumber(vObject_41_1);
                decimal vDecimal_42_1 = ConvertNumber(vObject_42_1);
                decimal vDecimal_43_1 = ConvertNumber(vObject_43_1);

                vSumAmount = vDecimal_39_1 + vDecimal_40_1 + vDecimal_41_1 + vDecimal_42_1 + vDecimal_43_1;
                COL47_1.EditValue = vSumAmount;
                COL14_1.EditValue = vSumAmount;
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void SumTax_COL47_2()
        {
            try
            {
                object vObject_39_2 = COL39_2.EditValue;
                object vObject_40_2 = COL40_2.EditValue;
                object vObject_41_2 = COL41_2.EditValue;
                object vObject_42_2 = COL42_2.EditValue;
                object vObject_43_2 = COL43_2.EditValue;
                object vObject_44_2 = COL44_2.EditValue;
                object vObject_45_2 = COL45_2.EditValue;
                object vObject_46_2 = COL46_2.EditValue;

                decimal vSumTax = 0m;

                decimal vDecimal_39_2 = ConvertNumber(vObject_39_2);
                decimal vDecimal_40_2 = ConvertNumber(vObject_40_2);
                decimal vDecimal_41_2 = ConvertNumber(vObject_41_2);
                decimal vDecimal_42_2 = ConvertNumber(vObject_42_2);
                decimal vDecimal_43_2 = ConvertNumber(vObject_43_2);
                decimal vDecimal_44_2 = ConvertNumber(vObject_44_2);
                decimal vDecimal_45_2 = ConvertNumber(vObject_45_2);
                decimal vDecimal_46_2 = ConvertNumber(vObject_46_2);
                
                //2014.1기 예정 추가 
                decimal vE_FORE_TOUR_REFUND_VAT = iString.ISDecimaltoZero(E_FORE_TOUR_REFUND_VAT.EditValue, 0);

                vSumTax = vDecimal_39_2 + vDecimal_40_2 + vDecimal_41_2 + vDecimal_42_2 + vDecimal_43_2 + vDecimal_44_2 + vDecimal_45_2 + vDecimal_46_2 +
                            vE_FORE_TOUR_REFUND_VAT;
                COL47_2.EditValue = vSumTax;
                COL14_2.EditValue = vSumTax;
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void SumAmount_COL51_1()
        {
            try
            {
                object vObject_48_1 = COL48_1.EditValue;
                object vObject_49_1 = COL49_1.EditValue;
                object vObject_50_1 = COL50_1.EditValue;

                decimal vSumAmount = 0m;

                decimal vDecimal_48_1 = ConvertNumber(vObject_48_1);
                decimal vDecimal_49_1 = ConvertNumber(vObject_49_1);
                decimal vDecimal_50_1 = ConvertNumber(vObject_50_1);

                vSumAmount = vDecimal_48_1 + vDecimal_49_1 + vDecimal_50_1;
                COL51_1.EditValue = vSumAmount;
                COL16_1.EditValue = vSumAmount;
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void SumTax_COL51_2()
        {
            try
            {
                object vObject_48_2 = COL48_2.EditValue;
                object vObject_49_2 = COL49_2.EditValue;
                object vObject_50_2 = COL50_2.EditValue;

                decimal vSumTax = 0m;

                decimal vDecimal_48_2 = ConvertNumber(vObject_48_2);
                decimal vDecimal_49_2 = ConvertNumber(vObject_49_2);
                decimal vDecimal_50_2 = ConvertNumber(vObject_50_2);

                vSumTax = vDecimal_48_2 + vDecimal_49_2 + vDecimal_50_2;
                COL51_2.EditValue = vSumTax;
                COL16_2.EditValue = vSumTax;
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void SumTax_COL57_2()
        {
            try
            {
                object vObject_52_2 = COL52_2.EditValue;
                object vObject_53_2 = COL53_2.EditValue;
                object vObject_54_2 = COL54_2.EditValue;
                object vObject_55_2 = COL55_2.EditValue;
                object vObject_56_2 = COL56_2.EditValue;
                object vORIGIN_PLACE_VAT = R_ORIGIN_PLACE_AMT.EditValue;

                decimal vSumTax = 0m;

                decimal vDecimal_52_2 = ConvertNumber(vObject_52_2);
                decimal vDecimal_53_2 = ConvertNumber(vObject_53_2);
                decimal vDecimal_54_2 = ConvertNumber(vObject_54_2);
                decimal vDecimal_55_2 = ConvertNumber(vObject_55_2);
                decimal vDecimal_56_2 = ConvertNumber(vObject_56_2);
                decimal vDecimal_ORIGIN_PLACE_VAT = ConvertNumber(vORIGIN_PLACE_VAT);

                decimal vR_CARD_AGENT_PAY_TAX_VAT = ConvertNumber(R_CARD_AGENT_PAY_TAX_VAT.EditValue);

                vSumTax = vDecimal_52_2 + vDecimal_53_2 + vDecimal_54_2 + vDecimal_55_2 + vDecimal_56_2 + vDecimal_ORIGIN_PLACE_VAT + vR_CARD_AGENT_PAY_TAX_VAT;
                COL57_2.EditValue = vSumTax;
                COL18_2.EditValue = vSumTax;
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void SumTax_COL68_2()
        {
            try
            {
                object vObject_58_2 = COL58_2.EditValue;
                object vObject_59_2 = COL59_2.EditValue;
                object vObject_60_2 = COL60_2.EditValue;
                object vObject_61_2 = COL61_2.EditValue;
                object vObject_62_2 = COL62_2.EditValue;
                object vObject_63_2 = COL63_2.EditValue;
                //object vObject_64_2 = COL64_2.EditValue;  // 2013년1기예정 삭제 항목세분화하여 추가//
                object vObject_65_2 = COL65_2.EditValue;
                object vObject_66_2 = COL66_2.EditValue;
                object vObject_67_2 = COL67_2.EditValue;
                object vTAX_RECEIVE_DELAY_VAT = A_TAX_RECEIVE_DELAY_VAT.EditValue;
                //2013년1기 예정 추가 //
                object vA_TAX_INV_SUM_BAD_VAT_1 = A_TAX_INV_SUM_BAD_VAT_1.EditValue;
                object vA_REPORT_BAD_VAT_1 = A_REPORT_BAD_VAT_1.EditValue;
                object vA_REPORT_BAD_VAT_2 = A_REPORT_BAD_VAT_2.EditValue;
                object vA_REPORT_BAD_VAT_3 = A_REPORT_BAD_VAT_3.EditValue;
                object vA_REPORT_BAD_VAT_4 = A_REPORT_BAD_VAT_4.EditValue;
                object vA_REALTY_LEASE_UNREPORT_VAT = A_REALTY_LEASE_UNREPORT_VAT.EditValue;


                decimal vSumTax = 0m;

                decimal vDecimal_58_2 = ConvertNumber(vObject_58_2);
                decimal vDecimal_59_2 = ConvertNumber(vObject_59_2);
                decimal vDecimal_60_2 = ConvertNumber(vObject_60_2);
                decimal vDecimal_61_2 = ConvertNumber(vObject_61_2);
                decimal vDecimal_62_2 = ConvertNumber(vObject_62_2);
                decimal vDecimal_63_2 = ConvertNumber(vObject_63_2);
                //decimal vDecimal_64_2 = ConvertNumber(vObject_64_2);    // 2013년1기예정 삭제 항목세분화하여 추가//
                decimal vDecimal_65_2 = ConvertNumber(vObject_65_2);
                decimal vDecimal_66_2 = ConvertNumber(vObject_66_2);
                decimal vDecimal_67_2 = ConvertNumber(vObject_67_2);
                decimal vDecimal_TAX_RECEIVE_DELAY_VAT = ConvertNumber(vTAX_RECEIVE_DELAY_VAT);
                //2013년1기 예정 추가 //
                decimal vDecimal_A_TAX_INV_SUM_BAD_VAT_1 = ConvertNumber(vA_TAX_INV_SUM_BAD_VAT_1);
                decimal vDecimal_A_REPORT_BAD_VAT_1 = ConvertNumber(vA_REPORT_BAD_VAT_1);
                decimal vDecimal_A_REPORT_BAD_VAT_2 = ConvertNumber(vA_REPORT_BAD_VAT_2);
                decimal vDecimal_A_REPORT_BAD_VAT_3 = ConvertNumber(vA_REPORT_BAD_VAT_3);
                decimal vDecimal_A_REPORT_BAD_VAT_4 = ConvertNumber(vA_REPORT_BAD_VAT_4);
                decimal vDecimal_A_REALTY_LEASE_UNREPORT_VAT = ConvertNumber(vA_REALTY_LEASE_UNREPORT_VAT);

                //2014.1기 예정 추가 
                decimal vA_MISS_DEAL_ACCOUNT_VAT = iString.ISDecimaltoZero(A_MISS_DEAL_ACCOUNT_VAT.EditValue, 0);
                decimal vA_DELAY_PAYMENT_VAT = iString.ISDecimaltoZero(A_DELAY_PAYMENT_VAT.EditValue, 0);

                vSumTax =   vDecimal_58_2 + 
                            vDecimal_59_2 + 
                            vDecimal_60_2 + 
                            vDecimal_61_2 + 
                            vDecimal_62_2 + 
                            vDecimal_63_2 +
                            //vDecimal_64_2 + // 2013년1기예정 삭제 항목세분화하여 추가//
                            vDecimal_65_2 + 
                            vDecimal_66_2 + 
                            vDecimal_67_2 + 
                            vDecimal_TAX_RECEIVE_DELAY_VAT +
                            vDecimal_A_TAX_INV_SUM_BAD_VAT_1 +
                            vDecimal_A_REPORT_BAD_VAT_1 +
                            vDecimal_A_REPORT_BAD_VAT_2 +
                            vDecimal_A_REPORT_BAD_VAT_3 +
                            vDecimal_A_REPORT_BAD_VAT_4 +
                            vDecimal_A_REALTY_LEASE_UNREPORT_VAT + 
                            vA_MISS_DEAL_ACCOUNT_VAT + 
                            vA_DELAY_PAYMENT_VAT    
                            ;
                COL68_2.EditValue = vSumTax;
                COL24_2.EditValue = vSumTax;
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void SumAmount_COL30()
        {
            try
            {
                object vObject_26_3 = COL26_3.EditValue;
                object vObject_27_3 = COL27_3.EditValue;
                object vObject_28_3 = COL28_3.EditValue;
                object vObject_29_3 = COL29_3.EditValue;

                decimal vSumAmount = 0m;

                decimal vDecimal_26_3 = ConvertNumber(vObject_26_3);
                decimal vDecimal_27_3 = ConvertNumber(vObject_27_3);
                decimal vDecimal_28_3 = ConvertNumber(vObject_28_3);
                decimal vDecimal_29_3 = ConvertNumber(vObject_29_3);

                vSumAmount = vDecimal_26_3 + vDecimal_27_3 + vDecimal_28_3 + vDecimal_29_3;
                COL30.EditValue = vSumAmount;
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void SumAmount_COL72()
        {
            try
            {
                object vObject_69_3 = COL69_3.EditValue;
                object vObject_70_3 = COL70_3.EditValue;
                object vObject_71_3 = COL71_3.EditValue;

                decimal vSumAmount = 0m;

                decimal vDecimal_69_3 = ConvertNumber(vObject_69_3);
                decimal vDecimal_70_3 = ConvertNumber(vObject_70_3);
                decimal vDecimal_71_3 = ConvertNumber(vObject_71_3);

                vSumAmount = vDecimal_69_3 + vDecimal_70_3 + vDecimal_71_3;
                COL72.EditValue = vSumAmount;
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        #endregion;

        #region ----- Edit Validated Event ----

        //private decimal RoundF(decimal pValue)
        //{
        //    decimal vValue = 0.0m;

        //    try
        //    {
        //        decimal vHalfAdd = pValue + 0.5m;

        //        string vConvert_String = vHalfAdd.ToString();
        //        int vCutLength = vConvert_String.LastIndexOf(".");
        //        vConvert_String = vConvert_String.Substring(0, vCutLength);

        //        int vConvert_int = int.Parse(vConvert_String);
        //        vValue = decimal.Parse(vConvert_String);
        //    }
        //    catch (System.Exception ex)
        //    {
        //        isAppInterfaceAdv1.OnAppMessage(ex.Message);
        //        System.Windows.Forms.Application.DoEvents();
        //    }

        //    return vValue;
        //}

        private decimal RoundF(decimal pValue)
        {
            decimal vValue = 0.0m;

            try
            {
                idcROUND.SetCommandParamValue("P_NUMBER", pValue);
                idcROUND.ExecuteNonQuery();

                object vObject_Value = idcROUND.GetCommandParamValue("O_NUMBER");
                vValue = ConvertNumber(vObject_Value);
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }

            return vValue;
        }

        private void TaxCompute(object pSender, ISEditAdvValidatedEventArgs e, InfoSummit.Win.ControlAdv.ISEditAdv pPutValueTax)
        {
            try
            {
                InfoSummit.Win.ControlAdv.ISEditAdv vGetValueAmount = pSender as InfoSummit.Win.ControlAdv.ISEditAdv;

                object vObject_Value = vGetValueAmount.EditValue;
                decimal vDecimal_Value_Amount = ConvertNumber(vObject_Value);

                decimal vDecimal_Value_Tax = vDecimal_Value_Amount * (10.0m / 100.0m); //decimal vDecimal_Round_Tax = System.Math.Round(vDecimal_Value_Tax, 0);

                decimal vDecimal_Round_Tax = RoundF(vDecimal_Value_Tax);

                pPutValueTax.EditValue = vDecimal_Round_Tax;

                decimal vValueAmount = vDecimal_Value_Amount;
                decimal vDividend = 10.0m;
                decimal vDivisor = 100.0m;
                decimal vDivision = vValueAmount * (vDividend / vDivisor);
                decimal vDecimal_Round = System.Math.Round(vDivision);
                decimal vDecimal_Ceiling = System.Math.Ceiling(vDivision);
                string vMessage2 = string.Format("{0} * ({1}/{2}) = {3} | Round({4}) | Ceiling({5})", vValueAmount, vDividend, vDivisor, vDivision, vDecimal_Round, vDecimal_Ceiling);
                isAppInterfaceAdv1.OnAppMessage(vMessage2);
                System.Windows.Forms.Application.DoEvents();
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void COL01_1_CurrentEditValidated(object pSender, ISEditAdvValidatedEventArgs e)
        {
            TaxCompute(pSender, e, COL01_2);
        }

        private void COL02_1_CurrentEditValidated(object pSender, ISEditAdvValidatedEventArgs e)
        {
            TaxCompute(pSender, e, COL02_2);
        }

        private void COL03_1_CurrentEditValidated(object pSender, ISEditAdvValidatedEventArgs e)
        {
            TaxCompute(pSender, e, COL03_2);
        }

        private void COL04_1_CurrentEditValidated(object pSender, ISEditAdvValidatedEventArgs e)
        {
            TaxCompute(pSender, e, COL04_2);
        }

        private void COL31_1_CurrentEditValidated(object pSender, ISEditAdvValidatedEventArgs e)
        {
            TaxCompute(pSender, e, COL31_2);
        }

        private void COL32_1_CurrentEditValidated(object pSender, ISEditAdvValidatedEventArgs e)
        {
            TaxCompute(pSender, e, COL32_2);
        }

        private void COL58_1_CurrentEditValidated(object pSender, ISEditAdvValidatedEventArgs e)
        {
            try
            {
                object vObject_Value = COL58_1.EditValue;
                decimal vDecimal_Value_Amount = ConvertNumber(vObject_Value);

                decimal vDecimal_Value_Tax = vDecimal_Value_Amount * (1.0m / 100.0m);
                decimal vDecimal_Round_Tax = RoundF(vDecimal_Value_Tax);

                COL58_2.EditValue = vDecimal_Round_Tax;

                decimal vValueAmount = vDecimal_Value_Amount;
                decimal vDividend = 1.0m;
                decimal vDivisor = 100.0m;
                decimal vDivision = vValueAmount * (vDividend / vDivisor);
                decimal vDecimal_Round = System.Math.Round(vDivision);
                decimal vDecimal_Ceiling = System.Math.Ceiling(vDivision);
                string vMessage2 = string.Format("{0} * ({1}/{2}) = {3} | Round({4}) | Ceiling({5})", vValueAmount, vDividend, vDivisor, vDivision, vDecimal_Round, vDecimal_Ceiling);
                isAppInterfaceAdv1.OnAppMessage(vMessage2);
                System.Windows.Forms.Application.DoEvents();
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void COL59_1_CurrentEditValidated(object pSender, ISEditAdvValidatedEventArgs e)
        {
            try
            {
                object vObject_Value = COL59_1.EditValue;
                decimal vDecimal_Value_Amount = ConvertNumber(vObject_Value);

                decimal vDecimal_Value_Tax = vDecimal_Value_Amount * (1.0m / 100.0m);
                decimal vDecimal_Round_Tax = RoundF(vDecimal_Value_Tax);

                COL59_2.EditValue = vDecimal_Round_Tax;

                decimal vValueAmount = vDecimal_Value_Amount;
                decimal vDividend = 1.0m;
                decimal vDivisor = 100.0m;
                decimal vDivision = vValueAmount * (vDividend / vDivisor);
                decimal vDecimal_Round = System.Math.Round(vDivision);
                decimal vDecimal_Ceiling = System.Math.Ceiling(vDivision);
                string vMessage2 = string.Format("{0} * ({1}/{2}) = {3} | Round({4}) | Ceiling({5})", vValueAmount, vDividend, vDivisor, vDivision, vDecimal_Round, vDecimal_Ceiling);
                isAppInterfaceAdv1.OnAppMessage(vMessage2);
                System.Windows.Forms.Application.DoEvents();
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void A_TAX_RECEIVE_DELAY_AMT_CurrentEditValidated(object pSender, ISEditAdvValidatedEventArgs e)
        {
            try
            {
                object vObject_Value = A_TAX_RECEIVE_DELAY_AMT.EditValue;
                decimal vDecimal_Value_Amount = ConvertNumber(vObject_Value);

                decimal vDecimal_Value_Tax = vDecimal_Value_Amount * (1.0m / 100.0m);
                decimal vDecimal_Round_Tax = RoundF(vDecimal_Value_Tax);

                A_TAX_RECEIVE_DELAY_VAT.EditValue = vDecimal_Round_Tax;

                decimal vValueAmount = vDecimal_Value_Amount;
                decimal vDividend = 1.0m;
                decimal vDivisor = 100.0m;
                decimal vDivision = vValueAmount * (vDividend / vDivisor);
                decimal vDecimal_Round = System.Math.Round(vDivision);
                decimal vDecimal_Ceiling = System.Math.Ceiling(vDivision);
                string vMessage2 = string.Format("{0} * ({1}/{2}) = {3} | Round({4}) | Ceiling({5})", vValueAmount, vDividend, vDivisor, vDivision, vDecimal_Round, vDecimal_Ceiling);
                isAppInterfaceAdv1.OnAppMessage(vMessage2);
                System.Windows.Forms.Application.DoEvents();
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void COL60_1_CurrentEditValidated(object pSender, ISEditAdvValidatedEventArgs e)
        {
            try
            {
                object vObject_Value = COL60_1.EditValue;
                decimal vDecimal_Value_Amount = ConvertNumber(vObject_Value);

                decimal vDecimal_Value_Tax = vDecimal_Value_Amount * (2.0m / 100.0m);
                decimal vDecimal_Round_Tax = RoundF(vDecimal_Value_Tax);

                COL60_2.EditValue = vDecimal_Round_Tax;

                decimal vValueAmount = vDecimal_Value_Amount;
                decimal vDividend = 2.0m;
                decimal vDivisor = 100.0m;
                decimal vDivision = vValueAmount * (vDividend / vDivisor);
                decimal vDecimal_Round = System.Math.Round(vDivision);
                decimal vDecimal_Ceiling = System.Math.Ceiling(vDivision);
                string vMessage2 = string.Format("{0} * ({1}/{2}) = {3} | Round({4}) | Ceiling({5})", vValueAmount, vDividend, vDivisor, vDivision, vDecimal_Round, vDecimal_Ceiling);
                isAppInterfaceAdv1.OnAppMessage(vMessage2);
                System.Windows.Forms.Application.DoEvents();
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void COL61_1_CurrentEditValidated(object pSender, ISEditAdvValidatedEventArgs e)
        {
            try
            {
                object vObject_Value = COL61_1.EditValue;
                decimal vDecimal_Value_Amount = ConvertNumber(vObject_Value);

                decimal vDecimal_Value_Tax = vDecimal_Value_Amount * (1.0m / 1000.0m);
                decimal vDecimal_Round_Tax = RoundF(vDecimal_Value_Tax);

                COL61_2.EditValue = vDecimal_Round_Tax;

                decimal vValueAmount = vDecimal_Value_Amount;
                decimal vDividend = 1.0m;
                decimal vDivisor = 1000.0m;
                decimal vDivision = vValueAmount * (vDividend / vDivisor);
                decimal vDecimal_Round = System.Math.Round(vDivision);
                decimal vDecimal_Ceiling = System.Math.Ceiling(vDivision);
                string vMessage2 = string.Format("{0} * ({1}/{2}) = {3} | Round({4}) | Ceiling({5})", vValueAmount, vDividend, vDivisor, vDivision, vDecimal_Round, vDecimal_Ceiling);
                isAppInterfaceAdv1.OnAppMessage(vMessage2);
                System.Windows.Forms.Application.DoEvents();
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void COL62_1_CurrentEditValidated(object pSender, ISEditAdvValidatedEventArgs e)
        {
            try
            {
                object vObject_Value = COL62_1.EditValue;
                decimal vDecimal_Value_Amount = ConvertNumber(vObject_Value);

                decimal vDecimal_Value_Tax = vDecimal_Value_Amount * (3.0m / 1000.0m);
                decimal vDecimal_Round_Tax = RoundF(vDecimal_Value_Tax);

                COL62_2.EditValue = vDecimal_Round_Tax;

                decimal vValueAmount = vDecimal_Value_Amount;
                decimal vDividend = 3.0m;
                decimal vDivisor = 1000.0m;
                decimal vDivision = vValueAmount * (vDividend / vDivisor);
                decimal vDecimal_Round = System.Math.Round(vDivision);
                decimal vDecimal_Ceiling = System.Math.Ceiling(vDivision);
                string vMessage2 = string.Format("{0} * ({1}/{2}) = {3} | Round({4}) | Ceiling({5})", vValueAmount, vDividend, vDivisor, vDivision, vDecimal_Round, vDecimal_Ceiling);
                isAppInterfaceAdv1.OnAppMessage(vMessage2);
                System.Windows.Forms.Application.DoEvents();
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void COL66_1_CurrentEditValidated(object pSender, ISEditAdvValidatedEventArgs e)
        {
            try
            {
                object vObject_Value = COL66_1.EditValue;
                decimal vDecimal_Value_Amount = ConvertNumber(vObject_Value);

                decimal vDecimal_Value_Tax = vDecimal_Value_Amount * (1.0m / 100.0m);
                decimal vDecimal_Round_Tax = RoundF(vDecimal_Value_Tax);

                COL66_2.EditValue = vDecimal_Round_Tax;

                decimal vValueAmount = vDecimal_Value_Amount;
                decimal vDividend = 1.0m;
                decimal vDivisor = 100.0m;
                decimal vDivision = vValueAmount * (vDividend / vDivisor);
                decimal vDecimal_Round = System.Math.Round(vDivision);
                decimal vDecimal_Ceiling = System.Math.Ceiling(vDivision);
                string vMessage2 = string.Format("{0} * ({1}/{2}) = {3} | Round({4}) | Ceiling({5})", vValueAmount, vDividend, vDivisor, vDivision, vDecimal_Round, vDecimal_Ceiling);
                isAppInterfaceAdv1.OnAppMessage(vMessage2);
                System.Windows.Forms.Application.DoEvents();
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void COL67_1_CurrentEditValidated(object pSender, ISEditAdvValidatedEventArgs e)
        {
            try
            {
                object vObject_Value = COL67_1.EditValue;
                decimal vDecimal_Value_Amount = ConvertNumber(vObject_Value);

                decimal vDecimal_Value_Tax = vDecimal_Value_Amount * (1.0m / 100.0m);
                decimal vDecimal_Round_Tax = RoundF(vDecimal_Value_Tax);

                COL67_2.EditValue = vDecimal_Round_Tax;

                decimal vValueAmount = vDecimal_Value_Amount;
                decimal vDividend = 1.0m;
                decimal vDivisor = 100.0m;
                decimal vDivision = vValueAmount * (vDividend / vDivisor);
                decimal vDecimal_Round = System.Math.Round(vDivision);
                decimal vDecimal_Ceiling = System.Math.Ceiling(vDivision);
                string vMessage2 = string.Format("{0} * ({1}/{2}) = {3} | Round({4}) | Ceiling({5})", vValueAmount, vDividend, vDivisor, vDivision, vDecimal_Round, vDecimal_Ceiling);
                isAppInterfaceAdv1.OnAppMessage(vMessage2);
                System.Windows.Forms.Application.DoEvents();
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void COL63_1_CurrentEditValidated(object pSender, ISEditAdvValidatedEventArgs e)
        {
            try
            {
                object vObject_Value = COL63_1.EditValue;
                decimal vDecimal_Value_Amount = ConvertNumber(vObject_Value);

                decimal vDecimal_Value_Tax = vDecimal_Value_Amount * (1.0m / 100.0m);
                decimal vDecimal_Round_Tax = RoundF(vDecimal_Value_Tax);

                COL63_2.EditValue = vDecimal_Round_Tax;

                decimal vValueAmount = vDecimal_Value_Amount;
                decimal vDividend = 1.0m;
                decimal vDivisor = 100.0m;
                decimal vDivision = vValueAmount * (vDividend / vDivisor);
                decimal vDecimal_Round = System.Math.Round(vDivision);
                decimal vDecimal_Ceiling = System.Math.Ceiling(vDivision);
                string vMessage2 = string.Format("{0} * ({1}/{2}) = {3} | Round({4}) | Ceiling({5})", vValueAmount, vDividend, vDivisor, vDivision, vDecimal_Round, vDecimal_Ceiling);
                isAppInterfaceAdv1.OnAppMessage(vMessage2);
                System.Windows.Forms.Application.DoEvents();
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void A_TAX_INV_SUM_BAD_AMT_1_CurrentEditValidated(object pSender, ISEditAdvValidatedEventArgs e)
        {
            try
            {
                object vObject_Value = A_TAX_INV_SUM_BAD_AMT_1.EditValue;
                decimal vDecimal_Value_Amount = ConvertNumber(vObject_Value);

                decimal vDecimal_Value_Tax = vDecimal_Value_Amount * (5.0m / 1000.0m);
                decimal vDecimal_Round_Tax = RoundF(vDecimal_Value_Tax);

                A_TAX_INV_SUM_BAD_VAT_1.EditValue = vDecimal_Round_Tax;

                decimal vValueAmount = vDecimal_Value_Amount;
                decimal vDividend = 5.0m;
                decimal vDivisor = 1000.0m;
                decimal vDivision = vValueAmount * (vDividend / vDivisor);
                decimal vDecimal_Round = System.Math.Round(vDivision);
                decimal vDecimal_Ceiling = System.Math.Ceiling(vDivision);
                string vMessage2 = string.Format("{0} * ({1}/{2}) = {3} | Round({4}) | Ceiling({5})", vValueAmount, vDividend, vDivisor, vDivision, vDecimal_Round, vDecimal_Ceiling);
                isAppInterfaceAdv1.OnAppMessage(vMessage2);
                System.Windows.Forms.Application.DoEvents();
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void A_REALTY_LEASE_UNREPORT_AMT_CurrentEditValidated(object pSender, ISEditAdvValidatedEventArgs e)
        {
            try
            {
                object vObject_Value = A_REALTY_LEASE_UNREPORT_AMT.EditValue;
                decimal vDecimal_Value_Amount = ConvertNumber(vObject_Value);

                decimal vDecimal_Value_Tax = vDecimal_Value_Amount * (1.0m / 100.0m);
                decimal vDecimal_Round_Tax = RoundF(vDecimal_Value_Tax);

                A_REALTY_LEASE_UNREPORT_VAT.EditValue = vDecimal_Round_Tax;

                decimal vValueAmount = vDecimal_Value_Amount;
                decimal vDividend = 1.0m;
                decimal vDivisor = 100.0m;
                decimal vDivision = vValueAmount * (vDividend / vDivisor);
                decimal vDecimal_Round = System.Math.Round(vDivision);
                decimal vDecimal_Ceiling = System.Math.Ceiling(vDivision);
                string vMessage2 = string.Format("{0} * ({1}/{2}) = {3} | Round({4}) | Ceiling({5})", vValueAmount, vDividend, vDivisor, vDivision, vDecimal_Round, vDecimal_Ceiling);
                isAppInterfaceAdv1.OnAppMessage(vMessage2);
                System.Windows.Forms.Application.DoEvents();
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        #endregion;

        #region ----- Button Event -----

        private void ibtnSET_DECLARATION_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            object vObject1 = W_TAX_DESC.EditValue;
            object vObject2 = W_PERIOD_YEAR.EditValue;
            object vObject3 = W_VAT_REPORT_NM.EditValue;
            if (iString.ISNull(vObject1) == string.Empty || iString.ISNull(vObject2) == string.Empty || iString.ISNull(vObject3) == string.Empty)
            {
                //사업장, 과세년도, 신고기간구분은 필수 입니다.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10366"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            object vObject_CLOSING_YN = W_CLOSING_YN.EditValue;
            string vClosingYN = ConvertString(vObject_CLOSING_YN);
            if (vClosingYN == "Y")
            {
                //해당 신고기간의 자료는 마감되어 변경할 수 없습니다.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10365"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            System.Windows.Forms.DialogResult vChoiceValue;

            FCMF0882_CREATE vFCMF0882_CREATE = new FCMF0882_CREATE(isAppInterfaceAdv1.AppInterface);
            vChoiceValue = vFCMF0882_CREATE.ShowDialog();
            if (vChoiceValue == DialogResult.OK)
            {
                string vStatus = "F";
                string vMessageString1 = isMessageAdapter1.ReturnText("FCM_10376"); //기초자료를 생성하시겠습니까?
                string vMessageString2 = isMessageAdapter1.ReturnText("FCM_10377"); //기존 자료가 삭제되고 (재)생성됩니다.
                string vMessage = string.Format("{0}\n\n{1}", vMessageString1, vMessageString2);
                vChoiceValue = MessageBoxAdv.Show(vMessage, "Warning", System.Windows.Forms.MessageBoxButtons.YesNo, System.Windows.Forms.MessageBoxIcon.Question, System.Windows.Forms.MessageBoxDefaultButton.Button2);

                try
                {
                    if (vChoiceValue == System.Windows.Forms.DialogResult.Yes)
                    {
                        IDC_CREATE_SURTAX_CARD.SetCommandParamValue("W_VAT_LEVIER_GB", vFCMF0882_CREATE.VAT_LEVIER_GB);
                        IDC_CREATE_SURTAX_CARD.SetCommandParamValue("W_VAT_MAKE_GB", vFCMF0882_CREATE.VAT_MAKE_GB);
                        IDC_CREATE_SURTAX_CARD.SetCommandParamValue("W_MODIFY_DESC", vFCMF0882_CREATE.MODIFY_DESC);
                        IDC_CREATE_SURTAX_CARD.ExecuteNonQuery();
                        vStatus = iString.ISNull(IDC_CREATE_SURTAX_CARD.GetCommandParamValue("O_STATUS"));
                        vMessage = iString.ISNull(IDC_CREATE_SURTAX_CARD.GetCommandParamValue("O_MESSAGE"));

                        if (IDC_CREATE_SURTAX_CARD.ExcuteError || vStatus == "F")
                        {
                            if (vMessage != string.Empty)
                            {
                                MessageBoxAdv.Show(vMessage, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                                return;
                            }
                        }
                        else
                        {
                            //해당 작업을 정상적으로 처리 완료하였습니다.
                            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10112"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);

                            W_VAT_MAKE_GB.EditValue = vFCMF0882_CREATE.VAT_MAKE_GB;
                            W_VAT_MAKE_GB_DESC.EditValue = vFCMF0882_CREATE.VAT_MAKE_GB_DESC;

                            W_MODIFY_DEGREE.EditValue = IDC_CREATE_SURTAX_CARD.GetCommandParamValue("O_MODIFY_DEGREE");
                            W_MODIFY_DESC.EditValue = IDC_CREATE_SURTAX_CARD.GetCommandParamValue("O_MODIFY_DESC");
                            
                            SearchDB();
                        }
                    }
                }
                catch (System.Exception ex)
                {
                    MessageBoxAdv.Show(ex.Message, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                }
            }
        }

        #endregion;

        #region ----- XL Print 1 Method ----

        private void XLPrinting_1(string pOutChoice, InfoSummit.Win.ControlAdv.ISDataAdapter p_adapter_LIST_SURTAX_CARD)
        {
            object vObject1 = W_TAX_DESC.EditValue;
            object vObject2 = W_PERIOD_YEAR.EditValue;
            object vObject3 = W_VAT_REPORT_NM.EditValue;
            string vVAT_MAKE_GB = iString.ISNull(W_VAT_MAKE_GB.EditValue);

            if (iString.ISNull(vObject1) == string.Empty || iString.ISNull(vObject2) == string.Empty || iString.ISNull(vObject3) == string.Empty)
            {
                //사업장, 과세년도, 신고기간구분은 필수 입니다.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10366"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            if (iString.ISNull(W_VAT_MAKE_GB.EditValue) == string.Empty)
            {
                //신고구분
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", string.Format("&&FIELD_NAME:={0}", Get_Edit_Prompt(W_VAT_MAKE_GB))), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            if (vVAT_MAKE_GB == "02" && iString.ISNull(W_MODIFY_DEGREE.EditValue) == string.Empty)
            {
                //수정차수
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10492"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            string vMessageText = string.Empty;
            string vSaveFileName = string.Empty;

            int vCountRow = p_adapter_LIST_SURTAX_CARD.OraSelectData.Rows.Count;

            if (vCountRow < 1)
            {
                vMessageText = string.Format("Without Data");
                isAppInterfaceAdv1.OnAppMessage(vMessageText);
                System.Windows.Forms.Application.DoEvents();
                return;
            }

            System.Windows.Forms.Application.UseWaitCursor = true;
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            System.Windows.Forms.Application.DoEvents();

            int vPageNumber = 0;

            vMessageText = string.Format(" Printing Starting...");
            isAppInterfaceAdv1.OnAppMessage(vMessageText);
            System.Windows.Forms.Application.DoEvents();

            XLPrinting xlPrinting = new XLPrinting(isAppInterfaceAdv1.AppInterface, isMessageAdapter1);
                        
            try
            {
                if (vVAT_MAKE_GB == "02")
                {
                    //수정신고 양식//
                    //-------------------------------------------------------------------------------------
                    xlPrinting.OpenFileNameExcel = "FCMF0882_002.xls";
                    //-------------------------------------------------------------------------------------
                }
                else
                {
                    if (iDate.ISGetDate(W_DEAL_DATE_FR.EditValue) < iDate.ISGetDate("2014-01-01"))
                    {
                        xlPrinting.OpenFileNameExcel = "FCMF0882_001.xls";
                    }
                    else if (iDate.ISGetDate(W_DEAL_DATE_FR.EditValue) < iDate.ISGetDate("2021-04-01"))
                    {
                        xlPrinting.OpenFileNameExcel = "FCMF0882_003.xlsx";
                    }
                    else
                    {
                        //2014년도 변경 양식 적용 
                        xlPrinting.OpenFileNameExcel = "FCMF0882_013.xlsx";
                    }
                }                

                //-------------------------------------------------------------------------------------
                bool isOpen = xlPrinting.XLFileOpen();
                //-------------------------------------------------------------------------------------

                //-------------------------------------------------------------------------------------
                if (isOpen == true)
                {
                    vMessageText = string.Format(" XL File Open...");
                    isAppInterfaceAdv1.OnAppMessage(vMessageText);
                    System.Windows.Forms.Application.DoEvents();

                    if (vVAT_MAKE_GB == "02")
                    {
                        //수정신고 양식//
                        IDA_PRINT_SURTAX_CARD_01.Fill();
                        if (iDate.ISGetDate(W_DEAL_DATE_FR.EditValue) < iDate.ISGetDate("2014-01-01"))
                        {
                            vPageNumber = xlPrinting.LineWrite_02(p_adapter_LIST_SURTAX_CARD, IDA_PRINT_SURTAX_CARD_01);
                        }
                        else
                        {
                            //2014년도 변경 양식 적용 
                            vPageNumber = xlPrinting.LineWrite_02_201401(p_adapter_LIST_SURTAX_CARD, IDA_PRINT_SURTAX_CARD_01);
                        }
                    }
                    else
                    {
                        if (iDate.ISGetDate(W_DEAL_DATE_FR.EditValue) < iDate.ISGetDate("2014-01-01"))
                        {
                            vPageNumber = xlPrinting.LineWrite(p_adapter_LIST_SURTAX_CARD);
                        }
                        else if(iDate.ISGetDate(W_DEAL_DATE_FR.EditValue) < iDate.ISGetDate("2021-04-01"))
                        { 
                            //2014년도 변경 양식 적용 
                            vPageNumber = xlPrinting.LineWrite_201401(p_adapter_LIST_SURTAX_CARD);
                        }
                        else
                        {
                            //2014년도 변경 양식 적용 
                            vPageNumber = xlPrinting.LineWrite_013(p_adapter_LIST_SURTAX_CARD);
                        }
                    }                    

                    if (pOutChoice == "PRINT")
                    {
                        xlPrinting.Printing(1, vPageNumber);
                    }
                    else if (pOutChoice == "FILE")
                    {
                        xlPrinting.SAVE("TAX_");
                    }

                    //-------------------------------------------------------------------------------------
                    xlPrinting.Dispose();
                    //-------------------------------------------------------------------------------------

                    vMessageText = string.Format("Printing End [Total Page : {0}]", vPageNumber);
                    isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
                    System.Windows.Forms.Application.DoEvents();
                }
                else
                {
                    vMessageText = "Excel File Open Error";
                    isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
                    System.Windows.Forms.Application.DoEvents();
                }
                //-------------------------------------------------------------------------------------
            }
            catch (System.Exception ex)
            {
                xlPrinting.Dispose();

                vMessageText = ex.Message;
                isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
                System.Windows.Forms.Application.DoEvents();
            }

            System.Windows.Forms.Application.UseWaitCursor = false;
            this.Cursor = System.Windows.Forms.Cursors.Default;
            System.Windows.Forms.Application.DoEvents();
        }

        #endregion;


    }
}