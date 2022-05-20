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

namespace FCMF0801
{
    public partial class FCMF0801 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public FCMF0801()
        {
            InitializeComponent();
        }

        public FCMF0801(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;

            //int vCountRow = ((ISGridAdvEx)(pObject)).RowCount;
            //((mdiMMPS52)(this.MdiParent)).StatusSTRIP_Form_Open_iF_Value.Text = "0";
            //(()(this.MdiParent)).

            //System.Type vType = this.MdiParent.GetType();
            //object vO1 = Convert.ChangeType(pMainForm, System.Type.GetType(vType.FullName));
            string vPathReport = string.Empty;
            object vObject = this.MdiParent.Tag;
            if (vObject != null)
            {
                bool isConvert = vObject is string;
                if (isConvert == true)
                {
                    vPathReport = vObject as string;
                }
            }
        }

        #endregion;

        #region ----- Private Methods ----

        private void SEARCH_DB()
        {
            idaVAT_ACCOUNTS.Fill();
            igrVAT_ACCOUNTS.Focus();
        }

        private DateTime GetDate()
        {
            DateTime vDateTime = DateTime.Today;

            try
            {
                idcGetDate.ExecuteNonQuery();
                object vObject = idcGetDate.GetCommandParamValue("X_LOCAL_DATE");

                bool isConvert = vObject is DateTime;
                if (isConvert == true)
                {
                    vDateTime = (DateTime)vObject;
                }
            }
            catch (Exception ex)
            {
                string vMessage = ex.Message;
                vDateTime = new DateTime(9999, 12, 31, 23, 59, 59);
            }
            return vDateTime;
        }

        private void SetCommonParameter(object pGroup_Code, object pCode_Name, object pENABLED_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
            ildCOMMON.SetLookupParamValue("W_CODE_NAME", pCode_Name);
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pENABLED_YN);
        }

        private void INIT_INSERT_DATA()
        {
            igrVAT_ACCOUNTS.SetCellValue("ENABLED_FLAG", "Y");
            igrVAT_ACCOUNTS.CurrentCellMoveTo(igrVAT_ACCOUNTS.GetColumnToIndex("ACCOUNT_CODE"));
            igrVAT_ACCOUNTS.CurrentCellActivate(igrVAT_ACCOUNTS.GetColumnToIndex("ACCOUNT_CODE"));
        }

        #endregion;

        #region ----- XL Export Methods ----

        private void ExportXL()
        {
            int vCountRow = idaVAT_ACCOUNTS.OraSelectData.Rows.Count;
            if (vCountRow < 1)
            {
                return;
            }

            string vsMessage = string.Empty;
            string vsSheetName = "Slip_Line";

            saveFileDialog1.Title = "Excel_Save";
            saveFileDialog1.FileName = "XL_00";
            saveFileDialog1.DefaultExt = "xls";
            System.IO.DirectoryInfo vSaveFolder = new System.IO.DirectoryInfo(System.Environment.GetFolderPath(Environment.SpecialFolder.Desktop));
            saveFileDialog1.InitialDirectory = vSaveFolder.FullName;
            saveFileDialog1.Filter = "Excel Files (*.xls)|*.xls";
            if (saveFileDialog1.ShowDialog() == System.Windows.Forms.DialogResult.OK)
            {
                string vsSaveExcelFileName = saveFileDialog1.FileName;
                XL.XLPrint xlExport = new XL.XLPrint();
                bool vXLSaveOK = xlExport.XLExport(idaVAT_ACCOUNTS.OraSelectData, vsSaveExcelFileName, vsSheetName);
                if (vXLSaveOK == true)
                {
                    vsMessage = string.Format("Save OK [{0}]", vsSaveExcelFileName);
                    MessageBoxAdv.Show(vsMessage);
                }
                else
                {
                    vsMessage = string.Format("Save Err [{0}]", vsSaveExcelFileName);
                    MessageBoxAdv.Show(vsMessage);
                }
                xlExport.XLClose();
            }
        }

        #endregion;

        #region ----- Territory Get Methods ----

        private int GetTerritory(ISUtil.Enum.TerritoryLanguage pTerritoryEnum)
        {
            int vTerritory = -1;

            switch (pTerritoryEnum)
            {
                case ISUtil.Enum.TerritoryLanguage.Default:
                    vTerritory = 0;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL1_KR:
                    vTerritory = 1;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL2_CN:
                    vTerritory = 2;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL3_VN:
                    vTerritory = 3;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL4_JP:
                    vTerritory = 4;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL5_XAA:
                    vTerritory = 5;
                    break;
            }

            return vTerritory;
        }

        #endregion;

        #region ----- XL Print 1 Methods ----
                
        #endregion;

        #region ----- Events -----

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
                    if (idaVAT_ACCOUNTS.IsFocused)
                    {
                        idaVAT_ACCOUNTS.AddOver();
                        INIT_INSERT_DATA();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaVAT_ACCOUNTS.IsFocused)
                    {
                        idaVAT_ACCOUNTS.AddUnder();
                        INIT_INSERT_DATA();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (idaVAT_ACCOUNTS.IsFocused)
                    {
                        idaVAT_ACCOUNTS.Update();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaVAT_ACCOUNTS.IsFocused)
                    {
                        idaVAT_ACCOUNTS.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaVAT_ACCOUNTS.IsFocused)
                    {
                        idaVAT_ACCOUNTS.Delete();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                }
            }
        }
                
        #endregion;

        #region ----- Form Event -----

        private void FCMF0801_Load(object sender, EventArgs e)
        {
            idaVAT_ACCOUNTS.FillSchema();
        }

        private void FCMF0801_Shown(object sender, EventArgs e)
        {
            cbENABLED_FLAG_0.CheckBoxValue = "Y";
        }

        #endregion

        #region ----- Lookup Event -----

        private void ilaACCOUNT_CONTROL_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildACCOUNT_CONTROL.SetLookupParamValue("W_ACCOUNT_CODE_FR", DBNull.Value);
            ildACCOUNT_CONTROL.SetLookupParamValue("W_ENABLED_YN", "N");
        }

        private void ilaACCOUNT_CONTROL_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildACCOUNT_CONTROL.SetLookupParamValue("W_ACCOUNT_CODE_FR", DBNull.Value);
            ildACCOUNT_CONTROL.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaVAT_GUBUN_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("VAT_GUBUN", null, "Y");
        }

        private void ilaVAT_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("VAT_TYPE", null, "Y");
        }

        private void ilaVAT_ASSET_GB_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("VAT_ASSET_GB", null, "Y");
        }

        private void ilaVAT_DOC_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("VAT_DOC_TYPE", null, "Y");
        }

        #endregion

        #region ----- Adapter Event ------

        private void idaVAT_ACCOUNTS_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["ACCOUNT_CONTROL_ID"]) == string.Empty)
            {// ��������.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10123"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["ACCOUNT_CODE"]) == string.Empty)
            {// ��������
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10123"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaVAT_ACCOUNTS_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:=Data(������)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // ��� �ڵ� �Է�
                e.Cancel = true;
                return;
            }
        }

        #endregion
    }
}