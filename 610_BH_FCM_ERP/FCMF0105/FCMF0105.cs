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

namespace FCMF0105
{
    public partial class FCMF0105 : Office2007Form
    {
        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        public FCMF0105(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();

            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #region ----- Property Method ------
        private void DefaultSetFormReSize()
        {//[Child Form, Mdi Form에 맞게 ReSize]
            int vMinusWidth = 4;
            int vMinusHeight = 54;
            System.Drawing.Size vSize = this.MdiParent.ClientSize;
            this.Width = vSize.Width - vMinusWidth;
            this.Height = vSize.Height - vMinusHeight;
        }

        private void SEARCH_DB()
        {
            idaCREDIT_CARD.Fill();

            igrCREDIT_CARD.CurrentCellMoveTo(igrCREDIT_CARD.GetColumnToIndex("CARD_CODE"));
            igrCREDIT_CARD.Focus();
        }

        private void Insert_Credit_Card()
        {
            igrCREDIT_CARD.SetCellValue("ENABLED_FLAG", "Y");
            igrCREDIT_CARD.SetCellValue("EFFECTIVE_DATE_FR", iDate.ISMonth_1st(DateTime.Today));

            igrCREDIT_CARD.CurrentCellMoveTo(igrCREDIT_CARD.GetColumnToIndex("CARD_CODE"));
            igrCREDIT_CARD.Focus();
        }

        private void isSetCommonParameter(string pGroup_Code, string pEnabled_Flag)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", pEnabled_Flag);
        }

        #endregion

        #region ----- isAppInterfaceAdv1_AppMainButtonClick Button Click -----
        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    SEARCH_DB();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    if (idaCREDIT_CARD.IsFocused)
                    {
                        idaCREDIT_CARD.AddOver();
                        Insert_Credit_Card();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaCREDIT_CARD.IsFocused)
                    {
                        idaCREDIT_CARD.AddUnder();
                        Insert_Credit_Card();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                { 
                        idaCREDIT_CARD.Update();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaCREDIT_CARD.IsFocused)
                    {
                        idaCREDIT_CARD.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaCREDIT_CARD.IsFocused)
                    {
                        idaCREDIT_CARD.Delete();
                    }
                }
            }
        }
        #endregion
        
        #region ----- Form Event -----
        private void FCMF0105_Load(object sender, EventArgs e)
        {
            idaCREDIT_CARD.FillSchema();
        }
        #endregion

        #region ----- Adapter Event -----

        private void idaCREDIT_CARD_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["CARD_NUM"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", "&&FIELD_NAME:=Card Number(카드번호)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);  //코드 입력
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["CARD_NAME"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", "&&FIELD_NAME:=Card Name(카드명)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);  // 코드명 입력
                e.Cancel = true;
                return;
            }            
            if (iString.ISNull(e.Row["CRAD_CORP_ID"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", "&&FIELD_NAME:=Card Corporation(카드사명)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);  // 코드명 입력
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["EXPIRE_DATE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", "&&FIELD_NAME:=Expire Period(유효년월)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);  // 코드명 입력
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["EFFECTIVE_DATE_FR"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning); 
                e.Cancel = true;
                return;
            }
        }

        private void idaCREDIT_CARD_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:=Data(데이터)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
                e.Cancel = true;
                return;
            }
        }
        #endregion

        #region ----- Lookup Code -----
        private void ilaCREDIT_CARD_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCREDIT_CARD.SetLookupParamValue("W_ENABLED_YN", "N");
        }

        private void ilaCARD_CORPORATION_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "CARD_CORPORATION");
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", "N");
        }

        private void ilaCPERSON_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildPERSON.SetLookupParamValue("W_STD_DATE", iDate.ISGetDate());
        }

        private void ilaCARD_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "CARD_TYPE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaCARD_CORPORATION_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "CARD_CORPORATION");
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaPERSON_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildPERSON.SetLookupParamValue("W_STD_DATE", iDate.ISGetDate());
        }

        private void ilaBANK_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildBANK.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaBANK_ACCOUNT_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildBANK_ACCOUNT.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaCURRENCY_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCURRENCY.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaCLOSE_DAY_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "DAY_NUM");
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaSETTLE_DAY_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "DAY_NUM");
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        #endregion
        
    }
}