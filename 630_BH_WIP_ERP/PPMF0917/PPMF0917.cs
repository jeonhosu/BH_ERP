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

namespace PPMF0917
{
    public partial class PPMF0917 : Office2007Form
    {
        #region ----- Variables -----

        private ISCommonUtil.ISFunction.ISConvert iConvert = new ISFunction.ISConvert();
        private ISCommonUtil.ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public PPMF0917(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void Search_DB()
        {
            int vIDX_DISPOSAL_HEADER_ID = IGR_PURCHASE_LIST.GetColumnToIndex("DISPOSAL_HEADER_ID");
            int vIDX_INVOICE_NO = IGR_PURCHASE_LIST.GetColumnToIndex("INVOICE_NO");
            string vDISPOSAL_HEADER_ID = iConvert.ISNull(IGR_PURCHASE_LIST.GetCellValue("DISPOSAL_HEADER_ID"));
            
            IGR_PURCHASE_LIST.LastConfirmChanges();
            IDA_PURCHASE_LIST.OraSelectData.AcceptChanges();
            IDA_PURCHASE_LIST.Refillable = true;

            IDA_PURCHASE_LIST.Fill();

            if (vDISPOSAL_HEADER_ID == string.Empty)
            {
                IGR_PURCHASE_LIST.Focus();
                return;
            }

            for (int r = 0; r < IGR_PURCHASE_LIST.RowCount; r++)
            {
                if (vDISPOSAL_HEADER_ID == iConvert.ISNull(IGR_PURCHASE_LIST.GetCellValue(r, vIDX_DISPOSAL_HEADER_ID)))
                {
                    IGR_PURCHASE_LIST.CurrentCellMoveTo(r, vIDX_INVOICE_NO);
                    IGR_PURCHASE_LIST.CurrentCellActivate(r, vIDX_INVOICE_NO);
                    IGR_PURCHASE_LIST.Focus();
                    return;
                }
            }
            IGR_PURCHASE_LIST.Focus();
        }

        private void Sync_Grid_Status(string pSummary_Flag)
        {
            if (pSummary_Flag == "N")
            {
                IGR_PURCHASE_DTL.GridAdvExColElement[IGR_PURCHASE_DTL.GetColumnToIndex("CURRENCY_CODE")].Updatable = 1;
                IGR_PURCHASE_DTL.GridAdvExColElement[IGR_PURCHASE_DTL.GetColumnToIndex("ITEM_PRICE")].Updatable = 1;
                IGR_PURCHASE_DTL.GridAdvExColElement[IGR_PURCHASE_DTL.GetColumnToIndex("ITEM_AMOUNT")].Updatable = 1;
                IGR_PURCHASE_DTL.GridAdvExColElement[IGR_PURCHASE_DTL.GetColumnToIndex("EXCHANGE_RATE")].Updatable = 1;
                IGR_PURCHASE_DTL.GridAdvExColElement[IGR_PURCHASE_DTL.GetColumnToIndex("EXCHANGE_ITEM_AMOUNT")].Updatable = 1;
            }
            else
            {
                IGR_PURCHASE_DTL.GridAdvExColElement[IGR_PURCHASE_DTL.GetColumnToIndex("CURRENCY_CODE")].Updatable = 0;
                IGR_PURCHASE_DTL.GridAdvExColElement[IGR_PURCHASE_DTL.GetColumnToIndex("ITEM_PRICE")].Updatable = 0;
                IGR_PURCHASE_DTL.GridAdvExColElement[IGR_PURCHASE_DTL.GetColumnToIndex("ITEM_AMOUNT")].Updatable = 0;
                IGR_PURCHASE_DTL.GridAdvExColElement[IGR_PURCHASE_DTL.GetColumnToIndex("EXCHANGE_RATE")].Updatable = 0;
                IGR_PURCHASE_DTL.GridAdvExColElement[IGR_PURCHASE_DTL.GetColumnToIndex("EXCHANGE_ITEM_AMOUNT")].Updatable = 0;
            }
        }

        #endregion;

        #region ----- Events -----

        private void PPMF0917_Load(object sender, EventArgs e)
        {
            W_PERIOD_NAME.EditValue = iDate.ISYearMonth(DateTime.Today);

            IDA_PURCHASE_LIST.FillSchema();
            IDA_PURCHASE_DTL.FillSchema(); 
        }

        private void ilaPERIOD_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildPERIOD.SetLookupParamValue("W_CLOSE_TYPE", "SHIP_ADJ");
        }

        private void IGR_PURCHASE_DTL_CurrentCellChanged(object pSender, ISGridAdvExChangedEventArgs e)
        {
            decimal vINVOICE_UOM_QTY = iConvert.ISDecimaltoZero(IGR_PURCHASE_DTL.GetCellValue("INVOICE_UOM_QTY"));
            decimal vITEM_PRICE = iConvert.ISDecimaltoZero(IGR_PURCHASE_DTL.GetCellValue("ITEM_PRICE"));
            decimal vITEM_AMOUNT = iConvert.ISDecimaltoZero(IGR_PURCHASE_DTL.GetCellValue("ITEM_AMOUNT"));
            decimal vEXCHANGE_RATE = iConvert.ISDecimaltoZero(IGR_PURCHASE_DTL.GetCellValue("EXCHANGE_RATE"));
            decimal vEXCHANGE_ITEM_AMOUNT = iConvert.ISDecimaltoZero(IGR_PURCHASE_DTL.GetCellValue("EXCHANGE_ITEM_AMOUNT"));
            if (e.ColIndex == IGR_PURCHASE_DTL.GetColumnToIndex("ITEM_PRICE"))
            {
                vITEM_PRICE = iConvert.ISDecimaltoZero(e.NewValue);

                vITEM_AMOUNT = Math.Round(vINVOICE_UOM_QTY * vITEM_PRICE, 2);
                vEXCHANGE_ITEM_AMOUNT = Math.Round(vITEM_AMOUNT * vEXCHANGE_RATE);

                IGR_PURCHASE_DTL.SetCellValue("ITEM_AMOUNT", vITEM_AMOUNT);
                IGR_PURCHASE_DTL.SetCellValue("EXCHANGE_ITEM_AMOUNT", vEXCHANGE_ITEM_AMOUNT);
            }
            else if (e.ColIndex == IGR_PURCHASE_DTL.GetColumnToIndex("ITEM_AMOUNT"))
            {
                vITEM_AMOUNT = iConvert.ISDecimaltoZero(e.NewValue);
                vEXCHANGE_ITEM_AMOUNT = Math.Round(vITEM_AMOUNT * vEXCHANGE_RATE);

                IGR_PURCHASE_DTL.SetCellValue("ITEM_AMOUNT", vITEM_AMOUNT);
                IGR_PURCHASE_DTL.SetCellValue("EXCHANGE_ITEM_AMOUNT", vEXCHANGE_ITEM_AMOUNT);
            }
            else if (e.ColIndex == IGR_PURCHASE_DTL.GetColumnToIndex("EXCHANGE_RATE"))
            {
                vEXCHANGE_RATE = iConvert.ISDecimaltoZero(e.NewValue);
                vEXCHANGE_ITEM_AMOUNT = Math.Round(vITEM_AMOUNT * vEXCHANGE_RATE);

                IGR_PURCHASE_DTL.SetCellValue("ITEM_AMOUNT", vITEM_AMOUNT);
                IGR_PURCHASE_DTL.SetCellValue("EXCHANGE_ITEM_AMOUNT", vEXCHANGE_ITEM_AMOUNT);
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
                    IDA_PURCHASE_LIST.Update();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    IDA_PURCHASE_LIST.Cancel();
                    IDA_PURCHASE_DTL.Cancel();
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

        #endregion;

        #region ----- Adapter Event ----- 
        
        private void IDA_PURCHASE_DTL_NewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            if (pBindingManager.DataRow == null)
            {
                Sync_Grid_Status("N");
                return;
            }
            Sync_Grid_Status(iConvert.ISNull(pBindingManager.DataRow["SUMMARY_FLAG"]));
        }
        
        #endregion

    }
}