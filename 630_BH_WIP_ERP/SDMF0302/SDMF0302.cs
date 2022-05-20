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

namespace SDMF0302
{
    public partial class SDMF0302 : Office2007Form
    {
        ISCommonUtil.ISFunction.ISConvert iConvert = new ISFunction.ISConvert();

        #region ----- Variables -----



        #endregion;

        #region ----- Constructor -----

        public SDMF0302(Form pMainForm, ISAppInterface pAppInterface)
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
                    IDA_ECO_APPR.Fill();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    if (IDA_ECO_APPR.IsFocused == true)
                    {
                        IDA_ECO_APPR.AddOver();
                        DefaultValue();
                    }
                 }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (IDA_ECO_APPR.IsFocused == true)
                    {
                        IDA_ECO_APPR.AddUnder();
                        DefaultValue();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    IDA_ECO_APPR.Update();

                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (IDA_ECO_APPR.IsFocused == true)
                    {
                        IDA_ECO_APPR.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (IDA_ECO_APPR.IsFocused == true)
                    {
                        IDA_ECO_APPR.Delete();
                    }
                }
                //모델필드 활성화 제어
               // Bom_Item_Access();
            }
        }

        #endregion;


        private void SDMF0302_Load(object sender, EventArgs e)
        {
            IDA_ECO_APPR.FillSchema();
            IDA_ECO_ROUTING.FillSchema();
            IDA_ECO_BOM.FillSchema();
            isrNOT_APPR.CheckedState = ISUtil.Enum.CheckedState.Checked;
            DefaultValue();
        }


        #region -- Default Value Setting --
        private void DefaultValue()
        {
            idcLOCAL_DATE.ExecuteNonQuery();
            V_REQ_DATE_FR.EditValue = idcLOCAL_DATE.GetCommandParamValue("X_LOCAL_DATE");
            V_REQ_DATE_TO.EditValue = idcLOCAL_DATE.GetCommandParamValue("X_LOCAL_DATE");

            IDC_LOGIN_PERSON.ExecuteNonQuery();
            V_APPROVER_PERSON_ID.EditValue = IDC_LOGIN_PERSON.GetCommandParamValue("X_PERSON_ID");
            V_APPROVER_PERSON_NAME.EditValue = IDC_LOGIN_PERSON.GetCommandParamValue("X_DISPLAY_NAME");            
        }
        #endregion


        private void ISG_ECO_ROUTING_CurrentCellEditingComplete(object pSender, ISGridAdvExCellEditingEventArgs e)
        {
            if (e.ColIndex == 1)
            {

                if (iConvert.ISNull(ISG_ECO_ROUTING.GetCellValue("ACTION_TYPE_LCODE")).ToString() != string.Empty)
                {
                    if (ISG_ECO_ROUTING.GetCellValue("ACTION_TYPE_LCODE").ToString() == Convert.ToString("ADD"))
                    {
                        Routing_From_Property((int)0);
                        Routing_To_Property((int)1);
                    }
                    if (ISG_ECO_ROUTING.GetCellValue("ACTION_TYPE_LCODE").ToString() == Convert.ToString("MODIFY"))
                    {
                        Routing_From_Property((int)1);
                        Routing_To_Property((int)1);
                    }
                    if (ISG_ECO_ROUTING.GetCellValue("ACTION_TYPE_LCODE").ToString() == Convert.ToString("DELETE"))
                    {
                        Routing_From_Property((int)1);
                        Routing_To_Property((int)0);
                    }
                }
            }
        }
        private void ISG_ECO_BOM_CurrentCellEditingComplete(object pSender, ISGridAdvExCellEditingEventArgs e)
        {
            if (e.ColIndex == 1)
            {
                if (iConvert.ISNull(ISG_ECO_BOM.GetCellValue("ACTION_TYPE_LCODE")).ToString() != string.Empty)
                {
                    if (ISG_ECO_BOM.GetCellValue("ACTION_TYPE_LCODE").ToString() == Convert.ToString("ADD"))
                    {
                        Bom_From_Property((int)0);
                        Bom_To_Property((int)1);
                    }
                    if (ISG_ECO_BOM.GetCellValue("ACTION_TYPE_LCODE").ToString() == Convert.ToString("MODIFY"))
                    {
                        Bom_From_Property((int)1);
                        Bom_To_Property((int)1);
                    }
                    if (ISG_ECO_BOM.GetCellValue("ACTION_TYPE_LCODE").ToString() == Convert.ToString("DELETE"))
                    {
                        Bom_From_Property((int)1);
                        Bom_To_Property((int)0);
                    }
                }
            }
        }
        #region -- Grid Access Property --
        private void Routing_From_Property(int vProperty)
        {
            if (vProperty == (int) 0)
            {
                ISG_ECO_ROUTING.SetCellValue("FROM_OPERATION_SEQ_NO", null);
                ISG_ECO_ROUTING.SetCellValue("FROM_OPERATION_CODE", null);
                ISG_ECO_ROUTING.SetCellValue("FROM_OPERATION_DESC", null);
                ISG_ECO_ROUTING.SetCellValue("FROM_OPERATION_ID", null);
            }
            ISG_ECO_ROUTING.GridAdvExColElement[3].Insertable = vProperty;  //From Operation Code
            ISG_ECO_ROUTING.GridAdvExColElement[3].Updatable = vProperty;
            ISG_ECO_ROUTING.Invalidate();
        }
        private void Routing_To_Property(int vProperty)
        {
            if (vProperty == (int)0)
            {
                ISG_ECO_ROUTING.SetCellValue("TO_OPERATION_SEQ_NO", null);
                ISG_ECO_ROUTING.SetCellValue("TO_OPERATION_CODE", null);
                ISG_ECO_ROUTING.SetCellValue("TO_OPERATION_DESC", null);
                ISG_ECO_ROUTING.SetCellValue("TO_OPERATION_ID", null);
            }
            ISG_ECO_ROUTING.GridAdvExColElement[5].Insertable = vProperty;  //To Operation Seq No
            ISG_ECO_ROUTING.GridAdvExColElement[5].Updatable = vProperty;
            ISG_ECO_ROUTING.GridAdvExColElement[6].Insertable = vProperty;  //To Operation Code
            ISG_ECO_ROUTING.GridAdvExColElement[6].Updatable = vProperty;
            ISG_ECO_ROUTING.Invalidate();
        }
        private void Bom_From_Property(int vProperty)
        {
            if (vProperty == (int)0)
            {
                ISG_ECO_BOM.SetCellValue("FROM_COMPONENT_CATEGORY", null);
                ISG_ECO_BOM.SetCellValue("FROM_COMPONENT_INV_ITEM_CODE", null);
                ISG_ECO_BOM.SetCellValue("FROM_COMPONENT_INV_ITEM_DESC", null);
                ISG_ECO_BOM.SetCellValue("FROM_COMPONENT_INV_ITEM_SPEC", null);
                ISG_ECO_BOM.SetCellValue("FROM_UOM_CODE", null);
                ISG_ECO_BOM.SetCellValue("FROM_REQUIRED_QTY", null);
                ISG_ECO_BOM.SetCellValue("FROM_COMPONENT_INV_ITEM_ID", null);
                ISG_ECO_BOM.SetCellValue("FROM_COMPONENT_BOM_ITEM_ID", null);
                ISG_ECO_BOM.SetCellValue("FROM_BOM_COMPONENT_TYPE", null);
            }
            ISG_ECO_BOM.GridAdvExColElement[5].Insertable = vProperty;  //From Component Category
            ISG_ECO_BOM.GridAdvExColElement[5].Updatable = vProperty;
            ISG_ECO_BOM.GridAdvExColElement[6].Insertable = vProperty;  //From Component Item Code
            ISG_ECO_BOM.GridAdvExColElement[6].Updatable = vProperty;
            ISG_ECO_BOM.GridAdvExColElement[10].Insertable = vProperty; //From Required Qty
            ISG_ECO_BOM.GridAdvExColElement[10].Updatable = vProperty;
            ISG_ECO_BOM.Invalidate();
        }
        private void Bom_To_Property(int vProperty)
        {
            if (vProperty == (int)0)
            {
                ISG_ECO_BOM.SetCellValue("TO_COMPONENT_CATEGORY", null);
                ISG_ECO_BOM.SetCellValue("TO_COMPONENT_INV_ITEM_CODE", null);
                ISG_ECO_BOM.SetCellValue("TO_COMPONENT_INV_ITEM_DESC", null);
                ISG_ECO_BOM.SetCellValue("TO_COMPONENT_INV_ITEM_SPEC", null);
                ISG_ECO_BOM.SetCellValue("TO_UOM_CODE", null);
                ISG_ECO_BOM.SetCellValue("TO_REQUIRED_QTY", null);
                ISG_ECO_BOM.SetCellValue("TO_COMPONENT_INV_ITEM_ID", null);
                ISG_ECO_BOM.SetCellValue("TO_COMPONENT_BOM_ITEM_ID", null);
                ISG_ECO_BOM.SetCellValue("TO_BOM_COMPONENT_TYPE", null);
                ISG_ECO_BOM.SetCellValue("TO_COMPONENT_CATEGORY_CODE", null);
            }
            ISG_ECO_BOM.GridAdvExColElement[11].Insertable = vProperty;  //To Component Category
            ISG_ECO_BOM.GridAdvExColElement[11].Updatable = vProperty;
            ISG_ECO_BOM.GridAdvExColElement[12].Insertable = vProperty;  //To Component Item Code
            ISG_ECO_BOM.GridAdvExColElement[12].Updatable = vProperty;
            ISG_ECO_BOM.GridAdvExColElement[16].Insertable = vProperty;  //To Required Qty
            ISG_ECO_BOM.GridAdvExColElement[16].Updatable = vProperty;
            ISG_ECO_BOM.Invalidate();
        }
        #endregion

        private void isrNOT_APPR_CheckChanged(object sender, EventArgs e)
        {
            if (isrNOT_APPR.RadioButtonString == "N")
            {
                V_RADIO_VALUE.EditValue = isrNOT_APPR.RadioButtonString;
            }
        }

        private void isrEND_APPR_CheckChanged(object sender, EventArgs e)
        {
            if (isrEND_APPR.RadioButtonString == "Y")
            {
                V_RADIO_VALUE.EditValue = isrEND_APPR.RadioButtonString;
            }
        }

        private void isrALL_CheckChanged(object sender, EventArgs e)
        {
            if (isrALL.RadioButtonString == "A")
            {
                V_RADIO_VALUE.EditValue = isrALL.RadioButtonString;
            }
        }

        private void ISG_APPROVAL_CellMoved(object pSender, ISGridAdvExCellClickEventArgs e)
        {
            // 승인완료일시가 있을 경우 승인완료 flag는 수정할 수 없음 //
            if (iConvert.ISNull(ISG_APPROVAL.GetCellValue("APPLY_COMPLETE_DATE")).ToString() != String.Empty)
            {
                ISG_APPROVAL.GridAdvExColElement[4].Updatable = 0;
            }
            else
            {
                ISG_APPROVAL.GridAdvExColElement[4].Updatable = 1;
            }
            ISG_APPROVAL.Invalidate();
        }

        //private void ILA_BOM_ITEM_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        //{
        //    if (ISG_ECO_ROUTING.RowCount != 0 || ISG_ECO_BOM.RowCount != 0)
        //    {
        //        T_BOM_ITEM_CODE.LookupAdapter = null;
        //        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("SDM_10039"), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
        //        return;
        //    }
        //}

        // ECO Entry 라인이 있으면 Bom_Item(모델)은 수정할 수 없도록 설정.
        //private void Bom_Item_Access()
        //{
        //    // Routing 활성 Line Count
        //    int vRoutingCount = 0;
        //    foreach (DataRow row in IDA_ECO_ROUTING.SelectRows) 
        //    {
        //        if (row.RowState != DataRowState.Deleted)
        //        {
        //            vRoutingCount++;
        //        }
        //    }

        //    // Bom 활성 Line Count
        //    int vBomCount = 0;
        //    foreach (DataRow row in IDA_ECO_BOM.SelectRows) 
        //    {
        //        if (row.RowState != DataRowState.Deleted)
        //        {
        //            vBomCount++;
        //        }
        //    }

        //    // 모델 활성화 제어
        //    if (vRoutingCount != 0 || vBomCount != 0)
        //    {
        //        T_BOM_ITEM_CODE.Insertable = false;
        //        T_BOM_ITEM_CODE.Updatable = false;
        //    }
        //    else
        //    {
        //        T_BOM_ITEM_CODE.Insertable = true;
        //        T_BOM_ITEM_CODE.Updatable = true;
        //    }
        //    T_BOM_ITEM_CODE.Invalidate();
        //}

        //private void IDA_ECO_HEADER_ExcuteKeySearch(object pSender)
        //{
        //    IDA_ECO_HEADER.Fill();
        //    Bom_Item_Access();
        //}


        //private void IDA_CSR_PreDelete(ISPreDeleteEventArgs e)
        //{
        //    if (e.Row.RowState != DataRowState.Added)
        //    {
        //        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:=CSR Entry"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
        //        e.Cancel = true;
        //        return;
        //    }
        //}

    }
}