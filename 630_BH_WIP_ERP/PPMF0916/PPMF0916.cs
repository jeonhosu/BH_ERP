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

namespace PPMF0916
{
    public partial class PPMF0916 : Office2007Form
    {
        #region ----- Variables -----

        private ISCommonUtil.ISFunction.ISConvert iConvert = new ISFunction.ISConvert();
        private ISCommonUtil.ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        string mBASE_CURRENCY;

        #endregion;

        #region ----- Constructor -----

        public PPMF0916(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void Search_DB()
        {
            int vIDX_DISPOSAL_HEADER_ID = IGR_DISPOSAL_LIST.GetColumnToIndex("DISPOSAL_HEADER_ID");
            int vIDX_INVOICE_NO = IGR_DISPOSAL_LIST.GetColumnToIndex("INVOICE_NO");
            string vDISPOSAL_HEADER_ID = iConvert.ISNull(IGR_DISPOSAL_LIST.GetCellValue("DISPOSAL_HEADER_ID"));

            IGR_DISPOSAL_LIST.LastConfirmChanges();
            IDA_DISPOSAL_LIST.OraSelectData.AcceptChanges();
            IDA_DISPOSAL_LIST.Refillable = true;

            IDA_DISPOSAL_LIST.Fill();

            if (vDISPOSAL_HEADER_ID == string.Empty)
            {
                IGR_DISPOSAL_LIST.Focus();
                return;
            }

            for (int r = 0; r < IGR_DISPOSAL_LIST.RowCount; r++)
            {
                if (vDISPOSAL_HEADER_ID == iConvert.ISNull(IGR_DISPOSAL_LIST.GetCellValue(r, vIDX_DISPOSAL_HEADER_ID)))
                {
                    IGR_DISPOSAL_LIST.CurrentCellMoveTo(r, vIDX_INVOICE_NO);
                    IGR_DISPOSAL_LIST.CurrentCellActivate(r, vIDX_INVOICE_NO);
                    IGR_DISPOSAL_LIST.Focus();
                    return;
                }
            }
            IGR_DISPOSAL_LIST.Focus();
        }

        private void Sync_Grid_Status(string pSummary_Flag)
        {
            if (pSummary_Flag == "N")
            {
                IGR_DISPOSAL_DTL.GridAdvExColElement[IGR_DISPOSAL_DTL.GetColumnToIndex("CURRENCY_CODE")].Updatable = 1;                
                IGR_DISPOSAL_DTL.GridAdvExColElement[IGR_DISPOSAL_DTL.GetColumnToIndex("ITEM_PRICE")].Updatable = 1;
                IGR_DISPOSAL_DTL.GridAdvExColElement[IGR_DISPOSAL_DTL.GetColumnToIndex("ITEM_AMOUNT")].Updatable = 1;
                IGR_DISPOSAL_DTL.GridAdvExColElement[IGR_DISPOSAL_DTL.GetColumnToIndex("EXCHANGE_RATE")].Updatable = 1;
                IGR_DISPOSAL_DTL.GridAdvExColElement[IGR_DISPOSAL_DTL.GetColumnToIndex("EXCHANGE_ITEM_AMOUNT")].Updatable = 1;
            }
            else
            {
                IGR_DISPOSAL_DTL.GridAdvExColElement[IGR_DISPOSAL_DTL.GetColumnToIndex("CURRENCY_CODE")].Updatable = 0;
                IGR_DISPOSAL_DTL.GridAdvExColElement[IGR_DISPOSAL_DTL.GetColumnToIndex("ITEM_PRICE")].Updatable = 0;
                IGR_DISPOSAL_DTL.GridAdvExColElement[IGR_DISPOSAL_DTL.GetColumnToIndex("ITEM_AMOUNT")].Updatable = 0;
                IGR_DISPOSAL_DTL.GridAdvExColElement[IGR_DISPOSAL_DTL.GetColumnToIndex("EXCHANGE_RATE")].Updatable = 0;
                IGR_DISPOSAL_DTL.GridAdvExColElement[IGR_DISPOSAL_DTL.GetColumnToIndex("EXCHANGE_ITEM_AMOUNT")].Updatable = 0;
            }
        }

        //private void Total_Computing_Amount()
        //{
        //    iedSLIP_AMOUNT.EditValue = (int)0;
        //    iedTAX_AMOUNT.EditValue = (int)0;
        //    iedAMOUNT_1.EditValue = (int)0;
        //    iedAMOUNT_2.EditValue = (int)0;
        //    iedAMOUNT_3.EditValue = (int)0;
        //    iedAMOUNT_4.EditValue = (int)0;
        //    iedAMOUNT_5.EditValue = (int)0;

        //    isGridAdvEx2.LastConfirmChanges();

        //    for (int vLoop = 0; vLoop < isGridAdvEx2.RowCount; vLoop++)
        //    {
        //        if (isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("SELECT_FLAG")).ToString() == "Y")
        //        {
        //            iedSLIP_AMOUNT.EditValue = Convert.ToDecimal(iedSLIP_AMOUNT.EditValue) +
        //                                            Convert.ToDecimal(isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("ADJUST_AMOUNT")));

        //            iedTAX_AMOUNT.EditValue = System.Math.Truncate(Convert.ToDecimal(iedSLIP_AMOUNT.EditValue) / 10);

        //            if (isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("ACCOUNT_CODE")).ToString() == "1120400")
        //            {
        //                iedAMOUNT_1.EditValue = Convert.ToDecimal(iedAMOUNT_1.EditValue) +
        //                                            Convert.ToDecimal(isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("ADJUST_AMOUNT")));
        //            }
        //            else if (isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("ACCOUNT_CODE")).ToString() == "5132001")
        //            {
        //                iedAMOUNT_2.EditValue = Convert.ToDecimal(iedAMOUNT_2.EditValue) +
        //                                            Convert.ToDecimal(isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("ADJUST_AMOUNT")));
        //            }
        //            else if (isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("ACCOUNT_CODE")).ToString() == "1220300")
        //            {
        //                iedAMOUNT_3.EditValue = Convert.ToDecimal(iedAMOUNT_3.EditValue) +
        //                                            Convert.ToDecimal(isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("ADJUST_AMOUNT")));
        //            }
        //            else if (isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("ACCOUNT_CODE")).ToString() == "1120200")
        //            {
        //                iedAMOUNT_4.EditValue = Convert.ToDecimal(iedAMOUNT_4.EditValue) +
        //                                            Convert.ToDecimal(isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("ADJUST_AMOUNT")));
        //            }
        //            else if (isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("ACCOUNT_CODE")).ToString() == "5131503")
        //            {
        //                iedAMOUNT_5.EditValue = Convert.ToDecimal(iedAMOUNT_5.EditValue) +
        //                                            Convert.ToDecimal(isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("ADJUST_AMOUNT")));
        //            }
        //        }
        //    }            
        //}

        #endregion;

        #region ----- Events -----

        private void PPMF0916_Load(object sender, EventArgs e)
        {
            W_PERIOD_NAME.EditValue = iDate.ISYearMonth(DateTime.Today);

            IDA_DISPOSAL_LIST.FillSchema();
            IDA_DISPOSAL_DTL.FillSchema();

            IDC_BASE_CURRENCY.ExecuteNonQuery();
            mBASE_CURRENCY = iConvert.ISNull(IDC_BASE_CURRENCY.GetCommandParamValue("O_CURRENCY_CODE"));
        }
         
        private void ilaPERIOD_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildPERIOD.SetLookupParamValue("W_CLOSE_TYPE", "SHIP_ADJ");

        }

        private void IGR_DISPOSAL_DTL_CurrentCellChanged(object pSender, ISGridAdvExChangedEventArgs e)
        {
            decimal vDISPOSAL_ITEM_UOM_QTY = iConvert.ISDecimaltoZero(IGR_DISPOSAL_DTL.GetCellValue("DISPOSAL_ITEM_UOM_QTY"));
            decimal vITEM_PRICE = iConvert.ISDecimaltoZero(IGR_DISPOSAL_DTL.GetCellValue("ITEM_PRICE"));
            decimal vITEM_AMOUNT = iConvert.ISDecimaltoZero(IGR_DISPOSAL_DTL.GetCellValue("ITEM_AMOUNT"));
            decimal vEXCHANGE_RATE = iConvert.ISDecimaltoZero(IGR_DISPOSAL_DTL.GetCellValue("EXCHANGE_RATE"));
            decimal vEXCHANGE_ITEM_AMOUNT = iConvert.ISDecimaltoZero(IGR_DISPOSAL_DTL.GetCellValue("EXCHANGE_ITEM_AMOUNT"));
            if (e.ColIndex == IGR_DISPOSAL_DTL.GetColumnToIndex("ITEM_PRICE"))
            {
                vITEM_PRICE = iConvert.ISDecimaltoZero(e.NewValue);

                vITEM_AMOUNT = Math.Round(vDISPOSAL_ITEM_UOM_QTY * vITEM_PRICE, 2);
                vEXCHANGE_ITEM_AMOUNT = Math.Round(vITEM_AMOUNT * vEXCHANGE_RATE);

                IGR_DISPOSAL_DTL.SetCellValue("ITEM_AMOUNT", vITEM_AMOUNT);
                IGR_DISPOSAL_DTL.SetCellValue("EXCHANGE_ITEM_AMOUNT", vEXCHANGE_ITEM_AMOUNT);
            }
            else if (e.ColIndex == IGR_DISPOSAL_DTL.GetColumnToIndex("ITEM_AMOUNT"))
            {
                vITEM_AMOUNT = iConvert.ISDecimaltoZero(e.NewValue);
                vEXCHANGE_ITEM_AMOUNT = Math.Round(vITEM_AMOUNT * vEXCHANGE_RATE);

                IGR_DISPOSAL_DTL.SetCellValue("ITEM_AMOUNT", vITEM_AMOUNT);
                IGR_DISPOSAL_DTL.SetCellValue("EXCHANGE_ITEM_AMOUNT", vEXCHANGE_ITEM_AMOUNT);
            }
            else if (e.ColIndex == IGR_DISPOSAL_DTL.GetColumnToIndex("EXCHANGE_RATE"))
            {
                vEXCHANGE_RATE = iConvert.ISDecimaltoZero(e.NewValue);
                vEXCHANGE_ITEM_AMOUNT = Math.Round(vITEM_AMOUNT * vEXCHANGE_RATE);

                IGR_DISPOSAL_DTL.SetCellValue("ITEM_AMOUNT", vITEM_AMOUNT);
                IGR_DISPOSAL_DTL.SetCellValue("EXCHANGE_ITEM_AMOUNT", vEXCHANGE_ITEM_AMOUNT);
            } 
        }
         
        #endregion;

        #region ----- MDi ToolBar Button Event ----

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
                    IDA_DISPOSAL_LIST.Update();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    IDA_DISPOSAL_DTL.Cancel();
                    IDA_DISPOSAL_LIST.Cancel();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {
                     
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                     
                }
            }
        }

        private void IDA_DISPOSAL_DTL_NewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            if (pBindingManager.DataRow == null)
            {
                Sync_Grid_Status("N");
                return;
            }
            Sync_Grid_Status(iConvert.ISNull(pBindingManager.DataRow["SUMMARY_FLAG"]));
        }

        #endregion;

    }
}