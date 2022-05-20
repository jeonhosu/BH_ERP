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

namespace INVF0002
{
    public partial class INVF0002 : Office2007Form
    {

        #region ----- Variables -----



        #endregion;

        #region ----- Constructor -----

        public INVF0002(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void INVF0002_Load(object sender, EventArgs e)
        {
            idaINV_ITEM.FillSchema();
            Form_DefaultValue();
            Division_DefaultValue();
        }

        #endregion;

        #region ----- Events -----

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    INV_ITEM_INQUIRY();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                        idaINV_ITEM.AddOver();
                        Form_DefaultValue();
                        Division_DefaultValue();
                    
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    
                        idaINV_ITEM.AddUnder();
                        Form_DefaultValue();
                        Division_DefaultValue();
                    
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (idaINV_ITEM.Refillable == false)
                    {
                        idaINV_ITEM.Update();
                    }

                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    
                        idaINV_ITEM.Cancel();
                    
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    
                        //idaINV_ITEM.Delete();
                    
                }
            }
        }

        #endregion;

        #region -- Data Find --
        private void INV_ITEM_INQUIRY()
        {
            idaINV_ITEM.Fill();
            ITEM_CODE.Focus();
        }

        #endregion


        #region -- Default Value Setting --
        private void Form_DefaultValue()
        {
            idcDEFAULT_FORM.ExecuteNonQuery();
            EFFECTIVE_DATE_FR.EditValue = idcDEFAULT_FORM.GetCommandParamValue("X_LOCAL_DATE");
            ENABLED_FLAG.CheckBoxValue = "Y";
            INV_AGING_FLAG.CheckBoxValue = idcDEFAULT_FORM.GetCommandParamValue("X_MATERIAL_AGING_FLAG").ToString();
            INV_AGING_DAYS.EditValue = idcDEFAULT_FORM.GetCommandParamValue("X_MATERIAL_AGING_DAYS");
        }

        private void Division_DefaultValue()
        {
            ITEM_DIVISION_CODE.EditValue = "MATERIAL";
            idcDEFAULT_DIVISION.ExecuteNonQuery();
            ITEM_DIVISION_DESC.EditValue = idcDEFAULT_DIVISION.GetCommandParamValue("X_ITEM_DIVISION_DESC").ToString();
        }

        #endregion


        private void ITEM_CODE_CurrentEditValidating(object pSender, ISEditAdvValidatingEventArgs e)
        {
            if (idaINV_ITEM.CurrentRow != null && idaINV_ITEM.CurrentRow.RowState == DataRowState.Added)
            {
                string V_Check_Result = null;

                idcITEM_CODE.ExecuteNonQuery();
                V_Check_Result = idcITEM_CODE.GetCommandParamValue("X_CHECK_RESULT").ToString();


                if (V_Check_Result == 'N'.ToString())
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90003", "&&FIELD_NAME:=ITEM CODE"), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    e.Cancel = true;
                }
            }
        }

        //private void ilaITEM_CATEGORY_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        //{
        //    ildITEM_CATEGORY.SetLookupParamValue("W_FG_MAT_FLAG", Convert.ToString("FG"));
        //}

        //private void ilaITEM_SECTION_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        //{
        //    ildITEM_SECTION.SetLookupParamValue("W_FG_MAT_FLAG", Convert.ToString("FG"));
        //}

        //private void ilaITEM_CATEGORY_V_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        //{
        //    ildITEM_CATEGORY_V.SetLookupParamValue("W_FG_MAT_FLAG", Convert.ToString("FG"));
        //}

        private void ilaWAREHOUSE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildWAREHOUSE.SetLookupParamValue("W_FG_MAT_FLAG", Convert.ToString("MAT"));
        }


        private void idaINV_ITEM_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (string.IsNullOrEmpty(ITEM_CATEGORY_DESC.EditValue.ToString()) | string.IsNullOrEmpty(ITEM_CATEGORY_CODE.EditValue.ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", "&&FIELD_NAME:=ITEM_CATEGORY(품목유형)"), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                e.Cancel = true;
                return;
            }
            if (string.IsNullOrEmpty(ITEM_SECTION_DESC.EditValue.ToString()) | string.IsNullOrEmpty(ITEM_SECTION_CODE.EditValue.ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", "&&FIELD_NAME:=ITEM_SECTION(품목구분)"), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                e.Cancel = true;
                return;
            }
            if (string.IsNullOrEmpty(MAT_MAKER_CODE.EditValue.ToString()) | MAT_MAKER_ID.EditValue == null)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", "&&FIELD_NAME:=MAKER(제조처)"), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                e.Cancel = true;
                return;
            }
        }

        private void idaINV_ITEM_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:=Material Item"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
                e.Cancel = true;
                return;
            }
        }






        
    }
}