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

namespace FCMF0203
{
    public partial class FCMF0203_UNLIQUIDATE_LIST : Office2007Form
    {        
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();
        string mLiquidate_Method_Type_Flag;
        string mBasic_Currency_Code;

        #endregion;

        #region ----- Constructor -----

        public FCMF0203_UNLIQUIDATE_LIST(ISAppInterface pAppInterface, ISDataAdapter pDataAdapter
            , object pAccount_Code, object pAccount_Desc, object pAccount_Control_ID
            , object pCustomer_Name, object pCustomer_Code
            , object pBasic_Currency_Code, object pCurrency_Code, object pExchange_Rate)
        {
            InitializeComponent();
            isAppInterfaceAdv1.AppInterface = pAppInterface;

            idaUNLIQUIDATE_LIST = pDataAdapter;
            igrUNLIQUIDATE_LIST.DataAdapter = idaUNLIQUIDATE_LIST;

            ACCOUNT_CODE.EditValue = pAccount_Code;
            ACCOUNT_DESC.EditValue = pAccount_Desc;
            ACCOUNT_CONTROL_ID.EditValue = pAccount_Control_ID;
            CUSTOMER_NAME.EditValue = pCustomer_Name;
            CUSTOMER_CODE.EditValue = pCustomer_Code;
            mBasic_Currency_Code = iString.ISNull(pBasic_Currency_Code);
            CURRENCY_CODE.EditValue = pCurrency_Code;
            EXCHANGE_RATE.EditValue = pExchange_Rate;
        }

        #endregion;

        #region ----- Private Methods ----

        private void Init_Edit_GL_Amount()
        {// 총금액.
            if (mBasic_Currency_Code != CURRENCY_CODE.EditValue.ToString())
            {
                TOTAL_AMOUNT.EditValue = iString.ISDecimaltoZero(TOTAL_CURR_AMOUNT.EditValue) * iString.ISDecimaltoZero(EXCHANGE_RATE.EditValue);
                idcCONVERSION_BASE_AMOUNT.SetCommandParamValue("W_BASE_CURRENCY_CODE", mBasic_Currency_Code);
                idcCONVERSION_BASE_AMOUNT.SetCommandParamValue("W_CONVERSION_AMOUNT", TOTAL_AMOUNT.EditValue);
                idcCONVERSION_BASE_AMOUNT.ExecuteNonQuery();
                TOTAL_AMOUNT.EditValue = idcCONVERSION_BASE_AMOUNT.GetCommandParamValue("O_BASE_AMOUNT");
            }
        }

        private void Set_Grid_GL_Amount()
        {//선택에 따른 금액 동기화.
            Application.UseWaitCursor = true;
            string vCheckValue = iString.ISNull(igrUNLIQUIDATE_LIST.GetCellValue("CHECK_YN"), "N");
            decimal vRemain_Amount = 0;             // 잔액
            decimal vGap_Amount = 0;                // 차액.
            decimal vNew_Amount = 0;                // 새로 생성된 금액.
            if (vCheckValue == "Y".ToString())
            {
                if (mBasic_Currency_Code != CURRENCY_CODE.EditValue.ToString())
                {// 외화
                    vRemain_Amount = iString.ISDecimaltoZero(igrUNLIQUIDATE_LIST.GetCellValue("GL_REMAIN_CURRENCY_AMOUNT"));
                    if (iString.ISDecimaltoZero(TOTAL_CURR_AMOUNT.EditValue) < iString.ISDecimaltoZero(SELECT_TOTAL_CURR_AMOUNT.EditValue))
                    {// 입력된 금액이 클 경우 적용 안함.
                        vGap_Amount = 0;
                    }
                    else
                    {// 잔액 몽땅.
                        vGap_Amount = iString.ISDecimaltoZero(TOTAL_CURR_AMOUNT.EditValue) - iString.ISDecimaltoZero(SELECT_TOTAL_CURR_AMOUNT.EditValue);
                        if (vRemain_Amount < vGap_Amount)
                        {
                            vNew_Amount = vRemain_Amount;
                        }
                        else
                        {
                            vNew_Amount = vGap_Amount;
                        }
                    }
                    igrUNLIQUIDATE_LIST.SetCellValue("NEW_CURRENCY_AMOUNT", vNew_Amount);
                    Init_Grid_GL_Amount();
                }
                else
                {
                    vRemain_Amount = iString.ISDecimaltoZero(igrUNLIQUIDATE_LIST.GetCellValue("GL_REMAIN_AMOUNT"));
                    if (iString.ISDecimaltoZero(TOTAL_AMOUNT.EditValue) < iString.ISDecimaltoZero(SELECT_TOTAL_AMOUNT.EditValue))
                    {// 입력된 금액이 클 경우 적용 안함.
                        vGap_Amount = 0;
                    }
                    else
                    {// 잔액 몽땅.
                        vGap_Amount = iString.ISDecimaltoZero(TOTAL_AMOUNT.EditValue) - iString.ISDecimaltoZero(SELECT_TOTAL_AMOUNT.EditValue);
                        if (vRemain_Amount < vGap_Amount)
                        {
                            vNew_Amount = vRemain_Amount;
                        }
                        else
                        {
                            vNew_Amount = vGap_Amount;
                        }                        
                    }
                    igrUNLIQUIDATE_LIST.SetCellValue("NEW_GL_AMOUNT", vNew_Amount);
                }
            }
            else
            {
                if (mBasic_Currency_Code != CURRENCY_CODE.EditValue.ToString())
                {// 외화                
                    igrUNLIQUIDATE_LIST.SetCellValue("NEW_CURRENCY_AMOUNT", 0);
                }
                igrUNLIQUIDATE_LIST.SetCellValue("NEW_GL_AMOUNT", 0);
            }
            Application.UseWaitCursor = false;
        }

        private void Init_Grid_GL_Amount()
        {// GL 금액 동기화
            if (mBasic_Currency_Code != CURRENCY_CODE.EditValue.ToString())
            {// 외화
                decimal vCurrency_Amount = iString.ISDecimaltoZero(igrUNLIQUIDATE_LIST.GetCellValue("NEW_CURRENCY_AMOUNT"));
                decimal vExchange_Rate = iString.ISDecimaltoZero(igrUNLIQUIDATE_LIST.GetCellValue("EXCHANGE_RATE"));
                decimal vBase_Amount = vCurrency_Amount * vExchange_Rate;
                idcCONVERSION_BASE_AMOUNT.SetCommandParamValue("W_BASE_CURRENCY_CODE", mBasic_Currency_Code);
                idcCONVERSION_BASE_AMOUNT.SetCommandParamValue("W_CONVERSION_AMOUNT", vBase_Amount);
                idcCONVERSION_BASE_AMOUNT.ExecuteNonQuery();
                vBase_Amount = iString.ISDecimaltoZero(idcCONVERSION_BASE_AMOUNT.GetCommandParamValue("O_BASE_AMOUNT"));
                igrUNLIQUIDATE_LIST.SetCellValue("NEW_GL_AMOUNT", vBase_Amount);
            }            
        }

        private void Init_Total_GL_Amount()
        {
            Application.UseWaitCursor = true;
            string vCheckValue;
            decimal mCurrency_Amount = Convert.ToDecimal(0);
            decimal mGL_Amount = Convert.ToDecimal(0);
            for (int r = 0; r <  igrUNLIQUIDATE_LIST.RowCount; r++)
            {
                vCheckValue = iString.ISNull(igrUNLIQUIDATE_LIST.GetCellValue(r, igrUNLIQUIDATE_LIST.GetColumnToIndex("CHECK_YN")), "N");
                if (vCheckValue == "Y".ToString())
                {
                    if (mBasic_Currency_Code != CURRENCY_CODE.EditValue.ToString())
                    {                        
                        mCurrency_Amount = mCurrency_Amount 
                                            + iString.ISDecimaltoZero(igrUNLIQUIDATE_LIST.GetCellValue(r, igrUNLIQUIDATE_LIST.GetColumnToIndex("NEW_CURRENCY_AMOUNT")));
                    }
                    mGL_Amount = mGL_Amount 
                                + iString.ISDecimaltoZero(igrUNLIQUIDATE_LIST.GetCellValue(r, igrUNLIQUIDATE_LIST.GetColumnToIndex("NEW_GL_AMOUNT")));
                }
                else
                {
                    igrUNLIQUIDATE_LIST.SetCellValue(r, igrUNLIQUIDATE_LIST.GetColumnToIndex("NEW_CURRENCY_AMOUNT"), 0);
                    igrUNLIQUIDATE_LIST.SetCellValue(r, igrUNLIQUIDATE_LIST.GetColumnToIndex("NEW_GL_AMOUNT"), 0);
                }
            }
            SELECT_TOTAL_CURR_AMOUNT.EditValue = iString.ISDecimaltoZero(mCurrency_Amount);
            SELECT_TOTAL_AMOUNT.EditValue = iString.ISDecimaltoZero(mGL_Amount);
            Application.UseWaitCursor = false;
        }

        private void Init_Select_GL_Amount()
        {// 실 적용 금액.
            decimal vCurrent_Amount = 0;
            decimal vGap_Amount = 0;
            decimal vNew_Amount = 0;
            if (mBasic_Currency_Code != CURRENCY_CODE.EditValue.ToString())
            {// 외화
                vCurrent_Amount = iString.ISDecimaltoZero(igrUNLIQUIDATE_LIST.GetCellValue("NEW_CURRENCY_AMOUNT"));       // 입력금액.
                if (iString.ISDecimaltoZero(TOTAL_CURR_AMOUNT.EditValue) < iString.ISDecimaltoZero(SELECT_TOTAL_CURR_AMOUNT.EditValue))
                {// 총외화금액 vs 선택한 총 외화금액.
                    vGap_Amount = iString.ISDecimaltoZero(SELECT_TOTAL_CURR_AMOUNT.EditValue) - iString.ISDecimaltoZero(TOTAL_CURR_AMOUNT.EditValue);
                    vNew_Amount = vCurrent_Amount - vGap_Amount;
                    igrUNLIQUIDATE_LIST.SetCellValue("NEW_CURRENCY_AMOUNT", vNew_Amount);
                }
            }
            else
            {// 기본 금액.
                vCurrent_Amount = iString.ISDecimaltoZero(igrUNLIQUIDATE_LIST.GetCellValue("NEW_GL_AMOUNT"));       // 입력금액.
                if (iString.ISDecimaltoZero(TOTAL_AMOUNT.EditValue) < iString.ISDecimaltoZero(SELECT_TOTAL_AMOUNT.EditValue))
                {// 총외화금액 vs 선택한 총 외화금액.
                    vGap_Amount = iString.ISDecimaltoZero(SELECT_TOTAL_AMOUNT.EditValue) - iString.ISDecimaltoZero(TOTAL_AMOUNT.EditValue);
                    vNew_Amount = vCurrent_Amount - vGap_Amount;
                    igrUNLIQUIDATE_LIST.SetCellValue("NEW_GL_AMOUNT", vNew_Amount);
                }
            }
        }

        private void Set_Edit_Status()
        {
            if (mBasic_Currency_Code == iString.ISNull(CURRENCY_CODE.EditValue))
            {// 같은 통화.                
                TOTAL_CURR_AMOUNT.ReadOnly = true;
                TOTAL_CURR_AMOUNT.Insertable = false;
                TOTAL_CURR_AMOUNT.Updatable = false;
                TOTAL_CURR_AMOUNT.TabStop = false;

                TOTAL_AMOUNT.ReadOnly = false;
                TOTAL_AMOUNT.Insertable = true;
                TOTAL_AMOUNT.Updatable = true;
                TOTAL_AMOUNT.TabStop = true;

                EXCHANGE_RATE.EditValue = null;
                TOTAL_CURR_AMOUNT.EditValue = null;
            }
            else
            {
                TOTAL_CURR_AMOUNT.ReadOnly = false;
                TOTAL_CURR_AMOUNT.Insertable = true;
                TOTAL_CURR_AMOUNT.Updatable = true;
                TOTAL_CURR_AMOUNT.TabStop = true;

                // 기본통화와 다를 경우 기본금액 수정 불가.
                TOTAL_AMOUNT.ReadOnly = true;
                TOTAL_AMOUNT.Insertable = false;
                TOTAL_AMOUNT.Updatable = false;
                TOTAL_AMOUNT.TabStop = false;

            }    
        }

        private void Set_Grid_Status()
        {
            if (mBasic_Currency_Code == iString.ISNull(CURRENCY_CODE.EditValue))
            {// 기본통화.
                igrUNLIQUIDATE_LIST.GridAdvExColElement[igrUNLIQUIDATE_LIST.GetColumnToIndex("NEW_CURRENCY_AMOUNT")].ReadOnly = true;
                igrUNLIQUIDATE_LIST.GridAdvExColElement[igrUNLIQUIDATE_LIST.GetColumnToIndex("NEW_CURRENCY_AMOUNT")].Insertable = 0;
                igrUNLIQUIDATE_LIST.GridAdvExColElement[igrUNLIQUIDATE_LIST.GetColumnToIndex("NEW_CURRENCY_AMOUNT")].Updatable = 0;

                igrUNLIQUIDATE_LIST.GridAdvExColElement[igrUNLIQUIDATE_LIST.GetColumnToIndex("NEW_GL_AMOUNT")].ReadOnly = false;
                igrUNLIQUIDATE_LIST.GridAdvExColElement[igrUNLIQUIDATE_LIST.GetColumnToIndex("NEW_GL_AMOUNT")].Insertable = 1;
                igrUNLIQUIDATE_LIST.GridAdvExColElement[igrUNLIQUIDATE_LIST.GetColumnToIndex("NEW_GL_AMOUNT")].Updatable = 1;
            }
            else
            {// 외화.
                igrUNLIQUIDATE_LIST.GridAdvExColElement[igrUNLIQUIDATE_LIST.GetColumnToIndex("NEW_CURRENCY_AMOUNT")].ReadOnly = false;
                igrUNLIQUIDATE_LIST.GridAdvExColElement[igrUNLIQUIDATE_LIST.GetColumnToIndex("NEW_CURRENCY_AMOUNT")].Insertable = 1;
                igrUNLIQUIDATE_LIST.GridAdvExColElement[igrUNLIQUIDATE_LIST.GetColumnToIndex("NEW_CURRENCY_AMOUNT")].Updatable = 1;

                igrUNLIQUIDATE_LIST.GridAdvExColElement[igrUNLIQUIDATE_LIST.GetColumnToIndex("NEW_GL_AMOUNT")].ReadOnly = true;
                igrUNLIQUIDATE_LIST.GridAdvExColElement[igrUNLIQUIDATE_LIST.GetColumnToIndex("NEW_GL_AMOUNT")].Insertable = 0;
                igrUNLIQUIDATE_LIST.GridAdvExColElement[igrUNLIQUIDATE_LIST.GetColumnToIndex("NEW_GL_AMOUNT")].Updatable = 0;
            }                

            //else
            //{
            //    // 금액 초기화.
            //    igrUNLIQUIDATE_LIST.SetCellValue("NEW_EXCHANGE_RATE", 0);
            //    igrUNLIQUIDATE_LIST.SetCellValue("NEW_CURRENCY_AMOUNT", 0);
            //    igrUNLIQUIDATE_LIST.SetCellValue("NEW_GL_AMOUNT", 0);

            //    igrUNLIQUIDATE_LIST.GridAdvExColElement[igrUNLIQUIDATE_LIST.GetColumnToIndex("NEW_CURRENCY_AMOUNT")].ReadOnly = true;
            //    igrUNLIQUIDATE_LIST.GridAdvExColElement[igrUNLIQUIDATE_LIST.GetColumnToIndex("NEW_CURRENCY_AMOUNT")].Insertable = 0;
            //    igrUNLIQUIDATE_LIST.GridAdvExColElement[igrUNLIQUIDATE_LIST.GetColumnToIndex("NEW_CURRENCY_AMOUNT")].Updatable = 0;

            //    igrUNLIQUIDATE_LIST.GridAdvExColElement[igrUNLIQUIDATE_LIST.GetColumnToIndex("NEW_GL_AMOUNT")].ReadOnly = true;
            //    igrUNLIQUIDATE_LIST.GridAdvExColElement[igrUNLIQUIDATE_LIST.GetColumnToIndex("NEW_GL_AMOUNT")].Insertable = 0;
            //    igrUNLIQUIDATE_LIST.GridAdvExColElement[igrUNLIQUIDATE_LIST.GetColumnToIndex("NEW_GL_AMOUNT")].Updatable = 0;                
            //}            
        }

        #endregion;

        #region ----- Events -----

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

        #region ----- Form Event ------
        
        private void FCMF0206_UNLIQUIDATE_LIST_Load(object sender, EventArgs e)
        {
            idcLIQUIDATE_METHOD_TYPE.ExecuteNonQuery();
            mLiquidate_Method_Type_Flag = iString.ISNull(idcLIQUIDATE_METHOD_TYPE.GetCommandParamValue("O_LIQUIDATE_METHOD_TYPE_FLAG"), "-");

            Set_Edit_Status();
            Set_Grid_Status();
            idaUNLIQUIDATE_LIST.Fill();
        }

        private void ibtnOK_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            this.DialogResult = System.Windows.Forms.DialogResult.OK;
        }

        private void ibtnCANCEL_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            this.Close();
        }

        private void ibtnALL_YN_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            string vCheckValue;
            Application.UseWaitCursor = true;
            for (int r = 0; r < igrUNLIQUIDATE_LIST.RowCount; r++)
            {
                vCheckValue = iString.ISNull(igrUNLIQUIDATE_LIST.GetCellValue(r, igrUNLIQUIDATE_LIST.GetColumnToIndex("CHECK_YN")), "N");
                if (vCheckValue == "Y".ToString())
                {
                    igrUNLIQUIDATE_LIST.SetCellValue(r, igrUNLIQUIDATE_LIST.GetColumnToIndex("CHECK_YN"), "N");
                }
                else
                {
                    igrUNLIQUIDATE_LIST.SetCellValue(r, igrUNLIQUIDATE_LIST.GetColumnToIndex("CHECK_YN"), "Y");
                }
                igrUNLIQUIDATE_LIST.CurrentCellMoveTo(r, 0);
                Set_Grid_GL_Amount();
                Init_Total_GL_Amount();
            }
            igrUNLIQUIDATE_LIST.Invalidate();
            Application.UseWaitCursor = false;
        }

        private void EXCHANGE_RATE_CurrentEditValidated(object pSender, ISEditAdvValidatedEventArgs e)
        {
            Init_Edit_GL_Amount();
        }

        private void TOTAL_CURR_AMOUNT_CurrentEditValidated(object pSender, ISEditAdvValidatedEventArgs e)
        {
            Init_Edit_GL_Amount();
        }

        private void igrUNLIQUIDATE_LIST_CurrentCellValidating(object pSender, ISGridAdvExValidatingEventArgs e)
        {
            if (e.ColIndex == igrUNLIQUIDATE_LIST.GetColumnToIndex("CHECK_YN")
                || e.ColIndex == igrUNLIQUIDATE_LIST.GetColumnToIndex("NEW_CURRENCY_AMOUNT")
                || e.ColIndex == igrUNLIQUIDATE_LIST.GetColumnToIndex("NEW_GL_AMOUNT"))
            {
                Set_Grid_GL_Amount();
                Init_Total_GL_Amount();
            }
        }

        private void igrUNLIQUIDATE_LIST_CurrentCellEditingComplete(object pSender, ISGridAdvExCellEditingEventArgs e)
        {            
            if (e.ColIndex == igrUNLIQUIDATE_LIST.GetColumnToIndex("CHECK_YN")
                || e.ColIndex == igrUNLIQUIDATE_LIST.GetColumnToIndex("NEW_CURRENCY_AMOUNT")
                || e.ColIndex == igrUNLIQUIDATE_LIST.GetColumnToIndex("NEW_GL_AMOUNT"))
            {
                Set_Grid_GL_Amount();
                Init_Total_GL_Amount();
            }
        }

        #endregion               



    }
}