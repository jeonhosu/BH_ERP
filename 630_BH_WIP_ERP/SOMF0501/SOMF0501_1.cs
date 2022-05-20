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

namespace SOMF0501
{
    public partial class SOMF0501_1 : Office2007Form
    {
        #region ----- Variables -----

        //private object[] mObject = new object[9];

        //public object[] pSOMF0501_1
        //{
        //    get
        //    {
        //        return mObject;
        //    }
        //    set
        //    {
        //        mObject = value;
        //    }
        //}

        private object mObject = new object();

        public object pCharge_Amount_Tot
        {
            get
            {
                return mObject;
            }
            set
            {
                mObject = value;
            }
        }

        #endregion;

        #region ----- Constructor -----

        public SOMF0501_1(ISAppInterface pAppInterface, object pORDER_LINE_ID, object pORDER_HEADER_ID, object pORDER_NO, object pORDER_LINE_NO, object pCURRENCY_CODE, object pITEM_CODE, object pITEM_DESCRIPTION, object pORDER_QTY)
        {
            InitializeComponent();

            isAppInterfaceAdv1.AppInterface = pAppInterface;

            iedORDER_LINE_ID.EditValue = pORDER_LINE_ID;
            iedORDER_HEADER_ID.EditValue = pORDER_HEADER_ID;
            iedORDER_NO.EditValue = pORDER_NO;
            iedORDER_LINE_NO.EditValue = pORDER_LINE_NO;
            iedCURRENCY_CODE.EditValue = pCURRENCY_CODE;
            iedITEM_CODE.EditValue = pITEM_CODE;
            iedITEM_DESCRIPTION.EditValue = pITEM_DESCRIPTION;
            iedORDER_QTY.EditValue = pORDER_QTY;            
        }

        #endregion;

        #region ----- Private Methods ----

        private void Line_Setting()
        {
            isGridAdvEx1.SetCellValue("ORDER_LINE_ID", iedORDER_LINE_ID.EditValue);
            isGridAdvEx1.SetCellValue("ORDER_HEADER_ID", iedORDER_HEADER_ID.EditValue);
        }

        private void Total_Computing()
        {
            iedCHARGE_AMOUNT_TOT.EditValue = (int)0;

            for (int vLoop = 0; vLoop < isGridAdvEx1.RowCount; vLoop++)
            {
                iedCHARGE_AMOUNT_TOT.EditValue = Convert.ToDecimal(iedCHARGE_AMOUNT_TOT.EditValue) +
                                                Convert.ToDecimal(isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("CHARGE_AMOUNT")));
            }
        }

        #endregion;

        #region ----- Events -----

        private void SOMF0501_1_Load(object sender, EventArgs e)
        {
            idaCHARGE.Fill();
            Total_Computing();
            mObject = iedCHARGE_AMOUNT_TOT.EditValue;
        }

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    idaCHARGE.Fill();
                    Total_Computing();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    if (idaCHARGE.IsFocused == true)
                    {
                        idaCHARGE.AddOver();
                        Line_Setting();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaCHARGE.IsFocused == true)
                    {
                        idaCHARGE.AddUnder();
                        Line_Setting();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    idaCHARGE.Update();
                    Total_Computing();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    idaCHARGE.Cancel();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaCHARGE.IsFocused == true)
                    {
                        idaCHARGE.Delete();
                        Total_Computing();
                    }
                }
            }
        }

        private void ilagCHARGE_TYPE_SelectedRowData(object pSender)
        {
            if (isGridAdvEx1.GetCellValue("PAYMENT_TYPE").ToString() == "PRICE")
            {
                isGridAdvEx1.SetCellValue("CHARGE_AMOUNT", Convert.ToDecimal(iedORDER_QTY.EditValue) * Convert.ToDecimal(isGridAdvEx1.GetCellValue("CHARGE_PRICE")));           
            }
            else
            {
                isGridAdvEx1.SetCellValue("CHARGE_PRICE", (int)0);
            }            
        }

        private void isGridAdvEx1_CurrentCellValidating(object pSender, ISGridAdvExValidatingEventArgs e)
        {
            switch (isGridAdvEx1.GridAdvExColElement[e.ColIndex].DataColumn.ToString())
            {
                case "CHARGE_PRICE":
                    if (isGridAdvEx1.GetCellValue("PAYMENT_TYPE").ToString() == "PRICE")
                    {
                        isGridAdvEx1.SetCellValue("CHARGE_AMOUNT", Convert.ToDecimal(iedORDER_QTY.EditValue) * Convert.ToDecimal(e.NewValue));
                    }
                    else
                    {
                        if (Convert.ToDecimal(e.NewValue) != 0)
                        {
                            isGridAdvEx1.SetCellValue("CHARGE_PRICE", (int)0);
                            e.Cancel = true;
                        }
                    }
                    break;

                default:
                    break;
            }
        }

        private void ibtADD_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            idaCHARGE.AddUnder();
            Line_Setting();
        }

        private void ibtSAVE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            idaCHARGE.Update();
            Total_Computing();
        }

        private void ibtDEL_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            idaCHARGE.Delete();
            Total_Computing();
        }

        private void ibtCLOSE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            mObject = iedCHARGE_AMOUNT_TOT.EditValue;
            this.Close();
        }

        #endregion;

    }
}