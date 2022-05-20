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


namespace HRMF0231
{
    public partial class HRMF0231 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();
        ISFunction.ISConvert iConv = new ISFunction.ISConvert();

        #endregion;

        #region ----- Constructor -----
        public HRMF0231(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }
        #endregion;

        #region -----isAppInterfaceAdv1_AppMainButtonClick Events -----
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
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {
                    DateTime dPrint_Date = DateTime.Today;
                    string sPrint_num = null;

                    isOnPrinting(dPrint_Date, sPrint_num, "PRINT");
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                    DateTime dPrint_Date = DateTime.Today;
                    string sPrint_num = null;

                    isOnPrinting(dPrint_Date, sPrint_num, "FILE");
                }
            }
        }

        private void ISPrinted(string pFormID)
        {
            SEARCH_DB();
        }

        #endregion;

        #region ----- Form Event -----

        private void HRMF0231_Load(object sender, EventArgs e)
        {
            iedSTD_DATE_0.EditValue = DateTime.Today;

            DefaultCorporation();
            //DefaultSetFormReSize();		//[Child Form, Mdi Form에 맞게 ReSize]
        }

        //[2012-01-17]주석
        //private void igrCERTIFICATE_CellDoubleClick(object pSender)
        //{
        //    if (igrCERTIFICATE.RowIndex > -1)
        //    {
        //        DateTime dPrint_Date = iDate.ISGetDate(igrCERTIFICATE.GetCellValue("PRINT_DATE"));
        //        string sPrint_num = iConv.ISNull(igrCERTIFICATE.GetCellValue("PRINT_NUM")); ;

        //        isOnPrinting(dPrint_Date, sPrint_num);
        //    }
        //}

        #endregion

        #region ----- Lookup Event -----

        private void ilaCERT_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON_W.SetLookupParamValue("W_GROUP_CODE", "CERT_TYPE");
            ildCOMMON_W.SetLookupParamValue("W_WHERE", "HC.VALUE1 = 10 ");
            ildCOMMON_W.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        //[2012-01-17]주석
        //private void igrCERTIFICATE_DoubleClick(object sender, EventArgs e)
        //{
        //    DateTime dPrint_Date = DateTime.Today;
        //    string sPrint_num = null;

        //    if (igrCERTIFICATE.RowCount > 0)
        //    {
        //        dPrint_Date = Convert.ToDateTime(igrCERTIFICATE.GetCellValue("PRINT_DATE"));
        //        sPrint_num = igrCERTIFICATE.GetCellValue("PRINT_NUM").ToString();

        //    }
        //    isOnPrinting(dPrint_Date, sPrint_num);
        //}

        #endregion

        #region ----- Private Methods -----

        private void DefaultSetFormReSize()
        {//[Child Form, Mdi Form에 맞게 ReSize]
            int vMinusWidth = 4;
            int vMinusHeight = 54;
            System.Drawing.Size vSize = this.MdiParent.ClientSize;
            this.Width = vSize.Width - vMinusWidth;
            this.Height = vSize.Height - vMinusHeight;
        }

        private void DefaultCorporation()
        {
            // Lookup SETTING
            ildCORP.SetLookupParamValue("W_DUTY_CONTROL_YN", "Y");
            ildCORP.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");

            // LOOKUP DEFAULT VALUE SETTING - CORP
            idcDEFAULT_CORP.SetCommandParamValue("W_DUTY_CONTROL_YN", "Y");
            idcDEFAULT_CORP.SetCommandParamValue("W_ENABLED_FLAG_YN", "N");
            idcDEFAULT_CORP.ExecuteNonQuery();
            CORP_NAME_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_NAME");
            CORP_ID_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_ID");
        }

        private void SEARCH_DB()
        {
            idaCERTIFICATE.SetSelectParamValue("W_SOB_ID", isAppInterfaceAdv1.SOB_ID);
            idaCERTIFICATE.SetSelectParamValue("W_ORG_ID", isAppInterfaceAdv1.ORG_ID);
            idaCERTIFICATE.Fill();
        }

        #endregion;

        #region ----- is OnPrinting Method -----

        private void isOnPrinting(DateTime pPrint_Date, string pPrint_num, string pOutChoice)
        {
            if (CORP_ID_0.EditValue == null)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME_0.Focus();
                return;
            }

            if (iedSTD_DATE_0.EditValue == null)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10015"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                iedSTD_DATE_0.Focus();
                return;
            }

            ISHR.isCertificatePrint vCertificatePrint = new ISHR.isCertificatePrint();
            vCertificatePrint.FormID = this.Name;
            vCertificatePrint.Corp_ID = Convert.ToInt32(CORP_ID_0.EditValue);
            vCertificatePrint.Print_Num = pPrint_num;
            vCertificatePrint.Print_Date = pPrint_Date;
            if (pPrint_num != null)
            {
                vCertificatePrint.Cert_Type_Name = igrCERTIFICATE.GetCellValue("CERT_TYPE_NAME").ToString();
                vCertificatePrint.Cert_Type_ID = Convert.ToInt32(igrCERTIFICATE.GetCellValue("CERT_TYPE_ID"));
                vCertificatePrint.Name = igrCERTIFICATE.GetCellValue("NAME").ToString();
                vCertificatePrint.Person_ID = Convert.ToInt32(igrCERTIFICATE.GetCellValue("PERSON_ID"));
                vCertificatePrint.Join_Date = iDate.ISGetDate(igrCERTIFICATE.GetCellValue("JOIN_DATE"));
                vCertificatePrint.Retire_Date = iDate.ISGetDate(igrCERTIFICATE.GetCellValue("RETIRE_DATE"));
                vCertificatePrint.Description = igrCERTIFICATE.GetCellValue("DESCRIPTION").ToString();
                vCertificatePrint.Send_Org = igrCERTIFICATE.GetCellValue("SEND_ORG").ToString();
                vCertificatePrint.Print_Count = Convert.ToInt32(igrCERTIFICATE.GetCellValue("PRINT_COUNT"));
            }

            vCertificatePrint.ISPrinted += ISPrinted;
            ISAppInterface vAppInterface = new ISAppInterface();
            vAppInterface = isAppInterfaceAdv1.AppInterface;
            Form vHRMF0231_PRINT = new HRMF0231_PRINT(this.MdiParent, vCertificatePrint, vAppInterface, pOutChoice);
            vCertificatePrint.isPrintingEvent(this.Name);
            vHRMF0231_PRINT.Show();
        }

        #endregion;
    }
}