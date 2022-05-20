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

namespace POMF0719
{
    public partial class POMF0719 : Office2007Form
    {
        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        private ISCommonUtil.ISFunction.ISConvert iConvert = new ISFunction.ISConvert();

        #region ----- Variables -----

        #endregion;

        #region ----- Constructor -----

        public POMF0719(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;  

        }

        #endregion;

        #region ----- Private Methods ----

        #endregion;

        #region ----- Events -----

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    if (TAB_MAIN.SelectedIndex == 0)
                    {
                        IDA_LC_BL_CO.OraSelectData.AcceptChanges();
                        IDA_LC_BL_CO.Refillable = true;
                        //IDA_CHARGE.OraSelectData.AcceptChanges();
                        //IDA_CHARGE.Refillable = true;
                        IDA_LC_BL_CO.Fill();
                    }
                    else if (TAB_MAIN.SelectedIndex == 1)
                    {
                        idaADJUST.Fill();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    if (TAB_MAIN.SelectedIndex == 0)
                    {
                        IDA_CHARGE.AddOver();
                        Line_Setting();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (TAB_MAIN.SelectedIndex == 0)
                    {
                        IDA_CHARGE.AddUnder();
                        Line_Setting();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {

                        IDA_CHARGE.Update();

                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    
                        IDA_CHARGE.Cancel();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {

                        IDA_CHARGE.Delete();
                    
                        
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {
                    int vIndexTAB = TAB_MAIN.SelectedIndex;

                    if (vIndexTAB == 0)
                    {
                      //  if (IDA_LC_BL_CO.IsFocused)
                      //  {
                            idcSLIP_ID.SetCommandParamValue("W_SLIP_NUM", ISG_BANKING_LIST.GetCellValue("SLIP_NUM"));
                            idcSLIP_ID.ExecuteNonQuery();

                            if ( Convert.ToInt32( iConvert.ISNull(idcSLIP_ID.GetCommandParamValue("O_HEADER_ID")) ) > 0)
                            {
                                idaSLIP_HEADER.SetSelectParamValue("W_HEADER_INTERFACE_ID", idcSLIP_ID.GetCommandParamValue("O_HEADER_ID"));                                
                                idaSLIP_HEADER.Fill();
                                
                                idaSLIP_LINE_PRINT.SetSelectParamValue("W_HEADER_IF_ID", idcSLIP_ID.GetCommandParamValue("O_HEADER_ID"));
                                idaSLIP_LINE_PRINT.Fill();

                                XLPrinting1("PRINT");
                            }
                      //  }
                       // else if (IDA_CHARGE.IsFocused)
                      //  {
                            idcSLIP_ID.SetCommandParamValue("W_SLIP_NUM", isgLINE.GetCellValue("SLIP_NUM"));
                            idcSLIP_ID.ExecuteNonQuery();

                            if (Convert.ToInt32(iConvert.ISNull(idcSLIP_ID.GetCommandParamValue("O_HEADER_ID"))) > 0)
                            {
                                idaSLIP_HEADER.SetSelectParamValue("W_HEADER_INTERFACE_ID", idcSLIP_ID.GetCommandParamValue("O_HEADER_ID"));
                                idaSLIP_HEADER.Fill();

                                idaSLIP_LINE_PRINT.SetSelectParamValue("W_HEADER_IF_ID", idcSLIP_ID.GetCommandParamValue("O_HEADER_ID"));
                                idaSLIP_LINE_PRINT.Fill();

                                XLPrinting1("PRINT");
                            }
                      //  }                        
                    }
                    else if (vIndexTAB == 1)
                    {
                        idcSLIP_ID.SetCommandParamValue("W_SLIP_NUM", isGridAdvEx2.GetCellValue("SLIP_NUM"));
                        idcSLIP_ID.ExecuteNonQuery();

                        if (Convert.ToInt32(iConvert.ISNull(idcSLIP_ID.GetCommandParamValue("O_HEADER_ID"))) > 0)
                        {
                            idaSLIP_HEADER.SetSelectParamValue("W_HEADER_INTERFACE_ID", idcSLIP_ID.GetCommandParamValue("O_HEADER_ID"));
                            idaSLIP_HEADER.Fill();

                            idaSLIP_LINE_PRINT.SetSelectParamValue("W_HEADER_IF_ID", idcSLIP_ID.GetCommandParamValue("O_HEADER_ID"));
                            idaSLIP_LINE_PRINT.Fill();

                            XLPrinting1("PRINT");
                        }
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                    int vIndexTAB = TAB_MAIN.SelectedIndex;

                    if (vIndexTAB == 0)
                    {
                        if (IDA_LC_BL_CO.IsFocused)
                        {
                            idcSLIP_ID.SetCommandParamValue("W_SLIP_NUM", ISG_BANKING_LIST.GetCellValue("SLIP_NUM"));
                            idcSLIP_ID.ExecuteNonQuery();

                            if (Convert.ToInt32(iConvert.ISNull(idcSLIP_ID.GetCommandParamValue("O_HEADER_ID"))) > 0)
                            {
                                idaSLIP_HEADER.SetSelectParamValue("W_HEADER_INTERFACE_ID", idcSLIP_ID.GetCommandParamValue("O_HEADER_ID"));
                                idaSLIP_HEADER.Fill();

                                idaSLIP_LINE_PRINT.SetSelectParamValue("W_HEADER_IF_ID", idcSLIP_ID.GetCommandParamValue("O_HEADER_ID"));
                                idaSLIP_LINE_PRINT.Fill();

                                XLPrinting1("FILE");
                            }
                        }
                        else if (IDA_CHARGE.IsFocused)
                        {
                            idcSLIP_ID.SetCommandParamValue("W_SLIP_NUM", isgLINE.GetCellValue("SLIP_NUM"));
                            idcSLIP_ID.ExecuteNonQuery();

                            if (Convert.ToInt32(iConvert.ISNull(idcSLIP_ID.GetCommandParamValue("O_HEADER_ID"))) > 0)
                            {
                                idaSLIP_HEADER.SetSelectParamValue("W_HEADER_INTERFACE_ID", idcSLIP_ID.GetCommandParamValue("O_HEADER_ID"));
                                idaSLIP_HEADER.Fill();

                                idaSLIP_LINE_PRINT.SetSelectParamValue("W_HEADER_IF_ID", idcSLIP_ID.GetCommandParamValue("O_HEADER_ID"));
                                idaSLIP_LINE_PRINT.Fill();

                                XLPrinting1("FILE");
                            }
                        }
                    }
                    //else if (vIndexTAB == 1)
                    //{
                    //    idcSLIP_ID.SetCommandParamValue("W_SLIP_NUM", isGridAdvEx2.GetCellValue("SLIP_NUM"));
                    //    idcSLIP_ID.ExecuteNonQuery();

                    //    if (Convert.ToInt32(iConvert.ISNull(idcSLIP_ID.GetCommandParamValue("O_HEADER_ID"))) > 0)
                    //    {
                    //        idaSLIP_HEADER.SetSelectParamValue("W_HEADER_INTERFACE_ID", idcSLIP_ID.GetCommandParamValue("O_HEADER_ID"));
                    //        idaSLIP_HEADER.Fill();

                    //        idaSLIP_LINE_PRINT.SetSelectParamValue("W_HEADER_IF_ID", idcSLIP_ID.GetCommandParamValue("O_HEADER_ID"));
                    //        idaSLIP_LINE_PRINT.Fill();

                    //        XLPrinting1("FILE");
                    //    }
                    //}
                }
            }
        }


//        #endregion;

        private void POMF0719_Load(object sender, EventArgs e)
        {
            iedDATE_FR_S.EditValue = iDate.ISMonth_1st(DateTime.Today);
            iedDATE_TO_S.EditValue = DateTime.Today;

            iedDELIVERY_DATE_FR.EditValue = iDate.ISMonth_1st(DateTime.Today);
            iedDELIVERY_DATE_TO.EditValue = DateTime.Today;

            iedSLIP_DATE.EditValue = DateTime.Today;
            iedSLIP_DATE_C.EditValue = DateTime.Today;
            iedEXPECT_DATE.EditValue = iDate.ISMonth_Last(DateTime.Today, 1);
            V_EXPECT_DATE.EditValue = iedSLIP_DATE_C.EditValue;
            ibtSLIP_CANCEL_2.BringToFront();

            IDA_LC_BL_CO.FillSchema();
            IDA_CHARGE.FillSchema();
            idaADJUST.FillSchema();
            idaTRX.FillSchema();

            // Radod Button Initialize //
            //V_SHIPMENT_FLAG.EditValue = Convert.ToString("A");
            //RD_ALL.Checked = true;
        }


        private void ilagCHARGE_TYPE_SelectedRowData(object pSender)
        {            
            if (isgLINE.GetCellValue("CHARGE_CLASS_LCODE").ToString() == "BL")
            {
                isgLINE.SetCellValue("BL_NO", ISG_BANKING_LIST.GetCellValue("BL_NO"));
                isgLINE.SetCellValue("CUSTOM_NO", ISG_BANKING_LIST.GetCellValue("CUSTOM_NO"));
            }
            else if (isgLINE.GetCellValue("CHARGE_CLASS_LCODE").ToString() == "CUSTOM")
            {
                isgLINE.SetCellValue("BL_NO", ISG_BANKING_LIST.GetCellValue("BL_NO"));
                isgLINE.SetCellValue("CUSTOM_NO", ISG_BANKING_LIST.GetCellValue("CUSTOM_NO"));
            }
        }

        private void ISG_BANKING_LIST_CellMoved(object pSender, ISGridAdvExCellClickEventArgs e)
        {
            
            IDA_CHARGE.Fill();
            
            for(int i = 0; i < isgLINE.RowCount; i++)
            {
                if(Convert.ToString(isgLINE.GetCellValue(i, isgLINE.GetColumnToIndex("CHARGE_CODE"))) == "VAT" && Convert.ToDecimal(isgLINE.GetCellValue(i, isgLINE.GetColumnToIndex("CHARGE_AMOUNT"))) != 0)
                {
                    isgLINE.SetCellValue(i, isgLINE.GetColumnToIndex("TAX_AMOUNT"), isgLINE.GetCellValue(i, isgLINE.GetColumnToIndex("CHARGE_AMOUNT")));
                    isgLINE.SetCellValue(i, isgLINE.GetColumnToIndex("CHARGE_AMOUNT"), isgLINE.GetCellValue(i, isgLINE.GetColumnToIndex("CHARGE_AMOUNT_OWN")));
                }
            }

            IDA_CHARGE.Refillable = true;
        }

        private void ilagCURRENCY_SelectedRowData(object pSender)
        {
            idcEXCHANGE_RATE.ExecuteNonQuery();
        }

        private void ibtSLIP_SEND_ButtonClick(object pSender, EventArgs pEventArgs)
        {

            for (int vLoop = 0; vLoop < ISG_BANKING_LIST.RowCount; vLoop++)
            {
                if (ISG_BANKING_LIST.GetCellValue(vLoop, ISG_BANKING_LIST.GetColumnToIndex("SELECT_FLAG")).ToString() == "Y")
                {
                    string X_RESULT_STATUS;
                    string X_RESULT_MSG;

                    isDataTransaction1.BeginTran();

                    idcSEND.ExecuteNonQuery();

                    X_RESULT_STATUS = iConvert.ISNull(idcSEND.GetCommandParamValue("X_RESULT_STATUS"));
                    X_RESULT_MSG = iConvert.ISNull(idcSEND.GetCommandParamValue("X_RESULT_MSG"));

                    if (idcSEND.ExcuteError || (X_RESULT_STATUS != string.Empty && X_RESULT_STATUS == "F"))
                    {
                        isDataTransaction1.RollBack();
                        MessageBoxAdv.Show(X_RESULT_MSG, "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return;
                    }

                    isDataTransaction1.Commit();

                }
            }

            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10010", null), "SUCCESS", MessageBoxButtons.OK, MessageBoxIcon.Information);

            IDA_LC_BL_CO.OraSelectData.AcceptChanges();
            IDA_LC_BL_CO.Refillable = true;
            IDA_CHARGE.OraSelectData.AcceptChanges();
            IDA_CHARGE.Refillable = true;
            IDA_LC_BL_CO.Fill();
            IDA_CHARGE.Fill();
        }

        private void ibtSLIP_CANCEL_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            isDataTransaction1.BeginTran();

            idcCANCEL.ExecuteNonQuery();

            string X_RESULT_STATUS = iConvert.ISNull(idcCANCEL.GetCommandParamValue("X_RESULT_STATUS"));
            string X_RESULT_MSG = iConvert.ISNull(idcCANCEL.GetCommandParamValue("X_RESULT_MSG"));

            if (idcCANCEL.ExcuteError || (X_RESULT_STATUS != string.Empty && X_RESULT_STATUS == "F"))
            {
                isDataTransaction1.RollBack();
                MessageBoxAdv.Show(X_RESULT_MSG, "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            isDataTransaction1.Commit();

            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10010", null), "SUCCESS", MessageBoxButtons.OK, MessageBoxIcon.Information);

            IDA_LC_BL_CO.OraSelectData.AcceptChanges();
            IDA_LC_BL_CO.Refillable = true;
            IDA_CHARGE.OraSelectData.AcceptChanges();
            IDA_CHARGE.Refillable = true;
            IDA_LC_BL_CO.Fill();
            IDA_CHARGE.Fill();
        }


        private void ibtSLIP_CANCEL_2_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            isDataTransaction1.BeginTran();

            idc_SLIP_CHARGE_CANCEL_2.ExecuteNonQuery();
            
            string X_RESULT_STATUS = iConvert.ISNull(idc_SLIP_CHARGE_CANCEL_2.GetCommandParamValue("X_RESULT_STATUS"));
            string X_RESULT_MSG = iConvert.ISNull(idc_SLIP_CHARGE_CANCEL_2.GetCommandParamValue("X_RESULT_MSG"));

            if (idc_SLIP_CHARGE_CANCEL_2.ExcuteError || (X_RESULT_STATUS != string.Empty && X_RESULT_STATUS == "F"))
            {
                isDataTransaction1.RollBack();
                MessageBoxAdv.Show(X_RESULT_MSG, "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            isDataTransaction1.Commit();

            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10010", null), "SUCCESS", MessageBoxButtons.OK, MessageBoxIcon.Information);

            IDA_LC_BL_CO.OraSelectData.AcceptChanges();
            IDA_LC_BL_CO.Refillable = true;
            IDA_CHARGE.OraSelectData.AcceptChanges();
            IDA_CHARGE.Refillable = true;
            IDA_LC_BL_CO.Fill();
            IDA_CHARGE.Fill();
        }

        //private void ibtLC_ADJUST_ButtonClick(object pSender, EventArgs pEventArgs)
        //{
        //    for (int vLoop = 0; vLoop < isGridAdvEx1.RowCount; vLoop++)
        //    {
        //        if (isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("SELECT_FLAG")).ToString() == "Y")
        //        {
        //            isDataTransaction1.BeginTran();

        //            idcLC_ADJUST.SetCommandParamValue("P_PERIOD_NAME", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("PERIOD_NAME")));
        //            idcLC_ADJUST.SetCommandParamValue("P_DELIVERY_DATE", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("DELIVERY_DATE")));
        //            idcLC_ADJUST.SetCommandParamValue("P_SUPPLIER_ID", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("SUPPLIER_ID")));
        //            idcLC_ADJUST.SetCommandParamValue("P_LC_NO", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("LC_NO")));
        //            idcLC_ADJUST.ExecuteNonQuery();

        //            string X_RESULT_STATUS = iConvert.ISNull(idcLC_ADJUST.GetCommandParamValue("X_RESULT_STATUS"));
        //            string X_RESULT_MSG = iConvert.ISNull(idcLC_ADJUST.GetCommandParamValue("X_RESULT_MSG"));

        //            if (idcLC_ADJUST.ExcuteError || (X_RESULT_STATUS != string.Empty && X_RESULT_STATUS == "F"))
        //            {
        //                isDataTransaction1.RollBack();
        //                MessageBoxAdv.Show(X_RESULT_MSG, "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error);
        //                return;
        //            }

        //            isDataTransaction1.Commit();
        //        }
        //    }

        //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10010", null), "SUCCESS", MessageBoxButtons.OK, MessageBoxIcon.Information);

        //    idaADJUST.OraSelectData.AcceptChanges();
        //    idaADJUST.Refillable = true;

        //    idaADJUST.Fill();        
        //}

        //private void ibtLC_CONFIRM_ButtonClick(object pSender, EventArgs pEventArgs)
        //{
        //    for (int vLoop = 0; vLoop < isGridAdvEx1.RowCount; vLoop++)
        //    {
        //        if (isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("SELECT_FLAG")).ToString() == "Y")
        //        {
        //            isDataTransaction1.BeginTran();

        //            idcTRX_CONFIRM.SetCommandParamValue("P_PERIOD_NAME", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("PERIOD_NAME")));
        //            idcTRX_CONFIRM.SetCommandParamValue("P_SUPPLIER_ID", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("SUPPLIER_ID")));
        //            idcTRX_CONFIRM.SetCommandParamValue("P_LC_NO", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("LC_NO")));
        //            idcTRX_CONFIRM.ExecuteNonQuery();

        //            string X_RESULT_STATUS = iConvert.ISNull(idcTRX_CONFIRM.GetCommandParamValue("X_RESULT_STATUS"));
        //            string X_RESULT_MSG = iConvert.ISNull(idcTRX_CONFIRM.GetCommandParamValue("X_RESULT_MSG"));

        //            if (idcTRX_CONFIRM.ExcuteError || (X_RESULT_STATUS != string.Empty && X_RESULT_STATUS == "F"))
        //            {
        //                isDataTransaction1.RollBack();
        //                MessageBoxAdv.Show(X_RESULT_MSG, "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error);
        //                return;
        //            }

        //            isDataTransaction1.Commit();
        //        }
        //    }

        //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10010", null), "SUCCESS", MessageBoxButtons.OK, MessageBoxIcon.Information);

        //    idaADJUST.OraSelectData.AcceptChanges();
        //    idaADJUST.Refillable = true;

        //    idaADJUST.Fill();        
        //}

        //private void ibtLC_CANCEL_ButtonClick(object pSender, EventArgs pEventArgs)
        //{
        //    for (int vLoop = 0; vLoop < isGridAdvEx1.RowCount; vLoop++)
        //    {
        //        if (isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("SELECT_FLAG")).ToString() == "Y")
        //        {
        //            isDataTransaction1.BeginTran();

        //            idcTRX_CANCEL.SetCommandParamValue("P_PERIOD_NAME", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("PERIOD_NAME")));
        //            idcTRX_CANCEL.SetCommandParamValue("P_SUPPLIER_ID", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("SUPPLIER_ID")));
        //            idcTRX_CANCEL.SetCommandParamValue("P_LC_NO", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("LC_NO")));
        //            idcTRX_CANCEL.ExecuteNonQuery();

        //            string X_RESULT_STATUS = iConvert.ISNull(idcTRX_CANCEL.GetCommandParamValue("X_RESULT_STATUS"));
        //            string X_RESULT_MSG = iConvert.ISNull(idcTRX_CANCEL.GetCommandParamValue("X_RESULT_MSG"));

        //            if (idcTRX_CANCEL.ExcuteError || (X_RESULT_STATUS != string.Empty && X_RESULT_STATUS == "F"))
        //            {
        //                isDataTransaction1.RollBack();
        //                MessageBoxAdv.Show(X_RESULT_MSG, "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error);
        //                return;
        //            }

        //            isDataTransaction1.Commit();
        //        }
        //    }

        //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10010", null), "SUCCESS", MessageBoxButtons.OK, MessageBoxIcon.Information);

        //    idaADJUST.OraSelectData.AcceptChanges();
        //    idaADJUST.Refillable = true;

        //    idaADJUST.Fill();    
        //}

        //private void ibtSLIP_SEND_C_ButtonClick(object pSender, EventArgs pEventArgs)
        //{
        //    for (int vLoop = 0; vLoop < isGridAdvEx1.RowCount; vLoop++)
        //    {
        //        if (isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("SELECT_FLAG")).ToString() == "Y")
        //        {
        //            isDataTransaction1.BeginTran();

        //            idcLC_SEND.SetCommandParamValue("P_LC_NO", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("LC_NO")));
        //            idcLC_SEND.ExecuteNonQuery();

        //            string X_RESULT_STATUS = iConvert.ISNull(idcLC_SEND.GetCommandParamValue("X_RESULT_STATUS"));
        //            string X_RESULT_MSG = iConvert.ISNull(idcLC_SEND.GetCommandParamValue("X_RESULT_MSG"));

        //            if (idcLC_SEND.ExcuteError || (X_RESULT_STATUS != string.Empty && X_RESULT_STATUS == "F"))
        //            {
        //                isDataTransaction1.RollBack();
        //                MessageBoxAdv.Show(X_RESULT_MSG, "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error);
        //                return;
        //            }

        //            isDataTransaction1.Commit();
        //        }
        //    }

        //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10010", null), "SUCCESS", MessageBoxButtons.OK, MessageBoxIcon.Information);

        //    idaADJUST.OraSelectData.AcceptChanges();
        //    idaADJUST.Refillable = true;

        //    idaADJUST.Fill();    
        //}

        //private void ibtSLIP_CANCEL_C_ButtonClick(object pSender, EventArgs pEventArgs)
        //{
        //    for (int vLoop = 0; vLoop < isGridAdvEx1.RowCount; vLoop++)
        //    {
        //        if (isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("SELECT_FLAG")).ToString() == "Y")
        //        {
        //            isDataTransaction1.BeginTran();

        //            idcLC_CANCEL.SetCommandParamValue("W_SLIP_NUM", isGridAdvEx2.GetCellValue("SLIP_NUM"));
        //            idcLC_CANCEL.SetCommandParamValue("W_LC_NO", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("LC_NO")));
        //            idcLC_CANCEL.ExecuteNonQuery();

        //            string X_RESULT_STATUS = iConvert.ISNull(idcLC_CANCEL.GetCommandParamValue("X_RESULT_STATUS"));
        //            string X_RESULT_MSG = iConvert.ISNull(idcLC_CANCEL.GetCommandParamValue("X_RESULT_MSG"));

        //            if (idcLC_CANCEL.ExcuteError || (X_RESULT_STATUS != string.Empty && X_RESULT_STATUS == "F"))
        //            {
        //                isDataTransaction1.RollBack();
        //                MessageBoxAdv.Show(X_RESULT_MSG, "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error);
        //                return;
        //            }

        //            isDataTransaction1.Commit();
        //        }
        //    }

        //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10010", null), "SUCCESS", MessageBoxButtons.OK, MessageBoxIcon.Information);

        //    idaADJUST.OraSelectData.AcceptChanges();
        //    idaADJUST.Refillable = true;

        //    idaADJUST.Fill();    
        //}

        private void ILA_VOUCH_CODE_RefreshLookupData(object pSender, ISRefreshLookupDataEventArgs e)
        {
            ILD_COMMON.SetLookupParamValue("W_GROUP_CODE", "VOUCH_CODE");
            ILD_COMMON.SetLookupParamValue("W_ENABLED_YN", "Y");
        }
        
        #endregion;

        private void Line_Setting()
        {
            isgLINE.SetCellValue("LC_NO", ISG_BANKING_LIST.GetCellValue("BANKING_NO"));
            isgLINE.SetCellValue("CHARGE_DATE", DateTime.Today);
            //isgLINE.SetCellValue("CURRENCY_CODE", ISG_BANKING_LIST.GetCellValue("CURRENCY_CODE"));
            isgLINE.SetCellValue("CHARGE_AMOUNT", 0);
            isgLINE.SetCellValue("CURRENCY_CODE", "KRW");
            isgLINE.SetCellValue("EXCHANGE_RATE", 1);

            //idcEXCHANGE_RATE.ExecuteNonQuery();
        }

        private void isgLINE_CurrentCellChanged(object pSender, ISGridAdvExChangedEventArgs e)
        {
            if (Convert.ToString(isgLINE.GetCellValue("CHARGE_CODE")) == "VAT")
            {
                return;
            }

            switch (isgLINE.GridAdvExColElement[e.ColIndex].DataColumn.ToString())
            {
                case "CHARGE_DATE":
                case "CURRENCY_CODE":
                    if (isgLINE.GetCellValue("CURRENCY_CODE").ToString() != "KRW")
                    {
                        idcEXCHANGE_RATE.ExecuteNonQuery();
                    }
                    isgLINE.SetCellValue("CHARGE_AMOUNT_OWN", Convert.ToDecimal(isgLINE.GetCellValue("CHARGE_AMOUNT")) * Convert.ToDecimal(isgLINE.GetCellValue("EXCHANGE_RATE")));
                    isgLINE.SetCellValue("TAX_AMOUNT", System.Math.Truncate(Convert.ToDecimal(isgLINE.GetCellValue("CHARGE_AMOUNT_OWN")) / 10));
                    break;

                case "CHARGE_AMOUNT":
                    isgLINE.SetCellValue("CHARGE_AMOUNT_OWN", Convert.ToDecimal(e.NewValue) * Convert.ToDecimal(isgLINE.GetCellValue("EXCHANGE_RATE")));
                    isgLINE.SetCellValue("TAX_AMOUNT", System.Math.Truncate(Convert.ToDecimal(isgLINE.GetCellValue("CHARGE_AMOUNT_OWN")) / 10));
                    break;

                case "EXCHANGE_RATE":
                    isgLINE.SetCellValue("CHARGE_AMOUNT_OWN", Convert.ToDecimal(e.NewValue) * Convert.ToDecimal(isgLINE.GetCellValue("CHARGE_AMOUNT")));
                    isgLINE.SetCellValue("TAX_AMOUNT", System.Math.Truncate(Convert.ToDecimal(isgLINE.GetCellValue("CHARGE_AMOUNT_OWN")) / 10));
                    break;

                default:
                    break;
            }


        }

        #region ----- XL Print 1 Methods ----

        private void XLPrinting1(string pOutChoice)
        {
            string vMessageText = string.Empty;
            int vPageTotal = 0;
            int vPageNumber = 0;

            vMessageText = string.Format("Printing Start");
            isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
            System.Windows.Forms.Application.DoEvents();


            System.Windows.Forms.Application.UseWaitCursor = true;
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            System.Windows.Forms.Application.DoEvents();

            int vCountRowTable = idaSLIP_HEADER.OraSelectData.Rows.Count;

            if (vCountRowTable > 0)
            {
                //-------------------------------------------------------------------------------------
                XLPrinting xlPrinting = new XLPrinting(isAppInterfaceAdv1.AppInterface);

                try
                {
                    //-------------------------------------------------------------------------------------
                    xlPrinting.OpenFileNameExcel = "POMF0719_001.xls";
                    xlPrinting.PrintingLineMAX = 57;         //엑셀에 출력될 총 라인
                    xlPrinting.IncrementCopyMAX = 67;        //엑셀 쉬트에 복사될 총 라인수
                    xlPrinting.PositionPrintLineSTART = 18;  //라인 출력시 엑셀 시작 행 위치 지정
                    xlPrinting.CopySumPrintingLine = 1;      //엑셀의 선택된 쉬트의 복사되어질 시작 행 위치
                    //-------------------------------------------------------------------------------------

                    //-------------------------------------------------------------------------------------
                    bool isOpen = xlPrinting.XLFileOpen();
                    //-------------------------------------------------------------------------------------

                    if (isOpen == true)
                    {
                        //-------------------------------------------------------------------------------------
                        xlPrinting.HeaderWrite(idaSLIP_HEADER);

                        object vObject_DEPT_ID = idaSLIP_HEADER.OraSelectData.Rows[0][idaSLIP_HEADER.OraSelectData.Columns.IndexOf("DEPT_ID")];
                        idaDOC_APPROVAL_LINE.SetSelectParamValue("W_DEPT_ID", vObject_DEPT_ID);
                        idaDOC_APPROVAL_LINE.Fill();

                        vPageNumber = xlPrinting.LineWrite(idaSLIP_LINE_PRINT, idaDOC_APPROVAL_LINE.OraSelectData);

                        if (pOutChoice == "PRINT")
                        {
                            xlPrinting.Printing(1, vPageNumber); //시작 페이지 번호, 종료 페이지 번호
                        }
                        else if (pOutChoice == "FILE")
                        {
                            xlPrinting.Save("FL_");
                        }
                        //-------------------------------------------------------------------------------------
                    }

                    //-------------------------------------------------------------------------------------
                    xlPrinting.Dispose();
                    //-------------------------------------------------------------------------------------
                }
                catch (System.Exception ex)
                {
                    string vMessage = ex.Message;
                    xlPrinting.Dispose();
                }
                //-------------------------------------------------------------------------------------
            }

            vPageTotal = vPageTotal + vPageNumber;

            //-------------------------------------------------------------------------
            vMessageText = string.Format("Printing End [Total Page : {0}]", vPageTotal);
            isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
            System.Windows.Forms.Application.DoEvents();


            System.Windows.Forms.Application.UseWaitCursor = false;
            this.Cursor = System.Windows.Forms.Cursors.Default;
            System.Windows.Forms.Application.DoEvents();
        }

        #endregion;

        private void ibtLC_ADJUST_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            for (int vLoop = 0; vLoop < isGridAdvEx1.RowCount; vLoop++)
            {
                if (isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("SELECT_FLAG")).ToString() == "Y")
                {
                    isDataTransaction1.BeginTran();

                    idcLC_ADJUST.SetCommandParamValue("P_PERIOD_NAME", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("PERIOD_NAME")));
                    idcLC_ADJUST.SetCommandParamValue("P_DELIVERY_DATE", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("DELIVERY_DATE")));
                    idcLC_ADJUST.SetCommandParamValue("P_SUPPLIER_ID", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("SUPPLIER_ID")));
                    idcLC_ADJUST.SetCommandParamValue("P_LC_NO", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("LC_NO")));
                    idcLC_ADJUST.SetCommandParamValue("P_BL_NO", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("BL_NO")));

                    idcLC_ADJUST.ExecuteNonQuery();

                    string X_RESULT_STATUS = iConvert.ISNull(idcLC_ADJUST.GetCommandParamValue("X_RESULT_STATUS"));
                    string X_RESULT_MSG = iConvert.ISNull(idcLC_ADJUST.GetCommandParamValue("X_RESULT_MSG"));

                    if (idcLC_ADJUST.ExcuteError || (X_RESULT_STATUS != string.Empty && X_RESULT_STATUS == "F"))
                    {
                        isDataTransaction1.RollBack();
                        MessageBoxAdv.Show(X_RESULT_MSG, "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return;
                    }

                    isDataTransaction1.Commit();
                }
            }

            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10010", null), "SUCCESS", MessageBoxButtons.OK, MessageBoxIcon.Information);

            idaADJUST.OraSelectData.AcceptChanges();
            idaADJUST.Refillable = true;

            idaADJUST.Fill();        
        }

        private void ibtLC_CONFIRM_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            for (int vLoop = 0; vLoop < isGridAdvEx1.RowCount; vLoop++)
            {
                if (isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("SELECT_FLAG")).ToString() == "Y")
                {
                    isDataTransaction1.BeginTran();

                    idcTRX_CONFIRM.SetCommandParamValue("P_PERIOD_NAME", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("PERIOD_NAME")));
                    idcTRX_CONFIRM.SetCommandParamValue("P_SUPPLIER_ID", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("SUPPLIER_ID")));
                    idcTRX_CONFIRM.SetCommandParamValue("P_LC_NO", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("LC_NO")));
                    idcTRX_CONFIRM.ExecuteNonQuery();

                    string X_RESULT_STATUS = iConvert.ISNull(idcTRX_CONFIRM.GetCommandParamValue("X_RESULT_STATUS"));
                    string X_RESULT_MSG = iConvert.ISNull(idcTRX_CONFIRM.GetCommandParamValue("X_RESULT_MSG"));

                    if (idcTRX_CONFIRM.ExcuteError || (X_RESULT_STATUS != string.Empty && X_RESULT_STATUS == "F"))
                    {
                        isDataTransaction1.RollBack();
                        MessageBoxAdv.Show(X_RESULT_MSG, "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return;
                    }

                    isDataTransaction1.Commit();
                }
            }

            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10010", null), "SUCCESS", MessageBoxButtons.OK, MessageBoxIcon.Information);

            idaADJUST.OraSelectData.AcceptChanges();
            idaADJUST.Refillable = true;

            idaADJUST.Fill();      
        }

        private void ibtLC_CANCEL_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            for (int vLoop = 0; vLoop < isGridAdvEx1.RowCount; vLoop++)
            {
                if (isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("SELECT_FLAG")).ToString() == "Y")
                {
                    isDataTransaction1.BeginTran();

                    idcTRX_CANCEL.SetCommandParamValue("P_PERIOD_NAME", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("PERIOD_NAME")));
                    idcTRX_CANCEL.SetCommandParamValue("P_SUPPLIER_ID", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("SUPPLIER_ID")));
                    idcTRX_CANCEL.SetCommandParamValue("P_LC_NO", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("LC_NO")));
                    idcTRX_CANCEL.ExecuteNonQuery();

                    string X_RESULT_STATUS = iConvert.ISNull(idcTRX_CANCEL.GetCommandParamValue("X_RESULT_STATUS"));
                    string X_RESULT_MSG = iConvert.ISNull(idcTRX_CANCEL.GetCommandParamValue("X_RESULT_MSG"));

                    if (idcTRX_CANCEL.ExcuteError || (X_RESULT_STATUS != string.Empty && X_RESULT_STATUS == "F"))
                    {
                        isDataTransaction1.RollBack();
                        MessageBoxAdv.Show(X_RESULT_MSG, "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return;
                    }

                    isDataTransaction1.Commit();
                }
            }

            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10010", null), "SUCCESS", MessageBoxButtons.OK, MessageBoxIcon.Information);

            idaADJUST.OraSelectData.AcceptChanges();
            idaADJUST.Refillable = true;

            idaADJUST.Fill();   
        }

        private void ibtSLIP_SEND_C_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            for (int vLoop = 0; vLoop < isGridAdvEx1.RowCount; vLoop++)
            {
                if (isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("SELECT_FLAG")).ToString() == "Y")
                {
                    isDataTransaction1.BeginTran();

                    idcLC_SEND.SetCommandParamValue("P_LC_NO", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("LC_NO")));
                    idcLC_SEND.SetCommandParamValue("P_BL_NO", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("BL_NO")));
                    idcLC_SEND.ExecuteNonQuery();

                    string X_RESULT_STATUS = iConvert.ISNull(idcLC_SEND.GetCommandParamValue("X_RESULT_STATUS"));
                    string X_RESULT_MSG = iConvert.ISNull(idcLC_SEND.GetCommandParamValue("X_RESULT_MSG"));

                    if (idcLC_SEND.ExcuteError || (X_RESULT_STATUS != string.Empty && X_RESULT_STATUS == "F"))
                    {
                        isDataTransaction1.RollBack();
                        MessageBoxAdv.Show(X_RESULT_MSG, "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return;
                    }

                    isDataTransaction1.Commit();
                }
            }

            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10010", null), "SUCCESS", MessageBoxButtons.OK, MessageBoxIcon.Information);

            idaADJUST.OraSelectData.AcceptChanges();
            idaADJUST.Refillable = true;

            idaADJUST.Fill();    
        }
         
        private void ibtSLIP_CANCEL_C_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            for (int vLoop = 0; vLoop < isGridAdvEx1.RowCount; vLoop++)
            {
                if (isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("SELECT_FLAG")).ToString() == "Y")
                {
                    isDataTransaction1.BeginTran();

                    idcLC_CANCEL.SetCommandParamValue("W_SLIP_NUM", isGridAdvEx2.GetCellValue("SLIP_NUM"));
                    idcLC_CANCEL.SetCommandParamValue("W_LC_NO", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("LC_NO")));
                    idcLC_CANCEL.ExecuteNonQuery();

                    string X_RESULT_STATUS = iConvert.ISNull(idcLC_CANCEL.GetCommandParamValue("X_RESULT_STATUS"));
                    string X_RESULT_MSG = iConvert.ISNull(idcLC_CANCEL.GetCommandParamValue("X_RESULT_MSG"));

                    if (idcLC_CANCEL.ExcuteError || (X_RESULT_STATUS != string.Empty && X_RESULT_STATUS == "F"))
                    {
                        isDataTransaction1.RollBack();
                        MessageBoxAdv.Show(X_RESULT_MSG, "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return;
                    }

                    isDataTransaction1.Commit();
                }
            }

            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10010", null), "SUCCESS", MessageBoxButtons.OK, MessageBoxIcon.Information);

            idaADJUST.OraSelectData.AcceptChanges();
            idaADJUST.Refillable = true;

            idaADJUST.Fill(); 
        }

    }
}