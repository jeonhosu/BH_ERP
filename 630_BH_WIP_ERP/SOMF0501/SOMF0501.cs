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

namespace SOMF0501
{
    public partial class SOMF0501 : Office2007Form
    {
        ISCommonUtil.ISFunction.ISConvert iConvert = new ISFunction.ISConvert();

        #region ----- Variables -----



        #endregion;

        #region ----- Constructor -----

        public SOMF0501(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void idaHEADER_ExcuteQuery()
        {
            idaHEADER.Fill();
            Total_Computing();
        }

        private void Header_Setting()
        {
            iedHEADER_STATUS_CODE.EditValue = "ENTERED";
            iedSTEP_DESCRIPTION.EditValue = "Entered";
            iedORDER_DATE.EditValue = DateTime.Today;
            Total_Computing();
        }

        private void Line_Setting()
        {
            isGridAdvEx1.SetCellValue("CURRENCY_CODE", iedCURRENCY_CODE.EditValue);
            isGridAdvEx1.SetCellValue("ORDER_PRICE", (int)0);
            isGridAdvEx1.SetCellValue("CHARGE_AMOUNT", (int)0);
            isGridAdvEx1.SetCellValue("LINE_STATUS_CODE", iedHEADER_STATUS_CODE.EditValue);
            isGridAdvEx1.SetCellValue("STEP_DESCRIPTION", iedSTEP_DESCRIPTION.EditValue);
        }

        private void Total_Computing()
        {
            iedORDER_AMOUNT_TOT.EditValue = (int)0;
            iedCHARGE_AMOUNT_TOT.EditValue = (int)0;
            iedTAX_AMOUNT_TOT.EditValue = (int)0;
            iedTOT_LINE_AMOUNT_TOT.EditValue = (int)0;

            for (int vLoop = 0; vLoop < isGridAdvEx1.RowCount; vLoop++)
            {
                iedORDER_AMOUNT_TOT.EditValue = Convert.ToDecimal(iedORDER_AMOUNT_TOT.EditValue) +
                                                Convert.ToDecimal(isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("ORDER_AMOUNT")));
                iedCHARGE_AMOUNT_TOT.EditValue = Convert.ToDecimal(iedCHARGE_AMOUNT_TOT.EditValue) +
                                                Convert.ToDecimal(isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("CHARGE_AMOUNT")));
                iedTAX_AMOUNT_TOT.EditValue = Convert.ToDecimal(iedTAX_AMOUNT_TOT.EditValue) +
                                                Convert.ToDecimal(isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("TAX_AMOUNT")));
                iedTOT_LINE_AMOUNT_TOT.EditValue = Convert.ToDecimal(iedORDER_AMOUNT_TOT.EditValue) + Convert.ToDecimal(iedCHARGE_AMOUNT_TOT.EditValue) + Convert.ToDecimal(iedTAX_AMOUNT_TOT.EditValue);
            }
        }

        private void Set_Tool_Request()
        {
            idaINSERT_TOOL_REQUEST.Fill();
            foreach (DataRow pRow in idaINSERT_TOOL_REQUEST.OraSelectData.Rows)
            {
                idaTOOL_REQUEST.AddUnder();
                igrTOOL_REQUEST.SetCellValue("TOOL_CLASS_ID", pRow["TOOL_CLASS_ID"]);
                igrTOOL_REQUEST.SetCellValue("TOOL_CLASS_CODE", pRow["TOOL_CLASS_CODE"]);
                igrTOOL_REQUEST.SetCellValue("TOOL_CLASS_DESCRIPTION", pRow["TOOL_CLASS_DESCRIPTION"]);
                igrTOOL_REQUEST.SetCellValue("REQUEST_FLAG", pRow["REQUEST_FLAG"]);
                igrTOOL_REQUEST.SetCellValue("TOOL_AMOUNT", pRow["TOOL_AMOUNT"]);
                igrTOOL_REQUEST.SetCellValue("REMARK", pRow["REMARK"]);
                igrTOOL_REQUEST.SetCellValue("ORDER_LINE_ID", pRow["ORDER_LINE_ID"]);
            }
            igrTOOL_REQUEST.CurrentCellMoveTo(0, 1);
            igrTOOL_REQUEST.CurrentCellActivate(0, 1);
        }

        #endregion;

        #region ----- Events -----

        private void SOMF0501_Load(object sender, EventArgs e)
        {
            idaHEADER.FillSchema();
            idaLINE.FillSchema();
            idaTOOL_REQUEST.FillSchema();
        }

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    idaHEADER.Fill();
                    Total_Computing();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    if (idaHEADER.IsFocused == true)
                    {
                        idaHEADER.AddOver();
                        Header_Setting();
                    }
                    else if (idaLINE.IsFocused == true)
                    {
                        if (iConvert.ISNull(iedCURRENCY_CODE.EditValue) == string.Empty)
                        {
                            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", "&&FIELD_NAME:=Currency Code").ToString(), "Error",MessageBoxButtons.OK, MessageBoxIcon.Error);
                            return;
                        }
                        idaLINE.AddOver();
                        Line_Setting();
                        Set_Tool_Request();
                    }
                    
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaHEADER.IsFocused == true)
                    {
                        idaHEADER.AddUnder();
                        Header_Setting();
                    }
                    else if (idaLINE.IsFocused == true)
                    {
                        if (iConvert.ISNull(iedCURRENCY_CODE.EditValue) == string.Empty)
                        {
                            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", "&&FIELD_NAME:=Currency Code").ToString(), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                            return;
                        }
                        idaLINE.AddUnder();
                        Line_Setting();
                        Set_Tool_Request();
                    }                    
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    idaHEADER.Update();
                    Total_Computing();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaHEADER.IsFocused == true)
                    {
                        idaHEADER.Cancel();
                    }
                    else if (idaLINE.IsFocused == true)
                    {
                        idaTOOL_REQUEST.Cancel();
                        idaLINE.Cancel();
                    }
                    else if (idaTOOL_REQUEST.IsFocused == true)
                    {
                        idaTOOL_REQUEST.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaHEADER.IsFocused == true)
                    {
                        idaHEADER.Delete();
                    }
                    else if (idaLINE.IsFocused == true)
                    {
                        idaTOOL_REQUEST.MoveFirst(this.Name);
                        foreach (DataRow row in idaTOOL_REQUEST.CurrentRows)
                        {
                            idaTOOL_REQUEST.Delete();
                        }
                        idaLINE.Delete();
                        Total_Computing();
                    }
                    else if (idaTOOL_REQUEST.IsFocused == true)
                    {
                        idaTOOL_REQUEST.Delete();
                    }
                }
            }
        }

        private void idaHEADER_ExcuteKeySearch(object pSender)
        {            
            idaHEADER_ExcuteQuery();
        }

        private void iedCURRENCY_CODE_CurrentEditValidating(object pSender, ISEditAdvValidatingEventArgs e)
        {
            if (idaHEADER.CurrentRow.RowState == DataRowState.Added)
            {
                for (int vLoop = 0; vLoop < isGridAdvEx1.RowCount; vLoop++)
                {
                    isGridAdvEx1.SetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("CURRENCY_CODE"), iedCURRENCY_CODE.EditValue);
                }
            }
        }

        private void isGridAdvEx1_CurrentCellValidating(object pSender, ISGridAdvExValidatingEventArgs e)
        {
            switch (isGridAdvEx1.GridAdvExColElement[e.ColIndex].DataColumn.ToString())
            {
                case "ORDER_QTY":
                    isGridAdvEx1.SetCellValue("ORDER_AMOUNT", Convert.ToDecimal(e.NewValue) * Convert.ToDecimal(isGridAdvEx1.GetCellValue("ORDER_PRICE")));
                    isGridAdvEx1.SetCellValue("TOT_LINE_AMOUNT", Convert.ToDecimal(isGridAdvEx1.GetCellValue("ORDER_AMOUNT")) + Convert.ToDecimal(isGridAdvEx1.GetCellValue("CHARGE_AMOUNT")));
                    isGridAdvEx1.SetCellValue("TAX_AMOUNT", Convert.ToDecimal(isGridAdvEx1.GetCellValue("ORDER_AMOUNT")) * Convert.ToDecimal(isGridAdvEx1.GetCellValue("TAX_RATE")));
                    Total_Computing();
                    break;

                case "ORDER_PRICE":
                    isGridAdvEx1.SetCellValue("ORDER_AMOUNT", Convert.ToDecimal(isGridAdvEx1.GetCellValue("ORDER_QTY")) * Convert.ToDecimal(e.NewValue));
                    isGridAdvEx1.SetCellValue("TOT_LINE_AMOUNT", Convert.ToDecimal(isGridAdvEx1.GetCellValue("ORDER_AMOUNT")) + Convert.ToDecimal(isGridAdvEx1.GetCellValue("CHARGE_AMOUNT")));
                    isGridAdvEx1.SetCellValue("TAX_AMOUNT", Convert.ToDecimal(isGridAdvEx1.GetCellValue("ORDER_AMOUNT")) * Convert.ToDecimal(isGridAdvEx1.GetCellValue("TAX_RATE")));

                    if ((Convert.ToDecimal(isGridAdvEx1.GetCellValue("LIST_PRICE")) == 0) || (Convert.ToDecimal(e.NewValue) == 0))
                    {
                        isGridAdvEx1.SetCellValue("NEGO_RATE", 0);

                        break;

                    }
                    else
                    {
                        isGridAdvEx1.SetCellValue("NEGO_RATE", (Convert.ToDecimal(isGridAdvEx1.GetCellValue("LIST_PRICE")) - Convert.ToDecimal(e.NewValue)) / Convert.ToDecimal(isGridAdvEx1.GetCellValue("LIST_PRICE")) * 100);
                        Total_Computing();
                        break;
                    }

                case "TAX_TYPE_DESCRIPTION":
                    isGridAdvEx1.SetCellValue("TAX_AMOUNT", Convert.ToDecimal(isGridAdvEx1.GetCellValue("ORDER_AMOUNT")) * (Convert.ToDecimal(isGridAdvEx1.GetCellValue("TAX_RATE")) / 100));
                    Total_Computing();
                    break;

                default:
                    break;
            }
        }

        private void ilagTAX_SelectedRowData(object pSender)
        {
            isGridAdvEx1.SetCellValue("TAX_AMOUNT", Convert.ToDecimal(isGridAdvEx1.GetCellValue("ORDER_AMOUNT")) * Convert.ToDecimal(isGridAdvEx1.GetCellValue("TAX_RATE")) );
        }

        private void ibtMODIFY_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            SOMF0501_2 vSOMF0501_2 = new SOMF0501_2(isGridAdvEx1.GetCellValue("ORDER_LINE_ID"), iedORDER_HEADER_ID.EditValue);

            vSOMF0501_2.ShowDialog();
        }

        private void ibtCHARGE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (iConvert.ISNull(isGridAdvEx1.GetCellValue("ORDER_LINE_NO")) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", "&&FIELD_NAME:=Line No").ToString(), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            SOMF0501_1 vSOMF0501_1 = new SOMF0501_1(isAppInterfaceAdv1.AppInterface, isGridAdvEx1.GetCellValue("ORDER_LINE_ID"), iedORDER_HEADER_ID.EditValue, iedORDER_NO.EditValue, isGridAdvEx1.GetCellValue("ORDER_LINE_NO"), iedCURRENCY_CODE.EditValue, isGridAdvEx1.GetCellValue("ITEM_CODE"), isGridAdvEx1.GetCellValue("ITEM_DESCRIPTION"), isGridAdvEx1.GetCellValue("ORDER_QTY"));

            vSOMF0501_1.ShowDialog();

            isGridAdvEx1.SetCellValue("CHARGE_AMOUNT", vSOMF0501_1.pCharge_Amount_Tot);            

            isAppInterfaceAdv1.AppInterface.MainButtonEvent(ISUtil.Enum.AppMainButtonType.Update);

            Total_Computing();

            //object[] vObject = new object[9];

            //vObject[0] = iedORDER_NO.EditValue;
            //SOMF0501_1 ChildForm = new SOMF0501_1(1,1,1,1,1,1,1,1);
            //ChildForm.pSOMF0501_1 = vObject;
        }

        #endregion;                                        
        
    }
}