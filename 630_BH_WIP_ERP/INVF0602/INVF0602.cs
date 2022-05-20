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

namespace INVF0602
{
    public partial class INVF0602 : Office2007Form
    {
        ISCommonUtil.ISFunction.ISConvert iConvert = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #region ----- Variables -----



        #endregion;

        #region ----- Constructor -----

        public INVF0602(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void idaHEADER_ExcuteQuery()
        {
            IDA_HEADER.Fill();
        }

        private void line_Setting()
        {
            //object vcurrency = H_CURRENCY_RATE.EditValue;
            isgLINE.SetCellValue("CURRENCY_CODE", H_CURRENCY_RATE.EditValue);
        }

        private void Header_Setting()
        {
            H_CREATION_DATE.EditValue = DateTime.Today;
            H_DISPOSAL_TYPE_CODE.EditValue = "A01";
            H_DISPOSAL_TYPE_NAME.EditValue = "불용자재 유상매각";
            H_DISPOSAL_DATE.EditValue = DateTime.Today;
            H_CURRENCY_RATE.EditValue = "KRW";
            H_EXCHANGE_RATE.EditValue = 1;
            H_PERSON_ID.EditValue = isAppInterfaceAdv1.PERSON_ID;
            H_PERSON_NAME.EditValue = isAppInterfaceAdv1.DISPLAY_NAME;
            H_DISPOSAL_TYPE_CODE.Focus();
           // idcFG_WIP.ExecuteNonQuery();
           // idcFG_MAIN.ExecuteNonQuery();
        }

        private bool line_data_check()
        {
            bool vcheck = true;
            //MessageBoxAdv.Show(isgOE_QUOTE_REQ_LINE.GetCellValue("REQ_LINE_ID").ToString());
            if (isgLINE.RowCount > 0)
            {
                vcheck = false;
            }
            return vcheck;
        }

        private void ComputeAmount(object pSender, ISGridAdvExValidatingEventArgs e)
        {
            ISGridAdvEx vGridAdvEx = pSender as ISGridAdvEx;
            object vObject1 = null;
            object vObject2 = null;

            if (e.ColIndex == 8 || e.ColIndex == 10)
            {
                if (e.NewValue != null)
                {
                    if (e.ColIndex == 8)
                    {
                        vObject1 = e.NewValue;
                        vObject2 = isgLINE.GetCellValue("DISPOSAL_UNIT_PRICE");
                    }
                    else if (e.ColIndex == 10)
                    {
                        vObject1 = isgLINE.GetCellValue("DISPOSAL_QTY");
                        vObject2 = e.NewValue;
                    }

                    if (vObject1 != null && vObject2 != null)
                    {
                        bool isConvert1 = vObject1 is decimal;
                        bool isConvert2 = vObject2 is decimal;

                        if (isConvert1 == true && isConvert2 == true)
                        {
                            decimal vQTY = (decimal)vObject1;
                            decimal vPrice = (decimal)vObject2;

                            decimal vAmount = vQTY * vPrice;

                            vGridAdvEx.SetCellValue("DISPOSAL_AMOUNT", vAmount);
                        }
                    }
                }
            }
        }

        private void idaHEADER_ExcuteKeySearch(object pSender)
        {
            idaHEADER_ExcuteQuery();
        }

        #endregion;

        #region ----- Events -----

        private void INVF0602_Load(object sender, EventArgs e)
        {
            IDA_HEADER.FillSchema();
           // idaLINE.FillSchema();

            V_DATE_FR.EditValue = iDate.ISMonth_1st(DateTime.Today);
            V_DATE_TO.EditValue = DateTime.Today;
        }

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    if (TAB_MAIN.SelectedIndex == 0)
                    {
                        IDA_HEADER.Fill();
                    }
                    else if (TAB_MAIN.SelectedIndex == 1)
                    {
                        IDA_LIST.Fill();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    if (IDA_HEADER.IsFocused == true)
                    {
                        if ((IDA_HEADER.CurrentRow == null) || ((IDA_HEADER.CurrentRow != null) && (IDA_HEADER.CurrentRow.RowState != DataRowState.Added)))
                        {                        
                            IDA_HEADER.AddOver();
                            Header_Setting();
                        }
                    }
                    else if (IDA_LINE.IsFocused == true)
                    {
                        IDA_LINE.AddOver();
                        line_Setting();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (IDA_HEADER.IsFocused == true)
                    {
                        if ((IDA_HEADER.CurrentRow == null) || ((IDA_HEADER.CurrentRow != null) && (IDA_HEADER.CurrentRow.RowState != DataRowState.Added)))
                        {
                            IDA_HEADER.AddUnder();
                            Header_Setting();
                        }
                    }
                    else if (IDA_LINE.IsFocused == true)
                    {
                        IDA_LINE.AddUnder();
                        line_Setting();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (IDA_HEADER.IsFocused == true)
                    {
                        //if (!line_data_check())
                        //{
                            IDA_HEADER.Update();
                        //}
                        //else
                        //{
                        //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10041", "&&VALUE:=해당 자료"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);// 모듈 코드 입력
                        //}
                    }
                    else if (IDA_LINE.IsFocused == true)
                    {
                        IDA_HEADER.Update();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (IDA_HEADER.IsFocused == true)
                    {
                        IDA_HEADER.Cancel();
                    }
                    else if (IDA_LINE.IsFocused == true)
                    {
                        IDA_LINE.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (IDA_HEADER.IsFocused == true)
                    {
                        if (line_data_check())
                        {
                            IDA_HEADER.Delete();
                        }
                        else
                        {
                            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10016"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);// 모듈 코드 입력
                        }
                    }
                    else if (IDA_LINE.IsFocused == true)
                    {
                        IDA_LINE.Delete();
                    }      
                }
            }
        }

        private void isgLINE_CurrentCellValidating(object pSender, ISGridAdvExValidatingEventArgs e)
        {
            if (isgLINE.ColIndex == 8 || isgLINE.ColIndex == 10)
            {
                ComputeAmount(pSender, e);
            }
        }

        private void ilaDISPOSAL_NO_SelectedRowData(object pSender)
        {
            //idaHEADER.IsMoveFocus();
        }

        private void H_DISPOSAL_NO_KeyDown(object pSender, KeyEventArgs e)
        {
            //if (e.KeyCode == System.Windows.Forms.Keys.F9)
            //{
            //    isgLINE.RowCount = 0;
            //}
        }

        private void ISG_DISPOSAL_LIST_CellDoubleClick(object pSender)
        {
            if (IDA_HEADER.Refillable == true && IDA_LINE.Refillable == true)
            {
                H_DISPOSAL_HEADER_ID.EditValue = ISG_DISPOSAL_LIST.GetCellValue("DISPOSAL_HEADER_ID");

                IDA_HEADER.OraSelectData.AcceptChanges();
                IDA_HEADER.Refillable = true;

                IDA_HEADER.Fill();

                TAB_MAIN.SelectedIndex = 0;

            }
            else
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("PO_10014"), "WARRING", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }
 
        //private void idaLINE_PreCurrentFill(object pSender, ISPreCurrentFillEventArgs e)
        //{
            //if ((idaHEADER.CurrentRow != null) && (idaHEADER.CurrentRow.RowState == DataRowState.Added))
            //{
            //    foreach (DataRow row in e.CurrentRows)
            //    {
            //        row.SetAdded();

            //        row["MasterKeyId"] = e.MasterCurrentRow["RowKeyId"];
            //    }
            //}
        //}

        //private void idaHEADER_PreDelete(ISPreDeleteEventArgs e)
        //{
        //    if (e.Row.RowState != DataRowState.Added)
        //    {
        //        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:=" + isGroupBox1.PromptText.ToString()), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
        //        e.Cancel = true;
        //        return;
        //    }
        //}

        //private void idaLINE_PreDelete(ISPreDeleteEventArgs e)
        //{
        //    if (e.Row.RowState != DataRowState.Added)
        //    {
        //        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:=" + isGroupBox2.PromptText.ToString()), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
        //        e.Cancel = true;
        //        return;
        //    }
        //}

        #endregion;   

    }
}