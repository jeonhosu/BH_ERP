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

namespace HRMF0402
{
    public partial class HRMF0402 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public HRMF0402()
        {
            InitializeComponent();
        }

        public HRMF0402(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----
        
        private void DefaultCorporation()
        {
            // Lookup SETTING
            ildCORP.SetLookupParamValue("W_PAY_CONTROL_YN", "Y");
            ildCORP.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");

            // LOOKUP DEFAULT VALUE SETTING - CORP
            idcDEFAULT_CORP.SetCommandParamValue("W_PAY_CONTROL_YN", "Y");
            idcDEFAULT_CORP.SetCommandParamValue("W_ENABLED_FLAG_YN", "N");
            idcDEFAULT_CORP.ExecuteNonQuery();
            CORP_NAME_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_NAME");
            CORP_ID_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_ID");
        }

        private void Search_DB()
        {
            if (iString.ISNull(CORP_ID_0.EditValue) == string.Empty)
            {// 업체 선택
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            if (iString.ISNull(INSUR_YYYYMM_0.EditValue) == string.Empty)
            {// 조회년월
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10036"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            if (itbINSUR.SelectedTab.TabIndex == 1)
            {
                idaHEALTH_INSUR.Fill();
                igrHEALTH_INSUR.Focus();
            }
            else if (itbINSUR.SelectedTab.TabIndex == 2)
            {
                idaPENSION_INSUR.Fill();
                igrPENSION_INSUR.Focus();
            }
        }

        #endregion;

        #region ----- Events -----

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
                    if (idaHEALTH_INSUR.IsFocused)
                    {
                        idaHEALTH_INSUR.Update();
                    }
                    else if (idaPENSION_INSUR.IsFocused)
                    {
                        idaPENSION_INSUR.Update();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaHEALTH_INSUR.IsFocused)
                    {
                        idaHEALTH_INSUR.Cancel();
                    }
                    else if (idaPENSION_INSUR.IsFocused)
                    {
                        idaPENSION_INSUR.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaHEALTH_INSUR.IsFocused)
                    {
                        idaHEALTH_INSUR.Delete();
                    }
                    else if (idaPENSION_INSUR.IsFocused)
                    {
                        idaPENSION_INSUR.Delete();
                    }
                }
            }
        }

        #endregion;

        #region ----- Form event -----

        private void HRMF0402_Load(object sender, EventArgs e)
        {
            idaHEALTH_INSUR.FillSchema();
            idaPENSION_INSUR.FillSchema();
        }

        private void HRMF0402_Shown(object sender, EventArgs e)
        {
            DefaultCorporation();                  // Corp Default Value Setting.

            INSUR_YYYYMM_0.EditValue = iDate.ISYearMonth(DateTime.Today);
            INSUR_YYYYMM_0.Focus();
        }

        #endregion

        #region ----- Lookup Event -----

        private void ilaDEPT_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT.SetLookupParamValue("W_USABLE_CHECK_YN", "N");
        }


        #endregion

        #region ----- Adapter Event -----


        #endregion
    }
}