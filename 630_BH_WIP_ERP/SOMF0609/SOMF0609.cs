using System;
using System.Data;
using System.Drawing;
using System.Windows.Forms;
using System.Collections.Generic;

using Syncfusion.Windows.Forms;
using Syncfusion.Windows.Forms.Tools;
using Syncfusion.Windows.Forms.Grid;
using InfoSummit.Win.ControlAdv;
using ISCommonUtil;

namespace SOMF0609
{
    public partial class SOMF0609 : Office2007Form
    {
        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #region ----- Variables -----



        #endregion;

        #region ----- Constructor -----

        public SOMF0609()
        {
            InitializeComponent();
        }

        public SOMF0609(Form pMainForm, ISAppInterface pAppInterface)
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
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search) // 검색 버튼
                {
                    // 매출일자 란이 비어있을 경우의 장애 처리
                    if (iString.ISNull(PURCHASE_DATE_FR_0.EditValue) == string.Empty)
                    {
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=시작일자"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        PURCHASE_DATE_FR_0.Focus();
                        return;
                    }
                    if (iString.ISNull(PURCHASE_DATE_TO_0.EditValue) == string.Empty)
                    {
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=종료일자"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        PURCHASE_DATE_TO_0.Focus();
                        return;
                    }
                    if (Convert.ToDateTime(PURCHASE_DATE_FR_0.EditValue) > Convert.ToDateTime(PURCHASE_DATE_TO_0.EditValue))
                    {
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10012"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        PURCHASE_DATE_FR_0.Focus();
                        return;
                    }

                    if (itbITEM_SHIPMENT.SelectedTab.TabIndex == 1) //고객순
                    {
                        idaITEM_SUMMARY_CUST.Fill();
                    }
                    else if (itbITEM_SHIPMENT.SelectedTab.TabIndex == 2) //매출일자순
                    {
                        idaITEM_SUMMARY_DATE.Fill();
                    }
                    else if (itbITEM_SHIPMENT.SelectedTab.TabIndex == 3) //상세내역
                    {
                        idaITEM_SUMMARY_DETAIL.Fill();
                    }

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

        private void ilaINVENTORY_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildINVENTORY.SetLookupParamValue("W_ITEM_CATEGORY_CODE", "FG");
        }

        private void SOMF0609_Load(object sender, EventArgs e) //매출일자에 초기값 설정
        {
            PURCHASE_DATE_FR_0.EditValue = iDate.ISMonth_1st(DateTime.Today);
            PURCHASE_DATE_TO_0.EditValue = DateTime.Today;

            idcEXCHANGE_RATE_TYPE.SetCommandParamValue("P_LOOKUP_TYPE", "EXCHANGE_RATE_TYPE");
            idcEXCHANGE_RATE_TYPE.ExecuteNonQuery();
            EXCHANGE_RATE_TYPE_DESC_0.EditValue = idcEXCHANGE_RATE_TYPE.GetCommandParamValue("X_ENTRY_DESCRIPTION");
            EXCHANGE_RATE_TYPE_0.EditValue = idcEXCHANGE_RATE_TYPE.GetCommandParamValue("X_ENTRY_CODE");
        }

    }
}