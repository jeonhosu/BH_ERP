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

namespace FCMF0865
{
    public partial class SLIP_IF_DETAIL : Office2007Form
    {
        #region ----- Variables -----
        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        object mHEADER_INTERFACE_ID;

        #endregion;

        #region ----- Constructor -----

        public SLIP_IF_DETAIL(ISAppInterface pAppInterface, object pHEADER_INTERFACE_ID)
        {
            InitializeComponent();
            isAppInterfaceAdv1.AppInterface = pAppInterface;

            mHEADER_INTERFACE_ID = pHEADER_INTERFACE_ID;
        }

        #endregion;

        #region ----- Private Methods ----

        private void Search_DB()
        {
            if (iString.ISNull(mHEADER_INTERFACE_ID) != string.Empty)
            {
                idaSLIP_HEADER.SetSelectParamValue("W_HEADER_INTERFACE_ID", mHEADER_INTERFACE_ID);
                idaSLIP_HEADER.Fill();
                SLIP_TYPE_NAME.Focus();
            }
        }
        private void Init_Total_GL_Amount()
        {
            decimal vDR_Amount = Convert.ToDecimal(0);
            decimal vCR_Amount = Convert.ToDecimal(0);
            decimal vCurrency_DR_Amount = Convert.ToInt32(0);
            if (igrSLIP_LINE.RowCount > 0)
            {
                for (int r = 0; r < igrSLIP_LINE.RowCount; r++)
                {
                    if (iString.ISNull(igrSLIP_LINE.GetCellValue(r, igrSLIP_LINE.GetColumnToIndex("ACCOUNT_DR_CR")), "3") == "1".ToString())
                    {
                        vDR_Amount = vDR_Amount + iString.ISDecimaltoZero(igrSLIP_LINE.GetCellValue(r, igrSLIP_LINE.GetColumnToIndex("GL_AMOUNT")));
                        vCurrency_DR_Amount = vCurrency_DR_Amount + iString.ISDecimaltoZero(igrSLIP_LINE.GetCellValue(r, igrSLIP_LINE.GetColumnToIndex("GL_CURRENCY_AMOUNT")));
                    }
                    else if (iString.ISNull(igrSLIP_LINE.GetCellValue(r, igrSLIP_LINE.GetColumnToIndex("ACCOUNT_DR_CR")), "3") == "2".ToString())
                    {
                        vCR_Amount = vCR_Amount + iString.ISDecimaltoZero(igrSLIP_LINE.GetCellValue(r, igrSLIP_LINE.GetColumnToIndex("GL_AMOUNT")));
                    }
                }
            }
            TOTAL_DR_AMOUNT.EditValue = iString.ISDecimaltoZero(vDR_Amount);
            TOTAL_CR_AMOUNT.EditValue = iString.ISDecimaltoZero(vCR_Amount);
            MARGIN_AMOUNT.EditValue = -(System.Math.Abs(iString.ISDecimaltoZero(vDR_Amount) - iString.ISDecimaltoZero(vCR_Amount))); ;
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

        #region ----- Form Event -----
        
        private void SLIP_IF_DETAIL_Shown(object sender, EventArgs e)
        {
            Search_DB();
            Application.DoEvents();
            this.Cursor = System.Windows.Forms.Cursors.Default;
            Application.UseWaitCursor = false;
        }

        private void btnCLOSE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            Application.UseWaitCursor = true;
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            Application.DoEvents();
            this.Close();
        }
        
        #endregion

        #region ------ Lookup Event ------

        #endregion

        #region ------ Adapter Event ------

        private void idaSLIP_LINE_NewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            Init_Total_GL_Amount();
        }

        #endregion             

    }
}