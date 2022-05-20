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

namespace HRMF0215
{
    public partial class HRMF0215 : Office2007Form
    {
        #region ----- Variables -----

        private ISFunction.ISDateTime ISDate = new ISFunction.ISDateTime();
        private ISFunction.ISConvert iString = new ISFunction.ISConvert();

        #endregion;

        #region ----- Constructor -----

        public HRMF0215(Form pMainForm, ISAppInterface pAppInterface)
        {
            this.Visible = false;
            this.DoubleBuffered = true;

            InitializeComponent();

            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Property Method ----

        private void DefaultCorporation()
        {
            // Lookup SETTING
            ildCORP_0.SetLookupParamValue("W_DEPT_CONTROL_YN", "Y");
            ildCORP_0.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");

            // LOOKUP DEFAULT VALUE SETTING - CORP
            idcDEFAULT_CORP_0.SetCommandParamValue("W_DEPT_CONTROL_YN", "Y");
            idcDEFAULT_CORP_0.SetCommandParamValue("W_ENABLED_FLAG_YN", "N");
            idcDEFAULT_CORP_0.ExecuteNonQuery();

            CORP_NAME_0.EditValue = idcDEFAULT_CORP_0.GetCommandParamValue("O_CORP_NAME");
            CORP_ID_0.EditValue = idcDEFAULT_CORP_0.GetCommandParamValue("O_CORP_ID");

            CORP_NAME_2.EditValue = idcDEFAULT_CORP_0.GetCommandParamValue("O_CORP_NAME");
            CORP_ID_2.EditValue = idcDEFAULT_CORP_0.GetCommandParamValue("O_CORP_ID");
        }

        private void DefaultEmploye()
        {
            //idcDEFAULT_EMPLOYE_TYPE_1.SetCommandParamValue("W_GROUP_CODE", "EMPLOYE_TYPE");
            //idcDEFAULT_EMPLOYE_TYPE_1.ExecuteNonQuery();
            //STD_DATE_0.EditValue = idcDEFAULT_EMPLOYE_TYPE_1.GetCommandParamValue("O_CODE_NAME");
            //EMPLOYE_TYPE_0.EditValue = idcDEFAULT_EMPLOYE_TYPE_1.GetCommandParamValue("O_CODE");
        }

        private void DefaultDateTime()
        {
            STD_DATE_0.EditValue = DateTime.Today;

            DATE_START_2.EditValue = ISDate.ISMonth_1st(System.DateTime.Today);
            DATE_END_2.EditValue = ISDate.ISMonth_Last(System.DateTime.Today);
        }

        private void SetCommonParameter(object pGroup_Code, object pEnabled_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);            
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        }

        private void SearchDB_1()
        {
            //if (CORP_ID_0.EditValue == null)
            //{// 업체 선택
            //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    return;
            //}
            IDA_PERSON_SPREAD.Fill();
            IGR_PERSON_SPREAD.Focus();
        }

        private void SearchDB_2()
        {
            IDA_PERSON_SPREAD_PERIOD.Fill();
            IGR__PERSON_SPREAD_PERIOD.Focus();
        }

        #endregion

        #region ----- MDi ToolBar Button Evetn -----

        public void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    
                    int vIndexTab = isTAB.SelectedIndex;

                    if (vIndexTab == 0)
                    {
                        SearchDB_1();
                    }
                    else if (vIndexTab == 1)
                    {
                        SearchDB_2();
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
                    int vIndexTab = isTAB.SelectedIndex;

                    if (vIndexTab == 0)
                    {
                        if (IDA_PERSON_SPREAD.IsFocused)
                        {
                            IDA_PERSON_SPREAD.Cancel();
                        }
                    }
                    else if (vIndexTab == 1)
                    {
                        if (IDA_PERSON_SPREAD_PERIOD.IsFocused)
                        {
                            IDA_PERSON_SPREAD_PERIOD.Cancel();
                        }
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {

                }
            }
        }
        #endregion

        #region ----- Form Event -----

        private void HRMF0215_Load(object sender, EventArgs e)
        {
                      
        }

        private void HRMF0215_Shown(object sender, EventArgs e)
        {
            //DefaultCorporation();
            //DefaultEmploye();
            DefaultDateTime();
        }
        
        #endregion

        #region ----- Lookup Event -----

        private void ilaEMPLOYE_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("EMPLOYE_TYPE", "Y");
        }

        private void ilaDEPT_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT_0.SetLookupParamValue("W_USABLE_CHECK_YN", "Y");
        }

        private void ilaFLOOR_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildFLOOR_0.SetLookupParamValue("W_GROUP_CODE", "FLOOR");
            ildFLOOR_0.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        private void ilaDEPT_2_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT_2.SetLookupParamValue("W_USABLE_CHECK_YN", "Y");
        }

        private void ilaFLOOR_2_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildFLOOR_2.SetLookupParamValue("W_GROUP_CODE", "FLOOR");
            ildFLOOR_2.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        #endregion

        #region ----- KeyDown Event -----

        private void PERSON_NAME_0_KeyDown(object pSender, KeyEventArgs e)
        {
            if (e.KeyCode == System.Windows.Forms.Keys.Enter)
            {
                SearchDB_1();
            }
        }

        private void PERSON_NAME_2_KeyDown(object pSender, KeyEventArgs e)
        {
            if (e.KeyCode == System.Windows.Forms.Keys.Enter)
            {
                SearchDB_2();
            }
        }

        private void DATE_START_2_EditValueChanged(object pSender)
        {
            DATE_END_2.EditValue = ISDate.ISMonth_Last(DATE_START_2.DateTimeValue);
        }

        #endregion
    }
}