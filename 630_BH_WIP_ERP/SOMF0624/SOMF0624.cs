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

namespace SOMF0624
{
    public partial class SOMF0624 : Office2007Form
    {
        ISCommonUtil.ISFunction.ISConvert iConvert = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #region ----- Variables -----



        #endregion;

        #region ----- Constructor -----

        public SOMF0624(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;
        
        #region ----- Private Methods ----

        private void idaHEADER_ExcuteQuery()
        {
            idaRECEIPT.Fill();
        }

        private void Header_Setting()
        {
            C_RECEIPT_DATE_FR.EditValue           = iDate.ISMonth_1st(DateTime.Today);
            C_RECEIPT_DATE_TO.EditValue           = DateTime.Today;
            C_TRX_TYPE_CODE.EditValue             = "GOODS_NOCHARGE_RECEIPT";
            C_TRX_TYPE_NAME.EditValue             = "제품 무상 입고";
            C_EXCHANGE_RATE_TYPE.EditValue        = "PLAN";
            C_EXCHANGE_RATE_TYPE_DESC.EditValue   = "계획환율(고정)";
            C_RECEIPT_DATE_FR.Focus();
           // idcFG_WIP.ExecuteNonQuery();
            idcEXCHANGE_RATE_TYPE.ExecuteNonQuery();
        }

        private void If(bool p)
        {
            throw new Exception("The method or operation is not implemented.");
        }         


        #endregion;

        #region ----- Events -----

        private void SOMF0624_Load(object sender, EventArgs e)
        {
            Header_Setting();
            idaRECEIPT.FillSchema();
           // idaLINE.FillSchema();
        }

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    idaRECEIPT.Fill();
                }
            }
        }

        #endregion;   



    }
}