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

namespace PPMF0901
{
    public partial class PPMF0901 : Office2007Form
    {
        ISCommonUtil.ISFunction.ISConvert iConvert = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();


        #region ----- Variables -----
        Object P_SAVE_FLAG;
        Object P_DISPOSAL_DATE;
        Object P_BILL_TO_CUST_ID;
        Object P_BILL_TO_CUST_CODE;
        Object P_BILL_TO_CUST_DESC;
        Object P_SHIP_TO_CUST_ID;
        Object P_SHIP_TO_CUST_CODE;
        Object P_SHIP_TO_CUST_DESC;
        Object P_INVOICE_NO;


        #endregion;

        #region ----- Constructor -----

        public PPMF0901(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void idaHEADER_ExcuteQuery()
        {
            IDA_DISPOSAL_HEADER.Fill();
            Total_Summary();
            BUTTON_DISABLE();

        }

        private void Header_Setting()
        {
            H_CREATION_DATE.EditValue = DateTime.Today;
            H_DISPOSAL_DATE.EditValue = DateTime.Today;
            H_SHIP_DATE.EditValue = DateTime.Today;
            H_DISPOSAL_PERSON_ID.EditValue = isAppInterfaceAdv1.PERSON_ID;
            H_PERSON_NAME.EditValue = isAppInterfaceAdv1.DISPLAY_NAME;
            IDC_DISPOSAL_LEVEL.ExecuteNonQuery();  // 제품구분 DEFAULT값 설정, 2014-03-05, BY JPSEO //
            H_BILL_TO_CUST_CODE.Focus();

            if (P_SAVE_FLAG.ToString() == "Y")
            {
                FORM_VALUE_SETTING();
            }

            IDC_DEFAULT_OPEATION.ExecuteNonQuery();

            BUTTON_ENABLE();

        }

        private bool line_data_check()
        {
            bool vcheck = true;
            //MessageBoxAdv.Show(isgOE_QUOTE_REQ_LINE.GetCellValue("REQ_LINE_ID").ToString());
            if (ISG_DISPOSAL_LINE.RowCount > 0)
            {
                vcheck = false;
            }
            return vcheck;
        }

        private void iedISSUE_NO_KeyDown(object pSender, KeyEventArgs e)
        {
            if (e.KeyCode == System.Windows.Forms.Keys.F9)
            {
                ISG_DISPOSAL_LINE.RowCount = 0;
            }
        }

        #endregion;

        #region ----- Events -----

        private void PPMF0901_Load(object sender, EventArgs e)
        {
            IDA_DISPOSAL_HEADER.FillSchema();

            V_DATE_FR.EditValue = iDate.ISMonth_1st(DateTime.Today);
            V_DATE_TO.EditValue = DateTime.Today;

            P_SAVE_FLAG = "N";
        }

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    if (TAB_MAIN.SelectedIndex == 0)
                    {
                        IDA_DISPOSAL_HEADER.Fill();
                        Total_Summary();
                        BUTTON_DISABLE();
                    }
                    else if (TAB_MAIN.SelectedIndex == 1)
                    {
                        IDA_DISPOSAL_LIST.Fill();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    if (IDA_DISPOSAL_HEADER.IsFocused == true)
                    {
                        if ((IDA_DISPOSAL_HEADER.CurrentRow == null) || ((IDA_DISPOSAL_HEADER.CurrentRow != null) && (IDA_DISPOSAL_HEADER.CurrentRow.RowState != DataRowState.Added)))
                        {                        
                            IDA_DISPOSAL_HEADER.AddOver();
                            Header_Setting();
                        }
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (IDA_DISPOSAL_HEADER.IsFocused == true)
                    {
                        if ((IDA_DISPOSAL_HEADER.CurrentRow == null) || ((IDA_DISPOSAL_HEADER.CurrentRow != null) && (IDA_DISPOSAL_HEADER.CurrentRow.RowState != DataRowState.Added)))
                        {
                            IDA_DISPOSAL_HEADER.AddUnder();
                            Header_Setting();
                        }
                    }

                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if(iConvert.ISNull(H_SHIP_DATE.EditValue, "") == "")
                    {
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("WIP_10335"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);// Message : 선적일자는 필수입니다.
                        return;
                    }

                    IDA_DISPOSAL_HEADER.Update();
                    FORM_VALUE_SAVE();

                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (IDA_DISPOSAL_HEADER.IsFocused == true)
                    {
                        IDA_DISPOSAL_HEADER.Cancel();
                    }
                    else if (IDA_DISPOSAL_LINE.IsFocused == true)
                    {
                        IDA_DISPOSAL_LINE.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (IDA_DISPOSAL_HEADER.IsFocused == true)
                    {
                        if (line_data_check())
                        {
                            IDA_DISPOSAL_HEADER.Delete();
                        }
                        else
                        {
                            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10016"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);// 모듈 코드 입력
                        }
                    }
                    else if (IDA_DISPOSAL_LINE.IsFocused == true)
                    {
                        IDA_DISPOSAL_LINE.Delete();
                    }      
                }
            }
        }
        
        private void idaHEADER_ExcuteKeySearch(object pSender)
        {            
            idaHEADER_ExcuteQuery();
        }

        private void ilaTO_LOCATION_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ILD_BILL_TO_CUST.SetLookupParamValue("W_WAREHOUSE_ID", H_BILL_TO_CUST_ID.EditValue);
        }

        private void BT_TARGET_SELECT_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (H_DISPOSAL_HEADER_ID.EditValue == null)
            {
                //// LINE에 DATA가 있으면 DELETE //
                //int V_MAX_CNT = ISG_DISPOSAL_LINE.RowCount;

                //if (V_MAX_CNT > 0)
                //{
                //    for (int icnt = 0; icnt <= V_MAX_CNT - 1; icnt++)
                //    {
                //        IDA_DISPOSAL_LINE.Delete();
                //    }
                //}

                IDA_DISPOSAL_LINE.Cancel();

                // 변경전 제품 재고 정보를 Select 하여 Line에 뿌려줌//
                IDA_DISPOSAL_TARGET.Fill();

                foreach (DataRow row in IDA_DISPOSAL_TARGET.SelectRows)
                {
                    IDA_DISPOSAL_LINE.AddUnder();

                    ISG_DISPOSAL_LINE.SetCellValue("SELECT_FLAG", row["SELECT_FLAG"]);
                    ISG_DISPOSAL_LINE.SetCellValue("BOM_ITEM_CODE", row["BOM_ITEM_CODE"]);
                    ISG_DISPOSAL_LINE.SetCellValue("BOM_ITEM_DESCRIPTION", row["BOM_ITEM_DESCRIPTION"]);
                    ISG_DISPOSAL_LINE.SetCellValue("JOB_NO", row["JOB_NO"]);
                    ISG_DISPOSAL_LINE.SetCellValue("ITEM_UOM_CODE", row["ITEM_UOM_CODE"]);
                    ISG_DISPOSAL_LINE.SetCellValue("ONHAND_ITEM_UOM_QTY", row["ONHAND_ITEM_UOM_QTY"]);
                    ISG_DISPOSAL_LINE.SetCellValue("DISPOSAL_ITEM_UOM_QTY", row["DISPOSAL_ITEM_UOM_QTY"]);
                    ISG_DISPOSAL_LINE.SetCellValue("ONHAND_WORKING_UOM_CODE", row["ONHAND_WORKING_UOM_CODE"]);
                    ISG_DISPOSAL_LINE.SetCellValue("ONHAND_WORKING_UOM_QTY", row["ONHAND_WORKING_UOM_QTY"]);
                    ISG_DISPOSAL_LINE.SetCellValue("DISPOSAL_WORKING_UOM_CODE", row["DISPOSAL_WORKING_UOM_CODE"]);
                    ISG_DISPOSAL_LINE.SetCellValue("DISPOSAL_WORKING_UOM_QTY", row["DISPOSAL_WORKING_UOM_QTY"]);
                    ISG_DISPOSAL_LINE.SetCellValue("CURRENCY_CODE", row["CURRENCY_CODE"]);
                    ISG_DISPOSAL_LINE.SetCellValue("ITEM_PRICE", row["ITEM_PRICE"]);
                    ISG_DISPOSAL_LINE.SetCellValue("ITEM_AMOUNT", row["ITEM_AMOUNT"]);
                    ISG_DISPOSAL_LINE.SetCellValue("EXCHANGE_RATE", row["EXCHANGE_RATE"]);
                    ISG_DISPOSAL_LINE.SetCellValue("EXCHANGE_ITEM_AMOUNT", row["EXCHANGE_ITEM_AMOUNT"]);
                    ISG_DISPOSAL_LINE.SetCellValue("BOM_ITEM_ID", row["BOM_ITEM_ID"]);
                    ISG_DISPOSAL_LINE.SetCellValue("JOB_ID", row["JOB_ID"]);
                    ISG_DISPOSAL_LINE.SetCellValue("WIP_OPERATION_ID", row["WIP_OPERATION_ID"]);
                }

            }
        }

        private void C_SELECT_FLAG_CheckedChange(object pSender, ISCheckEventArgs e)
        {
            for (int vLoop = 0; vLoop < ISG_DISPOSAL_LINE.RowCount; vLoop++)
            {
                ISG_DISPOSAL_LINE.SetCellValue(vLoop, 0, C_SELECT_FLAG.CheckBoxValue.ToString());
                //IDA_DISPOSAL_LINE.OraSelectData.AcceptChanges();
                //IDA_DISPOSAL_LINE.Refillable = true;
                if (e.CheckedState == ISUtil.Enum.CheckedState.Checked)
                {
                    ISGridAdvExChangedEventArgs vISGridAdvExChangedEventArgs = new ISGridAdvExChangedEventArgs(vLoop, 0, "N", "Y");
                    ISG_DISPOSAL_LINE_CurrentCellChanged(this, vISGridAdvExChangedEventArgs);
                }
                else
                {
                    ISGridAdvExChangedEventArgs vISGridAdvExChangedEventArgs = new ISGridAdvExChangedEventArgs(vLoop, 0, "Y", "N");
                    ISG_DISPOSAL_LINE_CurrentCellChanged(this, vISGridAdvExChangedEventArgs);
                }
            }
        }



        #endregion;   

        private void ISG_DISPOSAL_LINE_CurrentCellChanged(object pSender, ISGridAdvExChangedEventArgs e)
        {
            switch (ISG_DISPOSAL_LINE.GridAdvExColElement[e.ColIndex].DataColumn.ToString())
            {
                case "SELECT_FLAG":
                    if (e.NewValue.ToString() == Convert.ToString("Y"))
                    {
                        ISG_DISPOSAL_LINE.SetCellValue(e.RowIndex, ISG_DISPOSAL_LINE.GetColumnToIndex("DISPOSAL_ITEM_UOM_QTY"),
                                                       Convert.ToDecimal(ISG_DISPOSAL_LINE.GetCellValue(e.RowIndex, ISG_DISPOSAL_LINE.GetColumnToIndex("ONHAND_ITEM_UOM_QTY"))));
                        ISG_DISPOSAL_LINE.SetCellValue(e.RowIndex, ISG_DISPOSAL_LINE.GetColumnToIndex("DISPOSAL_WORKING_UOM_QTY"),
                                                       Convert.ToDecimal(ISG_DISPOSAL_LINE.GetCellValue(e.RowIndex, ISG_DISPOSAL_LINE.GetColumnToIndex("ONHAND_WORKING_UOM_QTY"))));
                        ISG_DISPOSAL_LINE.SetCellValue(e.RowIndex, ISG_DISPOSAL_LINE.GetColumnToIndex("ITEM_AMOUNT"), 
                                                       Convert.ToDecimal(ISG_DISPOSAL_LINE.GetCellValue(e.RowIndex, ISG_DISPOSAL_LINE.GetColumnToIndex("ITEM_PRICE")))
                                                       * Convert.ToDecimal(ISG_DISPOSAL_LINE.GetCellValue(e.RowIndex, ISG_DISPOSAL_LINE.GetColumnToIndex("DISPOSAL_WORKING_UOM_QTY"))));
                        ISG_DISPOSAL_LINE.SetCellValue(e.RowIndex, ISG_DISPOSAL_LINE.GetColumnToIndex("EXCHANGE_ITEM_AMOUNT"), 
                                                       Convert.ToDecimal(ISG_DISPOSAL_LINE.GetCellValue(e.RowIndex,ISG_DISPOSAL_LINE.GetColumnToIndex("ITEM_AMOUNT"))) 
                                                       * Convert.ToDecimal(ISG_DISPOSAL_LINE.GetCellValue(e.RowIndex, ISG_DISPOSAL_LINE.GetColumnToIndex("EXCHANGE_RATE"))));

                        //ISG_DISPOSAL_LINE.SetCellValue("DISPOSAL_QTY", Convert.ToDecimal(ISG_DISPOSAL_LINE.GetCellValue("ONHAND_QTY")));
                        //ISG_DISPOSAL_LINE.SetCellValue("ITEM_AMOUNT", Convert.ToDecimal(ISG_DISPOSAL_LINE.GetCellValue("ITEM_PRICE")) * Convert.ToDecimal(ISG_DISPOSAL_LINE.GetCellValue("DISPOSAL_QTY")));
                        //ISG_DISPOSAL_LINE.SetCellValue("EXCHANGE_ITEM_AMOUNT", Convert.ToDecimal(ISG_DISPOSAL_LINE.GetCellValue("ITEM_AMOUNT")) * Convert.ToDecimal(ISG_DISPOSAL_LINE.GetCellValue("EXCHANGE_RATE")));
                    }
                    else
                    {
                        ISG_DISPOSAL_LINE.SetCellValue(e.RowIndex, ISG_DISPOSAL_LINE.GetColumnToIndex("DISPOSAL_ITEM_UOM_QTY"), 0);
                        ISG_DISPOSAL_LINE.SetCellValue(e.RowIndex, ISG_DISPOSAL_LINE.GetColumnToIndex("DISPOSAL_WORKING_UOM_QTY"), 0);
                        ISG_DISPOSAL_LINE.SetCellValue(e.RowIndex, ISG_DISPOSAL_LINE.GetColumnToIndex("ITEM_AMOUNT"), 0);
                        ISG_DISPOSAL_LINE.SetCellValue(e.RowIndex, ISG_DISPOSAL_LINE.GetColumnToIndex("EXCHANGE_ITEM_AMOUNT"), 0);

                        //ISG_DISPOSAL_LINE.SetCellValue("DISPOSAL_QTY", 0);
                        //ISG_DISPOSAL_LINE.SetCellValue("ITEM_AMOUNT", 0);
                        //ISG_DISPOSAL_LINE.SetCellValue("EXCHANGE_ITEM_AMOUNT", 0);
                    }
                    Total_Summary();
                    break;

                case "CURRENCY_CODE":
                    ISG_DISPOSAL_LINE.SetCellValue("EXCHANGE_ITEM_AMOUNT", Convert.ToDecimal(ISG_DISPOSAL_LINE.GetCellValue("ITEM_AMOUNT")) * Convert.ToDecimal(ISG_DISPOSAL_LINE.GetCellValue("EXCHANGE_RATE")));
                    Total_Summary();
                    break;

                case "ITEM_PRICE":
                    ISG_DISPOSAL_LINE.SetCellValue("ITEM_AMOUNT", Convert.ToDecimal(e.NewValue) * Convert.ToDecimal(ISG_DISPOSAL_LINE.GetCellValue("DISPOSAL_WORKING_UOM_QTY")));
                    ISG_DISPOSAL_LINE.SetCellValue("EXCHANGE_ITEM_AMOUNT", Convert.ToDecimal(ISG_DISPOSAL_LINE.GetCellValue("ITEM_AMOUNT")) * Convert.ToDecimal(ISG_DISPOSAL_LINE.GetCellValue("EXCHANGE_RATE")));
                    Total_Summary();
                    break;

                case "ITEM_AMOUNT":
                    ISG_DISPOSAL_LINE.SetCellValue("EXCHANGE_ITEM_AMOUNT", Convert.ToDecimal(e.NewValue) * Convert.ToDecimal(ISG_DISPOSAL_LINE.GetCellValue("EXCHANGE_RATE")));
                    Total_Summary();
                    break;

                case "EXCHANGE_RATE":
                    ISG_DISPOSAL_LINE.SetCellValue("EXCHANGE_ITEM_AMOUNT", Convert.ToDecimal(ISG_DISPOSAL_LINE.GetCellValue("ITEM_AMOUNT")) * Convert.ToDecimal(e.NewValue));
                    Total_Summary();
                    break;

                default:
                    break;
            }
        }

        private void Total_Summary()
        {
            S_ITEM_AMOUNT.EditValue = (int)0;
            S_EXCHANGE_ITEM_AMOUNT.EditValue = (int)0;

            decimal V_ITEM_QTY = 0;
            decimal V_ITEM_AMOUNT = 0;
            decimal V_EXCHANGE_ITEM_AMOUNT = 0;


            for (int vLoop = 0; vLoop < ISG_DISPOSAL_LINE.RowCount; vLoop++)
            {
                V_ITEM_QTY = V_ITEM_QTY + iConvert.ISDecimaltoZero(ISG_DISPOSAL_LINE.GetCellValue(vLoop, ISG_DISPOSAL_LINE.GetColumnToIndex("DISPOSAL_WORKING_UOM_QTY")));
                V_ITEM_AMOUNT = V_ITEM_AMOUNT + iConvert.ISDecimaltoZero(ISG_DISPOSAL_LINE.GetCellValue(vLoop, ISG_DISPOSAL_LINE.GetColumnToIndex("ITEM_AMOUNT")));
                V_EXCHANGE_ITEM_AMOUNT = V_EXCHANGE_ITEM_AMOUNT + iConvert.ISDecimaltoZero(ISG_DISPOSAL_LINE.GetCellValue(vLoop, ISG_DISPOSAL_LINE.GetColumnToIndex("EXCHANGE_ITEM_AMOUNT")));
            }

            S_ITEM_QTY.EditValue = V_ITEM_QTY;
            S_ITEM_AMOUNT.EditValue = V_ITEM_AMOUNT;
            S_EXCHANGE_ITEM_AMOUNT.EditValue = V_EXCHANGE_ITEM_AMOUNT;
            
        }

        private void ISG_DISPOSAL_LIST_CellDoubleClick(object pSender)
        {
            if (IDA_DISPOSAL_HEADER.Refillable == true && IDA_DISPOSAL_LINE.Refillable == true)
            {
                H_DISPOSAL_HEADER_ID.EditValue = ISG_DISPOSAL_LIST.GetCellValue("DISPOSAL_HEADER_ID");

                IDA_DISPOSAL_HEADER.OraSelectData.AcceptChanges();
                IDA_DISPOSAL_HEADER.Refillable = true;

                IDA_DISPOSAL_HEADER.Fill();
                Total_Summary();
                BUTTON_DISABLE();

                TAB_MAIN.SelectedIndex = 0;

            }
            else
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("PO_10014"), "WARRING", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        private void BUTTON_ENABLE()
        {
            C_SELECT_FLAG.Enabled = true;
            BT_TARGET_SELECT.Enabled = true;
        }

        private void BUTTON_DISABLE()
        {
            C_SELECT_FLAG.Enabled = false;
            BT_TARGET_SELECT.Enabled = false;
        }

        private void BT_PRICE_APPLY_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            for (int vLoop = 0; vLoop < ISG_DISPOSAL_LINE.RowCount; vLoop++)
            {
                if (ISG_DISPOSAL_LINE.GetCellValue(vLoop, ISG_DISPOSAL_LINE.GetColumnToIndex("SELECT_FLAG")).ToString() == Convert.ToString("Y"))
                {
                    ISG_DISPOSAL_LINE.SetCellValue(vLoop, ISG_DISPOSAL_LINE.GetColumnToIndex("ITEM_PRICE"), Convert.ToDecimal(T_DISPOSAL_PRICE.EditValue));
                    ISG_DISPOSAL_LINE.SetCellValue(vLoop, ISG_DISPOSAL_LINE.GetColumnToIndex("ITEM_AMOUNT"),
                                                   Convert.ToDecimal(ISG_DISPOSAL_LINE.GetCellValue(vLoop, ISG_DISPOSAL_LINE.GetColumnToIndex("ITEM_PRICE")))
                                                   * Convert.ToDecimal(ISG_DISPOSAL_LINE.GetCellValue(vLoop, ISG_DISPOSAL_LINE.GetColumnToIndex("DISPOSAL_WORKING_UOM_QTY"))));
                    ISG_DISPOSAL_LINE.SetCellValue(vLoop, ISG_DISPOSAL_LINE.GetColumnToIndex("EXCHANGE_ITEM_AMOUNT"),
                                                   Convert.ToDecimal(ISG_DISPOSAL_LINE.GetCellValue(vLoop, ISG_DISPOSAL_LINE.GetColumnToIndex("ITEM_AMOUNT")))
                                                   * Convert.ToDecimal(ISG_DISPOSAL_LINE.GetCellValue(vLoop, ISG_DISPOSAL_LINE.GetColumnToIndex("EXCHANGE_RATE"))));

                }
            }
            Total_Summary();
        }

        private void FORM_VALUE_SAVE()
        {
            P_SAVE_FLAG = "Y";
            P_DISPOSAL_DATE = H_DISPOSAL_DATE.EditValue;
            P_BILL_TO_CUST_ID = H_BILL_TO_CUST_ID.EditValue;
            P_BILL_TO_CUST_CODE = H_BILL_TO_CUST_CODE.EditValue.ToString();
            P_BILL_TO_CUST_DESC = H_BILL_TO_CUST_DESC.EditValue.ToString();
            P_SHIP_TO_CUST_ID = H_SHIP_TO_CUST_ID.EditValue;
            P_SHIP_TO_CUST_CODE = H_SHIP_TO_CUST_CODE.EditValue.ToString();
            P_SHIP_TO_CUST_DESC = H_SHIP_TO_CUST_DESC.EditValue.ToString();
            P_INVOICE_NO = H_INVOICE_NO.EditValue.ToString();
        }

        private void FORM_VALUE_SETTING()
        {
            H_DISPOSAL_DATE.EditValue = P_DISPOSAL_DATE;
            H_BILL_TO_CUST_CODE.EditValue = P_BILL_TO_CUST_CODE;
            H_BILL_TO_CUST_DESC.EditValue = P_BILL_TO_CUST_DESC;
            H_BILL_TO_CUST_ID.EditValue = P_BILL_TO_CUST_ID;
            H_SHIP_TO_CUST_CODE.EditValue = P_SHIP_TO_CUST_CODE;
            H_SHIP_TO_CUST_DESC.EditValue = P_SHIP_TO_CUST_DESC;
            H_SHIP_TO_CUST_ID.EditValue = P_SHIP_TO_CUST_ID;
            H_INVOICE_NO.EditValue = P_INVOICE_NO;
        }

        private void ILA_BILL_TO_CUST_SelectedRowData(object pSender)
        {
            IDA_DISPOSAL_LINE.Cancel();
        }

        private void ILA_MAIN_ITEM_SelectedRowData(object pSender)
        {
            IDA_DISPOSAL_LINE.Cancel();
        }

        private void ILA_OPERATION_SelectedRowData(object pSender)
        {
            IDA_DISPOSAL_LINE.Cancel();
        }
    }
}